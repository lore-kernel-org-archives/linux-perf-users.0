Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C31CD25;
	Sun, 23 Jun 2024 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719174517; cv=none; b=gcPA7k+JlbmqVMFDopILWZNFJip73xdc3pRKX09iO1d34uyERnSIih3SNKhNlMY+li78YplOxt0HrjGFAqtgGCRSJav+VZ4wESR9ZT5vkLRDg3o2OKPF2UvmFyXQKAvS3XV38O5cU4x7b8oCVECbSyMiur0Sa25c//sn8qnfqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719174517; c=relaxed/simple;
	bh=YFvfxvE76NNhMU8FqQudjgn6c9l+8BTuE2icP0o/XVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvOZJpIX1g/5xEPTqDV9bvwtw++1Piz6ruYYkuIAE2KaPjICWA48W/CDN9mnXqtr7ASjzhKZjiLCqV4CF9fimgUZwjzY2dwT1RHCM9BDH8lySeECCm2GcVPaNGlbIpN8lek9/Pr5atC44mySSe0HygQZMrJmdWAzKpJfjw86TrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CK1XyLX4; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK1XyLX4"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so43108961fa.3;
        Sun, 23 Jun 2024 13:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719174514; x=1719779314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8CMu+bnwf8iQgK3whroeuHcNetbi7+WotVePUC3qdY=;
        b=CK1XyLX49eimOG3IzhTSJbfsxZPutfPTaEXM4mJYKjWUxBz6bkRbuGWeAub+eGX5OX
         bLNV/2F/k5LShBRmovfiwoppg7SDSbWwbj/YHX5heaelIdnNZAjy+TDDu3GMJ4rzUQIM
         LipGPmHAQvqsEFAWm3FswKHB0LeBURVb+RO1EYTDAUavf0n0mMmE6X57bLpB9zxu/qOU
         aPLow2u+XBwKcXNaBjyxb+6bnx8dYwQuQlT760KwPE9V263u12QKuo5aILQKAJDOoSQf
         fymMbfkgEa42iYYJb2egAHgcURI560x2KegVF9AjY1++oTG5r7EvJ5K68mQeE7ypZV5g
         oLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719174514; x=1719779314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8CMu+bnwf8iQgK3whroeuHcNetbi7+WotVePUC3qdY=;
        b=rpnzzwr2BCv+q8GmV14yfX91FZfx5Px+Ntxbn9A3pEYkNdXXgMSzDthgCJn3E0thTs
         Wb1DQyT8GfnsXiG250nC1q+Q6MAF7+A/145mL2gkkVhbg3nqaoxvKbkzjHf5PdgXMwc+
         Qg/3UnpTzo+LEVKSsAZ4GYBfgTE7IbIrf9BrbMK99fdmfTpUN7jG0VIUZP/CfAwFpQC0
         SZHmcK675qLLW9e1W1iCi0MZvu3XSNTSMttVPGMxakNEtxY8R4v87HfW+hri8Oq42/Ek
         XdTJOKwWkWQqPsenxSqa6+PcXnTg1KnepCVLcR/COUIq1nYSHADy454PrDcRvDECaI+6
         GvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIyfVp6YPeJCgF1VrsnTI1N/utd088zJaO7k5TGlUsLWysWp37y9NRZ5PoTrtPCgAdBNLnokhBWtGmlro8RwqfM6eUJ+FnD+gueW9IUfM36Q==
X-Gm-Message-State: AOJu0YwMS7IVVRr6hrT2HzdDwzHBqBcgS1YzgoK2Lx+0flB232JBxSxS
	4fdaF5+70fi6KBmzzlucLxEpgPd6AKGFcI+PkLcz1hddZzpuAa6w0yG3pDNH+qF0y8rynoQ3+wT
	CuxiupeZkXqpnBt1y14WvcPrEPA==
X-Google-Smtp-Source: AGHT+IEX14JMbb/K/wn8L6aNGbNjffLqDc2fa0MiCQ1eDwU56MCzQF/hrmNNJwSWmYxu06HWhzLfXEIbqeNb9TqyThY=
X-Received: by 2002:a2e:b0f3:0:b0:2ec:5785:ee94 with SMTP id
 38308e7fff4ca-2ec579fefd8mr23125731fa.52.1719174513680; Sun, 23 Jun 2024
 13:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622171435.3725548-1-xin@zytor.com> <20240622171435.3725548-5-xin@zytor.com>
In-Reply-To: <20240622171435.3725548-5-xin@zytor.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sun, 23 Jun 2024 16:28:22 -0400
Message-ID: <CAMzpN2hMP8c9PXy=0YV4Ln+u_1n1spJP2jaYXKzEABWLh0+hkQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] x86/cpufeatures: Use AWK to generate {REQUIRED|DISABLED}_MASK_BIT_SET
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org, 
	namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 1:14=E2=80=AFPM Xin Li (Intel) <xin@zytor.com> wrot=
e:
>
> Generate macros {REQUIRED|DISABLED}_MASK_BIT_SET in the newly added AWK
> script that generates the required and disabled feature mask header.
>
> Suggested-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  arch/x86/include/asm/cpufeature.h | 69 -------------------------------
>  arch/x86/tools/featuremasks.awk   | 12 +++++-
>  2 files changed, 11 insertions(+), 70 deletions(-)
>
> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpu=
feature.h
> index 8332f596ba3c..8161dfb3255c 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -55,75 +55,6 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
>  #define test_cpu_cap(c, bit)                                           \
>          arch_test_bit(bit, (unsigned long *)((c)->x86_capability))
>
> -/*
> - * There are 32 bits/features in each mask word.  The high bits
> - * (selected with (bit>>5) give us the word number and the low 5
> - * bits give us the bit/feature number inside the word.
> - * (1UL<<((bit)&31) gives us a mask for the feature_bit so we can
> - * see if it is set in the mask word.
> - */
> -#define CHECK_BIT_IN_MASK_WORD(maskname, word, bit)    \
> -       (((bit)>>5)=3D=3D(word) && (1UL<<((bit)&31) & maskname##word ))
> -
> -/*
> - * {REQUIRED,DISABLED}_MASK_CHECK below may seem duplicated with the
> - * following BUILD_BUG_ON_ZERO() check but when NCAPINTS gets changed, a=
ll
> - * header macros which use NCAPINTS need to be changed. The duplicated m=
acro
> - * use causes the compiler to issue errors for all headers so that all u=
sage
> - * sites can be corrected.
> - */
> -#define REQUIRED_MASK_BIT_SET(feature_bit)             \
> -        ( CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  0, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  1, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  2, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  3, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  4, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  5, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  6, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  7, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  8, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  9, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 10, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 11, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 12, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 13, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 14, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 15, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 16, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 17, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 19, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 21, feature_bit) ||    \
> -          REQUIRED_MASK_CHECK                                    ||    \
> -          BUILD_BUG_ON_ZERO(NCAPINTS !=3D 22))
> -
> -#define DISABLED_MASK_BIT_SET(feature_bit)                             \
> -        ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  1, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  2, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  3, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  4, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  5, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  6, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  7, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  8, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  9, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 10, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 11, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 12, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 13, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 14, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 15, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 16, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 17, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 19, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||    \
> -          CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 21, feature_bit) ||    \
> -          DISABLED_MASK_CHECK                                    ||    \
> -          BUILD_BUG_ON_ZERO(NCAPINTS !=3D 22))
> -
>  #define cpu_has(c, bit)                                                 =
       \
>         (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :  \
>          test_cpu_cap(c, bit))
> diff --git a/arch/x86/tools/featuremasks.awk b/arch/x86/tools/featuremask=
s.awk
> index 989b021e73d3..f6fe979a8fae 100755
> --- a/arch/x86/tools/featuremasks.awk
> +++ b/arch/x86/tools/featuremasks.awk
> @@ -77,7 +77,17 @@ END {
>                         printf "#define %s_MASK%d\t0x%08x\n", s, i, masks=
[i];
>                 }
>
> -               printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS =
!=3D %d)\n\n", s, ncapints;
> +               printf "\n#define %s_FEATURE(x)\t\t\t\t\\\n", s;
> +               printf "\t((\t\t\t\t\t";
> +               for (i =3D 0; i < ncapints; i++) {
> +                       if (masks[i])
> +                               printf "\t\\\n\t\t((x) >> 5) =3D=3D %2d ?=
 %s_MASK%d :", i, s, i;
> +               }
> +               printf " 0\t\\\n";
> +               printf "\t) & (1 << ((x) & 31)))\n";

The original macro had 1UL here.  I don't know if it is strictly
necessary in this case since we're using 32-bit masks, but it would
probably be safer.

> +
> +               printf "\n#define %s_MASK_BIT_SET(x)\t\t\t\\\n", s;
> +               printf "\t(%s_FEATURE(x) || BUILD_BUG_ON_ZERO(NCAPINTS !=
=3D %d))\n\n", s, ncapints;

Checking NCAPINTS isn't necessary anymore.  It was needed when these
macros had to be manually updated, but now if cpufeatures.h changes
this header will be regenerated.

>         }
>
>         printf "#endif /* _ASM_X86_FEATUREMASKS_H */\n";
> --
> 2.45.2
>

Otherwise, it looks good.


Brian Gerst
