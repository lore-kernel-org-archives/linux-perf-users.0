Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1AF28FC
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Dec 2024 05:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733549066; cv=none; b=gKBa8rgwGhs0mXAS3KzAbky52fOdum7LjgnS3IIe5Wj0CMcEC5nT+pLzMjZc5YBMHX2KL2LHixQBj3sdzLXwac1dDwagrpv6kH8bwwIC06oyZzY99s+HDoPMTeEgpwGv9SlS2VIfCu+rqb2D6u3wBRW1ONs8KadUSzJ77VQYrgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733549066; c=relaxed/simple;
	bh=2K0emPQqgBQ9oBcqR0nFbQartjnpOFBMsUE2xkjHNOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=titRLd6Uo0LsNzCrQd4HG5opum2oH4wsB8C5UMZ8Wg+taQoXILy0znR9HlxbVE2CHZAqMyqc6WGP5phomdyKRnJhz5QvpEIjZC3pcL76CWuSlmbaAwhPRKP3bpauG8eHvwnbjKTSNPXPKtAeGFeuGDvH0/3Ke657ps12k4PAu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huRuDuNE; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huRuDuNE"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso45015ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Dec 2024 21:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733549064; x=1734153864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OxJ2iCjWZ16KBHYZLjraakAvQeFU/uCVYCOXfPgYGw=;
        b=huRuDuNEJnpkbgaAtnZ47ikHVZ1lmSCLMAwufVc6A24paKMf4Yobid7vzOkcyGpoTm
         woiSSpb8GEl1aDDaR1vvxlhxp8mO9nwNr8+O2hdJX79n9clGOqKhM44Qicmec8NgVFpN
         t9q9AFJyjfEAfnBhdohaul607bxgiaLW6ThUunNaUFVnzFivO6U9AgCXrs4Umw2alXvR
         gjpPYrcxWhTLE4YqIHjjjCpLK6tXJBFquQq2wNH6pcVTeCh1vw+aXrlCCie5RQYZOgKv
         zFs2IjiUIKg7OKMkD1GYP9j4/2Yv4xmTfA93J5W6zcQmqS8ERxfmn59sA6k+d99gyObC
         gNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733549064; x=1734153864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OxJ2iCjWZ16KBHYZLjraakAvQeFU/uCVYCOXfPgYGw=;
        b=MpUEzVDfUSjoPTSEcD/3+ODTOuZhxTVRncgiPx1/Sgi/ePWZGhexNT07Q4s7e+27k0
         IX9IimI5JS6McWxyZ5Ilj9NyLqaBX1VgHic4J+5zABIEBw4lFEubvRHh8bXNF+9zWeUn
         Cvb/xBFCfnu+3yFTDG8IruSEbPaNqSoAE7bzJ2vZZpotTN183Oq4+JZldAIWfeOxwzLy
         40aOtMz38qeYUA3UW6odmsr3gCRqZe95PCFJZbQgqOg7NnEu+LRnin9uHwlsvH15RTsX
         MFDNwanHXnfOXpwnEqn71SC2MV02QRQgsiyB3N9eAd+ybKgI2T0UfgiKaLJWQeN0GHJR
         3Mjg==
X-Forwarded-Encrypted: i=1; AJvYcCXvROARbISJMIahlj8l/dU9JSh7Hdsat/B6ArFX2+aMFqkvKeVMSqi/V3ECdfYxg2B+Iz1s9Zs3xodK0nYEkG+7@vger.kernel.org
X-Gm-Message-State: AOJu0YznNT1eA3CqJQAU83aUr+LIofCoDXYc4yQroGPZM72qTPT42Uad
	WyKfyj5Kw6VOOqmaKKJZpMoF/H+MmDpAu9fN3oOLEn0AXlEoqiZUnpdhe3LyaL8NV8vhhqvKmBC
	rYiQLPlbJo+IBrOhZJV7rOS7VGK3ToZIgaOky
X-Gm-Gg: ASbGnctEeDcrTRJ7/q2kOV0UwS7hHPNxRT1CJi677eDGH84DKX2TYZZUNul6wrI1TM1
	H7TNU5Rf31A/GTva6AfH6hx33fXOsO2su
X-Google-Smtp-Source: AGHT+IFkSFn4ONKPsuCGA6zIMysWQnkXZs+/dkzRq4qJpLOGbhmBC7NLoEDCri7N7KdHttdePnUXKl65JqZd0MtpqgA=
X-Received: by 2002:a05:6e02:3309:b0:3a7:6126:ca3 with SMTP id
 e9e14a558f8ab-3a8717725b2mr1703685ab.24.1733549064069; Fri, 06 Dec 2024
 21:24:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com> <20241206044035.1062032-2-irogers@google.com>
 <20241206102451.GA3418674@e132581.arm.com> <CAP-5=fVDH6k7rW3_LXK5Y9Givs3WO5MQ8XMKsuUXXY5nQ66qDg@mail.gmail.com>
 <20241206230321.GA5430@e132581.arm.com>
In-Reply-To: <20241206230321.GA5430@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Dec 2024 21:24:12 -0800
Message-ID: <CAP-5=fXOE3k9bmYOykpN6M9bBwLqP54MWWMGxutJ4SS2G_3MZQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] perf: Increase MAX_NR_CPUS to 4096
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 3:03=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi Ian,
>
> On Fri, Dec 06, 2024 at 08:25:06AM -0800, Ian Rogers wrote:
>
> [...]
>
> > > This series is fine for me.  Just wandering if we can use a central
> > > place to maintain the macro, e.g. lib/perf/include/perf/cpumap.h.  It
> > > is pointless to define exactly same macros in different headers.  As
> > > least, I think we can unify this except the kwork bpf program?
> > >
> > > P.s. for dynamically allocating per CPU maps in eBPF program, we can
> > > refer to the code samples/bpf/xdp_sample_user.c, but this is another
> > > topic.
> >
> > Thanks Leo,
> >
> > can I take this as an acked-by?
>
> Yeah.  I will give my review tags in the cover letter.
>
> > Wrt a single constant I agree,
> > following these changes MAX_NR_CPUS is just used for a warning in
> > libperf's cpumap.c. I think we're agreed that getting rid of the
> > constant would be best. I also think the cpumap logic is duplicating
> > something that libc is providing in cpu_set.
> >
> > And we have more than one representation in perf for the sake of the
> > disk representation:
>
> Thanks for sharing the info.
>
> > Just changing the int to be a s16 would lower the memory overhead,
> > which is why I'd kind of like the abstraction to be minimal.
>
> Here I am not clear what for "changing the int to be a s16".  Could you
> elaberate a bit for this?

I meant this :-)
https://lore.kernel.org/lkml/20241207052133.102829-1-irogers@google.com/

> Lastly, I also found multiple files use "MAX_CPUS" rather than
> "MAX_NR_CPUS".  Polish them in a new series?

Makes sense.

Thanks,
Ian
