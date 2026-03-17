Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676D325A357
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762756; cv=pass; b=uKZQsd/JRUM85wEnhw6UbDYjkQZpJJdGvUUindW5gTgvfCfrH5+0uGT1Rtj4Nhk3IuH59YL9SqqIAWqxvcA9qlpdnioILRq1N4gwTHadzR3c9/Tt+YhfJ+oMUBlMCQzlRKcOLPwmAOxwCk5km2hzKp0ohDwTnPIAaqiZApNydFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762756; c=relaxed/simple;
	bh=jE6FqVyFcqvuMSIvjeoAKYl8wLaKhQ8ouJqR8s7EErc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWdQm/rx08vJDvtQ4PAFI8qVaNtvuBHsAUKoI8dkxmNxTIrFWHeZtLzvNYC+Zuwd2n3+bFtBjZxLhaV13dnG/cbJuZIZHtPbS2DtyoxbBujncaLPOvIyhq9jzJwj+wnZR9wzVL9MUKlLu+4PgHkufrhhfFyTR/2uJgk/m8+Orlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g+gJDQ93; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+gJDQ93"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aeab6ff148so92805ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 08:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773762755; cv=none;
        d=google.com; s=arc-20240605;
        b=k2tMDGnQ76K+08GGCeWknMtuyDWElKUuT2AlVAnoCZAkoEgP7CnvnTqGkOAOPuVcTs
         sfg1iAt+3MzZRHXS7mtBsArmu7MIebYTkA6VoOtGZ95dXcic9a9rPzb1vfbLciOf6+kO
         FEeitC8+7D3FnGaQ2o6MPN2bCJoW5xu/IjM0KMS09yBLdeGjoSgHzyY75sEQ2t4drWG6
         XcMM0i+v2VWazrnjXOdMSV1Q6xJXBsGL2kCnDOTYSSqO9qIkNlyBdaV+bAqY3jrmnMZi
         mGFa8sKUPKqZe+4zj2IwpiyJfvwS8qO7Tt7AK3HuMDzZxJAuEdBmXyxuk8VCY4idTh4l
         xgdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=78NN58kMKAj0P9I0QnI1xQxgwS8ArXygA2+hFYnQ/u8=;
        fh=AV0Mll7kZWlrx8aC87xw8MUVFR35o+yT9iQIC+UGtLU=;
        b=OV1X+UMAmYbZQ/WT2JeYPzTRqSmMga9Gd7Kzux2/qro9eYXYZvv7O8v2NXlPIqau79
         C2/hnpeA+v3bTBK0qpbUSt9J0nf6o39KLstSKi9Ub5tCIyOOJnM5cetFQE4S22smttHA
         8OGgh1ZnRbE/30lX9AYp3Yp46BrgJtTp0snmuNwhg0zRB/m8Gp9rVdzgQJlrelaxY3LD
         poiTFmmMOP3y/479sJ4orB9LfaJ/yPsCk+LBPE9kkrIfw3YcD6G7SQsED7O7tFUWs8/p
         9FhPB6gv6GuSSLDXx+9mYnZ6WJBEblDMxhMAvIOdCLO9JXb1tP33969VuTlHHuTL3LDZ
         heyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773762755; x=1774367555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78NN58kMKAj0P9I0QnI1xQxgwS8ArXygA2+hFYnQ/u8=;
        b=g+gJDQ93gGMAFllmTG8D9hTxkC7mvPiSr8TUUZkn4Fq3vtls4k5qP3/FvMCVQfVe6s
         S12BVqIpku3VNyGfJmE4Rav1e7tTx+sdvQiwvysxXuXVNHGmC6AVLbNIzoe/YdiI958i
         MAI5wA5SF8LU9nv9T8dLCdLARUI8vPsiKtMrH6d0oQnixVqw7JBo4MkxDXVxDrxL+LO+
         TLLXB6QeoE2xjwSZEVnYG/0ASziXVAwa/XMjLyHZvh6+Aji5AVxsa76itbKKMB39hWa/
         +dw0tOBI0gXNgEnKGXGcvZvUgF/HlPPlMPHOFbNMnWpKFVCiwThNEiVdc+sldcO9rsm+
         B8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773762755; x=1774367555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=78NN58kMKAj0P9I0QnI1xQxgwS8ArXygA2+hFYnQ/u8=;
        b=tMrdzsW6/sw1DhgK7V1koHGurOG/Vey1aIWh7QbuKQw4cOkt/DppG9imDotxag5EN5
         sqBYpkqOtjL/XFPiqdLNnIeVCbnPv8qJIfphbwexmkpUkdHRxP3eVLIJk4r7yExb/1ME
         DAnwp/DtG7gPd8p61xJ0GCHpBeNHzh6UXjE36MhAMs7rkY/4Uigz5ZiLlz0yxULrhLB4
         9iDvs+zZ2Rtf4fkv1SIMoRgPe+TcpGSwG+eBwK7/Q1hKKBa3Wm1fhYteu+Orxlt2azb8
         cY0xplxQEDyvxjrMaWs4PNT2VkXmJjcMdeQ6L6U+h7heSLHCv3iT5I+INCmrR04CPR80
         9Ogg==
X-Forwarded-Encrypted: i=1; AJvYcCURNwSHbgJut/rYE9G9KakG5DywMJtSWbbj2VR7oy69pYMss3LSfXUazzxsXcfEc9d1Eqey2qNiuK0EDMLQ8aV1@vger.kernel.org
X-Gm-Message-State: AOJu0YwEIGYnrZnQ69HLjdcISJde4sreoO/DqndyueUSEiDuhrLtzOS9
	zi5lEJH85knJipREygrRxeH8H2UfWkHq7HVkW7Tkhf1djDniNxO/tPQmfRbkekC1XpmWGsA++eN
	MokeXTkyp5FAqRJ1IYQMOumAXgWmgKc1nBzG47bVx
X-Gm-Gg: ATEYQzwVLv61vojZUxKULxfVO2SpLptVLK/UxSnYT6krOQAgTuG1YAN8w95eXKWnEMj
	+gEebvboZMd0rF8APzTJNi7uquEd9F0+IIRLqo9rtDsEhepdBsWagyJ8DPpNjGNHTmN48aurKRU
	Dtwasg/MiNzEhVJQ16q8IB0uw1u1eiuQWd/BMlz2A6mphan4tdCQ+Qdrv9C4UV4MnVOYgZzYVZ6
	iid/urj23LbXfAu3u2cIX/+PQw07KaecrYgmyzhIQzIFRrFKmYvandhL38cM/mZ3Svju24ettkr
	F1BPv4X/iAziTlqeR/0=
X-Received: by 2002:a17:903:b8e:b0:2ae:5d57:c94f with SMTP id
 d9443c01a7336-2b06402f708mr3378095ad.16.1773762754144; Tue, 17 Mar 2026
 08:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-tools_fix_build_libopenssl-v2-1-9362c14f04b8@arm.com>
In-Reply-To: <20260317-tools_fix_build_libopenssl-v2-1-9362c14f04b8@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Mar 2026 08:52:23 -0700
X-Gm-Features: AaiRm53UVAFZ96XCYdDHpKloysLEvHYi68DkAEV2Y2uy66DKKfycwPKF0D-Gth8
Message-ID: <CAP-5=fXopOUKZ=Hf1s5CZrb0CmH+W9XQa38JW9Bv+GXdYrcHnQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools build: Link static libs for libopenssl feature
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 1:50=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> The perf static build reports that the BPF skeleton is disabled due to
> the missing libopenssl feature.
>
> Explicitly linking the libraries fixes the static build failure.
>
> Fixes: 7678523109d1 ("tools/build: Add a feature test for libopenssl")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/build/feature/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 1fbcb3ce74d2173072748a417fc63bd9a5b13888..18a9abf6bfc43e86ecf58b96e=
0374a0e3c613bb0 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -384,7 +384,7 @@ $(OUTPUT)test-libpfm4.bin:
>         $(BUILD) -lpfm
>
>  $(OUTPUT)test-libopenssl.bin:
> -       $(BUILD) -lssl
> +       $(BUILD) -lssl -lcrypto -lz -lzstd

I wonder it would be better to do something like test-gtk2.bin so that
if openssl wasn't compiled with libz and libzstd things don't fail:
```
$(OUTPUT)test-gtk2.bin:
       $(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0
2>/dev/null) -Wno-deprecated-declarations
```
so:
```
$(OUTPUT)test-openssl.bin:
       $(BUILD) $(shell $(PKG_CONFIG) --libs --cflags openssl 2>/dev/null)
```
Since "-lssl" is a dependency of BUILD_ALL, that will probably also
need updating.

Thanks,
Ian

>
>  $(OUTPUT)test-bpftool-skeletons.bin:
>         $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
>
> ---
> base-commit: bb551508e78c886e6d3bcca6c744d3bc3fd8ad59
> change-id: 20260317-tools_fix_build_libopenssl-8290bfebda3c
>
> Best regards,
> --
> Leo Yan <leo.yan@arm.com>
>
