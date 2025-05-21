Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48CC18BBB9
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849155; cv=none; b=t2ttPpP9NUHxV9GAMCKnI+9OOX+ruJVbp/9hlcA8BGG29dGdVJEMqlzWi74nkwbYwpFQ0rQBpnKPdnvg7HBNQqNixmXRSPGcZxeAkmf5SRIhpkmbV2NS/balfor5ADD9xRjdAxcZPLROWow+yvLY06stxK0SClaSzBO0BqXGaz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849155; c=relaxed/simple;
	bh=xxdv/sOBKLxWyKENi19fsAunir3Rg819HaALHiYzrB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeLtIRElF4QD1OhSyvzMWpyWZVrWDDn2rSfbFgIfFZ007CtilwoZI+rJXzbVm7GmU/tXGm2HsO74yrB7L4qJrYoUE9IK/q9OT9Pq3BXNTdXBnrrZcrAHW0TkhsK0DmFejlH4Cx32LN3IzBSm4gLejSa6XllfWGWNeBADi0xOTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZ2kgTF5; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZ2kgTF5"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so938065ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 10:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747849153; x=1748453953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqVVTcgANAyNaY0Ppr50pnoF48ZHi7cLyBFt3UHbis0=;
        b=RZ2kgTF5hKJEftrCZeWjiMosB7CLLGNvgJ1vW+0vaVV9coUfSETuPMRoq71m4tjWKh
         9/gMHuHwy8o9IGXv/Fs1onWCM675lIKSCUmDSHuk0JAZNobQ1/xmQ7o5BzfAxYNd9g3a
         naR9FvAVxxKpuGqnCpUx3OSYARC6uBxSmtfwX0rCDJHQWbBnmjr/JwW59Ji6WeqgbdoD
         AE05EMTzbYdtYOTh1zGrTSHXLOllg/Pzc9BFNz9A7/HtYh5suORV3oiOVbjetAAyNNeB
         vzuVsXlbMJUS5pbAVeCe/7nLRz4h9TAo+mFyxpiLAyOoHDlwaihyonOyoxrdS25KsPZ1
         PIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747849153; x=1748453953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqVVTcgANAyNaY0Ppr50pnoF48ZHi7cLyBFt3UHbis0=;
        b=AKE4trW6s2vNYIakMknq+PAceuZjU7noXGtijtlnZncZ5uM2osFzRDJJ5+wSL1rV0A
         8cKUY30sHy5//9Dxxus4BqNjgC5rmc9YWWogdu0gysuGNyLzur547iTk76tuE0X2Ldyi
         IOFesmeKFYdkHiJZgNOUgWZEFWmFkuvtl0SiAhgpgnrzaPeK7mxuL3R681sXg0UE1VD6
         jn+3a7NJeeXasUel8PCRnzxgWvrSCfI66/L/8i85Nopps0bUBdBwe7ZKYBCIUxZ50ICf
         Wie/nwFSWoHYaOtngdkYZF1H+hjdvBW5/xQn7VvNeVRnIJEmxjbfe/MK/AH0LIQu/dOK
         OSJw==
X-Forwarded-Encrypted: i=1; AJvYcCWr4T9oFoefjZ705zLjxwyXZvxCdbpeJ7ApNVVOuoeWYKRzXIS/OziTgUcJcL1mOTC5+n7hU1eM9bH9wj2d7+Il@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqzed1nKclgJK3rc8mprie9S0A4rTnVeypY4LF0Z7wrumVL3h7
	sDOutbAZYcWS4JsFZEHVWBR3eIhVxZqZ9sECcpsENX2+Uu9KRit8Tu9ObywEnlccnKIyH2Y0lKT
	0KKYTmwkt6jusxyS6k+J5a4n9x6Ymip+QLdAgZkib
X-Gm-Gg: ASbGncvqhmcoXDc5Y2P3iWCAQsaDST+JwTWPI/pcY1Nf/0zQp+adDUv3cTPRoWqUdmh
	lJbkbJo89Suq98FzcXvXDtoYLfTSvljHJY4ViDOhZpHvbeCB0EGxjQfm/tGbROb71lyKwO6vNiN
	KCV9Rrx0cJYJPhAGr5Q/SkBv0kOMpjDUKR9HWOZf6jjuws3iLm1vA3VRULDcXST20czO8K8Tgt
X-Google-Smtp-Source: AGHT+IHawetcghXX9NFpqB2El7GERB4e19tFpZ08tDfTdOyQOXDNGq8QQWdT7JUuayl+jvBSMxLoH+D0Frsv5xlPjp4=
X-Received: by 2002:a92:c610:0:b0:3dc:6151:5903 with SMTP id
 e9e14a558f8ab-3dc6151598bmr11635425ab.10.1747849152558; Wed, 21 May 2025
 10:39:12 -0700 (PDT)
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
 <CAP-5=fXT0edO0pjO0Ks8vGHgO=iwfuu+Bs5pfccZQhwfSo9mgw@mail.gmail.com> <8dba0ba8-84dd-4a86-96fd-d72de11d40e0@linux.ibm.com>
In-Reply-To: <8dba0ba8-84dd-4a86-96fd-d72de11d40e0@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 May 2025 10:39:01 -0700
X-Gm-Features: AX0GCFtUnl_iQ8wT7uBIF4YnzRMvP0awHE3KnyEMzB99tkkYipM1OWGGzbbgGgU
Message-ID: <CAP-5=fXN4q_55Y9P2JkjreFasGh0NmRQ8_t2=GujyPeUJYeHjA@mail.gmail.com>
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

On Wed, May 21, 2025 at 10:28=E2=80=AFAM Likhitha Korrapati
<likhitha@linux.ibm.com> wrote:
>
> Hi Ian,
>
> On 5/21/25 21:15, Ian Rogers wrote:
> > On Wed, May 21, 2025 at 6:03=E2=80=AFAM Likhitha Korrapati
> > <likhitha@linux.ibm.com> wrote:
> >>
> >> Hi Arnaldo,
> >>
> >> On 5/14/25 02:43, Arnaldo Carvalho de Melo wrote:
> >>> On Fri, May 02, 2025 at 01:14:32PM +0530, Mukesh Kumar Chaurasiya wro=
te:
> >>>> On Fri, Apr 25, 2025 at 02:46:43PM -0300, Arnaldo Carvalho de Melo w=
rote:
> >>>>> Maybe that max() call in perf_cpu_map__intersect() somehow makes th=
e
> >>>>> compiler happy.
> >>>
> >>>>> And in perf_cpu_map__alloc() all calls seems to validate it.
> >>>
> >>>>> Like:
> >>>
> >>>>> +++ b/tools/lib/perf/cpumap.c
> >>>>> @@ -411,7 +411,7 @@ int perf_cpu_map__merge(struct perf_cpu_map **o=
rig, struct perf_cpu_map *other)
> >>>>>           }
> >>>>>
> >>>>>           tmp_len =3D __perf_cpu_map__nr(*orig) + __perf_cpu_map__n=
r(other);
> >>>>> -       tmp_cpus =3D malloc(tmp_len * sizeof(struct perf_cpu));
> >>>>> +       tmp_cpus =3D calloc(tmp_len, sizeof(struct perf_cpu));
> >>>>>           if (!tmp_cpus)
> >>>>>                   return -ENOMEM;
> >>>
> >>>>> =E2=AC=A2 [acme@toolbx perf-tools-next]$
> >>>
> >>>>> And better, do the max size that the compiler is trying to help us
> >>>>> catch?
> >>>
> >>>> Isn't it better to use perf_cpu_map__nr. That should fix this proble=
m.
> >>>
> >>> Maybe, have you tried it?
> >>
> >> I have tried this method and it works.
> >>
> >> --- a/tools/lib/perf/cpumap.c
> >> +++ b/tools/lib/perf/cpumap.c
> >> @@ -410,7 +410,7 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig=
,
> >> struct perf_cpu_map *other)
> >>                   return 0;
> >>           }
> >>
> >> -       tmp_len =3D max(__perf_cpu_map__nr(*orig), __perf_cpu_map__nr(=
other));
> >> +       tmp_len =3D perf_cpu_map__nr(*orig) +  perf_cpu_map__nr(other)=
;
> >>           tmp_cpus =3D malloc(tmp_len * sizeof(struct perf_cpu));
> >>           if (!tmp_cpus)
> >>                   return -ENOMEM;
> >>
> >> I will send a V2 with this change if this looks good.
> >
> > How is this different from the existing code:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/lib/perf/cpumap.c?h=3Dperf-tools-next#n423
> > ```
> >          tmp_len =3D __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(oth=
er);
> >          tmp_cpus =3D malloc(tmp_len * sizeof(struct perf_cpu));
> >          if (!tmp_cpus)
> >                  return -ENOMEM;
> > ```
> >
> > Thanks,
> > Ian
>
> I gave the wrong diff. Here is the corrected diff.
>
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -410,7 +410,7 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig,
> struct perf_cpu_map *other)
>                  return 0;
>          }
>
> -       tmp_len =3D __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(other)=
;
> +       tmp_len =3D perf_cpu_map__nr(*orig) + perf_cpu_map__nr(other);
>          tmp_cpus =3D malloc(tmp_len * sizeof(struct perf_cpu));
>          if (!tmp_cpus)
>                  return -ENOMEM;
>
>
> I am using perf_cpu_map__nr instead of __perf_cpu_map__nr.

Ok, why is that a fix? The function declarations are near identical
and perf_cpu_map__nr is implemented in terms of __perf_cpu_map__nr:
```
static int __perf_cpu_map__nr(const struct perf_cpu_map *cpus)
{
        return RC_CHK_ACCESS(cpus)->nr;
}
int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
{
        return cpus ? __perf_cpu_map__nr(cpus) : 1;
}
```
My guess is that being static allows all of the code to be analyzed in
the compilation unit and thereby create the warning/error, your change
is just defeating the analysis. The analysis could easily kick in
again for Link Time Optimization. I'd prefer making these `__nr`
functions return `unsigned int` or size_t over changes like this.

Thanks,
Ian

> Thanks,
> Likhitha.
>
> >
> >> Thanks
> >> Likhitha.
> >>
> >>>
> >>>> One question I have, in perf_cpu_map__nr, the function is returning
> >>>> 1 in case *cpus is NULL. Is it ok to do that? wouldn't it cause prob=
lems?
> >>>
> >>> Indeed this better be documented, as by just looking at:
> >>>
> >>> int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
> >>> {
> >>>           return cpus ? __perf_cpu_map__nr(cpus) : 1;
> >>> }
> >>>
> >>> It really doesn't make much sense to say that a NULL map has one entr=
y.
> >>>
> >>> But the next functions are:
> >>>
> >>> bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map =
*map)
> >>> {
> >>>           return map ? __perf_cpu_map__cpu(map, 0).cpu =3D=3D -1 : tr=
ue;
> >>> }
> >>>
> >>> bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *=
map)
> >>> {
> >>>           if (!map)
> >>>                   return true;
> >>>
> >>>           return __perf_cpu_map__nr(map) =3D=3D 1 && __perf_cpu_map__=
cpu(map, 0).cpu =3D=3D -1;
> >>> }
> >>>
> >>> bool perf_cpu_map__is_empty(const struct perf_cpu_map *map)
> >>> {
> >>>           return map =3D=3D NULL;
> >>> }
> >>>
> >>> So it seems that a NULL cpu map means "any/all CPU) and a map with ju=
st
> >>> one entry would have as its content "-1" that would mean "any/all CPU=
".
> >>>
> >>> Ian did work on trying to simplify/clarify this, so maybe he can chim=
e
> >>> in :-)
> >>>
> >>> - Arnaldo
> >>
> >
>
