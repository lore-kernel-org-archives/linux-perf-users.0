Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220972309A3
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502320; cv=none; b=bwn0adOKl20VvVkbJhtfhQojJK8mzIyM4AxAMMor5dL53pAy2wx+IU3NbMT15ctGku9BtY2Dd+zwSuL+CLlJu3ONQvgkzM0YJMFk5wtwLZvrDYPI3VGbQIE4XANq7jpqpNRoWhAyNAYVaCZHIvLCOMI3aqekBkVMCdKF63g4KO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502320; c=relaxed/simple;
	bh=ei0FtpHHrZUcxUt8WzTuRuIK31qZw6OThe6/aKViKtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5PbhvMpAO931TTpc34sUO4aM73BNB4SOPbxPeQ0q+MzzTSZKfwU9Pgd0yPgtUEqOuxp++HzSF0fsRmCpJl45wTX08l+K2aVP9HQcIJMQQkQj14MapLB7iW4CP4JJ9nKucipRXBNSdf93e4MC6Yn6sPypUsh7qc7J77lSo9KHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUv+Q0kf; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUv+Q0kf"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so85565ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Dec 2024 08:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733502318; x=1734107118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7AN4YKGkPuhBlqSxu9pcW9rYzEsgmg57zAfnSADqwM=;
        b=BUv+Q0kf6WC4j5MEVOF5XMOgQUm6qHL2SAZbquaC0PjG9wVkbvYyq+HAzHC5aN1ctR
         0gHG7+Q0Af8v574fnmCfFQdy1D2p+2DQqYyeRYwStluLprTpQVwV9oByDZuEfa7xxxlu
         WPvJtmi2n7NfHcuKHA0AN2DTIItAZxpudBUiQUvgRJVzp7iC4TvMCM/rXs/bFlmfu/HU
         iVY7+ZDfR/ovKD5/jOoRGcXlclpJRyPjccolrqXoWWYvjM0fotLvxbfX7cTJvXb2dCRu
         sEsrr5btkXdAmzcr4K094EcB/lPEYoHgwjk04fybbJEvk1SwiDDBjy4Y0Bjvmkk1907z
         oMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502318; x=1734107118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7AN4YKGkPuhBlqSxu9pcW9rYzEsgmg57zAfnSADqwM=;
        b=wBIj6xNtm7cVwHTXT75EL7h7KWZq8T1Y/F6ZxoloVRAFgG9hxmvps4Q1BwK/3yCtxG
         DzP2tqI2Y9GqOnjpkLBg8CCEDTxh1Pqtn6BHdgXcngwO3YtCw50+h7u0kJLWSjbV2YEa
         90Ma2CDVYOWyFaft2+xfueb1Z6vEVe4JFeI7KNL5ffvF3FKhZqt+S52eleY5qLUN+4vt
         c7cRM9ZO1hjt5k0FPVszQmK6MwSHxnRUY4bVa+OMbg3tL19hYwUdEcj3MkqHaNgXYz4B
         VsryVv7NwSshyOmt96K3x6gl+wQme52n2c6F9fZRVqyPxsJ8mfKna1SBqKysrZpI9vDU
         jr4g==
X-Forwarded-Encrypted: i=1; AJvYcCWt5tJX9rrArHWodcks7cIJui515XqraaQTk1lpYquxO0OLB9gVUgZFSa4bF66shWiBDqMO3cTs2GhIN/gHH8v2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7YhfY9AtpbCivATUyshKfmkXz54nZoYO686oYoewrhNn/+ktb
	EW2B8IJa1xD7suNG8yBj+hmgg89YFipQ4NbD+naz7efdDxJQ5Bp0ln1Jo1/MmE7M9MPJGtGd9Fz
	keT74L9zAIZXvMLlwPDZW3iaDQy3j9AaxCfxs
X-Gm-Gg: ASbGncsVXqHTQL6S91SM+zWWyIQuF7tLPCeiZPiC0zdBM9Uv0Usd6z6EDMuqd2IgC2A
	3gi9mtCOPU0nYkHnOx0TV8RMmIT3DoVG3
X-Google-Smtp-Source: AGHT+IEwiUM7lSchJOJMWcRstd5T/zhaT5EPwLxomkR/JEk3yV8g29msWYUMSgXl/Nhrl5J83dk6tUOv/1uuSGw6VLg=
X-Received: by 2002:a05:6e02:3a86:b0:3a7:aa54:ce04 with SMTP id
 e9e14a558f8ab-3a812c4d915mr3484025ab.18.1733502318069; Fri, 06 Dec 2024
 08:25:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com> <20241206044035.1062032-2-irogers@google.com>
 <20241206102451.GA3418674@e132581.arm.com>
In-Reply-To: <20241206102451.GA3418674@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Dec 2024 08:25:06 -0800
Message-ID: <CAP-5=fVDH6k7rW3_LXK5Y9Givs3WO5MQ8XMKsuUXXY5nQ66qDg@mail.gmail.com>
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

On Fri, Dec 6, 2024 at 2:24=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi Ian,
>
> On Thu, Dec 05, 2024 at 08:40:28PM -0800, Ian Rogers wrote:
> >
> > From: Kyle Meyer <kyle.meyer@hpe.com>
> >
> > Systems have surpassed 2048 CPUs. Increase MAX_NR_CPUS to 4096.
> >
> > Bitmaps declared with MAX_NR_CPUS bits will increase from 256B to 512B,
> > cpus_runtime will increase from 81960B to 163880B, and max_entries will
> > increase from 8192B to 16384B.
> >
> > Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/include/internal/cpumap.h | 2 +-
> >  tools/perf/perf.h                        | 2 +-
> >  tools/perf/util/bpf_skel/kwork_top.bpf.c | 4 +++-
> >  3 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/=
include/internal/cpumap.h
> > index 49649eb51ce4..3cf28522004e 100644
> > --- a/tools/lib/perf/include/internal/cpumap.h
> > +++ b/tools/lib/perf/include/internal/cpumap.h
> > @@ -22,7 +22,7 @@ DECLARE_RC_STRUCT(perf_cpu_map) {
> >  };
> >
> >  #ifndef MAX_NR_CPUS
> > -#define MAX_NR_CPUS    2048
> > +#define MAX_NR_CPUS    4096
> >  #endif
>
> This series is fine for me.  Just wandering if we can use a central
> place to maintain the macro, e.g. lib/perf/include/perf/cpumap.h.  It
> is pointless to define exactly same macros in different headers.  As
> least, I think we can unify this except the kwork bpf program?
>
> P.s. for dynamically allocating per CPU maps in eBPF program, we can
> refer to the code samples/bpf/xdp_sample_user.c, but this is another
> topic.

Thanks Leo,

can I take this as an acked-by? Wrt a single constant I agree,
following these changes MAX_NR_CPUS is just used for a warning in
libperf's cpumap.c. I think we're agreed that getting rid of the
constant would be best. I also think the cpumap logic is duplicating
something that libc is providing in cpu_set:
https://man7.org/linux/man-pages/man3/CPU_SET.3.html
And we have more than one representation in perf for the sake of the
disk representation:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/perf/include/perf/event.h?h=3Dperf-tools-next#n227
Just changing the int to be a s16 would lower the memory overhead,
which is why I'd kind of like the abstraction to be minimal.

Thanks,
Ian
