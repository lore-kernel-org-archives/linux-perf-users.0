Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11C185924
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 05:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325111; cv=none; b=K13DxWqUZhHOMZNnm0ZGWXZYP1UzM2jPVgpoFRTivLyTyQMPPq3nHxOG/tJZT5gB/pDOeHYNWHiAysV52qESc66pL/Wnt/cLzwAC4t9xQ+KkLqICP5C0fVAkEiLg2jtJnVoYyi4go52QsYgPszlHyGXb2xNhuARJTZ++pJ4Bg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325111; c=relaxed/simple;
	bh=bI3OybnSxdkVjgMf7Q+ee/FOm4jiD9TYuTB8jpdlQGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5Ildh590QnyVb7rTq9tGq5BWE4nvd5yC9PyXue4eeW+7ptj+l0rvhQzqEQbMABuCO4SCnl7KNKMw2REUc3QC65l1KnpgeIInu/6TIUK2EVpD0/r+tW4OiA7WPlfcBDQPml79tnaL3XonrbSwM4r4auldmcVwrph3V0i2F1Rn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALEhraHS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALEhraHS"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2240aad70f2so106415ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Mar 2025 21:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741325109; x=1741929909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWlAu5LA7bOZxdM/Sjg+8r3QT3/ix5LQ+eNaKjKWuzs=;
        b=ALEhraHSo01EIwIZGcdsHaije/Mdo9/vDEY20i2rGp8OfCYrzHwAcdlQYuS4bfDMpY
         ShRhrjg7EmsP1TtunRbWS45ULJvGyKeNuN0ADjUNNzfMpYs7XmatA4s2eDCBla3pRY+V
         sH8Q59YaSSO91ylBj2PVfkQd0IbdgfUdU4f+DuhYpU77atGIYUS0cNZfXTSYXZaUu9qv
         s63lFrAz227LZPX9UZsLnNccua/p160o9ajZiqtiZg0/LjFS+iGVFsm/iIQd1z6V6oKC
         KrAU7BPPNlC3S3iwQRBS3ZyA8gJ9eLO9YvcuLANNN20UuEaRlk6Qr23KMB/GPkOv3X6O
         ADhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741325109; x=1741929909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWlAu5LA7bOZxdM/Sjg+8r3QT3/ix5LQ+eNaKjKWuzs=;
        b=tz+iXJoTc9dZtFgzqdDj685QsNv8mXqOBRffBXpa4wsx0eMUvc6g1ZLkn6XEp4glNV
         Fr+siyQ9JDjV4G+14URywnSedkeUWsnDLYVLdj91fmVq7+LJPTjrfWj0GkSSBUp7PCfC
         cXGrT9I7miKVM0HYZ1JvjwYamrN2RxG+Uk9mj3HFdY+xgP1zbyNzCqw1M6xof9uJ5AbD
         uMm2a1IaGreiFMLLIhOUfwwrkmfUSHm1PoYFUmKHR1o1zcfV4WWsGFDguRHoS2cNnI3f
         Lf+Iw23PJvGtoxAtDdQ0gi5+jE52yOVRHuGRABq/syuOOy/+IWUy/3zHGZuSjhR1uRfx
         MbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJu42Sq/8KO35PeZ0iqZhiG+YuoxCiHv4L7PcXl91DcKw1VpEg6NIU+C2RCspfcPJFDuFSAhh17vEL5Wo/76dg@vger.kernel.org
X-Gm-Message-State: AOJu0YzHT1+Eq9xtAC5CXUw9MExF/psxLFKc/gL5YiSbVXpfq0wA6Pso
	LAdWuxPrr3kOVrkrfZUGYHCOnlpqdqoy3lSnuyr8hdFxoTA5KZTSiSdv187rOmTJFBdJrk+fiUI
	m/Mi6uNS3Wa8hOgyo4hKaNT/1jUq+i/A1hrBr
X-Gm-Gg: ASbGncs0Qg82Y2Trp+s+6VzLXlrUQBlasc521Z+73fBG3ok8yE/p1PpfmQHTYNiRwTI
	ak7JNdS6RpbJ/INcRRpAkWOuAJLfanuw0v3b4w5uvL/cm2yA/xQ5aE+Lm6B4AOhqZsL71NsOAfv
	RrPQXY4C1cbpTvMe7hvXPGirlSwbk=
X-Google-Smtp-Source: AGHT+IFRYVGJBUyqfEgEEPGl0XuJoVigNi9zw8+vpDfrTRYYJhLTf6i1tLXkipTYynSySNJGHrvuHKwIth5hC2cOdhc=
X-Received: by 2002:a17:902:e810:b0:215:7ced:9d67 with SMTP id
 d9443c01a7336-224297f2337mr1643855ad.24.1741325109250; Thu, 06 Mar 2025
 21:25:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7Z5kv75BMML2A1q@google.com> <CAP-5=fVbti6efu6uA9a5os6xhnTuJ0egyesZsy0dmkiScwYFqQ@mail.gmail.com>
 <Z7yJ0Vpub6JeQyYo@x1> <CAP-5=fXSgpZaAgickZSWgjt-2iTWK7FFZc65_HG3QhrTg1mtBw@mail.gmail.com>
In-Reply-To: <CAP-5=fXSgpZaAgickZSWgjt-2iTWK7FFZc65_HG3QhrTg1mtBw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Mar 2025 21:24:58 -0800
X-Gm-Features: AQ5f1JpJ-b0lCDiYR38BKsmRp5-QxDImcV_6P1n0_NI2oBbV65AfpBr4ZBGs4EQ
Message-ID: <CAP-5=fX3U3JsRebOLWNQ-0n+W8aGWSLoDWYNZ9f4T7+sPa4H4g@mail.gmail.com>
Subject: Re: [RFC] perf tools: About encodings of legacy event names
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Atish Patra <atishp@rivosinc.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:36=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> The series is trying to make "most people" happy with "no surprise"

So the patch [1] fixes a number of event grouping bugs present on all
Intel CPUs post Icelake (released April 2021). I think the code isn't
trivial, and I've tried to simplify everything as much as possible.
Again it shows the event parsing isn't a static problem and I am
trying to contribute fixes which this RFC on [2] is holding up.

On Alderlake I see problems:
```
$ perf stat -vv -e
'instructions,cpu_core/instructions/,cpu_atom/instructions/' perf test
-w noploop
Using CPUID GenuineIntel-6-B7-1
...
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 size                             136
 config                           0xa00000001
(cpu_atom/PERF_COUNT_HW_INSTRUCTIONS/)
 sample_type                      IDENTIFIER
 read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
 disabled                         1
 inherit                          1
 enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 1157109  cpu -1  group_fd -1  flags 0x8 =3D 5
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 size                             136
 config                           0x400000001
(cpu_core/PERF_COUNT_HW_INSTRUCTIONS/)
 sample_type                      IDENTIFIER
 read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
 disabled                         1
 inherit                          1
 enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 1157109  cpu -1  group_fd -1  flags 0x8 =3D 6
------------------------------------------------------------
perf_event_attr:
 type                             4 (cpu_core)
 size                             136
 config                           0xc0 (instructions)
 sample_type                      IDENTIFIER
 read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
 disabled                         1
 inherit                          1
 enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 1157109  cpu -1  group_fd -1  flags 0x8 =3D 7
------------------------------------------------------------
perf_event_attr:
 type                             10 (cpu_atom)
 size                             136
 config                           0xc0 (instructions)
 sample_type                      IDENTIFIER
 read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
 disabled                         1
 inherit                          1
 enable_on_exec                   1
------------------------------------------------------------
...
Performance counter stats for 'perf test -w noploop':

   13,323,070,728      cpu_atom/instructions/
                        (1.87%)
   26,695,170,453      cpu_core/instructions/
                        (98.13%)
   26,695,170,453      cpu_core/instructions/
                        (98.13%)
   13,323,070,728      cpu_atom/instructions/
                        (1.87%)

      1.007358136 seconds time elapsed

      1.003129000 seconds user
      0.004012000 seconds sys
```
That is the instructions event, literally the 2nd legacy event after
cycles, getting 2 different encodings but the stat output showing the
events as if they are the same. The multiplexing numbers obviously
look off.

There is still work to do. Specifying a topdown event twice in an
event list currently breaks (e.g. `perf stat -e "slots,slots" ..`). I
see situations in perf-tools-next where a wildcard tries to open a
legacy event on even uncore PMUs.

Given [2] under pins so much I think merging it has to be a priority.
I suspect it needs rebasing and checking in the light of the changes
in [1]. Given it has extensive reviewing and testing by vendors, it
helps RISC-V and ARM Apple-M, I hope that after 2 weeks of this thread
that hasn't stimulated additional comment (beyond the original
comments on the series) things can move forward and fixing things can
continue.

Thanks,
Ian

[1] https://lore.kernel.org/lkml/20250307023906.1135613-3-irogers@google.co=
m/
[2] https://lore.kernel.org/linux-perf-users/20250109222109.567031-5-iroger=
s@google.com/#r
