Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA176026
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490534; cv=none; b=EsqJsjS+erUdJyxD7w9oW1iHCqDLiGCryVTug8fmSdLeRVdgVtykOMgRGwDfsJohve26NiQk1dF5R5Ot8Rgk6Gtjs9aarmk9k1wU0JMfUWzpOArG7KmzSsdljRCR3YgTtBgdKlh9dtV+k3y+HaVQqckWdOMfQ5SdeI/dhcFfOBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490534; c=relaxed/simple;
	bh=i2KMGB5jXlYrZOEVyEEtlYkBMWkUvJBvYvMLMWjqryY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvmwxYQwEy9apOxwsb/x0v1HLFOa99YZgNzd+qopxRt+gfwlr+1YFpaPLYeHVmiDaiSivwUxvjvK2jEZ8UnSC9yyxf9E8mge1eJfJchhw0M99fZ5nbrjW3+bYyymswR5UL9hbpIuC0xJ57IRC3++2yKFA7AmhDS7AXncU1Re5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvfJPXFb; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvfJPXFb"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e9c6b44477so1714917137.3
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490531; x=1754095331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2KMGB5jXlYrZOEVyEEtlYkBMWkUvJBvYvMLMWjqryY=;
        b=EvfJPXFb+WTFp+kudxv6YHLf0TPkAJgThkffhKdWGbmjz30u3nn9Zduz8zDqdlAlOM
         j84jklBeCiSyQDNfKpHoY5KNobAq6ly+8cqJzhXgfvrDLMLhOd5Q5uKfRcYjfGDNgRZz
         ogAL316jEF7qhlCIN0GxRdmjwnvYEup+IgHiRL5ctFSsMTZL6akOHKtSdMMO4JJiCdIV
         TvRPGEx/yWQS5hFrEuaWpx/B5s5KwO9XHoz3ODbAkAPDR5f8SRt3NE8Jincs43nR3SAU
         WYSMBjATDMryH65U06Fb6gbmMPWUSEXJolRVXv+99OhwGwr47TCESyJEYVYy555ouxuH
         U7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490531; x=1754095331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2KMGB5jXlYrZOEVyEEtlYkBMWkUvJBvYvMLMWjqryY=;
        b=G7ICbpXaKKCXdBjYex9dfiiC9j+XmwSNnil5Fo4RCGxAau5m6j0XC4FdIPU/v25VBD
         RwlAJDYKF8myYxhv3wmCm4fgVIhrPhTkvctrqjY1aZeB84AUq6yXzd+bbG1KGOXCFBBb
         QBnx+muv6BcK5VNTQwU8xVKwAzQX+rYkZD4RyC15IdwD6IvZMambi/ptxUm1vnmDkSj7
         5eYyfqZTyC+aobHI45tbFUOuivvdkFyclPzpxVbVW+ywDbbPsz+cesQiIBb0QxDTn1yu
         WLQvgTvHRLmXRCaTAhk6eoAAMQv/y10iWGdHuGwNz39P8ZaLyjGkKZlqJdItCcZTahkx
         3mMw==
X-Forwarded-Encrypted: i=1; AJvYcCXQuJJlV+5oMV3SXrgGiHVXZTQe5iZSXW6VP1IrCIYn8h5AZW0Rg/bV0griNCyxeRm1KK6RgcJprTFWzFy5ITaR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1lxbm0VHsMmXy5MGjM2iEupz/jj4pO/WUqOCW4UiKtNBW4pc0
	GHc7oRVYKO3YC23G4n4yFnt6RROdMW12nD1l7u1t5uiZIgRxVt/+XuEK4ujOg1pmIFb/QDZZGM3
	BWXid9CaNpT5WRpe3S4UtInDeUqXA5bBIoKvFGPQl
X-Gm-Gg: ASbGncsrmpDMQYe6S2bU8rFvLfO9jP5RGwZp1oRFxEx4XfA0vKXT4W8eLTbdh3Xhpzu
	OxZH6SHsUwrNy0VHFGPX5j/pEpmPzFG5RcOie1J4T/LU4OR8Sjk0Gj6qTjIJOeM9Y7cMYknnlB+
	HhS3G1Wuu1uXE85ZDPmQ+n20TFNL5pCvbX83Mbp1Q2gtqhOjU0dBVJeo03BbpArARwRRtaNhjmy
	LdjpBo=
X-Google-Smtp-Source: AGHT+IHrA3GZZD0wwju8aMv9Qz7fcPczk9FABOxxb3E5ADsq04AqPwLpKjr7JRvL4/0iuqFoC974FPIiSp+z8XfswSE=
X-Received: by 2002:a05:6102:8087:b0:4e9:c652:6a1e with SMTP id
 ada2fe7eead31-4fa3fa67872mr2000007137.3.1753490530877; Fri, 25 Jul 2025
 17:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605233934.1881839-1-blakejones@google.com>
 <20250605233934.1881839-5-blakejones@google.com> <CAP-5=fVX_Qohsf=f=-fR8mYsTq4zitURit2=4BYyD5HPJHOT7Q@mail.gmail.com>
 <CAP_z_Cjuh9HJvcnsARaX-QUwDMbRPMDr9AtxbBxYUR_BTSzwCg@mail.gmail.com> <CAP-5=fWuU8Xhzvjx8FgQpOJCJXewOw9S3Vdm+aXYgw64bsq0UA@mail.gmail.com>
In-Reply-To: <CAP-5=fWuU8Xhzvjx8FgQpOJCJXewOw9S3Vdm+aXYgw64bsq0UA@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Fri, 25 Jul 2025 17:41:59 -0700
X-Gm-Features: Ac12FXz0LtMLKb3jLJLRjLCQ4NRMLoH85zHPh6h6oQV6X5PeOP12nXzMnjePzzA
Message-ID: <CAP_z_CjEzaPo=V+rzyDWFgnnHfNGAe_jHm7g=++V72GPs1A-fw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf: add test for PERF_RECORD_BPF_METADATA collection
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just sent https://lore.kernel.org/linux-perf-users/20250726004023.3466563=
-1-blakejones@google.com/T/#u
to address this issue. Sorry for the delay.

On Wed, Jul 9, 2025 at 2:45=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Jul 9, 2025 at 2:08=E2=80=AFPM Blake Jones <blakejones@google.com=
> wrote:
> >
> > On Wed, Jul 9, 2025 at 2:02=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > > > +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> > > > @@ -0,0 +1,76 @@
> > > > +#!/bin/sh
> > > > +# SPDX-License-Identifier: GPL-2.0
> > >
> > > The 2nd line in a shell test script is taken to be the name of the te=
st, so
> > > ```
> > > $ perf test list 108
> > > 108: SPDX-License-Identifier: GPL-2.0
> > > ```
> > >
> > > > +#
> > > > +# BPF metadata collection test.
> > >
> > > This should be on line 2 instead.
> >
> > Oof, that sure wasn't on my radar. Should I do a followup patch, or is
> > it not worth bothering?
>
> The patch has been in perf-tools-next for a few weeks:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/commit/?h=3Dperf-tools-next&id=3Dedf2cadf01e8f2620af25b337d15ebc584911b=
46
> so modifying it is probably not a good idea (it'd need a forced push
> and break people downstream). If you could send a follow up, that'd be
> great just so that we have >1 person in the
> author/reviewer/signed-off-by tag!
>
> Thanks,
> Ian
