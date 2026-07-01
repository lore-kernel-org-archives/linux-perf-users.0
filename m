Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA0241325C
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782949167; cv=pass; b=Mt+OpEFYO10Pvf7U16yFljv5BTzW7GQSOKzHTTfsvh4UE47wRbfs3PQfJrtT4WL9sFZhA8C+i3tsYRpqFQdbvodHBW86g55uMl3588C6FYkuardxvuhHEWC1YpduVWQ/whqWnRaDqdcwqzEQLqLRehOTc8gIePGKc646mXHiKj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782949167; c=relaxed/simple;
	bh=wBiVX7//7d5FpdJPPde7ZteUsPCBSPvabOoQbgv1Rio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpdPewF8q4aBsUASbjfi73raOst4nAl3mEUVWy+yzgTnWEH3nN1F2AcLj6MD3nPZVKRwlgktE5oM/tLRFDbt1OGWiEaaQbW0U9/laz0A0uQmG7f5zWG0XEa3FCtgYVx1Ax6MobyBCKSiMeLHAHe4kreu1vtnOxMMqZ//uIDbZY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SqTEBs9y; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqTEBs9y"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ca597093c0so114565ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jul 2026 16:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782949161; cv=none;
        d=google.com; s=arc-20260327;
        b=m8q663hw0+iA2F3S64KEB3Iaia7q3OXYkqQREL6PYCRHmhBAAoKnUpuEJcn6wJyvZS
         PaDQ3+KUc18Z7uzUIiNZ8gtP5l6TGOEpXJCsh9y4Mvb3FT4sSCfLswlp8kFPiiHAVbBe
         vJr1UpGN8TdmG+cmXHrcdnl+ruHMY47PhafI0T4GjuIly7YkX2T3S71NfHs5tQTrpfC2
         Or1WDib7jiIqmQEbdq8n95J9GMtFQFN1RSI1gWAW0TD1aDyGEjB0PU8DDPhshY21PTMQ
         sMxTe0EdfIM7Gr7XiVrFDTYDVzdWR7netXG753+wbj64ohQiQTCKEx+FR5xB41iyvrA0
         JPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8vJZfyauQpukrkEtThsHmEBFLpG9IbxDLY1laSveUSs=;
        fh=JFquZaYI9rEdbBWUD0O+GYwx6DYFx1LOuG6yqQZsPiA=;
        b=Y+rcT7LQxul494/hyH6qqyAAmC9Wx5Alr2l+9k5PHYbjzFq9auYmzH1eXsiMtbA/gU
         iodnMoBVRV60Nco2CMj74rnLvEClO4LYS/0uFMhu9OkAJ7LOCwF5oRl6/PpdGy5ag5UZ
         OKiQdhe4kAYVVSNfHdvgKwYRenSoDyS99Wv4gCyV/fbRtegIDiLO5kQyGLbh3Xf2VYRI
         iuxwGfgFi5MSFRfL0EElcUjYfk+WEPPMEAd3ud+2t3Hk09TLattl+72p8uPiEsYlvuFQ
         euWCqGOb0flF8Zwa8fjHvLorTsOYSe6XierlHOBQHgjoppklSI1yQrNHE/3KnHgV/1sN
         ycmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782949161; x=1783553961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8vJZfyauQpukrkEtThsHmEBFLpG9IbxDLY1laSveUSs=;
        b=SqTEBs9yQ7+8/cK9csIVEZyhSkOw689OcJYVtDPezruArCBZv2sV2xBDD9ShrcrTI9
         n7HEinxtxY6XaQPnrQ09TCvoxoiempmuqeFOAhbnpp5gG7xDk9gghvxjBGgt+8WZ0kPd
         bCvs3nr0NU8BqF1VTF5lNFP1aggovtJ5UjgyjCwDYmJmVkzgcajiEDRqTyTtxtsFaDzV
         t37tqShBrfkJJal5YMxnKbL6QZRy32VR4rKbOzxiQ1scaWOyEY+7Du/MsIA5s3Kd/958
         QhKFjfmtlYpQHfQOoCb4/nLooOnrc4+0FbtsT/c88/MpEjHh8CIa+cSZqJ65u1+zbOxB
         yRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782949161; x=1783553961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8vJZfyauQpukrkEtThsHmEBFLpG9IbxDLY1laSveUSs=;
        b=a3bhQcTCxBnZfDV4VgBt7iAWs1e0ssME5qWw/yuc5ysuCjTtO3A1xSYIjj9ui75NeA
         mNbTVkxjxgx1m4b3xjsL8LjKRAv1VgW1CwY6tvWU+N8TwRvrxCPu9lUO+dio9ALdsj+j
         1pRLkL8nICgdvSBJMRwskR1Ut91bxQ7BcMYln3eNJQjx+HdATjBbVResdSOBO38D1DdC
         +1s0IPkBdBhK7H9kPxG+gvn14GFnaY9Cc707y3+dVbjDGyhDSKju+EpzipvNvc0bLBhV
         zjfc0OTXYxy9znTGTsOJHzOl3eKzQLZRH9S0JEvprMNuGje7zg8vFjwWA3esQG/v/rMZ
         B/aw==
X-Forwarded-Encrypted: i=1; AHgh+RrpTk2r5hzaFRIlop41cdZpB8PLnp9fHK9krsmVlEec3i1ecoLlNstV54BToz1ObGv05knJ/tOqZ5mU98zuvC60@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEEfjpIK/ubU1/bDtVY61/OPPIsBJegVRjucW8/1YxiPLrqMR
	8RY9s7TMBmENV1UTnsLFgkhBOoXK9frzHOiIUcT6S3oRm0aDZjNeTUh5KGkLfDAHKEmCcdHsd+x
	8PZ+j9nXiXxl9O6EN91ByS/N36f/nK7RRzPwo0rz/
X-Gm-Gg: AfdE7cnZq9ZQKToyUtLX1cL1THeaDQN9mch/zhiCCfZ1KkNekKtdMXqUdL6pN/Os+Y5
	e67FN+FwXW8Do3Ik+2kRjaocY3XxUEeBC995mQ+NKylJ8B3lLqvPK7C4mjTvEvgB/s0kQwGKoJ+
	2yT7C7uexr8WRlEPMWe6/q+fEXz6Cgop2j8HnJO8o5xn4HU6wYVki/1DKqP7rJ1l2AiUGrkMdgi
	+W0/zRAeLmyJ1usQFL16wD5AAynnr1JsNNdEsJW2LF/83fI31fIdgClorQeHdPjG3gLsyTk7A==
X-Received: by 2002:a17:902:d58d:b0:2c6:a078:bfb7 with SMTP id
 d9443c01a7336-2caa3fd7219mr331835ad.7.1782949160763; Wed, 01 Jul 2026
 16:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701182824.347941-1-namhyung@kernel.org> <CAP-5=fUzfFkErqnDp4iJEgCQdAO1pFRKMKWn3mhEGK5z2qZvWA@mail.gmail.com>
 <akVqvG7amtP99cmE@google.com>
In-Reply-To: <akVqvG7amtP99cmE@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Jul 2026 16:39:07 -0700
X-Gm-Features: AVVi8Cfv5s6XlbfdkzpF2x1eVFKbgorbhUHM5we_i6pr9mPMg2rAC6YAdmDWdeI
Message-ID: <CAP-5=fXUzEzFjLoh9SuNSch5=NdCEAkw4Dx-+Xd883JKVGV65w@mail.gmail.com>
Subject: Re: [PATCH] perf build: Fix compiler errors with old capstone
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 12:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Wed, Jul 01, 2026 at 11:49:03AM -0700, Ian Rogers wrote:
> > On Wed, Jul 1, 2026 at 11:28=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > It seems RISCV was added in capstone version 5.  Unfortunately they a=
re
> > > enum constants so cannot check with #ifdef but anyway we can define t=
he
> > > symbols.  Let's do it using the version number to avoid build errors.
> > > It'll fail at runtime though.
> > >
> > >   util/capstone.c: In function 'e_machine_to_capstone':
> > >   util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first us=
e in this function);
> > >                                   did you mean 'CS_ARCH_SYSZ'?
> > >     186 |                 *arch =3D CS_ARCH_RISCV;
> > >         |                         ^~~~~~~~~~~~~
> > >         |                         CS_ARCH_SYSZ
> > >   util/capstone.c:186:25: note: each undeclared identifier is reporte=
d only once for each function it appears in
> > >
> > >   util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first =
use in this function);
> > >                                   did you mean 'CS_MODE_MIPS64'?
> > >     187 |                 *mode |=3D (is64 ? CS_MODE_RISCV64 : CS_MOD=
E_RISCV32) | CS_MODE_RISCVC;
> > >         |                                  ^~~~~~~~~~~~~~~
> > >         |                                  CS_MODE_MIPS64
> > >
> > > Also note that capstone renamed CS_MODE_RISCVC to CS_MODE_RISCV_C whi=
ch
> > > would cause a different build failure on latest versions.  It's repor=
ted
> > > in https://github.com/capstone-engine/capstone/issues/2977 so I think
> > > they will add compatibility layer to prevent the error.
> > >
> > > Fixes: 12c4737f55f2 ("perf capstone: Determine architecture from e_ma=
chine")
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Perhaps update the feature test from:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/build/feature/test-libcapstone.c?h=3Dperf-tools-next
> > ```
> > cs_open(CS_ARCH_X86, CS_MODE_64, &handle);
> > ```
> > to be CS_ARCH_RISCV? That way we won't detect old libcapstones and
> > avoid cluttering up the code.
>
> Then it'll drop support for capstone version 4 which works fine on some
> architectures.  Maybe we can add another feature check for capstone
> RISC-V support but I think it's better to define the RISCV symbols here.
>
> What do you think?

Arnaldo and I also discussed this in a thread, but I can't find it
right now. I believe the RISC-V support in libcapstone is now 8 years
old:
https://github.com/capstone-engine/capstone/issues/966
so it seemed unfortunate to add shims to support older libcapstone versions=
.

Thanks,
Ian

> Thanks,
> Namhyung
>
