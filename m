Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793137060;
	b=cVF1ImTfxU1GRYl39mti6IIUX3g8Oixw1cXOha9QZkG4MI9Gxm3Pgtd2Z8y8lL1z9nz+
	 uSwBK4MPYCWa6MTjvm2tZ8XmTQr5OnX/JpfXAIwGtHOQzXrD5oVVz3Apk/y6P3URyoNPr
	 Wr+Fy/6aSgbyL1nb1E5SsnmVnDPdcRUMxrdsdSUgurtsMoqRMHZMF+4yAYuo6mlZT5AE2
	 a7RSdH5kcLY8yS16xNBfPLWzqrA791w/qAQNrNI3jjWZepNEHQBG2oOKGM1EZGoKNk7ya
	 /IARVf9EAEGhsax94HSGE8MA9tbrdf9gQXxMSk8/sCJtaO3l7+b0Pqcf/XhP2T24WSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793137060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kiQeK4YjfB9mchdkYNVdndc2lj3CRJ2WEHIAVlUrnYk=;
	b=KFx/tmHfxRaONwPk6DqEc6ClFcdCcEV8M9CoDK1x6ulgeMk+eFAE7od+K4yL5tASZIgD
	 OFmpTAfBLZ/puInZx0nFOTVux6R+U1VAA4PFtXMGMnTRFNt0Q55+4A6TO2B6koXPbXBbw
	 wgQDlcCUy10fKFBYTExrfAeyXyv9FjdfSdOxCSXAdSZKKVVU149Mfv8uviTcIao2maZJM
	 X7O1l0zQV3pWX3XThiV5UuULEAbzIr/COfyrI6T5dVqPaWhi1HbEyY9l4es1DQh4MtcdK
	 eVazslpi+mt6AbObr0G+OAanNJP/8p2Vs08Rjj+5Fms52bYb4kBQKL/1kUVc0+jgEbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JDpJak+h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66C606A31A
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 21:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF66C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JDpJak+h
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-535f598d126so33731cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 14:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793137059; cv=none;
        d=google.com; s=arc-20260327;
        b=UybeoffkIJXQ7/I4PzExq4OCj3POZtQJ37rORWcTSEg2Np6qcL9wCk4T8ASEugJfkp
         8tpH/CpY27z1PSElKNVWn6MMKCeevGFO9eyJX3VxxjAHBv7J3knqRLItyDYkm/rGf7JZ
         xxFutsiQEciNutdEFMVxodvIJsbaRj5owviHYrZ2nxeNjPT5yHswV4WFqVYbUos8iTXi
         MhztcbyOT7OEL33rBn86ddpjuL84/Wgh01VeK0upU52EjcwNOBg/KyDc1Ue0rn9DZ3Z7
         15TAbt8itvRSkWhzpEP4J1WHt0fVBlCLhsrZzKv2nvQbsuLU25oOFLKaQU/NW5DtmBUK
         1HdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kiQeK4YjfB9mchdkYNVdndc2lj3CRJ2WEHIAVlUrnYk=;
        fh=gV8YRCizNor9qf9YqkfD6ouRyeo8kArNg6FIzxgURfA=;
        b=AhWBoVbzWfujLJZ6sZz8iyFxXdXlkfrC1XpsEG2Sz7eDlkpQq0uqExFuTZe0uJldYb
         cRYQ+xA0gn2VG83BNs/tJXvYVyyZIb2c3Hk9IYlKdYch+Lkq/QX/AWnPOl2yX6meNXJ7
         OwkJpjdp+jmAMf/lLA1MMSGvwLH8WqF79JHvOWCKNbdF36wotXR5emeB7XjJV/NMFiem
         vilyXXV6GCvLLUOP/dw4VTExYl7dbQSxSZy/OXD4OUKzXTEor7zLpPRpFG8O0ppGQnC5
         3/w8W3NzOQoSAaOITmPTlDkfPYMGx4qRAUizKjkzcQdFqzFksx8zKlwDqKVsWd59HAOF
         /6cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793137059; x=1793741859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kiQeK4YjfB9mchdkYNVdndc2lj3CRJ2WEHIAVlUrnYk=;
        b=JDpJak+h3CJc9jWlYYIY7KSCuaoOLUxMWzUAjOfWUeOlT1eC6LT+0QCYEmnMeAkJpM
         G35ymoC2udf83stlhT3e4153oAGewdADvuwXbPFmNCA/2c3xCJfpV+2Aa1hgT7aFXyxG
         2gKLkj17NB7rMyswPgVDEYtjcTrY0Rw1illHWe8LMPXkF5Gnlo0EOqL3V838hoBoCGQU
         sq/2F+RLJGPKthz9KxA+eajsJp2RC6HQyES1gJ0C5rwv4WOofM27yLzM01irLrYjPoei
         iNwhTw+m+/sxGWmX5R0sRkwOVidG5vEPDReqgN5b65xGSJ+bqSxTy3iUAZkralYqpjcL
         Z09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793137059; x=1793741859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kiQeK4YjfB9mchdkYNVdndc2lj3CRJ2WEHIAVlUrnYk=;
        b=PYUbnnq+H+ZR2QyPF3JEMHv7lkLF5cVIO4d6U7E/f2Prkmjch9lLKsdowrniFkVax0
         O9yHtlng/sLkd17CYxxL7fDSSytKbblNFba3fobarilNLHSRs2ULMoh0lzFpa1jlfoZT
         GVmc7YQRSR0QtiZQ982u+EHJYDHKNQZfTYwGhVqLEg667NBYT18ZoZ4f33YMnRG3R5yq
         ++2lVKvFEAwW8eT79UqgK+j9eNDfLIGf2ZFIlF7ot3Y06vbIBL+j7FWxlRnvbefekUsA
         V7xFlCK2pct/J5A4FlkrF8pMc6e4AK3yVtFbEERG4ae59zjzWPYJYfSrQMcN8TPhj4oi
         zsBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbBlW9QhQMqxT3Oe/XLiPFXZpacAodXDCh0mSJYl/08ZMIZXVozliF/F2dDyZgcxLK+xcVNuD1N/dbq5ZCetQP@vger.kernel.org
X-Gm-Message-State: AFq9FYK50+GFYrXiWDdNYH4yyqPsepUm99VIwpaiXk9cVoW2bm6jzAaL
	BzDFKJFojQxnn/LMadXzmfIjnDC7o99LQ9n+heotxhJK5ZNGDiMEthAfOXjT8TSXkeluOKM512v
	w+Am0w1/jMA/nlJS/4X+H/gO9YGDEQ6eUtJ/U4LJQ
X-Gm-Gg: AYBFou3Ttk3ePDQ+l4QeeJaiVmSQllRn4lGO+REft4W37MTKjZpo6E4KzYgUoEFGY9P
	bM6Se/vLZXe/VjHjNLtc2cmvsyvdN6JvOiD4J4y9L11BHqZiayYgc5ZbCxg9sGKvhTx7Ro70lQf
	0lY/HOH+SAIhd1FENa2LJIUjvRgm7M8XV1pk3ElpKgQbYo3a6NHhZQtyq/XwqZTxy9mkTYKiBi5
	u2PQcDHD4vN3PdHpAoVeryUPGgh5P5WixbWsjI8vlB75HPIXWwYwms9bKAn+siPND3BtUZ1c7nz
	uVK7H7sYkTEzCUOF0NzipTvSAwqRjdm41GYdU7AmQ1ZEBWrNxSseZZM/c8V4yMqtc20EeuyuTSz
	H/sm7aYVkGMfe8OL1L9nvY7bWgwLWsmdzV018u3JAf/72DJaKwi9aAMPTc6BmeSs/gA==
X-Received: by 2002:a05:622a:4d94:b0:536:6ae9:f55f with SMTP id
 d75a77b69052e-53fe254cd4cmr2738151cf.7.1793137058168; Tue, 27 Oct 2026
 14:37:38 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021224527.167637-1-takano32@gmail.com> <auEK6E-jX12Bi8u_@phoenix2>
In-Reply-To: <auEK6E-jX12Bi8u_@phoenix2>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Oct 2026 14:37:26 -0700
X-Gm-Features: AclHuK8R_WnqIcyQf8f2Qu5VxrU9TQxGN3EayZGJ9XRhsISfCA_QCGKlSsUCj44
Message-ID: <CAP-5=fX+2eRGCHcU43sqU=gi9iKvxqyS6ipwRSnvFcap3D+QzQ@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Drop stale
 BPU_FLUSH_MEM_FAULT entry
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, TAKANO Mitsuhiro <takano32@gmail.com>, 
	linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, 
	John Garry <john.garry@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 1:34=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Oct 21, 2026 at 10:45:27PM +0000, TAKANO Mitsuhiro wrote:
> > AmpereOne carried BPU_FLUSH_MEM_FAULT for EventCode 0x121 until it was
> > renamed to GPC_FLUSH_MEM_FAULT in 10a149e4b4a9; that rename and the
> > AmpereOneX table were patches 3 and 4 of the same series, so the new fi=
le
> > kept the old name.
> >
> > The result is a table that names the 0x121 counter twice:
> > ampereonex/core-imp-def.json has GPC_FLUSH_MEM_FAULT, and
> > ampereonex/memory.json adds BPU_FLUSH_MEM_FAULT with the same code and
> > the same description.  On AmpereOneX perf therefore lists two events fo=
r
> > one counter, one of them under a name the documentation does not use.
> > No metric and no other file refers to either name, so removing the stal=
e
> > entry cannot change a metric.
> >
> > It also leaves memory.json holding only the ArchStdEvent aliases the
> > other files of that kind carry: AmpereOne's memory.json has no raw
> > EventCode at all, and neither has any other file of the AmpereOneX set
> > except the ones where raw codes belong.
>
> > Nothing catches this at build time.  jevents.py asserts on duplicate
> > event names, but x86 repeats an EventCode for many events because the
> > code carries umask and unit bits (3756 times across its tables) and
> > powerpc repeats five codes, so a duplicate-code check is not possible.
> > arm64 is the only architecture where no table but this one repeats a
> > code.
>
> Maybe a followup improvement to jevents.py?

It is expected that events may share an event code but they may be
differentiated by unit masks, filters, etc. We might have identical
encodings even with these extra differentiators, due to old and new
event names.

> > Not tested on hardware: there is no AmpereOneX machine here, so perf wa=
s
> > not run against the real PMU.  The change only edits a JSON table; the
> > perf build was verified and the generated table for this PMU goes from
> > two names for 0x121 to one (rebuilt, counted in pmu-events.c).
>
> Ilkka, can I have your Reviewed-by or Acked-by?

An alternative to deleting the event is to add:
"Deprecated": "1",
as that makes the event not show up in perf list. Using Deprecated
means that anyone using the event name won't be broken by this change.

Thanks,
Ian
