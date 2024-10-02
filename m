Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CE28F40
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908055; cv=none; b=IJw7E1LI94zgnmqQaJjemzLi3SfXwEhfsQZKqWc3yEUfWWh8gBnwN/vYNyYOTPPcbkWaaQef4/dcAgQEu75c2YMtmMHhj4dtZAQd4N4+1n/tSRQI+6eX+RNQggXtSCCF170/J/YkNpNjoV6AKdOZBL8fRn32+4ktPLxI6T6NQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908055; c=relaxed/simple;
	bh=0NhFKsTdKewFEpxTZg7YxpWzPrDf1x7sj70luTglJgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX+jBi8D7FyJKfbtay0FHLsZ0EjhQQlUSOpMr6XbSwLhn7oplWnoSaJJeUw5CK6zW0/vDMi+mbIx88gWIDFhPCmjPykCjGIZtY6nS4X/Tm4mEmijjbVe7nlNdRSHQGdTAfmygUMjxdCO3VpgKgm+l0SDMhM1wh+4MaTvyAWlp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5b9PeXR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5b9PeXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0DCC4CEC2;
	Wed,  2 Oct 2024 22:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727908055;
	bh=0NhFKsTdKewFEpxTZg7YxpWzPrDf1x7sj70luTglJgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5b9PeXRAHkfQeqRYLz+3cmzAsUYzQOf0uj3olitCvLQwkivIuCa5a8iZJLno/Cib
	 E7bxBHidaUZzGnBDFKHqNkrmFYWjAoGeaKCmN0FPM6570zTQcOnk9Mh4msYGt0UE1n
	 KXW1vvKpQvUiwM/Bpcz5niHu1JttxDKmE66WVMwOMGO59OKxhwLA1oetP/VfSjadFc
	 V7KCTVOonK6OAF4KDis95zUJS1D5wu/qcAlkbqv054sgTQgUsksR/qr0jQPY94IoVM
	 pVQXbjx9BrnBSObfmFTFUijm1KJrum7eTT30Gvf86/UaMFvsB1InN4WnPmVo7/4Qup
	 bQ4xYAOkoHRgg==
Date: Wed, 2 Oct 2024 15:27:32 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org,
	irogers@google.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com
Subject: Re: [PATCH] perf trace: Keep exited threads for summary
Message-ID: <Zv3I1OIxrfIDtaH1@google.com>
References: <20240927151926.399474-1-mpetlan@redhat.com>
 <2ac467a9-065f-4da2-858c-04e72ce70b55@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ac467a9-065f-4da2-858c-04e72ce70b55@redhat.com>

On Mon, Sep 30, 2024 at 11:07:45AM +0200, Veronika Molnarova wrote:
> 
> 
> On 9/27/24 17:19, Michael Petlan wrote:
> > Since 9ffa6c7512ca ("perf machine thread: Remove exited threads by
> > default") perf cleans exited threads up, but as said, sometimes they
> > are necessary to be kept. The mentioned commit does not cover all the
> > cases, we also need the information to construct the summary table in
> > perf-trace.
> > 
> > Before:
> >     # perf trace -s true
> > 
> >      Summary of events:
> > 
> > After:
> >     # perf trace -s -- true
> > 
> >      Summary of events:
> > 
> >      true (383382), 64 events, 91.4%
> > 
> >        syscall            calls  errors  total       min       avg       max       stddev
> >                                          (msec)    (msec)    (msec)    (msec)        (%)
> >        --------------- --------  ------ -------- --------- --------- ---------     ------
> >        mmap                   8      0     0.150     0.013     0.019     0.031     11.90%
> >        mprotect               3      0     0.045     0.014     0.015     0.017      6.47%
> >        openat                 2      0     0.014     0.006     0.007     0.007      9.73%
> >        munmap                 1      0     0.009     0.009     0.009     0.009      0.00%
> >        access                 1      1     0.009     0.009     0.009     0.009      0.00%
> >        pread64                4      0     0.006     0.001     0.001     0.002      4.53%
> >        fstat                  2      0     0.005     0.001     0.002     0.003     37.59%
> >        arch_prctl             2      1     0.003     0.001     0.002     0.002     25.91%
> >        read                   1      0     0.003     0.003     0.003     0.003      0.00%
> >        close                  2      0     0.003     0.001     0.001     0.001      3.86%
> >        brk                    1      0     0.002     0.002     0.002     0.002      0.00%
> >        rseq                   1      0     0.001     0.001     0.001     0.001      0.00%
> >        prlimit64              1      0     0.001     0.001     0.001     0.001      0.00%
> >        set_robust_list        1      0     0.001     0.001     0.001     0.001      0.00%
> >        set_tid_address        1      0     0.001     0.001     0.001     0.001      0.00%
> >        execve                 1      0     0.000     0.000     0.000     0.000      0.00%
> > 
> > Fixes: 9ffa6c7512ca ("perf machine thread: Remove exited threads by default")
> > 
> > Reported-by: Veronika Molnarova <vmolnaro@redhat.com>
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> 
> The -S and -s option works after this patch, but --errno-summary ends with
> segfault for some reason.
> 
> Before:
> 	# perf trace --errno-summary -- true
> 
> 
>  	Summary of events:
> 
> After:
> 	# perf trace --errno-summary -- true
> 
> 	 Summary of events:
> 	
> 	 true (11386), 60 events, 90.9%
> 	
>    	   syscall            calls  errors  total       min       avg       max       stddev
>         	                             (msec)    (msec)    (msec)    (msec)        (%)
>  	   --------------- --------  ------ -------- --------- --------- ---------     ------
>    	   mmap                   8      0     0.044     0.003     0.006     0.010     15.17%
>    	   mprotect               3      0     0.014     0.004     0.005     0.005      4.56%
>    	   openat                 2      0     0.009     0.004     0.004     0.005      5.14%
>    	   munmap                 1      0     0.007     0.007     0.007     0.007      0.00%
>   	   access                 1      1     0.004     0.004     0.004     0.004      0.00%
> 	perf: Segmentation fault
> 	Obtained 12 stack frames.
> 	./perf() [0x5ae123]
> 	./perf() [0x5ae1cb]
> 	/lib64/libc.so.6(+0x3dbb0) [0x7f633845fbb0]
> 	./perf() [0x56e2fb]
> 	./perf() [0x4850b3]
> 	./perf() [0x48ee89]
> 	./perf() [0x493042]
> 	./perf() [0x49334b]
> 	./perf() [0x40ee8c]
> 	/lib64/libc.so.6(+0x27b8a) [0x7f6338449b8a]
> 	/lib64/libc.so.6(__libc_start_main+0x8b) [0x7f6338449c4b]
> 	./perf() [0x40f4b5]
> 	Segmentation fault
> 
> Will try to check what is causing this issue.

It seems like a different bug and shoul not be affected by this change.

  Program received signal SIGSEGV, Segmentation fault.
  0x000055555574cf67 in perf_env__arch_strerrno (env=0x0, err=110) at util/env.c:475
  475		if (env->arch_strerrno == NULL)
  (gdb) bt
  #0  0x000055555574cf67 in perf_env__arch_strerrno (env=0x0, err=110) at util/env.c:475
  #1  0x000055555563fc0b in thread__dump_stats (ttrace=0x55555661a220, trace=0x7fffffffaaf0, fp=0x7fffee3f24e0 <_IO_2_1_stderr_>) at builtin-trace.c:4674
  #2  0x000055555563fef8 in trace__fprintf_thread (fp=0x7fffee3f24e0 <_IO_2_1_stderr_>, thread=0x5555560f75d0, trace=0x7fffffffaaf0) at builtin-trace.c:4709
  #3  0x0000555555640112 in trace__fprintf_thread_summary (trace=0x7fffffffaaf0, fp=0x7fffee3f24e0 <_IO_2_1_stderr_>) at builtin-trace.c:4748
  #4  0x000055555563eba7 in trace__run (trace=0x7fffffffaaf0, argc=2, argv=0x7fffffffe390) at builtin-trace.c:4457
  #5  0x0000555555642a61 in cmd_trace (argc=2, argv=0x7fffffffe390) at builtin-trace.c:5484
  #6  0x0000555555648a37 in run_builtin (p=0x5555560185e8 <commands+648>, argc=5, argv=0x7fffffffe390) at perf.c:351
  #7  0x0000555555648cde in handle_internal_command (argc=5, argv=0x7fffffffe390) at perf.c:404
  #8  0x0000555555648e37 in run_argv (argcp=0x7fffffffe18c, argv=0x7fffffffe180) at perf.c:448
  #9  0x0000555555649185 in main (argc=5, argv=0x7fffffffe390) at perf.c:562

It needs to pass a non-NULL 'env' when --errno-summary is given.

Anyway, I'll pick this up.

Thanks,
Namhyung


> 
> > ---
> >  tools/perf/builtin-trace.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index f6e847529073..1a12ed71c809 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -5449,6 +5449,10 @@ int cmd_trace(int argc, const char **argv)
> >  	if (trace.summary_only)
> >  		trace.summary = trace.summary_only;
> >  
> > +	/* Keep exited threads, otherwise information might be lost for summary */
> > +	if (trace.summary || trace.summary_only)
> > +		symbol_conf.keep_exited_threads = true;
> > +
> >  	if (output_name != NULL) {
> >  		err = trace__open_output(&trace, output_name);
> >  		if (err < 0) {
> 
