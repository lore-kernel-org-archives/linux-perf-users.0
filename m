Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC4F1F03D9
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Apr 2025 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313121; cv=none; b=pVNlMTmP93HJ0PjrrJB/T5beYXKcp6IEllofo2D0esK7SkwMZwJRqUouuDxHoOBZ6WCV2wxXVMK1lh9ePQnvdTrPM+J+yetP0I9Jk1/hzVcVnP8/QRJyG77UM/chBjTr3PrAW4K19XBc91v3FJmCuKL1f5sfua7O0rACYOuF1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313121; c=relaxed/simple;
	bh=HxMXQ3xc4mDvaapysGnC877OYn6XVsmfSDsrTgWCYsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAk6ORmtB7JQVqCPrXR9bQUEMRYU10rSpF33+lhhQyvRoCutmiYIJFSWGroiDM6/JUTAlGWW31rKV3Vc5jRNcoxMDIxTaBTxqCOeniG/SY2YBP91EjncbD9U9YPuyjNRIIxlSJTm3nUyICbwF0r4QQ7Tnn/yr8zj9n0AM/g0YmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AlIzmfrQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AlIzmfrQ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-440685d6afcso45752935e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Apr 2025 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745313117; x=1745917917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vNQhtMzboJsKqrUjFlhlWpbiOnbOUnEHjsqB+mLSfIY=;
        b=AlIzmfrQHujeUK/EEdpGhI/gxMsOtaQ3f8FfmPvPp1CVYrZ9A0NxqIJ8ITSsezUrQB
         pJaQ8wI2bkV3sokRhGdU1rD/sxHVIFJZHDizQwWSiewspM2ejjAMAyAx8c6rlK+fhQRB
         Nem1U05Xm8HtqM0gEmevD3XcvGva5xijfg8pJJzL7O+3dqVUblf3mcia3f2bok12KrvP
         rSEtBE/4A8N04omNGParl9IsTr+fRlnLlSMoJkKEXTkCQ/GmPFmgVwsPYFd33baRzuQm
         g3oxtPsWrDIgaSlhUQoO+cSZ6K57/yp3xjkuH255UwerdhpRDG5Vc6bGE0PEKEIw4m4e
         /ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745313117; x=1745917917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vNQhtMzboJsKqrUjFlhlWpbiOnbOUnEHjsqB+mLSfIY=;
        b=w4nWtCeKoS1S1v86e3gpLwEcRrO3+2ieSSPtKoCT0RIFhdEnmtiSFKIWFvgnBs/0Oo
         RJX2SoKD2CbbKUU45O+SGnX0w+RZiJ+t5T3yh3B0Mnqk46A0WIsjjpc+Jd3G3afUbsgE
         cMLlQdargf9ks7TQsSPncTDuVr+WX7r7WahQAh7BADlZ/ixvW/c+65QoPinfDB/fqI2g
         5FxrTJ0negrtqJJaOALBHzRRq8an3oMLIgAY+iBeeCmBd0/A0BftN5QbOX+s/iBg+hHA
         st8SWef/50hyoPHODYTaAF6ieUn6oZxsL+ymw8gzRNXIH6EZbcBR6PTrnONRGaDmGdpA
         Uibg==
X-Gm-Message-State: AOJu0Yyndsy1XTq84M17QcD7+e4RKkvufXJdyMLUBmu5OrB2Tg4q9NdX
	/Wz7Pdv37eRhVCBIYnwwLWATfmJYqiDVtZGBTdpTTZ7iirmKbYFT2oyhIaVoYgI=
X-Gm-Gg: ASbGnctbzoq6dpyzJw8S1NISyIHC5tlgW3yVxP8F5QlhhQMd4HVp1eelHVUMNB8MFTU
	Os4WuIMrbcVRXi5zTWCJZkeBPtwAi29Hx6WZUhPcJwuEAA/CY1sb9IxcqTM2rbEWdYLWDbrm0Ce
	j+u9INwxE31/PfxU6aphtWHSv7AU2xoSzJTvMqR2NuSx3IM9cZRdfMjWBLZoBIJ1NLhFqaB66Fk
	TpYYd1fuYBcB9eqXTYi7faR9I3n2EXuR/EE3DiytTOkctoIVD/JikcpzX0BWy/R7BWz/5QuIONI
	eOYE4c5kNGMeDPZ9eZUMNsTP9JDukrI3cbLW6/2xNpw=
X-Google-Smtp-Source: AGHT+IGPpbum0KsQcE9z8vl2RfdveoyjLjKiZigrimsFoHNByQt297/k0WCP9oipkvXobXbABwmLAA==
X-Received: by 2002:a5d:5f93:0:b0:39c:140b:feec with SMTP id ffacd0b85a97d-39efba384cemr9947675f8f.7.1745313117068;
        Tue, 22 Apr 2025 02:11:57 -0700 (PDT)
Received: from [192.168.1.3] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4933e7sm14681335f8f.65.2025.04.22.02.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 02:11:56 -0700 (PDT)
Message-ID: <0f2b7c10-a30a-4d2e-ac3f-baec1b45d945@linaro.org>
Date: Tue, 22 Apr 2025 10:11:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools headers: Update the include/vdso/unaligned.h to
 sync headers
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
 disgoel@linux.vnet.ibm.com, hbathini@linux.vnet.ibm.com,
 Aditya.Bodkhe1@ibm.com, jiang.peng9@zte.com.cn, venkat88@linux.ibm.com,
 Tejas.Manhas1@ibm.com, acme@kernel.org, jolsa@kernel.org,
 adrian.hunter@intel.com, irogers@google.com, namhyung@kernel.org
References: <20250421034143.67607-1-atrajeev@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250421034143.67607-1-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/04/2025 4:41 am, Athira Rajeev wrote:
> To pick up the changes in:
> 	commit acea9943271b ("vdso: Address variable shadowing in macros")
> 
> Addressing this perf tools build warning:
> 
> 	diff -u tools/include/vdso/unaligned.h include/vdso/unaligned.h
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
>   tools/include/vdso/unaligned.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/include/vdso/unaligned.h b/tools/include/vdso/unaligned.h
> index eee3d2a4dbe4..ff0c06b6513e 100644
> --- a/tools/include/vdso/unaligned.h
> +++ b/tools/include/vdso/unaligned.h
> @@ -2,14 +2,14 @@
>   #ifndef __VDSO_UNALIGNED_H
>   #define __VDSO_UNALIGNED_H
>   
> -#define __get_unaligned_t(type, ptr) ({						\
> -	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
> -	__pptr->x;								\
> +#define __get_unaligned_t(type, ptr) ({							\
> +	const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr);	\
> +	__get_pptr->x;									\
>   })
>   
> -#define __put_unaligned_t(type, val, ptr) do {					\
> -	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
> -	__pptr->x = (val);							\
> +#define __put_unaligned_t(type, val, ptr) do {						\
> +	struct { type x; } __packed * __put_pptr = (typeof(__put_pptr))(ptr);		\
> +	__put_pptr->x = (val);								\
>   } while (0)
>   
>   #endif /* __VDSO_UNALIGNED_H */

Reviewed-by: James Clark <james.clark@linaro.org>

