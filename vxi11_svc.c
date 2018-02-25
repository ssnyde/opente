/*
 * Please do not edit this file.
 * It was generated using rpcgen.
 */

#include "vxi11.h"
#include <stdio.h>
#include <stdlib.h>
#include <rpc/pmap_clnt.h>
#include <string.h>
#include <memory.h>
#include <sys/socket.h>
#include <netinet/in.h>

#ifndef SIG_PF
#define SIG_PF void(*)(int)
#endif

static void
device_async_1(struct svc_req *rqstp, register SVCXPRT *transp)
{
  fprintf(stderr, "%s", "Hit device_async_1\n\r");
	union {
		Device_Link device_abort_1_arg;
	} argument;
	union {
		Device_Error device_abort_1_res;
	} result;
	bool_t retval;
	xdrproc_t _xdr_argument, _xdr_result;
	bool_t (*local)(char *, void *, struct svc_req *);

	switch (rqstp->rq_proc) {
	case NULLPROC:
		(void) svc_sendreply (transp, (xdrproc_t) xdr_void, (char *)NULL);
		return;

	case device_abort:
		_xdr_argument = (xdrproc_t) xdr_Device_Link;
		_xdr_result = (xdrproc_t) xdr_Device_Error;
		local = (bool_t (*) (char *, void *,  struct svc_req *))device_abort_1_svc;
		break;

	default:
		svcerr_noproc (transp);
		return;
	}
	memset ((char *)&argument, 0, sizeof (argument));
	if (!svc_getargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		svcerr_decode (transp);
		return;
	}
	retval = (bool_t) (*local)((char *)&argument, (void *)&result, rqstp);
	if (retval > 0 && !svc_sendreply(transp, (xdrproc_t) _xdr_result, (char *)&result)) {
		svcerr_systemerr (transp);
	}
	if (!svc_freeargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		fprintf (stderr, "%s", "unable to free arguments");
		exit (1);
	}
	if (!device_async_1_freeresult (transp, _xdr_result, (caddr_t) &result))
		fprintf (stderr, "%s", "unable to free results");

	return;
}

static void
device_core_1(struct svc_req *rqstp, register SVCXPRT *transp)
{
  fprintf(stderr, "%s", "Hit device_core_1\n\r");
	union {
		Create_LinkParms create_link_1_arg;
		Device_WriteParms device_write_1_arg;
		Device_ReadParms device_read_1_arg;
		Device_GenericParms device_readstb_1_arg;
		Device_GenericParms device_trigger_1_arg;
		Device_GenericParms device_clear_1_arg;
		Device_GenericParms device_remote_1_arg;
		Device_GenericParms device_local_1_arg;
		Device_LockParms device_lock_1_arg;
		Device_Link device_unlock_1_arg;
		Device_EnableSrqParms device_enable_srq_1_arg;
		Device_DocmdParms device_docmd_1_arg;
		Device_Link destroy_link_1_arg;
		Device_RemoteFunc create_intr_chan_1_arg;
	} argument;
	union {
		Create_LinkResp create_link_1_res;
		Device_WriteResp device_write_1_res;
		Device_ReadResp device_read_1_res;
		Device_ReadStbResp device_readstb_1_res;
		Device_Error device_trigger_1_res;
		Device_Error device_clear_1_res;
		Device_Error device_remote_1_res;
		Device_Error device_local_1_res;
		Device_Error device_lock_1_res;
		Device_Error device_unlock_1_res;
		Device_Error device_enable_srq_1_res;
		Device_DocmdResp device_docmd_1_res;
		Device_Error destroy_link_1_res;
		Device_Error create_intr_chan_1_res;
		Device_Error destroy_intr_chan_1_res;
	} result;
	bool_t retval;
	xdrproc_t _xdr_argument, _xdr_result;
	bool_t (*local)(char *, void *, struct svc_req *);

	switch (rqstp->rq_proc) {
	case NULLPROC:
		(void) svc_sendreply (transp, (xdrproc_t) xdr_void, (char *)NULL);
		return;

	case create_link:
		_xdr_argument = (xdrproc_t) xdr_Create_LinkParms;
		_xdr_result = (xdrproc_t) xdr_Create_LinkResp;
		local = (bool_t (*) (char *, void *,  struct svc_req *))create_link_1_svc;
		break;

	case device_write:
		_xdr_argument = (xdrproc_t) xdr_Device_WriteParms;
		_xdr_result = (xdrproc_t) xdr_Device_WriteResp;
		local = (bool_t (*) (char *, void *,  struct svc_req *))device_write_1_svc;
		break;

	case device_read:
		_xdr_argument = (xdrproc_t) xdr_Device_ReadParms;
		_xdr_result = (xdrproc_t) xdr_Device_ReadResp;
		local = (bool_t (*) (char *, void *,  struct svc_req *))device_read_1_svc;
		break;

	case device_readstb:
		_xdr_argument = (xdrproc_t) xdr_Device_GenericParms;
		_xdr_result = (xdrproc_t) xdr_Device_ReadStbResp;
		local = (bool_t (*) (char *, void *,  struct svc_req *))device_readstb_1_svc;
		break;

	case device_trigger:
		_xdr_argument = (xdrproc_t) xdr_Device_GenericParms;
		_xdr_result = (xdrproc_t) xdr_Device_Error;
		local = (bool_t (*) (char *, void *,  struct svc_req *))device_trigger_1_svc;
		break;

	case device_clear:
		_xdr_argument = (xdrproc_t) xdr_Device_GenericParms;
		_xdr_result = (xdrproc_t) xdr_Device_Error;
		local = (bool_t (*) (char *, void *,  struct svc_req *))device_clear_1_svc;
		break;

	case device_remote:
		_xdr_argument = (xdrproc_t) xdr_Device_GenericParms;
		_xdr_result = (xdrproc_t) xdr_Device_Error;
		local = (bool_t (*) (char *, void *,  struct svc_req *))device_remote_1_svc;
		break;

	case device_local:
		_xdr_argument = (xdrproc_t) xdr_Device_GenericParms;
		_xdr_result = (xdrproc_t) xdr_Device_Error;
		local = (bool_t (*) (char *, void *,  struct svc_req *))device_local_1_svc;
		break;

	case device_lock:
		_xdr_argument = (xdrproc_t) xdr_Device_LockParms;
		_xdr_result = (xdrproc_t) xdr_Device_Error;
		local = (bool_t (*) (char *, void *,  struct svc_req *))device_lock_1_svc;
		break;

	case device_unlock:
		_xdr_argument = (xdrproc_t) xdr_Device_Link;
		_xdr_result = (xdrproc_t) xdr_Device_Error;
		local = (bool_t (*) (char *, void *,  struct svc_req *))device_unlock_1_svc;
		break;

	case device_enable_srq:
		_xdr_argument = (xdrproc_t) xdr_Device_EnableSrqParms;
		_xdr_result = (xdrproc_t) xdr_Device_Error;
		local = (bool_t (*) (char *, void *,  struct svc_req *))device_enable_srq_1_svc;
		break;

	case device_docmd:
		_xdr_argument = (xdrproc_t) xdr_Device_DocmdParms;
		_xdr_result = (xdrproc_t) xdr_Device_DocmdResp;
		local = (bool_t (*) (char *, void *,  struct svc_req *))device_docmd_1_svc;
		break;

	case destroy_link:
		_xdr_argument = (xdrproc_t) xdr_Device_Link;
		_xdr_result = (xdrproc_t) xdr_Device_Error;
		local = (bool_t (*) (char *, void *,  struct svc_req *))destroy_link_1_svc;
		break;

	case create_intr_chan:
		_xdr_argument = (xdrproc_t) xdr_Device_RemoteFunc;
		_xdr_result = (xdrproc_t) xdr_Device_Error;
		local = (bool_t (*) (char *, void *,  struct svc_req *))create_intr_chan_1_svc;
		break;

	case destroy_intr_chan:
		_xdr_argument = (xdrproc_t) xdr_void;
		_xdr_result = (xdrproc_t) xdr_Device_Error;
		local = (bool_t (*) (char *, void *,  struct svc_req *))destroy_intr_chan_1_svc;
		break;

	default:
		svcerr_noproc (transp);
		return;
	}
	memset ((char *)&argument, 0, sizeof (argument));
	if (!svc_getargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		svcerr_decode (transp);
		return;
	}
	retval = (bool_t) (*local)((char *)&argument, (void *)&result, rqstp);
	if (retval > 0 && !svc_sendreply(transp, (xdrproc_t) _xdr_result, (char *)&result)) {
	  fprintf(stderr, "Hit svcerr_systemerr\n\r");
		svcerr_systemerr (transp);
	}
	if (!svc_freeargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		fprintf (stderr, "%s", "unable to free arguments");
		exit (1);
	}
	if (!device_core_1_freeresult (transp, _xdr_result, (caddr_t) &result))
		fprintf (stderr, "%s", "unable to free results");

	return;
}

static void
device_intr_1(struct svc_req *rqstp, register SVCXPRT *transp)
{
  fprintf(stderr, "%s", "Hit device_intr_1\n\r");
	union {
		Device_SrqParms device_intr_srq_1_arg;
	} argument;
	union {
	} result;
	bool_t retval;
	xdrproc_t _xdr_argument, _xdr_result;
	bool_t (*local)(char *, void *, struct svc_req *);

	switch (rqstp->rq_proc) {
	case NULLPROC:
		(void) svc_sendreply (transp, (xdrproc_t) xdr_void, (char *)NULL);
		return;

	case device_intr_srq:
		_xdr_argument = (xdrproc_t) xdr_Device_SrqParms;
		_xdr_result = (xdrproc_t) xdr_void;
		local = (bool_t (*) (char *, void *,  struct svc_req *))device_intr_srq_1_svc;
		break;

	default:
		svcerr_noproc (transp);
		return;
	}
	memset ((char *)&argument, 0, sizeof (argument));
	if (!svc_getargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		svcerr_decode (transp);
		return;
	}
	retval = (bool_t) (*local)((char *)&argument, (void *)&result, rqstp);
	if (retval > 0 && !svc_sendreply(transp, (xdrproc_t) _xdr_result, (char *)&result)) {
		svcerr_systemerr (transp);
	}
	if (!svc_freeargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		fprintf (stderr, "%s", "unable to free arguments");
		exit (1);
	}
	if (!device_intr_1_freeresult (transp, _xdr_result, (caddr_t) &result))
		fprintf (stderr, "%s", "unable to free results");

	return;
}

int
main (int argc, char **argv)
{
	register SVCXPRT *transp;

	pmap_unset (DEVICE_ASYNC, DEVICE_ASYNC_VERSION);
	pmap_unset (DEVICE_CORE, DEVICE_CORE_VERSION);
	pmap_unset (DEVICE_INTR, DEVICE_INTR_VERSION);

	transp = svcudp_create(RPC_ANYSOCK);
	if (transp == NULL) {
		fprintf (stderr, "%s", "cannot create udp service.");
		exit(1);
	}
	if (!svc_register(transp, DEVICE_ASYNC, DEVICE_ASYNC_VERSION, device_async_1, IPPROTO_UDP)) {
		fprintf (stderr, "%s", "unable to register (DEVICE_ASYNC, DEVICE_ASYNC_VERSION, udp).");
		exit(1);
	}
	if (!svc_register(transp, DEVICE_CORE, DEVICE_CORE_VERSION, device_core_1, IPPROTO_UDP)) {
		fprintf (stderr, "%s", "unable to register (DEVICE_CORE, DEVICE_CORE_VERSION, udp).");
		exit(1);
	}
	if (!svc_register(transp, DEVICE_INTR, DEVICE_INTR_VERSION, device_intr_1, IPPROTO_UDP)) {
		fprintf (stderr, "%s", "unable to register (DEVICE_INTR, DEVICE_INTR_VERSION, udp).");
		exit(1);
	}

	transp = svctcp_create(RPC_ANYSOCK, 0, 0);
	fprintf(stderr, "Port %d\n\r", transp->xp_port);
	if (transp == NULL) {
		fprintf (stderr, "%s", "cannot create tcp service.");
		exit(1);
	}
	if (!svc_register(transp, DEVICE_ASYNC, DEVICE_ASYNC_VERSION, device_async_1, IPPROTO_TCP)) {
		fprintf (stderr, "%s", "unable to register (DEVICE_ASYNC, DEVICE_ASYNC_VERSION, tcp).");
		exit(1);
	}
	if (!svc_register(transp, DEVICE_CORE, DEVICE_CORE_VERSION, device_core_1, IPPROTO_TCP)) {
		fprintf (stderr, "%s", "unable to register (DEVICE_CORE, DEVICE_CORE_VERSION, tcp).");
		exit(1);
	}
	if (!svc_register(transp, DEVICE_INTR, DEVICE_INTR_VERSION, device_intr_1, IPPROTO_TCP)) {
		fprintf (stderr, "%s", "unable to register (DEVICE_INTR, DEVICE_INTR_VERSION, tcp).");
		exit(1);
	}

	svc_run ();
	fprintf (stderr, "%s", "svc_run returned");
	exit (1);
	/* NOTREACHED */
}
