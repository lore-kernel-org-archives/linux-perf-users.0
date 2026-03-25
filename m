Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8033ECBEC
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454844; cv=pass; b=IutsjXpzCPX5krAb2upfC94ioQkgNRUiy5iDat9DGNjWAuF1KoBc8A++dIVvQb0mmDhkpRuw54YdTe+EiBcif1QPv5DGtFjy2se0pKDQdVrJCvi98pUbyy/hrUhP0da9mCsNlUk+4eW/kkTcztUu9FFOr97v3cKLNg5HkiilR9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454844; c=relaxed/simple;
	bh=+TlSawzrUCEFrje9gFkFM1DQjUB++zubEu1+EbfkAcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1WZwq/l2SH7jn8dRi/QpEjuvzdxCo7ObkYUH5wkTNTs/s4jz5tmFsP7wOm91KG7nVyBxxjDTroxcR9yBXl2nTcCjdGX+egOJSbhgNy1C/3Dfsmc/Tb0F6tCJ0QVPq+2oII0SZ6xnEx3TkbxXgetNdcD2sdMoMP+NiyvfJRVmsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jWZ9JMjF; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jWZ9JMjF"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aeab6ff148so90315ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 09:07:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774454841; cv=none;
        d=google.com; s=arc-20240605;
        b=XkkMkN9g7DoP7k2slN/1W2wTBXkZ4wslbUmnCqdf/njT3w1u6rEVJdaBmFsHwRVAfY
         kC2aX8gI2aiWdvsDwv6KDd71v59SpR8MykP8x42ozmnweQz6RtrcdAIm7ixPcg3TCN/t
         /8eD9h+i3bg5n3vhkn6RBe9vYMoG8gYBJE0PR4y3eKhI1aBLihOA5kD/zw1gMyQeTfmT
         CU5I6VpEspH1UtizBSguSL+BlaRGYQbeXaGES0mGW2tK2UuGgofY1vziI5UIsv7cEi8B
         iWt2OVxdW3oeNvtIIqWksl6JswY3BpZTTm0sWLuuLQ8sBq/MpbhEv7x/EnsLhw+YeE8C
         63Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jpc59Bl45IOqUUdUCotXNn+3s0ylV0qX3zLSq5VPby4=;
        fh=7Em9BhKM8ycl34kV7y9HK06iW9QDh4SXzI7Zx39Zmkw=;
        b=BKdMdQKGeM1iC+kmwxIvDzaLt9Vuu+fR7UDP2GAvc1OsuCE29zH8zS3Z4viQyLymWQ
         6QDCy1kA4IweMO134RY3sOWRdqryd/18yPIh5Vu1ANGi2U00DzwmyNxylFwOSqpuUjiI
         3lq5AF/Z6gWbEcS2sQ4aHaNl/1Y77pyj3sKkui4oY/zvJPpdFDQGNRGfkOQdo7zPcf2d
         caIfBL7NRZ/t+11FHTtMCwc5Zz77P9FpdVeGryIVVTMI8lL6aQtGIWPs7jLeOkmSa340
         MBFrRtnD1RcRRkEguXN+lSAbK8jjYGMuiha5MtOsE53U+ElhnMm6IzFBjutXckkT7f3V
         CN7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774454841; x=1775059641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jpc59Bl45IOqUUdUCotXNn+3s0ylV0qX3zLSq5VPby4=;
        b=jWZ9JMjFrVQRhrdTgWFiJ8NEwPvDs4qseGD7+YBhv17yjsShoVpkAjakvW12NoitJj
         a+SnHtv53vCbZzr9g8kXZjyTOEc2euZnNcCMYUqoVbC8fDcwAyGlV5lE0WBl3abieZQc
         54vWWG1xwR7EzFSxTJmzNgLrbhU1Lh04qG2C3RsJJF+f9FbKbBsY0QVGpqxuGJLmHvZm
         xI/XR9GihJ7A21lMQQlm9SzGshexmaruOJn6OmWmoo8p427ORPm+pRggQhwE0I4xBnGV
         NmTTsjnw2n1AnwVSX8tQhOCueoLZUt0oUv0AK7k/MFqCTWR6K6DJbCInyaPNyzq/4xGz
         0W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774454841; x=1775059641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jpc59Bl45IOqUUdUCotXNn+3s0ylV0qX3zLSq5VPby4=;
        b=mU+m49FUnT2TYDe+T/IJ4Pr12SL1PEnqnaoDzGDhYWumWrdraSPTcSiH7tOmUXCcEt
         LqtzsvquXDJlQTjvQUNfMlHJkGyzQdjOE553tnumNxz+4Zzs4r+YbBMVZ1ja49pYTPen
         4IPrPeazL4avfXzCA5iadYNWaw5EdYLDba9Ox/wdWR/s22fH7GzpKnYInZTQLHfAvnCT
         GT4eqw2JJn0NJY8ockdB15fFtCiYlu3oH4+Np9sNYxRs+10OQhbqLzUHeHUtrAzWXiOS
         ax80cX0RrRHnsTYH+h4Ig4oZ4EtIIonwyyGAW6pzRvOqVxhKjGJ4P2WCvEi+KQBDQwW0
         7bpw==
X-Forwarded-Encrypted: i=1; AJvYcCVopNbSAFbRl6Q5HaJ5AV8yX1hME6PQ+kQqnf55Y8TOna1gvjAqIkX5BlrvnQ6o59tDb+/FPvFtmmGeK3lMaUVX@vger.kernel.org
X-Gm-Message-State: AOJu0YwlakGJKeWj9qT+Mt/EWyXbrii0Nbmj1i5M1lKoAg0QLdnx3Hww
	yIHppe01x6pAZfESCbOVL2Bv/aX+vc8jxt0T0eldy3KFFdHDVgIUDJ/eOcPhSLKOseRA1JMk4UW
	lrUOUeAl/2vE54B57mdSanf35aImuzd2nIfs5BE4J
X-Gm-Gg: ATEYQzwwQorjPNlxBTaQKGDkWoeQ6Eqk4wZpWqWXmB2heDS6yeMZt6Ni465vzYl8kzl
	O9/HH8yHGNtpsuvy9CksOdOZDV+jK2smO44wRuZm90Y2stvPpXECSL2kCbZhKcY8ofHWRPC+fcg
	BMbrFxfAi4tkEipliLmKa38S6Y3P1Y8zK1Vbg8ZJYuNPwmpbSmOYuWYte+5Z4chr7pwHfIAiuQ+
	fBbsit7WtsHsY4ubpzdJfDmU8Z6waoVwLQDDmy3ceG52oPOtopHVUYtQMq+ZnjhS5dljoWliuKD
	y3FqjB/0NZDFTplKRpzTmq0WnSFcFLYSb2vuOA==
X-Received: by 2002:a17:902:f541:b0:2ae:c7c8:f46 with SMTP id
 d9443c01a7336-2b0b15e46f2mr21905ad.18.1774454840815; Wed, 25 Mar 2026
 09:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323085255.98173-1-jameshongleiwang@126.com>
 <CAP-5=fVdxJxSAYyAoS_UVxQqOtS1GrhHphEag=Ksb2Oc+NuCGQ@mail.gmail.com> <acOJPVxR7MRLE4NW@google.com>
In-Reply-To: <acOJPVxR7MRLE4NW@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Mar 2026 09:07:09 -0700
X-Gm-Features: AaiRm51zN2G_cU0Iw-R4KMeYBWtO8v1tJnlUmMV9D5hI1kgGixRwC0mgJ2KlgoE
Message-ID: <CAP-5=fX8QmteodkvmaE4baJdw=wwWWN7+_DA3v8C95BJuN2y=w@mail.gmail.com>
Subject: Re: [PATCH] perf symbols: Add 'intel_idle_irq' to the list of idle symbols
To: Namhyung Kim <namhyung@kernel.org>
Cc: Honglei Wang <jameshongleiwang@126.com>, acme@kernel.org, 
	Thomas Richter <tmricht@linux.ibm.com>, mingo@redhat.com, peterz@infradead.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, ojeda@kernel.org, 
	gary@garyguo.net, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 12:05=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Mar 23, 2026 at 11:35:05AM -0700, Ian Rogers wrote:
> > On Mon, Mar 23, 2026 at 1:53=E2=80=AFAM Honglei Wang <jameshongleiwang@=
126.com> wrote:
> > >
> > > Commit 32d4fd5751ea ("cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE=
")
> > > introduced intel_idle_irq as entry of those with
> > > CPUIDLE_FLAG_IRQ_ENABLE, say, skx and icx so far. Let's add a new
> > > one to the list of idle symbols to avoid noise.
> > >
> > > Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
> > > ---
> > >  tools/perf/util/symbol.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > > index 8662001e1e25..7cff66e7ce06 100644
> > > --- a/tools/perf/util/symbol.c
> > > +++ b/tools/perf/util/symbol.c
> > > @@ -730,6 +730,7 @@ static bool symbol__is_idle(const char *name)
> > >                 "cpu_startup_entry",
> > >                 "idle_cpu",
> > >                 "intel_idle",
> > > +               "intel_idle_irq",
> >
> > It would be nice to make this an Intel specific idle symbol. I sent
> > out a patch set to do this:
> > https://lore.kernel.org/lkml/20260302234343.564937-1-irogers@google.com=
/
> > but there are no reviews. Perhaps we can follow up that patch by
> > adding this symbol. Arnaldo, Namhyung, wdyt? I believe Arnaldo was
> > supportive in:
> > https://lore.kernel.org/lkml/aahC-zp56irr5e2k@x1/
>
> Yeah, I'm ok in general.  I've left a comment there.

As that patch adds:
```
if (e_machine =3D=3D EM_386 || e_machine =3D=3D EM_X86_64) {
    if (strstarts(name, "mwait_idle") ||
         strstarts(name, "intel_idle")) {
        sym->idle =3D SYMBOL_IDLE__IDLE;
    return true;
    }
}
```

The strstarts covers intel_idle_irq and that change will incorporate
this modification.

Thanks,
Ian

> Thanks,
> Namhyung
