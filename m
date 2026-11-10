Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794329361;
	b=VgXwQMq/7B18nrzFisEhPxuBV63leq7wcm0IMCadZ+gg7BZYl/xn0PskfrFQ1LZxm8Wn
	 DJomZ5cYxJszhRx3cSqe+zDrh04umAOHPbv6JniYIfYh3EJzP2PJ8Q57lK9L6o6y8X/nt
	 2kBXX7XmpdJTJ2gyIJ2o634CXo22hkCQdez55n43s85ZN5YuMeE3UcgBwRmhi21THGPN6
	 tOYnuARNcja62KU53dm/9Z5fGfrXOc05ZcYlgW7pNhRaaJS2OB+zktRa+yotIDcg/KJ8+
	 0uLswM0IKyQVRyE36guscl9GndkiPCSEb1hd1/iZGJv1dHH76u3uUGYxbPltffNh4SA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zlvgwtkrRqBrKyD8hhuPjHxDMNdzszs/sF7zsrz6Lcs=;
	b=BpUOiRSJ+M5YZNSPH/XJhsAKmvWYiNhP3uX41brmW9xJlmZbjRs21c0J9qwKWYuyH1Ez
	 99HTXGgTsZskpkzPs1zRj96DjotT3KfJz/DQef9XZZqTWDSGeEAZvuA5us3y1QbCJfFZG
	 waxfKUGzMcF4s+xeHSF6dg8Aeaa3E4g9LHN92cX5k2kxxazF4DqrzFF9VwFoK0Gn5HLfx
	 /ZPvvaLStF6mp1ARPWG8DNqsVA+l/8Cn+bHOPP6MBh5Vuff3pvOA+BGbHj3Fff3Yzqbcj
	 vilJ0v/a7GgrpK6z+xCQWnB4eVNM81ydPiH9XdgihKFE5e8LfMHwDq0H04nj0EY8dwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wrwwb8RZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA79606A325
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 16:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEA79606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wrwwb8RZ
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-533202fe429so269991cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 08:49:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794329360; cv=none;
        d=google.com; s=arc-20260327;
        b=bqMqLj757Xq2TrydSsYEq3qSdp8O0bzuG5J0DfQuDFZseLwjfP90xbhrabRP9BkXYP
         9/KbZ4W0cGNpCrcMf0U8xnsUARoieQLM4crLZsg/zZ2ytw8NXSr/GI1mR+bGGSFVos+y
         gMFw9uX17RK64B27t1Q8Hc6ua+54iC6JKB3T9fqZuqHgnxcWzbf+euzR0LgDuhj9o+6x
         1vpKEuPTLIUHNseN0GclIMQ2bYximw6ALF9fFtN7iCxCBcGDp+SC0uYf0K7z0sZ5iNyV
         D9weJH1fieCmC/lLIPyXV3TS6FDJOwGsO+JzRubDjykR21N/ZfHpTzTP+xcYOXjo5Tel
         kSrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zlvgwtkrRqBrKyD8hhuPjHxDMNdzszs/sF7zsrz6Lcs=;
        fh=VCkIxaW7Y1qLuIqQZkPXPrwa7HZxQtINLtNjkds5gZM=;
        b=rrbSP6IqpaTBkAlSYGXPJ7xx9e2iyI2ecFilGNX/5urnDH/YFSauxTTHEVcwyMlgio
         /jUiU3E7e4gn6QLHgq5yg7HojUkHhCLDhHUNRr4/86vh4gOOBJdiGxEuAqf8I8aWxqGW
         kj9Prwmg6WGs/lF0dnzUe7x4b1xQcHYBbIN2vaUvVJPMHPv/rh9uGI9+2kFwhvRh5B2z
         nflyholWwN9ALPy84IjWWSHCCfmLWsnMHkaeNKxREURnLP1s2rCPpo/7Lbj5xPsmnaiO
         WAfVTEQUnjA5xlVK4IpfHlYbnVcafmosEuajde/Rt3za4qMbmZwVqaq/S9SJw0nTtqmn
         5OnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794329360; x=1794934160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zlvgwtkrRqBrKyD8hhuPjHxDMNdzszs/sF7zsrz6Lcs=;
        b=Wrwwb8RZMcN+OuQWx3WQ2ei6Vk4em051JvTzan5xfnnBa+3Hd9Vzt3whmnlZXMvJmr
         CM/WMppNYR1MYm6O8gO21DkXr4qr+mRQ8/tBRigH8fFZ7NBw+juEgAbxJOPXw0i6zzor
         MTB7V3OBgWmFL5S4pGfVPiqLBiFuN2sI3GOa5uNdbMNKXqzQAbRf2+9k5SyXB98a9W9m
         y66jEDPD/4InIauMucDL0w2B4I/xXO5RffedrVMzGmz10kZTE5ioYYP2Ci2AWFuHCgMH
         EP1IC0WbOOs9ASzH2EXPtCGUlKHZMo+mg0Rz1DZjaU7SHevMI1mVn26tJ4OpzArwmC13
         Amxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329360; x=1794934160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zlvgwtkrRqBrKyD8hhuPjHxDMNdzszs/sF7zsrz6Lcs=;
        b=Fhr3W0Refm1tK3GoJI+L2PmNruAutStuWpHBQ9DGprTwkPo73g8ha8KDSZq3cwqV1D
         sN/9H/NwE+piyJYHab3dRVhF74DLVVA9FWQsGlmEbxMHSsK23TNoNATe6NKjOnOmdBjc
         ZK31tK3vzyZgyvVfAWfgw9hq3c9AponsPECHPaF2QXGkJAafg3Enx+0nAva9MC+PMmXB
         yCbUe7Ptmk0+h9TlpLMg8bi+iy3cXTecGl6CTNtjA23StU+HJbgcrvPIzjO8YeKxDGuc
         uVweNUdKqGq7tJayBgBWOkH/TnsyO5gKFFjnmy3KSCehLmcUoHEpSo2PEnRWTKHIDmgQ
         8xmw==
X-Forwarded-Encrypted: i=1; AL+hErHLTBKcXt6vOCvBnQJrDQSPWmNI7W/lAA35vXGl0mw09UPLi7/hOj+QiYtXv2WfwX81fAxTVkAMEkeg4jDs+2zb@vger.kernel.org
X-Gm-Message-State: APuU4Z/mTKyPrF+mR0HERSNM3eyr2cx65wTuK2xE9VOqop1u/r8VEQg4
	aMCVZn87scJP5Fa1hsEjHAZqU16EgJPlfFYZ99XQRTFEj0+h8ef7OxQIhUlEZwznr0mvj8Vb/G9
	U/WFZvjaW7ZcsCba2jLQnoSVk0QL2OcW+i3FXZAhS
X-Gm-Gg: AYBFou2cBMhioobNZBi+ApEYsH7tiDJol7obfg5kTcThbqbXtAY+ij+5+OPjirLg/8j
	MwxB/c//A1lJSpdMnoc2IZhzjksKLGYZuaudXLYsXiTWiwYNSJ4+Zoih8uwuSXzg8iJLQ7Y5mg1
	cEtvcRg9SjNHlAodtBE60P9RiuwNxuPshZ5FAdpD+3tDFIvBtUOoeb/KhQTnpovuPY7t6/HFOKh
	fU7LkMmjRpTK3hWP8OBusE80AHM4N18iizpyAoWKFeuzob60JKrefV9EzkpcGSK7BiP5gr32nWi
	k+bloIGl5w3cY/16qJel/TjlDuMxK9m4pZ5WiakcjyFyJ4RNVjO36kfLen0pU5h6Bc7npFlc/AQ
	o67X4t1e+9beN+3cAhThtgWGoyJ0rcRUnKxJRQX19ctWq8B3yzux3tZrhK4G/JAQtZgZd3GYE/B
	lo35HhkDHZ4CEg
X-Received: by 2002:a05:622a:4ccd:b0:536:3d22:fb83 with SMTP id
 d75a77b69052e-55552e12e96mr17913741cf.13.1794329358807; Tue, 10 Nov 2026
 08:49:18 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
 <20261109-james-perf-test-fixes-v4-4-355ee6b81917@linaro.org>
 <CAP-5=fX-AuoMOL+yPXw2FsdcC5Xg7qkb-Q038U3BeB+P+Rf_Yg@mail.gmail.com> <2c48c893-9ab5-4883-bafb-a2580b76c4c1@linaro.org>
In-Reply-To: <2c48c893-9ab5-4883-bafb-a2580b76c4c1@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Nov 2026 08:49:07 -0800
X-Gm-Features: AclHuK-rdkjE7omauEbuYBY4u2l0UMkCaFzsGPJHVInYk0HsEdQiDpmKPGZHwgE
Message-ID: <CAP-5=fUEv49Yymvw+EOwQmmKyOHqSKhRexJG_PC6HRTtgCqR=A@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] perf test: Don't starve per-process tests with
 system-wide events
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jakub Brnak <jbrnak@redhat.com>, Leo Yan <leo.yan@arm.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 4:30=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 09/11/2026 17:47, Ian Rogers wrote:
> > On Mon, Nov 9, 2026 at 5:48=E2=80=AFAM James Clark <james.clark@linaro.=
org> wrote:
> >>
> >> Some tests intermittently fail when run in parallel, for example "Chec=
k
> >> branch stack sampling" fails with no branches recorded at all.
> >>
> >> The default event is cycles:P which there may only be 1 or 2 HW counte=
rs
> >> for on Intel because it's precise. System wide or per-core precise
> >> events hog the HW counter leaving other per-process tests with no
> >> samples. Rather than make all the tests that use default record comman=
ds
> >> run serially, just make the system wide ones use a software event whic=
h
> >> has the greatest possible compatibility. They don't need precise
> >> sampling or HW counters anyway. The per-process tests can be left alon=
e
> >> as their events/processes never run concurrently on any one core.
> >>
> >> The LBR filter is another resource shared by all events on a CPU, and
> >> the system-wide LBR test uses different filters to the per-process
> >> branch stack test, so mark the LBR test as exclusive.
> >
> > Thanks for deflaking the tests! Making the LBR test exclusive is
> > pragmatic; however, it also feels like a shame since recording LBR
> > data in parallel should be something we expect users to do.
> >
> > For PMUs that can have a single user we have logic which prints
> > conflicting users in dump_perf_event_processes:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/evsel.c?h=3Dperf-tools-next#n4519
> >
> > I wonder if, when we get zero counts or no samples we could perform a
> > similar analysis and report conflicting users=E2=80=94though this would
> > inherently be racy. If we had that, maybe we could just repeat the LBR
> > tests until there are no conflicting users and not need the exclusive
> > tag.
> >
>
> Yeah re-running the test for certain failures would probably work well.
> But at the same time if we know certain resources are limited and we're
> running per-CPU and per-thread events at the same time in a way that we
> know won't multiplex at all, maybe it would be better to re-write the
> parallel tests to only use per-thread events.
>
> Even when multiplexing works there can be issues. For example another
> flake I looked at was in the metrics tests. Some of them test that the
> ratios don't exceed 100% for example, but multiplexing can break this
> assumption if all the counters in the metric are only in a weak group
> and they aren't always scheduled at the same time. There was a lot to
> unpick in that one so I dropped it. But it's a similar problem.

So because events are grouped, they should be scheduled in and out
together. Yes a weak group can be broken, but that shouldn't happen
with some caveats:

1) The NMI watchdog should be gone because the buddy watchdog is good
and doesn't take a counter. There's still tech debt because the buddy
watchdog calls itself the NMI watchdog in procfs and the perf tool
warns accordingly. Hopefully we're defaulting to the buddy watchdog
these days. Rather than a boot option I wanted the watchdog to be
selectable at runtime: none, buddy or NMI. Again, the hardest problem
in CS is naming things and the buddy watchdog people made some now
questionable choices.
2) The scaling of events on hybrid/BIG.little systems is broken. I
sent out this RFC and should really push on it more:
https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.com/
.

So the value test should never flake, and the fact that it does points
to real bugs, both of which are in the kernel.

> I think some of the kernel PMU scheduling and sharing decisions expect
> that any root user running things per-CPU is "well behaved" or
> understands the impact to other users that their events might have. And
> we're probably not doing that enough in the tests to honor that.

An area I think we're bad on is BPF perf event filtering. The tracing
code has notions of instances, we lack similar concepts for perf
events, so one profiler may derail another. I think we can improve
multiplexing by taking inspiration from the EEVDF scheduler. Again, I
have some plans and paper improvements in this area, but the challenge
is getting feedback.

> Another example for this is with Arm BRBE. There are multiple counters
> on the PMU, so you can have multiple events, but there's only one BRBE
> and one filter, and the branch history is limited. The driver takes the
> union of filters for all the PMU events running and then post processes
> the branch buffer for each user to not leak anything from the other
> event's filter. But imagine that one test gives a certain restricted
> filter and expects to completely fill up the branch buffer, and that
> exact full buffer is required for the test. When another root event runs
> in parallel on the same core, the filter can be widened and the buffer
> gets blown up with other branches that weren't interesting to the other
> test, and are filtered out by the driver anyway making it fail.

I think we should avoid system wide profiling for the tests, that
should mitigate issues like this. We need system-wide profiling for
uncore events.

Thanks,
Ian

> > Anyway, doing all of that is a bigger project.
> >
>
> Yep. and maybe something to keep in mind for any new tests or when doing
> further flake investigations.
>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
>
> Thanks!
>
> > Thanks,
> > Ian
> >
> >> This fixes the "Check branch stack sampling" test and other flakes whe=
n
> >> a system-wide record from another test runs at the same time, for
> >> example:
> >>
> >>    $ sudo perf record -a -o /dev/null -- sleep 30 &
> >>    $ sudo perf test -vvv "Check branch stack sampling"
> >>    ...
> >>    Testing user branch stack sampling
> >>    ERROR: Branches missing ^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IN=
D_CALL/.*$
> >>    ...
> >>    Testing user branch stack sampling [Failed]
> >>    ...
> >>    Testing branch stack filtering permutation (call,CALL|SYSCALL)
> >>    Testing branch stack filtering [Failed empty script output]
> >>    ...
> >>    ---- end(-1) ----
> >>    138: Check branch stack sampling : FAILED!
> >>
> >> Signed-off-by: James Clark <james.clark@linaro.org>
> >> ---
> >>   tools/perf/tests/shell/record.sh          | 6 +++---
> >>   tools/perf/tests/shell/record_lbr.sh      | 2 +-
> >>   tools/perf/tests/shell/record_sideband.sh | 4 ++--
> >>   3 files changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell=
/record.sh
> >> index 01dc3e22fa73..e4789e2bcf43 100755
> >> --- a/tools/perf/tests/shell/record.sh
> >> +++ b/tools/perf/tests/shell/record.sh
> >> @@ -388,7 +388,7 @@ test_system_wide() {
> >>     echo "Basic --system-wide mode test"
> >>     local ret=3D0
> >>     perf_record_with_retry "${perfdata}" "check_system_wide" "perf tes=
t -w thloop" \
> >> -    -aB --synth=3Dno || ret=3D$?
> >> +    -aB --synth=3Dno -e cpu-clock || ret=3D$?
> >>     if [ $ret -eq 2 ]; then
> >>       echo "System-wide record [Skipped not supported]"
> >>       return
> >> @@ -471,7 +471,7 @@ test_cgroup() {
> >>     echo "Cgroup sampling test"
> >>     local ret=3D0
> >>     perf_record_with_retry "${perfdata}" "check_cgroup" "perf test -w =
thloop" \
> >> -    -aB --synth=3Dcgroup --all-cgroups || ret=3D$?
> >> +    -aB --synth=3Dcgroup --all-cgroups -e cpu-clock || ret=3D$?
> >>     if [ $ret -eq 2 ]; then
> >>       echo "Cgroup sampling [Skipped not supported]"
> >>       return
> >> @@ -491,7 +491,7 @@ test_uid() {
> >>     echo "Uid sampling test"
> >>     local ret=3D0
> >>     perf_record_with_retry "${perfdata}" "check_uid" "perf test -w thl=
oop" \
> >> -    -aB --synth=3Dno --uid "$(id -u)" || ret=3D$?
> >> +    -aB --synth=3Dno --uid "$(id -u)" -e cpu-clock || ret=3D$?
> >>     if [ $ret -eq 2 ]; then
> >>       local logfile=3D"${PERF_RECORD_LOGS[${#PERF_RECORD_LOGS[@]}-1]}"
> >>       if grep -q -E "libbpf.*EPERM|Access to performance monitoring" "=
$logfile" || \
> >> diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/s=
hell/record_lbr.sh
> >> index 8d51afeb437b..6b6af59db871 100755
> >> --- a/tools/perf/tests/shell/record_lbr.sh
> >> +++ b/tools/perf/tests/shell/record_lbr.sh
> >> @@ -1,6 +1,6 @@
> >>   #!/bin/bash
> >>   # SPDX-License-Identifier: GPL-2.0
> >> -# perf record LBR tests
> >> +# perf record LBR tests (exclusive)
> >>
> >>   set -e
> >>
> >> diff --git a/tools/perf/tests/shell/record_sideband.sh b/tools/perf/te=
sts/shell/record_sideband.sh
> >> index 2182551873be..f16889e3fa9a 100755
> >> --- a/tools/perf/tests/shell/record_sideband.sh
> >> +++ b/tools/perf/tests/shell/record_sideband.sh
> >> @@ -22,7 +22,7 @@ trap trap_cleanup EXIT TERM INT
> >>
> >>   can_cpu_wide()
> >>   {
> >> -    if ! perf record -o ${perfdata} -BN --no-bpf-event -C $1 true > /=
dev/null 2>&1
> >> +    if ! perf record -o ${perfdata} -BN --no-bpf-event -e cpu-clock -=
C $1 true > /dev/null 2>&1
> >>       then
> >>           echo "record sideband test [Skipped cannot record cpu$1]"
> >>           err=3D2
> >> @@ -39,7 +39,7 @@ test_system_wide_tracking()
> >>       can_cpu_wide 1 || return 0
> >>
> >>       # Record on CPU 0 a task running on CPU 1
> >> -    perf record -BN --no-bpf-event -o ${perfdata} -C 0 -- taskset --c=
pu-list 1 true
> >> +    perf record -BN --no-bpf-event -e cpu-clock -o ${perfdata} -C 0 -=
- taskset --cpu-list 1 true
> >>
> >>       # Should get MMAP events from CPU 1
> >>       mmap_cnt=3D`perf script -i ${perfdata} --show-mmap-events -C 1 2=
>/dev/null | grep MMAP | wc -l`
> >>
> >> --
> >> 2.43.0
> >>
>
