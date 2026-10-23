Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790942;
	b=RxD0xfqRipDZ9tv6hTwCxgCbYkSMHe6npERgHFjCkLSKogGkx8NzT8tFKdlzjgxTSeyz
	 VXNyuHtAVcc04kq5wOk//6DIEdWNM/QXbRO+sKfUG3uIsZ046d1gVr01DsdgtWBzPcMtP
	 8uLlLgoAmpqfoXBWn5U4AGCmRqz+ud1Z5ohhOEbamdUKGNQ9PLmLhQfRvwjv/BGPnT+ZI
	 GuSTcplT8Fk+W1JvHsG2dsjOKJV9E/amahgJutkyzkjwryH6Lg7mp0Ec3PMHwejBF8EE9
	 ppjjrKdZ9vTY+vRvB7HSrTuFGOytlEg/v8HImv8gciW+cM2PHoDO7F9HVtXOASIhIDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790942;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SPo5JT16y1DaEMxqlX2cvPgpbj/FzZJAHhXrqtgHuJA=;
	b=PisjVic8YS8iEIisWSmqUjEbp9gikH3RzcuiL/BtRndytX4UKFAfsCw+kBJz613ognN7
	 0JC9NLf7hNdcOYyKcQK7JpIMHd23ynFagz8VRk7BNeetp3lW3Ls1HcXlp19QhzPL6sXNd
	 aDOSwk4nGeAbdOHhOR/REzmTcxcccceb2nAARRLd2XajIZuzNRtUmZMJVHh0npSdhpkIH
	 F4Rbd+48AkKdwWZjhvhyjYUCyVEdzMpelm9Zb7DHVtDpqxAh/fA2tSwDmZ4453lU49vms
	 EA8AH2KVFKDIwvoC9ZiP9BEdRLLa7Df0ntP/+TparkHOUq7Zlx+7TIOnTL3uPEC9VqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrDUDY5a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D950606A31B;
	Fri, 23 Oct 2026 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrDUDY5a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B5F1F01825;
	Fri, 23 Oct 2026 21:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792790942;
	bh=SPo5JT16y1DaEMxqlX2cvPgpbj/FzZJAHhXrqtgHuJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HrDUDY5aj9SM0a/3NOaJ9YsHk3+5IGEa3m+Rkvwx2rIa4v+OTTJKCbh7fH6yIMBED
	 0toEaHtWlwbgnUf3NXP7gfEHFC4DaM11EBB0NiwfGeoCl15YWcN0Au1w/b0vy27AQl
	 85J8EtK5nCXBZvuBeZrkB2HwTmmr7qPGHjBpaTRIN/O/SFQsitCMzU++05bW0wOO+7
	 ZecSyPBhN8g/Diq+Q1UFTK4zTZYJY/7XODqI0GFs/qAleIp9oQNC/KCs7OBZIs/KGS
	 1IZu6EfJog8RdMlQsyRBFe3zT93NISPFqkC4n4hYvjeUscEDQp4vd3nk+d5zRqH2Gm
	 v3HiBSuV757xw==
Date: Fri, 23 Oct 2026 18:28:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Antoine HURET <antoine.huret@bull.com>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] perf: Rewrite core context handling breaks
 multiplexed cgroup events
Message-ID: <atvRmz_uGKpiYfMv@phoenix2>
References: <PR3PR07MB69223331EED5BEBE150375B7849C2@PR3PR07MB6922.eurprd07.prod.outlook.com>
 <20261015111316.GJ4121339@noisy.programming.kicks-ass.net>
 <PR3PR07MB692235BC98DAB96E30E4AB8D849C2@PR3PR07MB6922.eurprd07.prod.outlook.com>
 <20261015132135.GK4121339@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015132135.GK4121339@noisy.programming.kicks-ass.net>

On Thu, Oct 15, 2026 at 03:21:35PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 15, 2026 at 12:30:55PM +0000, Antoine HURET wrote:
> > On Thu, Oct 15, 2026 at 11:13 UTC, Peter Zijlstra wrote:
> > > /me mutters something about having to go install and learn docker and
> > > what's wrong with simple shells scripts that poke about in /cgroup
> > > filesystems :-)

> > Fair enough, sorry about that! Next time I'll do plain cgroupfs,
> > promised :-)
 
> FWIW, it might be useful to extend perf-test with a bunch of cgroup
> tests - this one included. AFAICT we have nothing there atm.

The more the merrier, so far:

acme@phoenix2:~/git/perf-tools-next$ grep -rw cgroup tools/perf/tests/
tools/perf/tests/expand-cgroup.c:#include "cgroup.h"
tools/perf/tests/expand-cgroup.c:			pr_debug("cgroup name doesn't match:\n");
tools/perf/tests/shell/lib/perf_json_output_lint.py:      'cgroup': lambda x: True,
tools/perf/tests/shell/lock_contention.sh:	echo "Testing perf lock contention --lock-cgroup"
tools/perf/tests/shell/lock_contention.sh:	perf lock con -a -b --lock-cgroup -E 1 -q -- ${msg_workload} > /dev/null 2> ${result}
tools/perf/tests/shell/lock_contention.sh:	echo "Testing perf lock contention --cgroup-filter"
tools/perf/tests/shell/lock_contention.sh:	perf lock con -a -b --lock-cgroup -E 1 -F wait_total -q \
tools/perf/tests/shell/lock_contention.sh:		echo "[Fail] BPF result should have a cgroup result:" "$(cat "${result}")"
tools/perf/tests/shell/lock_contention.sh:	cgroup=$(cat "${result}" | awk '{ print $3 }')
tools/perf/tests/shell/lock_contention.sh:	perf lock con -a -b --lock-cgroup -E 1 -G "${cgroup}" -q \
tools/perf/tests/shell/lock_contention.sh:		echo "[Fail] BPF result should have a result with cgroup filter:" "$(cat "${cgroup}")"
tools/perf/tests/shell/record_bpf_filter.sh:  if ! perf record -e task-clock --filter 'cgroup == /' \
tools/perf/tests/shell/record_bpf_filter.sh:       -a --all-cgroups --synth=cgroup -o "${perfdata}" true 2> /dev/null
tools/perf/tests/shell/record_bpf_filter.sh:    echo "Cgroup bpf-filter test [Skipped cgroup not supported]"
tools/perf/tests/shell/record_bpf_filter.sh:  # 'cgroup' requires PERF_SAMPLE_CGROUP flag
tools/perf/tests/shell/record_bpf_filter.sh:  if ! perf record -e task-clock --filter 'cgroup == /' \
tools/perf/tests/shell/record_bpf_filter.sh:  if ! perf report -i "${perfdata}" -s cgroup -q | grep -q -F '100.00%'
tools/perf/tests/shell/record_bpf_filter.sh:    echo "Cgroup bpf-filter test [Failed root cgroup does not have 100%]"
tools/perf/tests/shell/record.sh:  perf script -i "${perfdata}" -F cgroup 2>/dev/null | grep -q -v "unknown"
tools/perf/tests/shell/record.sh:    -aB --synth=cgroup --all-cgroups || ret=$?
tools/perf/tests/shell/trace_summary.sh:# summary only for system wide - cgroup summary mode with BPF
tools/perf/tests/shell/trace_summary.sh:test_perf_trace "-as --summary-mode=cgroup --bpf-summary"
tools/perf/tests/shell/trace_summary.sh:# summary with normal output for system wide - cgroup summary mode with BPF
tools/perf/tests/shell/trace_summary.sh:test_perf_trace "-aS --summary-mode=cgroup --bpf-summary"
tools/perf/tests/shell/stat_bpf_counters_cgrp.sh:# perf stat --bpf-counters --for-each-cgroup test (no_mlock)
tools/perf/tests/shell/stat_bpf_counters_cgrp.sh:# skip if --bpf-counters --for-each-cgroup is not supported
tools/perf/tests/shell/stat_bpf_counters_cgrp.sh:	if ! perf stat -a --bpf-counters --for-each-cgroup / true > /dev/null 2>&1; then
tools/perf/tests/shell/stat_bpf_counters_cgrp.sh:			echo "Skipping: --bpf-counters --for-each-cgroup not supported"
tools/perf/tests/shell/stat_bpf_counters_cgrp.sh:			perf --no-pager stat -a --bpf-counters --for-each-cgroup / true || true
tools/perf/tests/shell/stat_bpf_counters_cgrp.sh:	if [ -d /sys/fs/cgroup/system.slice ] && [ -d /sys/fs/cgroup/user.slice ]; then
tools/perf/tests/shell/stat_bpf_counters_cgrp.sh:	find_cgroups_self_cgrp=$(grep perf_event /proc/self/cgroup | cut -d: -f3)
tools/perf/tests/shell/stat_bpf_counters_cgrp.sh:		# cgroup v2 doesn't specify perf_event
tools/perf/tests/shell/stat_bpf_counters_cgrp.sh:		find_cgroups_self_cgrp=$(grep ^0: /proc/self/cgroup | cut -d: -f3)
tools/perf/tests/shell/stat_bpf_counters_cgrp.sh:# As cgroup events are cpu-wide, we cannot simply compare the result.
tools/perf/tests/shell/stat_bpf_counters_cgrp.sh:	check_system_wide_counted_output=$(perf stat -a --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, sleep 1  2>&1)
tools/perf/tests/shell/stat_bpf_counters_cgrp.sh:	expand_output=$(perf stat -a -x, --bpf-counters --for-each-cgroup / true 2>&1 | wc -l)
tools/perf/tests/shell/stat_metrics_cgrp.sh:# perf stat metrics --for-each-cgroup test (no_mlock)
tools/perf/tests/shell/stat_metrics_cgrp.sh:	if [ -d /sys/fs/cgroup/system.slice ] && [ -d /sys/fs/cgroup/user.slice ]
tools/perf/tests/shell/stat_metrics_cgrp.sh:	find_cgroups_self_cgrp=$(grep perf_event /proc/self/cgroup | cut -d: -f3)
tools/perf/tests/shell/stat_metrics_cgrp.sh:		# cgroup v2 doesn't specify perf_event
tools/perf/tests/shell/stat_metrics_cgrp.sh:		find_cgroups_self_cgrp=$(grep ^0: /proc/self/cgroup | cut -d: -f3)
tools/perf/tests/shell/stat_metrics_cgrp.sh:# Check if metric is reported for each cgroup
tools/perf/tests/shell/stat_metrics_cgrp.sh:			--for-each-cgroup "${test_cgroups}" \
tools/perf/tests/shell/stat_metrics_cgrp.sh:		# Find metric lines for this cgroup
tools/perf/tests/shell/stat_metrics_cgrp.sh:			/)  # The root cgroup, leave unchanged.
tools/perf/tests/shell/stat_metrics_cgrp.sh:		# We use exact cgroup match with surrounding commas
tools/perf/tests/shell/stat_metrics_cgrp.sh:			echo "FAIL: No metric lines found for cgroup '${cgrp}'"
tools/perf/tests/shell/stat_metrics_cgrp.sh:				log_verbose "Enforcing metric check for cgroup '${cgrp}' \
tools/perf/tests/shell/stat_metrics_cgrp.sh:for cgroup '${cgrp}'"
tools/perf/tests/shell/stat_metrics_cgrp.sh:					echo "FAIL: Empty metric value for cgroup '${cgrp}'"
tools/perf/tests/shell/stat_metrics_cgrp.sh:				log_verbose "Skipping metric check for cgroup '${cgrp}' \
tools/perf/tests/shell/stat_metrics_cgrp.sh:if perf stat -a --bpf-counters --for-each-cgroup / true > /dev/null 2>&1
tools/perf/tests/sample-parsing.c:		COMP(cgroup);
tools/perf/tests/sample-parsing.c:		.cgroup		= 114,
tools/perf/tests/Build:perf-test-y += expand-cgroup.o
acme@phoenix2:~/git/perf-tools-next$

- Arnaldo
