Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0524CA281
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097982; cv=pass; b=tQhxOH15Z/QgESIQxfqTnVLlqqEDLrS+W1iraun/54aGystktkvzH30dn+yl6008wW9P9a2P5+Sj8swxKb0BCLNDg7oKbAN4IgIbA8dmU3+gT5sSfPrn/peeBlzMYw7wacZgxrq3h98QRnt016l2KJ3aKePhBI9dYcDc4MThcs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097982; c=relaxed/simple;
	bh=OC5tzLx0gvwMJXQ3DCnZrdeB3ov6NGEPUNw7jgsZanA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipgkqwiIrtCIO/pvSLyeRGhg/bfTWSokJcS6NmwMt2Id8mJrB2WOV/FefLKav7oscIq29v/agborRmV/eTiK/uHS6dOYVKvXNFg47fdQgSsVub10hcjwjW2cbtqX9y5rIEz22Ahwq7DAtV6y0s3tXNu2SSSrkSoYAFlMhNU86Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YG8nbSom; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YG8nbSom"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a35ae38bdfso77655ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 08:06:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769097971; cv=none;
        d=google.com; s=arc-20240605;
        b=KHQ1BY3WWBvuBIaV3nL/o7IM0g0rdAbpXp6BQiF1guSZEqE59AF78VIJLHUk5KaTX+
         MSmnI7feio3OihGr6K2KxH+0Uj7zIHMZQvCwRWqpDPjxFxX70UF6w35ulmUOq9ta5CQw
         BDjKs6hpJYwC4IelEvj1bIrL/Q3icrN4RX3YU0gZptvwFbVEH9YEfKkzQvu/0NcKeXDJ
         +HcdtCEZo7R9UeDV/TezffMDmO3dZv6kdLrs1p5zw1e5kRabojZDHsP/6kiwQc2JfJTX
         +Xb9URnbO6z3hG6U5jSb6QUZo+I/C655BEozoU/zBoVyowIHCPoDEDSL1g9GB6TH6s8o
         BMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z+AIbIK3eQTohbEi9mUjrpLQdvDbJl+5v84GWpefTnM=;
        fh=nE3va2ole4J8nWUZ4HSqCraxWEUnM8HF7g13Nl3S9f4=;
        b=SkKZrSzDz+xTly6EdslX40HfO8nm6uozWm0HhBKg65QM3mCjfTSIOmy1dOtWKuQcJA
         Sg5EPy0gkcmwnVRne0Km7vN6uAYXYshLBwvaNe1m1r1qIEE3FeH2LHJCyHR8ratKiBr6
         NMQUhE23WQBnRcBhPaGIVmQCc2e0CjhJPmMvSJvqJLTI14p00P+9VvVSUFWcaLiIfrUd
         eUCzdV3oCyuxbqt1kSrHNo9q3yq9Nk90Ufox/XtGzOHS3ZSfpL/PWCo6g45wbLgAvAVv
         ItNAwsoscKdsKPwyDneXBar0FtsV2ud1+tsdO3qI8n3i31QlJP6M98s5gmUlY/673dFC
         Ooqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769097971; x=1769702771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+AIbIK3eQTohbEi9mUjrpLQdvDbJl+5v84GWpefTnM=;
        b=YG8nbSomamH35BA+H5v3Eeaq+bSfQc+j08WhKtNjyig+q28O0H4GyvGWxYQFLpVG2g
         T2wacGSS10z4xbBU+y3l+eDRNGSoXAwi7LA9HY+roksmf8u9Yvq4c0RqXToeGxqX7rUa
         /jgLjE5WvV54/QdwYLv6fTvSwYVl29Gew3eXLK6lj/GyuW9EO2pFwj2dM7MrqTEjM5pk
         fraOD7a1cZDRQEh/oahlOrRTbyh/zpjwbCb5i2tNVEoiel0qvU/Ei/nRNZDNOwcKOrB7
         RpIokD5ig03EsHVOz6IK0oVt5qXCpLznN6L0OVGk3eIph4GZjuwbhXR3gD4lUxoXFTUD
         Ok7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097971; x=1769702771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+AIbIK3eQTohbEi9mUjrpLQdvDbJl+5v84GWpefTnM=;
        b=poNr81fUatRuUrRKvAVJoxF84uSFhd3B2oC8g1Z9rke3YUepmJkFNFyLuDHzlWJHqf
         rTVqjayGRTcY8iK2Oe4XEDJBXFeL0QrVpbeyxXsUi4vcv9UAxO//O8ha/JPdvUlhcYOI
         jxcy5gzCSsMHlOpUg3fVJvTxTnJiwrZIN51w6bkKb/JC5tNBtFy7BJN6ol8h6br3+0w6
         4QsZcIQcFuwhkcAOP1S25XiThqNnHDNwTToJxFOGQ3RUg0+D4OFQc7fk0P2BNl8Q7cN+
         H+0oTX5/WXBA+qrj2dwsOVashozkRyvzfIoytVzyKVr7MbYkpngKkqz8TLRF0GKaPDzo
         dm2w==
X-Forwarded-Encrypted: i=1; AJvYcCVOD2IKqxpmLxShCudTUS7TDUh5X7YfLubR0SAKlXneM2aWuCZWT54a1heiyO6MWlK0NVnvn7Wk3iqeTFwNtz25@vger.kernel.org
X-Gm-Message-State: AOJu0YwPxR5YWjc6psjwMOKSLoiu1O6WLTYPCTCWqP00yUBbalyewFHL
	JbfMl8X2AoECtmXVGHtdzsZvc3Irye3Eb5TMwsl0vCfy91rN9dsJvLGIu8HkpncY20cnKDdsoqb
	AgLloWRP6zmV5MoB+ymn4dKxRoQOmcZgZOW6oID5K
X-Gm-Gg: AZuq6aIBdjCsBCmaEGlwK0WX3LROloYJMSVVZJDuy28+F6Ie4BSZMlB0h4gRIBIvFk7
	h87ug9h9Uj5LaXJ+UE5OLSIscLxqeRi65rPixPDQwT2ljwyOBDj9duFX7hCiJUB0rBf7UO8GTGo
	ctSj78oYGeo9D/GsFUNN0aHcRycmsBHuuS9mHNJKH6p44/WrokDJt3JsOc6jwg42+g8cQwFnnIJ
	TuYPA6+apj5YKZwtmRJKEHafX9Kynxd1dkATec7mjumYuew+O2ik025ht0+zXOwblrBlz3Hf13Y
	jrz5Raobj0RWsybKWFwWy1RB1A==
X-Received: by 2002:a17:903:2b06:b0:29f:2563:7772 with SMTP id
 d9443c01a7336-2a7d417846bmr3095405ad.8.1769097970607; Thu, 22 Jan 2026
 08:06:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122073127.375139-1-irogers@google.com> <20260122073127.375139-3-irogers@google.com>
 <CAO9wTFh01Qzn9tAiXf8_eGd7AAJiKzjmHNw-hBBCzcYR9Mb8xg@mail.gmail.com>
In-Reply-To: <CAO9wTFh01Qzn9tAiXf8_eGd7AAJiKzjmHNw-hBBCzcYR9Mb8xg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Jan 2026 08:05:58 -0800
X-Gm-Features: AZwV_QheLkTE1KRcO3TYQKQs82VaNUxHiDT9G3Jcm0FUvq93zpwYWIu1qRjGJAw
Message-ID: <CAP-5=fUg=Gna1=HyugczBijYE07SnFHOO9OPutYQa+s8QcXBmw@mail.gmail.com>
Subject: Re: [PATCH v1 02/11] perf annotate: Fix args leak of map_symbol
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Guo Ren <guoren@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Zecheng Li <zecheng@google.com>, Tianyou Li <tianyou.li@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 3:47=E2=80=AFAM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> > @@ -1119,7 +1121,7 @@ static int symbol__parse_objdump_line(struct symb=
ol *sym,
> >                                       struct annotate_args *args,
> >                                       char *parsed_line, int *line_nr, =
char **fileloc)
> >  {
> > -       struct map *map =3D args->ms.map;
> > +       struct map *map =3D args->ms->map;
> >         struct annotation *notes =3D symbol__annotation(sym);
> >         struct disasm_line *dl;
> >         char *tmp;
> > @@ -1151,7 +1153,7 @@ static int symbol__parse_objdump_line(struct symb=
ol *sym,
> >         args->line    =3D parsed_line;
> >         args->line_nr =3D *line_nr;
> >         args->fileloc =3D *fileloc;
> > -       args->ms.sym  =3D sym;
> > +       args->ms->sym  =3D sym;
> >
> >         dl =3D disasm_line__new(args);
> >         (*line_nr)++;
> > @@ -1172,7 +1174,7 @@ static int symbol__parse_objdump_line(struct symb=
ol *sym,
> >                         .ms =3D { .map =3D map, },
> >                 };
> >
> > -               if (!maps__find_ams(args->ms.maps, &target) &&
> > +               if (!maps__find_ams(args->ms->maps, &target) &&
> >                     target.ms.sym->start =3D=3D target.al_addr)
> >                         dl->ops.target.sym =3D target.ms.sym;
> >         }
>
> Hi, a noob here so please correct me if I'm wrong.
> Looking at symbol__parse_objdump_line(), shouldn't we be calling
> map__get() when initializing the target struct? Since maps__find_ams()
> now calls map__put() (after patch 1).
> struct addr_map_symbol target =3D {
>     .addr =3D dl->ops.target.addr,
>     .ms =3D { .map =3D map__get(map), },
> };
> This would match the pattern used in call__parse() and jump__parse()
> that were fixed in patch 2.

Agreed this is another problem. I'll add the missing put and
addr_map_symbol__exit missing here.

Thanks,
Ian
