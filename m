Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1214CDE8
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jan 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nS/ZPVYt"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e36375f91so2892e87.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jan 2024 08:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704904170; x=1705508970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYd13Zejpu03Q/f4ErgpB8c40cbt6HWQmYbgmsVrrrI=;
        b=nS/ZPVYt/WFSBZS4JpFk2hobSuBW7l1mICI6a60EsxEqD8KcPpdA3RJ+dpwYytoDUZ
         3nFVHGCbD3ryL9iGFESC8U4Ukx6hscao6wCvfllN0xgG4MB/TZ8vPbnTxsS+HJKtuf8E
         aKVuuq3Faw4YfWCMAmpFLburaqKN8r2up6bHgxa/he9wZKz84bBCHMfRFFVvvWlIru/D
         3FArvcuUVC8xWGFHcSei8PMAx70JOiNWjQHTO6tSEIfIXbMoCwDyrEk5v7iVzC9rCpYK
         9wDrPJDesDSttlAvs8U/SK9xc8cGLfmJkmodLgpXXbVeSRSpyMw6YnsK+IZe4KbeYvIy
         jkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704904170; x=1705508970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYd13Zejpu03Q/f4ErgpB8c40cbt6HWQmYbgmsVrrrI=;
        b=FCT0WdX1s/iMMLVLhjWLKfC4foDOgHNM9IIXoZSnW0s03AITuDLhbIcDwUXSKVpuQj
         2HAfb2giB89DjT/pAeROJGmQrJr4IjyHF3lTeMl8UoCNXucLb2EOfeC6WWtrsyZC5RLQ
         e59lcj5VdR94LjIaQ+H3YJ92UIJ93qG0FpCZfuwO0aTbopNsDAp9tujVhj9FjNecpR25
         UvUnnZBAPChg9D+J746pZ6n/HT1dswLnbLvxPPE6Wwtq/j3k79vHL/IWc4s4WQ3tPklB
         q2y9LshlML6rXT2xj86v9cjWSaWxG1uKvzWT0CtCqUp1WvwZFTIYIrQPP7WigTZQ1U8B
         /4fQ==
X-Gm-Message-State: AOJu0YzTKoPowrWVpRU2WYZRkSmMeGwUHheiTKJCaWib3hWetjmiQWXQ
	DV2625YcI/o9y081RJEX+VpZao9X4CJtZj6hU4awde4/rL1n
X-Google-Smtp-Source: AGHT+IF5vM4N157aKb2AtB6x57aJsQ++ajAOqzDCXdw5TMmo4troBe/GusuB30ksORNAUtvkL8aYJotylri36ah/+bs=
X-Received: by 2002:a05:6512:2205:b0:50e:d1f8:461d with SMTP id
 h5-20020a056512220500b0050ed1f8461dmr44339lfu.4.1704904169658; Wed, 10 Jan
 2024 08:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZYbm5L7tw7bdpDpE@kernel.org> <4d86f3b6-eaee-4673-bdf5-3b97c1c1ad17@linux.intel.com>
 <CAP-5=fUfJ-VBGS1D2+WM_eBu4uPGvxJ2KyD4WXzgKRCfGKHTQQ@mail.gmail.com>
 <ZZfwjG-HL5yOEh6z@FVFF77S0Q05N> <CAP-5=fUK+t1p0g3dKtgyP0g3oixM1G7Xm4BFneY5EMzRW_urdw@mail.gmail.com>
 <ZZ12PhUfA_wPAaRR@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZZ12PhUfA_wPAaRR@FVFF77S0Q05N.cambridge.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Jan 2024 08:29:18 -0800
Message-ID: <CAP-5=fWCn88KchSdQg87FRY0cpH4tVqO0UEYMhE=ioANeRBdwg@mail.gmail.com>
Subject: Re: perf test hybrid failing on 14700K
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 8:37=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Fri, Jan 05, 2024 at 09:21:21AM -0800, Ian Rogers wrote:
> > While much has been done in the perf tool to work around latent issues
> > with ARM's PMU drivers and the behavior changes they have instigated,
> > except for 5c816728651a ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE
> > capability") where I wrote the original version, there doesn't seem to
> > have been progress made on the ARM PMU driver nor on ARM testing -
> > which was why such an issue could exist for so long, across numerous
> > Linux releases and ultimately break Hector and Martin.
>
> Ian, which latent issues in the PMU drivers are you referring to?

Core PMUs generally have a lookup from legacy to non-legacy event,
from the past discussion this was missing on the problematic PMUs
hence the sysfs versions.

> I already pointed out that one of the problems you have claimed to be a d=
river
> bug is actually due to userspace incorrectly detecting support for the ex=
tended
> HW type, and I suggested some options which you have so far ignored:
>
>   https://lore.kernel.org/lkml/ZV-CUlQhlkdOzfFZ@FVFF77S0Q05N.cambridge.ar=
m.com/
>   https://lore.kernel.org/lkml/ZV-ItX1eMeIdo_00@FVFF77S0Q05N.cambridge.ar=
m.com/

Those suggestions look fine but you seemed to be suggesting testing.
Lacking hardware with the broken PMU(s) I'm not able to do this. Could
you turn the suggestion into a patch and test on BIG.little? I can
test on Intel Alderlake.

Thanks,
Ian

> I agree that testing is a problem, and we need to do better from the arm =
side.
>
> Thanks,
> Mark.
