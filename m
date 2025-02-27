Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6521519B
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635907; cv=none; b=WvE/gH+1BH3w1onQtnZ9m9w6342Pf0+AS59vCNBL4lyX/9YgFvLpKK67SjicvosP4r00HkcBrjTbtanfjged/K93HtJmOMD4+wYlU3u9++Xf49O0eHW/XcvfHeG2RTAP1bWFOHBi4eeAvNXFNOvJ3UcXOzyuuA3isdRlYinM074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635907; c=relaxed/simple;
	bh=U9Ko2CfUZgT3zHFGlYgdOTRrPtH1+klh5OcX47iEFGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sG19c9mt94+MvWCJ66zGCVkwWx/sdLeLdQZGi/NFwYeYzpkEvVPcKBsZt0eZd6F3taF3/KjPIXqkT5M89aGhCbE7Qi6PYI98vxNHna3lVMxRsbOldQuk0/8dem21eZbkps1TgOWOq0/0icJ5dCqySWGy8W1Yre1KSYk+TN6XdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wYkf3whD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wYkf3whD"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-221ac1f849fso71185ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 21:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740635906; x=1741240706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ+4Hrzy1g8jVUQp2XV3I6mnhjf3pzaCYd6tUG9vrrU=;
        b=wYkf3whDSDacXsgv6n69Ns6HgxcwtjVLWoUqS7NTI7wEe0Um5JWeUssSbafsqRJc52
         JOr1u33otUCghTidYFWx/SuwJ+rmRRKTubSqAdclQM59yzCrMGzy6y02164pEz2XQqsE
         6CP2JAKM9vaNAItLsUFo2QrcjLKE4VIIYhHZLjkJ5+y1Ndf3v+OT56GYralxIz2hMZ/D
         rvXE5r2Q5OSQG1P2ueOAdnKHQ/s3c1+1iviNxm692wB2hSc45pYg5uwfzJz2xCJLAEpm
         Jf++31wUZRJyks8gUYJbjml7vvZv55ZEMpnHTSt12fLSBBuIbzJ3Jd3c4+C6rrRTrS7X
         B8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740635906; x=1741240706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQ+4Hrzy1g8jVUQp2XV3I6mnhjf3pzaCYd6tUG9vrrU=;
        b=w6Xai09ZYKY4M7TF8pqSWTlK9VQ89tLUSc1Jqnu770zz2m8uD1NZacXVRVVzrrypr3
         hsHoVAReamJj0NFK/bDF6aw7nst6kUrTiwIis6oanh9x00E3ykl0h6MyTfAI7HP3UZye
         0/r5vDspyJsVlsPCMonzETUq8qDvd92VJiCwu5nq8DCN9AeZ5N4O+QxEgcD7PHQDJwm2
         FEEZDelhnYM8rHtKomAO4iCVwdXW94d8EwYJhUykMmTq9bR4lsg5uFskwSQwY/aLdStI
         r7+1wFLLKb4qnAcecmK7jaNG5cV6WHVjM+mGcBig/QOFr6Mk/+025JKYDoL99+pgY4Sd
         C8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVTReJHT/ndsoZHuHGPG74/1b41l4L6QRRDELvP7G5HJ2mmocezomfed7tTlazERPlr1Gp23tMpDtwBztcp0oS0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2gq07CKkZLeYyKM0vFmVCOAnHSx2eRdfKygUnlP7LeIvQNqCZ
	+soGc7XsRDyYCAj5lDKcm6KtHZnz7f2hjEg3H5pEVjy+5SB+3osEtDyVVxzgnepqdUFQDLh2B/C
	Qb1ormO5J+ecD58ZQcU1NWg+FyJl0JEQTWnlf
X-Gm-Gg: ASbGncu3/VG62EdZ7vDFc/Bnx1zCGGuhPCLI6y1aDGfQ+miY0C4vQm4SJRBvv1KsTvI
	pgAjg6wJf9FlsjqWL12l6CtXqgMoZdbcRuTVW2TUzSgJZV1gslUbdQmvGGNprLzVDWNew8s+Yjl
	YrpYXgx2fq
X-Google-Smtp-Source: AGHT+IEnx+T2EUYhLV7nL60SOcHwmiEcQVNvKhtLADVhI0BTbEjofGbl24Xg7WDkyW8AGRZUt7Og/o9Yj7psZgpByqQ=
X-Received: by 2002:a17:903:2647:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-2234d3abb47mr1940025ad.0.1740635905615; Wed, 26 Feb 2025
 21:58:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227053738.788153-1-ctshao@google.com> <20250227053738.788153-2-ctshao@google.com>
In-Reply-To: <20250227053738.788153-2-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Feb 2025 21:58:14 -0800
X-Gm-Features: AQ5f1JqtUPNTMgd57t0SN-iYHsb7gP8rKfmuINbHUyod6nt66X-e0k-Ap31iJXc
Message-ID: <CAP-5=fWqa_yKDC5F6TBc0AFH1BG982Zu_rr+7=xAj1rqarUj-A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf record: Fix a asan runtime error in util/maps.c
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com, 
	dvyukov@google.com, ak@linux.intel.com, james.clark@linaro.org, 
	christophe.leroy@csgroup.eu, ben.gainey@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:39=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> If I build perf with asan and run Zstd test:
>
>   $ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g -fn=
o-omit-frame-pointer -fsanitize=3Dundefined"
>   $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -vv
>    83: Zstd perf.data compression/decompression:
>   ...
>   util/maps.c:1046:5: runtime error: null pointer passed as argument 2, w=
hich is declared to never be null
>   ...
>
> The issue was caused by `bsearch`. The patch adds a check to ensure
> argument 2 and 3 are not NULL and 0.
>
> Testing with the commands above confirms that the runtime error is
> resolved.
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/maps.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 09c9cc326c08..41a99e1f4b50 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -1042,10 +1042,13 @@ struct map *maps__find(struct maps *maps, u64 ip)
>         while (!done) {
>                 down_read(maps__lock(maps));
>                 if (maps__maps_by_address_sorted(maps)) {
> -                       struct map **mapp =3D
> -                               bsearch(&ip, maps__maps_by_address(maps),=
 maps__nr_maps(maps),
> -                                       sizeof(*mapp), map__addr_cmp);
> +                       struct map **mapp =3D NULL;
> +                       struct map **maps_by_address =3D maps__maps_by_ad=
dress(maps);
> +                       unsigned int nr_maps =3D maps__nr_maps(maps);
>
> +                       if (maps_by_address && nr_maps)
> +                               mapp =3D bsearch(&ip, maps_by_address, nr=
_maps, sizeof(*mapp),
> +                                              map__addr_cmp);
>                         if (mapp)
>                                 result =3D map__get(*mapp);
>                         done =3D true;
> --
> 2.48.1.658.g4767266eb4-goog
>
