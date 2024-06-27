Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20C5198E66;
	Thu, 27 Jun 2024 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513587; cv=none; b=qTCGuzJ1R32q4XN0P66NpJ3NzxzYAnAJ9JWuc5sspy3pKL0Kx6FSz+9sge4G8n/PrY9Cd73DEFZrv9vpcTH62vQ24xMhiWw3NPjmxEnrzzr7UKP4V1DuhDw2xCvo7WgSMscySTamFPq1UFPPgfruo2coSEkf+vNwz/FEihxPqW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513587; c=relaxed/simple;
	bh=H43vpq5CkpukxJ+RpfCH2kOHugkGp2OcA7lTZ7BQvog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSDyTPGgrFKk+DhqEPXiRQC1SA6ZXBbDlRSvFpyj58mIXVwPZpdGdTehGQGJwsK02szMcPI+W88cHwBXNCoBZDkXifENgvLJ39/BiOcEJOIcx9wrPPcR0lFCjGhT7sHoIxVeTmRVg+qixmxy7YLwsTU+0U1rJFSqYeAFxf5wXZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxcUahQ2; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxcUahQ2"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ce6c93103so6402236e87.3;
        Thu, 27 Jun 2024 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719513584; x=1720118384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yq9cgejnZ+hQ+e3cKAuM+poXuWnXROvtetA+LYOWE3o=;
        b=jxcUahQ2XutBwgM2QjclFkiqV8YN8KCx3njzDaHQHLgJyDi8yhH/Dk18I/R2MhtvcI
         eVeqyeGqz/agVzedqfIUIBzjQhRSHnIZFkLE7VaeO6w3ieMjJllMBIYYg7DytcjOvQH1
         cgU6FGEVD8p+Dbw24AFvbcMVkx2eOTOZunBvO5TnB5CXpYOTzAoNeXFP9pNg2ia3JpX8
         BK4OObAoxkv5qW5t0PFvTBScQaYjLLfpbpA1dxvbQPw3UnVSTiILYQwkMg6fVN1xFhV4
         TtFrHyTa2oHu1nIG+cG3axqboyLfBiI67uRCnt036Xkmzyy7RvNcrK2BitlMHIQVhIU3
         BX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719513584; x=1720118384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yq9cgejnZ+hQ+e3cKAuM+poXuWnXROvtetA+LYOWE3o=;
        b=mORP3g7ar55yY/42xEN/eyT0Lwt3VXws5+tqMeaTS+1rMDb3Ww66XOyF/MnwrJ0nRY
         FXyp4dTuoK0eL5IsvUrZbq2OeYYKSXOogbVX0uNI+Du9hV2S9y8AbH5r5Z4I8X2yBMVZ
         FgBmLHAECZrP8qa2ITr6tSo7jQ0oi0d/3HHkQXcrAS3v3v5ZJI1Vm27dHkI8n2CI7mZh
         mY7dbo2sImJNqXmjMfGcWF5FKa00MxMcTC7OQnGkpRziLe2AZ/w/TQFHZ3YfJn0NpusP
         lY5W4AWd6UWOsYPxjisg2yog+oPiXsr3/noRbcE1IKqphIX12RJl5a75GUUzcZr9slCY
         z6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCW6J3kH8i/eEptwBl5leKihlGNhWXn+wqKI9GqAJO40hQjdwZB3xIsTBCnV2DE57/nc3+ZTieVExRNgstIw6JdAu5Q+okGX4vdqm/St+2xn2A==
X-Gm-Message-State: AOJu0Yzyfcy7TIznPvXibjE5KdyC3btiy4mqPxrSvavKWg5QycTwKbUc
	BX8f+01NdqctcIGnw41ztic1jr9b1bGuLTih7VyvG9k76hEk6IHEMU39XX2kT0vtbAcdEPEXnD/
	MWN+d7zaKuxX/WCntpol1N6799A==
X-Google-Smtp-Source: AGHT+IFPhnuFwXPfbYAgWVIcWxp46Rfmu7wVOb3+DP0XhK7wh3skoxy1050J0LChH0Ile7ly05kV4RJccRf7ZjZWlds=
X-Received: by 2002:ac2:5293:0:b0:52c:deb9:904b with SMTP id
 2adb3069b0e04-52ce1835924mr10186273e87.38.1719513583756; Thu, 27 Jun 2024
 11:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0083546-f945-45e4-a0c3-96794ef76caa@citrix.com> <20240625052239.1244986-1-xin@zytor.com>
In-Reply-To: <20240625052239.1244986-1-xin@zytor.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 27 Jun 2024 14:39:32 -0400
Message-ID: <CAMzpN2jCceqKTkSYTCK4q=_3s-QCZWk6AA6=QfawjhCd_6Pj_w@mail.gmail.com>
Subject: Re: [PATCH v3B 4/4] x86/cpufeatures: Use AWK to generate {REQUIRED|DISABLED}_MASK_BIT_SET
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org, 
	namhyung@kernel.org, andrew.cooper3@citrix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 1:23=E2=80=AFAM Xin Li (Intel) <xin@zytor.com> wrot=
e:
>
> Generate macros {REQUIRED|DISABLED}_MASK_BIT_SET in the newly added AWK
> script that generates the required and disabled feature mask header.
>
> Suggested-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>
> Change since v3A:
> * Use '1U' instead of '1' in feature mask shifting (Andrew Cooper).
>
> Change since v3:
> * Checking NCAPINTS isn't necessary anymore.  It was needed when these
>   macros had to be manually updated, but now if cpufeatures.h changes
>   this header will be regenerated (Brian Gerst).
> ---
>  arch/x86/include/asm/cpufeature.h | 69 -------------------------------
>  arch/x86/tools/featuremasks.awk   |  9 +++-
>  2 files changed, 8 insertions(+), 70 deletions(-)
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
> index 989b021e73d3..e0383683e630 100755
> --- a/arch/x86/tools/featuremasks.awk
> +++ b/arch/x86/tools/featuremasks.awk
> @@ -77,7 +77,14 @@ END {
>                         printf "#define %s_MASK%d\t0x%08x\n", s, i, masks=
[i];
>                 }
>
> -               printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS =
!=3D %d)\n\n", s, ncapints;
> +               printf "\n#define %s_MASK_BIT_SET(x)\t\t\t\\\n", s;
> +               printf "\t((\t\t\t\t\t";
> +               for (i =3D 0; i < ncapints; i++) {
> +                       if (masks[i])
> +                               printf "\t\\\n\t\t((x) >> 5) =3D=3D %2d ?=
 %s_MASK%d :", i, s, i;
> +               }
> +               printf " 0\t\\\n";
> +               printf "\t) & (1U << ((x) & 31)))\n";
>         }
>
>         printf "#endif /* _ASM_X86_FEATUREMASKS_H */\n";
> --
> 2.45.2
>

Reviewed-by: Brian Gerst <brgerst@gmail.com>
