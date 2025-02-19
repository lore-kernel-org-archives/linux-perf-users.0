Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7971B6CF5
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990289; cv=none; b=lcNCeySRcyKNDTMJ88GndGMqTCmnq5s+Q81663m/OIXnfOIyCiJGq+zHXfSCPsSg27E6PQDc8jDoObNDKVwdpGitB1247ShD1FeBmMKsNdloMMXT4tTzq4tFHQcCGmpePVSdKJsJYTNbAMKdOukkVyzi2ukkV4Sv6lib5pKHO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990289; c=relaxed/simple;
	bh=gBV2UZFIKjnRUsJGbf05jytvdaauuWzNkzGor8r73Lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vwr7PxkZ91u0hRHO9LJGopTk9ICjW6ZckdmyP2Yb0OsldMUw4QbFF8rcC0unUEktJZXt7gVphsNM5Jv/bv+XcA8DLMh5WtnReHxlhVd/khf/Kel6AGHUyq67FYSgfoncZqydHb9B7VOL+Wr/Z79+30GrGkHwy4bpNXfYriFRKiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PTaSHOrk; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTaSHOrk"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d19702f977so10575ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 10:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739990287; x=1740595087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH6gCwcBfooV/1R4mxoSj5XvySZqaE4EBHJnx789OnA=;
        b=PTaSHOrkEwb/qtUrNkh0yZj0Xe1IXYm9RYznHRmt8vs/aa56TI6pW9sy5ZNahbF2rc
         tcJKN4rAp5KH0A0HWVJ08NcnPJ8ObC8habCUYOxms4I71LVHPy/euiupC9Nh1PXH2abQ
         /1qPVyBaBYDfKMXizpXutmYKyy3+bmHraFpjNw6aBZaJIFspnwF8OzdUBbNYG257qd/s
         Yc9N9R/wHGEAB0Y3/lXNtu95MLO0KHcRuOGz0sWZIR8MD4GgzieVN1s9mqVIE0tW/D8F
         bwN8kA2K6LiueiATIx9f16cGhjzLLWAcjVyQg2NYvrnbcDQ0aHZpgRGrrMPPff1XR2eA
         9EzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739990287; x=1740595087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SH6gCwcBfooV/1R4mxoSj5XvySZqaE4EBHJnx789OnA=;
        b=OtBwg2/YMyt9mKgJOPIG/8bG3AODPH8N1Mf03m5uPtXLZQXulwjBYKYyIh0vcv7nm7
         a6lJWDMKXXGRoLWEAn43C8PbdKRKhhGXTj1OKr4cKVPTJMDFMqJ91eneN6nKrjVRohQF
         kR6b9ddL4D9S66hTWJgMLr9XAagv+Jf9iTymAsFbyTpF2EQXdCBcnN/W7GB8ggk04C+T
         lzcJfePr6ym+K2Ds+AIW5LKtmHh033XKVEZncGM99Zl9jJjxYMPlJ1dsdGMTHFfRtUfK
         qrSVp3CqwR5I0BvQIfDNvX9RLPhJj+VcW/nJ3cw5BWGniKD9vTk0QRAwGYY80wX+RIft
         k7xw==
X-Forwarded-Encrypted: i=1; AJvYcCXRD6j9Ocv+86kdNt96sKj20tM27JdFkzVFfPR0WFvYZx0RoTHsOr5g0XCM0g2B+E9gjqiAnsQlnOZgvbEu4EaU@vger.kernel.org
X-Gm-Message-State: AOJu0YzjMuE2NPdYWWAoI7qgpLgjGIYBj0KpGMy8LEANvVai4rKp261N
	NCYAidF2v3752+c6Vsr73oklPTR7mtNEUFZ/gYb5GrfVP+K4IVj/YKYfSUd+sRNt84wfodi7chj
	JDS1Q0Zty0JOyvkg6VjdqYXoRXfU1+aSTqSNm
X-Gm-Gg: ASbGncumZ6JgER3Eim8IdhoPD3KtOiIVXmiw/5fOvs5B5C/vRXZm+1RsnZmDDSCU+ZO
	Q93qPdFm7FQUNE57MQARuuEEehpZ3P5lKzZsa+dM3qmngmHtLO23kK9xf+FSTcNiSE2fKE4sMV9
	uKO/PYQlz3uB+nIwTH8jUWH25TRg==
X-Google-Smtp-Source: AGHT+IEkPdMwZ8WcM0NCVDBRKNBfRF3H5QjAYRWB9xGokTDyk0HbI2IP6QgSQCQIroSqKz5jQL30tQKsNIXmV5emA5M=
X-Received: by 2002:a05:6e02:170f:b0:3ce:7852:1e9 with SMTP id
 e9e14a558f8ab-3d2b7622218mr3867015ab.17.1739990286725; Wed, 19 Feb 2025
 10:38:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>
 <Z66YjGvjD_yzEHUg@google.com> <tencent_45B4E91CA370C563D6420A1A25F992056D09@qq.com>
 <1b8b234f-6435-45cf-83e7-8e86c84f075f@linaro.org> <CAP-5=fVAhLLH-a0_wLo8dPoMLOb6rOJiTgGh-OFZJJoaLFE-8Q@mail.gmail.com>
 <fe46069e-c52e-45ee-b4b3-8b929fb83b31@linaro.org> <Z7UHieRRnvRb5_oU@google.com>
 <CAP-5=fWXmNoFLyWv+vo7hhLSqTDy7hf+-huKRD9OUWnO-GESRw@mail.gmail.com> <2834c9d7-f401-4b29-8f92-22193eb9ce31@linaro.org>
In-Reply-To: <2834c9d7-f401-4b29-8f92-22193eb9ce31@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Feb 2025 10:37:54 -0800
X-Gm-Features: AWEUYZmb7ZDC7Xg-vuEYcAR-MFR4dQhVVLJv_XLUmWBSLQWG90K_v4rSjZP5nUo
Message-ID: <CAP-5=fW_Sq4iFxoWPWuixz9fMLBPyPUO0RG0KPbYa-5T0DZbTA@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf vendor events arm64: Add A720/A520 events/metrics
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Yangyu Chen <cyy@cyyself.name>, 
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

On Wed, Feb 19, 2025 at 7:25=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 18/02/2025 10:33 pm, Ian Rogers wrote:
> > On Tue, Feb 18, 2025 at 2:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> >>
> >> On Tue, Feb 18, 2025 at 09:30:23AM +0000, James Clark wrote:
> >>>
> >>>
> >>> On 18/02/2025 12:41 am, Ian Rogers wrote:
> >>>> On Fri, Feb 14, 2025 at 2:02=E2=80=AFAM James Clark <james.clark@lin=
aro.org> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 14/02/2025 5:49 am, Yangyu Chen wrote:
> >>>>>>
> >>>>>>
> >>>>>>> On 14 Feb 2025, at 09:12, Namhyung Kim <namhyung@kernel.org> wrot=
e:
> >>>>>>>
> >>>>>>> Hello,
> >>>>>>>
> >>>>>>> On Thu, Feb 13, 2025 at 11:11:01PM +0800, Yangyu Chen wrote:
> >>>>>>>> This patchset adds the perf JSON files for the Cortex-A720 and C=
ortex-A520
> >>>>>>>> processors. Some events have been tested on Raxda Orion 6 with C=
ix P1 SoC
> >>>>>>>> (8xA720 + 4xA520) running mainline Kernel with ACPI mode.
> >>>>>>>
> >>>>>>> I'm curious how the name of PMUs look like.  It is cortex_a720 (o=
r a520)?
> >>>>>>
> >>>>>> The name of PMUs comes from Arm's documentation. I have included t=
hese
> >>>>>> links in each patch.
> >>>>>>
> >>>>>>> I remember there's a logic to check the length of hex digits at t=
he end.
> >>>>>>>
> >>>>>>
> >>>>>> Could you provide more details about this?
> >>>>>>
> >>>>>>> Ian, are you ok with this?
> >>>>>>>
> >>>>>
> >>>>> I think they wouldn't be merged because they're core PMUs, so shoul=
d be
> >>>>> fine? Even though they would otherwise be merged because they're mo=
re
> >>>>> than 3 hex digits.
> >>>>
> >>>> Do we know the PMU names? If they are cortex_a520 and cortex_a720 th=
en
> >>>
> >>> It will be "armv9_cortex_a720" from this line:
> >>>
> >>>    PMUV3_INIT_SIMPLE(armv9_cortex_a720)
> >>
> >> I see, thanks!
> >>
> >>>
> >>>> this comment at least reads a little stale:
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next=
.git/tree/tools/perf/util/pmus.c?h=3Dperf-tools-next#n76
> >>>> ```
> >>>> /*
> >>>> * There is a '_{num}' suffix. For decimal suffixes any length
> >>>> * will do, for hexadecimal ensure more than 2 hex digits so
> >>>> * that S390's cpum_cf PMU doesn't match.
> >>>> */
> >>>> ```
> >>>> James is right that core PMUs aren't put on the same list as uncore/=
other PMUs.
> >>
> >> Ok, then I guess we're good.
> >
> > I think you may be able to do things that look odd, like today the
> > "i915" PMU can be called just "i", I think the a520/a720 naming will
> > allow "armv9_cortex/cycles/" as an event name, then open it on two
> > PMUs if they are present.
>
> I assumed that was the intended behavior. It seems fairly useful to be
> able to open on ones with common prefixes.
>
> > We may only show one PMU in perf list as
> > that code I think assumes they're the same PMU as they only differ by
> > suffix:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmus.c?h=3Dperf-tools-next#n384
>
> Yeah that is the case. I didn't realise it when looking at the previous
> fixes to keep the suffixes in perf stat output.
>
> > I can imagine aggregation possibly being broken, but I think that
> > works off the number of PMUs not the names of the PMUs, so it should
> > be okay. Probably the only thing broken that matter is perf list when
> > you have a BIG.little system with a520 and a720, this may be broken
> > with say a a53 and a72 today as both of those suffix lengths are >2,
> > but maybe they use the "armv8._pmuv3_0", "armv8._pmuv3_1", etc. naming
> > convention. I suspect the >2 here:
>
> Also the case for a53 and a72 right now. Even "perf list --unit
> armv8_cortex_a57" doesn't work because we deduplicate before filtering.
> Adding -v fixes it though because that disables deduplication. Perhaps
> we can change it to disable it with the --unit argument?
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmus.c?h=3Dperf-tools-next#n80
> > would still work and be correct if it were >4. If that changes then
> > this will also need to change:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/Documentation/ABI/testing/sysfs-bus-event_source-devices?h=3Dperf-to=
ols-next#n12
>
> That could be an easy fix. If >4 is enough to still get rid of all the
> uncore duplicates I can make the change?

The change would be great. I think it is sufficient and doesn't break
the suffix:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/drivers/perf/arm_dmc620_pmu.c?h=3Dperf-tools-next#n710
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/drivers/perf/arm_smmuv3_pmu.c?h=3Dperf-tools-next#n921
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/drivers/perf/marvell_cn10k_ddr_pmu.c?h=3Dperf-tools-next#n1062
it is hard to tell as it is going to depend on the memory addresses
placed in the PMU names. Perhaps you can clear this up and add zero
padding in the drivers if the suffix is <=3D4 ?

No documentation here:
https://www.kernel.org/doc/Documentation/admin-guide/perf/mrvl-odyssey-ddr-=
pmu.rst

On a test machine I see in /sys/devices :
..
arm_dmc620_10008c400
..
on a different one I see:
..
smmuv3_pmcg_20528a2
..

so >4 but this is an ARM specific issue as far as I can tell, so you'd
be better placed to judge correctness than me.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >>
> >> Thanks,
> >> Namhyung
> >>
>
