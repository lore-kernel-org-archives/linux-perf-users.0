Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013EF57C9A
	for <linux-perf-users@vger.kernel.org>; Sun,  5 May 2024 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714937941; cv=none; b=CECrUmlo9Pg1bBvYBId+ybqAryNmk2hiiVzyzchiYQlzIxinJdeXH3ffCNZyW+HljQqp+nHYm14KuDDxv85ZodMs4oJPYfq3cd8LwuU2sl7JwNnIU+1zQNxdvrYff6B0odo0t2gmbLXiMdqqdd52dV2+0rOA8cAlK0Kjag0OKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714937941; c=relaxed/simple;
	bh=J0qHFlM7HLtOXw4vwEKvg2Jz79uQL2s3cEeY7pVH0us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxdEC5jNmvBsQekdFvto0gT+irYEJebzrkOiIV9QSnNsIlbn3JpUWVLz44J7lEwg+m1dXJqQQejMzES9cP7oZFiqayrITJCpCxJsoxc75DJAfJ2B4Tz7fLJUeB07klw211eGm/zMGym5vLZdxekwM/2OJpC4ytMyClLzA8wnCwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PCKPsXY/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PCKPsXY/"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f45104ef0so1308390e87.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714937937; x=1715542737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KDTMrcQdVfEBIW2E49sGipUfFmsmqU9bmOg1aSZaoeY=;
        b=PCKPsXY/QcFajWjOVPu8QCCuRqMOsiqAuSYUpMynMZmNOAvyRuKO6n61Ok6V5p1Tj5
         BWjMvfWfnrOmScI7B6FGZuMtuuSqyzwSlFsoZGqCaHnCmRmmV4paNjpMw7+APCxXMED5
         CXIffbvGrBw0AGuAlInKd3Hbx6RMYKQ2RqS/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714937937; x=1715542737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDTMrcQdVfEBIW2E49sGipUfFmsmqU9bmOg1aSZaoeY=;
        b=gTFbxtVKghMqzcXA25jayREqVZ7Bk5FCUJ2dedD55jyf7rNtTHQvn61aq5aIRKeoOx
         JLV0cv7wIG238VOC24+AaOJI1vLY55uoHQba5QXBagoZP/VNdl/cfdavsd7maYIc46eP
         EJd2eycwBFBsEULzw/baQ+RnRgHWdj0pDEl79vETTfncVNgsNvZ+3oAnp/2uY1e1hRxe
         +QHen4ls/JWOOHiBX/03VHF6NXNJBgzR8UwwZUizEBIprBvWXkCvCZroz6kudpLgFg0j
         5lvqdVYGgi4PwSnUA+pxr1lOUSoX+U2pNdccSpal2B1U1L2Z16KwtdZKjAcYe3eMwRdR
         xkYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/LMzyynIYcCLdoP3S0ORu5M1tq30PPLMcQ20cPIX5c+5qoV21FZdR/zdNd7R862MnNR35v++Cpm7vyOSbqgBpMJZ5wLU83w70sum1whq96Q==
X-Gm-Message-State: AOJu0Yz7xJlfVjF7kqsMuKROOhp0AoLpIWAhSiqtSeWRzsIU9Ql5mfFc
	qQg6LyU2eQ3TFMCjLmVTRc5XaUreXtuQdanRjmVubvNCPcKHUCNFsImis4QA0Cgv89X5cqjPhPE
	ixyPlmQ==
X-Google-Smtp-Source: AGHT+IFUUPNjZq7lm8ygKPcLsUcxF/PWxpDZm3O+GeIhr09AJAH9XlzeopUdv47b3aWYOK0uF6CdTw==
X-Received: by 2002:a05:6512:61c:b0:51f:3fea:cbce with SMTP id b28-20020a056512061c00b0051f3feacbcemr5826130lfe.51.1714937936826;
        Sun, 05 May 2024 12:38:56 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id l12-20020a1709066b8c00b00a59c0ecd559sm1154741ejr.112.2024.05.05.12.38.55
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 12:38:55 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59a0e4b773so274455866b.2
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 12:38:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwfXEHFLw6znKOTtagIRYf2G40a7ASb2dDY+TY1fE3SAq6dyqcqzSS+4n0e2loz6a/SY0tsObaIaoc8UKdrQasUSCoepLP44KhQTe/Wpu6tQ==
X-Received: by 2002:a17:906:2b84:b0:a59:a5c3:819e with SMTP id
 m4-20020a1709062b8400b00a59a5c3819emr2765418ejg.11.1714937935374; Sun, 05 May
 2024 12:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zi57-TMgU19puaQM@octinomon.home> <41180245c6e94a06b789cd44b8aebd62@AcuMS.aculab.com>
 <ZjPApuDc0gL9Pchm@octinomon.home> <424d62cd084a4aaeb1067ee0af8e98ea@AcuMS.aculab.com>
 <CAHk-=whCS468impcODViZuWxhQSqi4mqFCo3wbrsb=1SB0CXUg@mail.gmail.com> <e909d487c4c3468f8f20c952fe46c89c@AcuMS.aculab.com>
In-Reply-To: <e909d487c4c3468f8f20c952fe46c89c@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 May 2024 12:38:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8JOO9e4wAD11vKVndXsuzhVFw547x9nRXKyFS1QRkGA@mail.gmail.com>
Message-ID: <CAHk-=wg8JOO9e4wAD11vKVndXsuzhVFw547x9nRXKyFS1QRkGA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
To: David Laight <David.Laight@aculab.com>
Cc: Jules Bashizi Irenge <jbi.octave@gmail.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 May 2024 at 15:53, David Laight <David.Laight@aculab.com> wrote:
>
> I was thinking of something like (see https://godbolt.org/z/h8oj7h4sd):
>  [...]
> Which will call out for a large divisor, but will do inlined divides
> otherwise - so is reasonably sane whatever the types

No. This is not sane.

Once you have a callout, you might as well do it all entirely out of
line. You've messed up your register state and instruction scheduling
opportunities, and the advantage of inlining part of the computation
is basically almost entirely gone.

And the thing is, if you do a 64-by-64 divide, then you just do it.
Gcc will create that disgusting out-of-line code for you.

BUT IT SUCKS.

We don 't do stupid things in the kernel. We basically never need the
64-by-64 divide. The reason we have "do_div()" and friends is EXATCLY
THAT - to catch the "oh, you did something stuipid, just fix it".

Yes, we do divide 64-bit entities even on 32-bit hosts, but 99% of the
time the range of the divisor is basically always limited, and gcc
sadly does not understand that that case matters.

So stop arguing for 64-by-64 divides. They are so rare as to not
exist, and WE DO NOT WANT TO POLLUTE THE NORMAL CASE WITH THAT UNUSUAL
SPECIAL CASE.

No, the do_div() API isn't wonderful, and it comes from the fact that
it basically uses the "inline asm" API model, which is not a function
call, but an in-out parameter one.  That API was a mistake, but
whatever.

But importantly, the mistake was *NOT* that it doesn't handle a full
64-by-64 divide. Not 30 years ago, and not today.

                     Linus
