Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667CC33C51D
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866451; cv=pass; b=mX5lRFWHymyIw0FuvDguTEek9YbupYdi3C/g4pUdqB/9EC/SkMGwRhwdWwBboeE4nbhkm6ZoTMglpqCMu9+h2eyjULNthCD/nwNRVVM8xO9zqs5ndGHknKCszERu0lW4wpLF3Si/czHlrij7tDJ0gDTDmautcPxufGHrfcB4VJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866451; c=relaxed/simple;
	bh=ilOGkfSQuWFSl6+eWRuXcPWEJIw/eh3YO4M/z1h9j44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rhe3CCQxs5O/yvRiaG8G5VA2l07RdLs41PkJPbF+GI21h5sjJA47xsrjJ2nenUNqhAhNbbp4dEHPliNT5QbOBJ4b3CgeKK27OR3PQEYnx+4NzwQQYKYcfVOTmjTQT0kDu/3nGbuHRt4jw/9jck3BmgoaqES0JfQavKVQpdGc1k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gG2UjaIL; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gG2UjaIL"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so22905ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 13:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773866450; cv=none;
        d=google.com; s=arc-20240605;
        b=iL5wNmrwky+GlKX0nYdnk+NYJ6/8VM9r1awVZgcfbR7xdNzAWVOJ7JW1AqAszfV91E
         x4qBCjrmetVM9CkAcJPMcivn73X2Fn6wvL17IEKknfwnqeBYliEzLsq6k1qC4ymnyrq7
         1TyGTD69gFxoXkjV1BgEvL1gPZ7OQ2DUkLgK/gjp9z0pN1R0KRWfsy2NFGfb4ae4MGem
         waiAKw7/1/Umx010oq9Ubns5lBnaSNGIZ6Q3YyMNgG46Z4WJu31K3GBwrU6OyWcs9Uz6
         PRx9FYo4ZMvG7ta02tFRVbPJ+ba+le+FsPASceAz94IgqNPe9vXYjZG1f/6SKmPQ5fY0
         NVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/mJYfkh3V2Ae0hZVMZk5KYoiLCsLua3DnHxndq181WU=;
        fh=HrDeXdV7XZqlRlMi8Mlft/2IufKRMY5odkWJd6rbsbQ=;
        b=C1Nc/77ab3qx5ty+iU/XFhsWPA5rmb9bSa3vzpeCJYIJLIFdhHy91MPW+OLHFpJRki
         eoUYzvocZP24o64MOQP9P5S6KDGpPJ3S/oELhU9/FOw3elx12bPfCFi0y829nSbPkPvU
         sC4d1uPnoS5+kuQ42xjdDdepohXGnEIqLk0pUxKCTdbGyvdOTf2nh6pG3V6quWvU5uUr
         JWDEgIwsoGUF1m0ZjZRme8+dyG4fcwxHIUkw2P5ca4BkDdIi6ZC5KQdv1UqSppLt1Ddi
         wAMxptcYyKewTkDWbtEt/dFv3iMspd44pr4nB/k2Dhet/U0jg/xWMxwlsepb/3W749Q/
         eSEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773866450; x=1774471250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mJYfkh3V2Ae0hZVMZk5KYoiLCsLua3DnHxndq181WU=;
        b=gG2UjaILiuB9UNS8BGlOuKYNAsSwnFOj5AsM1gSJKB1kSoIiG62Vjm0G68CLYDugIK
         oMq7c3pk6l5/kRGSrOfIof37AUoCZaOkv6WULdGBY6C/+JgylLa/1u9R3VlKoJ32RSTq
         hYo7AcI4fEce6TEm9xDcyrs6j0Uqi8jLJ6i+0TzSuuN2+6qSLwO0/fJX9bKLz7mMjMJ0
         5X7VuM/OnKcMQKBunrgWjyVZov5eFN9HlqGO6RM856toGxoMdGCFOh7dB0eK8xNDWkt2
         YV9kJ+umT1hJ3qzJaaq2t5br1ZkBa6fxxu9WEjJsKLlpz7ntLFFb3ywntbn+lnXmpJXQ
         bi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773866450; x=1774471250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mJYfkh3V2Ae0hZVMZk5KYoiLCsLua3DnHxndq181WU=;
        b=lri4mlcWvogjV5sDzawmk2pB31JUOPWj5AQt8Ay5pITTctgPeS3lMFv6Jl/XvgLlY3
         2FDVBQ/h+H4XQeBgPE6z0pIrSz1xty8Tkj1tJxa0vZjq14HbMcN0H+HnCAJIaRdX5klK
         PY8fbaZqNKFvandvbz+SlrMFv1wFQIJg4INj2lMVpZU9uzXK4KylHe+9iTB7uAeesH83
         Fm9TENA98hQCg+spwE5MjC11S99/RM5J4xaiLxl1DWh8xeLT3jKHYSzgft7bK17HXw9w
         aUPNO6XYfPlfwgdBY56jN4A803GTdS6nimu1JdGKKQLmbiMaoE3ItGOEBBmGD5rrm4PT
         NxEw==
X-Forwarded-Encrypted: i=1; AJvYcCWmTdzoGm/kl/rroswojRQOnUQ74rb9B8azk/YSlIpzAbZasgRsMnK1rN3LBFxRHXshwcXnRWAv15OPgQFXney9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8gvwois14QSF/zS3i+pXMboum5NL6WeiVYYgZTYnOm0vcdHok
	5+o6yks1LUWAPCkIWvUQ8sWTLC3Hy/SAPlP9WEl1c9rhomMIR/0wlyxk2BVACzyP4eU0e0LzuTy
	SvuLldpBZPtdF9ee6uXwBAtZXcZIzXQmaE23P3ZJX
X-Gm-Gg: ATEYQzxpNGOS1BLA1JGjGgymAv7wZCuf04NnZjCf1bj74hMyLDo5Z53pgo++gU9kWxr
	9Fe23KfbhynNHV3NyIHdG9uLu0wMl6j9dNPzGb3eSk8J12nlH9nigT5qPHl8hzKR7JVTOiNj5XR
	xp5fOCjMQX65NOmpEuJ2a8hXvo0ix7ByhGHgcVTTAzcaG2kMejiU4Y6b06qXxNU2iNw0LN79lBk
	DEFXABrAsb4UmRn2H51Bnv1QvtoBiT2NauwjI2XtkFyq30qBuoyLYrKYABIoudPYpg38pz7hagZ
	oBiquSMk4w6V64aa5nBeb1qAjw+Qt68khJN6zyMM32vOkDDY
X-Received: by 2002:a17:903:3d05:b0:2b0:5c88:51e1 with SMTP id
 d9443c01a7336-2b077e5cf92mr799945ad.14.1773866449314; Wed, 18 Mar 2026
 13:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318034932.398913-1-nichen@iscas.ac.cn> <CAP-5=fUitzKwJONTngiW17XkS7kVr2cDS4cDL_HccJKcnR2EgQ@mail.gmail.com>
 <abrwRmaS7CDhzAyl@google.com> <abr1qQ2ZjQN8Nh4U@x1>
In-Reply-To: <abr1qQ2ZjQN8Nh4U@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Mar 2026 13:40:38 -0700
X-Gm-Features: AaiRm53tlIIUVnsxRmA3pL2n1WNkJ4HZvbEC0l2tHcJ5LX0dKveFaTpNCQMu5FY
Message-ID: <CAP-5=fXavSh9KkbKfZva-HSc4LG0=yaHJ9q3FmrBHgBTg6e2Ng@mail.gmail.com>
Subject: Re: [PATCH] perf intel-tpebs: Remove duplicate include of stat.h
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 11:57=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Mar 18, 2026 at 11:34:46AM -0700, Namhyung Kim wrote:
> > On Wed, Mar 18, 2026 at 10:33:54AM -0700, Ian Rogers wrote:
> > > On Tue, Mar 17, 2026 at 8:54=E2=80=AFPM Chen Ni <nichen@iscas.ac.cn> =
wrote:
> > > >
> > > > Remove duplicate inclusion of stat.h in intel-tpebs.c to clean up
> > > > redundant code.
> > > >
> > > > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > >
> > > We should really have a style for #includes and try to get it into th=
e
> > > kernel coding style. It doesn't matter so much in the kernel but
> > > inconsistencies abound in tools, and the lack of alphabetical sorting
> > > allows duplicates to occur. Here is a proposal that makes sense:
> > >
> > > For any given C source file (e.g., server.c), group your #include
> > > directives into distinct blocks separated by a blank line, ordered as
> > > follows:
> > >  * The Corresponding Header ("server.h")
> > >  * C Standard Library Headers (<stdio.h>, <stdlib.h>)
> > >  * OS/System-Specific Headers (<unistd.h>, <pthread.h>)
> > >  * Third-Party Library Headers (<sqlite3.h>, <jansson.h>)
> > >  * Your Project's Other Headers ("utils/logger.h", "database.h")
> > > Within each block, alphabetize the headers.
> >
> > Yep, sounds good.  I'm not sure if we want to convert all existing
> > sources for this.  I think it's good for new changes touching header
> > inclusion.
>
> And then there are cases where there are ordering dependencies, which I
> can't recall one to give as an example right now but I come accross in
> the past.
>
> So perhaps this should be made as a recommendation and when we have the
> opportunity we change?

The issue I normally face is adding 1 header file include. Should
there be 1 patch to sort/fix the headers, followed by a second patch
that adds the new header and feature? A problem with the sorting
patches is that they are prone to merge conflicts. Then the feature
landing gates doing the clean up. It may be worth cleaning up and
accepting the pain as a one-time event.

Thanks,
Ian

> Just going thru lots of churn to have it look polished seems overkill
> :-\
>
> - Arnaldo
>
> > Thanks,
> > Namhyung
