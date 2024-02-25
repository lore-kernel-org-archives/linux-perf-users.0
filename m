Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B6418637
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Feb 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708883061; cv=none; b=CNXg3DHSPQ2kBeXLGCdFADfD+iNf0HUpVeccGBIRHYpLxxS0GfC4U2wctuTAQXLgP7oZvQ4vaS8eIsSfrB0+78LqqClNZWMflB+Vgo/Ir9H8/RlayeC8JQhIuvYmTWeo+IhNTZCvoBQKgqTptYJiauyRvj2GHRXwo0GWiAbbE6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708883061; c=relaxed/simple;
	bh=0K5xMPOYequh7ZQp99U8co9tYPwwBbzQ3CMMu8+kdV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKGYWFv8IcJJQis5InnWrZgr8SsZJsRQtnvV5K8gg7OTs/j1RfyOHCkdl/OHPI+W5eNC/Ex5sIepErIrGq1+WJHR1hRZxMqtRLGKeWLYpyDDZkkxbVyaTQzOZ5dru/qkVRxseyHY6Beeas5+CHxZl4XeHpGXkkGx2xXvfikfYsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5XL5yM7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5XL5yM7"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc744f54d0so163915ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Feb 2024 09:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708883059; x=1709487859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qStKuBILkLY1v8oXdUPbeQuvbfRqjxTb+0Ot/9pOfvc=;
        b=G5XL5yM7BYQJjCRV4A55ICRhscaOFic+8Pl8beXvWXYMYDO0RPNbPgkjGzAlG0Ibmt
         7nyO8TPMmCleAq5npznvW1itZN+6uGMCyCVKKujzoH2sakS/VLFGWcz6MunlXyT2UM+S
         SwKQIhbcD6acX6wilUEf25pUT+Ufodj+h/uO+TSug5bntZuxtdJBmC/2HLax04qZbGGe
         e2fPo98aQ+ZEEUN2fLnrF4fP+EC+15H8KwzNh0bldSphcNInWvegc10Jzp17wqK2Tevn
         HOrqo1QyfeV1KHKmlitynT47ssJ+BBRjEfisvuM5u3S79+IrvrSLMCrKdlDWoyOfvmKH
         +mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708883059; x=1709487859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qStKuBILkLY1v8oXdUPbeQuvbfRqjxTb+0Ot/9pOfvc=;
        b=p0VAACVlz/hjICWa3X3//O6aUtEQC52Ewmc2PMZRpF3Rrurj/Qtc/0kDUIhYTBMjLB
         odskDoBEmKhUp3sUmrvN2ITsKGXUthpfLmt0qJx5GKI6Qq4aHcfT0T7VVTf1LeBXE/2v
         iD1dX1Qb+nLPb0KCha9cYhSC3utlcKzeKehD0RznEV+gnkCi/CYkBrB0VJLVwgNG3any
         7Ib8zrPhpCZA3vN1KIAdEqAMmJxBfUeH2vkdC8uEcT2x1ZhOXCrQ4zacmqvAwi0D5CBL
         16qnkuOdEx3Ux+eKVXD2H4MohyUGhDzcvf3acHPzmZTbbQ3M9DK+eh4xtAtM1f2lzXJ4
         a+rA==
X-Forwarded-Encrypted: i=1; AJvYcCUDXqQs/a8q9EWTwz5Jhw3vJjHQaXca98NGiNMhbKhSc5tjWcPTiBYQ6/ebj3XJ3qTYA3ypXimjp5fDFtEGrocsVZuQrgJioZ8iSBeUmv2v5Q==
X-Gm-Message-State: AOJu0Yw6IC4sKZLVPVvUXFtSVLLTyK+ZJtjZVGbGxCL74cD0OidTE3No
	rQayX9GWK6tvlKnpuhrxHU/VRzX1LGpr8HrIijJLEyWQ+TJ6oF3iPWgSRluhrJcO58TE/b8dVoP
	F85rfIrAvADfQZbmQ/5EQ7O2DoBRw5UFomZew
X-Google-Smtp-Source: AGHT+IErOGEY0ni+ULakJAaE+x5eBVu1gsfbzxfzy3KLUCvMo87Nc+2OWz/bDWgTxXZssUbPaDS0WS4CaFvvsNOJJik=
X-Received: by 2002:a17:902:fc4c:b0:1db:971b:cb62 with SMTP id
 me12-20020a170902fc4c00b001db971bcb62mr239463plb.8.1708883058352; Sun, 25 Feb
 2024 09:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9538b2b634894c33168dfe9d848d4df31fd4d801.1693085544.git.christophe.jaillet@wanadoo.fr>
 <3e1ed5a3-55dc-4652-936d-fd36e0442d79@wanadoo.fr>
In-Reply-To: <3e1ed5a3-55dc-4652-936d-fd36e0442d79@wanadoo.fr>
From: Ian Rogers <irogers@google.com>
Date: Sun, 25 Feb 2024 09:44:04 -0800
Message-ID: <CAP-5=fWEQdgOsVioWEHr6QNPv81r6VjAR5vyA3OGSuF09RsXBg@mail.gmail.com>
Subject: Re: [PATCH] perf pmu: Fix a potential memory leak in perf_pmu__lookup()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 7:42=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 26/08/2023 =C3=A0 23:32, Christophe JAILLET a =C3=A9crit :
> > The commit in Fixes has reordered some code, but missed an error handli=
ng
> > path.
> >
> > 'goto err' now, in order to avoid a memory leak in case of error.
> >
> > Fixes: f63a536f03a2 ("perf pmu: Merge JSON events with sysfs at load ti=
me")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
>
> Hi,
>
> polite reminder.

Apologies for the delay.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> CJ
>
>
> >   tools/perf/util/pmu.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index bb2ca29cd7bd..8dfce84ad9fe 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -1018,10 +1018,9 @@ struct perf_pmu *perf_pmu__lookup(struct list_he=
ad *pmus, int dirfd, const char
> >        * type value and format definitions. Load both right
> >        * now.
> >        */
> > -     if (pmu_format(pmu, dirfd, name)) {
> > -             free(pmu);
> > -             return NULL;
> > -     }
> > +     if (pmu_format(pmu, dirfd, name))
> > +             goto err;
> > +
> >       pmu->is_core =3D is_pmu_core(name);
> >       pmu->cpus =3D pmu_cpumask(dirfd, name, pmu->is_core);
> >
>
