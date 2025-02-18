Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3FAEACD
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2025 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739839277; cv=none; b=gX6PZbcmrgYBRUJzHBlPiQxtNSCyhfzWTna+pCdh0/NMl3iI9jUh9MWSJQswuuSFYByS4ACwggr0JhRQvNhkqB6jEtyTzaxO1cIN/4/aHy5T+w0zTDy9gOCvpS1Yvg+Hk7xeJR6AfCdex5t1+56vr72vqeEf94Nt/K6cAasF2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739839277; c=relaxed/simple;
	bh=PP3A8AthwAc8fj49jv3nJgrfA2WeYwYmTyR+GqfwcoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWNuJhZNiGIgGFWmrm4zbXLlrPv9AQUhm58pWEsKz6qfpl3ODzR7fLsKHYatBfoNXn/tf2Ri8QxU/g6Fhnyz2PlZ7Sg/QKNWbvKKms2+vu/VlbF/tYRddzFp3RUV9mOy1PAdrdiax6JpOqssbAK08IM8ufKrrwhJ1jcFMKivcfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fhutejNH; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhutejNH"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d2ad29f630so4445ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Feb 2025 16:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739839275; x=1740444075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcaewZV2w/xAY7WDlrMHxSsuzFCrVzNehbCR3+80PyQ=;
        b=fhutejNHFQOp/Pgohdn4DqOxuZod+OieJ4s8h8TOjFN4yb9smddN5leFUJPtOTyZc4
         R55Gak4Rhe96kqqcORlT2fzbYgB6PEw/DMPpHN0g99T6DN9T3tLSzlx8tvz/oeQjgn7C
         t7Xl2yqTq7/e/KtM9sLDdZJd/2My0wHcQmBat7vg6rKEi6lqpdNoY84Qn7AaymvczwNC
         C4pDUkldcJxCDnazP4/gDie3lRXWkkpCieupeMgzRqs6TRtsBH0Cmz6j2TSCQELGIWaV
         QvjVI9pT0SNbNREUNBwFUlYzGCbQ0ssD6RnC5ZWDfs3VuMn7OpFXEdqkYYXVpqmYYSdr
         7uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739839275; x=1740444075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcaewZV2w/xAY7WDlrMHxSsuzFCrVzNehbCR3+80PyQ=;
        b=g0+o8cGzkHEiuic659fK8JMCpGdUFafPX27D0/Phz26kWauOKq65hRQkB2FYNaDpMk
         DOmXNrvglt+4lqiqvG8GfrS71TW1NxN5iDjQ4EzZHq7eU9a8yex1dyGluMutaJ0yyK3B
         mg+1yjPbbtrRF1+PhtjAlkg8UAu4xJ+T8+aCUCeURHjstaJQTv5juIhuKxlYKQtpN4Az
         bNtwz54fT4Dnma5toFnwiLeXOfb2jKsSu3x7E+h4WinZFnoWxKRZYxWwRojemaAhjOLX
         5igo3Du3nfkRRkLGQOwmHiMlraUeh0GZyHmBg/MyDga3cnphQvI/l6Y6JQzWTmOmXw1v
         K80g==
X-Forwarded-Encrypted: i=1; AJvYcCUM1oNM6BIBN/Joq50SWKq3u4RcPBWMUZUkAAo5Glyi6BS4kD3Vu/BSe9v+udQcK3lqSU1uFq3NFS+PlElCkXQv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32jVGsUgW/Kf9H3BPfWhDEUyHWsNzZhDlccSa0kLUjE90p5oV
	N4Y7tx4ZQHySUfkjIAByYHC3yAet4w3dYDlUV3NDMHMF064GCcqLOstmxUQy6d4FTx8e7k8Ss8b
	IrM2YCcnFP0rMDBr7Vn9FiTglAZOJMdFYPrSy
X-Gm-Gg: ASbGnctSNnl8WRI5RyW9R26KAvrQycP/w6SG2fNuhg72IS+DGDMOeAT0BKyofsyhlMV
	azgyfjGcWC0mxUi6zw8Tgg7hyuroC3RlxwCOa1Am5NJQiW8H4b8o3E2DBVRzG3Nfn3JKHHW4Ldw
	==
X-Google-Smtp-Source: AGHT+IHXvaTfT4v1tmvC1J02ZtCA554QJNiA8MCodvX0sdZgxo1uoWF5abKOcGHasd3qudKxx8Y4IvU2a9qmJhEPy5M=
X-Received: by 2002:a05:6e02:1a01:b0:3cf:c98a:ceba with SMTP id
 e9e14a558f8ab-3d2824a2ef1mr7040345ab.22.1739839274924; Mon, 17 Feb 2025
 16:41:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>
 <Z66YjGvjD_yzEHUg@google.com> <tencent_45B4E91CA370C563D6420A1A25F992056D09@qq.com>
 <1b8b234f-6435-45cf-83e7-8e86c84f075f@linaro.org>
In-Reply-To: <1b8b234f-6435-45cf-83e7-8e86c84f075f@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Feb 2025 16:41:03 -0800
X-Gm-Features: AWEUYZnUSweoLhqqG88szbjCL3SjQ1zmQ5OCU6cYy08Ob1dcPF71ufs0IS27ejw
Message-ID: <CAP-5=fVAhLLH-a0_wLo8dPoMLOb6rOJiTgGh-OFZJJoaLFE-8Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf vendor events arm64: Add A720/A520 events/metrics
To: James Clark <james.clark@linaro.org>
Cc: Yangyu Chen <cyy@cyyself.name>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 2:02=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 14/02/2025 5:49 am, Yangyu Chen wrote:
> >
> >
> >> On 14 Feb 2025, at 09:12, Namhyung Kim <namhyung@kernel.org> wrote:
> >>
> >> Hello,
> >>
> >> On Thu, Feb 13, 2025 at 11:11:01PM +0800, Yangyu Chen wrote:
> >>> This patchset adds the perf JSON files for the Cortex-A720 and Cortex=
-A520
> >>> processors. Some events have been tested on Raxda Orion 6 with Cix P1=
 SoC
> >>> (8xA720 + 4xA520) running mainline Kernel with ACPI mode.
> >>
> >> I'm curious how the name of PMUs look like.  It is cortex_a720 (or a52=
0)?
> >
> > The name of PMUs comes from Arm's documentation. I have included these
> > links in each patch.
> >
> >> I remember there's a logic to check the length of hex digits at the en=
d.
> >>
> >
> > Could you provide more details about this?
> >
> >> Ian, are you ok with this?
> >>
>
> I think they wouldn't be merged because they're core PMUs, so should be
> fine? Even though they would otherwise be merged because they're more
> than 3 hex digits.

Do we know the PMU names? If they are cortex_a520 and cortex_a720 then
this comment at least reads a little stale:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmus.c?h=3Dperf-tools-next#n76
```
/*
* There is a '_{num}' suffix. For decimal suffixes any length
* will do, for hexadecimal ensure more than 2 hex digits so
* that S390's cpum_cf PMU doesn't match.
*/
```
James is right that core PMUs aren't put on the same list as uncore/other P=
MUs.

Thanks,
Ian

> >> Thanks,
> >> Namhyung
> >>
> >>>
> >>> Yangyu Chen (2):
> >>>   perf vendor events arm64: Add Cortex-A720 events/metrics
> >>>   perf vendor events arm64: Add Cortex-A520 events/metrics
> >>>
> >>> .../arch/arm64/arm/cortex-a520/bus.json       |  26 ++
> >>> .../arch/arm64/arm/cortex-a520/exception.json |  18 +
> >>> .../arm64/arm/cortex-a520/fp_operation.json   |  14 +
> >>> .../arch/arm64/arm/cortex-a520/general.json   |   6 +
> >>> .../arch/arm64/arm/cortex-a520/l1d_cache.json |  50 ++
> >>> .../arch/arm64/arm/cortex-a520/l1i_cache.json |  14 +
> >>> .../arch/arm64/arm/cortex-a520/l2_cache.json  |  46 ++
> >>> .../arch/arm64/arm/cortex-a520/l3_cache.json  |  21 +
> >>> .../arch/arm64/arm/cortex-a520/ll_cache.json  |  10 +
> >>> .../arch/arm64/arm/cortex-a520/memory.json    |  58 +++
> >>> .../arch/arm64/arm/cortex-a520/metrics.json   | 373 +++++++++++++++
> >>> .../arch/arm64/arm/cortex-a520/pmu.json       |   8 +
> >>> .../arch/arm64/arm/cortex-a520/retired.json   |  90 ++++
> >>> .../arm64/arm/cortex-a520/spec_operation.json |  70 +++
> >>> .../arch/arm64/arm/cortex-a520/stall.json     |  82 ++++
> >>> .../arch/arm64/arm/cortex-a520/sve.json       |  22 +
> >>> .../arch/arm64/arm/cortex-a520/tlb.json       |  78 ++++
> >>> .../arch/arm64/arm/cortex-a520/trace.json     |  32 ++
> >>> .../arch/arm64/arm/cortex-a720/bus.json       |  18 +
> >>> .../arch/arm64/arm/cortex-a720/exception.json |  62 +++
> >>> .../arm64/arm/cortex-a720/fp_operation.json   |  22 +
> >>> .../arch/arm64/arm/cortex-a720/general.json   |  10 +
> >>> .../arch/arm64/arm/cortex-a720/l1d_cache.json |  50 ++
> >>> .../arch/arm64/arm/cortex-a720/l1i_cache.json |  14 +
> >>> .../arch/arm64/arm/cortex-a720/l2_cache.json  |  62 +++
> >>> .../arch/arm64/arm/cortex-a720/l3_cache.json  |  22 +
> >>> .../arch/arm64/arm/cortex-a720/ll_cache.json  |  10 +
> >>> .../arch/arm64/arm/cortex-a720/memory.json    |  54 +++
> >>> .../arch/arm64/arm/cortex-a720/metrics.json   | 436 +++++++++++++++++=
+
> >>> .../arch/arm64/arm/cortex-a720/pmu.json       |   8 +
> >>> .../arch/arm64/arm/cortex-a720/retired.json   |  90 ++++
> >>> .../arch/arm64/arm/cortex-a720/spe.json       |  42 ++
> >>> .../arm64/arm/cortex-a720/spec_operation.json |  90 ++++
> >>> .../arch/arm64/arm/cortex-a720/stall.json     |  82 ++++
> >>> .../arch/arm64/arm/cortex-a720/sve.json       |  50 ++
> >>> .../arch/arm64/arm/cortex-a720/tlb.json       |  74 +++
> >>> .../arch/arm64/arm/cortex-a720/trace.json     |  32 ++
> >>> .../arch/arm64/common-and-microarch.json      |  15 +
> >>> tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
> >>> 39 files changed, 2263 insertions(+)
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/b=
us.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/e=
xception.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/f=
p_operation.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/g=
eneral.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l=
1d_cache.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l=
1i_cache.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l=
2_cache.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l=
3_cache.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l=
l_cache.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/m=
emory.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/m=
etrics.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/p=
mu.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/r=
etired.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/s=
pec_operation.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/s=
tall.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/s=
ve.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/t=
lb.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/t=
race.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/b=
us.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/e=
xception.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/f=
p_operation.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/g=
eneral.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l=
1d_cache.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l=
1i_cache.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l=
2_cache.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l=
3_cache.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l=
l_cache.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/m=
emory.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/m=
etrics.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/p=
mu.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/r=
etired.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/s=
pe.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/s=
pec_operation.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/s=
tall.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/s=
ve.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/t=
lb.json
> >>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/t=
race.json
> >>>
> >>> --
> >>> 2.47.2
> >>>
> >
>
