Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63514A4D7
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Apr 2024 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056620; cv=none; b=r1r3ChklxBXdMf4Yp6ioyI6NEO80VDssnneIaVSDJO/l6P3vj6R0cKCG3PPjcDVC1QBcB9E/xkP55hquqYasUl+6opTpTBnmoA82cn6w0H+K91lYmcv5SUCUlG416iQt866WUxltke+JZ73sFBoFyGlSUxwRY/ZuGvQYEp6lqFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056620; c=relaxed/simple;
	bh=Ycf9a2j2RJtUdhdofXQYYbRhrCc3ymXuWyYAmriuaf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmPMKUAEyx4f4/rD221n5U6LQLR/SV3ABjpv2cjVYUGtUxkA6sKfkmJPptzUagV1VTcM9DwsfDwhqgI7qXWpiYs86XMpgt0XOnCPQuI/kdxA6iJkZU58GCDgrv4tq7yHvm8UrcmzUbgXQpy6pj7n1r98pgBidertW4hiNlA5xvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKQ3HHDh; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKQ3HHDh"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36b34effb04so112325ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Apr 2024 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714056618; x=1714661418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2s/tnVUk7RhbjTUQ58lGklT1XmTBfjSiMBuxZZqOek=;
        b=SKQ3HHDhXgXx/cOsc8X5IV9OnKEaftdAsl2Em2tjq7lRhM75s7DGK4vT2MmVlUPXzq
         y1+sif2QKUTZWRor9CN8N0rTyki9XuJSVa//5zvEWSVE/gnfP/KQRFIyt6isM6+h5P0V
         6KzJDw9LkXLhApS/yyqR1MYXJIobbOiNBnOcgVwhqd/yuyA8njieP1cgWs0J3C9ysO79
         jLffgQvhA4elpWZpfTn7c+E24aKndshHHzcL565QAez6Du/qhfzNjnF1w/ZtSas1Y/yh
         7C+jEy+3e9bsXnbDBMXaaeKv0nHVIAiFVAKVsj6GNQz9DIYd1XSabl7kzkG5tyKHrrSg
         ccsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714056618; x=1714661418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2s/tnVUk7RhbjTUQ58lGklT1XmTBfjSiMBuxZZqOek=;
        b=Ti2usT2Cf+8NLK10vxzKK6gFgOJgekN6I+GOpgCVO5QMlhCOv4sNGYhvtqaKZyUevX
         zGwl7nxPENYKA+QBGHvYL+1AoCe7VCFvcZZ7Y37T9ZPH5Mfa/uOR77scmlLMNsATCzrK
         sMWMA4CnVprI4ah6iY0mf8L/lLWJ8l3tPkEDXD/eVCcsBPbW+rmt2dwhx0sZ46mdCOW6
         2oI3XXgdZJwvZ4IS6sUgJEp1GagV7rZg99FXA17NYtZWz4aIKZEKXUXgWXWkg1Ij4Ta3
         8Hoarh8xXL2BY+N0XNLvYOrC22W1XTXRU4wVxEPzO9yOruVPkl3yBjQrZPwMJMBOjNU9
         EJNA==
X-Forwarded-Encrypted: i=1; AJvYcCWXEO5CLHGIB3+BUjeiB1QmCGBG9bIhppX4ot8rdYkU3+bw/Lac459rVFhXzAq4IupcbgmAcavtNoOsgmuobEQAjJ4hdsFAYZtEQq8Bh3Pn/Q==
X-Gm-Message-State: AOJu0Yw6Kwq36UZjPO9+Okt7OU0w9kO2IeQmYzDdfAuP6trMuTPXCr2v
	Zu7zS92OZRjqSso/ZeB1S9Icr7QKyuRQ9YM6Y4mDsDXfiNks+UnSTgkfr7TNVEYKCbObLabcG7p
	dljCDgJHNmrimuIt1WtGvszXWJlya1O8TO+gr
X-Google-Smtp-Source: AGHT+IESDwd5zTDdz3/OORzEa4baR+AKJ83B5+ExBjdkF7TvDtkTAUrbIq+YmuQhoPaCa2kRSfxH2ljrrvc3VfKKgkA=
X-Received: by 2002:a92:da4a:0:b0:36b:f9c1:7ae3 with SMTP id
 p10-20020a92da4a000000b0036bf9c17ae3mr188764ilq.19.1714056617895; Thu, 25 Apr
 2024 07:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425005157.1104789-1-namhyung@kernel.org> <20240425005157.1104789-2-namhyung@kernel.org>
 <Zipk0p08bxO7werD@x1>
In-Reply-To: <Zipk0p08bxO7werD@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Apr 2024 07:50:03 -0700
Message-ID: <CAP-5=fXbJsdioDLjKMM3d=WJ_VGLtfygL8f6G+bfpDmK7_CPeQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf annotate: Update dso binary type when try build-id
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 7:12=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Apr 24, 2024 at 05:51:57PM -0700, Namhyung Kim wrote:
> > dso__disassemble_filename() tries to get the filename for objdump (or
> > capstone) using build-id.  But I found sometimes it didn't disassemble
> > some functions.  It turned out that those functions belong to a dso
> > which has no binary type set.  It seems it sets the binary type for som=
e
> > special files only - like kernel (kallsyms or kcore) or BPF images.  An=
d
> > there's a logic to skip dso with DSO_BINARY_TYPE__NOT_FOUND.
> >
> > As it's checked the build-id cache linke, it should set the binary type
> > as DSO_BINARY_TYPE__BUILD_ID_CACHE.
> >
> > Fixes: 873a83731f1c ("perf annotate: Skip DSOs not found")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/disasm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > index 412101f2cf2a..6d1125e687b7 100644
> > --- a/tools/perf/util/disasm.c
> > +++ b/tools/perf/util/disasm.c
> > @@ -1156,6 +1156,8 @@ static int dso__disassemble_filename(struct dso *=
dso, char *filename, size_t fil
> >                       }
> >               }
> >               mutex_unlock(&dso->lock);
> > +     } else if (dso->binary_type =3D=3D DSO_BINARY_TYPE__NOT_FOUND) {
> > +             dso->binary_type =3D DSO_BINARY_TYPE__BUILD_ID_CACHE;
> >       }
> >
> >       free(build_id_path);
>
> Fixed up to take into account a recent patch by Ian that turned that
> &dso->lock into dso__lock(dso):
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 70650808e2e7bf88..2921b32357705a02 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1156,6 +1156,8 @@ static int dso__disassemble_filename(struct dso *ds=
o, char *filename, size_t fil
>                         }
>                 }
>                 mutex_unlock(dso__lock(dso));
> +       } else if (dso->binary_type =3D=3D DSO_BINARY_TYPE__NOT_FOUND) {

With reference count checking on dsos, this will need to be:

dso__binary_type(dso)

too.

Thanks,
Ian

> +               dso->binary_type =3D DSO_BINARY_TYPE__BUILD_ID_CACHE;
>         }
>
>         free(build_id_path);
