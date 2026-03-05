Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC43630A6
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Mar 2026 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749614; cv=pass; b=k+RS0rfZ+HOdBSIvQBXiHKjHpbkBKbtj5aLgZWFatg7Vq7J80Ch2Ilu9DcdBSdwrUwpqcW1zRQaD8qMWt+hYTqIk6ZBU8o3wBk5INhGOERrc3HbmBTMARa5fLpXqru3cHByoC+WJbtcFgZTXRG/uOPUAk8kqCny6vp64zmacLmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749614; c=relaxed/simple;
	bh=kYz+GTRFzKg1oRdgcUO586fpkpafvO5R7dFXtsF8Yiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+GFxyLlXnAUacE9lLCmE32eb6m1/yac5X3CzMQ1kOoz5vUU2kDP0Wd99qpCkK0tBoYm7l5Si5aLwDzrU2NQqT1+bCJRIT2uZno0yoH7OGb+e7ctwqWdULYvarhLx6wVB6fD90egFsZaI0NBA1T/xOYDvgsB1Knts2JATrfJ0UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V7io71RW; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7io71RW"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae3f822163so26245ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Mar 2026 14:26:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772749612; cv=none;
        d=google.com; s=arc-20240605;
        b=JkMK6624Zmt/bUP63h2kRu2aO/f5lcfDLa/EeD04Ff/q/PfCasICZs2i+RPjy1Whdy
         ckyGRtwZEA232LRe+it7GOK3OarEYtzZ4fx3ev94NXTVnfyRHeFkYBwWSbFFcNuUtwN4
         7CNc4HKws+i5bJlX7YzOR7XKtHw0YpFa7YHee6SJGIcNSGdubpSRw/hEjk3KSx0z9vND
         kjsEKdKNkWQVHaSLiZoB5NK371Scpb3Bb9wVSQJSJLZTn8OamJLQrwoZBTq8il9zRFxi
         gIGKWXvc5F2nG7rPxR0VlEeDq3epKGX6Xb4vEAqKoEOgZiO4LRHId6kn5hNFhgQz22ih
         fZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2m5LHAUIsWRXiCiFcwbG010Xsn0ZFGYGbLjadSOn3Hk=;
        fh=JAujesVBlQHfX1hxTNJJccgz+yJJN1koQLDSLUoYmkg=;
        b=KwkIGV8aIQB/GxrESBuEMY70qk/3Q3tgYMeWXauuoz0KOEC9QbwyfHcDqksElzv7sy
         S90RDnUle9vyakJXsWtyqUFmcblge44i61545J0/cRfvkIyZ6F56trmPl9/wWowvyRIp
         Q5snNlaRN0vZo9IZmVdDB2kAzMKZOzQFYY3uAEknXz9aj096n78eizImATJ5iS+OiqEr
         /PIg71kPX7ewvhNrRLFHPRZ10wsUlvsIrntOEBRIRlHKvWqGb59VS+f1mztScWyJ4bdM
         A2Z7Ndhyg/4vqn6kmgcIoK4s1f/5LRwdLHLWuRSzH6DgpE6UR5zdIycxpOuXtR+Wdq8R
         EpSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772749612; x=1773354412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m5LHAUIsWRXiCiFcwbG010Xsn0ZFGYGbLjadSOn3Hk=;
        b=V7io71RW4kJN63ONwLUG0/+sqR8KslK3ktFd0ePXwnzuUsLNe5MGLRmU6wmnM4EZcd
         Q+8xyioVeYuGD4Kf1P8PYKZa+8T989QPN4FvFilMTfjZeNuX8MPIl3kYzH3D4azvlAQB
         pZWzNWFr/mHYRbcZK9jSGiSY9HyRoOAFWcLArYpFI/Jje6IE+LVkHpsj/oC33TkzGveX
         DLXGe1mLPBRJglrGdiYPpd614ya+KqyR1nCO5BB/l1MVay5aQ8XkhSOwcxo+T0DenIWc
         om7JY27qrzyR8RwNxH6c3Imrl2sytFhvWUCJF5C8LTrmD+43Xgm4h2fXpVvQgNvIyrBz
         Q5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772749612; x=1773354412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2m5LHAUIsWRXiCiFcwbG010Xsn0ZFGYGbLjadSOn3Hk=;
        b=ilScAQER8Mrm2ur3B26D0FskG2GLL6rQseNGfunYA/vOq3M6Jx3IsFgCpjkzHg2xL+
         zpb3ryA4j8oDle9F5w/PcfNXWZRy7f6K7Hx7/Yc+mfO2N5J0BHl+TFfFRsPy8HkHFxA8
         9NIaifZVkjTEd8R0TqZAxGUhICrQYHtNxU9XSBrOdPVRNzD1MIre1zfGDrlANeJd73Tl
         OXOcpSY4gKHUm7q5lzuSIOFbKCBgFMie9tmjTt6RilWOhNMOY9pfj13C2tOyZ1StlbaK
         ZsAmqAgDpvUWz6dut0ryG9Sy5acgxqPhRr2aiwN+aMmMoXdAW2MVEQMcotjp5schgtqx
         IUvA==
X-Forwarded-Encrypted: i=1; AJvYcCWDIiFqZ2z6G5IPOb25gQoAMAvIb3SNRsnaeoa/aEEyz7VNAucL5E5bhhBzwdeNSdHSHauHpRmPovUvLX8gcf3B@vger.kernel.org
X-Gm-Message-State: AOJu0YzvlpoH8r+JJ1FhV1n4F+iD8YcW60bhIEkdmuTl/Qu0lG4Nt3vZ
	2vdaWrDejGTvdmPM4UuQ5lKCL7kZEWIugY7P6qdLrSBr7h6LAsmFEDxF86ato/COHoLtUvH/2K4
	iZGyMsAEXf1iRx8RRDFUkxQRZOqvsoJBUwqMOOKUR
X-Gm-Gg: ATEYQzyQT5crsILngtYDNkoK46Ni3B1mELVudCWgsYRYAlEJfoBi25qV0t4VrszaVYm
	Zf+JPMhSocQPZGBYwYWsu3kJFvtIM4n+6Lu4GJ5rSMYRwCrBHbOQ12ugighRFVBz8PCGz/krtt5
	6DTVxWo0hUXDgviTgTFuILaw/j/E2DdhHxz1lH44zWltybojP4JcXjIMR3+O9hFLFPko+L334eh
	aQjSLDlFMTXTGGyvqle1DBtmmeIcuv+ZyaPHYxucvHyFmbXiFpCXu5aceKTdOM+EOzog5iEt67Z
	6rgoqZE85zv1lMQ0yuZSWt1zyh2xKnkv/wCL
X-Received: by 2002:a17:902:e801:b0:2ae:8039:fcb0 with SMTP id
 d9443c01a7336-2ae81dca9e9mr346475ad.5.1772749611546; Thu, 05 Mar 2026
 14:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305021721.593803-1-nichen@iscas.ac.cn>
In-Reply-To: <20260305021721.593803-1-nichen@iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Thu, 5 Mar 2026 14:26:39 -0800
X-Gm-Features: AaiRm50C1mmIFxeqYJ_iIgmWwQzE5OQuJx5doQ1flcbZ3ORWXl4Ek-gSQvXb7UA
Message-ID: <CAP-5=fXpwdpvv6bTF18S6tDB0E7KRm+Uz=BwYOM-CE-NOAFKKA@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Fix NULL vs IS_ERR() check in annotated_source__alloc_histograms()
To: Chen Ni <nichen@iscas.ac.cn>
Cc: namhyung@kernel.org, acme@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, jolsa@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 6:18=E2=80=AFPM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> The hashmap__new() function never returns NULL, it returns error
> pointers. Fix the error checking to match.
>
> Fixes: d3e7cad6f36d ("perf annotate: Add a hashmap for symbol histogram")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

More on the ERR_PTR is a source of bugs..

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 2e3522905046..64ab5c36ac02 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -44,6 +44,7 @@
>  #include "strbuf.h"
>  #include <regex.h>
>  #include <linux/bitops.h>
> +#include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
>  #include <linux/zalloc.h>
> @@ -137,7 +138,7 @@ static int annotated_source__alloc_histograms(struct =
annotated_source *src,
>                 return -1;
>
>         src->samples =3D hashmap__new(sym_hist_hash, sym_hist_equal, NULL=
);
> -       if (src->samples =3D=3D NULL)
> +       if (IS_ERR(src->samples))
>                 zfree(&src->histograms);
>
>         return src->histograms ? 0 : -1;
> --
> 2.25.1
>
