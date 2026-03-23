Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B2D36C9EE
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296972; cv=pass; b=K2qaD1nwKhxBHyANoB7j9hNHHCe79Nqe2g6CYePXuA93SSxjd2/J8ZB9Uz8GIGeUCW9snn1FqSTzaZDFfgwDjpicssVG0zNayFNXQnl4//O/GfrMAPQr0vOLjT2DpRADEDZqebzpcCLaWDJJmceU9Dy6L2r8h/lTxtG8IO/OLq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296972; c=relaxed/simple;
	bh=VOl7pb/ZhC/trz/86MTqMsyCMeLCIOh6h8/bHYINOBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKQwUgDoYiID8D64JdGsXltAMZZ4gPtOwfsdOCo2bdNdjAMlP12jlnuF6oJcGWzMnNDy7KnjBnppBlgucdq4xyqT1HD531tuNBpEKBKyo1j8eT9y7QqTTME+m4K7ZHGH7hd5gbi69SskzFTP3Ov1ObQcGVnGWZGkQfBpJd7XR1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nHUu6jLc; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHUu6jLc"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so23005ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 13:16:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774296970; cv=none;
        d=google.com; s=arc-20240605;
        b=I4bRsvNRiPTdWqJPKWye0O27kC6FqMMyIxcmPj4/mPfjmyIWtkBMg4c6PSKPk5mbjL
         mx4IViPmLt4sG8h1o5gc3ReAn/IKXaGVLrCHQ9V3uNLBzMcdh3Xh7AVUL8vftRtC/V6P
         iQgaXwPxhoBaoPHH2sp428ei38VG7TRHLnEtNmkiZAO5l+/HoERYmxWxicTo/zJb8YGs
         1IKptsD8TLepaKsl9xroKw/1Zd/5IGYvgajk3zvUDBG2mrRTw+dt5pCU/ppsqzGtu/qi
         Wkg5LbR8bOD2h/yviiWEdmXa/Sq5gAeo6+dhT5ZGq8IvSwifx4+ssC1rjP0pGnXFfy9V
         iQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JJHug66FC59ESymKjuwqMmAPHYNC2GLT6w+ZNPqPjcQ=;
        fh=ZvwMy6RW/z7D9S6xfFKzRe6X6kbDPTP1Zi3r4QiD/Lw=;
        b=SRzLryYZbbY2o9oRTAIys/nkjHz9p5O8uMJsA+/SXURb4cmHlzFsmSlfx4o4a4Aa3q
         8xCbGtgU62FqDq1EY9AcSV6TTpicN9G87vjYUka63wvVKaNRLjVbwsRh4LkkrisIWgu2
         mZg5IiIYFHr8u9ty1iK7z/+nbpQai71C4TFOTKHrMrKIImU52dbq85DjEyp6/2C5f+2W
         2VM5cpms8xiQLNN9u4pRA9hAdID3Ri4/x7xJkTrCOdil6q/oO02ZC2czGHJfZ22jvpnl
         FkbjQhX+YqPOz5Ua3EYdqxazGGrs5+Y2z8cCVVF6tZpC9pulpEMTme59n+cre3MYNtP+
         aIjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774296970; x=1774901770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJHug66FC59ESymKjuwqMmAPHYNC2GLT6w+ZNPqPjcQ=;
        b=nHUu6jLcodh+QQZURtIrmkfKBUKeLDTLMTCIzuiCp0TN6Bj5xu9rRWdFPh1T7gEtwI
         ywNFk8n6QMddN/1sSWHoXHglmulpGJxVJTKV0m5Zgl/KjcpSOxpqa1/bBPkB8eF8s0Pe
         in+9QULkJlzOlFodsNzPrbTOP7+7eGoaHt9rsQ4wE020sKXU+eYmqZbwghCNpiygyCY3
         ZyLx++W9AgR9pWMXrEL5pJ6rNEu8dp5mAY69OAxAPPTppomq0BHUl9CQG+0XWN5XjGmj
         rv2dvU40TLCbh8ti6BFZoJRykCJcj3gjA+e1UDVmBBhUZKtD+Go81/YBFgoiStkBrSHa
         PGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774296970; x=1774901770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJHug66FC59ESymKjuwqMmAPHYNC2GLT6w+ZNPqPjcQ=;
        b=fJr92XDvPRwWONAy278LHqF2XPut6sJM0Ef82PrbRIG+prJyNJ9XZIb+TJh1xLnju/
         pXXWX2oRgnAWBhZ+6njlEtQyfgWIetKBE9X8LcBmKEQTveJrFMrdd3zKztP4k2Dq0fO+
         Y5EnZrbGE/3mXlZhjFb8ObvKcD7k4R6BpMtsn4nTd0s8yczHTWAPvwUFE5nyu/qCWnSN
         679GpyecNa2NKJt8LoiwzjDD/bDfN9Uq5CzxA48eLBVTAm1sMnt0aHszv7HQaG22lmN3
         TVEZi90JhHmWPV14L3LaOioZ26YLbyO3PwzTFuiYmCVlQTwOMv9/CMMGdD8Lvc4Bx2ps
         J+LA==
X-Forwarded-Encrypted: i=1; AJvYcCU47Kne5k6NIH8fpI6QPjPDOoSHBJ/8MIghQF+5rz/t2TwprzmKoMzOar3c2rsJCjPuj03CwbkQi+5XvuDzrREi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4o0VBu8Syk8/0GvNIaaXiQfjrHisXUyrVCSOkDGU55FoeLLmo
	fxr+Zc6ZJ3S6sJn1VAIwOvRRXhfxFKmoc4kTwPbhUF0gpIbqs787PxlanWZhsvWyTQiRY7z63wP
	CT5Lvbg7nOXpSwGyxsNp+NmNANO+JJ5AxMb0Xp/LD
X-Gm-Gg: ATEYQzzkKz3BcdBvtjMoCgpaAcTV/TUnEUhetvWl5mGnAGoXhL+6QZvwaPPF8TYk/M4
	h30D5+RzyhkLqc7xCpGeChDRT1IxyL9ojVNcsii0+K0mAD1so8OnfSbu67OHu6uC9oJtOIhMElo
	QS6W11U+fuQlFQgk1bOoC0Z71LYLiVTqMQCAsVMrA76ki1zYgUtvWDHLHvMMokR5uKRhnerTWYU
	t9cBIerQnS1iFAa0tbPyiI/bSBZXw5tJwjRc5ToFSyfoHLywVh3lGW0Iik68VI6K++JrFr9ON9R
	r0LNYW4+dNna/ogAquZbSRlU0eSWsTRBGvdHPg==
X-Received: by 2002:a17:902:f68d:b0:2ae:4808:bd99 with SMTP id
 d9443c01a7336-2b0a53e730fmr762865ad.2.1774296969539; Mon, 23 Mar 2026
 13:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319064513.9269-1-namhyung@kernel.org> <acBnlSMHS9oe8yFR@x1>
In-Reply-To: <acBnlSMHS9oe8yFR@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Mar 2026 13:15:58 -0700
X-Gm-Features: AaiRm50qqvwRl7zIYoYJyutJTachhsAMx9V6yfSmjYdj0v5kj9Fdw4AymVJAXLU
Message-ID: <CAP-5=fW5Cx-a0hm_PKNLDSmo=L0xu=LizKiAPyJF1YtH-coFdg@mail.gmail.com>
Subject: Re: [PATCH v3] perf test: Fix perf stat --bpf-counters on hybrid machines
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 3:05=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Mar 18, 2026 at 11:45:13PM -0700, Namhyung Kim wrote:
> > The test constantly fails on my Intel hybrid machine.  The issue was it
> > has two events in the output even if I only gave it one event.
> >
> >   $ perf stat -e instructions -- perf test -w sqrtloop
> >
> >    Performance counter stats for 'perf test -w sqrtloop':
> >
> >          910,856,421      cpu_atom/instructions/                (28.05%=
)
> >       14,852,865,997      cpu_core/instructions/                (96.79%=
)
> >
> >          1.014313341 seconds time elapsed
> >
> >          1.004114000 seconds user
> >          0.008174000 seconds sys
> >
> > Let's modify the awk script to add the values for each line and print
> > the total.  The variable 'i' has a number of input lines that have vali=
d
> > output and variable 'c' has the sum of actual counter values.  That way
> > it should work on any platforms.
>
> Still doesn't pass reliably for me, only once it did work:
>
> =E2=AC=A2 [acme@toolbx perf-tools]$ git log --oneline -1
> 38415985abcdb64d (HEAD -> perf-tools, number/perf-tools, number/HEAD) per=
f test: Fix perf stat --bpf-counters on hybrid machines
> =E2=AC=A2 [acme@toolbx perf-tools]$
> logout
> acme@x1:~/git/perf-tools$
> acme@x1:~/git/perf-tools$
> acme@x1:~/git/perf-tools$ sudo su -
> root@x1:~# perf -v
> perf version 7.0.rc4.g38415985abcd
> root@x1:~# perf test 152
> 152: perf stat --bpf-counters test                                   : FA=
ILED!
> root@x1:~# set -o vi
> root@x1:~# perf test -v 152
> 152: perf stat --bpf-counters test                                   : Ok
> root@x1:~# perf test -v 152
> --- start ---
> test child forked, pid 1829364
> Testing --bpf-counters The difference between 21947395146 and 16947118203=
 are greater than 20%.
> ---- end(-1) ----
> 152: perf stat --bpf-counters test                                   : FA=
ILED!
> root@x1:~# perf test -v 152
> --- start ---
> test child forked, pid 1829401
> Testing --bpf-counters [Success]
> Testing bpf event modifier The difference between 22461906845 and 1719034=
4465 are greater than 20%.
> ---- end(-1) ----
> 152: perf stat --bpf-counters test                                   : FA=
ILED!
> root@x1:~# perf test -v 152
> --- start ---
> test child forked, pid 1829445
> Testing --bpf-counters The difference between 24210793380 and 16852007232=
 are greater than 20%.
> ---- end(-1) ----
> 152: perf stat --bpf-counters test                                   : FA=
ILED!
> root@x1:~# perf test -v 152
> --- start ---
> test child forked, pid 1829481
> Testing --bpf-counters The difference between 24293201069 and 17225814972=
 are greater than 20%.
> ---- end(-1) ----
> 152: perf stat --bpf-counters test                                   : FA=
ILED!
> root@x1:~# grep -m1 "model name" /proc/cpuinfo
> model name      : 13th Gen Intel(R) Core(TM) i7-1365U
> root@x1:~#
>
> acme@x1:~/git/perf-tools$ uname -a
> Linux x1 6.17.12-300.fc43.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Dec 13 05:06:=
24 UTC 2025 x86_64 GNU/Linux
> acme@x1:~/git/perf-tools$

So I think the real issue here is the multiplexing value, which I've
looked to fix with:
https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.com/

I have a patch to switch to task-clock which is a software event with
a CPU mask of all online CPUs rather than the split seen on hybrid
machines. I'll send it in reply here.

Thanks,
Ian

> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > v3) make sure to print numbers w/o thousand separators.
> > v2) handle '<not counted>' and '<not supported>'.
> >
> >  tools/perf/tests/shell/stat_bpf_counters.sh | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/t=
ests/shell/stat_bpf_counters.sh
> > index f43e28a136d3c9bc..35463358b273ce1c 100755
> > --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> > +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> > @@ -41,8 +41,14 @@ check_counts()
> >  test_bpf_counters()
> >  {
> >       printf "Testing --bpf-counters "
> > -     base_instructions=3D$(perf stat --no-big-num -e instructions -- $=
workload 2>&1 | awk '/instructions/ {print $1}')
> > -     bpf_instructions=3D$(perf stat --no-big-num --bpf-counters -e ins=
tructions -- $workload  2>&1 | awk '/instructions/ {print $1}')
> > +     base_instructions=3D$(perf stat --no-big-num -e instructions -- $=
workload 2>&1 | \
> > +                             awk -v i=3D0 -v c=3D0 '/instructions/ { \
> > +                                     if ($1 !=3D "<not") { i++; c +=3D=
 $1 } \
> > +                             } END { if (i > 0) printf "%.0f", c; else=
 print "<not" }')
> > +     bpf_instructions=3D$(perf stat --no-big-num --bpf-counters -e ins=
tructions -- $workload  2>&1 | \
> > +                             awk -v i=3D0 -v c=3D0 '/instructions/ { \
> > +                                     if ($1 !=3D "<not") { i++; c +=3D=
 $1 } \
> > +                             } END { if (i > 0) printf "%.0f", c; else=
 print "<not" }')
> >       check_counts $base_instructions $bpf_instructions
> >       compare_number $base_instructions $bpf_instructions
> >       echo "[Success]"
> > @@ -52,8 +58,14 @@ test_bpf_modifier()
> >  {
> >       printf "Testing bpf event modifier "
> >       stat_output=3D$(perf stat --no-big-num -e instructions/name=3Dbas=
e_instructions/,instructions/name=3Dbpf_instructions/b -- $workload 2>&1)
> > -     base_instructions=3D$(echo "$stat_output"| awk '/base_instruction=
s/ {print $1}')
> > -     bpf_instructions=3D$(echo "$stat_output"| awk '/bpf_instructions/=
 {print $1}')
> > +     base_instructions=3D$(echo "$stat_output"| \
> > +                             awk -v i=3D0 -v c=3D0 '/base_instructions=
/ { \
> > +                                     if ($1 !=3D "<not") { i++; c +=3D=
 $1 } \
> > +                             } END { if (i > 0) printf "%.0f", c; else=
 print "<not" }')
> > +     bpf_instructions=3D$(echo "$stat_output"| \
> > +                             awk -v i=3D0 -v c=3D0 '/bpf_instructions/=
 { \
> > +                                     if ($1 !=3D "<not") { i++; c +=3D=
 $1 } \
> > +                             } END { if (i > 0) printf "%.0f", c; else=
 print "<not" }')
> >       check_counts $base_instructions $bpf_instructions
> >       compare_number $base_instructions $bpf_instructions
> >       echo "[Success]"
> > --
> > 2.53.0
