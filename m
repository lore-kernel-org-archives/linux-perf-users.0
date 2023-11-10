Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59421118
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHtbqTL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A51C433C8;
	Fri, 10 Nov 2023 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699637113;
	bh=DfP9hjT8zX6yNC7H2p7TwjATDIvAvNBlfCKGJXMSaBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHtbqTL8dvA+bay8SCRuBzo7HaI2OeGrcQ7M95Uj2znSH9jyFJ02rU0UXdZNRVrXM
	 VljT6mcVRfHbQ4SroTPiqy81ZQ4WmLNxljHj9C2kE0vaJAjSx0D+1kiR598ZVjuqvk
	 hqHkm1dl9pwsB0ygtpQ9Ga+Yk1j1/WeEgZpzkHydUs47Q0gxyJdu0pJsK2ae7qK77q
	 4qtfrpuoSr4jFKDKS0u5J8xitTxWvmn+wbEppwEBElFFcuf69vbhDPIH6EXy9IoI6a
	 jj9CepI82y91RzbsXF8Nm3hY7kKkB3lUoZFWM71mOvTqjOZDejAGauzfNw0GwS1LX1
	 FppOMpV1Lsi4Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 1F5E640094; Fri, 10 Nov 2023 12:59:34 -0300 (-03)
Date: Fri, 10 Nov 2023 12:59:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Maksymilian Graczyk <maksymilian.graczyk@cern.ch>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	syclops-project <syclops-project@cern.ch>,
	Guilherme Amadio <guilherme.amadio@cern.ch>,
	Stephan Hageboeck <stephan.hageboeck@cern.ch>
Subject: Re: Broken stack traces with --call-graph=fp and a multi-threaded
 app due to page faults?
Message-ID: <ZU5TZiXMUZ4VLOO+@kernel.org>
References: <de597d7c-848e-4a35-887a-4cdefa23ecd2@cern.ch>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de597d7c-848e-4a35-887a-4cdefa23ecd2@cern.ch>
X-Url: http://acmel.wordpress.com

Em Wed, Nov 08, 2023 at 11:46:03AM +0100, Maksymilian Graczyk escreveu:
> Hello all,
 
> I have a problem with broken stack traces in perf when I profile a small
> multi-threaded program in C producing deep (~1000 entries) stacks with "perf
> record --call-graph=fp -e task-clock -F <any number> --off-cpu" attached to
> the program's PID. The callchains seem to stop at "random" points throughout
> my application, occasionally managing to reach the bottom (i.e. either
> "start" or "clone3").

> This is the machine configuration I use:
> 
> * Intel Xeon Silver 4216 @ 2.10 GHz, with two 16-core CPUs and
> hyper-threading disabled
> * 180 GB RAM, with no errors detected by Memtest86+ and no swap
> * Gentoo with Linux 6.5.8 (installed from the Gentoo repo with
> gentoo-sources and compiled using this config:
> https://gist.github.com/maksgraczyk/1bce96841a5b2cb2a92f725635c04bf2)
> * perf 6.6 with this quick patch of mine:
> https://gist.github.com/maksgraczyk/ee1dd98dda79129a35f7fd3acffb35fd


Ok, so the backtrace is being collected in the BPF skel (copying the
patch here for convenience):

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 01f70b8e705a8..cb2e4f335b0ad 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -16,7 +16,7 @@

 #include "bpf_skel/off_cpu.skel.h"

-#define MAX_STACKS  32
+#define MAX_STACKS  1024
 #define MAX_PROC  4096
 /* we don't need actual timestamp, just want to put the samples at last */
 #define OFF_CPU_TIMESTAMP  (~0ull << 32)
@@ -33,7 +33,7 @@ struct off_cpu_key {

 union off_cpu_data {
 	struct perf_event_header hdr;
-	u64 array[1024 / sizeof(u64)];
+	u64 array[1024 / sizeof(u64) + (MAX_STACKS - 32)];
 };

 static int off_cpu_config(struct evlist *evlist)
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index d877a0a9731f9..802c2389c400a 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -15,7 +15,7 @@
 /* create a new thread */
 #define CLONE_THREAD  0x10000

-#define MAX_STACKS   32
+#define MAX_STACKS   1024
 #define MAX_ENTRIES  102400

 struct tstamp_data {
--

That changes the size of the 'stacks' BPF map that is then used in:

        stack_id = bpf_get_stackid(ctx, &stacks,
                                   BPF_F_FAST_STACK_CMP | BPF_F_USER_STACK);


So, in the bpf_get_stackid implementation:

BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
           u64, flags)
{
        u32 max_depth = map->value_size / stack_map_data_size(map);
        u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
        bool user = flags & BPF_F_USER_STACK;
        struct perf_callchain_entry *trace;
        bool kernel = !user;

        if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
                               BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
                return -EINVAL;

        max_depth += skip;
        if (max_depth > sysctl_perf_event_max_stack)
                max_depth = sysctl_perf_event_max_stack;

        trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
                                   false, false);

        if (unlikely(!trace))
                /* couldn't fetch the stack trace */
                return -EFAULT;

        return __bpf_get_stackid(map, trace, flags);
}

So it is capped by sysctl_perf_event_max_stack, that is:

[root@quaco ~]# cat /proc/sys/kernel/perf_event_max_stack
127
[root@quaco ~]#

Can you try after doing:

[root@quaco ~]# echo 1024 > /proc/sys/kernel/perf_event_max_stack 
[root@quaco ~]# cat /proc/sys/kernel/perf_event_max_stack 
1024
[root@quaco ~]#

more comments below

> * Everything is compiled with "-fno-omit-frame-pointer" and
> "-mno-omit-leaf-frame-pointer" gcc flags
> * kernel.perf_event_max_stack is set to 1024 and kernel.perf_event_paranoid
> is set to -1
> 
> The code of the profiled program is at
> https://gist.github.com/maksgraczyk/da2bc6d0be9d4e7d88f8bea45221a542 (the
> higher the value of NUM_THREADS, the more likely the issue is to occur; you
> may need to compile the code without compiler optimisations).
> 
> Alongside sampling-based profiling, I run syscall profiling with a separate
> "perf record" instance attached to the same PID.
> 
> When I debug the kernel using kgdb, I see more-or-less the following
> behaviour happening in the stack traversal loop in perf_callchain_user() in
> arch/x86/events/core.c for the same thread being profiled:
> 
> 1. The first sample goes fine, the entire stack is traversed.
> 2. The second sample breaks at some point inside my program, with a page
> fault due to page not present.
> 3. The third sample breaks at another *earlier* point inside my program,
> with a page fault due to page not present.
> 4. The fourth sample breaks at another *later* point inside my program, with
> a page fault due to page not present.

Namhyung, Jiri: ideas? I have to stop this analysis now, will continue later.
 
> The stack frame addresses do not change throughout profiling and all page
> faults happen at __get_user(frame.next_frame, &fp->next_frame). The
> behaviour above also occurs occasionally in a single-threaded variant of the
> code (without pthread at all) with a very high sampling frequency (tens of
> thousands Hz).
> 
> This issue makes profiling results unreliable for my use case, as I usually
> profile multi-threaded applications with deep stacks with hundreds of
> entries (hence why my test program also produces a deep stack) and use flame
> graphs for later analysis.
> 
> Could you help me diagnose the problem? For example, what may be the cause
> of my page faults? I also did tests (without debugging though) without
> syscall profiling and the "--off-cpu" flag, broken stacks still appeared.
> 
> (I cannot use DWARF because it makes profiling too slow and perf.data size
> too large in my tests. I also want to avoid using
> non-portable/vendor-specific stack unwinding solutions like LBR, as we may
> need to run profiling on non-Intel CPUs.)
> 
> Best regards,
> Maks Graczyk
> 

-- 

- Arnaldo
