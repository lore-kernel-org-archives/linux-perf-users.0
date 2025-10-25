Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9BC234973;
	Sat, 25 Oct 2025 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761413835; cv=none; b=G6KbgAUNLDINCOOiu6s03xgTBQ1SDncXj7aqK44Wj1vbXAOhNyXk6aDGf3qGWCsyJzICv0amI6mqeUXQVn56dqXgaSCXVFuonDDYwqUN1HQQV3AmNkVo4+i8s6QyR3r1km410LqlWUQj8BoXuXoa2zuAvJoQjBxazM6K5F3+etQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761413835; c=relaxed/simple;
	bh=7EdRUE81q033NV5pKSbKWu4bjVyZP3tN029xWrwmh8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lflnsJ8d6WZzThe26Xu4A6eNXWa0Kmv6sL2LE6SXSWXnQEEqZ361vaa6uZ0auCalo6hvShsQr0m5ZDCSPtWHxpyKzsAiFb4NvU1Iownu7NOlzWlSJm9l2NeZ/IWkjUidF7NKs/BTowDuTfIVY6KMpKAby5GklfHcuAROwVV1o+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V11DYpDH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V11DYpDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5150C4CEF5;
	Sat, 25 Oct 2025 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761413835;
	bh=7EdRUE81q033NV5pKSbKWu4bjVyZP3tN029xWrwmh8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V11DYpDHuPNPvaG4f3/EEvvZ3AlL6W7EHpgbJc5MDTCbgSmDJ84OBTGnmxWuoqFiV
	 NgqYhnJVWObH5Z3VXI8yRSrcmO0SWOMr4X+8YfAXc3EwXucUfvWgjcqNh+y2cw2PZf
	 6S2Ve3jQCOJZUuU2yEepSLUw22EoSE035D/OY6qbQeV81LCNWWjccKxVoS4ZkmDMky
	 SpDFb5KAM30T8aE9FylYMKXtE4wLR6LCzEOJsPbtaahf76/yQNQOJGoy/aHFNJObFF
	 At6Vnq/UgMRPSwrrbg/JRrUIXYI5Dqu8QSGreepiRq7HuXzQ2tjJ2KbkFjW94zTLhD
	 7RPtVZTpBLodA==
Date: Sat, 25 Oct 2025 10:37:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf stat: Add/fix bperf cgroup max events workarounds
Message-ID: <aP0KyW5MmTL3yTtu@google.com>
References: <20251025165019.1109315-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251025165019.1109315-1-irogers@google.com>

Hi Ian,

On Sat, Oct 25, 2025 at 09:50:19AM -0700, Ian Rogers wrote:
> Commit b8308511f6e0 bumped the max events to 1024 but this results in
> BPF verifier issues if the number of command line events is too
> large. Workaround this by:
> 
> 1) moving the constants to a header file to share between BPF and perf
>    C code,
> 2) testing that the maximum number of events doesn't cause BPF
>    verifier issues in debug builds,
> 3) lower the max events from 1024 to 128,
> 4) in perf stat, if there are more events than the BPF counters can
>    support then disable BPF counter usage.
> 
> The rodata setup is factored into its own function to avoid
> duplicating it in the testing code.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Fixes: b8308511f6e0 ("perf stat bperf cgroup: Increase MAX_EVENTS from 32 to 1024")
> ---
> v2: Add missing header file
> ---
>  tools/perf/builtin-stat.c                   | 13 +++-
>  tools/perf/util/bpf_counter_cgroup.c        | 79 +++++++++++++++------
>  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 18 +++--
>  tools/perf/util/bpf_skel/bperf_cgroup.h     | 15 ++++
>  4 files changed, 91 insertions(+), 34 deletions(-)
>  create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.h
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 3c3188a57016..130515f87ee0 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -96,6 +96,10 @@
>  #include <perf/evlist.h>
>  #include <internal/threadmap.h>
>  
> +#ifdef HAVE_BPF_SKEL
> +#include "util/bpf_skel/bperf_cgroup.h"
> +#endif
> +
>  #define DEFAULT_SEPARATOR	" "
>  #define FREEZE_ON_SMI_PATH	"bus/event_source/devices/cpu/freeze_on_smi"
>  
> @@ -2852,7 +2856,14 @@ int cmd_stat(int argc, const char **argv)
>  			goto out;
>  		}
>  	}
> -
> +#ifdef HAVE_BPF_SKEL
> +	if (target.use_bpf &&
> +	    (evsel_list->core.nr_entries / nr_cgroups) > BPERF_CGROUP__MAX_EVENTS) {

I guess you also need to check if nr_cgroups is not zero.  Otherwise
looks good to me.

Thanks,
Namhyung

> +		pr_warning("Disabling BPF counters due to more events (%d) than the max (%d)\n",
> +			   evsel_list->core.nr_entries / nr_cgroups, BPERF_CGROUP__MAX_EVENTS);
> +		target.use_bpf = false;
> +	}
> +#endif // HAVE_BPF_SKEL
>  	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
>  
>  	evlist__for_each_entry(evsel_list, counter) {
> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> index 690be3ce3e11..68bd994c8880 100644
> --- a/tools/perf/util/bpf_counter_cgroup.c
> +++ b/tools/perf/util/bpf_counter_cgroup.c
> @@ -27,6 +27,7 @@
>  #include "cpumap.h"
>  #include "thread_map.h"
>  
> +#include "bpf_skel/bperf_cgroup.h"
>  #include "bpf_skel/bperf_cgroup.skel.h"
>  
>  static struct perf_event_attr cgrp_switch_attr = {
> @@ -42,6 +43,55 @@ static struct bperf_cgroup_bpf *skel;
>  
>  #define FD(evt, cpu) (*(int *)xyarray__entry(evt->core.fd, cpu, 0))
>  
> +static void setup_rodata(struct bperf_cgroup_bpf *sk, int evlist_size)
> +{
> +	int map_size, total_cpus = cpu__max_cpu().cpu;
> +
> +	sk->rodata->num_cpus = total_cpus;
> +	sk->rodata->num_events = evlist_size / nr_cgroups;
> +
> +	if (cgroup_is_v2("perf_event") > 0)
> +		sk->rodata->use_cgroup_v2 = 1;
> +
> +	BUG_ON(evlist_size % nr_cgroups != 0);
> +
> +	/* we need one copy of events per cpu for reading */
> +	map_size = total_cpus * evlist_size / nr_cgroups;
> +	bpf_map__set_max_entries(sk->maps.events, map_size);
> +	bpf_map__set_max_entries(sk->maps.cgrp_idx, nr_cgroups);
> +	/* previous result is saved in a per-cpu array */
> +	map_size = evlist_size / nr_cgroups;
> +	bpf_map__set_max_entries(sk->maps.prev_readings, map_size);
> +	/* cgroup result needs all events (per-cpu) */
> +	map_size = evlist_size;
> +	bpf_map__set_max_entries(sk->maps.cgrp_readings, map_size);
> +}
> +
> +static void test_max_events_program_load(void)
> +{
> +#ifndef NDEBUG
> +	/*
> +	 * Test that the program verifies with the maximum number of events. If
> +	 * this test fails unfortunately perf needs recompiling with a lower
> +	 * BPERF_CGROUP__MAX_EVENTS to avoid BPF verifier issues.
> +	 */
> +	int err, max_events = BPERF_CGROUP__MAX_EVENTS * nr_cgroups;
> +	struct bperf_cgroup_bpf *test_skel = bperf_cgroup_bpf__open();
> +
> +	if (!test_skel) {
> +		pr_err("Failed to open cgroup skeleton\n");
> +		return;
> +	}
> +	setup_rodata(test_skel, max_events);
> +	err = bperf_cgroup_bpf__load(test_skel);
> +	if (err) {
> +		pr_err("Failed to load cgroup skeleton with max events %d.\n",
> +			BPERF_CGROUP__MAX_EVENTS);
> +	}
> +	bperf_cgroup_bpf__destroy(test_skel);
> +#endif
> +}
> +
>  static int bperf_load_program(struct evlist *evlist)
>  {
>  	struct bpf_link *link;
> @@ -50,35 +100,18 @@ static int bperf_load_program(struct evlist *evlist)
>  	int i, j;
>  	struct perf_cpu cpu;
>  	int total_cpus = cpu__max_cpu().cpu;
> -	int map_size, map_fd;
> -	int prog_fd, err;
> +	int map_fd, prog_fd, err;
> +
> +	set_max_rlimit();
> +
> +	test_max_events_program_load();
>  
>  	skel = bperf_cgroup_bpf__open();
>  	if (!skel) {
>  		pr_err("Failed to open cgroup skeleton\n");
>  		return -1;
>  	}
> -
> -	skel->rodata->num_cpus = total_cpus;
> -	skel->rodata->num_events = evlist->core.nr_entries / nr_cgroups;
> -
> -	if (cgroup_is_v2("perf_event") > 0)
> -		skel->rodata->use_cgroup_v2 = 1;
> -
> -	BUG_ON(evlist->core.nr_entries % nr_cgroups != 0);
> -
> -	/* we need one copy of events per cpu for reading */
> -	map_size = total_cpus * evlist->core.nr_entries / nr_cgroups;
> -	bpf_map__set_max_entries(skel->maps.events, map_size);
> -	bpf_map__set_max_entries(skel->maps.cgrp_idx, nr_cgroups);
> -	/* previous result is saved in a per-cpu array */
> -	map_size = evlist->core.nr_entries / nr_cgroups;
> -	bpf_map__set_max_entries(skel->maps.prev_readings, map_size);
> -	/* cgroup result needs all events (per-cpu) */
> -	map_size = evlist->core.nr_entries;
> -	bpf_map__set_max_entries(skel->maps.cgrp_readings, map_size);
> -
> -	set_max_rlimit();
> +	setup_rodata(skel, evlist->core.nr_entries);
>  
>  	err = bperf_cgroup_bpf__load(skel);
>  	if (err) {
> diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> index 18ab4d9b49ff..c2298a2decc9 100644
> --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> @@ -1,14 +1,12 @@
>  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  // Copyright (c) 2021 Facebook
>  // Copyright (c) 2021 Google
> +#include "bperf_cgroup.h"
>  #include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_core_read.h>
>  
> -#define MAX_LEVELS  10  // max cgroup hierarchy level: arbitrary
> -#define MAX_EVENTS  1024  // max events per cgroup: arbitrary
> -
>  // NOTE: many of map and global data will be modified before loading
>  //       from the userspace (perf tool) using the skeleton helpers.
>  
> @@ -97,7 +95,7 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
>  	cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_subsys_id], cgroup);
>  	level = BPF_CORE_READ(cgrp, level);
>  
> -	for (cnt = 0; i < MAX_LEVELS; i++) {
> +	for (cnt = 0; i < BPERF_CGROUP__MAX_LEVELS; i++) {
>  		__u64 cgrp_id;
>  
>  		if (i > level)
> @@ -123,7 +121,7 @@ static inline int get_cgroup_v2_idx(__u32 *cgrps, int size)
>  	__u32 *elem;
>  	int cnt;
>  
> -	for (cnt = 0; i < MAX_LEVELS; i++) {
> +	for (cnt = 0; i < BPERF_CGROUP__MAX_LEVELS; i++) {
>  		__u64 cgrp_id = bpf_get_current_ancestor_cgroup_id(i);
>  
>  		if (cgrp_id == 0)
> @@ -148,17 +146,17 @@ static int bperf_cgroup_count(void)
>  	register int c = 0;
>  	struct bpf_perf_event_value val, delta, *prev_val, *cgrp_val;
>  	__u32 cpu = bpf_get_smp_processor_id();
> -	__u32 cgrp_idx[MAX_LEVELS];
> +	__u32 cgrp_idx[BPERF_CGROUP__MAX_LEVELS];
>  	int cgrp_cnt;
>  	__u32 key, cgrp;
>  	long err;
>  
>  	if (use_cgroup_v2)
> -		cgrp_cnt = get_cgroup_v2_idx(cgrp_idx, MAX_LEVELS);
> +		cgrp_cnt = get_cgroup_v2_idx(cgrp_idx, BPERF_CGROUP__MAX_LEVELS);
>  	else
> -		cgrp_cnt = get_cgroup_v1_idx(cgrp_idx, MAX_LEVELS);
> +		cgrp_cnt = get_cgroup_v1_idx(cgrp_idx, BPERF_CGROUP__MAX_LEVELS);
>  
> -	for ( ; idx < MAX_EVENTS; idx++) {
> +	for ( ; idx < BPERF_CGROUP__MAX_EVENTS; idx++) {
>  		if (idx == num_events)
>  			break;
>  
> @@ -186,7 +184,7 @@ static int bperf_cgroup_count(void)
>  			delta.enabled = val.enabled - prev_val->enabled;
>  			delta.running = val.running - prev_val->running;
>  
> -			for (c = 0; c < MAX_LEVELS; c++) {
> +			for (c = 0; c < BPERF_CGROUP__MAX_LEVELS; c++) {
>  				if (c == cgrp_cnt)
>  					break;
>  
> diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.h b/tools/perf/util/bpf_skel/bperf_cgroup.h
> new file mode 100644
> index 000000000000..3fb84b19d39a
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/bperf_cgroup.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/* Data structures shared between BPF and tools. */
> +#ifndef __BPERF_CGROUP_H
> +#define __BPERF_CGROUP_H
> +
> +// These constants impact code size of bperf_cgroup.bpf.c that may result in BPF
> +// verifier issues. They are exposed to control the size and also to disable BPF
> +// counters when the number of user events is too large.
> +
> +// max cgroup hierarchy level: arbitrary
> +#define BPERF_CGROUP__MAX_LEVELS  10
> +// max events per cgroup: arbitrary
> +#define BPERF_CGROUP__MAX_EVENTS  128
> +
> +#endif /* __BPERF_CGROUP_H */
> -- 
> 2.51.1.821.gb6fe4d2222-goog
> 
