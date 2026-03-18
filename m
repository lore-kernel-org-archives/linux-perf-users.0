Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A404B26158B
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866929; cv=pass; b=Yv3UFRg7IRupxjK7/mU+zDdCMWBOhDttvj6ZjCIH7nvSytpBi29xoAwoEmoB23dQiZAY0WoWhYl1uBBFBFUie9u0FmIS9WTOgGc51XPKltS8jt4vqiEIv4TWDLnX0wPhEqTTMnCXczRrtXbahexs6Wc4gc26ZTNQ2EWMmGAUIZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866929; c=relaxed/simple;
	bh=uP/X/c4byL8tV9q/9/0h5F8Ex1XJ6JshM8+8odZdA24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lncgTwEImV9652ZJCDryOjU7vQDjHx+Pob/FezRf7VfCkLcVBBtPfvn1cRMU4BpC6g6+dh1Ce2X2TeikP7rBGFMZ8LMi2AFhyQ3UW1KZDa67b5xRpuRYgYfAeAQSwrGHlql8UcOJMxJLsnmWg4xKdI5HYbhr11EFl180R+TaVAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fiJxthqw; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fiJxthqw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aeab6ff148so7225ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 13:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773866928; cv=none;
        d=google.com; s=arc-20240605;
        b=BaKx3ssPL2WCOWKOD6UYp6WEd/+iryPp8bKAc2uAMI7i/1PE19kkjuv1vzQn5MV/+8
         36p0ZCvkEkNY9w1llS4gCCqon6jDJEyoGbtwLa0lXo14HPbCH5Gydl7t2BpM3BIj6Dt5
         YGE/SkL9/9yUnFb/yLEjvnYYk9/o5U8Ax8YQWwLaPx7RojBFeQYAY9NjLyVgs52mzd6O
         Qz2h2kgBn/Qjn7TlnX7ePgfy2OlxqmIOgDyOgclSa8OeLQuq2h+lqtsiOBAjt5o6uAWv
         79TSsRezDVFtmraZ2URg+gbtmQraAA/ywjt9CfmiXftLXN+//U7DotIs4Ryl3ygsv5I3
         ff4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gElYO98Hg2Fg6bwa7XQRsZcF8Y9zb+Di190eJCWt1Ig=;
        fh=PSkqgZx9MCRhKU2pw8tuO1rPoH5iACYvL6msHvhuGNE=;
        b=IE+ENLwEzmlqYf//89abJ45kOfzrMZqFAqEor6fxAQPRgC20BU1jC50pKysFBxcfWz
         psBfRn2I99fcCGROYqguMy+g7W+jUEYHEDv4d2E3lrvQa+q67zqYVf5tHk7VPstcLRcU
         B80HMUoiYZ0v42ipcYQXr8x2WEOAHjbxpvfiMYjM5lk5/rUJxpQtYeHbOd2BV69Otb8Y
         JdDnzTUHt4enumFwJSOzZDdi5dp8NDbyob9fwe2XeXtsP2EiJKX8qmuN2jcyQcUVdS/S
         GivtYhe/5NfbxQLsihQAnjowEEQ2rjFmmvtyfQffOQT4dlUOSZtvJgiAkKTvSbm9HaKr
         YKXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773866928; x=1774471728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gElYO98Hg2Fg6bwa7XQRsZcF8Y9zb+Di190eJCWt1Ig=;
        b=fiJxthqw/9fNGtSHIEAUPfwMjWKOJywE+vP752q+7V2mc5MhsnQojqw/54ouLkj/Zi
         /C4FNlHLNhtpEJsWQjfCGyCnHSavjTkaaSaYQG0gIDipVs4qpQjbtnVk7fiPpdIL6Vsq
         5vsgyeQizdmCdIcbEf8w07dobWeAm6Z9WnmA4AgG6DmcifV5viaa61At5CniiDB8q0sZ
         XFDotFDO3m9/vlFl6bb43/SR/ddrQ8kKHugyCBqOTP+bfUa/Os5OJ8h7AL469zxotahu
         uMTwe7Kr2qZ6ySGfvehrx2J302UWa4Zvgy8FMSFBovLCfMPbgHKEWKdeCWpMhkalaQF8
         f60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773866928; x=1774471728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gElYO98Hg2Fg6bwa7XQRsZcF8Y9zb+Di190eJCWt1Ig=;
        b=KwMqhUK4X/r+W3mCxEjIEPg3fwUsj8QETSEM7u79POLpmqq7Bt45gtULXN7kznweAC
         aqwJ40YrPdheWCVFnzwzQWnCyElO621tmhCiCvkvSoMKz/TfXP012iuQkXkaR+j/RKD5
         9YYDUiN44LMfVYpP/s06EAmByTra/hSXPYWO1Xr2/BCGbbOI7me9KjHRlV2c2N+DzBR5
         Ar+t9HBGoh0H4M94daoOMWZICCzoZ/2wHudHw8qTj9/nCNyQLg/TfCdUl5ZR9GGz8s+0
         ZoQZpMNONiY/BuPjUAbBgFD8zcHEwTNBweytjJWDnLVAZV+Q7BZqRktomtq9RN/VitzI
         6H8w==
X-Forwarded-Encrypted: i=1; AJvYcCV8ldfrMXcoca4IfG45RsgMZ8hbs61xovq5B4W0trGCpM1kxRwRV6G4+chIik41zYavMuTsy1pHvhbmZtWgydJh@vger.kernel.org
X-Gm-Message-State: AOJu0YzNcsmcaYMqKzDeUrRfEY/L2RN0IcMfNbkgCsuI8nlqfAtVJVqB
	x+Xz/fOyqaEogsWrqzKk8ozegtOEYrt/rWbBYbDmf9YXTRq8SoPid/3ovMc1XNCZQRArNp5wQ0l
	x749hf8vdWxnG2ZR+uAqHmU45WcXL8y41Ks5gmfHW
X-Gm-Gg: ATEYQzxcZQ4Bt1RGdREBDsec4pYlfM7x62sfeXEKb1e95h7PMZa11AEpHWm4eznqWrN
	bq1TwRBjDpvjY0g0Rs9FisQ+T/J0U2UlbcHpXxEfviPLBdA+uwaLub3x8OckT4tnYdam00F73Y5
	yI+JZXdpXKIWBakl/B0uQ5xD0w4x0cpXTFItLx1YAZY90t2kvxnmMA+NbyMaxZWKwTJMrTVDSsH
	AcXRCpFUdsKzCAzKwiBc83qgvlwpLyX3mXDj5I5oU+Za/wOVDNNMwpljU7US/KHslCAxdr0joAH
	Avly+vHy1F33S9hv46mb+6y3DU0uwXloa9g8Tg==
X-Received: by 2002:a17:903:1a08:b0:2ae:d10c:6382 with SMTP id
 d9443c01a7336-2b077e5d126mr869875ad.20.1773866927220; Wed, 18 Mar 2026
 13:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abrwjt_R2X8r7Bbm@x1>
In-Reply-To: <abrwjt_R2X8r7Bbm@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Mar 2026 13:48:36 -0700
X-Gm-Features: AaiRm53HAAr9_kyTFC3KM_ke6veof6ncD0FFbGXA6B40_CFCg16lptkCwOfuQ58
Message-ID: <CAP-5=fV6_1_4oEDa2VG6uSegpASa_fqm2crs_LB1Toft7YA7wQ@mail.gmail.com>
Subject: Re: [PATCH 1/1 fyi] tools headers: Syncronize linux/build_bug.h with
 the kernel sources
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

nit: Typo in the subject line s/syncronize/synchronize/

On Wed, Mar 18, 2026 at 11:36=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> tldr; Just FYI, I'm carrying this on the perf tools tree.
>
> Full explanation:
>
> There used to be no copies, with tools/ code using kernel headers
> directly. From time to time tools/perf/ broke due to legitimate kernel
> hacking. At some point Linus complained about such direct usage. Then we
> adopted the current model.
>
> See further details at:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
tools/include/uapi/README
>
> To pick up the changes in:
>
>   6ffd853b0b10e1e2 ("build_bug.h: correct function parameters names in ke=
rnel-doc")
>
> That just add some comments, addressing this perf tools build warning:
>
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/linux/build_bug.h include/linux/build_bug.h
>
> Please take a look at tools/include/uapi/README for further info on this
> synchronization process.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  include/linux/build_bug.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
> index d3dc5dc5f916ff4e..2cfbb4c65c784ad8 100644
> --- a/include/linux/build_bug.h
> +++ b/include/linux/build_bug.h

Shouldn't this patch be to the tools version?

Thanks,
Ian

> @@ -32,8 +32,7 @@
>  /**
>   * BUILD_BUG_ON_MSG - break compile if a condition is true & emit suppli=
ed
>   *                   error message.
> - * @cond: the condition which the compiler should know is false.
> - * @msg: build-time error message
> + * @condition: the condition which the compiler should know is false.
>   *
>   * See BUILD_BUG_ON for description.
>   */
> @@ -61,7 +60,6 @@
>
>  /**
>   * static_assert - check integer constant expression at build time
> - * @expr: expression to be checked
>   *
>   * static_assert() is a wrapper for the C11 _Static_assert, with a
>   * little macro magic to make the message optional (defaulting to the
> --
> 2.53.0
>
