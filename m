Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871731F428C
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730116; cv=none; b=Jrko96Ulu2HGTRaEWtaT+zNjulve0XjQie+3oDGuwEMKkVAZ96X4U+Hd3z963pktYRxW7WL3eoBppQ0tVfyP97i7DCgVaOevzvhY8SMVTHcUTXrB8eIP/Hc13J51+I55Ou1hhHIFCc8UXT2nTn9tszQGhYnr4ZwotEtf4CHoXmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730116; c=relaxed/simple;
	bh=pFABHeUoQY0iTYtcJ4akPo9l83Vtn04kLhdTwdzSeGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kjm2xpEyeopL6BHqqoScjhke6rh0l5QwIRQji35GPUX9R6sf4oy1+vZnrNAOVwWGKqv+LTGOQNMI3YX8jEt11vyI4lT41LIldtbanYeDJq2EOg2uV9bklvg+oyXO2790DGDELBkj7sz/WVMTgY7ANAPKT1hyrpi9rgjHoGNxiHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tce2aylL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tce2aylL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35159C16AAE
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 13:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763730116;
	bh=pFABHeUoQY0iTYtcJ4akPo9l83Vtn04kLhdTwdzSeGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tce2aylLuTwJkp5tjrvo9HV45BY43bcXQhLYbKwSeeZfjGseOFeliyQAOjWhaFJcI
	 +mxhfIHytB2afLH4DW230R/oFYafOVUPYiN7jUWqWrt9e3YFRfC3pvrDgZNe3HGGn1
	 h3iPZfY78nLW5DPhcfMzrljOlLgES8nQxFxXUjQ7K4fsCRpjwDCFL5AsR9pqd7ySxH
	 b7tVpmreG4HIcRTWY5x8acgkxyDcwHpvRLpOq0Y/MVrszBXXrE5OtRUWkbXhN/nK4F
	 iL06ikq1zTFM6wuMyGFJWOfGim/tS80lbKOGDdc4CbDUlbJUB8GXYuw04Evk+y6Z9X
	 BS0SMV0I0C9zw==
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b31507ed8so1724933f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 05:01:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBEjGkifyMbX1jddvfj+0geFn6TdlV1Q8I74bzH2TsqIGoD7OjX3nWJ6iZSqplYoAmkixpSLVr9Vi2jlyBNpcV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy2UbeqKYM1QDsdDZTgRuC2cJJy+klihBRHQmMxLRpVc9FWfBy
	9sKpjSUS7WhQumN/DQHwF3nbz+XmLPAoPNvVQHYdDXSvYfHRCqroj0kb4FYj11llIBDchhd4shq
	jeV5DXA9xPAL9xkNxxHnmpyqTvEL8IM0=
X-Google-Smtp-Source: AGHT+IH2WWQx62nU3nXwdjAYaSGbKV/vdvwMmXoWS67FwfXhPZ0YDOvI2r9MT5zCkI2PYga5CpnXhou/x6QgIvB6LMg=
X-Received: by 2002:a5d:5c89:0:b0:42b:3455:e4a4 with SMTP id
 ffacd0b85a97d-42cc1d0c963mr2291902f8f.31.1763730114690; Fri, 21 Nov 2025
 05:01:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121063439.2545-1-cp0613@linux.alibaba.com>
 <20251121063439.2545-2-cp0613@linux.alibaba.com> <20251121-able-terrestrial-spaniel-90c3cf@kuoka>
 <20251121-shortlist-coroner-b29e19293b40@spud>
In-Reply-To: <20251121-shortlist-coroner-b29e19293b40@spud>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 21 Nov 2025 21:01:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRUmUHrTsOBM82kNq2cSYmeYr9NC_ORacUnqHAefFSaWw@mail.gmail.com>
X-Gm-Features: AWmQ_blX7yyP7BZRzgRui-YUVloEOuF-o22dWIaYeG9mowbwvBtor0IGCm44Agc
Message-ID: <CAJF2gTRUmUHrTsOBM82kNq2cSYmeYr9NC_ORacUnqHAefFSaWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add prefix for XuanTie
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, cp0613@linux.alibaba.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, devicetree@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 8:31=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Nov 21, 2025 at 10:01:07AM +0100, Krzysztof Kozlowski wrote:
> > On Fri, Nov 21, 2025 at 02:34:36PM +0800, cp0613@linux.alibaba.com wrot=
e:
> > > From: Chen Pei <cp0613@linux.alibaba.com>
> > >
> > > Add new vendor strings to dt bindings for RISC-V vendor XuanTie.
> > >
> > > Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> > > ---
> > >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b=
/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > index f1d1882009ba..5d28b2da94cd 100644
> > > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > @@ -1829,6 +1829,8 @@ patternProperties:
> > >      description: Xilinx
> > >    "^xnano,.*":
> > >      description: Xnano
> > > +  "^xuantie,.*":
> > > +    description: C-SKY Microsystems Co., Ltd. (XuanTie)
> >
> > We do not create new prefixes for existing entries. You have already
> > csky, alibaba and thead and probably many more. Choose some appropriate=
.
We could leave the one C-SKY vendor entry, how about:

--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -347,8 +347,8 @@ patternProperties:
     description: Creative Technology Ltd
   "^crystalfontz,.*":
     description: Crystalfontz America, Inc.
-  "^csky,.*":
-    description: Hangzhou C-SKY Microsystems Co., Ltd
+  "^xuantie,.*":
+    description: C-SKY Microsystems Co., Ltd. (XuanTie)
   "^csot,.*":
     description: Guangzhou China Star Optoelectronics Technology Co., Ltd
   "^csq,.*":

The arch/csky is the architecture name, which means "xuantie,csky".

The c810 is the CPU product name, which means "xuantie,c810" of the
"xuantie,csky" architecture.

The c930 is the CPU product name, which means "xuantie,c930".

>
> When the vendor literally says "C-SKY", it's hard to buy why csky
> shouldn't be used here. Xuantie is described as being a brand, where at
> least t-head was a company. This seems akin to having
> "snapdragon,msm8660" instead of "qcom,msm8660", for example.
Yes, XuanTie is not only a brand, but also the abbreviation of C-SKY
Microsystems Co., Ltd.

Just like:

  "^100ask,.*":
    description: Baiwen.com (100ask).
  "^linksys,.*":
    description: Belkin International, Inc. (Linksys)

>
> >
> > Your commit msg should also explain anything unusual here, like above.
> >
> > Best regards,
> > Krzysztof
> >

--=20
Best Regards
 Guo Ren
