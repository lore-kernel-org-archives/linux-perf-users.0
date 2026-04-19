Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8240DFD7
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776610918; cv=pass; b=XmdSEM3UjCE7uMQ4JYmeodrjQEjqM0GbE1fwiaMAqO++vKzCDRw7ECAywuzqx4KTxacRCftN+nY1Dmr6W4uk8pW6SamXkra6vLxxte+6xxMpFH/mmOnNvqoN4rrvuMeD3y/teWyRh1ILXcmFfMvhkG9OKfWxbJs4yaSW5RClB2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776610918; c=relaxed/simple;
	bh=oajmnfUT0ewEISMxls8cp07i4k5MNYH63Qg3BrPwfTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cz62tfCsecj1vK4wPmBDq7bK6xjKYwFz1LzRN9vw1P8Dzxecu3Rnhlrr2NHVS+QQBP9/wWh898QE9MtYFlypvL/ajyQxElh3HfjaZebZyahYJGCkx+qYUAH5T4zHt7IHx8PqixUipkHqvwL3KJmXKDSlrxu3Nj+i0mCQQO1qMnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jP5d7BXv; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jP5d7BXv"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1270fc2bdf2so8759c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 08:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776610916; cv=none;
        d=google.com; s=arc-20240605;
        b=iee/0R/jQQ82Hx9/FNvKIAyGUMRZLC2Cf9JGvSCyDyDeiDPS5d/7coBtq1UjZm5MEy
         BV4w6rK8GgXNGBASbKF8adlai926sCmFCSYKW+k8Qh5wASFFXZ/+e9rTDHf+c8vpRscd
         4KGDCCPl6EuUiVaoAuKnUC7BGy8NYeOeJERfWT9DeBdUgT6RXSfh8paq6fOozZbg82sm
         lytCP8jE0QOO+x64MIDViNOgFMIixGJwyR6fwpV9NFtsdZJuFnHhDmkRNBerl7QfBMYd
         LYkD6DorFkbGdj4mUhdAy0NpTV2XUFoKmPBp0QgNI/ElG2J6REUasu/YSQBk22TbDqcI
         4mig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EO7gB0nQmhkZHYAXrduT64kOSIDUwU/IpbCgv7t2Vks=;
        fh=PpezhjMR9xcL7Kc2cus+zxivQTx1/j2A1QHaZFw+LqM=;
        b=k/y9QtcxQ5f+s/nAuvvu8+v7UT8AGoeqB2TTBc5S3qC/wdw+PuTm31dIizk93BZFVB
         lvGa1Ce5YuQIKwosEMznX7RIdym4kqIzvtzeCcUpEm03bd2VnaNklfXePoPt3PIjnFBL
         Xs6FfCoDSrJUb66DDUe8WAW9necKDYLBbVEiG3kvLmKH8rSuyOVPeALj4wop3DZ6Ls2f
         ClpXFXO+eaou1B4x++oXacnI27DKiP1xQ83M68rnH0KxylDFf+XZjJe2rJxMTOmHe18q
         eEDjJCJ1UPFNhJxxaV0fcmvLIIMJZWeqlCYY3a5G6mCtu95xDgD4PX+jK6ie8zQnZUIp
         t6Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776610916; x=1777215716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EO7gB0nQmhkZHYAXrduT64kOSIDUwU/IpbCgv7t2Vks=;
        b=jP5d7BXvcwNVjM20UEiD9ex4aGzM0e+Sha8gOXVAHC+8tcqYxza9qQp9hUREbeL2oZ
         Wl4w6dj8DSfE+wL0cwbGZEpvYGO7bibb9Lssr53/RiQ8aqtVPvzrx5VMkEdNnPBcfHI7
         KYOVbQ8G/bbhTXCu4Wful/BJhF70XSdRLSlQBzOLDtWFLEtcF0jDgw7jjN2B9CC4ZInS
         c+Pw0xhQ4LsHnKMW/6yJe25DYfdlORXAmshJ9fV9Y1JuqK16QV9mmpTOZEe8+6AF611H
         r2YdiYtcgrE91TRL9FiljfCM6znomgv7xCNHGqLXNTf/ryooIofQwK47xApSxNRcoX+h
         qmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776610916; x=1777215716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EO7gB0nQmhkZHYAXrduT64kOSIDUwU/IpbCgv7t2Vks=;
        b=kDWFtNRypk//P9Z+WnotjTHpWaTxeQN2OCqpyLgBZkjt+7GrvneuuehH8LrHaSEhwV
         uAsvi7Ehf+VkMGrLH84bE1msIul+aCAvsT0ryAV4I23bfTufpM3uy4KMzU6pdkYJhUv/
         mD4kyrcdInO4QXOtkaki1q1642xDiwJj/oNPjN/B1nMLwxZRVUQjMh+hB7/WJjiZ3ylN
         A9NfCb93enk2zDdCWfa6m4Ehzayq5uNbtV7L0FyoiC8gP6yiE3cn6L+tyIdjgaGu+XO1
         GwlWKn3/KReqDH0NPHc6uEgK5x17BIBsHeCssWAO2YdIjUg+E/KY4uvcL9pIqZTSlTr6
         MJ7w==
X-Forwarded-Encrypted: i=1; AFNElJ8e2rYFr+2PZvFXSSApNDNABiF4Ds9BJJ5Xc/nd5WdN7Kg6zF4XQ20bqCBJkWox2xF5mNd18yMsRsLVgZumLc8+@vger.kernel.org
X-Gm-Message-State: AOJu0YywekxuuB0On+Q7yVjkRLwjVtYKOdzzQFJnTFlTgMmABbhbc+Cv
	bnBAyEx2hLzfP9mtfaokusdXVTAXRe1nY9YbOUoav7nmoHxBmbxuA/FWzIPnSM884v6IJw33R3l
	K2quvj5aXMhMkyfjh/zcJ5/sNlBgLm98LtWR4yXOD
X-Gm-Gg: AeBDieu0r5DCOBgGCipEPgpZyMoyc6cREpM4ZpvRhGnOVhhzC5NFgdZRFcxjBfaX+vg
	Sle4HeMdBTbeQVB9iQgg6HTpnoKPzgPwPgoxmc/HGBZ5IFqOUtv3Kyqs9E7zP9KajyeMXV6TYcY
	qQ0zuMJeJ7flO3ibWLgAzGkcbFVmWgf47J82BbsNXr/YvOP7pu2TUREklCnXeWBEUgNE7uOXMop
	BJ7L7wdMtjgCJtaRFUcREYzTsU2/N1kDyxuBIdmfoHsjCuxy53gTiYJaMbjLN2UsKQcX6OSVQ1e
	8VFtc6QWQDDo8grMxm/RvpB9tvZH4A==
X-Received: by 2002:a05:7023:b04:b0:12b:fa7f:e24b with SMTP id
 a92af1059eb24-12c7b2570b1mr107867c88.13.1776610915457; Sun, 19 Apr 2026
 08:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419090756.2190201-1-zhengxingda@iscas.ac.cn>
In-Reply-To: <20260419090756.2190201-1-zhengxingda@iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Sun, 19 Apr 2026 08:01:43 -0700
X-Gm-Features: AQROBzBStw1beLm8GiHCmsv5MOwelYHHtOzwIKqt0bbRh8Hc1as4FPv9pELhQFw
Message-ID: <CAP-5=fX=+2oNYHDqsNnFrOZya=RxpnPFF_ojZTQP8v8Umt951w@mail.gmail.com>
Subject: Re: [PATCH] perf unwind-libdw: Fix stale object reference in arch/loongarch
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Shimin Guo <shimin.guo@skydio.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 2:08=E2=80=AFAM Icenowy Zheng <zhengxingda@iscas.ac=
.cn> wrote:
>
> The arch/loongarch/util/unwind-libdw.c file is already moved to util/,
> but the Build statement for it is forgot to be removed.
>
> Remove the stale Build statement.
>
> This fixes the build failure of perf tool in kernel v7.0 on LoongArch.
>
> Fixes: e62fae9d9e85 ("perf unwind-libdw: Fix a cross-arch unwinding bug")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Cc: stable@vger.kernel.org

I think this is already fixed:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/?h=3Dperf-tools-next
I also sent out a fix, fwiw:
https://lore.kernel.org/linux-perf-users/20260305221927.3237145-3-irogers@g=
oogle.com/

Thanks,
Ian

> ---
>  tools/perf/arch/loongarch/util/Build | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loong=
arch/util/Build
> index 3ad73d0289f3e..8d91e78d31c94 100644
> --- a/tools/perf/arch/loongarch/util/Build
> +++ b/tools/perf/arch/loongarch/util/Build
> @@ -1,4 +1,3 @@
>  perf-util-y +=3D header.o
>
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> --
> 2.52.0
>
