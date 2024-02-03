Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186CA3D62
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Feb 2024 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706924529; cv=none; b=gvy9OzDbpciVVMws7K6HW1IJBcIEI9Lt9uX9J9Bsc1AJfHynl+dW3blVCi7h9MVdOz5vSR5/u0jTvYh+ierl0L1awN4dCaCCXUkan8IjjC2ybwrJxKvAKDXWlLAED7YMTLS1tmOOBCJnP2JuJH5IR48bFWA4IsjdPDsmYcbupQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706924529; c=relaxed/simple;
	bh=GL/NWsRNvwetg0ZgKm/CnIK8EZZYE3j8znwpXi+d+6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nt2ODNB0Z57h70uupBF/jCC79TttMUeg56kPWLB6y6H6ZU+FAfdsblZSsE7yg2RkxlKdlSx0iqwq9lcjngS0ChswHEOT9y8CbnV/cHdGHKVDL3BICnIVZ4A/9bmrwG8NpTO6X4/hPPqVKV+o6ai9+tD/p1bQvbdzvUhPkTwMFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/WBXHhD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/WBXHhD"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d89f0ab02bso31035ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Feb 2024 17:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706924527; x=1707529327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1tmXsSnp3camgDs1JiIWN7PNv+Db/yDFJhwZXZV06A=;
        b=D/WBXHhDzyKrowiHj1GMrP31KK5M/OAnZsRTqSjBT438hdoJcLSiMQ8wGVoWjgBEKb
         lCqzFLtXIHtrY/fuIhFYdy+9ledBCKhQMlPPMHMH+TAqoLn6kucLBW7aSNQsKrhLMYt1
         Jv3iFm51hQ73wUqAkAJHa0ny1D7Bpbi6CkwhBeB6MlVKjcfzPtCP1doz/PL5F+iNR7yw
         sK7QmlpUtBRuLPsuGZ4V/avM0VafKTgE+2A3gKy/vcq41XqLN5dCFc+XFh++Ig+R8JFr
         9zI7SgNHzXOi/iFdWHAr+5vI7aVXesPoluqm87X8V8kiqHPznjJ7/SF0Pn0FnbKAWaNy
         TG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706924527; x=1707529327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1tmXsSnp3camgDs1JiIWN7PNv+Db/yDFJhwZXZV06A=;
        b=G3ec7SMJXvNCWQVoonxfVMhhiNQc3zcWOkQmpkoWPG14WBNw/jR5UbYb3ZRaobZ2XF
         T0xQnZCd6TDsfdx7c40qOvbrsY9uHN2m6gXOIuolTmC0vy7u6d2TKiWzDaGA+KBYayLw
         BsdeaTNhZB1vfYPdY4UNK1qhylfkURH4tZLuEwqgZw5OjvGsVnAqw2iHa6Ho9trBdJpI
         MzUCc6xse+UET8TQ3frJKo0kDTH3nreKI89og3/MeGMDIVZLbq1JbdhYCSNah3a9IOqq
         R/LFs5QAAioTZsfr8kmKFp+Tn7J5GXc6D8DScMdD/MHJJ+e9+anbDSdPgPQC4MmRZWJl
         wktQ==
X-Gm-Message-State: AOJu0Yxy+lPUWasShXBhn4y3vPUjAsxQxy04Jc4eOV5/e7C4RBF0yPgn
	xE05NtvUO+LTPznHDfpMy9PFMgAMZx5Yiko7TeUjnDj6HDAmF1P1Rbb5csMZOjMtXA7GHPrYc2I
	ZxxMpnaYzhZGDt2Lwg2NCnJ6aegzQ8/9czZDF
X-Google-Smtp-Source: AGHT+IFvVXrppMHSh7EsMSe+LktgAY1bvnADV80hP2rmsBLFLZkqA4D0C/pdQHOx+A5VfLjdqqxNYj4YHwkYqewRHaI=
X-Received: by 2002:a17:902:b489:b0:1d7:48ef:e239 with SMTP id
 y9-20020a170902b48900b001d748efe239mr72459plr.18.1706924527056; Fri, 02 Feb
 2024 17:42:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-5-namhyung@kernel.org>
In-Reply-To: <20240202220459.527138-5-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Feb 2024 17:41:55 -0800
Message-ID: <CAP-5=fU=P-ib+n+OfqJAbm8gS2RY-W-KcBskoSHkC+aCmXYcXQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] perf map: Add map__objdump_2rip()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Sometimes we want to convert an address in objdump output to
> map-relative address to match with a sample data.  Let's add
> map__objdump_2rip() for that.

Hi Namhyung,

I think the naming can be better here. Aren't the objdump addresses
DSO relative offsets? Is the relative IP relative to the map or the
DSO?

Thanks,
Ian

> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/map.c | 20 ++++++++++++++++++++
>  tools/perf/util/map.h |  3 +++
>  2 files changed, 23 insertions(+)
>
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 54c67cb7ecef..66542864b7b5 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -594,6 +594,26 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
>         return ip + map__reloc(map);
>  }
>
> +u64 map__objdump_2rip(struct map *map, u64 ip)
> +{
> +       const struct dso *dso =3D map__dso(map);
> +
> +       if (!dso->adjust_symbols)
> +               return ip;
> +
> +       if (dso->rel)
> +               return ip + map__pgoff(map);
> +
> +       /*
> +        * kernel modules also have DSO_TYPE_USER in dso->kernel,
> +        * but all kernel modules are ET_REL, so won't get here.
> +        */
> +       if (dso->kernel =3D=3D DSO_SPACE__USER)
> +               return ip - dso->text_offset;
> +
> +       return map__map_ip(map, ip + map__reloc(map));
> +}
> +
>  bool map__contains_symbol(const struct map *map, const struct symbol *sy=
m)
>  {
>         u64 ip =3D map__unmap_ip(map, sym->start);
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 49756716cb13..65e2609fa1b1 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -132,6 +132,9 @@ u64 map__rip_2objdump(struct map *map, u64 rip);
>  /* objdump address -> memory address */
>  u64 map__objdump_2mem(struct map *map, u64 ip);
>
> +/* objdump address -> rip */
> +u64 map__objdump_2rip(struct map *map, u64 ip);
> +
>  struct symbol;
>  struct thread;
>
> --
> 2.43.0.594.gd9cf4e227d-goog
>
