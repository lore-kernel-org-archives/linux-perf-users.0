Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795102699;
	b=jkzaJ24a2GyTGfzhb4E+eG2ukONjn+hJIpTTMvuPaCCwuv/MBq3UhDSyOZtP3eY+S81d
	 S2qDnrUNpH2YaYsIYHrqgsfGBRbiALGJ3i5O3Xz2bbznHAlTosrTrzbu5vFcPmqTXDOvK
	 U+o4/7cVRdC16oIzm3fJIQNFdt9fTyBgHvJj1jn2DuDwqOTmZf0l3LJWyajG8rAAd/ED6
	 zmgVQva58k+GX0Hs6UWf305YWRByi1IJ0HxoO3X4ZkNJmtPkSyo4EH5CKcLMcRc0G5zgW
	 UW1xOmbbdQ+hmyxpQWuKy8NjzRk0cvGi95rd77o7pz0O/PY+c/xcjlPNH+Wkfka00jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=drywv9X/QD6GTy9pDjLa5PABODeuHIP48aMyKh24UjM=;
	b=nPAiXBjqrp7UDOcSPdOiVy9GOKr9J57AxAE2vsCOJipDpa39Ucbk0Sm+PbNT7BrG3J/L
	 VkqIGeyTSplpIkzbtuevmxpZlp8SW+y7MSIJywO3A8eRp9MbpmjVm8ZUxj6hiX7jREAum
	 iMGHyEDmcI/h6HbQFOKOInZHrHTcYelH5NLXHmTGYgu6WfPKWrVuTr4GX1UmktWcy43dA
	 Khke6OZUvxf0fMmrYcTsTPsTlasSE/GXYh9LwXHJp6yH4TcpTxnv0ZId2GtZ/oTAlu7PS
	 n2pKmCNnORxAxhkhnhkdBNp6k8Q6dDz4sL77LBNQMo58PfxcPiJT4epr+BrJwv0KlZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=l9wqPPh5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826AC606A334
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 15:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 826AC606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=l9wqPPh5
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48dee593f18so2386020f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 07:38:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795102693; cv=none;
        d=google.com; s=arc-20260327;
        b=GPYEMF/oubTvnv/nWTHlekBMxpVxRSe5cFuAniMQXtjQK8ZaDdOLlRHSsCSZ6a8M3d
         0pQf5uW8jp59podXNzKDs80VTL2RB3tcdX4ucoX7TyGgqygFoeDydMlVjjZlBQOqHD7z
         h2nx2k/BWFx5l2Gl6bSJgCAvIxVrkf3WjWR+lK77pEGQZhokJvTd+9KgHlrUCofKDPf/
         PNXCk8JjHHX8SMer+aHgJ4GakxpZ2I/eo7h6NxV5BqY+AXPdnN1R/O/hW4a6si15ItXQ
         3NAFVd6yHvTN7ESEPlCadw2by8XnqjOva6h1LONASjAJobJ2U2EKerVZEmSJBbi//yah
         64/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=drywv9X/QD6GTy9pDjLa5PABODeuHIP48aMyKh24UjM=;
        fh=YLu6/b8IMNATh/lr2RhTBpTdCIDxaCVzFcofEm9+V7E=;
        b=dZrPFTaGQmBSpFpLEx8mQbDySoinTKkFlaopBMMVeYi1/SfbumGGPMncj/CLuxkAUq
         vFLIYIQ2qKJVCvxNlm8wu3zierPSCFALT37mILzbyPQKrFPF5BUKClK3pU/wGkMU4Y9Y
         6K5aq2dPOTixufTmtCNSG+7kkq6ehe7iB36w0XvyVR3BVlmxx5iPYgJ9//QZBfGlRrbF
         EjnAQqCVGkHmFD/OxTiSGtKr63kU674YjZuxsXBMseJ4uZjyIAW5XgB6V0N7z+x8ManQ
         Ihl5gUJNGIy5ShHt8MTiZJCOmAHl99iYVP+uMdNbGe1dagIChD5TJL6QvKkpY+j/ygut
         v58Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795102693; x=1795707493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=drywv9X/QD6GTy9pDjLa5PABODeuHIP48aMyKh24UjM=;
        b=l9wqPPh5HAOPk4NvNfOoXCp9UFZt0jF4fJuFzlhGeawYtptb+gtWbzOsk933HOggcV
         gmrWI40zgGAVf0b2Rc4WuSWSxmqNANkfDkkQ8pMG0CjWEER+nI5FHtMkKixmM+9lkucI
         g3gMbdKtaU8mAkgC/MxW6muRBq27+stByNyKvhaqUsvnVfuISB8/r8YexQ+PeMrcncvM
         vQZRiRm1uTB1Gvgkogdwdaw7Vc1Trjj/d1iulvsvNKXFE9cntCxgMvnRZZUN/z+dLJCU
         9478GoyQiTkG7QDOI+ATjIQqiYR4wh41NerHKnqzQYvskYfHCSBPBqeDZ5YJZ/jALlde
         gRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795102693; x=1795707493;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drywv9X/QD6GTy9pDjLa5PABODeuHIP48aMyKh24UjM=;
        b=qK5jqPGNBYngmrtzCXRKEag/Y8MFZSfNX3FKda27Li07R6s0W7x7969Ln48u5mn9of
         pW63wQZuO7NFQ3p6aJ21MY3Db4HcZ5PoDymtKzRjNkgMwIjoI18rtmYhRGv8JYNNcC09
         edd5B+cRRiTA07dbn9/b2Q/12RtoukEYeW7017k2zPlLNlSZ8ycxr+H64CFdjzKIk/t5
         //QgvEus6h9qKE7C7SmR4o5PsOEZ5Xg0kEjUhVMZLd/FF9TD2hq8k6cECde1SA3bi4xV
         fMHDgO5661B8j22QYe2OG4yaOrUUhhT+ZtVmwjBMougwIZS1UXQzrB8qJGbdMYDaC41G
         U58A==
X-Forwarded-Encrypted: i=1; AL+hErEcFI2i4L8Xag127WsBNzdpI6YlH/W7cL7FH48jk3lqcAPoD3dQ8EowBlqqgrFiI2JnQwvvmM6Npkcc43YZmF8y@vger.kernel.org
X-Gm-Message-State: APuU4Z/p5KUYiAuQngB1FhjpIWWsc7HkwBtNBJpP1JZHYax7vpYoJXUo
	wv0EpWbxMv7+zVEz5u37Ans6WnfgYgWK5WVmIfjsf4hX/sdwQywYogKH6BB8cdu8s+5tQi7ME2i
	vFf00iuwxTXj3svuh+JMVP/p2GL7e9ctdGvCWGarCxg==
X-Gm-Gg: AZFdTZefOeq2Hct/AKmXNWSNz95s/X3fqT+ysZj4CFKFrlYtVnnxkK2lD4pjiWX4pm6
	pOufTQg/1H2wfCAy2+FvpTyQ55hx1kWKRw4RzXSO2Exj2HAOH446oDQLxOB/zysoOWbe8z02JHi
	O+/LWl5IBjK0B21s7bOnTc4TregUF1QDFjVi520ppXq+BJi7B/Zs1q8tfR/ZYo5rPo1ks3VU9wF
	dVvqqrlH9n1tLESY7vlUp7zriMFPvKZszntlYH1di6QC2RBamERrcI4ramTIaF/UhAz5E7XChpr
	m397PegTUh2MHQoOoMFAIkb+5RrTkvXNieqTB3IDaqDalrJ967fqK7icuZgG+GI2ts0GwOHoA1e
	3CTE26ZdANsJB20eRWUSSNNx7m5jm4buVvchqQ/wWKYI0t+BOMNyh6gofMyMZ6eXX9mpu+f5Ojn
	cqAwrEpH64C88ofiupvcG/nDwHtErEehfvGRU6oIGskSD8OpRXsp7tuk1a
X-Received: by 2002:adf:e009:0:20b0:490:1881:80ec with SMTP id
 ffacd0b85a97d-4a63a895742mr10073341f8f.36.1795102692730; Thu, 19 Nov 2026
 07:38:12 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com> <20261118095053.3871267-8-vikram.singh3@oss.qualcomm.com>
In-Reply-To: <20261118095053.3871267-8-vikram.singh3@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 19 Nov 2026 21:08:01 +0530
X-Gm-Features: Aa3M54qqVopLHoNkItX81APze_rfhpoAK0QlJ8DY6gdjSieSVn8liCJp7Smx0no
Message-ID: <CAAhSdy3KUqSqERnw6khG13mXKcaCf3UeG+FqQAZzeeNZ7S7GfQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] dt-bindings: riscv: add Sxctr ISA extension description
To: Vikram Singh <vikram.singh3@oss.qualcomm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, atishp@rivosinc.com, anup.patel@oss.qualcomm.com, 
	will@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	beeman@rivosinc.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Conor Dooley <conor@kernel.org>, 
	devicetree@vger.kernel.org, Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 3:21=E2=80=AFPM Vikram Singh
<vikram.singh3@oss.qualcomm.com> wrote:
>
> Add the S[m|s]ctr ISA extension description.
>
> Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
> Link: https://lore.kernel.org/r/20261106173942.3175069-8-vikram.singh3@os=
s.qualcomm.com
> Signed-off-by: Anup Patel <anup@brainfault.org>

As mentioned in PATCH1, drop the "Link:" and the subsequent
"Signed-off-by:" lines.

> ---
>  .../devicetree/bindings/riscv/extensions.yaml | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 79491ef8f86a..dde2f28cfda5 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -202,6 +202,13 @@ properties:
>              mechanism in M-mode as ratified in the 20240326 version of t=
he
>              privileged ISA specification.
>
> +        - const: smctr
> +          description: |
> +            The standard Smctr supervisor-level extension for the machin=
e mode
> +            to enable recording limited branch history in a register-acc=
essible
> +            internal core storage as ratified at commit 9c87013 ("Merge =
pull
> +            request #44 from riscv/issue-42-fix") of riscv-control-trans=
fer-records.
> +
>          - const: smmpm
>            description: |
>              The standard Smmpm extension for M-mode pointer masking as
> @@ -263,6 +270,13 @@ properties:
>              mechanism in S-mode as ratified in the 20240326 version of t=
he
>              privileged ISA specification.
>
> +        - const: ssctr
> +          description: |
> +            The standard Ssctr supervisor-level extension for recording =
limited
> +            branch history in a register-accessible internal core storag=
e as
> +            ratified at commit 9c87013 ("Merge pull request #44 from
> +            riscv/issue-42-fix") of riscv-control-transfer-records.
> +
>          - const: ssnpm
>            description: |
>              The standard Ssnpm extension for next-mode pointer masking a=
s
> @@ -1189,6 +1203,21 @@ properties:
>              - contains:
>                  const: zicntr
>
> +      # Smctr depends on Sscsrind
> +      - if:
> +          contains:
> +            const: smctr
> +        then:
> +          contains:
> +            const: sscsrind
> +      # Ssctr depends on Sscsrind
> +      - if:
> +          contains:
> +            const: ssctr
> +        then:
> +          contains:
> +            const: sscsrind
> +
>  allOf:
>    # Zcf extension does not exist on rv64
>    - if:
> --
> 2.43.0
>

Otherwise, LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
