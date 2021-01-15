#include <stdbool.h>
#include "vxi11.h"

char * respbuffer;
char waveform[4194304];

//DEVICE_CORE functions
bool_t create_link_1_svc(Create_LinkParms * params, Create_LinkResp * resp, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  resp->error = 0;
  resp->lid = 0xBEEF;
  resp->maxRecvSize = 1024;
  resp->abortPort = rqstp->rq_xprt->xp_port;
  //fprintf(stderr, "abortPort %d\n\r", resp->abortPort);
  return true;
}

bool_t device_write_1_svc(Device_WriteParms * params, Device_WriteResp * resp, struct svc_req * rqstp)
{
  resp->error = 0;
  resp->size = params->data.data_len;
  //if you get a t, that's a trigger, update buffer
  if (*params->data.data_val == 't')
    {
      unsigned i;
      for (i=0;i<sizeof(waveform);i++)
	{
	  waveform[i] = rand();
	}
    }
  //fprintf(stderr, "Hit %s, got first char %c\n\r", __FUNCTION__, *params->data.data_val);
  return true;
}

bool_t device_read_1_svc(Device_ReadParms * params, Device_ReadResp * resp, struct svc_req * rqstp)
{
  resp->error = 0;
  //respbuffer = (char *)malloc(sizeof(waveform));
  //memcpy(respbuffer, waveform, sizeof(waveform));
  resp->data.data_val = waveform;
  resp->data.data_len = sizeof(waveform);
  resp->reason = 4;
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

bool_t device_readstb_1_svc(Device_GenericParms * params, Device_ReadStbResp * resp, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

bool_t device_trigger_1_svc(Device_GenericParms * params, Device_Error * err, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

bool_t device_clear_1_svc(Device_GenericParms * params, Device_Error * err, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

bool_t device_remote_1_svc(Device_GenericParms * params, Device_Error * err, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

bool_t device_local_1_svc(Device_GenericParms * params, Device_Error * err, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

bool_t device_lock_1_svc(Device_LockParms * params, Device_Error * err, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

bool_t device_unlock_1_svc(Device_Link * link, Device_Error * err, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

bool_t device_enable_srq_1_svc(Device_EnableSrqParms * params, Device_Error * err, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

bool_t device_docmd_1_svc(Device_DocmdParms * params, Device_DocmdResp * resp, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

bool_t destroy_link_1_svc(Device_Link * link, Device_Error * err, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

bool_t create_intr_chan_1_svc(Device_RemoteFunc * func, Device_Error * err, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

bool_t destroy_intr_chan_1_svc(void * ptr, Device_Error * err, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

int device_core_1_freeresult (SVCXPRT * prt, xdrproc_t proc, caddr_t addr)
{
  if (respbuffer != NULL)
    {
      free(respbuffer);
      respbuffer = NULL;
    }
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

//DEVICE_ASYNC functions
bool_t device_abort_1_svc(Device_Link * link, Device_Error * err, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

int device_async_1_freeresult (SVCXPRT * ptr, xdrproc_t proc, caddr_t addr)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

//DEVICE_INTR functions
bool_t device_intr_srq_1_svc(Device_SrqParms * params, void * ptr, struct svc_req * rqstp)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}

int device_intr_1_freeresult (SVCXPRT * ptr, xdrproc_t proc, caddr_t addr)
{
  //fprintf(stderr, "Hit %s\n\r", __FUNCTION__);
  return true;
}
