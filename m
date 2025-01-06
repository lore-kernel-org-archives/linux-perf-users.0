Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FE435956;
	Mon,  6 Jan 2025 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164941; cv=none; b=ibkBEwbYKcNYyfS858bNfoU3OIDjsX0tw54xuSj0+LhYDk18Eeletm5CaaE1makWSgO3b6JWnJxx24rDU2afJRoTa2XNZC/2DDsvPL065u1eQnPp4e1o60RQ7rwT71J/XDsfrmNfiqlRMM7ypfv9Mw4xIJDM/9Z8EL+f1E8U6oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164941; c=relaxed/simple;
	bh=xKVCnMNM4pz8nzUZaEvlDKNBgmnFRDxkTILNnrgjOFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ektGb2QHvegzmKf+QA24QaCvoJEf+XUNJXY2qfGAF0Uoeui6hl7O3aDT5n7nD+bRdzAlSlAjh9+1nWT8Irv+mZbjaURHEaXud1kxGR2Y9UXnQfaPedxEWmhMUQpvLmaRBnBAnhqU+cvZa10FhUaL76htcX7bmLyqLaLPoVGoAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00B551476;
	Mon,  6 Jan 2025 04:02:46 -0800 (PST)
Received: from e128066.arm.com (unknown [10.57.93.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CE3E3F673;
	Mon,  6 Jan 2025 04:02:13 -0800 (PST)
From: mark.barnett@arm.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: ben.gainey@arm.com,
	deepak.surti@arm.com,
	ak@linux.intel.com,
	will@kernel.org,
	james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Barnett <mark.barnett@arm.com>
Subject: [PATCH v2 0/5] A mechanism for efficient support for per-function metrics
Date: Mon,  6 Jan 2025 12:01:51 +0000
Message-Id: <20250106120156.227273-1-mark.barnett@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Barnett <mark.barnett@arm.com>

This patch introduces the concept of an alternating sample rate to perf
core and provides the necessary basic changes in the tools to activate
that option.

The primary use case for this change is to be able to enable collecting
per-function performance metrics using the Arm PMU, as per the following 
approach:

 * Starting with a simple periodic sampling (hotspot) profile,
   augment each sample with PMU counters accumulated over a short window
   up to the point the sample was taken.
 * For each sample, perform some filtering to improve attribution of
   the accumulated PMU counters (ensure they are attributed to a single
   function)
 * For each function accumulate a total for each PMU counter so that
   metrics may be derived.

Without modification, and sampling at a typical rate associated
with hotspot profiling (~1mS) leads to poor results. Such an
approach gives you a reasonable estimation of where the profiled
application is spending time for relatively low overhead, but the
PMU counters cannot easily be attributed to a single function as the
window over which they are collected is too large. A modern CPU may
execute many millions of instructions over many thousands of functions
within 1mS window. With this approach, the per-function metrics tend
to trend to some average value across the top N functions in the
profile.

In order to ensure a reasonable likelihood that the counters are
attributed to a single function, the sampling window must be rather
short; typically something in the order of a few hundred cycles proves
well as tested on a range of aarch64 Cortex and Neoverse cores.

As it stands, it is possible to achieve this with perf using a very high
sampling rate (e.g ~300cy), but there are at least three major concerns
with this approach:

 * For speculatively executing, out of order cores, can the results be
   accurately attributed to a give function or the given sample window?
 * A short sample window is not guaranteed to cover a single function.
 * The overhead of sampling every few hundred cycles is very high and
   is highly likely to cause throttling which is undesirable as it leads
   to patchy results; i.e. the profile alternates between periods of 
   high frequency samples followed by longer periods of no samples. 

This patch does not address the first two points directly. Some means
to address those are discussed on the RFC v2 cover letter. The patch
focuses on addressing the final point, though happily this approach
gives us a way to perform basic filtering on the second point.

The alternating sample period allows us to do two things:

 * We can control the risk of throttling and reduce overhead by
   alternating between a long and short period. This allows us to
   decouple the "periodic" sampling rate (as might be used for hotspot
   profiling) from the short sampling window needed for collecting
   the PMU counters.
 * The sample taken at the end of the long period can be otherwise 
   discarded (as the PMU data is not useful), but the
   PERF_RECORD_CALLCHAIN information can be used to identify the current
   function at the start of the short sample window. This is useful
   for filtering samples where the PMU counter data cannot be attributed
   to a single function.

There are several reasons why it is desirable to reduce the overhead and
risk of throttling:

  * PMU counter overflow typically causes an interrupt into the kernel;
    this affects program runtime, and can affect things like branch
    prediction, cache locality and so on which can skew the metrics.
  * The very high sample rate produces significant amounts of data.
    Depending on the configuration of the profiling session and machine,
    it is easily possible to produce many orders of magnitude more data
    which is costly for tools to post-process and increases the chance
    of data loss. This is especially relevant on larger core count
    systems where it is very easy to produce massive recordings.
    Whilst the kernel will throttle such a configuration,
    which helps to mitigate a large portion of the bandwidth and capture
    overhead, it is not something that can be controlled for on a per
    event basis, or for non-root users, and because throttling is
    controlled as a percentage of time its affects vary from machine to
    machine. AIUI throttling may also produce an uneven temporal
    distribution of samples. Finally, whilst throttling does a good job
    at reducing the overall amount of data produced, it still leads to
    much larger captures than with this method; typically we have
    observed 1-2 orders of magnitude larger captures.

This patch set modifies perf core to support alternating between two
sample_period values, providing a simple and inexpensive way for tools
to separate out the sample window (time over which events are
counted) from the sample period (time between interesting samples). 

It is expected to be used with the cycle counter event, alternating
between a long and short period and subsequently discarding the counter
data for samples with the long period. The combined long and short
period gives the overall sampling period, and the short sample period 
gives the sample window. The symbol taken from the sample at the end of
the long period can be used by tools to ensure correct attribution as
described previously. The cycle counter is recommended as it provides
fair temporal distribution of samples as would be required for the
per-symbol sample count mentioned previously, and because the PMU can
be programmed to overflow after a sufficiently short window (which may
not be possible with software timer, for example). This patch does not
restrict to only the cycle counter, it is possible there could be other
novel uses based on different events, or more appropriate counters on
other architectures. This patch set does not modify or otherwise disable
the kernel's existing throttling behaviour; if a configuration is given
that would lead high CPU usage, then throttling still occurs.


To test this a simple `perf script` based python script was developed.
For a limited set of Arm PMU events it will post process a
`perf record`-ing and generate a table of metrics. Along side this a
benchmark application was developed that rotates through a sequence
of different classes of behaviour that can be detected by the Arm PMU
(eg. mispredicts, cache misses, different instruction mixes). The path
through the benchmark can be rotated after each iteration so as to
ensure the results don't land on some lucky harmonic with the sample
period. The script can be used with and without this patch allowing
comparison of the results. Testing was on Juno (A53+A57), N1SDP,
Gravaton 2 and 3. In addition this approach has been applied to a few
of Arm's tools projects and has correctly identified improvements and
regressions.

Headline results from testing indicate that ~300 cycles sample window
gives good results with or without this patch. Typical output on N1SDP (Neoverse-N1)
for the provided benchmark when run as:

    perf record -T --sample-cpu --call-graph fp,4 --user-callchains \
        -k CLOCK_MONOTONIC_RAW \
        -e '{cycles/period=999700,alt-period=300/,instructions,branch-misses,cache-references,cache-misses}:uS' \
        benchmark 0 1

    perf script -s generate-function-metrics.py -- -s discard

Looks like (reformatted for email brevity):

    Symbol              #     CPI   BM/KI  CM/KI  %CM   %CY   %I    %BM   %L1DA  %L1DM
    fp_divider_stalls   6553   4.9   0.0     0.0   0.0  41.8  22.9   0.1   0.6    0.0
    int_divider_stalls  4741   3.5   0.0     0.0   1.1  28.3  21.5   0.1   1.9    0.2
    isb                 3414  20.1   0.2     0.0   0.4  17.6   2.3   0.1   0.8    0.0
    branch_mispredicts  1234   1.1  33.0     0.0   0.0   6.1  15.2  99.0  71.6    0.1
    double_to_int        694   0.5   0.0     0.0   0.6   3.4  19.1   0.1   1.2    0.1
    nops                 417   0.3   0.2     0.0   2.8   1.9  18.3   0.6   0.4    0.1
    dcache_miss          185   3.6   0.4   184.7  53.8   0.7   0.5   0.0  18.4   99.1

(CPI = Cycles/Instruction, BM/KI = Branch Misses per 1000 Instruction,
 CM/KI = Cache Misses per 1000 Instruction, %CM = Percent of Cache
 accesses that miss, %CY = Percentage of total cycles, %I = Percentage
 of total instructions, %BM = Percentage of total branch mispredicts,
 %L1DA = Percentage of total cache accesses, %L1DM = Percentage of total
 cache misses)

When the patch is used, the resulting `perf.data` files are typically
between 25-50x smaller than without, and take ~25x less time for the
python script to post-process. For example, running the following:

    perf record -i -vvv -e '{cycles/period=1000000/,instructions}:uS' benchmark 0 1
    perf record -i -vvv -e '{cycles/period=1000/,instructions}:uS' benchmark 0 1
    perf record -i -vvv -e '{cycles/period=300/,instructions}:uS' benchmark 0 1

produces captures on N1SDP (Neoverse-N1) of the following sizes:

    * period=1000000: 2.601 MB perf.data (55780 samples), script time = 0m0.362s
    * period=1000: 283.749 MB perf.data (6162932 samples), script time = 0m33.100s
    * period=300: 304.281 MB perf.data (6614182 samples), script time = 0m35.826s

The "script time" is the user time from running "time perf script -s generate-function-metrics.py"
on the recording. Similar processing times were observed for "time perf report --stdio|cat"
as well.

By comparison, with the patch active:

    perf record -i -vvv -e '{cycles/period=999700,alt-period=300/,instructions}:uS' benchmark 0 1

produces 4.923 MB perf.data (107512 samples), and script time = 0m0.578s.
Which is as expected ~2x the size and ~2x the number of samples as per
the period=1000000 recording. When compared to the period=300 recording,
the results from the provided post-processing script are (within margin
of error) the same, but the data file is ~62x smaller. The same affect
is seen for the post-processing script runtime.

Notably, without the patch enable, L1D cache miss rates are often higher
than with, which we attribute to increased impact on the cache that
trapping into the kernel every 300 cycles has.

These results are given with `perf_cpu_time_max_percent=25`. When tested
with `perf_cpu_time_max_percent=100` the size and time comparisons are
more significant. Disabling throttling did not lead to obvious
improvements in the collected metrics, suggesting that the sampling
approach is sufficient to collect representative metrics.

Cursory testing on a Xeon(R) W-2145 with a 300 *instruction* sample
window (with and without the patch) suggests this approach might work
for some counters. Using the same test script, it was possible to identify
branch mispredicts correctly. However, whilst the patch is functionally 
correct, differences in the architectures may mean that this approach it
enables does not apply as a means to collect per-function metrics on x86.

Changes since v1:
 - Rebased onto perf-tools-next, as per request from Ian Rogers.
 - Removed unnecessary code that truncated period_left to 0 and restarted
   the PMU.
 - Renamed variables to use the shorter 'alt_period' instead of 
   'alterantive_period'.
 - Added patch #5 that addresses an issue in the x86 and PowerPC drivers that
   caused the opposite period to be reported in the sample record.
   
Changes since RFC v2:
 - Rebased on v6.12-rc6.

Changes since RFC v1:
 - Rebased on v6.9-rc1.
 - Refactored from arm_pmu based extension to core feature
 - Added the ability to jitter the sample window based on feedback
   from Andi Kleen.
 - Modified perf tool to parse the "alt-period" and "alt-period-jitter"
   terms in the event specification.

Ben Gainey (4):
  perf: Allow periodic events to alternate between two sample periods
  perf: Allow adding fixed random jitter to the alternate sampling
    period
  tools/perf: Modify event parser to support alt-period term
  tools/perf: Modify event parser to support alt-period-jitter term

Mark Barnett (1):
  perf: Record sample last_period before updating

 arch/powerpc/perf/core-book3s.c               |  3 +-
 arch/powerpc/perf/core-fsl-emb.c              |  3 +-
 arch/x86/events/core.c                        |  4 +-
 arch/x86/events/intel/core.c                  |  3 +-
 arch/x86/events/intel/knc.c                   |  3 +-
 include/linux/perf_event.h                    |  5 +++
 include/uapi/linux/perf_event.h               | 10 ++++-
 kernel/events/core.c                          | 44 ++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h         | 10 ++++-
 tools/perf/tests/shell/attr/base-record       |  4 +-
 tools/perf/tests/shell/attr/base-record-spe   |  2 +
 tools/perf/tests/shell/attr/base-stat         |  4 +-
 tools/perf/tests/shell/attr/system-wide-dummy |  4 +-
 .../attr/test-record-alt-period-jitter-term   | 13 ++++++
 .../shell/attr/test-record-alt-period-term    | 12 +++++
 .../tests/shell/attr/test-record-dummy-C0     |  4 +-
 tools/perf/tests/shell/lib/attr.py            |  2 +
 tools/perf/util/evsel.c                       |  2 +
 tools/perf/util/parse-events.c                | 30 +++++++++++++
 tools/perf/util/parse-events.h                |  4 +-
 tools/perf/util/parse-events.l                |  2 +
 tools/perf/util/perf_event_attr_fprintf.c     |  1 +
 tools/perf/util/pmu.c                         |  4 +-
 23 files changed, 159 insertions(+), 14 deletions(-)
 create mode 100644 tools/perf/tests/shell/attr/test-record-alt-period-jitter-term
 create mode 100644 tools/perf/tests/shell/attr/test-record-alt-period-term

-- 
2.43.0

