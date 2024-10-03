Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE4D136338
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Oct 2024 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727951777; cv=none; b=Pe0aPjZWgCZLZgwoCKuUDUpgZwFhJDO+gzY6TfaBYUFZ6B24sclXRfmWNruK/Q9XyiUXgyHpq/uevviMNVw2g+/Y/u8QKJEo0Ucasj3ylRmFo2h79PFJPhjCA2cWpuzjnmMS7dEfkGouPMygnRCK3BECNJmoryV0jZSl6E5YUUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727951777; c=relaxed/simple;
	bh=CWGHC/DfJClxUtmZyEWE+nWnsa83ftpL5qdp1ps+qSM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TpOtUh24jpwOx1E93CpcNRpww71rwjnpxPjESLS7YUAgNWu54KGFrCCQmh3EmwPP2SZdn5asksCk1eABJEqVEo7Yt5ZOihSCnuzCoOFK5/5XaXzuwYGhK66zHkvUFl1pBCV3YTLR9Eui11/Zay+bcH/qO87jMp0MEqI0c0e3n0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBo0LxXH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBo0LxXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727951775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygM3fAsA+iIJH87/TNwh24k5+nFhoLzwty4wVdwA9ps=;
	b=PBo0LxXHceHMQXIO+9VlFnxVV9bDW7jtmoppKmaHeqG/VeXh80BJcuPvtrqi9LSGC9wHqd
	DabotgRI7EjQc9pWioMIxYU9uZ9FV8P2KFWZKe+wA3UCx1utLX1sFcfAbcq1GhHc1yH8hz
	1AJtVW7CkevYtDN4SUvuPMiE4Fg9ZZ4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-6wLeKtMYO9qQ5gJZQa7_qw-1; Thu,
 03 Oct 2024 06:36:12 -0400
X-MC-Unique: 6wLeKtMYO9qQ5gJZQa7_qw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7198119560AE;
	Thu,  3 Oct 2024 10:36:09 +0000 (UTC)
Received: from Carbon (unknown [10.39.208.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DDF830000DF;
	Thu,  3 Oct 2024 10:36:05 +0000 (UTC)
Date: Thu, 3 Oct 2024 12:36:01 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
cc: Veronika Molnarova <vmolnaro@redhat.com>, linux-perf-users@vger.kernel.org, 
    irogers@google.com, peterz@infradead.org, mingo@redhat.com, 
    acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
    jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com
Subject: Re: [PATCH] perf trace: Keep exited threads for summary
In-Reply-To: <Zv3I1OIxrfIDtaH1@google.com>
Message-ID: <7c1fba2-5c4c-b997-2c8d-3af7d437c93b@redhat.com>
References: <20240927151926.399474-1-mpetlan@redhat.com> <2ac467a9-065f-4da2-858c-04e72ce70b55@redhat.com> <Zv3I1OIxrfIDtaH1@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, 2 Oct 2024, Namhyung Kim wrote:
> On Mon, Sep 30, 2024 at 11:07:45AM +0200, Veronika Molnarova wrote:
> > On 9/27/24 17:19, Michael Petlan wrote:
[...]
> > 
> > Before:
> > 	# perf trace --errno-summary -- true
> > 
> > 
> >  	Summary of events:
> > 
> > After:
> > 	# perf trace --errno-summary -- true
> > 
> > 	 Summary of events:
> > 	
> > 	 true (11386), 60 events, 90.9%
> > 	
> >    	   syscall            calls  errors  total       min       avg       max       stddev
> >         	                             (msec)    (msec)    (msec)    (msec)        (%)
> >  	   --------------- --------  ------ -------- --------- --------- ---------     ------
> >    	   mmap                   8      0     0.044     0.003     0.006     0.010     15.17%
> >    	   mprotect               3      0     0.014     0.004     0.005     0.005      4.56%
> >    	   openat                 2      0     0.009     0.004     0.004     0.005      5.14%
> >    	   munmap                 1      0     0.007     0.007     0.007     0.007      0.00%
> >   	   access                 1      1     0.004     0.004     0.004     0.004      0.00%
> > 	perf: Segmentation fault
> > 	Obtained 12 stack frames.
> > 	./perf() [0x5ae123]
> > 	./perf() [0x5ae1cb]
> > 	/lib64/libc.so.6(+0x3dbb0) [0x7f633845fbb0]
> > 	./perf() [0x56e2fb]
> > 	./perf() [0x4850b3]
> > 	./perf() [0x48ee89]
> > 	./perf() [0x493042]
> > 	./perf() [0x49334b]
> > 	./perf() [0x40ee8c]
> > 	/lib64/libc.so.6(+0x27b8a) [0x7f6338449b8a]
> > 	/lib64/libc.so.6(__libc_start_main+0x8b) [0x7f6338449c4b]
> > 	./perf() [0x40f4b5]
> > 	Segmentation fault
> > 
> > Will try to check what is causing this issue.
> 
> It seems like a different bug and shoul not be affected by this change.
> 
>   Program received signal SIGSEGV, Segmentation fault.
>   0x000055555574cf67 in perf_env__arch_strerrno (env=0x0, err=110) at util/env.c:475
>   475		if (env->arch_strerrno == NULL)
>   (gdb) bt
>   #0  0x000055555574cf67 in perf_env__arch_strerrno (env=0x0, err=110) at util/env.c:475
>   #1  0x000055555563fc0b in thread__dump_stats (ttrace=0x55555661a220, trace=0x7fffffffaaf0, fp=0x7fffee3f24e0 <_IO_2_1_stderr_>) at builtin-trace.c:4674
>   #2  0x000055555563fef8 in trace__fprintf_thread (fp=0x7fffee3f24e0 <_IO_2_1_stderr_>, thread=0x5555560f75d0, trace=0x7fffffffaaf0) at builtin-trace.c:4709
>   #3  0x0000555555640112 in trace__fprintf_thread_summary (trace=0x7fffffffaaf0, fp=0x7fffee3f24e0 <_IO_2_1_stderr_>) at builtin-trace.c:4748
>   #4  0x000055555563eba7 in trace__run (trace=0x7fffffffaaf0, argc=2, argv=0x7fffffffe390) at builtin-trace.c:4457
>   #5  0x0000555555642a61 in cmd_trace (argc=2, argv=0x7fffffffe390) at builtin-trace.c:5484
>   #6  0x0000555555648a37 in run_builtin (p=0x5555560185e8 <commands+648>, argc=5, argv=0x7fffffffe390) at perf.c:351
>   #7  0x0000555555648cde in handle_internal_command (argc=5, argv=0x7fffffffe390) at perf.c:404
>   #8  0x0000555555648e37 in run_argv (argcp=0x7fffffffe18c, argv=0x7fffffffe180) at perf.c:448
>   #9  0x0000555555649185 in main (argc=5, argv=0x7fffffffe390) at perf.c:562
> 
> It needs to pass a non-NULL 'env' when --errno-summary is given.
> 
> Anyway, I'll pick this up.
> 
Yes, it is probably a different issue, just exposed by the patch.

We'll have a look at it later.

> Thanks,
> Namhyung
> 
Thanks,
Michael

