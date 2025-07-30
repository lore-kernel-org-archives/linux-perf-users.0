Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9741E3772
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Jul 2025 18:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899131; cv=none; b=ZnYl3bghAz56xJWmzL1C9yQhKYLI76Yes/3KeapyVAc3K52SAevARfh5ShtaXqK78FD/yCmiZzzWiPp5YxkVhWU/gZ50qTxyQhD/AZw7kM0ArpQScSXmbnAAvSuHNLc24sXqMtRt06J5eGVZmmcbYIhlY9fouf//ACDoviZOKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899131; c=relaxed/simple;
	bh=VKJAtCIqjgiKO/g1zINUWruZgZKKnc1oXYyJuC29TFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyTH3+oYUFjstgVH2COStqt/XONTlweIzQnLLSfsqtPHweCnBzT9jP+Jry6cBlCypX6xvOTNXCfr/mVU1h8fnzbpHygBLQTpvDGpKzum+fJniaWrS1NkNqMyk/q6yzuxUhFJM0oNdw0djO4+FxCnkkBMxCrlxtFnSnjZXFMxW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErjHvYfr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErjHvYfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283DCC4CEE3;
	Wed, 30 Jul 2025 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753899131;
	bh=VKJAtCIqjgiKO/g1zINUWruZgZKKnc1oXYyJuC29TFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ErjHvYfraavl3DHVDbMC7C6hgHch1npNTS/hcBlbexg0nv43q3NdV2uCQbiMI/1Gf
	 O3fjWpcqaYNQN6uZpcP1HY+Ejmf85OOP8pqr1NgH3FVjJyAF/KHXlIAkdKURbVQ4K2
	 w5O6ow+oDIcJce7LlWU05zB1ooyr12A3gIom4P5yxZ/VwNZF/sbgWOT2AqkXL4bL5P
	 rpbVjpWgpWddHToCVAlEnhUaFnCVXyGK/6ZFywH73QnQUG/ras/pF/vfPQlSIV7ISl
	 JO9ypdZYtM8CIwtkg+ngXISD+EyN0FyDWQtMkLaaKfnswTH7kUGHQO2gud+u827JCH
	 JttbEtetdXw+g==
Date: Wed, 30 Jul 2025 11:12:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jan Polensky <japo@linux.ibm.com>
Cc: adrian.hunter@intel.com, irogers@google.com,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/1] perf test: Ensure lock contention using pipe mode
Message-ID: <aIpgeZUGKb3t9NRq@google.com>
References: <20250725170801.3176678-1-japo@linux.ibm.com>
 <aIRoR6j1qAfytIPC@google.com>
 <aIfNaheJ5REpoFE_@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIfNaheJ5REpoFE_@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>

On Mon, Jul 28, 2025 at 09:20:10PM +0200, Jan Polensky wrote:
> On Fri, Jul 25, 2025 at 10:31:51PM -0700, Namhyung Kim wrote:
> > On Fri, Jul 25, 2025 at 07:08:01PM +0200, Jan Polensky wrote:
> > > The 'kernel lock contention analysis test' requires reliable triggering
> > > of lock contention. On some systems, previous benchmark calls failed to
> > > generate sufficient contention due to low system activity or resource
> > > limits.
> >
> > Right, we need a reliable reproducer.
> >
> > >
> > > This patch adds the -p (pipe) option to all calls of perf bench sched
> > > messaging, ensuring consistent lock contention without relying on
> > > socket-based communication.
> >
> > But I don't understand why pipe is different than sockets.  Can you
> > please elaborate?
> 
> The solution suggested by v1 in
> https://lore.kernel.org/all/aIOvdQ003hRqFEH1@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com/
> can be significantly faster and more reproducible in some cases. However,
> on large systems it may fail with the error "perf: socketpair(): Too many
> open files", which in turn can lead to kernel lock contention. While this
> can be mitigated by increasing the file descriptor limit via ulimit -n
> <number>, we should avoid modifying system settings during testing.

Interesting, I didn't know the socketpair would generate more file
descriptors than pipe.  Maybe there's a bug in perf bench handling
socket file descriptors?

> 
> 	[root@localhost perf]# ./perf stat -- perf bench sched messaging --group $(nproc) --thread
> 	# Running 'sched/messaging' benchmark:
> 	perf: socketpair(): Too many open files
> 
> 	 Performance counter stats for 'perf bench sched messaging --group 32 --thread':
> 
> 				 43.14 msec task-clock                       #    0.104 CPUs utilized
> 				 1,013      context-switches                 #   23.483 K/sec
> 				   900      cpu-migrations                   #   20.863 K/sec
> 				 2,905      page-faults                      #   67.342 K/sec
> 		   162,801,472      instructions                     #    0.74  insn per cycle
> 		   220,427,613      cycles                           #    5.110 GHz
> 
> 		   0.414804757 seconds time elapsed
> 
> 		   0.004687000 seconds user
> 		   0.071900000 seconds sys
> 
> Analyzing the lock content w/o pipe:
> 
>     [root@localhost ~]# perf record -e 'lock:contention*' -a -- perf bench sched messaging; perf script | wc -l
>     # Running 'sched/messaging' benchmark:
>     # 20 sender and receiver processes per group
>     # 10 groups == 400 processes run
> 
>          Total time: 0.135 [sec]
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.363 MB perf.data ]
>     0

Hmm.. strange.  It causes some contention on my system.  But it could be
an arch specific issue.  I'm ok with changing it to pipe then.

Thanks,
Namhyung

> 
> Analyzing the lock content with pipe:
> 
>     [root@localhost ~]# perf record -e 'lock:contention*' -a -- perf bench sched messaging -p; perf script | wc -l
>     # Running 'sched/messaging' benchmark:
>     # 20 sender and receiver processes per group
>     # 10 groups == 400 processes run
> 
>          Total time: 0.108 [sec]
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 1.604 MB perf.data (14789 samples) ]
>     14789
> 
> By using the -g option, we identified pipe as a good source of contention:
> 
>     [skip]
>     sched-messaging 2028653 [003] 625253.243099: lock:contention_begin: 0x85846e40 (flags=SPIN|MUTEX)
>              3a211f16200 __traceiter_contention_begin+0x50 ([kernel.kallsyms])
>              3a212d92e0e __mutex_lock.constprop.0+0x1be ([kernel.kallsyms])
>              3a2122643f2 anon_pipe_write+0x52 ([kernel.kallsyms])
>              3a21225789a vfs_write+0x1ca ([kernel.kallsyms])
>              3a212257ca8 ksys_write+0xd8 ([kernel.kallsyms])
>              3a212d8c8f4 __do_syscall+0x164 ([kernel.kallsyms])
>              3a212d99154 system_call+0x74 ([kernel.kallsyms])
>              3ff8e2a9ba6 __internal_syscall_cancel+0xa6 (/usr/lib64/libc.so.6)
> 
> 	sched-messaging 2028652 [005] 625253.243099:   lock:contention_end: 0x85846e40 (ret=0)
>              3a211f16280 __traceiter_contention_end+0x50 ([kernel.kallsyms])
>              3a212d92fd6 __mutex_lock.constprop.0+0x386 ([kernel.kallsyms])
>              3a2122643f2 anon_pipe_write+0x52 ([kernel.kallsyms])
>              3a21225789a vfs_write+0x1ca ([kernel.kallsyms])
>              3a212257ca8 ksys_write+0xd8 ([kernel.kallsyms])
>              3a212d8c8f4 __do_syscall+0x164 ([kernel.kallsyms])
>              3a212d99154 system_call+0x74 ([kernel.kallsyms])
>              3ff8e2a9ba6 __internal_syscall_cancel+0xa6 (/usr/lib64/libc.so.6)
> 	[skip]
> 
> This suggests that sockets are better optimized to avoid such locking
> issues, and therefore are a poor choice in this specific benchmark
> scenario.
> 
> > Thanks,
> > Namhyung
> >
> [skip]
> > >
