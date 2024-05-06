Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D26745D9
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016433; cv=none; b=JDB2QlsnOSOVAgtp+rT/Hup53+6unM9uu2gZx9aCLPMk8pofma249PsQMrw24Vjd/ZIP30trzc93l8zvAWGHgDOXxC3gOrx/jj/PAIXjYgOVZPNRZOnVds+gDfbWBZhm/MYdIslc7Dvovrq3PO+t1vwlOW/cg6E8aGWb09Y/WFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016433; c=relaxed/simple;
	bh=1Gz+ZMUxvzU8tbk2S61iJbkhzNgB92CniBSM5tVjyCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVHy6oSKmkCkC1etHZNm+ST9x+qvtfgy+trxgJC9vpl4mnUSzyBmSkk4dMplURrLf/c0dz7WasIEnMEISm9dkA9VbHM3YlJqDMiPZNBMSaiLgqeS563XXcWY5ibk7jqmRPix+51vcegxqXmq42tAo7nfBQzxd819N4xBj2t63i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NMcDwJAI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NMcDwJAI"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59b178b75bso342542966b.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 May 2024 10:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715016430; x=1715621230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=si93Y3nf4li8Vv75gH4hoc/QXj4YJDQ0lpKJdmZfJPY=;
        b=NMcDwJAIgL/7pFN7DRqlzs4c1zKhj9Nfyfs7eX8oJO4xLTkIs05tf1NmIdL37WOGGW
         uOH2WUzrrmYrecHsJ2wp7iXEbAPNZ1nQRlh5lRzYNHkPmfzIVrL8AVa6xDuuoCTjr2xc
         3lJ93aBGRL4riv/KnMGTCRwViuUFWYZEAenOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715016430; x=1715621230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=si93Y3nf4li8Vv75gH4hoc/QXj4YJDQ0lpKJdmZfJPY=;
        b=We/cfMQsY8CZjskjw2ZRUjbXyv605v1nT0y4i9jQZqpcf88EOKJ8GpB4rFsMaFRE5g
         ZFJIfEwZ7bti7vS22jIlp/qdGnWAuUeLEkF00IZbIVEoNN1OCWa3arM7GapnC/FJiocW
         HfEQaDImPcr5ee0MzkTForBmZ90OVdaUURrilCY3+OjaovMGrGdaZCYArTuQmOnQmSwD
         5n7jFILRNK3m+k+gEkgr+0SxzgT7APrjB85wzBFLhcPFEpw3hWGjL2cobanVzztCo15z
         4BK2mZZ1DsmFsp3EFyjf+3GM7u8oKtkabgWekVjtatIEOtRwB7sVVbuJs/4fbuR72eQ7
         VkNA==
X-Forwarded-Encrypted: i=1; AJvYcCUMoieqRFgEWE8aHquJ3GMHAn+z9lecUKsnoEQTxd4qAcNlZh+l0rvNypQdhoNMHkyFiU53n7t7C2vDgyBL3ckqpra4/L/i0YhWJtUZpd8pcg==
X-Gm-Message-State: AOJu0YxqObnWdJGldrPeB+CuE0vkhm6F/chBbgrX6mIlAvgRmZhR//in
	c0MqmgRhNK2Pa35xIlcdiHkLb5VMFMVAaxIahzlKOL1V7TlP8NJdV2Iw/Bk7VxUhWoSxqaqYyu0
	Fp+iQtw==
X-Google-Smtp-Source: AGHT+IGm8lbyWIGLK3md/LHQxYFtBU+yLZ6AFrCZwS/ck17hemoQmhVPGG3HAQv9FwFPhpGV9hd4zg==
X-Received: by 2002:a17:907:7da6:b0:a59:ad15:6142 with SMTP id oz38-20020a1709077da600b00a59ad156142mr3914473ejc.77.1715016429726;
        Mon, 06 May 2024 10:27:09 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id p25-20020a170906141900b00a55a5384986sm5453867ejc.24.2024.05.06.10.27.09
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 10:27:09 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a599af16934so534075466b.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 May 2024 10:27:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpmDHadHa+BFw9XCIDmvgGPuOpy4aAFpKiwKAWeIR3F1UzaP0IdSCJ2ZQsOBRNNea/ueCu0QagOcE+dWXm7AnD7A0Ov+S25MB6ZrsVXKesqg==
X-Received: by 2002:a17:906:a159:b0:a58:e71d:d74 with SMTP id
 bu25-20020a170906a15900b00a58e71d0d74mr6566938ejb.13.1715016428860; Mon, 06
 May 2024 10:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zi57-TMgU19puaQM@octinomon.home> <41180245c6e94a06b789cd44b8aebd62@AcuMS.aculab.com>
 <ZjPApuDc0gL9Pchm@octinomon.home> <424d62cd084a4aaeb1067ee0af8e98ea@AcuMS.aculab.com>
 <CAHk-=whCS468impcODViZuWxhQSqi4mqFCo3wbrsb=1SB0CXUg@mail.gmail.com>
 <e909d487c4c3468f8f20c952fe46c89c@AcuMS.aculab.com> <CAHk-=wg8JOO9e4wAD11vKVndXsuzhVFw547x9nRXKyFS1QRkGA@mail.gmail.com>
 <264d983efe164f7d8e665fb7d330ad7a@AcuMS.aculab.com> <CAHk-=wh8=yVY5vJC0EgM8=-4FOFxA+0w-OoLsZDypjpjsB5www@mail.gmail.com>
In-Reply-To: <CAHk-=wh8=yVY5vJC0EgM8=-4FOFxA+0w-OoLsZDypjpjsB5www@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 May 2024 10:26:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGUkPz+9gN_uwOfg-VGP4Z5UBKe-xBrn3uHMtJ85UarA@mail.gmail.com>
Message-ID: <CAHk-=wiGUkPz+9gN_uwOfg-VGP4Z5UBKe-xBrn3uHMtJ85UarA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
To: David Laight <David.Laight@aculab.com>
Cc: Jules Bashizi Irenge <jbi.octave@gmail.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 May 2024 at 09:45, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So we probably _should_ have made "do_div()" be a "64-by-long" divide.

Actually, some of those conversions are just wrong and stupid, and
didn't have 'long' divisors at all.

And we do have "div64_ul()", although it's not used as widely as it could be.

But I think we can do the reverse, and just teach "div64_u64()" to do
what gcc should always have done, and look at the divisor range at
compile-time.

Something like this, perhaps:

  /*
   * Do a 64-by-64 divide using div64_ul / div64_long / div64_u64
   * depending on type of divisor.
   */
  #define div64_u64_type(a,b) _Generic((b),     \
        unsigned long: div64_ul(a,b),           \
        long: div64_long(a,b),                  \
        int: div64_long(a,b),                   \
        default: div64_u64(a,b))

  /* Is it zero without evaluating it? */
  #define is_constant_zero(x) \
        (__builtin_constant_p(x) && !(x))

  /* This catches constants and compile-time ranges */
  #define is_32_bit(x) \
        is_constant_zero((x)>>16>>16)

  /*
   * Pick the right division helper based on
   * value or type of the divisor
   */
  #define div64_u64(a,b) \
        (is_32_bit(b) ? do_div64(a,b) : div64_u64_type(a,b))

should now make div64_u64() do the right thing and avoid the 64-bit
divide for relevant types (the signed type case makes it a bit less
obvious, but whatever).

               Linus
