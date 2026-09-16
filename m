Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E3E48C8C4
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599638; cv=pass; b=Zxd7b5p5AI8tDdrZsOEfhtVinyU9bedM7F1G+dLrx0p4/bbldBcz7ijhT5s+tl4uCXJbqR/u5zvY7IkZt8ctjy+QoAZgoTgiYG/HjJdzkE707YW7OBMANaRAMGBaFYWRdCmGZHYHk5pT8mv/JfKS7H1Ic21o8YPEwvxvOq+pXcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599638; c=relaxed/simple;
	bh=QuBrajklj/vua4yJO0R7ldnuXGl8ewqZ+7dlM+710+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+VkcSYOGIE1m9leY/HT1a8ExqTH9AcXRU6gXk9tkvnUTeQBBec2uVnEFYkfdX5CshrgfCvL0g+lBFlnZj6+tXhBTisWFPx+mSViThxWKX/1AU6eKvsUa8/MxuJsCdJEOx1Hoc7iH9gP4h2gXwwkCXsIhEJhcUZmvcQ/zsW3RXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qWLZ5Vjk; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWLZ5Vjk"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5306706e89dso81001cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789599628; cv=none;
        d=google.com; s=arc-20260327;
        b=QN8NZsAYNVQ0RWSLZAP8R8gLF494bOWdgCyGExWs99VbbnMIwR1HKn/Gpn9pRkTPl6
         N0rv//v/E7mG9xVbwJB56o0kGA0mtJU+HvhAjK+i0R/kULjFxBVcChjn8sGIYzAd3cgD
         GpcE7YFf2MuwDQ/b1E6SXBmlt95wNsSpC2SNVIYpGSSWOYhLvHeYaOGBPL0mmQe4QKuI
         p1aIy0QQXvVhDyONUtq9n6W0x9MGhMAGG9lZIbEcVqSqhit7jPXwcIYthqtOlM/5LFk/
         J6G4kGh3/BuVa85sP8lG84aFshI5rui80GLu5FD1+tU+LZgaKh/ji5QCjH1KmISz9WWl
         uk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GWnq9EURCR66rglg3KayqZD0lrmT7EnLwwqURS0Xwm0=;
        fh=qf+/gXqpiSleHbMe9vFh/85+17BACzfZpYpa9KwMb9g=;
        b=gP3Jml/DaAlabdwnZ7813H6SgO9wFVJoz3t0mz43eZvSxdKww7gP9XdNJPEguwTtFG
         v+IkD/EkHCrRIyOyXIQBQNEakh67008bbTuz6tBov8Ha2dST35MkWWdLYn0mhtQaNxEF
         k1MhT7jcQkCY8wVybJb7BxYqKj0GJhmfb+xCEnRw7PlS7wGwVTlgYEkuR/WYWYD3lrOi
         9fgOyJ2GHGGu+1eLBfE0LNGNjGjF0lKor6qolusqiOYw1Bhrp+6mrVk0GfmVlluq+3Gp
         ODbPQKfAm4fWyeWVRMUbLfbsssuvxnPScQdvfKdyllX815tvDZcsfbZo4Xkn7/i0p147
         ZFmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789599628; x=1790204428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GWnq9EURCR66rglg3KayqZD0lrmT7EnLwwqURS0Xwm0=;
        b=qWLZ5Vjk29rXb9sbW+az7cK8mPsT51oR+AYygsK5c6iYXjB1sl1VJTUDSAK3l21/tZ
         DrgOXK2HQezU2q3ybTed4pGlnewixRn/rsaTrigWJ7aSlBfI2Idnn9d5v0bFzjN/vqJj
         3wLih5b/C2Zr3EqrRTPWVcaqXNd7IPA1ij24GK0HmRGFVLvrCUFEUpBfcrFL5ehifl38
         RR9DlOjNnooWcyS3u7jooFKDjEhNP6cLk0yIt11TYMCR/jFivlO5dKg1gs4u+oh14YCa
         31gaAxk26iYNkrCHcyhvXibgRKRbthl8FomU6xyk27UQrrPQN0zHWbma/ydOjU/HvVfQ
         V69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789599628; x=1790204428;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWnq9EURCR66rglg3KayqZD0lrmT7EnLwwqURS0Xwm0=;
        b=xp1O+NmABwsOza3cY5LKtuiaqAncIXxR7gImM7TXkAqo6LZeFWOotMhuxxh9y07EKb
         9n+km11hSfedcrt9KLMYG2wznXlXMc08R7BCFF8qptgzWlQtFikyeb6mECZSt6JaaFu9
         UrqCpTUMRnwx/ZhQQG0uE/wXPtKL7ExGewJ2bK5m6uV+cK+L4W3o22l29ELGn6qVaKr2
         vre0BPTaJSzHO80Bcd5K/tNIpgBrnugi3xtL6/j5rkAGABBV1Ef/nniWwm6NJ/wioVTV
         ylJAEsm6VUYdAlpJEHK1BsNGrlxQ9uslvkHe1CcnJJ2Umwq0Cw1EBwcUgV/SEyT/vwuj
         r3JQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGWj/yWIMYGmR8BaUBGgCq8tTBiPJq+0Vz7UiZoA7IbQaCpGKVc6ygrR4UUvA9KCpXcQ8qwt5SLXpCGVtp+m2i@vger.kernel.org
X-Gm-Message-State: AFuF++kIBGcmcWTwTUStXlh69/HC1L78PYsrk0udws/qVTK+KacEOgUv
	WXPnDltqD6y4s5GIJqKGFARMxQaKYCSdoJtMmznhaZYVsXzTDdxwsz2RBhJfSdNs2vj4+AqgolQ
	qDHBnwqYJEW5FOJ7HAzCUkkjsQYB36m3+JQgttS0Ffuhp9Qyjq+pzzFgGCSo=
X-Gm-Gg: AYBFou3Za3X603PUqPwLAmJFP53GHN2E+lTljyg+3PIGdTLVJQPAF1RV/OdL0CxN0gt
	LAwSC8ynhmvfhf3JUnyGx2v1bOzTXnWxJTjAqWGK1op2CMmFCo/gZHN8Rb9sCuf6ISloCjrtzFz
	3UF+lYZRJYwNktG/ClNJCeEsphmBC+YzGSbv5bGcOJYMHMGA5TfiM20R1oQbKg1m929wzXgjROT
	WTYWQwYq13VH6eOSNjCI2kDJsnTd6515cJb1imyanfOUjhomwrB8QZc9+qTl2kJXm/qnirZEn7L
	T8NqzvwQy25knKIU68CVfxM/slKeq/StfHxftBP+aAzwvmAx3wPs8DeycoBn9R7EpvzvAM7ch31
	CYSzIJdul1A==
X-Received: by 2002:a05:622a:2294:b0:52f:9ed4:8d74 with SMTP id
 d75a77b69052e-5328dc332cdmr6577051cf.14.1789599627288; Wed, 16 Sep 2026
 16:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916202740.257376-1-zide.chen@intel.com> <20260916204416.80E761F000FF@smtp.kernel.org>
 <9e86d9e4-7aee-4c1b-8812-94aecb2a2cea@intel.com>
In-Reply-To: <9e86d9e4-7aee-4c1b-8812-94aecb2a2cea@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Sep 2026 16:00:15 -0700
X-Gm-Features: AcwNN1U_2KEbv3R9fl85zKM5PShXqTETnXpkgaliTf0CHIl7ssx15QBLDxbxPLE
Message-ID: <CAP-5=fVkubfWSoQbZRmC7Xg-4SHM-=ickZub7zi4SDuFAhZuCg@mail.gmail.com>
Subject: Re: [PATCH] perf topdown: Don't require config1==0 for a slots event
To: "Chen, Zide" <zide.chen@intel.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 2:52=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wr=
ote:
>
> On 9/16/2026 3:44 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Low] perf: missing explicit <stdio.h> and <string.h> inclusions
> > --
> >
> > commit 197eea3115a0d065dc53e6f96ad2fd38fdb9bc99
> > Author: Zide Chen <zide.chen@intel.com>
> >
> > perf topdown: Don't require config1=3D=3D0 for a slots event
> >
> > This commit modifies the topdown slots architecture check to no longer =
require
> > config1 =3D=3D 0, fixing an issue where explicit slots events were dupl=
icated in
> > scheduling. It also adds a new test to verify that an explicit metrics_=
clear
> > slots event doesn't trigger extra injections.
> >
> >> diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86=
/tests/topdown.c
> >> index 2b6f47ce49324..b1ce9f83db00e 100644
> >> --- a/tools/perf/arch/x86/tests/topdown.c
> >> +++ b/tools/perf/arch/x86/tests/topdown.c
> > [ ... ]
> >> @@ -229,10 +229,38 @@ static int test__x86_topdown_slots_injection(str=
uct test_suite *test __maybe_unu
> >>      return TEST_OK;
> >>  }
> >>
> >> +/*
> >> + * An explicit "slots,metrics_clear=3D1" event is still the slots eve=
nt and
> >> + * must not cause an extra slots event to be injected into the group.
> >> + */
> >> +static int test__x86_topdown_metrics_clear(struct test_suite *test __=
maybe_unused,
> >> +                                       int subtest __maybe_unused)
> >> +{
> >> +    struct perf_pmu *pmu;
> >> +    char event_str[128];
> >> +    int ret;
> >> +
> >> +    if (!topdown_sys_has_perf_metrics())
> >> +            return TEST_OK;
> >> +
> >> +    pmu =3D perf_pmus__find_by_type(PERF_TYPE_RAW);
> >> +    if (!pmu || !perf_pmu__has_format(pmu, "metrics_clear"))
> >> +            return TEST_OK;
> >> +
> >> +    snprintf(event_str, sizeof(event_str),
> >> +             "{%s/slots,metrics_clear=3D1/,%s/topdown-retiring/}",
> >> +             pmu->name, pmu->name);
> >
> > [Severity: Low]
> > Does this new function test__x86_topdown_metrics_clear() need explicit =
header
> > inclusions for musl compatibility?
> >
> > This code relies on an implicit declaration of <stdio.h> for snprintf()=
.
> > Missing POSIX headers can cause build failures when compiling the perf =
tool
> > with strict libc implementations like musl instead of glibc.
> >
> > Should <stdio.h> (and potentially <string.h>) be explicitly included at=
 the top
> > of this file to prevent musl compilation failures?
>
> Not needed. tools/perf/util/pmu.h, along with debug.h (which is also
> included), explicitly pulls in <stdio.h>.
>
> Additionally, this file already contains other calls to snprintf(). If
> the required header dependency were missing, those existing uses would
> already fail to build.

In general we want to avoid transitive includes as they are brittle.
For example, if pmu.h and/or debug.h were changed, it might break
musl.

Thanks,
Ian
