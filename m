Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794246482;
	b=cehCZRNcFmrdv7+PKHEckDc2s2PkJ70k/AlUU1KhyXclWQit18+7S7XmonWmCeaIY7N5
	 ohvoQh4vc6U3/q6bnN1qWDwX5+nEBGkWrhyY0Vtz/dimLBp+HmSDf80i0y1bLLf1D48er
	 oFg4cTyVLkrdNBb0hS311yVdS11m3MyXZDevCfmgEZDUUbG/gA/fvowVZ4RmP+llMaqyh
	 KOnvfPWfdQhtIVolCbBE4/dYZDA+jAuPFyWE4S+Ip/pl/vehImEhiYKX6EkKDXEi0jGYj
	 Jh5VlnQlbwG7PzMZgoOvdAmvgZIqy0WyqSKKAAJ34Hpxfx17oK7Rvc9Q3YPYy8r1Nwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RHWJdH5skqZXvBWkiRsFGkN+eeAfmyFX8crg4i6q9fE=;
	b=GhkLRyF6uP4ZGg5sZ/XOSSSJKzfEriiUkfEiisPrFs0zz7RSzeCVGKckIK/6NGHhdDak
	 bF3TUYK/YLV3Vn705YlX01RqAEov7FVyPgPB22QMNNI8HRCG9gHYtEk51gaOyK8+6DuB0
	 xZTaL8a8PMg6MmGqQmFJPo4dwxZJx8WnAUtupP60VEtUJ/8nbUIb73tiBdh0W7fl+0jUX
	 JBhiP4WG022m+1TI5bT9seDe4aW3+tnEMScEnzoq68QZ+3p7LhcLbsmfto8PcfseihkWL
	 NPeSWr05Ir+wfuK1icJYLSmmmhdm1KxrjkcGAEjmY7sq5svW0y5EmhRmJrmJok5bHhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e7luoZgK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F03606A331
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 17:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F03606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e7luoZgK
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-535f598d126so330031cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 09:48:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794246481; cv=none;
        d=google.com; s=arc-20260327;
        b=DG4sZOMKJR9UIWbn2yLNgd4KaZLJ3gb0nr/5tULjOLR8omIcIeXXn+bj9ue+ygG7ex
         /KUjwry4yXSHiS70Wl+ifG7bs+l4DQNEeAwZVSqpgadFo254Vc74nDmr/Hf4tdaajuFg
         dsJoxygrwJqmIBd4maaaXvPrs5jI2koYPdtqsN2S2f2b3rcYbEWVJdqhMVqEpCQHyo2b
         tqnx0/ZSkKgZicQRB42CM24rTwSIa/E3w1paGSk0IlV8ig87xRIfqiGUhYao57A0o7sZ
         htx04tzquB22P0JBPmiTIFyTsRT1eCJNJY2xpXWxXlnYuag2mxeyxEjDzsmsoWkZRfLx
         uDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RHWJdH5skqZXvBWkiRsFGkN+eeAfmyFX8crg4i6q9fE=;
        fh=5LCk6TZcSrVTQKhwmDf5hWrkrx7mwtIVk7i5pciRl44=;
        b=kslONazDE2TnUT3ri1ZiFtyo5PZ4vF8uqSmSL1XzHsj7t7JRrCsxmhtqZDgu5OXPhO
         hatOgeFtOIlmBmvxIktbwBJbibW2Jd7PdWZo2QSkhXtGLsIqFkZ9mhUFWwb1TKhK/Ybu
         hSSBkqTySThzkCkzMb4QP+qV2qUWVf3nC9I9AKmAu5B+ITaabaUqOF0v6LrIGTiWuw+K
         kW+noA8rowmCW5RZO0dxY+IrhVzTs/JvJy6V0CYPaEyRtI+53cS2teiuqsHAiIcn/br+
         4u4yT2q50IItAQyj8OFA5Y7rSUiHLpC0X6j2zh2NzZ1aLeF9hjsDuIjkjOMDfxpfctDH
         ZBrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794246481; x=1794851281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RHWJdH5skqZXvBWkiRsFGkN+eeAfmyFX8crg4i6q9fE=;
        b=e7luoZgKdFIUo5hbvQSn6rqFRD5CzWlMTTSkTRTB1VXOmCIqs8luvmwU1zRN7My+Ct
         FkMJlL2s1vnNrSQoNQKxUo5uyKgI/sasI3IZuNf/S8g7bcH3uc9mlexL/9wRcEpNgAon
         rCOPsapTJmj1N3f1BoI5ztLtIoClLhnDVPjvOr9BwDQZ0t7Ns5c84/cbFcB+uePhLOWL
         ckV064egvW8UZylUzq/CdFuv+O7RAy+r1QqvruW1+7eBNYqF3+Dv+751wa32NRhFDvpe
         S/6CoXjZFxnJsJ1iw1ezJ/+bXdzpLt+qTnHCnuVzn5do9vBeA41jh7i0NpQHm4M3KvUd
         ZY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794246481; x=1794851281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RHWJdH5skqZXvBWkiRsFGkN+eeAfmyFX8crg4i6q9fE=;
        b=j2YlbkGOuzC4ZUApPOsyyEeohXI70gULxLBNgvNkXaJbFhVSO9iWOZL6as/vM/x10p
         f9a46CTbOMYPpODCmoryIxe0Gcd3ZDjAvmfr/PYsf5WIFnEyzSWx9XrzZ+g6+WFmGU8W
         bMDRnlYknJhFGg1/m5/lDDqgj6SMPmI2hyYPaBPBNc60I5DhZu8whbV349GwwsHlGC8d
         6yKXYGhHlnlFZBth7m43Bp6s/N4A2uT+vQ+1aUiFAVu77Udo/kqpsfPgemsYZDYdVRaL
         rRhVEfJDUFh/orAwbnAJZCA+AkZ/Gs3TYWjqFuhAaDqKDb3Z2ia1gqaygiHbuDISahhy
         TXmg==
X-Forwarded-Encrypted: i=1; AL+hErEVZYkOwUefQy1pP0YKlF/4jl//LFpALiFnUfmGRYgECu7A/M4MvZCYub2pzaOJWcoTmR6RiYw4WUjI88Qjg06L@vger.kernel.org
X-Gm-Message-State: APuU4Z9UADj35aQDpysVuD9TUH4121vQ2v+e57UOLqXr9vSZN10kcTxT
	PeQYpYYcPsnyIRuo17EGtPYGGW9mXY/OM/VRMuhavLEGcuZ/k0eiItHOpIf4x0fcM0iGOyTQgSC
	GCTVUDHqNHXH5ETsT2Fympvettq3qNj5QXqtNFTx088F7rwlqhV794CTajxA=
X-Gm-Gg: AYBFou16gHWiHg8+mTZVQ2bRoGUxdYzgGuX0zHy6wQqKQ8BDjwpmpnr2W2QKsvgCqjN
	AhbUaMbPbiwS6ChGXNAuMs64ctlGbgoek+BAfMEnNOPD4MMnv2PXnKQTJFexiEfRLjRFTkgQzUP
	EzTsrMKF2MDarSYJjhS00vf2UCDZpySIUbaFBZu0PCsRuoikkDbtivRwjZdUYeQbKrV8bJ4lgrX
	fkBAy8wS1Y4UaOL4NNwXrU0DqbAAzsPXFRN9yiOxmBMm5d8zxZI0YVM+Xh3Fwwp7m3Y87EkDIec
	5JrXJG+PrTz1WPkGavzGge4sn1U4lEpEwr2rrEJb8lOar7qR6cPBZ24EC+vnfwgdAjgOS2Cfe/w
	Xcjju0rtQBw1kI+5gxiKkh/HmzoXHFVAIZhvuQlB3AeQmGY/HmEYAPAddbz3tWuACa/g=
X-Received: by 2002:a05:622a:a05:b0:535:30a:76c7 with SMTP id
 d75a77b69052e-55517715f34mr1531781cf.3.1794246480432; Mon, 09 Nov 2026
 09:48:00 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org> <20261109-james-perf-test-fixes-v4-4-355ee6b81917@linaro.org>
In-Reply-To: <20261109-james-perf-test-fixes-v4-4-355ee6b81917@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 09:47:49 -0800
X-Gm-Features: AclHuK8Qp2Cv9kN48IExBwB2gdj912t_RB5Gh3vuokUoac-1DxjpaOwzjPM0dOs
Message-ID: <CAP-5=fX-AuoMOL+yPXw2FsdcC5Xg7qkb-Q038U3BeB+P+Rf_Yg@mail.gmail.com>
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

On Mon, Nov 9, 2026 at 5:48=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> Some tests intermittently fail when run in parallel, for example "Check
> branch stack sampling" fails with no branches recorded at all.
>
> The default event is cycles:P which there may only be 1 or 2 HW counters
> for on Intel because it's precise. System wide or per-core precise
> events hog the HW counter leaving other per-process tests with no
> samples. Rather than make all the tests that use default record commands
> run serially, just make the system wide ones use a software event which
> has the greatest possible compatibility. They don't need precise
> sampling or HW counters anyway. The per-process tests can be left alone
> as their events/processes never run concurrently on any one core.
>
> The LBR filter is another resource shared by all events on a CPU, and
> the system-wide LBR test uses different filters to the per-process
> branch stack test, so mark the LBR test as exclusive.

Thanks for deflaking the tests! Making the LBR test exclusive is
pragmatic; however, it also feels like a shame since recording LBR
data in parallel should be something we expect users to do.

For PMUs that can have a single user we have logic which prints
conflicting users in dump_perf_event_processes:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/evsel.c?h=3Dperf-tools-next#n4519

I wonder if, when we get zero counts or no samples we could perform a
similar analysis and report conflicting users=E2=80=94though this would
inherently be racy. If we had that, maybe we could just repeat the LBR
tests until there are no conflicting users and not need the exclusive
tag.

Anyway, doing all of that is a bigger project.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> This fixes the "Check branch stack sampling" test and other flakes when
> a system-wide record from another test runs at the same time, for
> example:
>
>   $ sudo perf record -a -o /dev/null -- sleep 30 &
>   $ sudo perf test -vvv "Check branch stack sampling"
>   ...
>   Testing user branch stack sampling
>   ERROR: Branches missing ^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CA=
LL/.*$
>   ...
>   Testing user branch stack sampling [Failed]
>   ...
>   Testing branch stack filtering permutation (call,CALL|SYSCALL)
>   Testing branch stack filtering [Failed empty script output]
>   ...
>   ---- end(-1) ----
>   138: Check branch stack sampling : FAILED!
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/tests/shell/record.sh          | 6 +++---
>  tools/perf/tests/shell/record_lbr.sh      | 2 +-
>  tools/perf/tests/shell/record_sideband.sh | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 01dc3e22fa73..e4789e2bcf43 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -388,7 +388,7 @@ test_system_wide() {
>    echo "Basic --system-wide mode test"
>    local ret=3D0
>    perf_record_with_retry "${perfdata}" "check_system_wide" "perf test -w=
 thloop" \
> -    -aB --synth=3Dno || ret=3D$?
> +    -aB --synth=3Dno -e cpu-clock || ret=3D$?
>    if [ $ret -eq 2 ]; then
>      echo "System-wide record [Skipped not supported]"
>      return
> @@ -471,7 +471,7 @@ test_cgroup() {
>    echo "Cgroup sampling test"
>    local ret=3D0
>    perf_record_with_retry "${perfdata}" "check_cgroup" "perf test -w thlo=
op" \
> -    -aB --synth=3Dcgroup --all-cgroups || ret=3D$?
> +    -aB --synth=3Dcgroup --all-cgroups -e cpu-clock || ret=3D$?
>    if [ $ret -eq 2 ]; then
>      echo "Cgroup sampling [Skipped not supported]"
>      return
> @@ -491,7 +491,7 @@ test_uid() {
>    echo "Uid sampling test"
>    local ret=3D0
>    perf_record_with_retry "${perfdata}" "check_uid" "perf test -w thloop"=
 \
> -    -aB --synth=3Dno --uid "$(id -u)" || ret=3D$?
> +    -aB --synth=3Dno --uid "$(id -u)" -e cpu-clock || ret=3D$?
>    if [ $ret -eq 2 ]; then
>      local logfile=3D"${PERF_RECORD_LOGS[${#PERF_RECORD_LOGS[@]}-1]}"
>      if grep -q -E "libbpf.*EPERM|Access to performance monitoring" "$log=
file" || \
> diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shel=
l/record_lbr.sh
> index 8d51afeb437b..6b6af59db871 100755
> --- a/tools/perf/tests/shell/record_lbr.sh
> +++ b/tools/perf/tests/shell/record_lbr.sh
> @@ -1,6 +1,6 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
> -# perf record LBR tests
> +# perf record LBR tests (exclusive)
>
>  set -e
>
> diff --git a/tools/perf/tests/shell/record_sideband.sh b/tools/perf/tests=
/shell/record_sideband.sh
> index 2182551873be..f16889e3fa9a 100755
> --- a/tools/perf/tests/shell/record_sideband.sh
> +++ b/tools/perf/tests/shell/record_sideband.sh
> @@ -22,7 +22,7 @@ trap trap_cleanup EXIT TERM INT
>
>  can_cpu_wide()
>  {
> -    if ! perf record -o ${perfdata} -BN --no-bpf-event -C $1 true > /dev=
/null 2>&1
> +    if ! perf record -o ${perfdata} -BN --no-bpf-event -e cpu-clock -C $=
1 true > /dev/null 2>&1
>      then
>          echo "record sideband test [Skipped cannot record cpu$1]"
>          err=3D2
> @@ -39,7 +39,7 @@ test_system_wide_tracking()
>      can_cpu_wide 1 || return 0
>
>      # Record on CPU 0 a task running on CPU 1
> -    perf record -BN --no-bpf-event -o ${perfdata} -C 0 -- taskset --cpu-=
list 1 true
> +    perf record -BN --no-bpf-event -e cpu-clock -o ${perfdata} -C 0 -- t=
askset --cpu-list 1 true
>
>      # Should get MMAP events from CPU 1
>      mmap_cnt=3D`perf script -i ${perfdata} --show-mmap-events -C 1 2>/de=
v/null | grep MMAP | wc -l`
>
> --
> 2.43.0
>
