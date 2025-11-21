Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC32B33B6F5
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713359; cv=none; b=YeBGtU479n5f2x6ytWGIkaE9TYjkWD0Fz4w3ov4hS1QNgqebR+v0CJ4DeQbAklB7dvdJN4Ar3v87MgMxBNI2hRTd+wrA/cwmNsX9A2b6g8SLmmSKihAQs/pJACkdf7Kbok4bBETZ63cCJKsJ4i4gGSY7w1unwHeohcfR3ZpuE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713359; c=relaxed/simple;
	bh=HYNDpspIIvlQrvW+iVhMi8SfO4q/jqFm+sWhmzc5mMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJmPISbUTo0VWrfAiAJeOVyqNwr4qP1xAfZ6TMAQOQq1dV+mvSDJ17m0dHw99Z6WjrQCyGLUVC8gxIAQgYtwrp5BQVCJCOO0S5ULyi2nWmj2mD/HetUFeeJUfbRcUDW/BvaHVJNj8mkbSKJR97ztA0dbEiJI/mPlnyEHF1xhkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFFnTNDW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFFnTNDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45728C2BC87
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 08:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763713359;
	bh=HYNDpspIIvlQrvW+iVhMi8SfO4q/jqFm+sWhmzc5mMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FFFnTNDWHm6S3nVWx6LLLUhjdYwuA4MweY+5foFaJLD8Gp3mAWBjTtX8EtcABAg3g
	 YXmivT5yZoQRUXwb7a/Mm7fWjEm//XP87wJhdhkw30YUrKxgFzKf1GiCSXFqX3muNp
	 IZcvDJKF+49gc2rg7tyR069jEvaeYNYA2lzHER/Qo8i7fsIDzjusqNTZErlCHDi/Qa
	 VMJKY0ZYlkuX4HEv2mEDq80MNVJeDIO8aXwgPYYQX7C+q2CBteD7DkLtFFpyqzXE+t
	 dGZSzgbvVk9P/lX3dugyFbWUyTnWTwDH3PeXVV7zR4fc898C9bT5k3MqH7GefKNty5
	 NBogVKQEexb3w==
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b566859ecso1558775f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 00:22:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJEgc30HW8tEikQYN290q4Nm8V2zGBruJxF6wQEyPu7QpHgzeERsde7GeereYBfv7EJw+PCZgUacHxxt4e8Jmw@vger.kernel.org
X-Gm-Message-State: AOJu0YyracHGq/xrT9LSpwMCAexwsZytBtnbkR8yu29bfg0hkAjfYKdT
	qIctCM3iMwr69ydP2dPSfWNHVlCChKTmEQjEoerc3cnfsT49Nn6SgOKRNXUevG6sGvhcOI2crga
	4V5xTjNOc+rzbC21rXvIWiwlkFWSaq+Y=
X-Google-Smtp-Source: AGHT+IGUTC0KIr8VzF4dB2PYL/35xms4GHTL8V+m6O+4W4E4J+pE2dP+DxrlgkmaLJo1VtMewWX9G6RonD0G+xBL+TQ=
X-Received: by 2002:a05:6000:1a8f:b0:42b:3dfb:645f with SMTP id
 ffacd0b85a97d-42cc1d19d78mr1388711f8f.47.1763713357676; Fri, 21 Nov 2025
 00:22:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121063439.2545-1-cp0613@linux.alibaba.com> <20251121063439.2545-2-cp0613@linux.alibaba.com>
In-Reply-To: <20251121063439.2545-2-cp0613@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 21 Nov 2025 16:22:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRhatsOVshRHZSrxcNLktGCD6xK2MF3=qTtjkqm2-A8JQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnMD2gejPZX_v0rAyljbsI6Oke2xFh30nSFLiY-NGQAnJTIyn8eTijEau0
Message-ID: <CAJF2gTRhatsOVshRHZSrxcNLktGCD6xK2MF3=qTtjkqm2-A8JQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add prefix for XuanTie
To: cp0613@linux.alibaba.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, devicetree@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 2:35=E2=80=AFPM <cp0613@linux.alibaba.com> wrote:
>
> From: Chen Pei <cp0613@linux.alibaba.com>
>
> Add new vendor strings to dt bindings for RISC-V vendor XuanTie.
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index f1d1882009ba..5d28b2da94cd 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1829,6 +1829,8 @@ patternProperties:
>      description: Xilinx
>    "^xnano,.*":
>      description: Xnano
> +  "^xuantie,.*":
> +    description: C-SKY Microsystems Co., Ltd. (XuanTie)
Yes, According to the "Standard Manufacturer's IDENTIFICATION CODE"
[1]. The manufacturer of Code '0x5b7' has changed from thead to
xuantie in 04/30/2024.

105 T-HEAD Semiconductor Co Ltd -> C-SKY Microsystems Co Ltd (XuanTie)

The XuanTie is the abbreviation of C-SKY Microsystems Co., Ltd, which
belongs to Alibaba Damo Academy.

[1] https://www.jedec.org/standards-documents/docs/jep-106ab

Reviewed-by: Guo Ren (Alibaba Damo Academy) <guoren@kernel.org>
Signed-off-by: Guo Ren (Alibaba Damo Academy) <guoren@kernel.org>

>    "^xunlong,.*":
>      description: Shenzhen Xunlong Software CO.,Limited
>    "^xylon,.*":
> --
> 2.50.1
>


--
Best Regards
 Guo Ren
