Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFCE409128;
	Mon, 15 Jun 2026 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545486; cv=none; b=XdjAsCp4hVaSR0WE2bjTmdYR+W+HN7yVzmBVfCPH1/kN2rn1CVr9y4cSpoXeJXznp8imPOdCN6IxMbESI3kGsgeeBratXD5k7hvYK7RHz9I1l9aA0kEbQHO1ehBAp02Wa0gCAjekt0DIckFpXFK9/4Zj/uJMjGJpFfbpoSp0zyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545486; c=relaxed/simple;
	bh=Mwcs3nctOLhqachusX/alsD/dc95WVdCLhzHZIXXypo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOIw/OgJYQwGy8TZDwNpafPKyi27dbvlRUh8dvUf0mjA2nFX9gGwup6Um69wDSRkbdqJ5raQu0PL9mhsk9y6zx1a9k5A+6RCJGwyAQ/+aJDoqpBp7/b46eFrmvPlnf/HKt6n/baCQ/xS0mxu+tEG461otVnY/etOYs6ZKQN8wsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IY5HFcw3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IY5HFcw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B881F000E9;
	Mon, 15 Jun 2026 17:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781545484;
	bh=qFmB7Nl/it9xvGJb9ids0/h9Y5s2+KQlDw9sSBEtC98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IY5HFcw3brZovDUBE4imWTq2HEneNsR6CPO3+ecbmFU5+Pjo0yOwZgvmFVstDD944
	 Fnn/B057Qjp9GxhAoIjvhNoR4FD+Ff1YpyqtpMFVmI/mJjPjIIS/z+ReEFS7s9lteO
	 w5dO4ArgP2k7oNZs0esND/MtUvy5pKlrLH1riXn69jNgjst6nChcFbMYjylRqaZkwW
	 532mC2EeB6RygpqUndMNGE2pgslMNyz8y56floaCfEjO8bzPeWGMPk9vPH2bN94AT6
	 IFmLsX0C4IVsg6ZrfK7chZNuXbk3eemIj8dz+fuLg4+enrMPdtDTfVYcdL8j+BeaXp
	 kKDutxvoxtq1w==
Date: Mon, 15 Jun 2026 14:44:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: james.clark@linaro.org, namhyung@kernel.org, adrian.hunter@intel.com,
	gmx@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH v20 3/5] perf inject/aslr: Implement sample address
 remapping
Message-ID: <ajA6CHlLrRGO50Ts@x1>
References: <20260608054841.3856224-1-irogers@google.com>
 <20260611164122.3974068-1-irogers@google.com>
 <20260611164122.3974068-4-irogers@google.com>
 <ai_sesDicE7R7fm5@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ai_sesDicE7R7fm5@x1>

On Mon, Jun 15, 2026 at 09:13:46AM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 11, 2026 at 09:41:20AM -0700, Ian Rogers wrote:
> > diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c

> > +	key.machine = maps__machine(thread__maps(aslr_thread));
> > +	key.dso = map__dso(al.map);
> > +	key.invariant = map__start(al.map) - map__pgoff(al.map);
> > +	key.pid = (effective_cpumode == PERF_RECORD_MISC_KERNEL ||
> > +		   effective_cpumode == PERF_RECORD_MISC_GUEST_KERNEL) ?
> > +		  kernel_pid : thread__pid(aslr_thread);
> > +
> > +	if (hashmap__find(&aslr->remap_addresses, &key, &remapped_invariant_ptr)) {
> > +		remap_addr = *remapped_invariant_ptr + map__pgoff(al.map) +
> > +			     (addr - map__start(al.map));
> > +	} else {
> > +		pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
> > +			 addr, map__start(al.map), map__size(al.map), key.pid);

Had to apply this:

diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index 3cb3d4951c7e8ab5..d0760ca8926da74d 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -159,7 +159,7 @@ static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
 		remap_addr = *remapped_invariant_ptr + map__pgoff(al.map) +
 			     (addr - map__start(al.map));
 	} else {
-		pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
+		pr_debug("Cannot find a remapped entry for address %" PRIx64 " in mapping %" PRIx64 "(%zu) for pid=%d\n",
 			 addr, map__start(al.map), map__size(al.map), key.pid);
 	}
 
To address this on 32-bit:

   3    17.06 almalinux:9-i386              : FAIL gcc version 11.5.0 20240719 (Red Hat 11.5.0-14) (GCC) 
    util/aslr.c: In function ‘aslr_tool__remap_address’:
    util/aslr.c:193:26: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘u64’ {aka ‘long long unsigned int’} [-Werror=format=]
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    util/debug.h:20:21: note: in definition of macro ‘pr_fmt’
       20 | #define pr_fmt(fmt) fmt
          |                     ^~~
    util/aslr.c:193:17: note: in expansion of macro ‘pr_debug’
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                 ^~~~~~~~
    util/aslr.c:193:70: note: format string is defined here
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                                                                    ~~^
          |                                                                      |
          |                                                                      long unsigned int
          |                                                                    %llx
    In file included from util/aslr.c:5:
    util/aslr.c:193:26: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘u64’ {aka ‘long long unsigned int’} [-Werror=format=]
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    util/debug.h:20:21: note: in definition of macro ‘pr_fmt’
       20 | #define pr_fmt(fmt) fmt
          |                     ^~~
    util/aslr.c:193:17: note: in expansion of macro ‘pr_debug’
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                 ^~~~~~~~
    util/aslr.c:193:85: note: format string is defined here
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                                                                                   ~~^
          |                                                                                     |
          |                                                                                     long unsigned int
          |                                                                                   %llx
    In file included from util/aslr.c:5:
    util/aslr.c:193:26: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 6 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    util/debug.h:20:21: note: in definition of macro ‘pr_fmt’
       20 | #define pr_fmt(fmt) fmt
          |                     ^~~
    util/aslr.c:193:17: note: in expansion of macro ‘pr_debug’
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                 ^~~~~~~~
    util/aslr.c:193:89: note: format string is defined here
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                                                                                       ~~^
          |                                                                                         |
          |                                                                                         long unsigned int
          |                                                                                       %x
    cc1: all warnings being treated as errors
      LD      /tmp/build/perf/util/dwarf-regs-arch/perf-util-in.o
      CC      /tmp/build/perf/util/block-range.o
      CC      /tmp/build/perf/builtin-kwork.o
      CC      /tmp/build/perf/util/build-id.o
    In file included from util/aslr.c:5:
    util/aslr.c: In function ‘aslr_tool__remap_address’:
    util/aslr.c:193:26: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘u64’ {aka ‘long long unsigned int’} [-Werror=format=]
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    util/debug.h:20:21: note: in definition of macro ‘pr_fmt’
       20 | #define pr_fmt(fmt) fmt
          |                     ^~~
    util/aslr.c:193:17: note: in expansion of macro ‘pr_debug’
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                 ^~~~~~~~
    --
          |                                                                    ~~^
          |                                                                      |
          |                                                                      long unsigned int
          |                                                                    %llx
    In file included from util/aslr.c:5:
    util/aslr.c:193:26: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘u64’ {aka ‘long long unsigned int’} [-Werror=format=]
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    util/debug.h:20:21: note: in definition of macro ‘pr_fmt’
       20 | #define pr_fmt(fmt) fmt
          |                     ^~~
    util/aslr.c:193:17: note: in expansion of macro ‘pr_debug’
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                 ^~~~~~~~
    util/aslr.c:193:85: note: format string is defined here
    --
          |                                                                                   ~~^
          |                                                                                     |
          |                                                                                     long unsigned int
          |                                                                                   %llx
    In file included from util/aslr.c:5:
    util/aslr.c:193:26: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 6 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    util/debug.h:20:21: note: in definition of macro ‘pr_fmt’
       20 | #define pr_fmt(fmt) fmt
          |                     ^~~
    util/aslr.c:193:17: note: in expansion of macro ‘pr_debug’
      193 |                 pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(%lx) for pid=%d\n",
          |                 ^~~~~~~~
    util/aslr.c:193:89: note: format string is defined here

- Arnaldo

> > +	}
> > +
> > +	addr_location__exit(&al);
> > +	return remap_addr;
> > +}
> > +
> >  struct aslr_machine_priv {
> >  	bool kernel_maps_loaded;
> >  };
> > @@ -616,13 +671,415 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
> >  				     struct perf_sample *sample,
> >  				     struct machine *machine)
> >  {
> > -	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
> > -	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
> > -	struct perf_tool *delegate = aslr->tool.delegate;
> > +	struct evsel *evsel = sample->evsel;
> > +	struct delegate_tool *del_tool;
> > +	struct aslr_tool *aslr;
> > +	struct perf_tool *delegate;
> > +	int ret;
> > +	u64 sample_type;
> > +	struct thread *thread;
> > +	struct machine *aslr_machine;
> > +	__u64 max_i;
> > +	__u64 max_j;
> > +	union perf_event *new_event;
> > +	struct perf_sample new_sample;
> > +	__u64 *in_array, *out_array;
> > +	u8 cpumode;
> > +	u64 addr;
> > +	size_t i;
> > +	size_t j;
> 
> The following 4 variables are not used in this patch, so the build at
> this point fails:
> 
> > +	struct aslr_evsel_priv *priv = NULL;
> > +	u64 orig_sample_type;
> > +	u64 orig_regs_user;
> > +	u64 orig_regs_intr;
> 
> 
> With:
> 
>   CC      /tmp/build/perf-tools-next/util/bpf_lock_contention.o
> util/aslr.c: In function ‘aslr_tool__process_sample’:
> util/aslr.c:694:13: error: unused variable ‘orig_regs_intr’ [-Werror=unused-variable]
>   694 |         u64 orig_regs_intr;
>       |             ^~~~~~~~~~~~~~
> util/aslr.c:693:13: error: unused variable ‘orig_regs_user’ [-Werror=unused-variable]
>   693 |         u64 orig_regs_user;
>       |             ^~~~~~~~~~~~~~
> util/aslr.c:692:13: error: unused variable ‘orig_sample_type’ [-Werror=unused-variable]
>   692 |         u64 orig_sample_type;
>       |             ^~~~~~~~~~~~~~~~
> util/aslr.c:691:33: error: unused variable ‘priv’ [-Werror=unused-variable]
>   691 |         struct aslr_evsel_priv *priv = NULL;
>       |                                 ^~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:95: /tmp/build/perf-tools-next/util/aslr.o] Error 1
> 
> So I moved it to the next patch, where they start to be used.
> 
> > +	del_tool = container_of(tool, struct delegate_tool, tool);
> > +	aslr = container_of(del_tool, struct aslr_tool, tool);
> > +	delegate = aslr->tool.delegate;
> > +
> 
> I also removed these extra blank lines and collected James Tested-by.
> 
> Thanks, applied to perf-tools-next, for v7.2.
> 
> - Arnaldo
> 
> > +
> > +
> > +	if (evsel__is_dummy_event(evsel))
> > +		return delegate->sample(delegate, event, sample, machine);
> > +
> > +	ret = -EFAULT;
> > +	sample_type = evsel->core.attr.sample_type;
> > +	max_i = (event->header.size - sizeof(struct perf_event_header)) / sizeof(__u64);
> > +	max_j = (PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_event_header)) / sizeof(__u64);
> > +	new_event = (union perf_event *)aslr->event_copy;
> > +	cpumode = sample->cpumode;
> > +	i = 0;
> > +	j = 0;
> > +
> > +	aslr_machine = machines__findnew(&aslr->machines, machine->pid);
> > +	if (!aslr_machine)
> > +		return -ENOMEM;
> > +	if (aslr_tool__preload_kernel_maps(aslr_machine) < 0)
> > +		return -ENOMEM;
> > +
> > +	thread = machine__findnew_thread(aslr_machine, sample->pid, sample->tid);
> > +
> > +	if (!thread)
> > +		return -ENOMEM;
> > +
> > +	if (max_i > PERF_SAMPLE_MAX_SIZE / sizeof(u64))
> > +		goto out_put;
> > +
> > +	new_event->sample.header = event->sample.header;
> > +
> > +	in_array = &event->sample.array[0];
> > +	out_array = &new_event->sample.array[0];
> > +
> > +#define CHECK_BOUNDS(required_i, required_j) \
> > +	(i + (required_i) > max_i || j + (required_j) > max_j)
> > +
> > +#define COPY_U64() \
> > +	do { \
> > +		if (CHECK_BOUNDS(1, 1)) { \
> > +			ret = -EFAULT; \
> > +			goto out_put; \
> > +		} \
> > +		out_array[j++] = in_array[i++]; \
> > +	} while (0)
> > +
> > +#define REMAP_U64(addr_field) \
> > +	do { \
> > +		u64 remapped; \
> > +		if (CHECK_BOUNDS(1, 1)) { \
> > +			ret = -EFAULT; \
> > +			goto out_put; \
> > +		} \
> > +		remapped = aslr_tool__remap_address(aslr, thread, cpumode, addr_field); \
> > +		out_array[j++] = remapped; \
> > +		i++; \
> > +	} while (0)
> > +
> > +	if (sample_type & PERF_SAMPLE_IDENTIFIER)
> > +		COPY_U64(); /* id */
> > +	if (sample_type & PERF_SAMPLE_IP)
> > +		REMAP_U64(sample->ip);
> > +	if (sample_type & PERF_SAMPLE_TID) {
> > +		union {
> > +			u64 val64;
> > +			u32 val32[2];
> > +		} u;
> > +
> > +		if (CHECK_BOUNDS(1, 1)) {
> > +			ret = -EFAULT;
> > +			goto out_put;
> > +		}
> > +		u.val32[0] = sample->pid;
> > +		u.val32[1] = sample->tid;
> > +		out_array[j++] = u.val64;
> > +		i++;
> > +	}
> > +	if (sample_type & PERF_SAMPLE_TIME)
> > +		COPY_U64(); /* time */
> > +	if (sample_type & PERF_SAMPLE_ADDR)
> > +		REMAP_U64(sample->addr);
> > +	if (sample_type & PERF_SAMPLE_ID)
> > +		COPY_U64(); /* id */
> > +	if (sample_type & PERF_SAMPLE_STREAM_ID)
> > +		COPY_U64(); /* stream_id */
> > +	if (sample_type & PERF_SAMPLE_CPU)
> > +		COPY_U64(); /* cpu, res */
> > +	if (sample_type & PERF_SAMPLE_PERIOD)
> > +		COPY_U64(); /* period */
> > +	if (sample_type & PERF_SAMPLE_READ) {
> > +		if ((evsel->core.attr.read_format & PERF_FORMAT_GROUP) == 0) {
> > +			COPY_U64(); /* value */
> > +			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
> > +				COPY_U64(); /* time_enabled */
> > +			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
> > +				COPY_U64(); /* time_running */
> > +			if (evsel->core.attr.read_format & PERF_FORMAT_ID)
> > +				COPY_U64(); /* id */
> > +			if (evsel->core.attr.read_format & PERF_FORMAT_LOST)
> > +				COPY_U64(); /* lost */
> > +		} else {
> > +			u64 nr;
> > +
> > +			if (CHECK_BOUNDS(1, 1)) {
> > +				ret = -EFAULT;
> > +				goto out_put;
> > +			}
> > +			nr = in_array[i];
> > +			COPY_U64();
> > +			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
> > +				COPY_U64(); /* time_enabled */
> > +			if (evsel->core.attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
> > +				COPY_U64(); /* time_running */
> > +			for (u64 cntr = 0; cntr < nr; cntr++) {
> > +				COPY_U64(); /* value */
> > +				if (evsel->core.attr.read_format & PERF_FORMAT_ID)
> > +					COPY_U64(); /* id */
> > +				if (evsel->core.attr.read_format & PERF_FORMAT_LOST)
> > +					COPY_U64(); /* lost */
> > +			}
> > +		}
> > +	}
> > +	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
> > +		u64 nr;
> > +
> > +		if (CHECK_BOUNDS(1, 1)) {
> > +			ret = -EFAULT;
> > +			goto out_put;
> > +		}
> > +		nr = in_array[i];
> > +		COPY_U64();
> > +
> > +		for (u64 cntr = 0; cntr < nr; cntr++) {
> > +			if (CHECK_BOUNDS(1, 1)) {
> > +				ret = -EFAULT;
> > +				goto out_put;
> > +			}
> > +			addr = in_array[i++];
> > +			if (addr >= PERF_CONTEXT_MAX) {
> > +				out_array[j++] = addr;
> > +				switch (addr) {
> > +				case PERF_CONTEXT_HV:
> > +					cpumode = PERF_RECORD_MISC_HYPERVISOR;
> > +					break;
> > +				case PERF_CONTEXT_KERNEL:
> > +					cpumode = PERF_RECORD_MISC_KERNEL;
> > +					break;
> > +				case PERF_CONTEXT_USER:
> > +					cpumode = PERF_RECORD_MISC_USER;
> > +					break;
> > +				case PERF_CONTEXT_GUEST:
> > +					cpumode = PERF_RECORD_MISC_GUEST_KERNEL;
> > +					break;
> > +				case PERF_CONTEXT_GUEST_KERNEL:
> > +					cpumode = PERF_RECORD_MISC_GUEST_KERNEL;
> > +					break;
> > +				case PERF_CONTEXT_GUEST_USER:
> > +					cpumode = PERF_RECORD_MISC_GUEST_USER;
> > +					break;
> > +				case PERF_CONTEXT_USER_DEFERRED:
> > +					if (cntr + 1 >= nr) {
> > +						pr_debug("Truncated callchain deferred cookie context\n");
> > +						ret = 0;
> > +						goto out_put;
> > +					}
> > +					/*
> > +					 * Immediately followed by a 64-bit
> > +					 * stitching cookie. Skip/Copy it!
> > +					 */
> > +					if (CHECK_BOUNDS(1, 1)) {
> > +						ret = -EFAULT;
> > +						goto out_put;
> > +					}
> > +					out_array[j++] = in_array[i++];
> > +					cntr++;
> > +					cpumode = PERF_RECORD_MISC_USER;
> > +					break;
> > +				default:
> > +					pr_debug("invalid callchain context: %"PRIx64"\n", addr);
> > +					ret = 0;
> > +					goto out_put;
> > +				}
> > +				continue;
> > +			}
> > +			addr = aslr_tool__remap_address(aslr, thread, cpumode, addr);
> > +			out_array[j++] = addr;
> > +		}
> > +	}
> > +	if (sample_type & PERF_SAMPLE_RAW) {
> > +		size_t bytes = sizeof(u32) + sample->raw_size;
> > +		size_t u64_words = (bytes + 7) / 8;
> > +
> > +		if (i + u64_words > max_i || j + u64_words > max_j) {
> > +			ret = -EFAULT;
> > +			goto out_put;
> > +		}
> > +		memcpy(&out_array[j], &in_array[i], bytes);
> > +		i += u64_words;
> > +		j += u64_words;
> > +		/*
> > +		 * TODO: certain raw samples can be remapped, such as
> > +		 * tracepoints by examining their fields.
> > +		 */
> > +		pr_debug("Dropping raw samples as possible ASLR leak\n");
> > +		ret = 0;
> > +		goto out_put;
> > +	}
> > +	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> > +		u64 nr;
> > +
> > +		if (CHECK_BOUNDS(1, 1)) {
> > +			ret = -EFAULT;
> > +			goto out_put;
> > +		}
> > +		nr = in_array[i];
> > +		COPY_U64();
> > +
> > +		if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)
> > +			COPY_U64(); /* hw_idx */
> > +
> > +		if (nr > (ULLONG_MAX / 3)) {
> > +			ret = -EFAULT;
> > +			goto out_put;
> > +		}
> > +		if (nr * 3 > max_i - i || nr * 3 > max_j - j) {
> > +			ret = -EFAULT;
> > +			goto out_put;
> > +		}
> > +		for (u64 cntr = 0; cntr < nr; cntr++) {
> > +			u64 from = in_array[i++];
> > +			u64 to = in_array[i++];
> > +
> > +			from = aslr_tool__remap_address(aslr, thread, sample->cpumode, from);
> > +			to = aslr_tool__remap_address(aslr, thread, sample->cpumode, to);
> > +
> > +			out_array[j++] = from;
> > +			out_array[j++] = to;
> > +			out_array[j++] = in_array[i++]; /* flags */
> > +		}
> > +		if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS) {
> > +			if (nr > max_i - i || nr > max_j - j) {
> > +				ret = -EFAULT;
> > +				goto out_put;
> > +			}
> > +			for (u64 cntr = 0; cntr < nr; cntr++)
> > +				COPY_U64();
> > +		}
> > +	}
> > +	if (sample_type & PERF_SAMPLE_REGS_USER) {
> > +		if (CHECK_BOUNDS(1, 0)) {
> > +			ret = -EFAULT;
> > +			goto out_put;
> > +		}
> > +		/* abi */
> > +		COPY_U64();
> > +		/* TODO: can this be less conservative? */
> > +		pr_debug("Dropping regs user sample as possible ASLR leak\n");
> > +		ret = 0;
> > +		goto out_put;
> > +	}
> > +	if (sample_type & PERF_SAMPLE_STACK_USER) {
> > +		u64 size;
> >  
> > -	return delegate->sample(delegate, event, sample, machine);
> > +		if (CHECK_BOUNDS(1, 1)) {
> > +			ret = -EFAULT;
> > +			goto out_put;
> > +		}
> > +		size = in_array[i];
> > +		COPY_U64();
> > +		if (size > 0) {
> > +			size_t u64_words = size / 8 + (size % 8 ? 1 : 0);
> > +
> > +			if (u64_words > max_i - i || u64_words > max_j - j) {
> > +				ret = -EFAULT;
> > +				goto out_put;
> > +			}
> > +			memcpy(&out_array[j], &in_array[i], size);
> > +			if (size % 8) {
> > +				size_t pad = 8 - (size % 8);
> > +
> > +				memset(((char *)&out_array[j]) + size, 0, pad);
> > +			}
> > +			i += u64_words;
> > +			j += u64_words;
> > +		}
> > +		/* TODO: can this be less conservative? */
> > +		pr_debug("Dropping stack user sample as possible ASLR leak\n");
> > +		ret = 0;
> > +		goto out_put;
> > +	}
> > +	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
> > +		COPY_U64(); /* perf_sample_weight */
> > +	if (sample_type & PERF_SAMPLE_DATA_SRC)
> > +		COPY_U64(); /* data_src */
> > +	if (sample_type & PERF_SAMPLE_TRANSACTION)
> > +		COPY_U64(); /* transaction */
> > +	if (sample_type & PERF_SAMPLE_REGS_INTR) {
> > +		if (CHECK_BOUNDS(1, 0)) {
> > +			ret = -EFAULT;
> > +			goto out_put;
> > +		}
> > +		/* abi */
> > +		COPY_U64();
> > +		/* TODO: can this be less conservative? */
> > +		pr_debug("Dropping interrupt register sample as possible ASLR leak\n");
> > +		ret = 0;
> > +		goto out_put;
> > +	}
> > +	if (sample_type & PERF_SAMPLE_PHYS_ADDR) {
> > +		COPY_U64(); /* phys_addr */
> > +		/* TODO: can this be less conservative? */
> > +		pr_debug("Dropping physical address sample as possible ASLR leak\n");
> > +		ret = 0;
> > +		goto out_put;
> > +	}
> > +	if (sample_type & PERF_SAMPLE_CGROUP)
> > +		COPY_U64(); /* cgroup */
> > +	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
> > +		COPY_U64(); /* data_page_size */
> > +	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
> > +		COPY_U64(); /* code_page_size */
> > +
> > +	if (sample_type & PERF_SAMPLE_AUX) {
> > +		u64 size;
> > +
> > +		if (CHECK_BOUNDS(1, 1)) {
> > +			ret = -EFAULT;
> > +			goto out_put;
> > +		}
> > +		out_array[j] = in_array[i];
> > +		size = out_array[j++];
> > +		i++;
> > +		if (size > 0) {
> > +			size_t u64_words = size / 8 + (size % 8 ? 1 : 0);
> > +
> > +			if (u64_words > max_i - i || u64_words > max_j - j) {
> > +				ret = -EFAULT;
> > +				goto out_put;
> > +			}
> > +			memcpy(&out_array[j], &in_array[i], size);
> > +			if (size % 8) {
> > +				size_t pad = 8 - (size % 8);
> > +
> > +				memset(((char *)&out_array[j]) + size, 0, pad);
> > +			}
> > +			i += u64_words;
> > +			j += u64_words;
> > +		}
> > +		/* TODO: can this be less conservative? */
> > +		pr_debug("Dropping aux sample as possible ASLR leak\n");
> > +		ret = 0;
> > +		goto out_put;
> > +	}
> > +
> > +	if (evsel__is_offcpu_event(evsel)) {
> > +		/* TODO: can this be less conservative? */
> > +		pr_debug("Dropping off-CPU sample as possible ASLR leak\n");
> > +		ret = 0;
> > +		goto out_put;
> > +	}
> > +
> > +	new_event->sample.header.size = sizeof(struct perf_event_header) + j * sizeof(u64);
> > +
> > +	perf_sample__init(&new_sample, /*all=*/ true);
> > +	ret = __evsel__parse_sample(evsel, new_event, &new_sample, /*needs_swap=*/false);
> > +
> > +	if (ret) {
> > +		perf_sample__exit(&new_sample);
> > +		goto out_put;
> > +	}
> > +
> > +	new_sample.evsel = evsel;
> > +	ret = delegate->sample(delegate, new_event, &new_sample, machine);
> > +	perf_sample__exit(&new_sample);
> > +
> > +out_put:
> > +	thread__put(thread);
> > +	return ret;
> >  }
> >  
> > +#undef CHECK_BOUNDS
> > +#undef COPY_U64
> > +#undef REMAP_U64
> > +
> >  static int skipn(int fd, off_t n)
> >  {
> >  	char buf[4096];
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 34c03f47a913..05fa0010c858 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -3337,11 +3337,11 @@ static int __set_offcpu_sample(struct perf_sample *data)
> >  	return -EFAULT;
> >  }
> >  
> > -int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> > -			struct perf_sample *data)
> > +int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> > +			  struct perf_sample *data, bool needs_swap)
> >  {
> >  	u64 type = evsel->core.attr.sample_type;
> > -	bool swapped = evsel->needs_swap;
> > +	bool swapped = needs_swap;
> >  	const __u64 *array;
> >  	u16 max_size = event->header.size;
> >  	const void *endp = (void *)event + max_size;
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 8178858d168a..8009be22cc3f 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -432,8 +432,14 @@ static inline int evsel__read_on_cpu_scaled(struct evsel *evsel, int cpu_map_idx
> >  	return __evsel__read_on_cpu(evsel, cpu_map_idx, thread, true);
> >  }
> >  
> > -int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> > -			struct perf_sample *sample);
> > +int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> > +			  struct perf_sample *data, bool needs_swap);
> > +
> > +static inline int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> > +				      struct perf_sample *data)
> > +{
> > +	return __evsel__parse_sample(evsel, event, data, evsel->needs_swap);
> > +}
> >  
> >  int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
> >  				  u64 *timestamp);
> > -- 
> > 2.54.0.1099.g489fc7bff1-goog
