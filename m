Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBCB6A8A7;
	Tue,  7 May 2024 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715056829; cv=none; b=be6Lb3DWpWaDXPVjIEO0+SrcYZRxCToHA1cuHRxDAv5uJG/G4kUj/sywa35Aj9ceB1QKKQFAhQpukVFV41jOGmOpT2Q9XtDCIjx81Yq7kgpRUgNxvhhKiIda0tbYprjopp+eQKlEwM/+2qvSFoHUSC7A9IwrAwWasZJRzT20hIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715056829; c=relaxed/simple;
	bh=32tjm0gXv+At6ci6xcuU+wyx8uYN+jM9Jkcb4EILh9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fu/Dz1tPQJDiQLhAfAkjJ1Gt0GEXye0GFmYpc6EIb1HVpE4k/PdDiQkosowLhEPZsFwezyT2CzWDfLHa5aGepORkxsgaSNU+047NLFwI+AbpmJUZ5YrS0ja1NXHjPeaWPbN3dIRCtj3vwSjCt+14F3dXmq8MiEfXi9NRBqq0CpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so2523440b3a.2;
        Mon, 06 May 2024 21:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715056827; x=1715661627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGLcXpXfQB7UP2yJQ9aG+ammKIDK8VLtkTKX2sseVsw=;
        b=VBD+qB/ouB0uJHksK2Ee+RsS0mj6P1aJtIm80mK9WIUUMGvkfOs9w4bUsEKE657ma/
         u82VsOzgKjLngkU4QqNt4LbBpyhS4bgCXL0iPUSt71yUhIR6m3YO6IZ9wLgdwsw0MIsY
         yEdGsYlTjG515VNAcidtJongXJ2aOr06Lq/cERRPuboE39sggLkOgmzSGSWIaU0+j9Kb
         MSOK2issezomuzTldsxAEo6T0wOGcL2ynOTlIYQ/6RbrsCpNacJq7/D162Xd7YMePpIx
         kD8PXEYK1SdXFuwCjmUQTAjviKrgzJ5fYP774jMsaleEkb3XzM6JbK2JrN2feGwwBy7b
         9S+g==
X-Forwarded-Encrypted: i=1; AJvYcCXVKZBSnfKpJtUKgX5/cP0mLwQ8p5eqXWKIzdAt2veGwijsW8RW37rQVivMvaR0uoX1R87BAFKxCEXerd6z2XA4lOwFcGkZ8ZIQlS+Gc2EVal2LVIKpSVtxl1PmoyoXhzToo9xKsFNwTYoq9Iv24w==
X-Gm-Message-State: AOJu0YxyRsYuuL91fmzv5GV3CHuAv9W7I+U8LmRr4FVjZNRTRsGrrYWs
	CKBitp/lyY3ETaEJc1Y1tpDnhScXFMM3nBd7IBIJ+py0I96nSckAuq7vBVeWwGVxtIIbsrd7mDN
	swgWTj1rRUptuX10VLWMD4ykjHLc=
X-Google-Smtp-Source: AGHT+IHiLizhGwF4eGXYOLN/AvZXFQ5be5OLPsFdc4WCc51CLXFzNfw6aTdsJYNpMwWQYv4+Dj4cvCa9ERL5Fjl2Yms=
X-Received: by 2002:a05:6a21:3994:b0:1ad:7e4e:428d with SMTP id
 ad20-20020a056a21399400b001ad7e4e428dmr17580223pzc.20.1715056827313; Mon, 06
 May 2024 21:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506121906.76639-1-atrajeev@linux.vnet.ibm.com> <20240506121906.76639-4-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20240506121906.76639-4-atrajeev@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 6 May 2024 21:40:15 -0700
Message-ID: <CAM9d7ciKUQErzu1Y7FnWCryW15xUkyJLSt-Jez9h8TYgp-tLjw@mail.gmail.com>
Subject: Re: [PATCH V2 3/9] tools/perf: Fix a comment about multi_regs in
 extract_reg_offset function
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	irogers@google.com, segher@kernel.crashing.org, christophe.leroy@csgroup.eu, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, 
	linux-kernel@vger.kernel.org, akanksha@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 5:19=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Fix a comment in function which explains how multi_regs field gets set
> for an instruction. In the example, "mov  %rsi, 8(%rbx,%rcx,4)", the
> comment mistakenly referred to "dst_multi_regs =3D 0". Correct it to use
> "src_multi_regs =3D 0"
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index f5b6b5e5e757..0f5e10654d09 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2093,7 +2093,7 @@ static int extract_reg_offset(struct arch *arch, co=
nst char *str,
>   *   mov  0x18, %r8      # src_reg1 =3D -1, src_mem =3D 0
>   *                       # dst_reg1 =3D r8, dst_mem =3D 0
>   *
> - *   mov  %rsi, 8(%rbx,%rcx,4)  # src_reg1 =3D rsi, src_mem =3D 0, dst_m=
ulti_regs =3D 0
> + *   mov  %rsi, 8(%rbx,%rcx,4)  # src_reg1 =3D rsi, src_mem =3D 0, src_m=
ulti_regs =3D 0
>   *                              # dst_reg1 =3D rbx, dst_reg2 =3D rcx, ds=
t_mem =3D 1
>   *                              # dst_multi_regs =3D 1, dst_offset =3D 8
>   */
> --
> 2.43.0
>
