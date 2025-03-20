Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989B74BED
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Mar 2025 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487289; cv=none; b=TRz6gpdtkv1SpqK68uiJ8pyMXWHxlCYUpDaoRPs4Ocs0bO7ypoBm9H8CiMmPACxTgY27tGKuxLakYGgdqSwTYF7Cd65MRvB2OGylfCVnoR9xv2wVk4FydADut0X02LoaBAorlGoWFrCwLXPcebWfklFKaWrLshOHjhkkFRtrCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487289; c=relaxed/simple;
	bh=ifrRfiFiGLjy5/kioXPgn4QTU6kdKDttQmJhZjTKTCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcwJlWGnhIVqxgpWeS00UEg1xwR79jTThijpXiwSoibSkhBW5a+JsWQYhxWXZkMpWDjD9uTG2k1qBchRrCw4kNqhsvGnV2vzceNUK7orYW2tiB/5sjhyqpy0n/DlAJSpXfsfVcKKFXWx3etIevs9ZXHXxnXtS7/Jz+7rPXyZ0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IdJTDg7I; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IdJTDg7I"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so1771023a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Mar 2025 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742487284; x=1743092084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgKpMMyMOafptAKyBG1mzXxlPUkssnGf6TM2QWwcXbs=;
        b=IdJTDg7IXjHB5TLrpK0hGggljZ64rx/LGj+JNV8KVw1uTi91JZbI3UbSnE8yF4fEHg
         WW3/WnTrA9hy+tV1KZzyWHzww/I+7PXxUsVaWTewrPtKOdivNx5lbBVeAO8M4GxXtbiL
         HUJ+G4pW6EvUu47zOSbH4nyPrpQmssrvvDvkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487284; x=1743092084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgKpMMyMOafptAKyBG1mzXxlPUkssnGf6TM2QWwcXbs=;
        b=OMXXRChD3PBRmFgN5x/9S47zxseorWUH0DkxTH9/aHUTjJ8AlzLfJivWHSPqs28MUl
         aXFYJNikTk26+JtwDAOzrF6C+g9VpJfPk/foQCRip5g/4ygdL+LmJCrVJpSZV68aN/iw
         F6bZrkIQrYgepjhXwIsmNMHJGI87IMqZqTKWo+e/QJTBvDXD3ro2VKtWriBctB0bYVLb
         PtxP8nqHpjvO0bGa4nUlnHTh5Go9UtmwBPzTQzJSsgPBUxxuxcRaJz97jvtX7RHK5WJc
         zKDx4/0VZHYVAuCQFgyCYHkyvsQ0GRfOveDruhUqdYD11cmo+ax1g+mLuf6m2Isbqf+D
         gS9A==
X-Forwarded-Encrypted: i=1; AJvYcCVtyZJ0TWj8MKf0z8PJl3wBu+dXQpfdCaGOrMgs8nf5c2TXF78UCSMOJp9yI5pLBGMFoLnOWT+stFMwWqCWlUBw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz8lMmV0deFRTv2PHu6+m89tYSr4GGQrNmpEa9gsEqpJSIcY0d
	1yrZOB0oJywjZcfvZKeIyzrfUGMaDUoIe6Qd8xsPfPZzbAgJO9fTul9dzLqTSiRPtJBybtQKEW6
	Ibw==
X-Gm-Gg: ASbGncs8Ak9oIibyrCmMDY/Aql5+5nK89MQ3vWgsa9VGjl2qwQTD1ivPws9B9Tf+Fwh
	eQZc8C8Fhcg/4MF7K7QB8qSwmZXucPAm0J8RMOrfWDQSFWA2OU6h7rWyJOzNWCl9kA+aovoVSYr
	40xBYolBo+Cv4CNj6oC6AWYNAyTTdu3vxf+HRyve5jdtxSvErze6G5nc5/0ksR0v93Ne+a7DvwS
	3euk+rUy7FYz4OGED5Cl1a9n6Rd0/LzlVWTjncByeNTbGNzkcqsVF0HQ8ANkAE+sgwkbNFV8Iqd
	HRkKkItsF4IZ3RQH0fsTkbWhXTt1OLarl1j1MICStfcOHUVrGSVEzaNbBy6orYMp3vMDelWLZS1
	v4uc2L/ww
X-Google-Smtp-Source: AGHT+IFIHAAbMt0L5Dj8spguYtDQohq5GHsLtcFbkRPlf1tAPFIPgT2ZhIpDEHxfLaQV9seYEGldjg==
X-Received: by 2002:a05:6402:354a:b0:5de:dd44:929e with SMTP id 4fb4d7f45d1cf-5eb80fa3cb3mr6664278a12.21.1742487284452;
        Thu, 20 Mar 2025 09:14:44 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf8ccb0sm9778a12.30.2025.03.20.09.14.42
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 09:14:42 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso1506507a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Mar 2025 09:14:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXD+gXlQujft7WLGWtgmxipUbgvXAfB5p51TsYaTQMO99cEpuOEsU92VDzDsdwQoaddxUxfwVR5vagsx0KI2am+@vger.kernel.org
X-Received: by 2002:a05:6512:12cc:b0:549:8ebe:b3c8 with SMTP id
 2adb3069b0e04-54acb193389mr3321744e87.11.1742486808634; Thu, 20 Mar 2025
 09:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fV-t6j9SOSUHLO8H8LWEmB1E4KZtKa3fQWiMx7y12gjhQ@mail.gmail.com>
In-Reply-To: <CAP-5=fV-t6j9SOSUHLO8H8LWEmB1E4KZtKa3fQWiMx7y12gjhQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Mar 2025 09:06:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WWUiCi6bZCs_gseFpDDWNkuJMoL6XCftEo6W7q6jRCkg@mail.gmail.com>
X-Gm-Features: AQ5f1JpF9sCuzDNdO5q2qlHtgQI6MPM9Bpy_gqRVuh3gszX3bRjLlOVcnTluNQY
Message-ID: <CAD=FV=WWUiCi6bZCs_gseFpDDWNkuJMoL6XCftEo6W7q6jRCkg@mail.gmail.com>
Subject: Re: Remove the "perf" hard lock up detector (watchdog) from the kernel?
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Vince Weaver <vincent.weaver@maine.edu>, 
	Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

+Petr who helped a bunch with getting the buddy watchdog integrated.

On Mon, Mar 17, 2025 at 2:26=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Hi,
>
> The kernel tree has two hard lockup detectors. The perf one uses a
> perf counter to generate NMI interrupts and detect a lack of forward
> progress, whereas the buddy approach uses the soft lockup hrtimer to
> check the next CPU is progressing. Doug Anderson
> <dianders@chromium.org> recently questioned:
>
> https://lore.kernel.org/all/CAD=3DFV=3DWfB6inJPuwfhbw4mtFBYpr+3ot2J+SJAZ3=
pT3t4fW7cw@mail.gmail.com/
>   ...but I'd also have to ask: is there a reason you're using the "perf"
>   hard-lockup detector instead of the buddy one? In my mind, the "buddy"
>   watchdog is better in almost all ways (I believe it's lower power,
>   doesn't waste a "perf" controller, and doesn't suffer from frequency
>   issues). It's even crossed my mind whether the "perf" lockup detector
>   should be deprecated. ;-)
>
> In the perf tool there are warnings associated with the NMI watchdog.
> The metric code also has a flag on metrics where events aren't grouped
> when the NMI watchdog is enabled. For example:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json?h=
=3Dperf-tools-next#n1916
>
> The warning and breaking of groups is currently inaccurate for the
> buddy hard lockup detector as /proc/sys/kernel/nmi_watchdog is still
> present to enable or disable the buddy detector. That is the perf tool
> is currently warning and breaking event groups stating the NMI
> watchdog is a problem but the kernel is configured to use the buddy
> watchdog.
>
> I'm unaware of a way to determine if the buddy or "perf" counter based
> approach is in use and to correct perf's behavior. A patch adding such
> an ability (say a new file in /proc/sys/kernel), and perhaps new
> abilities to switch watchdog at runtime, seem less desirable than just
> deleting the "perf" counter based hard lock up detector. The perf tool
> could make the NMI warnings and breaking of event groups conditional
> on the running kernel version then.
>
> Are there objections to just deleting the "perf" hard lock up detector
> (watchdog) from the kernel tree? Are there reasons to keep it around
> but just not default?

In the cover letter of the patches to land the buddy hardlockup
detector [1] I talked about some of the pros and cons of the buddy vs
the perf hardlockup detector. Pasting them here:

Overall, pros (+) and cons (-) of the buddy system compared to an
arch-specific hardlockup detector (which might be implemented using
perf):
+ The buddy system is usable on systems that don't have an
  arch-specific hardlockup detector, like arm32 and arm64 (though it's
  being worked on for arm64 [5]).
+ The buddy system may free up scarce hardware resources.
+ If a CPU totally goes out to lunch (can't process NMIs) the buddy
  system could still detect the problem (though it would be unlikely
  to be able to get a stack trace).
+ The buddy system uses the same timer function to pet the hardlockup
  detector on the running CPU as it uses to detect hardlockups on
  other CPUs. Compared to other hardlockup detectors, this means it
  generates fewer interrupts and thus is likely better able to let
  CPUs stay idle longer.
- If all CPUs are hard locked up at the same time the buddy system
  can't detect it.
- If we don't have SMP we can't use the buddy system.
- The buddy system needs an arch-specific mechanism (possibly NMI
  backtrace) to get info about the locked up CPU.

I'd expect that non-SMP systems are quite rare these days (and do they
really have NMI-enabled perf?). I'd also expect that most systems that
have NMI-enabled perf also can handle a NMI-enabled backtrace (arm64
was in that state for a while, but it was a "simple matter of
software" to fix it). That means that the only real downside of the
buddy detector is that it can't detect when all CPUs are locked up at
the same time. Off-list someone pointed out that could possibly happen
with certain classes of bugs where all CPUs could end up trying to
grab the same spinlock...

That all being said, though:

* Currently, switching between the two hardlockup detectors requires
recompiling the kernel since both can't coexist. From what I'm aware
of the pros/cons I'd think most people would want the "buddy"
detector. That probably at least means it should be the default.

* I have no idea if it's worth keeping the perf hardlockup detector
code around just for the small number of use cases where it could
catch a bug that the buddy one couldn't. My gut says it's not worth
keeping the "perf" hardlockup detector around.

* NOTE that we still need to support more than one type of
"hardlockup" detector because, from what I understand, the
arch-specific powerpc hardlockup detector _is_ superior to the buddy
lockup detector. See "HARDLOCKUP_DETECTOR_ARCH" in the code.

-Doug


[1] https://lore.kernel.org/r/20230519101840.v5.14.I6bf789d21d0c3d75d382e7e=
51a804a7a51315f2c@changeid/
