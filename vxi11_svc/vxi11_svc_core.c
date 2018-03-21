#include "vxi11.h"

char * respbuffer;

//DEVICE_CORE functions
bool_t create_link_1_svc(Create_LinkParms * params, Create_LinkResp * resp, struct svc_req * rqstp)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  resp->error = 0;
  resp->lid = 0xBEEF;
  resp->maxRecvSize = 1024;
  resp->abortPort = rqstp->rq_xprt->xp_port;
  fprintf(stderr, "abortPort %d\n\r", resp->abortPort);
}

bool_t device_write_1_svc(Device_WriteParms * params, Device_WriteResp * resp, struct svc_req * rqstp)
{
  resp->error = 0;
  resp->size = params->data.data_len;
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

bool_t device_read_1_svc(Device_ReadParms * params, Device_ReadResp * resp, struct svc_req * rqstp)
{
  resp->error = 0;
  const char respdata[] = "MYTE";
  respbuffer = (char *)malloc(4);
  memcpy(respbuffer, respdata, 4);
  resp->data.data_val = respbuffer;
  resp->data.data_len = 4;
  resp->reason = 4;
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

bool_t device_readstb_1_svc(Device_GenericParms *, Device_ReadStbResp *, struct svc_req *)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

bool_t device_trigger_1_svc(Device_GenericParms *, Device_Error *, struct svc_req *)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

bool_t device_clear_1_svc(Device_GenericParms *, Device_Error *, struct svc_req *)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

bool_t device_remote_1_svc(Device_GenericParms *, Device_Error *, struct svc_req *)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

bool_t device_local_1_svc(Device_GenericParms *, Device_Error *, struct svc_req *)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

bool_t device_lock_1_svc(Device_LockParms *, Device_Error *, struct svc_req *)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

bool_t device_unlock_1_svc(Device_Link *, Device_Error *, struct svc_req *)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

bool_t device_enable_srq_1_svc(Device_EnableSrqParms *, Device_Error *, struct svc_req *)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

bool_t device_docmd_1_svc(Device_DocmdParms *, Device_DocmdResp *, struct svc_req *)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

bool_t destroy_link_1_svc(Device_Link *, Device_Error *, struct svc_req *)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

bool_t create_intr_chan_1_svc(Device_RemoteFunc *, Device_Error *, struct svc_req *)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

bool_t destroy_intr_chan_1_svc(void *, Device_Error *, struct svc_req *)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

int device_core_1_freeresult (SVCXPRT *, xdrproc_t, caddr_t)
{
  if (respbuffer != NULL)
    {
      free(respbuffer);
      respbuffer = NULL;
    }
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

//DEVICE_ASYNC functions
bool_t device_abort_1_svc(Device_Link *, Device_Error *, struct svc_req *)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

int device_async_1_freeresult (SVCXPRT *, xdrproc_t, caddr_t)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

//DEVICE_INTR functions
bool_t device_intr_srq_1_svc(Device_SrqParms *, void *, struct svc_req *)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}

int device_intr_1_freeresult (SVCXPRT *, xdrproc_t, caddr_t)
{
  fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
}
