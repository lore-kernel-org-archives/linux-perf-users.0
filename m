Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027313DDD8
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013970; cv=none; b=lO6PI5pmhlaEjxs1tlO8o1Gr76zZl6DX5/ujM5ZVGVJhp+QQi3mZPcIDoZG3IrzrC6lQuJOKInXAridXct6Oz7Y03x7gSYHX2EgkaofsrZJNSYpuJ+zJIkEnlSwU4jbJJ4eYAe7mQWprrCVITrhEXQ8CsvIGHfoUA1FMa18l2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013970; c=relaxed/simple;
	bh=IPgDnhSi8JDjmEcxm6sL+rpr4YZLmHEgFsyFZ7mqQvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2f0XGzCmtLnBP/2JGRPAmZ/FC1Dfl2S9zhXg037Wyf4v0Vb3phN/iwcjYIuXuesAy4SR/oQMfBt4s/ZMS+Nnd5nswifN8PRVPyB0lsUiQO8APNT8B5ly9+RVTKyoth/3USpLyjuVOV0V/qTzAiiq1G93V2hUDWwM0gG5/x/tjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D93NXnyv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D93NXnyv"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a52223e004dso447634766b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 06 May 2024 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715013965; x=1715618765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=agzKsGkt1CQMrqR/XE0sZ8vS82jWREq2dAikRnOmCts=;
        b=D93NXnyvwLEAtiZndCYZ1lSaYHvXkzasGWJV9hAf/v/pKKtDZsXFOGCeHkbcUA8NeE
         HZdM/CYqLHrCzR2ocMwBqN0eF0aZmraQDSy5jtiH9DrTEoVhJQMygxAJ5VX4nhraIEII
         OPXf+GmOHc++/Y6DN4nZhe6GbX3sudgeYHETU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715013965; x=1715618765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agzKsGkt1CQMrqR/XE0sZ8vS82jWREq2dAikRnOmCts=;
        b=C1ZPOAhwHisubN6Xyf4wdQv/Zx7M6cgGZQOVlg+njfWbgRuOpRYHwMH/z93ueoUwUi
         2KipFvGrkIYoAO/tY7bXzfumhF1vM3CzaXxynQubHB9mUoKso/G6EluaZFVDkf+ecH7r
         +b/cRvzK/fy7iCcVmyaXsDTSwTgKABycTWY2wnSCkIYKepJCaWx/SHcHaDPeAa1X8NVB
         pSB+7TXZrL5YI3YFQ9ImGpg6u3zocTsIHO7iqw6rW2yq4z/rpvTZtbU1N0TEC2ZV2Vn8
         OJyA2fpJaBxOwy8UHiTcHLtMgvQgv/vfff9RY7eTHefGKhiacty8DmfVqmSddCdwpTXA
         B3cw==
X-Forwarded-Encrypted: i=1; AJvYcCVlG7PKLOyB9yBNA6fmZ2jDS87vsdBvXtJ7o1Wvut84IgBhjsuarK86FqRkwF1Jd9CD+riRvk7Qe29JoMquJvz6de562dJIPkMRFQ0sOXtqCw==
X-Gm-Message-State: AOJu0YxNVtTS04muPA2DSWoy+T4jWHipKN9UU7YRIyPgXOnrA9XND4mh
	HcnU0/GB+QkTzL55R/HXgtvhQJYkj8+UGFTHONPH9vIr3+3g2MljsCg18YEI5Uav6pZadvjGQcJ
	uwHmU7A==
X-Google-Smtp-Source: AGHT+IFOVuzgXgaue1WXdz6igt1rVirCwBFierPRtK9Oc025dYTUOh1B76ZKODgyD+IMgki4VDJY0Q==
X-Received: by 2002:a50:d55c:0:b0:56d:fc9f:cca0 with SMTP id f28-20020a50d55c000000b0056dfc9fcca0mr8785538edj.41.1715013965084;
        Mon, 06 May 2024 09:46:05 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id fi24-20020a056402551800b005727dc26598sm5364715edb.13.2024.05.06.09.46.04
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 09:46:04 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59b81d087aso420471266b.3
        for <linux-perf-users@vger.kernel.org>; Mon, 06 May 2024 09:46:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9Bz2IO8jyYb5jUJ+0CvHQRlSifHZNTrNUC7CZCjE4D9MRu/mztenGqdqRzEWDTCED4yR8GhuV2qskgFunLkBazbM5S1l3aNJfwKW47ySaAg==
X-Received: by 2002:a17:906:2806:b0:a56:e555:3ea6 with SMTP id
 r6-20020a170906280600b00a56e5553ea6mr8013781ejc.55.1715013963908; Mon, 06 May
 2024 09:46:03 -0700 (PDT)
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
 <264d983efe164f7d8e665fb7d330ad7a@AcuMS.aculab.com>
In-Reply-To: <264d983efe164f7d8e665fb7d330ad7a@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 May 2024 09:45:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8=yVY5vJC0EgM8=-4FOFxA+0w-OoLsZDypjpjsB5www@mail.gmail.com>
Message-ID: <CAHk-=wh8=yVY5vJC0EgM8=-4FOFxA+0w-OoLsZDypjpjsB5www@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
To: David Laight <David.Laight@aculab.com>
Cc: Jules Bashizi Irenge <jbi.octave@gmail.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 May 2024 at 09:40, David Laight <David.Laight@aculab.com> wrote:
> >
> > We don 't do stupid things in the kernel. We basically never need the
> > 64-by-64 divide.
>
> There are 381 references to div64_u64() some of them are just plain stupid.
> Constant divisors of 100 and 1000 and div64_u64(x_ns * 100, y_us * 1000).

Sadly, some peopel will get the compile error for "you can't do that"
because they did a regular "a = b / c" and gcc created a mess, and
then they mindlessly just replace it with div64_u64".

> But someone wrote a script that complains that is a full 64bit divide
> on 64bit systems - so suggests div64_u64().

Yeah, that's well-intentioned, but it screws up.

The reason is that "do_div()" _always_ does a 64-by-32 divide, and
then if you have a divisor that is "long" (which is indeed 32 bit on
32-bit architectures), now on 64-bit architectures it truncates what
can be a 64-bit value.

So we probably _should_ have made "do_div()" be a "64-by-long" divide.

On actual 64-bit architectures, doing a 64-bti divide is typically
fine (I can imagine some broken cases, but not enough to care). The
whole problem is because of 32-bit architectures.

              Linus
