Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E8253B61;
	Tue, 11 Feb 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294899; cv=none; b=A/PnUN+qY59AEdKkJUce5kX1YhpBMFdmvVudROo+9DBPtFPBbD9nj1B7s88p9L5fkVm6Va+iAArnaHPlf3Uk2ifvnm3YMP/cUZAHvP3a9MJMsMLbfNJGw/Lo/WCU4g/6UZzpw1x6uEmm6BV3DKmQhfD2l0tseQAbPfZaJMs3WDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294899; c=relaxed/simple;
	bh=LD/O1EBHcgMEITUbuApU66HPZd2hSaN6Qz+lpvhgYLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHG6GxyPkEtghFaF2nhLWKG/EnLPYfrCnT1TMl28lrbIKlGL94GG1h2pGo1G8PyuD+cc8w69EE/HhLaeCcsa/EM/Y/539SaYWX4U5zeTNMGJzwmkS6BF5ethdl69QlfRpyCksH2r1torTcSZISz+qEwyFyQs0L39odRRXvMM5yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meqzADNx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meqzADNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08833C4CEDD;
	Tue, 11 Feb 2025 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739294898;
	bh=LD/O1EBHcgMEITUbuApU66HPZd2hSaN6Qz+lpvhgYLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=meqzADNxPyy8lDrn5qHUVqcRkkz99t3Vk0zXCnSBCgpLq011eZ/z/SGkvFSSCu34C
	 WbsSKgXWHsgj3xRbkQq3Q5TTPxoinT+5CkjT2v3gHoWCtWP9EoI7fOsYXMPELm7Qz3
	 nFlynvCmFqFHwzc2PKQQeoyb6J2BAByPGvl4TTbMUEa0nZyuavi6Zp8AzcV8p65CfW
	 UdGiLhenehDi4+QkNAKjyBmXgUcsQ05mKGaCAPkyp+zy2aU3W0XPGWiQxhfsUImREB
	 t5sRluJ0A5zrRkuEiiaSzwa6Jwaw+J8oejSbQTEEmzdF7TFTgDNN+AjsmF9QIllesY
	 GNXnvTKyNStxg==
Date: Tue, 11 Feb 2025 18:28:15 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v14 04/10] perf record --off-cpu: Dump off-cpu samples in
 BPF
Message-ID: <Z6uIr8cRZBllFKt4@x1>
References: <20241215181220.754822-1-howardchu95@gmail.com>
 <20241215181220.754822-5-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241215181220.754822-5-howardchu95@gmail.com>

On Sun, Dec 15, 2024 at 10:12:14AM -0800, Howard Chu wrote:
> Collect tid, period, callchain, and cgroup id and dump them when off-cpu
> time threshold is reached.
> 
> We don't collect the off-cpu time twice (the delta), it's either in
> direct samples, or accumulated samples that are dumped at the end of
> perf.data.
> 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20241108204137.2444151-6-howardchu95@gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/bpf_skel/off_cpu.bpf.c | 88 ++++++++++++++++++++++++--
>  1 file changed, 83 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> index 1cdd4d63ea92..77fdc9e81db3 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -19,11 +19,17 @@
>  #define MAX_ENTRIES  102400
>  
>  #define MAX_CPUS  4096
> +#define MAX_OFFCPU_LEN 37
> +
> +struct stack {
> +	u64 array[MAX_STACKS];
> +};

So I needed to rename the above as it fails 'make -C tools/perf
build-test', the direct make command line to hit that:

⬢ [acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/  
⬢ [acme@toolbox perf-tools-next]$ alias m='rm -rf ~/libexec/perf-core/ ; make -k GEN_VMLINUX_H=1 CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin && perf test python && cat /tmp/build/perf-tools-next/feature/test-all.output'
⬢ [acme@toolbox perf-tools-next]$ m 
  GENSKEL /tmp/build/perf-tools-next/util/bpf_skel/sample_filter.skel.h
util/bpf_skel/off_cpu.bpf.c:24:8: error: redefinition of 'stack'
   24 | struct stack {
      |        ^
/tmp/build/perf-tools-next/util/bpf_skel/.tmp/../vmlinux.h:128096:8: note: previous definition is here
 128096 | struct stack {
        |        ^
util/bpf_skel/off_cpu.bpf.c:218:42: error: no member named 'array' in 'struct stack'
  218 |         for (int i = 0; i < MAX_STACKS && from->array[i]; ++i, ++len)
      |                                           ~~~~  ^
util/bpf_skel/off_cpu.bpf.c:219:32: error: no member named 'array' in 'struct stack'
  219 |                 to->array[n + 2 + i] = from->array[i];
      |                                        ~~~~  ^
3 errors generated.
make[2]: *** [Makefile.perf:1276: /tmp/build/perf-tools-next/util/bpf_skel/.tmp/off_cpu.bpf.o] Error 1

So for now I'm adding the patch below to get it going.

IIRC there was some discussion about ditching GEN_VMLINUX_H=1, we can
remove this hack later if/when we progress on that.

- Arnaldo

diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 77fdc9e81db395d1..848a123e5610f17b 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -21,7 +21,8 @@
 #define MAX_CPUS  4096
 #define MAX_OFFCPU_LEN 37
 
-struct stack {
+// We have a 'struct stack' in vmlinux.h when building with GEN_VMLINUX_H=1
+struct __stack {
 	u64 array[MAX_STACKS];
 };
 
@@ -29,7 +30,7 @@ struct tstamp_data {
 	__u32 stack_id;
 	__u32 state;
 	__u64 timestamp;
-	struct stack stack;
+	struct __stack stack;
 };
 
 struct offcpu_key {
@@ -211,7 +212,7 @@ static inline int can_record(struct task_struct *t, int state)
 	return 1;
 }
 
-static inline int copy_stack(struct stack *from, struct offcpu_data *to, int n)
+static inline int copy_stack(struct __stack *from, struct offcpu_data *to, int n)
 {
 	int len = 0;
 
@@ -231,7 +232,7 @@ static inline int copy_stack(struct stack *from, struct offcpu_data *to, int n)
  * information of the task, and dump it as a raw sample to perf ring buffer
  */
 static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct offcpu_key *key,
-			struct stack *stack, __u64 delta)
+			struct __stack *stack, __u64 delta)
 {
 	int n = 0, len = 0;
 
  
>  struct tstamp_data {
>  	__u32 stack_id;
>  	__u32 state;
>  	__u64 timestamp;
> +	struct stack stack;
>  };
>  
>  struct offcpu_key {
> @@ -41,6 +47,10 @@ struct {
>  	__uint(max_entries, MAX_ENTRIES);
>  } stacks SEC(".maps");
>  
> +struct offcpu_data {
> +	u64 array[MAX_OFFCPU_LEN];
> +};
> +
>  struct {
>  	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>  	__uint(key_size, sizeof(__u32));
> @@ -48,6 +58,13 @@ struct {
>  	__uint(max_entries, MAX_CPUS);
>  } offcpu_output SEC(".maps");
>  
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(struct offcpu_data));
> +	__uint(max_entries, 1);
> +} offcpu_payload SEC(".maps");
> +
>  struct {
>  	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
>  	__uint(map_flags, BPF_F_NO_PREALLOC);
> @@ -106,6 +123,8 @@ const volatile bool uses_cgroup_v1 = false;
>  
>  int perf_subsys_id = -1;
>  
> +__u64 offcpu_thresh_ns = 500000000ull;
> +
>  /*
>   * Old kernel used to call it task_struct->state and now it's '__state'.
>   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> @@ -192,6 +211,47 @@ static inline int can_record(struct task_struct *t, int state)
>  	return 1;
>  }
>  
> +static inline int copy_stack(struct stack *from, struct offcpu_data *to, int n)
> +{
> +	int len = 0;
> +
> +	for (int i = 0; i < MAX_STACKS && from->array[i]; ++i, ++len)
> +		to->array[n + 2 + i] = from->array[i];
> +
> +	return len;
> +}
> +
> +/**
> + * off_cpu_dump - dump off-cpu samples to ring buffer
> + * @data: payload for dumping off-cpu samples
> + * @key: off-cpu data
> + * @stack: stack trace of the task before being scheduled out
> + *
> + * If the threshold of off-cpu time is reached, acquire tid, period, callchain, and cgroup id
> + * information of the task, and dump it as a raw sample to perf ring buffer
> + */
> +static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct offcpu_key *key,
> +			struct stack *stack, __u64 delta)
> +{
> +	int n = 0, len = 0;
> +
> +	data->array[n++] = (u64)key->tgid << 32 | key->pid;
> +	data->array[n++] = delta;
> +
> +	/* data->array[n] is callchain->nr (updated later) */
> +	data->array[n + 1] = PERF_CONTEXT_USER;
> +	data->array[n + 2] = 0;
> +	len = copy_stack(stack, data, n);
> +
> +	/* update length of callchain */
> +	data->array[n] = len + 1;
> +	n += len + 2;
> +
> +	data->array[n++] = key->cgroup_id;
> +
> +	return bpf_perf_event_output(ctx, &offcpu_output, BPF_F_CURRENT_CPU, data, n * sizeof(u64));
> +}
> +
>  static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
>  			struct task_struct *next, int state)
>  {
> @@ -216,6 +276,16 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
>  	pelem->state = state;
>  	pelem->stack_id = stack_id;
>  
> +	/*
> +	 * If stacks are successfully collected by bpf_get_stackid(), collect them once more
> +	 * in task_storage for direct off-cpu sample dumping
> +	 */
> +	if (stack_id > 0 && bpf_get_stack(ctx, &pelem->stack, MAX_STACKS * sizeof(u64), BPF_F_USER_STACK)) {
> +		/*
> +		 * This empty if block is used to avoid 'result unused warning' from bpf_get_stack().
> +		 * If the collection fails, continue with the logic for the next task.
> +		 */
> +	}
>  next:
>  	pelem = bpf_task_storage_get(&tstamp, next, NULL, 0);
>  
> @@ -230,11 +300,19 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
>  		__u64 delta = ts - pelem->timestamp;
>  		__u64 *total;
>  
> -		total = bpf_map_lookup_elem(&off_cpu, &key);
> -		if (total)
> -			*total += delta;
> -		else
> -			bpf_map_update_elem(&off_cpu, &key, &delta, BPF_ANY);
> +		if (delta >= offcpu_thresh_ns) {
> +			int zero = 0;
> +			struct offcpu_data *data = bpf_map_lookup_elem(&offcpu_payload, &zero);
> +
> +			if (data)
> +				off_cpu_dump(ctx, data, &key, &pelem->stack, delta);
> +		} else {
> +			total = bpf_map_lookup_elem(&off_cpu, &key);
> +			if (total)
> +				*total += delta;
> +			else
> +				bpf_map_update_elem(&off_cpu, &key, &delta, BPF_ANY);
> +		}
>  
>  		/* prevent to reuse the timestamp later */
>  		pelem->timestamp = 0;
> -- 
> 2.43.0
