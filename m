Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C02A1B8
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Dec 2024 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221391; cv=none; b=mu5QeZeL6ic7HysORDiZAZX8m47hDbN1Ok09tKxPi0/1sQ9ctHHGrxoy7JRBx2USd6QghUL7VH3SgOTS4RmZi7dBRO7l0XBwuQug2YnnwGnDD7MquSSKtmEBzmS4ztQXQ3IJ1soHCXjwD9/qvs0rlSRbm/n4PjgA1vJjn0gLo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221391; c=relaxed/simple;
	bh=jC5ZZXGG+us+dzjalSTOJFS55SAMDRx2a0gCJW9ylj8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O1cG9twdkHdhxdy1nSqc+LKCuY8UGCHtfvxiasnrrxrf7rFZ5W43UBYDqnwbckQAEnlvKJeHzjfbZznzUNB3sD3sZhMhX/g/R59/9hwJDYVTGFtkx2QdH3ebbyt2EbbhOhok6JNjronzMgXFYPbp5zfQKsFK8JNsi3yrVf+fm3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=he0KfaDI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="he0KfaDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733221389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dddZCBtsII5/kRzmFSAxen5JYlgw9qIJINUCkyKnNps=;
	b=he0KfaDIfrMn9cwSFpD2UBQONBkSgTGPqau4g1Ca2fTnA9cg3+zPQNIUBrLESurEOpHCf1
	PPJr1ltpjYUF0WdHt7QgjXahvQqIZwf1UZ1TB6dv5KA0dW+JuLXLN/cqBlXOHnmAJrLKiO
	IbpPtl0pvFji7QO/XVPXX6/gBlubNRM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-yvLrJ-61P5yiZ2B2Qb2IoQ-1; Tue,
 03 Dec 2024 05:23:05 -0500
X-MC-Unique: yvLrJ-61P5yiZ2B2Qb2IoQ-1
X-Mimecast-MFC-AGG-ID: yvLrJ-61P5yiZ2B2Qb2IoQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 139591955D83;
	Tue,  3 Dec 2024 10:23:04 +0000 (UTC)
Received: from Carbon (unknown [10.39.208.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EB7419560A3;
	Tue,  3 Dec 2024 10:22:59 +0000 (UTC)
Date: Tue, 3 Dec 2024 11:22:56 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
cc: Namhyung Kim <namhyung@kernel.org>, 
    Veronika Molnarova <vmolnaro@redhat.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, 
    James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
    Kan Liang <kan.liang@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 perf-tools] perf machine: Initialize machine->env to
 address a segfault
In-Reply-To: <Z0XffUgNSv_9OjOi@x1>
Message-ID: <18126ef4-e5a0-4c17-2d2-ea4c451a9e@redhat.com>
References: <Z0XffUgNSv_9OjOi@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, 26 Nov 2024, Arnaldo Carvalho de Melo wrote:
> Its used from trace__run(), for the 'perf trace' live mode, i.e. its
> strace-like, non-perf.data file processing mode, the most common one.
> 
> The trace__run() function will set trace->host using machine__new_host()
> that is supposed to give a machine instance representing the running
> machine, and since we'll use perf_env__arch_strerrno() to get the right
> errno -> string table, we need to use machine->env, so initialize it in
> machine__new_host().
> 
> Before the patch:
> 
>   (gdb) run trace --errno-summary -a sleep 1
>   <SNIP>
>    Summary of events:
> 
>    gvfs-afc-volume (3187), 2 events, 0.0%
> 
>      syscall            calls  errors  total       min       avg       max       stddev
>                                        (msec)    (msec)    (msec)    (msec)        (%)
>      --------------- --------  ------ -------- --------- --------- ---------     ------
>      pselect6               1      0     0.000     0.000     0.000     0.000      0.00%
> 
>    GUsbEventThread (3519), 2 events, 0.0%
> 
>      syscall            calls  errors  total       min       avg       max       stddev
>                                        (msec)    (msec)    (msec)    (msec)        (%)
>      --------------- --------  ------ -------- --------- --------- ---------     ------
>      poll                   1      0     0.000     0.000     0.000     0.000      0.00%
>   <SNIP>
>   Program received signal SIGSEGV, Segmentation fault.
>   0x00000000005caba0 in perf_env__arch_strerrno (env=0x0, err=110) at util/env.c:478
>   478		if (env->arch_strerrno == NULL)
>   (gdb) bt
>   #0  0x00000000005caba0 in perf_env__arch_strerrno (env=0x0, err=110) at util/env.c:478
>   #1  0x00000000004b75d2 in thread__dump_stats (ttrace=0x14f58f0, trace=0x7fffffffa5b0, fp=0x7ffff6ff74e0 <_IO_2_1_stderr_>) at builtin-trace.c:4673
>   #2  0x00000000004b78bf in trace__fprintf_thread (fp=0x7ffff6ff74e0 <_IO_2_1_stderr_>, thread=0x10fa0b0, trace=0x7fffffffa5b0) at builtin-trace.c:4708
>   #3  0x00000000004b7ad9 in trace__fprintf_thread_summary (trace=0x7fffffffa5b0, fp=0x7ffff6ff74e0 <_IO_2_1_stderr_>) at builtin-trace.c:4747
>   #4  0x00000000004b656e in trace__run (trace=0x7fffffffa5b0, argc=2, argv=0x7fffffffde60) at builtin-trace.c:4456
>   #5  0x00000000004ba43e in cmd_trace (argc=2, argv=0x7fffffffde60) at builtin-trace.c:5487
>   #6  0x00000000004c0414 in run_builtin (p=0xec3068 <commands+648>, argc=5, argv=0x7fffffffde60) at perf.c:351
>   #7  0x00000000004c06bb in handle_internal_command (argc=5, argv=0x7fffffffde60) at perf.c:404
>   #8  0x00000000004c0814 in run_argv (argcp=0x7fffffffdc4c, argv=0x7fffffffdc40) at perf.c:448
>   #9  0x00000000004c0b5d in main (argc=5, argv=0x7fffffffde60) at perf.c:560
>   (gdb)
> 
> After:
> 
>   root@number:~# perf trace -a --errno-summary sleep 1
>   <SNIP>
>      pw-data-loop (2685), 1410 events, 16.0%
> 
>      syscall            calls  errors  total       min       avg       max       stddev
>                                        (msec)    (msec)    (msec)    (msec)        (%)
>      --------------- --------  ------ -------- --------- --------- ---------     ------
>      epoll_wait           188      0   983.428     0.000     5.231    15.595      8.68%
>      ioctl                 94      0     0.811     0.004     0.009     0.016      2.82%
>      read                 188      0     0.322     0.001     0.002     0.006      5.15%
>      write                141      0     0.280     0.001     0.002     0.018      8.39%
>      timerfd_settime       94      0     0.138     0.001     0.001     0.007      6.47%
> 
>    gnome-control-c (179406), 1848 events, 20.9%
> 
>      syscall            calls  errors  total       min       avg       max       stddev
>                                        (msec)    (msec)    (msec)    (msec)        (%)
>      --------------- --------  ------ -------- --------- --------- ---------     ------
>      poll                 222      0   959.577     0.000     4.322    21.414     11.40%
>      recvmsg              150      0     0.539     0.001     0.004     0.013      5.12%
>      write                300      0     0.442     0.001     0.001     0.007      3.29%
>      read                 150      0     0.183     0.001     0.001     0.009      5.53%
>      getpid               102      0     0.101     0.000     0.001     0.008      7.82%
> 
>   root@number:~#
> 
> Fixes: 54373b5d53c1f6aa ("perf env: Introduce perf_env__arch_strerrno()")
> Reported-by: Veronika Molnarova <vmolnaro@redhat.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks for fixing the segfault!

Acked-by: Michael Petlan <mpetlan@redhat.com>
Tested-by: Michael Petlan <mpetlan@redhat.com>

> ---
>  tools/perf/util/machine.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 4f0ac998b0ccfd7a..27d5345d2b307a97 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -134,6 +134,8 @@ struct machine *machine__new_host(void)
>  
>  		if (machine__create_kernel_maps(machine) < 0)
>  			goto out_delete;
> +
> +		machine->env = &perf_env;
>  	}
>  
>  	return machine;
> -- 
> 2.47.0
> 
> 

