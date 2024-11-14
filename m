Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692E1E9070
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550969; cv=none; b=etiLkgqXfocqMVmOHQwHH/hRcuNH9m7L2DGIfwDUg8eKSRk9AB06+a2JrlbQb42BO70YlDy3e3j2Bv3qQSAUtF9sztbpAhcfC8astwbfugiGAWZ2dPZg1ynDxAU+22H5cNVhpl6qU6THWeEIqPbcK+5IcnhV00Y5FCRxsfy7XJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550969; c=relaxed/simple;
	bh=EMkD5x/rX8Jv1ujpZkN7/y7bzHD+vr4hOvuQfDFFFmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWu7gouWyhlAazRuq1FKmbsgKQf2bI9758EN5jKkIRM3XjPGIGdii3k7X3j1SCedDzpPYEi8gq7kiKzNc1JvmiC5GlML8YlSKFY67ZxfWkPHvvuCSQRv3ctdg2jOAaqRXo0W2rm/ZQOrMqTTEr2wL+ASn+j58wAlLw3krrfnqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1qfzaAoO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1qfzaAoO"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ca4877690so38165ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 18:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731550965; x=1732155765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFjbyEhB6YlvQdLcxCY78EUF4TC4mFNmvglTPgbd4h0=;
        b=1qfzaAoO3lR/P8iWL16Dtch7tMRNql+qI2ZRTBCK04VFdm4PuvfhjTo6J5QCTb3zjA
         ctcDaTG8+bQ4FZ4e3HwDi7zBc9TTd7GzaffI/FMZHxA9G/XbgY7sPxbnqsmIbP2Jdb0t
         pEluD8IXf+UQAY8JAFJxZ1v9IUMsR4M1uJoQgg/esS2W6BfIKgo8hznqscWrU1XO9+2f
         /KeIohIpzjAcFkMT/i2Qu5Z2uQHhExAP7mrgFm9c2lrw54u1tFH+gXdI4iBxgyzjyCGN
         zWWklAZq5094BcJ6LVsiUTmNupHRsmrbVe1nETNHCLJWgCkXN+ic+25hcflFnwxvx6lS
         Skjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731550965; x=1732155765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFjbyEhB6YlvQdLcxCY78EUF4TC4mFNmvglTPgbd4h0=;
        b=J/N5F2P55bXoXXtnmhHrRrGuUbkUFimVQ0bVGTHWElLwjKHmBObO0nBnW8digzpz8e
         k7GfvxQf7xEg+C5WGQqGCXNy2yfYzw9F7lmTLJJOYUhg6xwdzGzr6dFcbDNPdellaMZY
         ZgQcbTeAtsDJKzu2K0109E/U3+OmMGyjyzw2wYgsq82GmXO49qWBeSePcKglOH5/ClyP
         ivd2ra1e6HrbenZggfbWuKw69p6DOHboa+PKCcbflbLMR6rkXoaAlQuG3fV3ltSzyzlo
         x/iXIoVtnrI9GRJg52Qv+USAcHGmWvA18SsYHS49cDLl3IXL0SQ0cyjYqOaNbYYTps+I
         qSaA==
X-Forwarded-Encrypted: i=1; AJvYcCVg2FDJyJnfSSc9rj32vD2ONIcrz6DxBiC2DvMoydSgZTXTR4Trvnjub/rdMJ6O4BM05Os1R6ADHNn8GsaTAfSM@vger.kernel.org
X-Gm-Message-State: AOJu0YwinHiQXl19MaToP21w4RXq9rj0xU7kQUrIDPlvkhQlX9v3h7Eb
	rIf/pAznLpMSe1MMRYH2jrQbxoHPZnnRLtKNsQWG/IIKYZDqviitQ2w9UrSVSaEpctMY4L74l6v
	ej3aTtA/k4m/7mmZwMcSDDBMLtl1W4zo114SU
X-Gm-Gg: ASbGnctJrL/TlGA+zby1OFxKKgWGmeZbjDTGfcPUwlO9MfXjpV0HntY1tkZSRJgPOt9
	GqHJB7NGJnZ/pnEwoDOi6yN9P8YJbn1BD
X-Google-Smtp-Source: AGHT+IEkHAxuNUMrQfjgKIWdSsYc7V/QUk6N1one1DotrFR+zPLsyGLzHOhroHdOV2Gkm0PwtDPFe6/yqGWMOs6bXdU=
X-Received: by 2002:a17:902:fa4f:b0:20b:13a8:9f86 with SMTP id
 d9443c01a7336-211c193f425mr1508925ad.28.1731550964983; Wed, 13 Nov 2024
 18:22:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107160721.1401614-1-deepak.surti@arm.com>
In-Reply-To: <20241107160721.1401614-1-deepak.surti@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 Nov 2024 18:22:33 -0800
Message-ID: <CAP-5=fU83dr8XR0_bO8ZHD2-K+YXmK7H-1evs9ERKJ3EiGLiFQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] A mechanism for efficient support for per-function metrics
To: Deepak Surti <deepak.surti@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.barnett@arm.com, ben.gainey@arm.com, 
	ak@linux.intel.com, will@kernel.org, james.clark@arm.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 8:08=E2=80=AFAM Deepak Surti <deepak.surti@arm.com> =
wrote:
>
> This patch introduces the concept on an alternating sample rate to perf
> core and provides the necessary basic changes in the tools to activate
> that option.
>
> This patchset was original posted by Ben Gainey out for RFC back in April=
,
> the latest version of which can be found at
> https://lore.kernel.org/linux-perf-users/20240422104929.264241-1-ben.gain=
ey@arm.com/.
> Going forward, I will be owning this.
>
> The primary use case for this change is to be able to enable collecting
> per-function performance metrics using the Arm PMU, as per the following
> approach:
>
>  * Starting with a simple periodic sampling (hotspot) profile,
>    augment each sample with PMU counters accumulated over a short window
>    up to the point the sample was take.
>  * For each sample, perform some filtering to improve attribution of
>    the accumulated PMU counters (ensure they are attributed to a single
>    function)
>  * For each function accumulate a total for each PMU counter so that
>    metrics may be derived.
>
> Without modification, and sampling at a typical rate associated
> with hotspot profiling (~1mS) leads to poor results. Such an
> approach gives you a reasonable estimation of where the profiled
> application is spending time for relatively low overhead, but the
> PMU counters cannot easily be attributed to a single function as the
> window over which they are collected is too large. A modern CPU may
> execute many millions of instructions over many thousands of functions
> within 1mS window. With this approach, the per-function metrics tend
> to trend to some average value across the top N functions in the
> profile.
>
> In order to ensure a reasonable likelihood that the counters are
> attributed to a single function, the sampling window must be rather
> short; typically something in the order of a few hundred cycles proves
> well as tested on a range of aarch64 Cortex and Neoverse cores.
>
> As it stands, it is possible to achieve this with perf using a very high
> sampling rate (e.g ~300cy), but there are at least three major concerns
> with this approach:
>
>  * For speculatively executing, out of order cores, can the results be
>    accurately attributed to a give function or the given sample window?
>  * A short sample window is not guaranteed to cover a single function.
>  * The overhead of sampling every few hundred cycles is very high and
>    is highly likely to cause throttling which is undesirable as it leads
>    to patchy results; i.e. the profile alternates between periods of
>    high frequency samples followed by longer periods of no samples.
>
> This patch does not address the first two points directly. Some means
> to address those are discussed on the RFC v2 cover letter. The patch
> focuses on addressing the final point, though happily this approach
> gives us a way to perform basic filtering on the second point.
>
> The alternating sample period allows us to do two things:
>
>  * We can control the risk of throttling and reduce overhead by
>    alternating between a long and short period. This allows us to
>    decouple the "periodic" sampling rate (as might be used for hotspot
>    profiling) from the short sampling window needed for collecting
>    the PMU counters.
>  * The sample taken at the end of the long period can be otherwise
>    discarded (as the PMU data is not useful), but the
>    PERF_RECORD_CALLCHAIN information can be used to identify the current
>    function at the start of the short sample window. This is useful
>    for filtering samples where the PMU counter data cannot be attributed
>    to a single function.

I think this is interesting. I'm a little concerned on the approach as
I wonder if a more flexible mechanism could be had.

One approach that wouldn't work would be to open high and low
frequency events, or groups of events, then use BPF filters to try to
replicate this approach by dropping most of the high frequency events.
I don't think it would work as the high frequency sampling is likely
going to trigger during the BPF filter execution, and the BPF filter
would be too much overhead.

Perhaps another approach is to change the perf event period with a new
BPF helper function that's called where we do the perf event
filtering. There's the overhead of running the BPF code, but the BPF
code could allow you to instead of alternating between two periods
allow you to alternate between an arbitrary number of them.

Thanks,
Ian

> There are several reasons why it is desirable to reduce the overhead and
> risk of throttling:
>
>   * PMU counter overflow typically causes an interrupt into the kernel;
>     this affects program runtime, and can affect things like branch
>     prediction, cache locality and so on which can skew the metrics.
>   * The very high sample rate produces significant amounts of data.
>     Depending on the configuration of the profiling session and machine,
>     it is easily possible to produce many orders of magnitude more data
>     which is costly for tools to post-process and increases the chance
>     of data loss. This is especially relevant on larger core count
>     systems where it is very easy to produce massive recordings.
>     Whilst the kernel will throttle such a configuration,
>     which helps to mitigate a large portion of the bandwidth and capture
>     overhead, it is not something that can be controlled for on a per
>     event basis, or for non-root users, and because throttling is
>     controlled as a percentage of time its affects vary from machine to
>     machine. AIUI throttling may also produce an uneven temporal
>     distribution of samples. Finally, whilst throttling does a good job
>     at reducing the overall amount of data produced, it still leads to
>     much larger captures than with this method; typically we have
>     observed 1-2 orders of magnitude larger captures.
>
> This patch set modifies perf core to support alternating between two
> sample_period values, providing a simple and inexpensive way for tools
> to separate out the sample window (time over which events are
> counted) from the sample period (time between interesting samples).
>
> It is expected to be used with the cycle counter event, alternating
> between a long and short period and subsequently discarding the counter
> data for samples with the long period. The combined long and short
> period gives the overall sampling period, and the short sample period
> gives the sample window. The symbol taken from the sample at the end of
> the long period can be used by tools to ensure correct attribution as
> described previously. The cycle counter is recommended as it provides
> fair temporal distribution of samples as would be required for the
> per-symbol sample count mentioned previously, and because the PMU can
> be programmed to overflow after a sufficiently short window (which may
> not be possible with software timer, for example). This patch does not
> restrict to only the cycle counter, it is possible there could be other
> novel uses based on different events, or more appropriate counters on
> other architectures. This patch set does not modify or otherwise disable
> the kernel's existing throttling behaviour; if a configuration is given
> that would lead high CPU usage, then throttling still occurs.
>
>
> To test this a simple `perf script` based python script was developed.
> For a limited set of Arm PMU events it will post process a
> `perf record`-ing and generate a table of metrics. Along side this a
> benchmark application was developed that rotates through a sequence
> of different classes of behaviour that can be detected by the Arm PMU
> (eg. mispredicts, cache misses, different instruction mixes). The path
> through the benchmark can be rotated after each iteration so as to
> ensure the results don't land on some lucky harmonic with the sample
> period. The script can be used with and without this patch allowing
> comparison of the results. Testing was on Juno (A53+A57), N1SDP,
> Gravaton 2 and 3. In addition this approach has been applied to a few
> of Arm's tools projects and has correctly identified improvements and
> regressions.
>
> Headline results from testing indicate that ~300 cycles sample window
> gives good results with or without this patch. Typical output on N1SDP (N=
eoverse-N1)
> for the provided benchmark when run as:
>
>     perf record -T --sample-cpu --call-graph fp,4 --user-callchains \
>         -k CLOCK_MONOTONIC_RAW \
>         -e '{cycles/period=3D999700,alt-period=3D300/,instructions,branch=
-misses,cache-references,cache-misses}:uS' \
>         benchmark 0 1
>
>     perf script -s generate-function-metrics.py -- -s discard
>
> Looks like (reformatted for email brevity):
>
>     Symbol              #     CPI   BM/KI  CM/KI  %CM   %CY   %I    %BM  =
 %L1DA  %L1DM
>     fp_divider_stalls   6553   4.9   0.0     0.0   0.0  41.8  22.9   0.1 =
  0.6    0.0
>     int_divider_stalls  4741   3.5   0.0     0.0   1.1  28.3  21.5   0.1 =
  1.9    0.2
>     isb                 3414  20.1   0.2     0.0   0.4  17.6   2.3   0.1 =
  0.8    0.0
>     branch_mispredicts  1234   1.1  33.0     0.0   0.0   6.1  15.2  99.0 =
 71.6    0.1
>     double_to_int        694   0.5   0.0     0.0   0.6   3.4  19.1   0.1 =
  1.2    0.1
>     nops                 417   0.3   0.2     0.0   2.8   1.9  18.3   0.6 =
  0.4    0.1
>     dcache_miss          185   3.6   0.4   184.7  53.8   0.7   0.5   0.0 =
 18.4   99.1
>
> (CPI =3D Cycles/Instruction, BM/KI =3D Branch Misses per 1000 Instruction=
,
>  CM/KI =3D Cache Misses per 1000 Instruction, %CM =3D Percent of Cache
>  accesses that miss, %CY =3D Percentage of total cycles, %I =3D Percentag=
e
>  of total instructions, %BM =3D Percentage of total branch mispredicts,
>  %L1DA =3D Percentage of total cache accesses, %L1DM =3D Percentage of to=
tal
>  cache misses)
>
> When the patch is used, the resulting `perf.data` files are typically
> between 25-50x smaller than without, and take ~25x less time for the
> python script to post-process. For example, running the following:
>
>     perf record -i -vvv -e '{cycles/period=3D1000000/,instructions}:uS' b=
enchmark 0 1
>     perf record -i -vvv -e '{cycles/period=3D1000/,instructions}:uS' benc=
hmark 0 1
>     perf record -i -vvv -e '{cycles/period=3D300/,instructions}:uS' bench=
mark 0 1
>
> produces captures on N1SDP (Neoverse-N1) of the following sizes:
>
>     * period=3D1000000: 2.601 MB perf.data (55780 samples), script time =
=3D 0m0.362s
>     * period=3D1000: 283.749 MB perf.data (6162932 samples), script time =
=3D 0m33.100s
>     * period=3D300: 304.281 MB perf.data (6614182 samples), script time =
=3D 0m35.826s
>
> The "script time" is the user time from running "time perf script -s gene=
rate-function-metrics.py"
> on the recording. Similar processing times were observed for "time perf r=
eport --stdio|cat"
> as well.
>
> By comparison, with the patch active:
>
>     perf record -i -vvv -e '{cycles/period=3D999700,alt-period=3D300/,ins=
tructions}:uS' benchmark 0 1
>
> produces 4.923 MB perf.data (107512 samples), and script time =3D 0m0.578=
s.
> Which is as expected ~2x the size and ~2x the number of samples as per
> the period=3D1000000 recording. When compared to the period=3D300 recordi=
ng,
> the results from the provided post-processing script are (within margin
> of error) the same, but the data file is ~62x smaller. The same affect
> is seen for the post-processing script runtime.
>
> Notably, without the patch enable, L1D cache miss rates are often higher
> than with, which we attribute to increased impact on the cache that
> trapping into the kernel every 300 cycles has.
>
> These results are given with `perf_cpu_time_max_percent=3D25`. When teste=
d
> with `perf_cpu_time_max_percent=3D100` the size and time comparisons are
> more significant. Disabling throttling did not lead to obvious
> improvements in the collected metrics, suggesting that the sampling
> approach is sufficient to collect representative metrics.
>
> Cursory testing on a Xeon(R) W-2145 with a 300 *instruction* sample
> window (with and without the patch) suggests this approach might work
> for some counters. Using the same test script, it was possible to identif=
y
> branch mispredicts correctly. However, whilst the patch is functionally
> correct, differences in the architectures may mean that this approach it
> enables does not apply as a means to collect per-function metrics on x86.
>
> Changes since RFC v2:
>  - Rebased on v6.12-rc6.
>
> Changes since RFC v1:
>  - Rebased on v6.9-rc1.
>  - Refactored from arm_pmu based extension to core feature
>  - Added the ability to jitter the sample window based on feedback
>    from Andi Kleen.
>  - Modified perf tool to parse the "alt-period" and "alt-period-jitter"
>    terms in the event specification.
>
> Ben Gainey (4):
>   perf: Allow periodic events to alternate between two sample periods
>   perf: Allow adding fixed random jitter to the alternate sampling
>     period
>   tools/perf: Modify event parser to support alt-period term
>   tools/perf: Modify event parser to support alt-period-jitter term
>
>  include/linux/perf_event.h                    |  5 ++
>  include/uapi/linux/perf_event.h               | 13 ++++-
>  kernel/events/core.c                          | 47 +++++++++++++++++++
>  tools/include/uapi/linux/perf_event.h         | 13 ++++-
>  tools/perf/tests/attr.c                       |  2 +
>  tools/perf/tests/attr.py                      |  2 +
>  tools/perf/tests/attr/base-record             |  4 +-
>  tools/perf/tests/attr/base-record-spe         |  2 +
>  tools/perf/tests/attr/base-stat               |  4 +-
>  tools/perf/tests/attr/system-wide-dummy       |  4 +-
>  .../attr/test-record-alt-period-jitter-term   | 13 +++++
>  .../tests/attr/test-record-alt-period-term    | 12 +++++
>  tools/perf/tests/attr/test-record-dummy-C0    |  4 +-
>  tools/perf/util/parse-events.c                | 30 ++++++++++++
>  tools/perf/util/parse-events.h                |  4 +-
>  tools/perf/util/parse-events.l                |  2 +
>  tools/perf/util/perf_event_attr_fprintf.c     |  1 +
>  tools/perf/util/pmu.c                         |  2 +
>  18 files changed, 157 insertions(+), 7 deletions(-)
>  create mode 100644 tools/perf/tests/attr/test-record-alt-period-jitter-t=
erm
>  create mode 100644 tools/perf/tests/attr/test-record-alt-period-term
>
> --
> 2.43.0
>
