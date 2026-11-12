Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=38.105.200.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794511117;
	b=R4FTaMsRUfCn1HIANZE3xiV1QJOyvLL+ND2B3eAAN+qC5bXBRrIYUF3cwnebn0a2bd8F
	 0lV/YxapJ7z3z2xPpEUlh+6xMS+3jNfYov757TFYpeNNt3wO1ETk1sCwEEs7uy5rV1DnM
	 SpJnxk6TtbukXEGneL/mPEUwxXpABBOEAt4wt4qMjFXpJ8Ujpo5fVbj51/qKspoYcdjD2
	 edwwkVMJgqD0LHxZDrDpLBBmkJID6Px2kVUaGtRgvYD2AKkMgZUiY9hxcDGDbo0dKq/kN
	 Cq6eBIrm36kHXAp3cECgJqzCnaVIog8xD8q7/yedSBVPv8GxcEjRExl4x+tOmVkz/gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511117;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=EFDkvvuk/5rONyB6sG3nkd+MKe2Z3SzEfM0I/qm/DYo=;
	b=PS3QFEGRmDIKPcduHmOo70/m8z1YGnVvhx44RH4ii4SnhC1j7gqE5gx3kLM0XN1Kq4d2
	 5PPM2yqhIUqpflC9rCCGB+dDEWVH0/GtzdqWaWjSHPgrNROs53l9cs2FuZdKZO7W3BrPv
	 Xnh5ge6jQz3b9ne0v9XHPPzbJw1LOnxgpN65ydp7qprzvIqHNFC7CRa0KPvYN3ZwsVCp1
	 4qSBJ5O6qW7kT35e+qIQh32kXSCgJY8zYi+aeyXcf5Yb4bXPxDvALSRb3jqDt5tqwRYAe
	 cc9azU63Ps6Xe2lyvNw8fRsnwVQQVU/HebtGaqyL8oN10mb7aDNZHiNPG0rsqD9qVYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=janestreet.com;
	spf=pass smtp.mailfrom=janestreet.com;
	dkim=pass header.d=janestreet.com header.i=@janestreet.com header.a=rsa-sha256 header.s=waixah header.b=RiRgLta0;
	dkim=pass header.d=janestreet.com header.i=@janestreet.com header.a=rsa-sha256 header.s=google header.b=Iy9DWvvG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=38.105.200.78
Received: from mxout1.mail.janestreet.com (mxout1.mail.janestreet.com [38.105.200.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D15606A321
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 19:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65D15606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=janestreet.com header.i=@janestreet.com header.a=rsa-sha256 header.s=waixah header.b=RiRgLta0;
	dkim=pass (1024-bit key, unprotected) header.d=janestreet.com header.i=@janestreet.com header.a=rsa-sha256 header.s=google header.b=Iy9DWvvG
Received: from mail-lj1-f199.google.com ([209.85.208.199])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.100.1)
 	id 1xRaJa-00000000NX6-2Ptz
 	for linux-perf-users@vger.kernel.org;
 	Thu, 12 Nov 2026 14:18:30 -0500
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3ad00533aa8so538771fa.0
         for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 11:18:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794511109; cv=none;
         d=google.com; s=arc-20260327;
         b=OjsHbGRDuetxbDfm0DnGYraKAHUkChoAVTFHbSYpZ8M4Ng9cMYaRC5nMAfoL5speT7
          I70Ktlnmbfn8gyfUKNWbJvb7bkt0SYyFbGaAMMyxXmt3xH8sLxYgnEbe2BX29AL6UOn0
          MGRI5d9TJH+423KigYcsBHhGPx42du7GYD5S1GKDX+OsjIL56F2WpHR/RKmL+5Qc4ok8
          x9ixQjgNra4PF6hN29bvPqUxMvGEzAg7Wlwuc5hvjk5jWF0uyXRIX74tKtp5a9boqfvJ
          C4uA1TMX03AGzzCRLbXQSML3MHqUa6c09swtrJjbyKk79ZpXvHBy916tzn69qiLLV9lc
          pkpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
         h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
         bh=EFDkvvuk/5rONyB6sG3nkd+MKe2Z3SzEfM0I/qm/DYo=;
         fh=5sUB6O1djL/FiYMSppk2U8SY+gUiWolSpCNcMkp62dA=;
         b=J6y+ldlUU1wGb6ZFR4dEPXDiC3FA9Px5WL1KR5MtYO91gQBrmqOtzVvUgQA/5H/pSs
          kmdgkxIxlilCOaPobUatf4V9o5pys9z0ZjOUIDx/a5bqoJsv2XajTnIhcbj233lHIKOn
          63aIqx05KLFt+yQMNx03Ri8b94dEaZm/RrvfiysxX8RPfWDMhIURnOiB6BlWynSJ23Ro
          RjROnmS4UiE630q04lv7zTB3n8dxlqhZDCEoNSjDJsPdTqxudUugdZN1BS3ngyJbHjJh
          unIQHDpnBOArV6Pyi4lSAm5VraowWf1amonUtkOW1JmX+yETOl39zJdSNOfS3clp9kMK
          tUnw==;
         darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1794511110;
  bh=EFDkvvuk/5rONyB6sG3nkd+MKe2Z3SzEfM0I/qm/DYo=;
  h=From:Date:Subject:To:Cc;
  b=RiRgLta0b5jaIvGclQQe6YOWJ9mRdJ3GPJWhMplzGLoe5rY7aljlx3eXePtNjgh8i
  I8OdoVSfiaPuHtOAqWjSXiixRfMNh3m3TXt7FKjaOy2ynYAGx2MTjvtnIrf16SbsAS
  qsqMhE9qFVeoJFgXHeEc9F8no4OitNOxuLwrYMRNipdVjH4vhcK10yyrCyOB00n1Ba
  pg9mHgMIVkuWRJ5PW5rHFx+K/qbOVDNmJQAvr5JG4srV0KSIKaS5/5JlWaP2YivuwJ
  0S4gnH+AFCRwYtl4xMW03It3ZS1RddMMOzUL8ueaNVQWD3NOx4qgw1YQrMLawG0p0O
  MjuzIjMkq65Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1794511109; x=1795115909; darn=vger.kernel.org;
         h=content-type:cc:to:subject:message-id:date:from:mime-version:from
          :to:cc:subject:date:message-id:reply-to:content-type;
         bh=EFDkvvuk/5rONyB6sG3nkd+MKe2Z3SzEfM0I/qm/DYo=;
         b=Iy9DWvvGAWsf9UxNWrg6ZCxuT0hNkZtWDAYC2EOsE59V3pVZx/w5HuNgsaa/uCLkDn
          SXAKlWkuPDBW8/+JhfXQRK32aqG7YtyiLQYXe700GGdyypVz9t33qXUnptmZNycMHIB/
          YXKyWxCNLzXEX1JisJuoxTyo1w8+y7s4ZuWVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20260707; t=1794511109; x=1795115909;
         h=content-type:cc:to:subject:message-id:date:from:mime-version
          :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
          :reply-to:content-type;
         bh=EFDkvvuk/5rONyB6sG3nkd+MKe2Z3SzEfM0I/qm/DYo=;
         b=Os39/B8xolFc3Gj/jdp7f1XwOV+U515qVMPZ81OaJAV1RDwHsTknP/jTfLCgMQmYIR
          2Kiei//SpTxqXwUqMIhFgbM4VKwCRTXM8ITgUk+mTph1hM3qOpLsY66z5h8hcORVbyYH
          ajPuEH9/4JM81VbJAyDK13LRac0qmBYQqtbtO14KBDfqMgtPWlFhdxXPRlv+70jb2QQc
          qXwcFyCugXyemTFmrbhssqPtgQkeaxWLzDo7S5JKF3Vux4qu7cmkJg6PJDif1CmBiS05
          X19g1Pa3YFsWd9ONfKq8Vk+j3ksh3gHdr/HUdPubwE2T0N8cQ7E3VjOl9x0tD6hUc4yy
          azhA==
X-Gm-Message-State: APuU4Z/1O0W9uixMeK65SwFfyFqncd4+LaQHt+FB1NnYuKonLLu0lf/r
 	9oLm07P6Ov5HhoMyIbWDxOZ5nAs4IF+zazgFLPXqsXSfh3+yj8Dfl0u4EhWRstR5QXsa23GnfUW
 	hFkj0Cjo8oRT2q3h6zJpyZ902Tr3thGC1DAOYVJBhlIxWQB4RfAB9cyZzkjMoBC25pN7Gwp53rh
 	GR45HzdWvYchEwhubmR/GRk6gOh2WjtKf7xl/UJg/pz/7YEPpO+f/Ig+g=
X-Gm-Gg: AYBFou0hKl9yncurbIi4qObtKbj9LW2sOfIDJuBqcT99Xwjjo+0FwftN3atdnT1P1IQ
 	wAdSYLt6Mz5B074+idUlOywGCXvwCzd3UQ6AmnBxDIh0Kh4mM+By/w7uBBXNbARgo/9pj5HEblQ
 	rj9+RzfBVbTeBSqheXpEsgcEudBhHO01SK0pOXwmlql3VjUB4W8qK2PNw+
X-Received: by 2002:a05:651c:41d1:b0:3ab:1207:bd2f with SMTP id 38308e7fff4ca-3ae2b4bad8cmr2454391fa.11.1794511109070;
         Thu, 12 Nov 2026 11:18:29 -0800 (PST)
X-Received: by 2002:a05:651c:41d1:b0:3ab:1207:bd2f with SMTP id
  38308e7fff4ca-3ae2b4bad8cmr2452381fa.11.1794511108606; Thu, 12 Nov 2026
  11:18:28 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Gregg Leventhal <gleventhal@janestreet.com>
Date: Thu, 12 Nov 2026 14:17:52 -0500
X-Gm-Features: AclHuK_B7quFzyIv8VUjYl-Ts-0hb1VNcf5TexOj_ipkHnHeo-gl7aDWP1ryg_s
Message-ID: <CAFN_u7G94CC_RGL1La66jX+jRKHSJdAB5PKkTRSWrUvqhM48oQ@mail.gmail.com>
Subject: Subject: [BUG] perf/core: frequency-mode period overshoots during ramp-up
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
 	Mark Rutland <mark.rutland@arm.com>, 
 	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
 	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 	James Clark <james.clark@linaro.org>, Mark Barnett <mark.barnett@arm.com>, 
 	linux-kernel@vger.kernel.org, Jay Hilton <jahilton@janestreet.com>, 
 	Andrew Delgadillo <adelgadillo@janestreet.com>, Eric Hagberg <ehagberg@janestreet.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

In frequency mode (attr.freq = 1, e.g. perf record -F 11), the sample
period overshoots its target while it ramps up from its initial value.
The sampled thread then goes unsampled for roughly 2-6x longer than
1/freq, and when the kernel later cuts the period back, events go
missing from the profile. We see this on vanilla v7.3, 6.18.56 and
6.12.112. The code involved is unchanged in v7.4-rc2.

Tested on (all vanilla kernel.org kernels):

- AMD EPYC 9655P (Zen5), bare metal, 7.3.0: cycles 50/50,
  instructions 50/50, raw cycles 50/50 runs (>2x in 17, 25 and 16 of
  those), up to 5.9x. IBS (ibs_op, cycles:P): >2x in 28/30, up to 7.0x.
- Intel Xeon Platinum 8468, bare metal, 7.3.0: raw cycles (0x3c)
  49/50, up to 6.8x; cycles 0/50.
- AMD EPYC Turin (Zen5), KVM guest, 7.3.0: 3/3 runs.
- AMD EPYC Genoa (Zen4), KVM guest, 6.18.56: 3/3 runs.
- AMD EPYC Genoa (Zen4), KVM guest, 6.12.112: 3/3 runs.

"N/50" counts runs in which the ramp-up produced either a period over
2x the target or a sample whose period doesn't match the cycles
counted. The 9655P uses PerfMonV2 (amd_pmu_v2_handle_irq()); the
guests don't expose it and use x86_pmu_handle_irq().

IBS (perf_ibs_handle_irq()) is affected the same way. It starts at its
minimum period of 144 and, for example, goes 144 -> 318,671 ->
2,021,072,009 (4.9x the target, a 450 ms gap). IBS runs included
kernel mode, since IBS rejects exclude_kernel without its software
filter.

Reproducer
----------

The program at the end samples its own user-mode cycles at 11 Hz while
spinning for 3 seconds. For each sample it prints the reported period
(PERF_SAMPLE_PERIOD), the cycles counted since the previous sample
(PERF_SAMPLE_READ), and the time since the previous sample. On v7.3,
bare-metal EPYC 9655P (target period ~411M cycles, ~91 ms):

        period      counted    dt(ms)
             1         1790     0.001
          2426         1863     0.001
      21864282     21864341     4.852
    2313570064   2458402940   543.880  <- != counted  <- > 2x target
     411062043    411061989    90.958
     410683637    410683588    90.945
  target period 410934292, max period 2313570064 (5.6x): BUG

After a 21.9M-cycle interval, the period jumps to 2.3G (5.6x the target)
and the next sample comes 544 ms later instead of 91 ms. 2.46G cycles
elapsed, so 145M are not attributed to any sample (see below for why).

On the Turin guest (v7.3, target ~403M), a run with a smaller overshoot:

        period      counted    dt(ms)
             1         1706     0.000
             1         2133     0.015
             1         1179     0.009
          1210         1398     0.011
       1019729      1020007     0.241
     998467121    998466679   225.390  <- > 2x target
     402677477    402677426    90.819
     402960793    402960844    90.921
  target period 403056550, max period 998467121 (2.5x): BUG

After a 1.02M-cycle interval, the counter is armed for 998M cycles,
2.5x the target, and period == counted: nothing was cut back, and the
next sample comes 225 ms later instead of 91 ms. When the overshoot is
larger, a later tick cuts it back, which shows up as a sample whose
period is smaller than the cycles that elapsed:

       2036681      2037233     0.458
     464053892    711277272   159.223  <- != counted
     406964862    406964897    90.959

Here 247M cycles (~55 ms of CPU) are not attributed to any sample.
6.18.56 behaves the same way (955M armed against a 329M target, or
379.6M reported for 573.4M counted).

Cause
-----

__perf_event_account_interrupt() adjusts the period with

        if (delta > 0 && delta < 2*TICK_NSEC)
                perf_adjust_period(event, delta, hwc->last_period,
                                   true);

but the PMU drivers re-arm the counter before calling
perf_event_overflow() (x86_pmu_handle_irq(), amd_pmu_v2_handle_irq(),
handle_pmi_common(), perf_ibs_handle_irq(), ...), and re-arming sets
hwc->last_period to the period of the *next* interval. The estimator
therefore divides the next period by the time the previous one took.
Once the period is stable the two are about equal, but during ramp-up
each period is much larger than the one before it, so the rate is
overestimated by that ratio.

The Turin guest run above matches this. At the overflow that ended
the 1,210-cycle interval (about 11 us), the counter was re-armed for
1,019,729 cycles, so perf_adjust_period() got count = 1,019,729 and
nsec ~ 11 us:

  period        = 1019729 * 1e9 / (11e3 * 11)       ~ 8.4e9
  sample_period = 1019729 + (8.4e9 - 1019729) / 8   ~ 1.05e9

which is the ~998M period armed one overflow later. With the elapsed
count (1,210) the same calculation gives a period of ~10M and a next
sample_period of ~2.1M. The low-pass filter can only move sample_period
1/8 of the way toward the estimate, so a correctly fed estimator cannot
overshoot the target. Reaching 2.5x the target needs an estimated rate
around 20x what the CPU can do.

When the overshoot exceeds 8x, perf_adjust_period() on the next tick
sees period_left > 8 * sample_period, zeroes period_left and restarts
the counter. Restarting sets hwc->last_period to the new, smaller
period, which is why the reported period then understates the cycles
that elapsed (the 464M/711M sample above).

Since 1734d98fbcce ("perf/arch: Record sample last_period before
updating on the x86 and PowerPC platforms"), the elapsed period is in
data->period when perf_event_overflow() is called, so that looks like
the right input for the estimator, but we haven't tested that change
on mainline.

Kernels without 1734d98fbcce (e.g. 6.12) also report each sample's
period one sample late. Combined with this bug, the oversized period is
attached to a sample that covered only ~1M cycles. For example, on
6.12.112:

       1037581         1464     0.012  <- != counted
    1002666013      1037874     0.293  <- != counted  <- > 2x target

That sample claims ~1000x the cycles it represents.

Impact
------

This matters most at low frequencies and for threads that run in short
bursts, since they spend a large share of their samples in ramp-up.
It isn't limited to low frequencies, though: on the bare-metal 9655P,
perf's default 4000 Hz overshot in 10/10 runs, by up to 4x (in the KVM
guests it was ~1.03x).

We found it because continuous per-thread profiles at 11 Hz (on
6.12-based kernels) attributed ~12% of a CPU-bound program's time to a
function that only runs at startup, and heavily overweighted a mostly
idle runtime ticker thread. On kernels with 1734d98fbcce, the symptoms
are sampling gaps and events missing from the profile, rather than
inflated weights.

On Intel (Xeon 8468, bare metal, 7.3), the default cycles and
instructions events are not affected: intel_pmu_freq_start_period()
starts them at 500M/freq (45,454,545 at 11 Hz), close to the target, so
there is no ramp-up to overshoot. A raw cycles event (0x3c) starts much
lower (23,272) and overshoots in 49 of 50 runs, by up to 6.8x. In a
typical run (target ~344M), the period jumps to 1.94G (5.7x) and 61M
cycles are not attributed to any sample:

         23272        23255     0.007
      25310078     25310067     6.737
    1943552252   2005048959   530.205  <- != counted  <- > 2x target
     343751272    343751292    90.879

So the problem is in the generic code; Intel's start-period estimate
only hides it for some events. We haven't looked at or tested other
architectures.

Thanks to Jay Hilton <jahilton@janestreet.com> and Andrew Delgadillo
<adelgadillo@janestreet.com>, who found and analyzed this.

Reproducer:

// Minimal reproducer for the perf frequency-mode ramp-up bug.
// Samples this thread's user-mode cycles at 11 Hz while burning CPU
// for 3s, then prints each sample's period, the cycles actually
// counted since the previous sample, and the time since the previous
// sample.
//
// On a correct kernel, period == counted (up to skid) and no period
// exceeds 2x the steady-state target (cycles per second / samples
// per second). Exits 1 if either check fails.
//
//   cc -O2 -o repro-min repro-min.c && ./repro-min
#define _GNU_SOURCE
#include <linux/perf_event.h>
#include <stdint.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <time.h>
#include <unistd.h>

#define FREQ 11
#define PAGES 64
#define SKID 100000

static double now(void) {
  struct timespec ts;
  clock_gettime(CLOCK_MONOTONIC, &ts);
  return ts.tv_sec + ts.tv_nsec / 1e9;
}

int main(void) {
  struct perf_event_attr attr = {
      .size = sizeof(attr),
      .type = PERF_TYPE_HARDWARE,
      .config = PERF_COUNT_HW_CPU_CYCLES,
      .freq = 1,
      .sample_freq = FREQ,
      .sample_type =
          PERF_SAMPLE_TIME | PERF_SAMPLE_PERIOD | PERF_SAMPLE_READ,
      .exclude_kernel = 1,
      .disabled = 1,
  };
  int fd = syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0);
  if (fd < 0) return perror("perf_event_open"), 2;
  long pg = sysconf(_SC_PAGESIZE);
  struct perf_event_mmap_page *meta =
      mmap(NULL, (PAGES + 1) * pg, PROT_READ | PROT_WRITE,
           MAP_SHARED, fd, 0);
  if (meta == MAP_FAILED) return perror("mmap"), 2;

  ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
  double start = now();
  while (now() < start + 3) {
  }
  ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
  double elapsed = now() - start;
  uint64_t total;
  if (read(fd, &total, sizeof total) != sizeof total)
    return perror("read"), 2;
  double target = total / elapsed / FREQ;

  // 3s at 11 Hz fits in the buffer, so records never wrap.
  char *data = (char *)meta + pg;
  uint64_t head = __atomic_load_n(&meta->data_head, __ATOMIC_ACQUIRE);
  uint64_t prev_count = 0, prev_time = 0, max = 0;
  int bad = 0;
  printf("%12s %12s %9s\n", "period", "counted", "dt(ms)");
  for (uint64_t pos = 0; pos < head;) {
    struct perf_event_header *h = (void *)(data + pos);
    if (h->type == PERF_RECORD_SAMPLE) {
      // v[0] = time, v[1] = period, v[2] = counter value
      uint64_t *v = (void *)(h + 1);
      uint64_t counted = v[2] - prev_count;
      long long err = (long long)(v[1] - counted);
      int mismatch = err > SKID || err < -SKID;
      int over = v[1] > 2 * target;
      double dt = prev_time ? (v[0] - prev_time) / 1e6 : 0;
      printf("%12llu %12llu %9.3f%s%s\n",
             (unsigned long long)v[1], (unsigned long long)counted,
             dt, mismatch ? "  <- != counted" : "",
             over ? "  <- > 2x target" : "");
      bad |= mismatch || over;
      if (v[1] > max) max = v[1];
      prev_count = v[2];
      prev_time = v[0];
    }
    pos += h->size;
  }
  printf("target period %.0f, max period %llu (%.1fx): %s\n", target,
         (unsigned long long)max, max / target, bad ? "BUG" : "OK");
  return bad;
}

Thanks,
Gregg Leventhal
