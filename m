Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF582101B0
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005532; cv=none; b=P233KsaB1ViWWDm1MYOIZmxhZ9Rzj4yiBsmDSO80hS+O0sQd/9JAMvbzzzqsUOlM0QFaor8wXL0vVN7k1dqSw8XOiV+4JJ/ANW9LK7VdkXDYKWxPVGJPZ5rY57Zc79tPp5+NOMgIk3Gr3a1Id/iN3//0genx6bHPLT/5JqclNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005532; c=relaxed/simple;
	bh=5waiBhM4WgYuhJy35YT7HAoT0amIFBAEf40b0y5+l1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeg+QYsElG+XlCgsSizMUTB44gzSBmhy4gqf2Ub/IpQRkDHVOzbrsczDACSZAsILvjSCZ3d8WFT9RwIf5sEzg6aN8Ese3d0DEtgFpYhoNn4kF8zqAfbv3Uuwit+4mfohZcipLzYDywSjsV/wMPl0cGq2XyxOKW8+qQwGCluCmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hrz+FwxY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrz+FwxY"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c87b0332cso20365ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 10:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731005530; x=1731610330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eBN8ymnBc8p9QxnxQVe7atvkFMrTJybu6XE4oODfEs=;
        b=hrz+FwxYGYN82LQZbxjuKZUX8SjvAhdIDbIrCMhFmO362zqqrZEmVp7StxM0l0t3PG
         W3M4Rv7SUc/gXRbAqOaMe8mGPWJ3gl8jdgh0CmaYhQjgfBYvNaN0kBbQc3KXG7gAm5lc
         QPnoux262PhYvhER4WR8NmKDhk0uoMyY+iL+LRnC8SnSTJXMyIX7z4n9WELGleyGTJUJ
         UcTbWFIn4om72ZYsEFKvULEcsJK8FS0/r9dtS0XgS9PTQhGbMJtoCBv00VdW+B3gbWur
         gEAE968x28ebHSxUDYtPNXm2niMUO38jt7r0Os9GY5CFKpjiSIUCQVtUxJAWPpvJU+Yx
         Oqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731005530; x=1731610330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eBN8ymnBc8p9QxnxQVe7atvkFMrTJybu6XE4oODfEs=;
        b=DDNnAhzGRlUp+HEw8OeJEf8uLAObYzNNpJhNMgGTFUSq4/T0rIZnkPCoxIVSHbJvzs
         +nx/Ba7e16OmK59K1wcmzoyzBVdFabdRexUodbl9NtWO4esi0W97LKoJP9IZQE4NL7Jg
         OIdIWuZe302enAuUf8xAUPRGyO4dv1DriAUoBZ19/tEE+duMyITTQ/kXGmFjZMq4+59S
         uL9Vyj68p5IFo+doS5Q4Teb3l1mZdnyKSuzfC5yNCnSn6rwSiiyl5k/OogxEIaVVXa30
         XNEIGtuW2NgrWthS3gckpbZFU7aQL410IhwZaelmMhOZvKND2CMYN91QmYrilI+xT+u/
         jPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC+SY88dyEg+qihMHWql8bb7kqtYp4YRgVNz8tHS9QNw5Yrty7wVUAWbXk4eHis8IdnBw0qL+Qhe66y/PpKmhq@vger.kernel.org
X-Gm-Message-State: AOJu0YyYdjrAFIPWKtHrk/j5Fhs5BpyZsYz0h4EYE2ikOxOdih5vHZFT
	MxekLUNQzxtKB5X/VFEo9sdTm6/x4h4ZSzT06GuZ+w/odCeP3TajWpjdHBp8xfvZTA48IYpkhMA
	JEyhu5rThQEKVlsn4C5VAZNsYN3JEP6MUYEMW
X-Gm-Gg: ASbGncsrWxu6Yj8LGAr9MG3XJm+C3NTJAq7ujWFupM+3eIomYiUWaTp4w7UAgPxKWio
	kd6p9WEDfm9oFu5kiFu+hqi4Mm7CwRUzzssowzZQkSd25vwil/TBpWw4X7B6LSy0=
X-Google-Smtp-Source: AGHT+IGvx7KFsyMX5+AYcMaGovXO3S3lUt1B/FRKeJuNVZEWZxKDX6Uv2YyfvW7lg1pESwLCE/Oq1UyOTpc16+leygo=
X-Received: by 2002:a17:903:41ce:b0:205:60ef:18af with SMTP id
 d9443c01a7336-211749d3e94mr3901475ad.29.1731005529781; Thu, 07 Nov 2024
 10:52:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com>
In-Reply-To: <20241026121758.143259-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 Nov 2024 10:51:58 -0800
Message-ID: <CAP-5=fXf9HtqKZyvfXNbKLTB-dL_Ax5Hd0_Gn1J-y0T1SE9wLQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: Atish Patra <atishp@rivosinc.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ben Gainey <ben.gainey@arm.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-riscv@lists.infradead.org, beeman@rivosinc.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 5:18=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> At the RISC-V summit the topic of avoiding event data being in the
> RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
> events being the priority when no PMU is provided so that legacy
> events maybe supported via json. Originally Mark Rutland also
> expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
> M? processors, but James Clark more recently tested this and believes
> the driver issues there may not have existed or have been resolved. In
> any case, it is inconsistent that with a PMU event names avoid legacy
> encodings, but when wildcarding PMUs (ie without a PMU with the event
> name) the legacy encodings have priority.
>
> The patch doing this work was reverted in a v6.10 release candidate
> as, even though the patch was posted for weeks and had been on
> linux-next for weeks without issue, Linus was in the habit of using
> explicit legacy events with unsupported precision options on his
> Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
> where ARM decided to call the events bus_cycles and cycles, the latter
> being also a legacy event name. ARM haven't renamed the cycles event
> to a more consistent cpu_cycles and avoided the problem. With these
> changes the problematic event will now be skipped, a large warning
> produced, and perf record will continue for the other PMU events. This
> solution was proposed by Arnaldo.
>
> Two minor changes have been added to help with the error message and
> to work around issues occurring with "perf stat metrics (shadow stat)
> test".
>
> The patches have only been tested on my x86 non-hybrid laptop.

Hi Atish and James,

Could I get your tags for this series?

The patches were originally motivated by wanting to make the behavior
of events parsed like "cycles" match that of "cpu/cycles/", the PMU is
wildcarded to "cpu" in the first case. This was divergent because of
ARM we switched from preferring legacy (type =3D PERF_TYPE_HARDWARE,
config =3D PERF_COUNT_HW_CPU_CYCLES) to sysfs/json (type=3D<core PMU's
type>, config=3D<encoding from event>) when a PMU name was given. This
aligns with RISC-V wanting to use json encodings to avoid complexity
in the PMU driver.

James, could you show the neoverse with the cmn PMU behavior for perf
record of "cycles:pp" due to sensitivities there.

Thanks,
Ian




> Ian Rogers (4):
>   perf evsel: Add pmu_name helper
>   perf stat: Fix find_stat for mixed legacy/non-legacy events
>   perf record: Skip don't fail for events that don't open
>   perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
>     legacy"
>
>  tools/perf/builtin-record.c    | 22 +++++++---
>  tools/perf/util/evsel.c        | 10 +++++
>  tools/perf/util/evsel.h        |  1 +
>  tools/perf/util/parse-events.c | 26 +++++++++---
>  tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
>  tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
>  tools/perf/util/pmus.c         | 20 +++++++--
>  tools/perf/util/stat-shadow.c  |  3 +-
>  8 files changed, 145 insertions(+), 73 deletions(-)
>
> --
> 2.47.0.163.g1226f6d8fa-goog
>
