Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3120B17
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Feb 2024 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418775; cv=none; b=sds0fy7rbSo4yi3VFUonRGrsJJa1v/g12TY632/Fa8KrB87mGOU6rmfXthBeqsLe+ByGMRBDlbWgFFQUaVc2BeoZ/pU6P/LW6Trneq681zBZByZUSiP3q9JsENV1R2aHyHPsw6lpkaLxpTuzcqsv7ri/WVY0o2uD2AHYddxg4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418775; c=relaxed/simple;
	bh=d06JzZrfurSH+GFP3SQuBGIsqzlybDAxzcTr5jKLY9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGvaKVPa/uSQe6Qyo6zCs5XMffpwF70Bf04qnddmLkqFVMHVSHy+nKejp0URFRBV3Nkhgpqkx5Upqe5COMJJSI0l06ueI8ZUKhRoKpjjoqlWZEOfiKnOPvBkMFpJriGZ6VXcXnGWpW/X7Y5m1nUTjPjdwI2fQO8y4s/Gw953g2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amTihs91; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amTihs91"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d93b982761so301085ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Feb 2024 10:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707418773; x=1708023573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYaw+GihRftYikU7DfbOWB/C78nj3a8FEHBnrx9ij7U=;
        b=amTihs912hJO0demSPKwaW41tSyihjs5qBwhDWHJwnnfoZZzqdkmhATwkJoDEhGvPw
         aKdyEyoH8V4tiE72urlbAFf+8nn824Xc8z1Kdm0gj7uaGZcIWFmEacNsi99OfJ+KVxOB
         mzd1XbNusXwUz2+xTgfuaJafDGKz4vWr7JwNx7flmRAXQQfuYGgbA4iHFb/wtaCPHesl
         hz5kC0GPjXxzkf5p2EdzVwkCfhungBypcIPKTb/BtAUd9L/ksa4dQgHJKHsxwpj8e4tU
         48FB5AzvEoIb3KH2QbcyOaaJW6pAbpNygyDvz8XrvTI5K241L5LTIleacX+bE+j+RizB
         Bp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707418773; x=1708023573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYaw+GihRftYikU7DfbOWB/C78nj3a8FEHBnrx9ij7U=;
        b=Ml6wv/8BQ8HepWQtzqhmJwvFNuRwtRPaFQ2eTEZrxR//5lIwVU0sbqPAYVqxTjitih
         RWxr14g5pePIB3U4LupnaXSOc319SFyqLeD3w7Uc/GcZyzRSOZHEG+yQN7iogty6l8We
         l50ulW7SWGTEvb87D2mv7RFOAtJB/iLud7B91OaBm96aKCcv5Si2ygB6TpvAacdG3TWS
         PLkaGZm5cyy9GGODxvSiDPzsf+it1q8KWMYyAPWLRwwt6e9ztlE7nQEp7+n7rrKovxTQ
         aEXe5avKJnlKN1w/ZJRLtVePlBevCwabhInzYtqOztO6tuE1yeD4LmJ7EsVH4tJqDrtK
         RnuA==
X-Gm-Message-State: AOJu0YwFNxu4/HfDRRU2mBUo1V30puKj7peEFDoHNMCAxfspTHel/Ycp
	DPrkpsDVlrWwipkusdHuUuFSFI3n/uhKd45UpDVJRTZAsdgFyDoWYAGdJntZbQQjCRmFDa/UV9t
	YhUK4eCwsjNv1hmsCjZD+HAekIcvyJ2t+KtDu
X-Google-Smtp-Source: AGHT+IFTwdSwfGYFj/VgADwqwvcCIqKE1CYVed0IKqT7KajXxjer4g8JkZ5gqBkz6LfIjIKi1PRFJyKSgxkBBTZHAiA=
X-Received: by 2002:a17:902:f98e:b0:1d8:eac9:bbfc with SMTP id
 ky14-20020a170902f98e00b001d8eac9bbfcmr13038plb.15.1707418772905; Thu, 08 Feb
 2024 10:59:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208181025.1329645-1-namhyung@kernel.org>
In-Reply-To: <20240208181025.1329645-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Feb 2024 10:59:21 -0800
Message-ID: <CAP-5=fWj+zMX9NRge5i=CF4945Tbv81oEqU2o87MWYuxqSMP5w@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Remove misleading comments on map functions
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 10:10=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> When it converts sample IP to or from objdump-capable one, there's a
> comment saying that kernel modules have DSO_SPACE__USER.  But commit
> 02213cec64bb ("perf maps: Mark module DSOs with kernel type") changed
> it and makes the comment confusing.  Let's get rid of it.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/map.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index cf5a15db3a1f..14a5ea70d81e 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -553,10 +553,6 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
>         if (dso->rel)
>                 return rip - map__pgoff(map);
>
> -       /*
> -        * kernel modules also have DSO_TYPE_USER in dso->kernel,
> -        * but all kernel modules are ET_REL, so won't get here.
> -        */
>         if (dso->kernel =3D=3D DSO_SPACE__USER)
>                 return rip + dso->text_offset;
>
> @@ -585,10 +581,6 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
>         if (dso->rel)
>                 return map__unmap_ip(map, ip + map__pgoff(map));
>
> -       /*
> -        * kernel modules also have DSO_TYPE_USER in dso->kernel,
> -        * but all kernel modules are ET_REL, so won't get here.
> -        */
>         if (dso->kernel =3D=3D DSO_SPACE__USER)
>                 return map__unmap_ip(map, ip - dso->text_offset);
>
> --
> 2.43.0.687.g38aa6559b0-goog
>
