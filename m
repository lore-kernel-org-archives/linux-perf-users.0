Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEEC202C52
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747175789; cv=none; b=NkgKW+KqnD783R7XOG0MrNq5dQt4eMpQAvEU2GYWPJh7dK1RqrLInZkG5PzKUm1bkVTtoY8JVPFVNsrzixbuPR7tfk5wrSatF+51uBrdk5CaPKD7VUDwPmbHSadSkgk/m/JNE/mFnN8wBWLTTEaw0dSXVVk2V2ECEXLevSpR2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747175789; c=relaxed/simple;
	bh=dEf/ktSAsPoNJtKy+OtTdeVNK9rPB8+VNytTrnFHKT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSLL9paQRtWHSpxEaroMH+whxqGcFEXFf/TsFd7Zst8tQBvwwOrL9jyaZGQnOXiZ3ivRHXgnsZJdS/zKfreY9Qmj4pnZO5vgKvut76V/QbiC4ThLZleU0zsZxLt7Rh7LErtuuMz8QX73FIi9H20M/8xGEqZrqHc2Kl8RGEiCPFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EkJPhmN1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EkJPhmN1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22e39fbad5fso31465ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747175787; x=1747780587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIo9PdcOwR30863D/j7oWqsw+0Z2QYx4WZEdgsHvWKI=;
        b=EkJPhmN1OGjMmD9Ogv/sz4qDnVVfFAV5W/rHKG5EWuwH1Nz0ZO6IEJMxlOFxz/dseQ
         sp+h6F02PsNeyzag9ctIZR+EwI3Ny8RfDxMxYF5YAOoL2HkW0ea6iYfyCZUp/LaG7GH1
         Y4VyQj+4dqUVR78Mzs9WriCTAUsl2XdW9uczFgzL7rhQ+FHlXVbVqAkR3aXWvNuiN901
         HtMdrxtZO6gFJH5ejWiZiMGNen76Db0/BaUDTGyX4JZBODiMnb5haVRte2WT+AD3Ks76
         7OeJ3vhrbehI3R90OG+vZC9Bm4vp7+VKmL0U7CIC5/VQblDzLTithBLIr9khaXpIQ856
         kqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747175787; x=1747780587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIo9PdcOwR30863D/j7oWqsw+0Z2QYx4WZEdgsHvWKI=;
        b=FlV37XRrD4JNtSkGO7i5/jicATkC/fHVhhOeoI2204jTCh5kkY2JwZW/P5D9XT5Rwl
         uHHXENUWqXgXdnx+KGXtyF7MyZL/rrnD7G8BZJeyQzPuL1IrpEOf1dvs4Ur3o7ZBC2tH
         l0E80BX1zcK8gHFpLvjuzQtSJ36MZQ4e2Xqlmol7G1UEES3zT1zwaZjhS5Az5CS7cMFY
         CXxPAmGY8bpiFUf3MxDiuFRtHDQG1HQIVbDnTnz1oYCvndMrWrkA+8Ce5FMv2b9Pf6tP
         lJh/N3pgO6twbvqZjnxXHdt6WzBj/uIhOfZ1+CxJ6AlT/BMlsgCG2XEJfdt7OX1evvfl
         lBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVhfPrPkZdXRiYA7ZqI3Qb8IFl0SDzHM/UCxfuguiAwWfpCvPmlW8MHUInYvo+J/CtJMmRe8Gf7A5wh8jQruKW@vger.kernel.org
X-Gm-Message-State: AOJu0YxtxUNCW/VxIXlST7f7qKNny94dJSDWWcz8la6HOpyw/RwF4Ay7
	CBV8jiNbqDcVDCYRvDzXHXMGOByRMLRQCykBjTc8EQ9BLLfJTNZCiHGVmSvsn9101pIFs/yLH7y
	ug8+EqaapF3/OjxgP/KbhHonl91Lf1dtyIBko2o3h
X-Gm-Gg: ASbGncs1NMYbUvoGI/Dqgu0hMmgJKjrORW91SoA2HN7veRSN3bS9EZDMsUd45tOJze4
	BdKiFISPMwYBzZl7lO+k2hx/a9fHFoxf+v+4fqOxhMIpZYE9T+qMDFQ9hywu45DdWcEWaLHfFwR
	V1nC099Evwu9JuCTJso9DayOEq5HOnG/0nGInsRQSP42g6ZNbKgvSuVICWmCXewmjlKZvJcvGv
X-Google-Smtp-Source: AGHT+IGHfOzERkGFQ2IraOYVxiXhrNyz9QOA260/X59T6iym5+2x4qPyvdlodRp7VpBhkN6uzzWDH9NdW080lQ/d0i8=
X-Received: by 2002:a17:902:ced1:b0:22e:570f:e25 with SMTP id
 d9443c01a7336-2319ab21226mr415175ad.13.1747175786548; Tue, 13 May 2025
 15:36:26 -0700 (PDT)
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
 <aCO156Qh5mbeR4Sk@x1> <CAP-5=fXtppSZZc=DxDRkdXgVmqFycaSsji-MVOvFK6go9GY=3A@mail.gmail.com>
In-Reply-To: <CAP-5=fXtppSZZc=DxDRkdXgVmqFycaSsji-MVOvFK6go9GY=3A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 May 2025 15:36:14 -0700
X-Gm-Features: AX0GCFt4dhOpUp7215ImS5pQARceS2IuUVa4FcPpMMxjoJNamGBEdhFYnj6tTy0
Message-ID: <CAP-5=fXx3sGH=MHUY-qcQ=Y2X2XB5b20+yz9WoOqgbdrwZkqVA@mail.gmail.com>
Subject: Re: [PATCH] tools/lib/perf: Fix -Werror=alloc-size-larger-than in cpumap.c
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	Likhitha Korrapati <likhitha@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 3:12=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, May 13, 2025 at 2:13=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Fri, May 02, 2025 at 01:14:32PM +0530, Mukesh Kumar Chaurasiya wrote=
:
> > > On Fri, Apr 25, 2025 at 02:46:43PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > Maybe that max() call in perf_cpu_map__intersect() somehow makes th=
e
> > > > compiler happy.
> >
> > > > And in perf_cpu_map__alloc() all calls seems to validate it.
> >
> > > > Like:
> >
> > > > +++ b/tools/lib/perf/cpumap.c
> > > > @@ -411,7 +411,7 @@ int perf_cpu_map__merge(struct perf_cpu_map **o=
rig, struct perf_cpu_map *other)
> > > >         }
> > > >
> > > >         tmp_len =3D __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(=
other);
> > > > -       tmp_cpus =3D malloc(tmp_len * sizeof(struct perf_cpu));
> > > > +       tmp_cpus =3D calloc(tmp_len, sizeof(struct perf_cpu));
> > > >         if (!tmp_cpus)
> > > >                 return -ENOMEM;
> >
> > > > =E2=AC=A2 [acme@toolbx perf-tools-next]$
> >
> > > > And better, do the max size that the compiler is trying to help us
> > > > catch?
> >
> > > Isn't it better to use perf_cpu_map__nr. That should fix this problem=
.
> >
> > Maybe, have you tried it?
> >
> > > One question I have, in perf_cpu_map__nr, the function is returning
> > > 1 in case *cpus is NULL. Is it ok to do that? wouldn't it cause probl=
ems?
> >
> > Indeed this better be documented, as by just looking at:
> >
> > int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
> > {
> >         return cpus ? __perf_cpu_map__nr(cpus) : 1;
> > }
> >
> > It really doesn't make much sense to say that a NULL map has one entry.
> >
> > But the next functions are:
> >
> > bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *m=
ap)
> > {
> >         return map ? __perf_cpu_map__cpu(map, 0).cpu =3D=3D -1 : true;
> > }
> >
> > bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *ma=
p)
> > {
> >         if (!map)
> >                 return true;
> >
> >         return __perf_cpu_map__nr(map) =3D=3D 1 && __perf_cpu_map__cpu(=
map, 0).cpu =3D=3D -1;
> > }
> >
> > bool perf_cpu_map__is_empty(const struct perf_cpu_map *map)
> > {
> >         return map =3D=3D NULL;
> > }
> >
> > So it seems that a NULL cpu map means "any/all CPU) and a map with just
> > one entry would have as its content "-1" that would mean "any/all CPU".
> >
> > Ian did work on trying to simplify/clarify this, so maybe he can chime
> > in :-)
>
> So I've tried to improve the naming but not vary the implementation
> greatly - initially I was in the code fixing reference count checking
> issues. There is an important distinction between "all" meaning a
> range of CPUs like 0-15 on a 16 core/hyperthread system, and "any"
> meaning the special "-1" value. It is possible to have a perf_cpu_map
> to both be "all" and "any", iterating an empty perf_cpu_map has
> strangely also meant the "any" and so the code isn't specific but
> relies on these odd properties.

I just remembered, there was also a discussion with Adrian IIRC. I
wanted "all" to mean all possible CPUs on a system, and "online" to be
either the same or a subset of that, in case CPUs were offline. There
was a different view that the distinction between "all" and "online"
wasn't useful. So there is some confusion in the code in this regard
and some errors may exist when CPU cores are offline. There's
definitely work to make the API better.

Thanks,
Ian

> Anyway, I'm not sure on the implication of this with
> malloc/calloc/unsigned... It would seem reasonable to me for
> __perf_cpu_map__nr to return an unsigned number and to propagate that
> to fix the new GCC issue.
>
> Thanks,
> Ian
>
>
> > - Arnaldo
