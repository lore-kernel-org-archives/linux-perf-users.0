Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2CE33CD1
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jul 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720856587; cv=none; b=HlowJ1opHDQk1YavkE54zwPO7WeKZpokJdNmcBSwTvcl5/F/3nvOrUPvK2ZEYUkF9UE6KinaqTXxzHRaqRjYC74Tb1PZ4WBqTT2GUAX8GI+VhzZZPGOv5YG4Z7Z2h5iifNbgnHNdvG006rCUrdlRK8cGsMignyAQTsqOgLoZK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720856587; c=relaxed/simple;
	bh=ZWqEdHgcz+4uudQU/sHPR34TpX60s9IZRz8RQ5VkdOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3DPTzWPjYoh7Vor/EGeSqgYm9LIEacwkix9NVLdMQiBuV1xn8/RnuSi2xUJwDaYoSnzl8ymkbwAlLtk/Jv3D5YgS/fGZXebC/uFyr58K4mjL3H8yNL++rueNjojYBq5npOQnAvDJxXSrjYfl0vqdlHS8Fwf+M6ftD6eGEJ3bjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S3bhHixt; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S3bhHixt"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52caebc6137so2329422e87.0
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Jul 2024 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720856584; x=1721461384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0ss37jV9lTaJ6DYS3+pxIxXoElnFV986o3Klbi+DcM=;
        b=S3bhHixtFcylGimLnpRTNG63sIKqHOXKuh5E06TUQAk6BXRHojLkUhWCbT9v7FCMCu
         V01oFVg+A3dI8TnZJRLYF02hZAhz7nJ6oNchCbUOv5ULG6Vf5huN8tPXrWr4KLU4xTWZ
         CuDl8OF5GhPxEXavStcv3+p/AazDOMPmeEqa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720856584; x=1721461384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0ss37jV9lTaJ6DYS3+pxIxXoElnFV986o3Klbi+DcM=;
        b=Ne9oxIvw2D5UJwpstzaG0yVKTX5eNJGcFY+k3z2g9k6ZgZwvKxNgF5pa4+C9cOJnnu
         2BoHhWAagXcCazJ7NvHCkLAU+w8FjD1Dp1q055OXzP5UKw5bHOHCcbJY9Kc9GiERrtXV
         d1DbWOqRoXGjjPH3CZEV50gUWPKT8gRxnEGxM/8o2Mdu38J/RKyFhDOGWcmf3AHlX5P4
         0m8YKYmQEM1kq/N59oEImcvEbk56ODwdTUi0brduk6Xoruf9BDLq47TWgQze8+3iHKE9
         EeZzt3LTA45wuY0k/8thO1IYABqTCDRJHKC5xAx6fG5rOaN35trbNdjGjJ0QofWcz311
         q2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWRQ0c0+m1sNokCRbmSqfKaFBdClJU/A0f+XRxhjVJYKGIXRhiVToPvLrUs3C2rhs/oTN/DkmTb3leBIE8uUfw1gSLeG7TERm7GFyhYM+/Aag==
X-Gm-Message-State: AOJu0YzTIWezxOsCqeYdzNa+czCfPFk+9dHXbZ2JTfvss8GnottNadxR
	smC3GrIlCgkGt2QV7Nnu7zEnJvcU5N+uKPBYeE0amnxhX8MkLCchYUMLjAO5DFdZH6nTqVA79KH
	9zPMH8u5ACq587S8FTGhA+lkN7aVzeMzspXGE
X-Google-Smtp-Source: AGHT+IFPi274+tFWUtAjuaJOoWwBzCxKxVXq5jOkTPqm/Wd71CXr/zbc+FsAJ1xNZz/WbG8M1xvWmwzFo3GKXUEW99U=
X-Received: by 2002:ac2:5972:0:b0:52e:be50:9c55 with SMTP id
 2adb3069b0e04-52ebe509db8mr5677138e87.52.1720856583990; Sat, 13 Jul 2024
 00:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com> <CAP-5=fVwZfV+gNWcmEtRnkOtrvozMdXPVrZ37COHkf4BX1VPgw@mail.gmail.com>
In-Reply-To: <CAP-5=fVwZfV+gNWcmEtRnkOtrvozMdXPVrZ37COHkf4BX1VPgw@mail.gmail.com>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Sat, 13 Jul 2024 13:12:52 +0530
Message-ID: <CAD2QZ9ZLHQ62d5CDpf14DkrWFs_FggRMdqzGFz3qsmF_vmS00Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] perf: add logic to collect off-cpu samples
To: Ian Rogers <irogers@google.com>
Cc: chu howard <howardchu95@gmail.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	rostedt@goodmis.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, yangjihong1@huawei.com, 
	zegao2021@gmail.com, leo.yan@linux.dev, asmadeus@codewreck.org, 
	siyanteng@loongson.cn, sunhaiyong@loongson.cn, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com, 
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>, nadav.amit@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 3:28=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Jul 11, 2024 at 5:16=E2=80=AFAM Ajay Kaher <ajay.kaher@broadcom.c=
om> wrote:
> >
> > Add --off-cpu-kernel option to capture off-cpu sample alongwith on-cpu
> > samples.
> >
> > off-cpu samples represent time spent by task when it was on wait queue
> > (schedule out to waiting for events, blocked on I/O, locks, timers,
> > paging/swapping, etc)
> >
> > Refer following links for more details:
> > https://lpc.events/event/17/contributions/1556/
> > https://www.youtube.com/watch?v=3DsF2faKGRnjs
>
> Hi Ajay,
>
> I wonder if Howard's improvements (not landed) for `perf record
> --off-cpu` would solve this problem for you?
> https://lore.kernel.org/lkml/20240424024805.144759-1-howardchu95@gmail.co=
m/
> Or is that approach problematic due to the use of BPF?
>

Thanks Ian for your response and sharing Howard's improvements.

Yes, perf --off-cpu is based upon BPF and having following restrictions:

- target binary should be compiled with frame pointer, same mentioned
  in tools/perf/Documentation/perf-record.txt:
  =EF=BB=BFNote that BPF can collect stack traces using frame pointer ("fp"=
) only,
  as of now. So the applications built without the frame pointer might see
  bogus addresses.

- perf should be complied with BUILD_BPF_SKEL=3D1:
  Warning: option `off-cpu' is being ignored because no BUILD_BPF_SKEL=3D1

- off-cpu, on-cpu samples are not on the same result page.
  (I guess Howard has improve this, not tried his patches)

I have tried to collect the off-cpu sample same as on-cpu sample with the h=
elp
of  kernel/events/core.c. We will get one off-cpu sample from the target ta=
sk
sched-out to sched-in. Or we can say off-cpu samples are not dependent on
frequency provided by the user to perf record.

I am also worried about having so many samples if sched-in/out
frequency is high.
Thinking to merge samples if attributes are the same (i.e. stacktrace)
and add the
off-cpu period to previous samples with the same attribute.

-Ajay

> Thanks,
> Ian
>
> > Ajay Kaher (3):
> >   perf/core: add logic to collect off-cpu sample
> >   perf/record: add options --off-cpu-kernel
> >   perf/report: add off-cpu samples
> >
> >  include/linux/perf_event.h            | 16 ++++++++++++++
> >  include/uapi/linux/perf_event.h       |  3 ++-
> >  kernel/events/core.c                  | 27 ++++++++++++++++++-----
> >  tools/include/uapi/linux/perf_event.h |  3 ++-
> >  tools/perf/builtin-record.c           |  2 ++
> >  tools/perf/util/events_stats.h        |  2 ++
> >  tools/perf/util/evsel.c               |  4 ++++
> >  tools/perf/util/hist.c                | 31 ++++++++++++++++++++++++---
> >  tools/perf/util/hist.h                |  1 +
> >  tools/perf/util/record.h              |  1 +
> >  tools/perf/util/sample.h              |  1 +
> >  11 files changed, 81 insertions(+), 10 deletions(-)
> >
> > --
> > 2.39.0
> >
