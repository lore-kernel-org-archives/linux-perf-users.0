Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05D32937A
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775022851; cv=pass; b=fit+rBYfhz+0+XVQAFU6+id6HmbtsqFqW8ozlLtlE2ZzAXgSytJE5MgZXaKEaT5hoXRh/s7tU5JW6Be0fBIraIvuEY4zPasH4KdDuxIPu2m1TLnmsjHeZN14ceMUYxRfqf7Owr63XxZjyxdkLU7yKpNmjR3SkzKnmyu9iXLBJ78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775022851; c=relaxed/simple;
	bh=myudahY8BfsfgVaJNGncg5DDzjE2qRDZ3MRxSQd/8NI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OcBPlRmpjLtb107uoys678F5jkO5KIkvB9z0tAdXiPYV2ko60Pqou0TL6cWUtcmJWqWDoPy5uKXRfG/KnbzZa7jLP3Tb82sq8Y1/cLvxqCaUlM2MqnpDZ/Mmp2wggVQllsD7qYcxlxYDqUl08JjRUpoaxyzW8sJl7txMCvpBBZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rESH8GZK; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rESH8GZK"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b0c12be0ecso191305ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775022849; cv=none;
        d=google.com; s=arc-20240605;
        b=Xw0cN/a//SSZ1sRLh/twQr63EbHaRjAYbVU5rnpTJ9ioso41bVtAnLQSw04aRlF3v9
         04Myjs28Vc0PyvcEv/uatio1A862U68aURZdetDRZsBClgkHd3b4lFkDj0+hV0mUGbOS
         zxxJjcP47x0Q+rkrX4/MDak6HjruLJhRk9DUoWHhng73RBTx0rYRr126O6rH16XyfF0X
         sTKyciUGCfu/frbBoKA6rvY9IrBicegsOqFL+yLXMAL1qOGzShcY18PrS0h3mtRo6pIZ
         j029AS4oU4inl0jirAqW5a5+8iRxY1oPf86aA7wPeu53HgKNt255ExmATxPtVL6vsw6E
         zz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cioANUO8rx90bPWuuBWw1epTvghxNvR2Eke33Sx62fQ=;
        fh=z87wbtd6H0F/K2gBm8qkmTP1FZ93gcPelAWfQM+kNWA=;
        b=Jf8A51I2J6Pj123WQuXFGJZICbihLsP67f8drrE1RGB1zgu+OWoCS/qmS0h4BKSJob
         jyzIiXHLifOtib4e/pRntfVwUxW4axv+q7lHC/OXSiYN8D0mQa3GZBwexNzvkEX5Clgh
         J9Ri9fLcOJp1TDBgzwLpHGocTVLesNzVUelwJu89zrspQeI8pRcQnmyumJLdSmHfXyM9
         XgOZ5uqimX2TmiyP0q2Bm2r+DiJT+ptVNiPXl/jfPyVjlj9jFs+bBpsZ1Ds5IU621X2h
         ZYI5Qi5P+HFUGnSSbK0PNoOEjP/RuHu19982Zeu38Hf9CG4wEGBVcPwTKH4tg8vxjU6S
         Ez8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775022849; x=1775627649; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cioANUO8rx90bPWuuBWw1epTvghxNvR2Eke33Sx62fQ=;
        b=rESH8GZKmO3GrhyCGTHNMngqLzxNHGGHiEpNQKIwo8EYalMoFt0Opn1jDxg1i4+RyG
         I+jrfo++W4sWOoyPPEz4BU0t1/dyGteRO0xlfb5VJ7RjBjwQAGJJMXss5Rl1P5aV+PyC
         oYm9PuGr+2sKjv3kKtIr1sXzJsnpWwMiVODLtRoSLzaDVrfde+LyTnCq5TiJDH6LFYLt
         7bpcm0pFt/PBtCajRuDpLX5Eb+Vl0vaQ7VwdXRwfSx4zySUZ4akX3noCT8iinQSA8P5D
         zJGU23s6i4n+obq7cnWa4uCBLCVOQ8zEClhQ2mvysdrm5itnnCXVvTJE5JAq8LgdwbcQ
         D1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775022849; x=1775627649;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cioANUO8rx90bPWuuBWw1epTvghxNvR2Eke33Sx62fQ=;
        b=WOSxEKZDg9H9kaw2luBk10CDKsQXkZmTf9OG2vMphYhoGruWX/LioNpkb//pjNeo/0
         KDy6SikhAlFZeqG8nhZ5qxV/CPoBrAzT1FTLeJSRvsT1yZgduHGDzaeURTct+V/u1klV
         DcRP4NSG+UsJcXg+fTqFu5963FZi/nRA84PsBC5LjmCFoukV571DpOEBnzV8dO2JEENb
         5u4t+OJze9pkyMKMUSFUk5LjJDntwfCWm0tMD5Fs/tIIHS634Dgz1CEIxUnlEA38E67o
         Lwf2djXOZ/+99TUcW8ud6WNLD3GMN4opa4OZQg4bcQbIvemZsbrYp+vCgbwmkcjhj45L
         7bFA==
X-Forwarded-Encrypted: i=1; AJvYcCVX8yabKID49eudQXAuwo4tCjn6jXUKuobYQWFEBZ+otmpuQaMB6GaG99xfudfmWoG+RTw6mjKzyL0JUKNOwpEE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc80/F1AK/KHtPD9Way4horWZTM0d+VdbaQp0UAtgwcEc+1Bcr
	7g7dZRvjmd6Dn6x728Qw6H0i3NuCHW+bVQJhSL/2fq06V6WZQc7jp3I0PzrRHl82MLell84xqrU
	4k4h78eja/WaaVOhManqWwW63wEwn6WaR+qsqgRq4
X-Gm-Gg: ATEYQzwhTFXE9+cVEVAIXcw1txmSkUqLVYdBS1YxqZuHLF4FwnejLGH/+6KK6dxw7Pl
	Xf+IpdpBOBAID48eLuG+9WjA16jCsoZInUQ5ryDeslUWhIpWQcSUFVD+ksyh4TgPt9WwdQh1lab
	BEcXxJUKYm3XQt4Bn0J7F5Q24V2VDHm3dgER0ZbA9bmf+RzkRZ0AuvRVnSeL+2vOsn52QMr8v+K
	9UUEa/ipZS0iCxPw2kiDZlKJ+Sj/SHw2YuyPWaQPxaQnmwQAiGPN3ol0WOOe14c8hVR8sGsoh3x
	dDmKtg7g8Z2/YzytH3Y=
X-Received: by 2002:a17:902:f711:b0:2a9:5ef5:399b with SMTP id
 d9443c01a7336-2b26b2dc7f2mr1476455ad.19.1775022848757; Tue, 31 Mar 2026
 22:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306185022.2016541-1-irogers@google.com> <CAP-5=fX6ttKud+b0sDS2SjHytocVNq8Ga7j66LFwRBXOwKJ85g@mail.gmail.com>
In-Reply-To: <CAP-5=fX6ttKud+b0sDS2SjHytocVNq8Ga7j66LFwRBXOwKJ85g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 22:53:57 -0700
X-Gm-Features: AQROBzAf0w2euISk4DwPPLrxfPEtuYTPs4B29BwLeHGZyaK9iG2pQVUXEDjpdJs
Message-ID: <CAP-5=fVw338CJLJNpD6qjWVA3ofqd9H5-0PvjUfhQRjOtnN4Gg@mail.gmail.com>
Subject: Re: [PATCH v1] perf ftrace: Proper error clean up in print_profile_result
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 7:50=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Mar 6, 2026 at 10:50=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > The ftrace profile_hash is cleaned up on success but not on memory
> > allocation and empty paths. Fix by running the clean up for all. Free
> > the profile too, so make it NULL, just for clarity that this is all
> > clean up code.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Ping.

Ping.

Thanks,
Ian

> Thanks,
> Ian
>
> > ---
> >  tools/perf/builtin-ftrace.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 6b6eec65f93f..19e796e58fb0 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -18,6 +18,7 @@
> >  #include <poll.h>
> >  #include <ctype.h>
> >  #include <linux/capability.h>
> > +#include <linux/err.h>
> >  #include <linux/string.h>
> >  #include <sys/stat.h>
> >
> > @@ -1369,17 +1370,17 @@ static int cmp_profile_data(const void *a, cons=
t void *b)
> >
> >  static void print_profile_result(struct perf_ftrace *ftrace)
> >  {
> > -       struct hashmap_entry *entry, **profile;
> > +       struct hashmap_entry *entry, **profile =3D NULL;
> >         size_t i, nr, bkt;
> >
> >         nr =3D hashmap__size(ftrace->profile_hash);
> >         if (nr =3D=3D 0)
> > -               return;
> > +               goto out;
> >
> >         profile =3D calloc(nr, sizeof(*profile));
> >         if (profile =3D=3D NULL) {
> >                 pr_err("failed to allocate memory for the result\n");
> > -               return;
> > +               goto out;
> >         }
> >
> >         i =3D 0;
> > @@ -1403,6 +1404,7 @@ static void print_profile_result(struct perf_ftra=
ce *ftrace)
> >                        p->st.max / 1000, p->st.max % 1000, p->st.n, nam=
e);
> >         }
> >
> > +out:
> >         free(profile);
> >
> >         hashmap__for_each_entry(ftrace->profile_hash, entry, bkt) {
> > --
> > 2.53.0.473.g4a7958ca14-goog
> >
