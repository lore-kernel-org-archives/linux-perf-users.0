Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627633446A3
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964109; cv=none; b=RtpizZEU1BwjsHHhWLNrqhyqKxR1WDyoT2LzAzHDwvEOA0JySzngFUSBY3Sq/SWquzk6S0Qvl+huRamPFBP1iqgtUplnWt5O6h5a2fOJ6rr7VpdFGtqfWA0zD7NobB7ZmpQHNtUYBe2eA69S3cbSFhUtsyIJzLz4t4Z93rt6tGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964109; c=relaxed/simple;
	bh=UCzJZ4pbFG83+k7McdvyAWoYIvtXznNm3BUfaa2YoAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFvStIlOq7d7zS4SJ4xkzNgjLdQSKZlCpu/R5NxQ7EUM5wRzYwTlggnv/3cX2Edv91YQ6HIALYh2082vaAWwtFnXYeocX9lnhsWHTKRhKunPvCXsICucAj+xwaOLBeXSEu1xEjC2GqMCu6PGoMkcopderYg2mOMpJwxQSUORH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gNqy3pOO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gNqy3pOO"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-295c64cb951so222925ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 08:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762964106; x=1763568906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCKMCXtaU/P3d7AoQdR9cSG83XtgC6uAWsLooIET0S8=;
        b=gNqy3pOOt9Afr4wPiXaBpeGH8TDC5gNZgSSSUHGUHQL39qESyQTbSQsgWGjjR4l0Rq
         lpydKp1VkSlp9OMsA/mRXW02ziCM7Jhpfn/c/jJ2/kn19dz3/xphI1XClxy9UgZfq9sc
         GAyBCJtvGB9PJYD6YmscZqpkwAAPBfY1lGOIODCCh/NYIw4UgbDI5VYDuR+Z7qt6nTuS
         947PWeO/3RElq3HLhULjjR56LnDaBMQURx++5Ir7jKBL0RUGCurhOYwNjq/XZrf+GRVw
         TQu9GetP5YbSxNBA+aOXlqUViTRqHHx0j4U3LABQfXK80Ew6n0BOSptvBhskJnWJTzT+
         IA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762964106; x=1763568906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NCKMCXtaU/P3d7AoQdR9cSG83XtgC6uAWsLooIET0S8=;
        b=vqZoM6+3IboCmS78fxbwE+3nfZ20+C+socEUkg8YYaMvHvoIuQN4yyEl05tOivmEIA
         er0rbGymx0gX4tLBerCsbgSo816etgNH64u+NtbiV2Qf41VvIfwVw1OL8c6diVHXg+Zm
         fgTU1sQ6MtV3wzZW2GLir7VXwY3eE3lPrtLP9vxbNOdeWfQ05BXfxmGC3oMLK1gvofQl
         5CuPkGJ8cJ0A3zSA3cDc6tUtsdq3MoSOMZCpWRSp3sEsc3fVtBhCRXXWMy4ADsyjmHId
         wufeuuDuNIU/TMtHCYU5U9XfOyFECtzTX3wHTjVKZG8ltZg6qmpKXMWNg9vm60Vvp64b
         ZZtA==
X-Gm-Message-State: AOJu0YwpyFvYvc7yzvrnycpbVdXctHUGpaEZ7tN16TNLO1y6EgfarbfM
	7Lv1F9iPsrQT4PdtS5r4pOYdpWJSQRmJbgZD70gZO/6lM6vDxEBDJTR38M9xNTQKZuwYnlMw0uA
	qO2WWDqkcur9cM7yMfLbDDjcaYrKQFacOeIukylqU
X-Gm-Gg: ASbGncvlMAOWCtRt8VAoVq+r0ojRWVRqH9BHY9LqyDG+jtkLX38x0SoNGnAoIO6IwMq
	IDTDxvHlvOFWFu8sBzYvdroL3e8/eMFmf0m8A4VCvIiuyeO0aDklP33ePMskGAxTohiOu+myM81
	LJPN2MDyuLGpV6e5JfFC3jSkWkNDk6i5TG/vDU2xpHI2tEinzUAHnv3sMCoq6dr6tX+xI+ua1i6
	vo3P4puIOYmEUomUx/ElQCk3BS/0z1VoS24vg4o/JsUM5hI8oAtr0vINSJ8fSnqBPacYoKJSR9f
	sBKaznMpxmOwb9IOaL9PsPkn8qqyKXmr3COpjsYUKWtFwkw=
X-Google-Smtp-Source: AGHT+IGJpvQO9LNBG2hi5w+nCYlwYeJgQHFLSJd0xCIlG7oti7wsk25HSUBmIJBvZJ6hoBFgnwpVDljEUs/pLo1LTyk=
X-Received: by 2002:a17:902:c951:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-2984f827a37mr5286795ad.6.1762964105934; Wed, 12 Nov 2025
 08:15:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3e80f453-f015-4f4f-93d3-8df6bb6b3c95@linux.ibm.com>
In-Reply-To: <3e80f453-f015-4f4f-93d3-8df6bb6b3c95@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Nov 2025 08:14:54 -0800
X-Gm-Features: AWmQ_bnTPPFM_XNFM6Pmr-8cLYcV-8so7huzabG7Zo4h7wqStKO2mwTABJDM2xU
Message-ID: <CAP-5=fUZ+imMSsykF3iaUyshKD008a2m5TeqQ=HZ1QvqgF1iWA@mail.gmail.com>
Subject: Re: Test cases metricgroups and metrics fail on s390 zVM guest
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Jan Polensky <japo@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 7:01=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Hi Ian,
>
> I discovered this strange issue on a z/VM system (linux guest on s390 LPA=
R).
> I use linux-next repo.
>
> root in =F0=9F=8C=90 a8345032 in mirror-linux-next/tools/perf on =EE=82=
=A0 master [?] via C v15.1.1-gcc
> =E2=9D=AF perf test 96
>  96: perf all metricgroups test        : FAILED!
>
> root in =F0=9F=8C=90 a8345032 in mirror-linux-next/tools/perf on =EE=82=
=A0 master [?] via C v15.1.1-gcc
> =E2=9D=AF perf test 97
>  97: perf all metrics test             : FAILED!
>
> This test works on the linux repo on a z/VM linux guest:
> root in =F0=9F=8C=90 a8345047 in ~
> =E2=9D=AF perf test 95
>  95: perf all metricgroups test        : Ok
>
> root in =F0=9F=8C=90 a8345047 in ~
> =E2=9D=AF perf test 96
>  96: perf all metrics test             : Ok
>
> root in =F0=9F=8C=90 a8345047 in ~
>
> On both systems I get this:
> # ./perf list --raw-dump metric
> cpi est_cpi finite_cpi l1mp l2p l3p l4lp l4rp memp prbstate scpl1m tlb_mi=
ss \
>             tlb_percent transaction
>
> It lists metrics. It is ok when running on an LPAR which has the
> CPU Measurement counting facility:
>
>  # ll /sys/devices/cpum_cf/events | wc -l
>  106
>  #
>
> But on z/VM this facility does not exist:
>
>  # ll  /sys/devices/cpum_cf/events | wc -l
>  ls: cannot access '/sys/devices/cpum_cf/events': No such file or directo=
ry
>  0
>  #
>
> Now when I look into the json files for s390, I have the metrics defined
> in arch/s390/cf_z16/transaction.json:
>
>   {
>     "BriefDescription": "Cycles per Instruction",
>     "MetricName": "cpi",
>     "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) e=
lse 0"
>   },
>
> Up to now the has_event(event-name) was sufficient to suppress the metric=
 when
> that counter did not exist. At least I thought so.
>
> Now I get this output when I run test case on linux-next repo:
>  # ./perf stat -vvvvv -M cpi -- sleep 1
>  Using CPUID IBM,3931,703,A01
>  metric expr (CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0=
) for cpi
>  parsing metric: (CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) el=
se 0)
>  hwmon_pmu: not a hwmon file 'INSTRUCTIONS'
>  Attempt to add: cpu/INSTRUCTIONS/
>  ..after resolving event: cpu/legacy-hardware-config=3D0x1/
>  INSTRUCTIONS -> cpu/INSTRUCTIONS/
>  found event CPU_CYCLES
>  found event INSTRUCTIONS
>  Parsing metric events '{CPU_CYCLES/metric-id=3DCPU_CYCLES/,INSTRUCTIONS/=
metric-id=3DINSTRUCTIONS/}:W'
>  hwmon_pmu: not a hwmon type 'CPU' in file name 'CPU_CYCLES'
>  event syntax error: '{CPU_CYCLES/metric-id=3DCPU_CYCLES/,INSTRUCTIONS/me=
tric-id=3DINSTRUCTIONS/}:W'
>                        \___ Bad event or PMU
>
>  Unable to find PMU or event on a PMU of 'CPU_CYCLES'
>
> Sure it can not find counter named CPU_CYCLES nor INSTRUCTIONS. They are =
not available.
> Isn't the has_event(INSTRUCTIONS) macro sufficient to avoid the calculati=
on at all?
> This has worked before.


Hi Thomas,

I think I know what's happened and I broke you, sorry :-( The move to
put the legacy events into json:
https://lore.kernel.org/lkml/20251005182430.2791371-1-irogers@google.com/
means that has_event(instructions) is always true as the event is declared =
in:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/common/common/legacy-hardware.json?h=3Dpe=
rf-tools-next#n13
CPU_CYCLES isn't a legacy event name, those are cpu-cycles and cycles,
so I think changing the has_event event name to not be a legacy name
will address the problem. I'll send out a patch set.

Thanks,
Ian

> When I run the same command on z/VM guest with linux repo, I get this:
>  # ./perf stat -vvvvv -M cpi -- true
>  Using CPUID IBM,3931,703,A01
>  metric expr (CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0=
) for cpi
>  parsing metric: (CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) el=
se 0)
>  hwmon_pmu: not a hwmon file 'INSTRUCTIONS'
>  found event duration_time
>  Parsing metric events 'duration_time'
>  hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
>  Attempt to add: tool/duration_time/
>  ..after resolving event: tool/config=3D0x1/
>  duration_time -> tool/duration_time/
>  Matched metric-id duration_time to duration_time
>  Control descriptor is not initialized
>  Opening: duration_time
>  ------------------------------------------------------------
>  perf_event_attr:
>   type                             4294967294 (tool)
>   size                             136
>   config                           0x1 (duration_time)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>  ------------------------------------------------------------
>  duration_time: -1: 471615 1 1
>  duration_time: 471615 1 1
>
>  Performance counter stats for 'true':
>
>            471,615      duration_time
>  parsing metric: (CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) el=
se 0)
>  CPU_CYCLES not found
>  INSTRUCTIONS not found
>  #     0.00 cpi
>
>        0.000465696 seconds time elapsed
>
>        0.000060000 seconds user
>        0.000416000 seconds sys
>  #
>
> It has switched to event 'duration time' handled by some dummy tool PMU. =
I find this
> somehow misleading.
> Here is the same command without verbose output:
>  # perf stat  -M cpi -- true
>
>  Performance counter stats for 'true':
>
>            346,237      duration_time                    #     0.00 cpi
>
>        0.000340752 seconds time elapsed
>
>        0.000056000 seconds user
>        0.000303000 seconds sys
>
> At least the CPI metric is 0 because it could not be calculated. This is =
ok.
>
> And finally when executed on a s390 LPAR it works as intended
>  # ./perf stat -M cpi -- true
>
>  Performance counter stats for 'true':
>
>            855,234      CPU_CYCLES                       #     1.42 cpi
>            601,676      INSTRUCTIONS
>
>        0.000473961 seconds time elapsed
>
>        0.000063000 seconds user
>        0.000491000 seconds sys
>  #
>
> Maybe a better place to fix the metric issue is in perf list subcommand.
> When counters are not available, do not list the metrics depending on ref=
ered
> counters? This has to be done at runtime as seen above.
> I think the has_event() macros has worked this way some time ago?
>
> Any other ideas or recommendations?
> Thanks a lot
>
> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
>
