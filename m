Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974FA8462
	for <linux-perf-users@vger.kernel.org>; Thu,  2 May 2024 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690802; cv=none; b=kruwL86BGRFv6pIGQdt4udjhp5kaRxFyFAyqBKRBSZwNHlg7iWdZZpGTf4ME1pw8PxLsl2ZBSt/M31/mcq2Wy+lWFZ44LDpJxCMTMSO5eQ+DyD7Ep26jx8tQd6UE/RGpdJEzWmLzbe3hGGmYjwgF3S1+q0tcavH3p4ops/YLoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690802; c=relaxed/simple;
	bh=oJ2B3xWnyMsG3znWjYEqNMQOOuCTKjRZIDwsdrKa4EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWwU4OIk0wfPirUteVB8ohdowk/j/YZ8y5NCo8nRXwOoP3XGcSDrza74GOiHiByKOzBLgolr78uzXvV5vtzSS7AXnvOJDCaUeCUUPTys8a5PuOEXNe8+FbXpQn6QkPxDuCeIzU32cihs+/8k/OYByfgdWtrRYpDADBVBqQKFKEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dgiNmpvI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dgiNmpvI"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34dc8d3fbf1so1554945f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 May 2024 16:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714690799; x=1715295599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DtPekKLO5uWz03wcMhz4ZUHzEKah4IbGaG0Ir6OHM8M=;
        b=dgiNmpvIw0GdhYmpq5jy4m5suhcDIPq2xv7MZtSqtI5UN+8MsylSwT8Atug2kA9XLE
         bfJyYcNtzAUruGA0Ml12CqWNwIriREe1zynHCV6H80nhscGXA2JoHMTvH9SnX4CJ2QVG
         fxGUIQgO+HqhZ9a2acnWaI49NwErG6qBM4ObI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714690799; x=1715295599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtPekKLO5uWz03wcMhz4ZUHzEKah4IbGaG0Ir6OHM8M=;
        b=Ucd3yb8ExvGGbiRMCwK9cyFXym9sk8SqHj/gjvLsEHIyqauyc4ORmkkqHDP8MglTf9
         YRe0Ji87nYUBN6fJTWNU24PKHlnICorh8ddC7anT07Wx6U+DOHpYJFY6qQj5pC42yAHX
         dSPocrAc7fDYeK+GllMnpPidAfFYH8WnXegCAzbRy3+SKiR/BuI0wMh3p45outDIp4Mt
         skRP9RaOFZJhGCEUS23f/j7NpA8eQK8DoL05yMb5f31VqRKC9QdSUjbq892tC50hyks+
         q96dBxGhYx6VuBQ7gjTuT01Yb5vLLxHA+QExELV+trTjcIvWwenCALuTr5JAm/A+FMzs
         6g6g==
X-Forwarded-Encrypted: i=1; AJvYcCVM/zb7udUDvJ8LTHNN3Idxn6VEiZjnCkqvESttIJz7aKfd8OhuZL+UBnW7lV6gqKF88BmoSswTd+P7D6WXFGQGRaBoZGoVty/8th3n+Vh6Nw==
X-Gm-Message-State: AOJu0YyV4YsdQc0GdBTDDDADwciHwtKQVybB26t8rqUHgTIVdAW5RVLz
	zcNdV4aSVCbFG9J5UYyoNovsoJf1buuJg9e1jpl/uJH1FubJdUUB1OT+psjOcV2jogD9b6xZDM+
	R36aXMQ==
X-Google-Smtp-Source: AGHT+IFvNSSa//LXMQQmCaIsfh0/NxCCXXyn0Sw8KUWi3DR3xvNqs3D1LdHEUHEp8PVKQcSvwQDYwA==
X-Received: by 2002:a5d:4207:0:b0:349:d7dd:9e4d with SMTP id n7-20020a5d4207000000b00349d7dd9e4dmr764077wrq.48.1714690798651;
        Thu, 02 May 2024 15:59:58 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id j18-20020a170906279200b00a46a2779475sm1022159ejc.101.2024.05.02.15.59.58
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 15:59:58 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51addddbd4so1002486166b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 May 2024 15:59:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsLGBOevCJ1Zf3eYs2K62L5HabXFQdbBuZ9uFUludh6K35sSlyx/+GvArwNf/85lsIN2nOqjhUBZEMFvzpDX/wD+CgAunUSN3E1iVhSiHFrw==
X-Received: by 2002:a17:906:448:b0:a58:cd39:d154 with SMTP id
 e8-20020a170906044800b00a58cd39d154mr504767eja.11.1714690797825; Thu, 02 May
 2024 15:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zi57-TMgU19puaQM@octinomon.home> <41180245c6e94a06b789cd44b8aebd62@AcuMS.aculab.com>
 <ZjPApuDc0gL9Pchm@octinomon.home> <424d62cd084a4aaeb1067ee0af8e98ea@AcuMS.aculab.com>
In-Reply-To: <424d62cd084a4aaeb1067ee0af8e98ea@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 May 2024 15:59:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCS468impcODViZuWxhQSqi4mqFCo3wbrsb=1SB0CXUg@mail.gmail.com>
Message-ID: <CAHk-=whCS468impcODViZuWxhQSqi4mqFCo3wbrsb=1SB0CXUg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
To: David Laight <David.Laight@aculab.com>
Cc: Jules Bashizi Irenge <jbi.octave@gmail.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 15:19, David Laight <David.Laight@aculab.com> wrote:
>
> Somewhen it must have got changed from a simple asm wrapper for divl.

It's never been a simple wrapper for divl. For the simple reason that
'divl' doesn't do a full 64/32 divide returning a full 64-bit result.

'divl' takes a 64-bit input, but only works if the whole result *fits*
in 32 bits.

If it doesn't, you need to do two divl instructions (the first to
reduce the range).

I think the only real change to do_div() has been to make it notice
the constant power-of-two divides and turning them into shifts/masks.
I'm not sure when that was done, and too lazy to check.

> So maybe just supporting 64bit divide wouldn't be that expensive??

A 64/64 divide is *much* more expensive than a 74/32 divide that does
(potentially) two 'divl' instructions to get a 64/32 division.

Go look at lib/math/div64.c and the mess that generates. We're talking
bit scanning instructions, several multiples and 64-bit additions and
subtractions, some shifts, etc etc. And that's in *addition* to the
two divides. It's no longer inlinable.

And yes, none of that is relevant on modern hardware, but the
corollary to that is that on the old hardware where this *is*
relevant, even the multiplies were 10+ cycles, and the bit scan
reverse (that the full 64-bit divide thing uses) was 20-70 cycles.

So a full 64/64 divide is cheap these days on 64-bit architectures,
but is really bad on those old CPUs.

In fact, the reason do_div() exists in the first place is that gcc has
historically not understood that (maybe it does now - didn't check),
and would force the full 64/64 divide.

This is in contrast to the 32/32 divide that gcc does fine, which is
why you have that

                        __upper = __high % (__base);            \
                        __high = __high / (__base);             \

which gcc will just turn into a single divl on its own.

That said, I agree that the "if (__high)" could always have been "if
(__high >= __base)".

It probably doesn't matter all that much, but div_u64_rem() randomly
gets that right (same function conceptually, different calling
conventions, different way to split the 64 bit value into two 32-bit
ones).

And if you don't care about the remainder, just use "div_u64()" which
has even simpler calling convention (on 32-bit x86 it's the same code
as div_u64_rem, the remainder just gets thrown away).

             Linus
