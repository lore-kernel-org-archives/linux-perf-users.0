Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57E3AFB0E
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955897; cv=pass; b=tTHbWz7AgjoTKOjXjNUO58chw/SAOKcC4OXCzNwiSl2rbm22J15tzL7BryETaITZNxfd9T7KP8A1gXomamj+1/6cNIN9dy1clMWLfVXqR9HdG6//mYCpKO5K0f6CR+S0bKXT1hOY1zjkhVbxJuro2bmo+4wFfvhAel+SkT1DJls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955897; c=relaxed/simple;
	bh=8O6yKVx4GkcgZbWfHqe+8Mn60MtK/KAOZxjTORCZ0Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6rfoxd6WCq1dcVWiDjOMdgsRGQ7xMmG3agFW7TkT57VN/rr1zNKBqa4xamH2j06Tg4NZX4VyBVclMwdOCZcD8Vyh0RzvhJHPlPHY/cR+gnxYCOkhOJLnMtaoD0rvVF2i8l5siLc/ZXdqeDH5ZovVqmobSjZIIYlM9crpZqjGA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/MGtufZ; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/MGtufZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf22c18ad3so447375ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 14:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780955895; cv=none;
        d=google.com; s=arc-20240605;
        b=UGZTN5191ltkr5BbRjBmk08jg3fCzi6hid7tXWqzCURt5e7YwdKEbdShS1662B4rm1
         KywvnEK8a8gguv0rhlMMo/ajo36IYtbtTaBtGxB/SCofXk13pVHuH6XIB7RRkp476SWF
         yrhKABnn4j6Eg5JFWd/4fQkMea/eyM3KySOUtQITDjw0DiTTl3x1ULF0vxJOfTfREGRp
         6Ems3uck8w7Z4GvH98GLOlE3ySCcuC81VUN9L8ouNmzMEaJDmcP2CXpc2oSj9mYnMKey
         LwTgmG3ODc2dnWbLU5iGVL8izmoukoCmMybheYFcwlECgFZihhu/3JQt715fjvWB0XwY
         r0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FZYk3j1U9+VAA8nXIGXgT5apYvr2DYklRqyX4KJd4Z8=;
        fh=EY/rBStiv8EQCzFym/87jMLAiH6bmvppRnu7HLZ/rjI=;
        b=ikm1pFEaUS0QmAzSPNSKF3kwQQ1fZHHXWAwVo1VdU97btVubIsFCpTZVAEuAZi5Wen
         nLDjmwJ3mZP8TFMy6FAS+oX5EUCvU6js+BhSPj1XVoPC7p/RbFFj3RFeQ5RPuUAvNHkF
         4eCOzumJrZJmC/UIytEcLIQrjx7mhKW0eAPx0T9ARqXR/+a6eX3hfe1sFUvbE/YhZuqP
         QK14nkzbmHrzehDKjns5T3p86eLg0h9xAVUM5Owp2Znl3J8Kg/wkhfMT2Nb36pyajw/1
         Vm/lJzn+xFueOEWpUIV0r2v1hHghhGb+4AH2WOQubzFmFV2i8ohrl6u4KXJRm5LrGx1q
         VhdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780955895; x=1781560695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZYk3j1U9+VAA8nXIGXgT5apYvr2DYklRqyX4KJd4Z8=;
        b=f/MGtufZIpodF7ofr2LRzF8IWF+Ml8T/bgK/vbNVhW7Ng6k2S5+63tGS4k/4naqXWj
         rgT10ibBY3v6NONMQkE9uy5iemrTAbleHKxfBRwMFtQDf4br30pg91iOfIHSbeyfyIOg
         glYOJTa5bqdAdj6WAMCSmpPuPi22Vfh6crTwyCVyIH7iFuFmmi5TUGejr3314Ir+O2tk
         sTFDNmzQpFrPmtMKo49kPn9irZvm8hTepNq3E837K5tXD+MxhpfztZuGr3ICYQeImbUu
         KiJ43zL81arfrKTXf9a10DvonvUtsJIPpmR2Wjc1SlDiR9H3J4vg/tmkkaE86jjeYgCH
         NyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955895; x=1781560695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FZYk3j1U9+VAA8nXIGXgT5apYvr2DYklRqyX4KJd4Z8=;
        b=Dv/snzAFGifATYLG4qZSJdZJG+oStL1Wl9u+B8N3HLd6TCLsAmAagrYTMqRKyX0TaT
         EhLPBzqc0IcuWccrktCj2YLZZZaqRh3jOBXH9TmcEEqUqSgL7woJiQ1BKVrDwA7hBttz
         YBokpjfzzrEN3nHcXmnl1uPLucHYd82O/CuSr/fzL6gCDR4WThXQLNLSWtCTVa+i389o
         z9TfQ7NdsV7NglSxryPVnU7PvC+/kAwJSS2quUUrpOdUqdRuL5XQuRo1J1OZABRq9Ymr
         BZPH32mMC2ImOETB+Ojqb9a91hIXglRiw90Jo50ZIwlsdig4hCK3Z5AiQ5ms8aNDp11g
         9TiA==
X-Forwarded-Encrypted: i=1; AFNElJ/QpVgecfM59HzSQI2VgHsT8nd6qwLcergwNZwMWdoOfYirCBhjkJLou5DhPDPhIapMSTo2t8XIGOWOeC0FzlvT@vger.kernel.org
X-Gm-Message-State: AOJu0YzPoZcl806S3p3AZb37vr//G0wlyt2yhTboJxFgPLn5JYipdbsA
	Qqy3E1fsYy6pEVTM7kbw9mKUX8q9OdhpFjaEMQM6XBlW3dtLUGyk6SCIOmEqfH+BjANmyVlUzTQ
	EQfgvuSVFh4UOl8Xw563jzWQ1lPXzYoUKUI2uMx+O
X-Gm-Gg: Acq92OEJRD8CX7En2KBfeG1sSTgoMj+m0gg5H2wrRgc/5HlApA9A1fxFE2Lmgjiv5HR
	akkjNiKzkR8CuF6Ut20byl2lCOBMakX8w44IkbhR0XXICXNcsJRHh+5+lYAcbAFOCK6FW/q8qY1
	fqGcnObNOuKQd7LjJvcjAvTorOMPweHBGcQOsHouRPX1Q7+/Bi8tEe1AVSy38b75shcVGVllP2w
	eqsFB1AUEjCCEvvQa+vmoR591p9aUtgeGKvVZcDXNHxIgGDQquBJndY7gsL65CI9EyOvY7itPkU
	rffvHYsrhYFTbzpTpXlu1QlsZc+GVptf5BqMS5PAHidA35it
X-Received: by 2002:a17:903:8c3:b0:2c0:c14c:bf37 with SMTP id
 d9443c01a7336-2c1eb50a69bmr5840675ad.16.1780955895041; Mon, 08 Jun 2026
 14:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608201753.1979464-1-acme@kernel.org> <20260608201753.1979464-5-acme@kernel.org>
In-Reply-To: <20260608201753.1979464-5-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 14:58:03 -0700
X-Gm-Features: AVVi8CcmLQfIN6fpJBiGGt6cUi1hvn_7G0DmOG2wsHetv4INmLkkXseKReY3iME
Message-ID: <CAP-5=fV-O+5ajOtCVBTS2fEvob=8n2+5iWs-+g6tdrVBe8x_1g@mail.gmail.com>
Subject: Re: [PATCH 04/11] perf tools: NULL bitmap pointers after bitmap_free()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Alexey Budankov <alexey.budankov@linux.intel.com>, 
	Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:18=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Two call sites free bitmaps without NULLing the pointer, risking
> double-free if the structure is reused or cleanup is called twice:
>
>  - mmap__munmap():                 map->affinity_mask.bits
>  - record__mmap_cpu_mask_free():   mask->bits
>
> Set each pointer to NULL after bitmap_free().
>
> Fixes: 8384a2600c7ddfc8 ("perf record: Adapt affinity to machines with #C=
PUs > 1K")
> Fixes: f466e5ed6c356d1d ("perf record: Extend --threads command line opti=
on")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Perhaps there's a need for bitmap_zfree.

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 1 +
>  tools/perf/util/mmap.c      | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index a33c78f030d91012..e915390556752b9e 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3084,6 +3084,7 @@ static int record__mmap_cpu_mask_alloc(struct mmap_=
cpu_mask *mask, int nr_bits)
>  static void record__mmap_cpu_mask_free(struct mmap_cpu_mask *mask)
>  {
>         bitmap_free(mask->bits);
> +       mask->bits =3D NULL;
>         mask->nbits =3D 0;
>  }
>
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index d64aec6c7c843e81..c6bd4c37d50ee57e 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -238,6 +238,7 @@ static void perf_mmap__aio_munmap(struct mmap *map __=
maybe_unused)
>  void mmap__munmap(struct mmap *map)
>  {
>         bitmap_free(map->affinity_mask.bits);
> +       map->affinity_mask.bits =3D NULL;
>
>         zstd_fini(&map->zstd_data);
>
> --
> 2.54.0
>
