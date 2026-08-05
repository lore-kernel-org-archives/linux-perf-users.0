Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4505C3A0E99
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956966; cv=pass; b=VO0lnhoLpCJcYlAsBEcAbeoEA0BJr5sgTgaxUgKXEufsZ4pFV8a50aAg78kk0Ed3XOqdpPCW5GXrMDLDOyqZmy5coLcDULxIZGYz/rVeQVhz63kt5Zdbe+9V0HeeZiW9szfXnY+X1txlH8RG+frEDXn5rA1xmYyEAy3MusSrY/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956966; c=relaxed/simple;
	bh=tRtbSZM5Zc2m2fCRmYZJ44y9UBxfraKEkCcFQ/lPDDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAgfwo7FnS9pPI7tiJfcfesIzW/htSzJVxzsLvTZdtDa8bZR9exwH49GUSgWZLORg4cFvm4MKaQk5qPE4KVWwCkcv08eSrm4mMV1vJrIqF3t4dRWoWG6ubqBQxV+O4tx8fDcTwonzcfkPFuQ/oVVLArIGgNaVBMrfnJHgo37Zq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hEejN9mM; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hEejN9mM"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c15a5b265so58461cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 12:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785956964; cv=none;
        d=google.com; s=arc-20260327;
        b=DVKnyvriiDZ7eedhrd6MF6fFAoKcN3t2owZM2amXgRR3R7IoDZSJmpmiJytq/oxdFw
         iOnhdDwykSCDpflUgsQzGnn0Sth0LTDA0HnLKPMONHCYRG+XypgttB4w08NFSwWGnkiJ
         ZUtcmw1ipSona3yryieC/g1YwA5DG3AfNUPGDyiy0qei/ZvXY4kSWkwjH3TTiuhRx1Uc
         2suNYFae+1ID9AsY1/f5kxWi2Uf4izkRLSPBBetgUjaTbMMBKkljmg+wGGIua5u3qV1/
         gu99bfiKUMgEZaBpYxu6FUuUPviAzWEMmmsnc8qi//vyI55J1LnB0qmWydfTywjHjSq0
         kz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ip7sA4v4HXZicF09b9p23+We3T8NTe71O3C/0+Wa4vc=;
        fh=8GPEfdZcBsN9mhLtGIOEnFj4mDaXBDUxXkSJoY+9Z7o=;
        b=bVV5X5NInsvui5SFD8vibDdfXWnuTvL+9X9rRKeuscPl74FRmtLe6zjJJXhLzgRShc
         2ulelWt1Lyx1X0FE5E9n7hTru5wAmS4NBwg8Syjxcxropd7mSFOIr5dAqHtU9UN0mLm2
         htP3NJqpzlhTxLt7TEJ5k/0OZBNCeUQAs19T0FPcUH2hJ4I+VLdzPf66QbcB6rF391lj
         HbEO4dES8peyjVd15X7j2YsRVJf/nDbxsN8mk1ORuYvmiCjwZvAaKjV2TCMU2zhFrtEf
         f7JjOZqLKbA/W81ZPl1z/VgDzIkCkAK2xe/zLQyP+/GD1eQV+3ercp+iIQFfV+Rg0qJX
         f49Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785956964; x=1786561764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ip7sA4v4HXZicF09b9p23+We3T8NTe71O3C/0+Wa4vc=;
        b=hEejN9mMe4k2q/fZHyGAIRATIlJLTa7pMavyaqKPaYAugrgtXcbfps1AqLbcsy5CjG
         C2o2LXkK+5L8R/hEx3LydMaNANhgQI4bcxBy2NwhPk3/TYUmSYTE7/6Y0kBV2ju8lrph
         PCP5YKdyE09IJuIDMspNxhbZcOoKGhVgi75mK8sepgBJVhvKgrdOQ2TM3XySsj7aqGJN
         VcQnmUSJS8jXVV8T7mVMPQxA6VcynILopg0sfuSXrcALvK5adc/xVrjrSNFb28g3LZsg
         4ccohMocoG+avoG/0ZN3mThnr06kb0rbEa8isaAUFYZ3AiwaIsmzc7OCfW9+AQ2TL9d7
         OgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785956964; x=1786561764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ip7sA4v4HXZicF09b9p23+We3T8NTe71O3C/0+Wa4vc=;
        b=X//76gPDD34mzJDBg1PeI797HS8Cj10YZ4x6B7wDBokdpo3UNnPZh2zi2uhmWtJo1J
         r2PtQGg5GGuM3m4YZNUYfqpvZSQ+wW6wncHl4sPtPFM14l5s9ojl8LPenQMtV7VETqWE
         LtEEZVg2NICKGMIGhrUqdnVFZmzK2ehHR4yLUbO6Tw/nVtm1kYHXTNiSiNqFXWRKqdCD
         vuCJGXca13bk0UzLCChJihFOIF86Sep5KPfVNVoeHwwnf7/PbdSQVSPKFQBxsrCiOxl3
         NRF5zVZv4LNxrNt2dpd/tNvpDlquluBfnREKep4zeV/gAFQT7obiYFZCQV6Q9zZ+p24R
         O5UA==
X-Forwarded-Encrypted: i=1; AHgh+RoCyzI94mgykODSg2aCTXUa+64LsYj5lzKUPFvPcALsNd8FnpOyNA8y3YegZZNa6cZrlTA7Qgz4vHhSd4NpmkWO@vger.kernel.org
X-Gm-Message-State: AOJu0YwZCfbAIHb/tzKvM1J7C8rUNLpM9rK/wMX74CZTAL+HtQ+PmPI8
	/ilDe2i6iPPv6is2Nr6vYGCauYJD+g3EpHGLDcw58jrn2vTNMReJph/mzUgMs5JUy5bR/yUdmPq
	TAfZ8fhHjn3fy2r+I3aQRvYVJ37s3hzHNw1fs7RZs
X-Gm-Gg: AR+sD11beKxQ87JiAaNyrHkaP58yvlyaP+Wn/kaLrp3FyscVMqMeyL9Z+8hdlL+UNGw
	PFSizZD8ME9fV7FvjwumAO7Lnr4VHLqFE6VyLNtaSluPAar+rF8qKwRE/BRDJaFNCJJSJvUEi1C
	kHQYpx5GA+TU8yt3MLWHKzIUiev8amd4d0BNwqQhUlwXM9/P2A0yaK87yAB1xlE2othVdiZQdY/
	PUORf3UTaWnoXg4qSFJrwlgndJP3UlXpFOzA0HUKzE6ZIUPDAcstVsHL5gc/aoU0v2xYy0HK4WC
	Bf+Bbi54bmosn06ytywxFsDIVA9fwcydHe8cL8p90HftBaAaib2cC1TBlM9OsF601TGp
X-Received: by 2002:a05:622a:134b:b0:528:3186:5799 with SMTP id
 d75a77b69052e-52cfbf29554mr2038131cf.10.1785956963538; Wed, 05 Aug 2026
 12:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805133013.235016-1-acme@kernel.org> <20260805133013.235016-7-acme@kernel.org>
In-Reply-To: <20260805133013.235016-7-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 12:09:10 -0700
X-Gm-Features: AUfX_mz4Fnqg4DBzZJBapcTXAhv3Ra7yRETF6ARcmGNlkgBQEBsPXPVdEa0th8E
Message-ID: <CAP-5=fUKrQx5hZaNUfYLHAL4Lkg806jNNTRpZwYMnpngX2=a4Q@mail.gmail.com>
Subject: Re: [PATCH 06/12] perf jitdump: Fix funlockfile on unlocked stream in
 jit_open() error path
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:31=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> If the malloc() for the initial read buffer fails, jit_open() jumps to
> the error label which calls funlockfile(jd->in).  However, flockfile()
> is called later in the function, so at this point the stream was never
> locked.  Calling funlockfile() on an unlocked stream is undefined
> behavior per POSIX.
>
> Split the error path into two labels: 'error' (after flockfile) calls
> funlockfile before cleanup, 'error_noflock' (before flockfile) skips
> the unlock.
>
> Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/jitdump.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index fd11e07bf00b7978..c3f11d1c1d76d6c7 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -155,7 +155,7 @@ jit_open(struct jit_buf_desc *jd, const char *name)
>
>         buf =3D malloc(bsz);
>         if (!buf)
> -               goto error;
> +               goto error_noflock;
>
>         /*
>          * protect from writer modifying the file while we are reading it
> @@ -244,8 +244,9 @@ jit_open(struct jit_buf_desc *jd, const char *name)
>
>         return 0;
>  error:
> -       free(buf);
>         funlockfile(jd->in);
> +error_noflock:
> +       free(buf);
>         fclose(jd->in);
>         return retval;
>  }
> --
> 2.55.0
>
