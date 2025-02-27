Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4A276D02
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 23:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698854; cv=none; b=FhcpR3Z7Zrx3jdNsVNzy2ToHctnW5oYUbpERKD+EVZMdpphrgWLJmOh/xrV7BtHq7POIvOecJ6m17aN1jI8COZT885/PhJxMysTyS8z2Zac+XbB9YW5LihtFnZwZ2b8nBZqfvQo91wrOjnDchhgFiXM0gp1X/ZrUSb94jETOxL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698854; c=relaxed/simple;
	bh=jr7u3BOZKKfDw+c3ldhUxg4rmX9o5zJRP/eIM1CU12o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9FiBi/ftuW4WlDrX0vVYyuT7ZHqOFz4EsJ1nh4MGivcURgUqUf2dDXZIlVHpEibnWEIGZ4iOkX7ymkkYb6myN1i/X1mHkHfWU7Z639M3USCkYlS0Ms8/TIz3YG9gQhuei7nW1a/pSovUq81ipXqpQySCLz9o6ZBImAfNmEdb8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nzDn2G5z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nzDn2G5z"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22342c56242so64365ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 15:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740698851; x=1741303651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o03gaGFVjRe6DTPlfJATQ6ihz81VY0PF2OQ9MM08hhc=;
        b=nzDn2G5zxoygIpuy+NU5Pe+VxjEaqhKg0Ei5e2MyuvY8uYQ1SesWlO4cvlZaBGwHMT
         UERJSigiJgxsDt+/1+aZOp62ci/q6ORMH31YP0qxPhxpGxk3pepWIYKTTdiJK4uytpku
         z3JNWYp+fm8V2SmzEcPugK+Ec3uMSLHtq26t4lTGsdA3d7AQgU/TH/ceiWp0mGeaZzYB
         2HGDM7eMXIxdyaXg0FAvuAjO/dIB0g9OJx/89eA0Ol54Be0ikPGpW3BXlPzUpWCf2o4U
         1KR8F/psp1/MsXrtyh9bm1NFuAfl6pIB2JgGq+kgRYkwNkA0dojuyUpx3+SDJ3kvElal
         h0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740698851; x=1741303651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o03gaGFVjRe6DTPlfJATQ6ihz81VY0PF2OQ9MM08hhc=;
        b=ZUJCQJerLEvkWr2irIQMvmcF3QW7T98VxON7iol1UbpyimhnfgGymEQGh8obxpwl29
         fJ6lrWSSpmFg8jfGYFKVXNnwHC+reqkIboOYsPiI+7GzC5DulI8GSPxTDO+gGDHL7msn
         U9N8KnJPAvXMHBv7XTn8lqfT8Eduyx2NK57qOIXf2qdWIUqGZPclIz4l7hn6Ef7gJAj8
         xtMmVZfeEh7Os9KNVcl5yQPqINKIm8f7VYIBDM12wIZTD2r3wMaNzy4VIXUZHFYvHmeE
         MpgCBUicP1VMPIj9aWXjBZtYt8oTDN2yE3UECHl1ZtAKHcpiz3CuYKOHwTr2a6geYip2
         whqA==
X-Forwarded-Encrypted: i=1; AJvYcCUOqBNxP7bYSHyJdYxtf12rFmBnIkZXK/8KSAhAd3XoCepyqA9XM6lDrSkYwEgsOVEI1FJiySepTS4A8Uw8la/t@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52UEYKyVFrW0hOj/pbdyscBdWv997Xx1lwRRX3El7YCcPXENk
	wduF9+gvuU8dJ1v91jed72H2TFBa3XUi0hnm9XAfrg9MfS/XrUNp805LP5Ux9ub7IyKiFJkGlqY
	5N0SNPOMGuc1PsNZpaEsoCtoL1hVNbZ7hpE6C
X-Gm-Gg: ASbGncvGJkc+WIvsHQEMdcwfPkXsp+C/+4oocLY49D120JGoCkgSZ8kQzMacev9iHD9
	izPJIliA0bQLzsGvJwTqQ3UKkDGIPqqoMqSwcNAPjqv++stgIihEbQ1ct3d4hpBLrxIQCxje+p5
	Vekohnc3TNbiizhZ/Dd7thfRp1Ck1omo+abXo=
X-Google-Smtp-Source: AGHT+IGZEKIqRJs0dHjZ0ac8WstQxsDWoFoO+KTsgHSkoiplmefENbkO/0Ml8B8SOtsWigjR7vAlSECbNe463I9aNzY=
X-Received: by 2002:a17:903:278e:b0:215:7152:36e4 with SMTP id
 d9443c01a7336-2236cfcc6f3mr400065ad.27.1740698850828; Thu, 27 Feb 2025
 15:27:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227215455.30514-1-acme@kernel.org> <20250227215455.30514-2-acme@kernel.org>
In-Reply-To: <20250227215455.30514-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Feb 2025 15:27:19 -0800
X-Gm-Features: AQ5f1JpIi5vdH8MS85zSlahfNtAd87BvrmGzOP30gHtNTV0nBIMXx3_MS1ndY0Q
Message-ID: <CAP-5=fUqLyCt4=4XgoCjTkmeO4yrHTvEU1Hw48-+S3Szi20x5g@mail.gmail.com>
Subject: Re: [PATCH 1/6] perf maps: Introduce map__set_kmap() for kernel maps
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 1:55=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> We need to set it in other places than __maps__insert(), so that we can
> have access to the 'struct kmap' from a kernel 'struct map'.
>
> When building perf with 'DEBUG=3D1' we can notice it failing a consistenc=
y
> check done in the check_invariants() function:
>
>   root@number:~# perf record -- perf test -w offcpu
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.040 MB perf.data (23 samples) ]
>   perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <=3D =
map__end(map)' failed.
>   Aborted (core dumped)
>   root@number:~#
>
> The investigation on that was happening bisected to 876e80cf83d10585
> ("perf tools: Fixup end address of modules"), and the following patches
> will plug the problems found, this patch is just legwork on that
> direction.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stephane Eranian <eranian@google.com>
> Link: https://lore.kernel.org/lkml/Z74V0hZXrTLM6VIJ@x1
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/maps.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 09c9cc326c08d435..e21d29f5df01c6f7 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -428,11 +428,29 @@ static unsigned int maps__by_name_index(const struc=
t maps *maps, const struct ma
>         return -1;
>  }
>
> +static void map__set_kmap(struct map *map, struct maps *maps)

I'm not sure this is the right function name. The kmap is created when
the map is created, so perhaps `map__set_kmap_maps(..)` is more
accurate.

Fwiw, kmap is:
```
#define KMAP_NAME_LEN 256

struct kmap {
struct ref_reloc_sym *ref_reloc_sym;
struct maps      *kmaps;
char      name[KMAP_NAME_LEN];
};
```

The name is pretty chunky, perhaps it should be a strdup-ed pointer.
ref_reloc_sym is used in the context of a machine, so perhaps there
should be a hashmap from map to ref_reloc_sym.
The kmaps variable seems to largely be unnecessary, things like
addr_location and map_symbol carry around a map and the associated
maps, so when kmaps is needed it was probably already one of the
arguments to the calling function and could have just been passed
through.
So I think there is a cleanup to:
1) remove kmaps - just pass down an associated maps
2) make ref_reloc_sym and name things looked up from a hashmap
3) get rid of kmap altogether so that invariants don't need to be
maintained and issues like this shouldn't repeat.

Thanks,
Ian

> +{
> +       struct dso *dso;
> +
> +       if (map =3D=3D NULL)
> +               return;
> +
> +       dso =3D map__dso(map);
> +
> +       if (dso && dso__kernel(dso)) {
> +                struct kmap *kmap =3D map__kmap(map);
> +
> +                if (kmap)
> +                        kmap->kmaps =3D maps;
> +                else
> +                        pr_err("Internal error: kernel dso with non kern=
el map\n");
> +        }
> +}
> +
>  static int __maps__insert(struct maps *maps, struct map *new)
>  {
>         struct map **maps_by_address =3D maps__maps_by_address(maps);
>         struct map **maps_by_name =3D maps__maps_by_name(maps);
> -       const struct dso *dso =3D map__dso(new);
>         unsigned int nr_maps =3D maps__nr_maps(maps);
>         unsigned int nr_allocate =3D RC_CHK_ACCESS(maps)->nr_maps_allocat=
ed;
>
> @@ -483,14 +501,9 @@ static int __maps__insert(struct maps *maps, struct =
map *new)
>         }
>         if (map__end(new) < map__start(new))
>                 RC_CHK_ACCESS(maps)->ends_broken =3D true;
> -       if (dso && dso__kernel(dso)) {
> -               struct kmap *kmap =3D map__kmap(new);
>
> -               if (kmap)
> -                       kmap->kmaps =3D maps;
> -               else
> -                       pr_err("Internal error: kernel dso with non kerne=
l map\n");
> -       }
> +       map__set_kmap(new, maps);
> +
>         return 0;
>  }
>
> --
> 2.47.0
>
