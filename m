Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BCE2D4B77
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636817; cv=pass; b=jRdm8NVgWJWwF0C3Dqf1qcrooKYWnfa4kuQCRNtc0PIjgQoxU67hH5CaD3plS9SJGr5BSAr10qsZkB2x4Vuj0EW41LPlAGQiCVv8LO4CNJPVEmU5Lz2i20RYQTj+JTitYzpQIDLmrsa+Jt33+DvT+vyP6/ju1K3URVsqAb2KCGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636817; c=relaxed/simple;
	bh=QMyzR8AASiC8mc5ezn9gZm2PPHye9eCV0x2StDMZX2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Yji04/3Wrnf/gHUVKjdP9LxTgmQHliL569D39WwOMnWjei+23FZICGWnMasXRjJss6XuWoiQAlS3ZQNMvucLoQgry5zbGAJpVDxkKEBIBnP9HR5rkGwkq/omDrBwED9fZFhdb24W4xkagw7NMMxFpm80xtUNJHPxWKQ5rfwlzV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vek6o7IK; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vek6o7IK"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a1462573caso7405ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 13:46:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769636816; cv=none;
        d=google.com; s=arc-20240605;
        b=U4P3ZHqIJF4/u5+XbvqpmJVOYhwsRG2tBe1JufSH9BTneSlZl74W6Zsl5lPqLXG1JT
         TpB9h4OTRQ96EPRuKGV/hkvAmTNnMVVJ3RWWxTgqPy/nYyar6NQA6iL2OYvptndeBG9k
         Y/n54CPU9DjaeQhmF3xhOfcIktH0aR/e9kwFCk5wdG868O27XsRWrueJ3v1vmOzcRdK5
         dxAxdKV0N38eEErp+2wTtIovD6ZYl7tRkv25nc0Q98+8hDkbQqyT/kfF6b+iHnTVYfwO
         FkZP9o0cSCeCFkymy4qHRpkQQXVMB5sYlgbPsAkOGfYDN62u/WGjfidG6/QIpz29udjV
         ssfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QNas9XIWeoMZdUnffIbpQ/NSw81LufKuyHUtTwShFg0=;
        fh=Z6bXmmqzjqH1W1gt5aJePet0UgPrKFXxxRvzqoyNA2k=;
        b=QHX0dW0UXZZazpbP0YtZuIBgSnADIIC12GxI+OeZ2JbSt9IrGSn7pqVCd7YmoTwUtc
         nPvwm7HE2yNqYveafVd9qRGs+sFQZ/qoDo/cR3lUg3GY5uHxsz1z/1+q3zWxDnjNTxRR
         edchSY5ogpm5g9v3Cjzy32FuI1kInaBH2o5rY6Dw6wLJ6OMHyX5t2+Ou2s6iZroRscWd
         YDX1tu1Dr1wHU8slatLCv9IUcr4lDKGP2AThE6EAkIQBST98zs3s2X+enLt20oEnYwn8
         aQu3CraOzbQYz13UhQ96YO6IGaB2DetesCQdlY7kx8wE4ppBxFSkz02KacdKLSa45ylm
         Icsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769636816; x=1770241616; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNas9XIWeoMZdUnffIbpQ/NSw81LufKuyHUtTwShFg0=;
        b=vek6o7IKG/NzGKb+Q2KEfh6tpjAAGIAQNhYeiZFFMyhf8XL+a3FpE+Poakip/n7fEu
         VT4c2cxlbST4MDcEBZtaGWFev05akbKi5+4gmWKtHqPrhNAW+w8sm4qLRVZHwRW52+a7
         joEibu2LeROprRlZghBryCGrOoUn5uPOIMJCZb6/LLIOQ9wHpbuyF5qgBqFQSgWfhlgm
         ndN9oh0RxVsIOgqwsrsHHrGuJvGUqR1bUHQyyOs4wzqOKDt2Z69zGYEvpQ3B+q2w54mc
         iT9z6oUGmMk9M12Feyzp5DBxW4N2lfiCiuUAvu33L6Xair8xF6XgyvXbxDKmkw+z+x3L
         CBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769636816; x=1770241616;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNas9XIWeoMZdUnffIbpQ/NSw81LufKuyHUtTwShFg0=;
        b=MjgP2dxClRIFj1ocqaa3XJumbGzOyNpCMm+w0f3xn5iyeHiLzn0ieS9szAPQaVSeOV
         AcP324sVRuEp8snmQK0VN84lM7/WBlL7MKF4glJohBQfSvbxS4GS2d40oPSyaiMaFbDY
         ZLYjkfzJxb3xQ18S8wFLw99WcITDEmnKDz1C+K4qMKoIDcE4sKMtkQADiZF/N78wok3+
         unZS4acQFjK/PziIF6+JVPOQ+uy99+Zk4x5rZszh0sjM/A2s9pETQQBUwXUvAIcT7HR+
         3YJNpxqy0tsqsm2P5lqfA3tpQFngNzdTaJLkxSooUIBPBniqc4ftGUvVWUy7ucLASodM
         BY3g==
X-Forwarded-Encrypted: i=1; AJvYcCUBPkvS5GrXPaFB5/QcpefpbchHjCnt8i6JLai5edj0qEyF4i6LGamtzFS9T7UOlBP9GiQ2bQ+ygg+ocHrWbG+T@vger.kernel.org
X-Gm-Message-State: AOJu0YwqwaTwbuKkbVEi2W6kh5St7V4n2pAv+JhP89DDSvl7I+x5TNVA
	1Y/IGYnKdVlYmHPElezK2g34axr5lwbUhHe8tQP+36X+hklKejLNO5xqeihkcpJnA+sTlwgyPd8
	wJwbbWSBDBIJKcHOGD7sbrN+JI2z6hbugnyeT6MEg
X-Gm-Gg: AZuq6aIX9zcxMwNxhnQSDn2rtcsLigU3Nm/vmhnSxaV8yhxpGVqfFS0oQ/0X6ZIB3tM
	gkBNSNZjV2HA2GhzQrq0oK5AhsAYGawsslzEv7G9X3MfcN9ui6ILpx/4ZxPBe6Oo2ShavPo5bKQ
	bXCf+zcEN0k9sHZzl+7Mu3EzI6yLpT3Q+b1sPwqe9WLIlidDfNLg+NgPDayD6wi3eCle88S6O7S
	TzCJERknCR8hfYJkSg9W+/izGNXWGj26MSnu+rdQHy54G48G7q03aFH0WvFkU/7IkVJF1J73pkX
	u2+gnJuGWl0eXYPP0M1d4jXDFA==
X-Received: by 2002:a17:903:2407:b0:2a0:867c:60e2 with SMTP id
 d9443c01a7336-2a8c056afc5mr145795ad.19.1769636815148; Wed, 28 Jan 2026
 13:46:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108212652.768875-1-irogers@google.com>
In-Reply-To: <20260108212652.768875-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Jan 2026 13:46:44 -0800
X-Gm-Features: AZwV_Qgi5tfNcgJYFojzjzcLY7kFpaTYTW9TAeDo4H19OzIHp54C6JsjroDKyow
Message-ID: <CAP-5=fVHXpgS=yhTzDrA_zGqa-Fav5i=QWo+djN1uDTp4rJY-g@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] perf stat affinity changes
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 1:27=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Change how affinities work with evlist__for_each_cpu. Move the
> affinity code into the iterator to simplify setting it up. Detect when
> affinities will and won't be profitable, for example a tool event and
> a regular perf event (or read group) may face less delay from a single
> IPI for the event read than from a call to sched_setaffinity. Add a
>  --no-affinity flag to perf stat to allow affinities to be disabled.

Ping.

Thanks,
Ian

> v6: Drop merged tool event change. Move TPEBS fix into its own patch
>     1st.
>
> v5: Drop merged changes. Move tool event reading to first
>     patch. Change --no-affinity flag to --affinity/--no-affinity flag.
> https://lore.kernel.org/lkml/20251118211326.1840989-1-irogers@google.com/
>     On v5 there was discussion with Andi Kleen who points out that
>     affinities will work better with real time priorities but using
>     this requires privileges.
>
> v4: Rebase. Add patch to reduce scope of walltime_nsec_stats now that
>     the legacy metric code is no more. Minor tweak to the ru_stats
>     clean up.
> https://lore.kernel.org/lkml/20251113180517.44096-1-irogers@google.com/
>
> v3: Add affinity clean ups and read tool events last.
> https://lore.kernel.org/lkml/20251106071241.141234-1-irogers@google.com/
>
> v2: Fixed an aggregation index issue:
> https://lore.kernel.org/lkml/20251104234148.3103176-2-irogers@google.com/
>
> v1:
> https://lore.kernel.org/lkml/20251104053449.1208800-1-irogers@google.com/
>
> Ian Rogers (3):
>   perf evlist: Missing TPEBS close in evlist__close
>   perf evlist: Reduce affinity use and move into iterator, fix no
>     affinity
>   perf stat: Add no-affinity flag
>
>  tools/perf/Documentation/perf-stat.txt |   4 +
>  tools/perf/builtin-stat.c              | 114 ++++++++----------
>  tools/perf/util/evlist.c               | 156 +++++++++++++++----------
>  tools/perf/util/evlist.h               |  27 +++--
>  tools/perf/util/pmu.c                  |  12 ++
>  tools/perf/util/pmu.h                  |   1 +
>  6 files changed, 183 insertions(+), 131 deletions(-)
>
> --
> 2.52.0.457.g6b5491de43-goog
>
