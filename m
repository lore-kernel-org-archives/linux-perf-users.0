Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795243547;
	b=3IBq9sXw+rGROwEfOdrDoyM3JwFlZv+D20fJ4wn4kbX/fVunBPmSiq8G+j4R/q5CPnjL
	 UOwxXToWM0MG5kNiAaxq2m6196QpP2AcO9adJ+xu+eicgR5nxzYTB0Wzw0NcN+oaHTzMJ
	 Gb40nf+QaJPpIrjLTVqnewBhTAfzNWzib06Uz0x13Sr77OA1JzO9PxrerAJUC5GiKmk6m
	 olz6aYpD7ubl9icqTmp/dI3Y1GYIdBkIbnDkXQ/6Z7E2SfqsJeJowj7+T1WYkgWS5XY+W
	 fubh//o4w2KY7vsPzS3k8D1wfzXC2n12j6d5NAFEgfPYnvA0ujZu4U/pQ41t8u4tHtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795243547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iyUW/gQgK6sLuAw1qsqOpPSq/qowOpiEcwfea2zJOWY=;
	b=GOXYrGWnN4BcEZlNiuzXPh2nx+qFUvlurAl4MMx3PXi/oPSwmrJ91Z/dtz1SYcBWsCo4
	 XLEb2xxHdYKc0Lzr/Y3GePW0XQkXX0RW5ox/9NjEz7JxLIe3RVrvrgzMjoIA+yB9Q9YoC
	 Sy9JB1zcQoX53J8g0UCGH5+27su/QR8uJqO95Xv84bmsztj2emo+XABTW849H19TeebS6
	 vMTWTtvTL5tThTgQmufytWTqHgPoRNCYpTloB4xmD+K4KFJe129NHHTDjQGWStupQtslO
	 pAizbHWaV71FNnBOylPdtiWpTtC+EH0PmB4qdeoCEtmby+1rJuX/UjTglLeA03pIfbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Scq+rGqM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2DF606A320
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 06:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE2DF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Scq+rGqM
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-55be673e029so80311cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:45:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795243544; cv=none;
        d=google.com; s=arc-20260327;
        b=MAm5KByX4ItyEuGxk9lTQDqeJnrU/MsMBycUwkd5qbMRVVsOUmh+NBtrYRtodepr74
         KtlcWDm2vTGsM4gfAH0rqwgRNLOmoOuLKfqR3XI9YrKB8q0nvLuflWKI8v5M898nVZLG
         ub/zqJA3aCUWtG6PgGkhMDZk/g8iiJtqHqcwdAcWGA4oKPmbQU2UxXYMorl6HWatdndA
         YX3rApdFFSloIQJnLX9M+dNfj9Pj/n73K0ZnjgEC/vd7QNBLJ+0UA+Ekt16Q+yg5yAWg
         ViCid6FXQzVxlaIVBrpr0Crk7gLiC1/xirWhsWqL7Y58jWJ8QISErsM+xpvF1fyPKP2C
         ftKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iyUW/gQgK6sLuAw1qsqOpPSq/qowOpiEcwfea2zJOWY=;
        fh=lT95JiwO97YZ/a0rca4XXJk+SZaDA18kUnyd5GYYLME=;
        b=LWrSW86kk9waXwt2EXKeno2tlc2bvfzj3xnWWtQsGBfW/oRhs5VpqnM/HaPKLulurn
         Tn41rxh7HX0jZRSZDVzq2Rct1WZo69T8hWj73CyL6A5sIr3bH/P5Nt7+bRWwvdEHRYT6
         ODCmc+qgJS8jmaKCQ5ARM8JDF89Zl6dOCQ9LWTWvDqHZv1iwqYd469jLjsYpwg26/QHf
         NOg58jMF8TLNoJZqPfohDfdKjpT+BH/T8AARDXq86mr/SDXf3mTb3409XwrUNVJnY1jj
         PI29qpAhism0E/UPHOX/kScLE5Cg5lVQ5jEKKlLasQCtM+WC6hNiMSWnFUtRQ/+7upbP
         G6+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795243544; x=1795848344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iyUW/gQgK6sLuAw1qsqOpPSq/qowOpiEcwfea2zJOWY=;
        b=Scq+rGqMgjH5HvW1o8QNBcQd8ROgCAPIjtciEEDHUXKDU6H//hWWcDXXVa3kFxUNAW
         KRdLlMav5f6WM4wWJFB6MZgmNhHvEFzZ4t3BdyD38HoUapC+T2O+YNfydNfPNhNejIbI
         iUnMn6wecMomnkQ5uhrzmii0UJW9BOq2nAtPFnEqTLnBr4MGNb3Btkns2hpHvazS6Nan
         aFmw6Mt2+srHc3wdcg5x/g9zzz7bBOjP/RHsgcsFSI4pC0OPQl2wZQFWxrvKegG24hdm
         ZISGveilcdcJ0SEzDr5Yv1WiSBeDhdIzgmMarnooUL39nIwXpER1uol+ej8mkrl86J7Z
         sWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795243544; x=1795848344;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iyUW/gQgK6sLuAw1qsqOpPSq/qowOpiEcwfea2zJOWY=;
        b=hQ6aF/+bKAs8W18dEdIQQx0J9EKLGAwXlskf5i+KyZDHhXlIILr4HhaI6grH4xCbNa
         1pqR4C78WN8W5vAnYhBO7gTrwdfbEGAG1uZtYVsksSwNCq25jyTw0uBatMhQOc2JSQzA
         XxYITImkXMFlsEfyyLC6A3BGIakw2sqbb1I6QLLqT6Zc1m3VWgY9cAvPbci7skO6ug0g
         pwHUDCi8Rb7DUlaxUJQZOGnTLujnRXgi8/qcp2eifXUT3TsmW6KZ7o+r4dXpYJYXVd44
         8fhpV2yUKgHZW40gLJyud1YwVAO9c2vRbW5xZbW4JovKFu8U+mZTGRp2qSebwuqwMtqI
         POUg==
X-Forwarded-Encrypted: i=1; AL+hErG8NDkNsIlf+nirzncqT4BuILRanhlfSNEvS71vfE7oPZERkqGB7kyltp9Nkt9JAQTgxiofRCIzDsX7cXmQd8TJ@vger.kernel.org
X-Gm-Message-State: APuU4Z8pe4f/v3i3JSa9ltrTgivdebeW8E+7dqSXHsaOEi9Jm2vbiudV
	NZyOxdHoCBiAToGWvbYhaHTF5DxTzY+FgTEZDDfcH9QBSJSpzjqpcEzk40XnOpJXXtpFVN3S8T/
	omDe8thbFYyLOtSC9QDMsF5ue2BoRN92e73If/jNw
X-Gm-Gg: AZFdTZfuhEiAF1/mslv04h96ERjgtovTY/bDU7EsVxfj9T+Kp0sFYalGCKVJM9IAGa/
	UCvnrNNO6x+C5ijiWbX/wjLNpHkyRccbQ/ai0MF8TcHbhNMP9EceLrBoYW4Pgn9UplZKDL+K4k6
	trTTwqeJj1UM2DWrOZxitHHucV4/qikdadrgQpwvUhuWj7VAEEwJGRUq0qfbHpPlgCrNukbEUBl
	IjBZHMmT1EsgcnNFSUGHnQa/9O9WFhF3qTGy/fMKsnBqhfobgH1GrbKfU3mTpcEW1dZnHABwtO1
	o3umFmN1yaYU1HIICqq0HI8Mo4yFPYM9vmZJai2dWGWSJthKQ3yyldxwcIiTJ6KmP+hzLtnPOGB
	stEaW3AiRinlP2VvT+YT4B5xHnyfUIWJR4etMa5sb28nuknPpYuV5PYKyKw==
X-Received: by 2002:a05:622a:2598:b0:533:9731:f0f1 with SMTP id
 d75a77b69052e-55d890363c8mr7906391cf.10.1795243543244; Fri, 20 Nov 2026
 22:45:43 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113164152.2095566-1-irogers@google.com> <20261113164152.2095566-20-irogers@google.com>
 <av_bvJpYwwMWNfDt@google.com>
In-Reply-To: <av_bvJpYwwMWNfDt@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Nov 2026 22:45:32 -0800
X-Gm-Features: Aa3M54qyHKFYs0sdnXs9w20kZO_6DKZ1sbg-cIz7ng-wQJ7TMSYuLzSPX_ox-F0
Message-ID: <CAP-5=fV=DxVPn_wQGuFD8FEmz0n4kXQLyYV7aTc53-HoUp=NeA@mail.gmail.com>
Subject: Re: [PATCH v13 19/21] perf maps: Fix lock inversion in maps__load_first()
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org, 
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, ndesaulniers@google.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Nov 13, 2026 at 08:41:50AM -0800, Ian Rogers wrote:
> > In maps__load_first(), take a reference to the first map and drop
> > maps__lock(maps) before calling map__load() to avoid a read-to-write
> > self-deadlock when loading kernel maps inserts extra trampoline maps.
>
> It seems this function is not used anymore.

Good catch! Commit 553d18c98a89 ("perf lock contention: Load kernel map
before lookup") removed the last caller. I'll replace this patch with
one removing maps__load_first() in v15.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Fixes: e77b0236cd0c ("perf maps: Add maps__load_first()")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/maps.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> > index f808df2fe77b..7ca33e5218e7 100644
> > --- a/tools/perf/util/maps.c
> > +++ b/tools/perf/util/maps.c
> > @@ -1459,10 +1459,15 @@ int maps__merge_in(struct maps *kmaps, struct m=
ap *new_map)
> >
> >  void maps__load_first(struct maps *maps)
> >  {
> > -     down_read(maps__lock(maps));
> > +     struct map *first =3D NULL;
> >
> > +     down_read(maps__lock(maps));
> >       if (maps__nr_maps(maps) > 0)
> > -             map__load(maps__maps_by_address(maps)[0]);
> > -
> > +             first =3D map__get(maps__maps_by_address(maps)[0]);
> >       up_read(maps__lock(maps));
> > +
> > +     if (first) {
> > +             map__load(first);
> > +             map__put(first);
> > +     }
> >  }
> > --
> > 2.56.1.703.gf848ed807c-goog
> >
>
