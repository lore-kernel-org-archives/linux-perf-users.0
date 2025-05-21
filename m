Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53F2D600
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842348; cv=none; b=FQdoY6W6DgoTeLfCG9rFFPC1cnUp2tzaj27DvNfg3QhZzdO+uZMKeV39hgKpzwS93D1F69ww9HfPFjaaVdV8bjGxibVIHbSp0JesHXp48ZhrQkWnNeNPwYLnwZZpz5ukYuxVpnVIwxgxUH7OrvDW+9DdwpvjVqimBLs6OM/ofHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842348; c=relaxed/simple;
	bh=dNBh7LY7EHy/dovAdNpFvXF7isUaItVzDkMEkkQ7uD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CREfwb9u8jywCBOxxfYET7CkJkzkLUR+Vs5faqfEh9dIBYMlWjUPWWiKSEdNcmDte9nohHG/XOTV8BLoNRC8SlDehO+ZjkrSUoJWuvaFH6uVtaczrRZgjzLMiVKmcNHG2xg6ZHpzd44HVDz1qhJ6ZeG6pzZwI2uV8K7vDN0+b70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jEK2HfSv; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jEK2HfSv"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso96535ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747842346; x=1748447146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8uzxrSyLMPXgPC5EdFwjFvRKftp4g9crlr7xPugRkA=;
        b=jEK2HfSv2lO6YDUqN0zbAAI4QgxPVKEWJFsoPBO37mhHOoFzIaaoTr1VcHSWk6tH/0
         OxjFzxI5CSvgcu7kvuBKGSdPFwp6+hOeCZNLxIrpD2cNyudpGfTqHQQYnU80f/np6ooT
         mUyLvAYETeu7mKAQ0HjVGwbNVVLgIsvLXP7Aw2jqSQz1BzY1yUzk9AIKJvB26L9NQBcb
         fo1PqnLdTsBEnKrabsJvvZDEe6cfWzWokjdP3lVH26mAUkkUkOfgobQ3090fhJcNfI+H
         8ltxcFMXwsbtd4AnuVJa2P6rtDkyolXoeeGmMdMoAq/pOgC7x834/9th4pP2Cb07elLP
         dvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747842346; x=1748447146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8uzxrSyLMPXgPC5EdFwjFvRKftp4g9crlr7xPugRkA=;
        b=hdYbh9q1zAumzsVZF5YxordWlk1pb4jILgWoSjShNq9Q1WhhvGAX9LlDz7CrF3joAt
         FHiHpFuACZ7OwGyRhMGtHOsdjYsR8IxE0WIeBixlKRhbcVaRQHstuXJuDuUHjasL/Ze/
         zxWfOu7pDGyzQIhVFDF+899lgCPeKYLfJkYbOYUwHj5021aDs05DxDR6VOdmFHppeS/1
         be/3GaVLOcHGWxmQDTOwflFeCrDWoWlcG4o998awcDqMEtgVTTF/Rb66MpEPTLDkA1oH
         rKNo+/eaYDuBLKoXDMLR3DdtJB4eNdQo2P7i1zV+T3FR5wlUplKcThTVQV5VtXks0aTz
         ylKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvkUp2Hx7sTgHCcesqO5fDzwdd6uJGuv7TaGSnv8FpIXb33LzyyD1MAS8COYgyfvNEWWN0p7dtnalUHjOK5PWq@vger.kernel.org
X-Gm-Message-State: AOJu0YzdszBzp5bPau06JFeeqWZOLhihCcKD4tLFPSf0OgqWCqsr6XgI
	2PN+MnR++qZ7eR2cPt+W3ikNshD6XAtqzj0FSD5xZ7G7c1ddyciRsAdK/2s2rArkyKWfjLgMIx4
	WjKMcUHCTFJlBYxOb4lR7f65Us78UYN8NYN1dMGel
X-Gm-Gg: ASbGncvDqYBqg2tDNSeclEU12bzI57dI78p/jsG9Vt+ORWdo7WIaYgLMcm8OpacfgX+
	s07uCXjwodAf/rbCIwZdo6NiUxcD/qrKq2GfPbJIUt5FBujV9HmHz/zKX8DG0wWv3eu4eVhKaTE
	VAbMr4js5U6OBrMzMe48SfdnBp0T0fzf2wvy1c0GVA+n78Ess29vNzOxyIQ6xXeP35L9fIgwK+
X-Google-Smtp-Source: AGHT+IEQbr4EE2e3RyaoVM71bg+PWANkmopwgCjTCxeDF9dNu+YPkvBQIC6TX+vXRXLQ010sFAlDmGllPecJL+6XkCo=
X-Received: by 2002:a05:6e02:1a42:b0:3d9:6cb3:d6d2 with SMTP id
 e9e14a558f8ab-3dc5d591e3cmr15852845ab.4.1747842345674; Wed, 21 May 2025
 08:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250406163412.897313-1-likhitha@linux.ibm.com>
 <E58C5DCA-5F52-4B61-A816-DE932BA40FDA@linux.ibm.com> <baad9d65-07b1-4a19-aea6-5ba5d60da98e@linux.ibm.com>
 <1b1450a8-f091-4091-981d-76b27f61be24@linux.ibm.com> <D1C1E5D6-085A-41D1-85AB-52809C956BFB@linux.ibm.com>
 <aAvKg8K2fyrZ6zy4@x1> <wqewmdha3bx7pmxqwbna26qnl55fcejqsjs4b2zhuciddpb3b5@7ztolpf6erwo>
 <aCO156Qh5mbeR4Sk@x1> <528d4af0-8e8f-4ab8-a1d0-d0bb937e4f53@linux.ibm.com>
In-Reply-To: <528d4af0-8e8f-4ab8-a1d0-d0bb937e4f53@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 May 2025 08:45:34 -0700
X-Gm-Features: AX0GCFvZnY5uly84PfYT69clmTRe8UCoTQ_6UjSd2lfiXv1AzDxWlII_-VQPTqU
Message-ID: <CAP-5=fXT0edO0pjO0Ks8vGHgO=iwfuu+Bs5pfccZQhwfSo9mgw@mail.gmail.com>
Subject: Re: [PATCH] tools/lib/perf: Fix -Werror=alloc-size-larger-than in cpumap.c
To: Likhitha Korrapati <likhitha@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 6:03=E2=80=AFAM Likhitha Korrapati
<likhitha@linux.ibm.com> wrote:
>
> Hi Arnaldo,
>
> On 5/14/25 02:43, Arnaldo Carvalho de Melo wrote:
> > On Fri, May 02, 2025 at 01:14:32PM +0530, Mukesh Kumar Chaurasiya wrote=
:
> >> On Fri, Apr 25, 2025 at 02:46:43PM -0300, Arnaldo Carvalho de Melo wro=
te:
> >>> Maybe that max() call in perf_cpu_map__intersect() somehow makes the
> >>> compiler happy.
> >
> >>> And in perf_cpu_map__alloc() all calls seems to validate it.
> >
> >>> Like:
> >
> >>> +++ b/tools/lib/perf/cpumap.c
> >>> @@ -411,7 +411,7 @@ int perf_cpu_map__merge(struct perf_cpu_map **ori=
g, struct perf_cpu_map *other)
> >>>          }
> >>>
> >>>          tmp_len =3D __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(o=
ther);
> >>> -       tmp_cpus =3D malloc(tmp_len * sizeof(struct perf_cpu));
> >>> +       tmp_cpus =3D calloc(tmp_len, sizeof(struct perf_cpu));
> >>>          if (!tmp_cpus)
> >>>                  return -ENOMEM;
> >
> >>> =E2=AC=A2 [acme@toolbx perf-tools-next]$
> >
> >>> And better, do the max size that the compiler is trying to help us
> >>> catch?
> >
> >> Isn't it better to use perf_cpu_map__nr. That should fix this problem.
> >
> > Maybe, have you tried it?
>
> I have tried this method and it works.
>
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -410,7 +410,7 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig,
> struct perf_cpu_map *other)
>                  return 0;
>          }
>
> -       tmp_len =3D max(__perf_cpu_map__nr(*orig), __perf_cpu_map__nr(oth=
er));
> +       tmp_len =3D perf_cpu_map__nr(*orig) +  perf_cpu_map__nr(other);
>          tmp_cpus =3D malloc(tmp_len * sizeof(struct perf_cpu));
>          if (!tmp_cpus)
>                  return -ENOMEM;
>
> I will send a V2 with this change if this looks good.

How is this different from the existing code:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/lib/perf/cpumap.c?h=3Dperf-tools-next#n423
```
        tmp_len =3D __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(other);
        tmp_cpus =3D malloc(tmp_len * sizeof(struct perf_cpu));
        if (!tmp_cpus)
                return -ENOMEM;
```

Thanks,
Ian

> Thanks
> Likhitha.
>
> >
> >> One question I have, in perf_cpu_map__nr, the function is returning
> >> 1 in case *cpus is NULL. Is it ok to do that? wouldn't it cause proble=
ms?
> >
> > Indeed this better be documented, as by just looking at:
> >
> > int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
> > {
> >          return cpus ? __perf_cpu_map__nr(cpus) : 1;
> > }
> >
> > It really doesn't make much sense to say that a NULL map has one entry.
> >
> > But the next functions are:
> >
> > bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *m=
ap)
> > {
> >          return map ? __perf_cpu_map__cpu(map, 0).cpu =3D=3D -1 : true;
> > }
> >
> > bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *ma=
p)
> > {
> >          if (!map)
> >                  return true;
> >
> >          return __perf_cpu_map__nr(map) =3D=3D 1 && __perf_cpu_map__cpu=
(map, 0).cpu =3D=3D -1;
> > }
> >
> > bool perf_cpu_map__is_empty(const struct perf_cpu_map *map)
> > {
> >          return map =3D=3D NULL;
> > }
> >
> > So it seems that a NULL cpu map means "any/all CPU) and a map with just
> > one entry would have as its content "-1" that would mean "any/all CPU".
> >
> > Ian did work on trying to simplify/clarify this, so maybe he can chime
> > in :-)
> >
> > - Arnaldo
>
