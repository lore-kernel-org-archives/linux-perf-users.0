Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1255218D98;
	Tue, 12 Nov 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439048; cv=none; b=MNvaEH+DaMrkCjQGYdXPVmSZ5LtddK/aeuKoItbzJoLupzkcBqo+MmlkFQaId7e6+OTTAJM+igtTWCtar+CquRH/CyR3vvWfk4wDiTnu0jKjN9ly55GeTcnW0HrbVFh/tIExEDEce7QiXx+IgtEXUEM3KGRW7aIKZCRcoyROAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439048; c=relaxed/simple;
	bh=p9g9ldYowVrzMVe9obVK9iw6SZeeneXH7DN4MDPTvz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRkUQdh0b/ZZHzbRtE+NJAAU5zfCAueW9R5/yfPGWLftvgUYU/gRRg3tYgKrElQrF966CctqOTLmFI6zsLRTlz73l+up6hwRPexlfP7PwUdbKM1LKXDQGbp8pch1bIEklpTletIdZdLXZVm6wGLCo6Ohob6N71+vQKbVBlKigE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5iutILE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5iutILE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BC0C4CED5;
	Tue, 12 Nov 2024 19:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731439044;
	bh=p9g9ldYowVrzMVe9obVK9iw6SZeeneXH7DN4MDPTvz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5iutILEy9ks7fcw4MC1dy+6IZxzX6MNB+IwQCu/pwcGYVI3wdod0XXjTEgcg2AEC
	 NBfVGghdA+2/15adVtXBjlyyl3gQGQ6JP0JkUTN5pNci+DFXP/r/9xFSQud1daV1J0
	 MZBKlQ9viyXpuCc5nkbSnwc6o1iPPbiaD8xt0eSlZ3YTFdbTwc30wgxstkD+RIhfVN
	 mH2R8rShc04tX0NaogQcS0DkaxusTFku4NsSuNfec+mA/V5FsmdAqNHzBnK3tOhF0Y
	 C231GoJ/VWRj73NR0nbCG1Vdv4NOdeN+bzibXAL5VwP9/SY147UAq3yhH44ZFFQ8Fr
	 H0mpxWw+yyg4A==
Date: Tue, 12 Nov 2024 16:17:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, namhyung@kernel.org, irogers@google.com,
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] perf record --off-cpu: Dump off-cpu samples
 directly
Message-ID: <ZzOpvzN-OTLZPyFh@x1>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
 <ZzOg3Xlq2jsG85XQ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzOg3Xlq2jsG85XQ@x1>

On Tue, Nov 12, 2024 at 03:39:25PM -0300, Arnaldo Carvalho de Melo wrote:
> ⬢ [acme@toolbox perf-tools-next]$        git am ./v7_20241108_howardchu95_perf_record_off_cpu_dump_off_cpu_samples_directly.mbx
> Applying: perf record --off-cpu: Add --off-cpu-thresh option
> Applying: perf evsel: Expose evsel__is_offcpu_event() for future use
> Applying: perf record --off-cpu: Parse off-cpu event
> Applying: perf record --off-cpu: Preparation of off-cpu BPF program
> Applying: perf record --off-cpu: Dump off-cpu samples in BPF
> error: corrupt patch at line 107
> Patch failed at 0005 perf record --off-cpu: Dump off-cpu samples in BPF
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config advice.mergeConflict false"
> ⬢ [acme@toolbox perf-tools-next]$
> 
> This is on top of:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
> 
> The message:
> 
> error: corrupt patch at line 107
> 
> Doesn't look like a clash with something that changed after you prepared
> this patch set.
> 
> If we apply the first 4:
> 
> ⬢ [acme@toolbox perf-tools-next]$        git am ./v7_20241108_howardchu95_perf_record_off_cpu_dump_off_cpu_samples_directly.mbx
> Applying: perf record --off-cpu: Add --off-cpu-thresh option
> Applying: perf evsel: Expose evsel__is_offcpu_event() for future use
> Applying: perf record --off-cpu: Parse off-cpu event
> Applying: perf record --off-cpu: Preparation of off-cpu BPF program
> ⬢ [acme@toolbox perf-tools-next]$ 
> 
> Then try to apply just the 5th patch:
> 
> ⬢ [acme@toolbox perf-tools-next]$ b4 am -P5 -ctsl --cc-trailers 20241108204137.2444151-2-howardchu95@gmail.com
> ⬢ [acme@toolbox perf-tools-next]$ patch -p1 < ./v7_20241108_howardchu95_perf_record_off_cpu_dump_off_cpu_samples_directly.mbx
> patching file tools/perf/util/bpf_skel/off_cpu.bpf.c
> patch: **** malformed patch at line 138:  
> 
> ⬢ [acme@toolbox perf-tools-next]$
> 
> You have:
> 
> @@ -209,6 +268,12 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
>         pelem->state = state;
>         pelem->stack_id = stack_id;
> 
> +       /*
> +        * If stacks are successfully collected by bpf_get_stackid(), collect them once more
> +        * in task_storage for direct off-cpu sample dumping
> +        */
> +       if (stack_id > 0 && bpf_get_stack(ctx, &pelem->stack, MAX_STACKS * sizeof(u64), BPF_F_USER_STACK)) {
> +       }
> +
>  next:
>         pelem = bpf_task_storage_get(&tstamp, next, NULL, 0);
> 
> @@ -223,11 +288,19 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
> 
> see the -209,6 +268,12? Did you edit it manually? It should be -209,6 +268,13

So, I fixed up that patch hunk, applied the patch and tried to build
perf:

  CC      /tmp/build/perf-tools-next/util/bpf_off_cpu.o
  CC      /tmp/build/perf-tools-next/util/bpf-filter.o
  CC      /tmp/build/perf-tools-next/util/bpf_lock_contention.o
  CC      /tmp/build/perf-tools-next/util/bpf_kwork.o
  CC      /tmp/build/perf-tools-next/util/bpf_kwork_top.o
  CC      /tmp/build/perf-tools-next/util/annotate-data.o
  CC      /tmp/build/perf-tools-next/util/data-convert-bt.o
  CC      /tmp/build/perf-tools-next/util/data-convert-json.o
util/bpf_off_cpu.c: In function ‘off_cpu_start’:
util/bpf_off_cpu.c:78:9: error: ‘evsel’ undeclared (first use in this function)
   78 |         evsel = evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
      |         ^~~~~
util/bpf_off_cpu.c:78:9: note: each undeclared identifier is reported only once for each function it appears in
In file included from /tmp/build/perf-tools-next/libperf/include/internal/cpumap.h:6,
                 from /tmp/build/perf-tools-next/libperf/include/internal/evsel.h:9,
                 from /home/acme/git/perf-tools-next/tools/perf/util/evsel.h:10,
                 from util/bpf_off_cpu.c:4:
util/bpf_off_cpu.c:84:42: error: ‘i’ undeclared (first use in this function)
   84 |         perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
      |                                          ^
/tmp/build/perf-tools-next/libperf/include/perf/cpumap.h:90:15: note: in definition of macro ‘perf_cpu_map__for_each_cpu’
   90 |         for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);   \
      |               ^~~
util/bpf_off_cpu.c:84:36: error: ‘pcpu’ undeclared (first use in this function)
   84 |         perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
      |                                    ^~~~
/tmp/build/perf-tools-next/libperf/include/perf/cpumap.h:90:26: note: in definition of macro ‘perf_cpu_map__for_each_cpu’
   90 |         for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);   \
      |                          ^~~
/tmp/build/perf-tools-next/libperf/include/perf/cpumap.h:90:23: error: left-hand operand of comma expression has no effect [-Werror=unused-value]
   90 |         for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);   \
      |                       ^
util/bpf_off_cpu.c:84:9: note: in expansion of macro ‘perf_cpu_map__for_each_cpu’
   84 |         perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/build/perf-tools-next/libperf/include/perf/cpumap.h:92:21: error: left-hand operand of comma expression has no effect [-Werror=unused-value]
   92 |              (idx)++, (cpu) = perf_cpu_map__cpu(cpus, idx))
      |                     ^
util/bpf_off_cpu.c:84:9: note: in expansion of macro ‘perf_cpu_map__for_each_cpu’
   84 |         perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
util/bpf_off_cpu.c:85:17: error: ‘err’ undeclared (first use in this function)
   85 |                 err = bpf_map__update_elem(skel->maps.offcpu_output, &pcpu.cpu, sizeof(__u32),
      |                 ^~~
cc1: all warnings being treated as errors
  CC      /tmp/build/perf-tools-next/util/jitdump.o
  CC      /tmp/build/perf-tools-next/util/bpf-event.o
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: /tmp/build/perf-tools-next/util/bpf_off_cpu.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:158: util] Error 2
make[2]: *** [Makefile.perf:789: /tmp/build/perf-tools-next/perf-util-in.o] Error 2
make[1]: *** [Makefile.perf:292: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbox perf-tools-next]$

I squashed the patch below and I'm trying to apply the other patches to do some
minimal testing on the feature itself, but the organization of the
patches needs some work.

- Arnaldo

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index cfe5b17393e9ed3a..531465b07952f3b7 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -61,6 +61,9 @@ static int off_cpu_config(struct evlist *evlist)
 static void off_cpu_start(void *arg)
 {
 	struct evlist *evlist = arg;
+	struct evsel *evsel;
+	struct perf_cpu pcpu;
+	int i;
 
 	/* update task filter for the given workload */
 	if (skel->rodata->has_task && skel->rodata->uses_tgid &&
@@ -82,6 +85,8 @@ static void off_cpu_start(void *arg)
 	}
 
 	perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
+		int err;
+
 		err = bpf_map__update_elem(skel->maps.offcpu_output, &pcpu.cpu, sizeof(__u32),
 					   xyarray__entry(evsel->core.fd, i, 0),
 					   sizeof(__u32), BPF_ANY);
