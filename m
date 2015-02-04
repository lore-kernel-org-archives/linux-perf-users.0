From: Carl Love <cel@us.ibm.com>
Subject: PATCH[3/3 RFC]  PERF, Add remapping support for jit'ed code to perf
Date: Wed, 04 Feb 2015 09:15:37 -0800
Message-ID: <1423070137.7292.31.camel@oc0276584878.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:39680 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161032AbbBDRQa (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 Feb 2015 12:16:30 -0500
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <cel@us.ibm.com>;
	Wed, 4 Feb 2015 12:16:30 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D48A338C804F
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2015 12:16:26 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t14HGQss21692642
	for <linux-perf-users@vger.kernel.org>; Wed, 4 Feb 2015 17:16:26 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t14HGP3I019833
	for <linux-perf-users@vger.kernel.org>; Wed, 4 Feb 2015 12:16:26 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org
Cc: cel@us.ibm.com, sukadev@linux.vnet.ibm.com, Pawel Moll <pawel.moll@arm.com>

/*
 * Agent library to collect jit code for the perf tool
 * 
 *
 *
 */

#include <stdio.h>
#include "/home/carll/JAVA_INCLUDES/include/jvmti.h"
#include "perf-jit-support.h"
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include <errno.h>
#include <linux/prctl.h>
#include <fcntl.h>
#include <pthread.h>


#define TRUE  1
#define FALSE 0

/* This call back library is still under development.  The library inserts
 * a remap request after pr_count symbols have loaded.  This is just to force
 * remap requests to be sent to test the remapping in the perf code.
 *
 * This code will be updated to only send the remap request when the mapping
 * has changed to reuse an address range.  As long as new symbols do not use
 * an address range for a previously loaded and unloaded method no remap is 
 * required.  
 * 
 * This library is being submitted as is for the moment to show how the remap
 * requests are sent to perf.
 */

static int debug = TRUE;
static int symbol_count = 0, pr_count = 1;
static pthread_mutex_t perf_mutex = PTHREAD_MUTEX_INITIALIZER;
static FILE *perf_file = NULL;

/* flags for informatiion we can access */
static int source_file_name_avail = FALSE;

typedef void (*call_back) (int, int);

call_back back = NULL;

void set_callback_function(call_back back_arg) {
  back = back_arg;
}

void print_callback_function(void) {
  fprintf(stderr, " the call back function address is %p\n", back);
}

static int print_error(jvmtiError error, char const * msg)
{
  fprintf(stderr, "  %s:  err code %i\n", msg, error);
  fflush(stderr);
  return 0;

}


static void JNICALL
compiled_method_load_handler(jvmtiEnv * jvmti,
			     jmethodID method,
			     jint code_size,
			     void const * code_addr,
			     jint map_length,
			     jvmtiAddrLocationMap const * map,
			     void const * compile_info)
{

  jvmtiError rtn;
  jclass class_type;
  char * thread_ptr = NULL;
  char * class_signature_ptr = NULL;
  char * source_file_name = NULL;
  char * method_signature_ptr = NULL;
  char * method_name = NULL;

  char filename[20];
  char methodname[20];
  static FILE *perf_file_tmp;

  struct jit_data_st jit_data;
  struct sym_data_st sym_data, sym_data_array[200];

  int i, error;
  unsigned long zero = 0, size;

  if (debug)
    fprintf(stderr, "Called compiled_method_load_handler\n");

  rtn = (*jvmti)->GetMethodDeclaringClass(jvmti, method,
					  &class_type);
  if (back == NULL) {
    fprintf(stderr, "call back function is NULL\n");
  } else {
    fprintf(stderr, "call back function is not NULL\n");
    back (1, 2);
  }

  if (rtn != JVMTI_ERROR_NONE) {
    print_error(rtn, "Error: GetMethodDeclaringClass() failed");
  }

  rtn = (*jvmti)->GetClassSignature(jvmti, class_type,
				    &class_signature_ptr, NULL);
  if (rtn != JVMTI_ERROR_NONE) {
    print_error(rtn, "Error: GetClassSignature() failed");
    (*jvmti)->Deallocate(jvmti, (unsigned char *) class_signature_ptr);
  }

  rtn = (*jvmti)->GetMethodName(jvmti, method, &method_name,
				&method_signature_ptr, NULL);
  if (rtn != JVMTI_ERROR_NONE) {
    print_error(rtn, "Error: GetMethodName() failed");
    (*jvmti)->Deallocate(jvmti, (unsigned char *) class_signature_ptr);
    (*jvmti)->Deallocate(jvmti, (unsigned char *) method_signature_ptr);
  }

  /* get additional info if available */
  if (source_file_name_avail == TRUE) {
    //    rtn = (*jvmti)->GetSourceFileName(jvmti, class_type,
    //				      &sym_data.source_code_filename);
    // Work on gathering the source code.  FIX
    ;
  }

  if (rtn != JVMTI_ERROR_NONE) {
    print_error(rtn, "Error: GetSourceFileName() failed");
    source_file_name_avail == FALSE;
  }

  strcpy(sym_data.method_name, method_name);
  sym_data.virtual_mem_addr = (uint64_t)(uintptr_t) code_addr;
  sym_data.code_size = code_size;

  if (debug) {
    fprintf(stderr, "PID = %d\n", getpid());
    fprintf(stderr, "compiled_method_load_handler: class_type = %p\n",
	    class_type);
    fprintf(stderr, "class signature = %s, method name = %s\n",
	    class_signature_ptr, sym_data.method_name);

    fprintf(stderr, "method_signature = %s\n", method_signature_ptr);

    if (source_file_name_avail == TRUE)
      fprintf(stderr, "source file name = %s\n",
	      sym_data.source_code_filename);

    fprintf(stderr, "code address = %p, code size = %x\n",
	    sym_data.virtual_mem_addr, sym_data.code_size);
    fprintf(stderr, "\n");
  }

  size = (unsigned long) sizeof(sym_data);


  /* check if the perf file is open */
  if (perf_file == NULL) {
    sprintf(filename, "/tmp/perf-%d.map", getpid());
    fprintf(stderr, "CARLL, symbol file %s\n", filename);

    perf_file = fopen(filename, "w");

    if (perf_file == NULL) {
      fprintf(stderr, "ERROR, could not open %s\n", filename);
    }
  }

  sym_data_array[symbol_count].virtual_mem_addr = sym_data.virtual_mem_addr;
  sym_data_array[symbol_count].code_size = sym_data.code_size;
  strcpy(sym_data_array[symbol_count].method_name, sym_data.method_name);
  printf("CARLL, here 3\n");
  fflush(stdout);
  
  printf("CARLL, source_file_name_avail = %d\n", source_file_name_avail);
  fflush(stdout);

  if (source_file_name_avail == TRUE) {
    ;  
  }

  pthread_mutex_lock(&perf_mutex);

  if ((symbol_count % pr_count == 0) && (symbol_count != 0)){
    fclose(perf_file);
    sprintf(filename, "/tmp/perf-%d-%d.map", getpid(),
	    (symbol_count/pr_count));
    perf_file = fopen(filename, "w");

    if (perf_file == NULL) {
      fprintf(stderr, "ERROR, could not open %s\n", filename);
    } 

    /* Send notification to perf.data file saying remap has occured.  Do
     * this as soon as possible so samples will be correctly aligned to 
     * the old/new maps.
     */
    strcpy(jit_data.map_filename, filename);  
    jit_data.pid = getpid();
    jit_data.tid = getpid()+1;   // temporary hack, the gettid() isn't compiling
    //      jit_data.tid = gettid();  // gettid() UNDEFINED, FIX, hack for now

    error = prctl(PR_TASK_PERF_UEVENT, zero, size,
		  (unsigned long)(&jit_data),	zero);
    if (error)
      fprintf(stderr, "ERROR, perf remap with file = %s FALED\n", filename);
    
    for (i = 0; i <= symbol_count; i++) {
      fprintf(perf_file, "%llx %x %s\n",
	      sym_data_array[i].virtual_mem_addr,
	      sym_data_array[i].code_size,
	      sym_data_array[i].method_name);
    }
    fflush(stdout);

  } else {
    fprintf(perf_file, "%llx %x %s\n",
	    sym_data.virtual_mem_addr,
	    sym_data.code_size,
	    sym_data.method_name);
  }
  pthread_mutex_unlock(&perf_mutex);

  symbol_count++;
}

static void JNICALL
compiled_method_unload_handler(jvmtiEnv * jvmti_env,
			       jmethodID method,
			       void const * code_addr)
{
  if (debug)
    fprintf(stderr, "called compiled_method_unload_handler addr=%p\n",
	    code_addr);
}



JNIEXPORT jint JNICALL
Agent_OnLoad(JavaVM * jvm, char * options, void * reserved)
{
  jint  rc;
  jvmtiEventCallbacks callbacks;
  jvmtiEnv * jvmti = NULL;
  jvmtiError rtn;
  jvmtiCapabilities capabilities;

  if (options) {
    /* check the passed options */
    if (strcmp("debug", options) == 0)
      debug = TRUE;
  }

  if (debug)
    fprintf(stderr, "Called Agent_OnLoad for libjvmti-perf\n");

  rc = (*jvm)->GetEnv(jvm, (void *)&jvmti, JVMTI_VERSION_1);

  if (rc != JNI_OK) {
    print_error(rtn, "Error: GetEnv failed");
    return -1;
  }

  /* setup capabilities */
  memset(&capabilities, '\0', sizeof(capabilities));
  capabilities.can_generate_compiled_method_load_events = 1;
  rtn = (*jvmti)->AddCapabilities(jvmti, &capabilities);

  if (rtn != JVMTI_ERROR_NONE) {
    print_error(rtn, "Error: AddCapabilities, can_generate_compiled_method_load_events failed");
    return -1;
  }

  capabilities.can_get_source_file_name = 1;
  rtn = (*jvmti)->AddCapabilities(jvmti, &capabilities);

  if (rtn == JVMTI_ERROR_NONE)
    source_file_name_avail = TRUE;

  if (debug) {
    fprintf(stderr, "Capabilities: \n");

    if (source_file_name_avail == TRUE)  
      fprintf(stderr, " get_source_file_name\n");

    fprintf(stderr, "\n\n");
  }
  /* setup callbacks to collect information needed by perf */
  memset(&callbacks, 0, sizeof(callbacks));
  callbacks.CompiledMethodLoad = compiled_method_load_handler;
  callbacks.CompiledMethodUnload = compiled_method_unload_handler;

  rtn = (*jvmti)->SetEventCallbacks(jvmti, &callbacks,
				      sizeof(callbacks));

  if (rtn != JVMTI_ERROR_NONE) {
    print_error(rtn, "Error: SetEventCallbacks failed");
    return -1;
  }

  rtn = (*jvmti)->SetEventNotificationMode(jvmti, JVMTI_ENABLE,
					   JVMTI_EVENT_COMPILED_METHOD_LOAD,
					   NULL);

  if (rtn != JVMTI_ERROR_NONE) {
    print_error(rtn, "Error: Enabling method load callback failed");
    return -1;
  }

  rtn = (*jvmti)->SetEventNotificationMode(jvmti, JVMTI_ENABLE,
					   JVMTI_EVENT_COMPILED_METHOD_UNLOAD,
					   NULL);
  if (rtn != JVMTI_ERROR_NONE) {
    print_error(rtn, "Error: Enabling method unload callback failed");
    return -1;
  }

  return 0;  /* success */
}
