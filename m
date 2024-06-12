Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D716D4D3
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Jun 2024 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193135; cv=none; b=en/VaHmkCukElfPglC9AIzBoenIVhLiLVxN8ZDyuYWF45Btb9DhPSg4IwyAygf1EXflYS9qzGWlmb+sWWLK3fQo+AkdWs1VMtuDFhggosvBJvMw4bmCEBsx8BYP/yM9rh6zQjW0O7XJxOlCjIAww7e6bgM9gk0Z+AVXkufl5djE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193135; c=relaxed/simple;
	bh=7LD66xSINsodhZwvGnWbhgzSoyQkiGmOvbl8gmj8k74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dV8Q7DxfhYlQoxfJRuF90xcNR910da2qLqhLP1sgXf9+D/gYRt1xhIQJi6N++5yH1ZMgs7lUAZN+8N+1ntkCM5I5qFLWIOxH6WWsNn+FaGaZbB/wPmPMXlkI4ZwpYUVN4ngjTSAOSrtCr8A/6NGUmqf7oS53lhPTi2bctG/wzGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePrY1PSU; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePrY1PSU"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3748a9fa84fso127865ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jun 2024 04:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718193132; x=1718797932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDVeyfDKY20hrMZkPuumvahLgkbZ8XPx+xCcPCGoUlg=;
        b=ePrY1PSULnehCzJdymZiHOBvcxokV7audVCkbGWr43nPF2gU8yNI0se7qGOzyEOjhF
         g5n6YykUyrdBHXE1uCALmuff+3DtgSORUmC/SGZq6yTA77xT2LVnBW/6MuALdgzwnoGV
         PTzXdBnTyvJ8pT50fnz3MXdzmvWhcOw1Js6V45mUC2aLaYBHCYQJwfc3MsJhqa+RQeaN
         x82AA3KALYSRcqBPxPojF+xaNFOc8NNlct+jIJ20L0DS0tmj9pfrZUECLmSjWmBgUtFc
         6PlMoJ/kRFrcT2sGbK72o3ZbnHIPPyyhiEYzhL1SEq8f9fE5uAvfqtecwbfufjcePKCw
         I1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718193132; x=1718797932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDVeyfDKY20hrMZkPuumvahLgkbZ8XPx+xCcPCGoUlg=;
        b=q+PMr8CtNyH1n6y1FmFJD1rGeC4QUyeZe99GAAilmZ5vkiw5SXiB+Ny2wfYUz5u+mc
         lVD6qX8je5OG3NX2C8YlUTO17cUrR2a/DS/p/+oq5hhvE67JXOYVVziKtYr00pyQUfuz
         FSxPrIC+xeSCyBWEvd+Xbf11TdAyK73UQVM2vLY/2Ch9DC3HeLcpA21z8Fat4NT4P/FY
         hEm0NSPXH6h+GU7/r8xxKON8R8pWBtG8UKx5L6BhBHfzE9rD8GFQFFbqPphr/piEcsC/
         3MtCUdlemoSzmlHCCf2L8LK9YKGvriSq/EPUb3R50+K6oElom5wn92hvrMsJM3YicWPN
         0uSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPzPpQeAkZq5Bb7o9lT7chI1JSmCfrnahST5jWXhllHtpcaei5s4sctQfmPVDPdAjHD/9Sodqi+ciGOGD77+DV4DTafMDH6iN5RpwsVNA2uw==
X-Gm-Message-State: AOJu0YzZrveKSNiacmh1sJxh6laG/Z01SyCNgwonxiJIlTDMQvU3Rntv
	7wDcf/uXEUanyTTyV2I4R6v/wYka9cQjlKUNxeQvgDdCFZU5ZahxpKxL15QUCDWnnrBX9ORHxBe
	/ILPmwZmQ+EqR67JUn4PHgyFUkSmRVKNLiaws
X-Google-Smtp-Source: AGHT+IE89xTmZD7j7eQRxBBnlT8TqLZ55txucZmJnqJJq5kOu47qog8PEr5hK2uyKYXe4HWIQ8krODHQ97o4tQ4XXuM=
X-Received: by 2002:a05:6e02:3f82:b0:374:984c:5c8d with SMTP id
 e9e14a558f8ab-375cb51be3amr3078965ab.16.1718193131991; Wed, 12 Jun 2024
 04:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607065343.695369-1-irogers@google.com> <cc4ac58b-6a0b-1d72-f881-a60b43d5c229@huawei.com>
In-Reply-To: <cc4ac58b-6a0b-1d72-f881-a60b43d5c229@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Jun 2024 04:52:00 -0700
Message-ID: <CAP-5=fWNDkOpnYF=5v1aQkVDrDWsmw+zYX1pjS8hoiYVgZsRGA@mail.gmail.com>
Subject: Re: [PATCH v1] perf arm: Workaround ARM PMUs cpu maps having offline cpus
To: Yicong Yang <yangyicong@huawei.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 3:16=E2=80=AFAM Yicong Yang <yangyicong@huawei.com>=
 wrote:
>
> Hi Ian,
>
> On 2024/6/7 14:53, Ian Rogers wrote:
> > When PMUs have a cpu map in the 'cpus' or 'cpumask' file, perf will
> > try to open events on those CPUs. ARM doesn't remove offline CPUs
> > meaning taking a CPU offline will cause perf commands to fail unless a
> > CPU map is passed on the command line.
> >
> > More context in:
> > https://lore.kernel.org/lkml/20240603092812.46616-1-yangyicong@huawei.c=
om/
> >
> > Reported-by: Yicong Yang <yangyicong@huawei.com>
> > Closes: https://lore.kernel.org/lkml/20240603092812.46616-2-yangyicong@=
huawei.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Tested worked for this case:
>
> [root@localhost tmp]# echo 0 > /sys/devices/system/cpu/cpu1/online
> [root@localhost tmp]# /home/yang/perf_static stat -e armv8_pmuv3_0/cpu_cy=
cles/ --timeout 100
> Error:
> The sys_perf_event_open() syscall returned with 19 (No such device) for e=
vent (armv8_pmuv3_0/cpu_cycles/).
> /bin/dmesg | grep -i perf may provide additional information.
>
> [root@localhost tmp]# /tmp/perf_Ian stat -e armv8_pmuv3_0/cpu_cycles/ --t=
imeout 100
>
>  Performance counter stats for 'system wide':
>
>           54994604      armv8_pmuv3_0/cpu_cycles/
>
>        0.176079800 seconds time elapsed
>
> So:
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
>
> But still wondering why isn't it better to move this into pmu_cpumask() a=
s does in
> the previous patch? Yes currently this is a arm specific issue, but we ca=
nnot handle
> the case if later PMU doesn't update the cpus/cpumask either :)

Thanks Yicong. To the greatest extent possible I'm trying to avoid
unnecessary code during event parsing. On x86 there isn't a PMU that
has the buggy behavior of showing offline CPUs in the cpumask, so
computing the online CPUs and doing the intersection there is pure
overhead. The online CPUs calculation is either going to read a file
or probe via sysconf. The fallback sysconf probing may fail and can't
handle arbitrary holes in the CPU map (like in your example). So I'm
concerned about the overhead of doing this in pmu_cpumask and the
ability for it to break non-ARM platforms. I think the right
conservative thing to do is to just have the buggy cpumask fix for ARM
and work toward fixing the PMU drivers so potentially in the future we
can remove the fix there. Something I'd like to see is greater PMU
driver testing and detecting bugs, like:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/pmu.c?h=3Dperf-tools-next#n285

Thanks,
Ian

> > ---
> >  tools/perf/arch/arm/util/pmu.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/=
pmu.c
> > index 8b7cb68ba1a8..6b544edbd3f6 100644
> > --- a/tools/perf/arch/arm/util/pmu.c
> > +++ b/tools/perf/arch/arm/util/pmu.c
> > @@ -11,12 +11,15 @@
> >
> >  #include "arm-spe.h"
> >  #include "hisi-ptt.h"
> > +#include "../../../util/cpumap.h"
> >  #include "../../../util/pmu.h"
> >  #include "../../../util/cs-etm.h"
> >  #include "../../arm64/util/mem-events.h"
> >
> > -void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
> > +void perf_pmu__arch_init(struct perf_pmu *pmu)
> >  {
> > +     struct perf_cpu_map *intersect;
> > +
> >  #ifdef HAVE_AUXTRACE_SUPPORT
> >       if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
> >               /* add ETM default config here */
> > @@ -33,6 +36,9 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe=
_unused)
> >               pmu->selectable =3D true;
> >  #endif
> >       }
> > -
> >  #endif
> > +     /* Workaround some ARM PMU's failing to correctly set CPU maps fo=
r online processors. */
> > +     intersect =3D perf_cpu_map__intersect(cpu_map__online(), pmu->cpu=
s);
> > +     perf_cpu_map__put(pmu->cpus);
> > +     pmu->cpus =3D intersect;
> >  }
> >
