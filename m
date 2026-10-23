Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792773383;
	b=uvli7SqH5ZBV5y6TqMyv81wNV3pVSMKiDouakyl887DujfR6I4ivW0/eNWMmMjlsFwYl
	 l2swDY7kkO8uAx9tQC2DAhgrv3LaMzboacFl6n8QPnwZGO2UosbNcHhVFBYOFYQ+1XcUl
	 UZa7Fe3egOyrvbqZxKadKutHSTIOhLfRM6z7O70gD5xSufk46e4C42jl/GWp9tSRzpYM2
	 nEl6v+fZAmdxZQH7Ke1qslJyIfygKSlr3RpRaiNaZZ02451ZoGesLaGCTWZ44XKjKLT5F
	 SfuJ3yUxnWSVlpVN+6BlzFeVy57v47taul5IcBSUocag8XfWn0mTOVEu/Hvdiv8DvCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Usf2vtqHFMLa5VutOOQ/gk9DwHwlTcl7zL/PTMHYhxo=;
	b=Lp+q8vUBiO/c0CMD9yEObo1c/+o7gmx98xvXBGTToAJeGM9X076/LDAdbY+nm/wJu3pl
	 zsCyULEiJL2FskEGjrNTwpDg4OwdJhmf3z8coc4lo3rp4roMDr2Td3O2b1sBNBoonPuiR
	 rpYYV9wM8Qu6Wqiyp97BQiipBOmNF9+XZUvJE1mD/oTpUUh8ZR1ZGvp8iCgIb/ZOVPOC/
	 cYKWWYLifqvZE/lXxHUmStA84BahPalV0qYFqo3e2AOwlneWVk/Kytdbqs/hGlvPA7qIM
	 j7qfi7vTXZk/fhv20mx0O8A4oa7pZHSVDQ40Htr57H5MuX68JEeDBxWY/xxIkMcCLhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="kYOnhQj/";
	arc=fail smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C058A606A31B
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 16:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C058A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kYOnhQj/
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5337c7b9937so373611cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 09:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792773382; cv=none;
        d=google.com; s=arc-20260327;
        b=OL3NlneplQBvVozaGqTqeogq9MyqyuC2s/QAr93i0/ZLcsG5qKLmikVLkXR3fHK4ew
         z5kt9ElT+bDq2WHAy3yaAzkrBnfTYZL3VkkRVYxM+EQQ/C6niAfh2EaXyxSOBsWnSbJq
         xatVQOhZgeZaI6O33G7wVZMuhbv0jGU8kFXWedg07loihMwETJr/kwEUM++EGyTcSDBA
         pMwi7kmrlb0TJob58fgczwJj3MTl+buTK2gjkNNycwS64TXvpDl4Q+mBM9n/48GQrRHH
         rOuh1eeexq4OSYwdtlGgMOG9TuuJelBHramu9tqibxs5OprkuVI92axaBXzxckJV+3uk
         YNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Usf2vtqHFMLa5VutOOQ/gk9DwHwlTcl7zL/PTMHYhxo=;
        fh=Ue70aZOmPQp2S3ROLcScNjDyIY1Z8Mi11iM1zkU2jUU=;
        b=BVhAI+F/oJmMRwfduWz7ojwDGRjveNXTKwP7B+eFPbpW7bn/0qIOTw4icVBQ6oBqn5
         7xb1k4oPDZOLr86eLqsn/xTSQpQNiZz4NJdLRDgN4FllbHUAEEyUOW982qQXUfrWiLMm
         DDxvjNdkuJJ14F9caSdu6vi8DdBZ6gXZXeEkyEaW+P4jTEw+jw0HgLrko4nWMkJp3Mi1
         4CpZZF/8PdVt3vINrqfbqThklYQGKBeX9e0XYPUijJaFqJKs4KCN00o8nD6SiLA02UIU
         46YAzXzDTw9TbVvMMqs8VFhovdJ/fKS3EDcddi7a9hEfWUtju2xO/z9fbLeaPEUJEcOs
         FwgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792773382; x=1793378182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Usf2vtqHFMLa5VutOOQ/gk9DwHwlTcl7zL/PTMHYhxo=;
        b=kYOnhQj/ogjjwa1uKOTGZH12sq2xwa+4X/n84jQULPO1tiJEQ+DcHPSXjbvNJYzDPl
         Ect/kvPL5WfJnQDD6Du9tBsWOGFs23nErQ6yH0+Ds1KwjyaTLjowTDqska7WXWMpTfbc
         7fAbGq++2EUHZo2NZOd5f9K+/C7zWW8bfBwsU5tmnIiSrEtnzhtQkqw0atVCpKQm6kb6
         gwhEe/BV7ufIQCa1oOwB0WpU6v8rjSQ2aLE4aWl5Lejko7RK1GmIpd3W3J9hFt7YwTEC
         kFKzZTQn4I6Cjw/VJ6Xe86v0UGJlLCr0G5hmxWmR8BQ8scko4GKol6TSVLfwDgCMSUMW
         W1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773382; x=1793378182;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Usf2vtqHFMLa5VutOOQ/gk9DwHwlTcl7zL/PTMHYhxo=;
        b=YjPCsYng6NLOzS4k55td52t3HxojVKgUTXjzqtn/lXSxH0G8PQ2dHd7GISJ3M6Fnff
         Ldq4GjVkHQM/CLKXWkx+QiKR1QgAtyRiE2Bc+GyeYrYyYv9b3kj3nJcnf6S1ikA+1qz4
         bC7TmJMhbUMZUjU2W8CWY5+Feweam9htexD9ILOyJCqyKW676ATXFlwyn+9KPxffplqh
         X4+qnPvhcNR1tsfrY50Sxbt+9xvKLgASBxWADvWXcUoQycX+R469jDM3DGNkpD2XYQG5
         yYf7C0wXpCVHWLcuSdil/1o9m7jWKbA+1W6YaTCTR7MxFZg4L27+l28gRWG7RcS17EMA
         YUSw==
X-Forwarded-Encrypted: i=1; AKwUvBxZFFzqjcw1kcLF97D3YracVjnq1m2zz190heSKZqNcvXqpFS5FPwk6Hp7z9NuK/5ExUQJ72wuljFHBz/w/+raG@vger.kernel.org
X-Gm-Message-State: AFq9FYK6kJeEI/l0yoxn879MkA82NqJc5GXEz+CzuOZs+awVvcqSoFDb
	q3P7XZ83493/g4DknTuknUd958ln91QbnarOcFVzLWE75pVRs1zAOBDpKqvN9w34Vo3GL+Aiof9
	LJAP3XORGcfKjxMlCbZVE+Y0GCrAtGnAuHDci98ox
X-Gm-Gg: AYBFou2k4npwbrxGKmq7vNxW2K5ByO6wP1edgNYyCF1eLX1gUxRaI4tNMpb5CJqhrNh
	A5ZRqBSqJ0YjCMKwg1torXtkcCXDzCBa3NM0HI/exroEKW75UqHSzbScyiW96tMcMIn3D6Ke5Vf
	B0e09vyILWJnrMNOG3IulLL/RgrH5fbI+9KfxDZRVoZSoyi59QYeV7xd/nmmHKzv5rz68UNu2ZD
	YjfhapcRvh47VHpJMWjKGwigIUPvuGN4k61CZYzvjKzYTdYbqHq5GRJcT2vE4SeC2YdcKdAfEY7
	3JFTZcoH8jHiNQ5Ij0OJ4K8cjA1YCMeU+5hpuCnIo/Rrw45RG0gY0R8BjlstqBR2+18TxTq1XR0
	u+U0HsTkygXkhZxVlHscH+EMIjQbgUtZ8VoP0O26qIEe2hong/+58BoUoXqSnfJ9pKw==
X-Received: by 2002:a05:622a:5984:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-536c204fccdmr19376021cf.0.1792773380998; Fri, 23 Oct 2026
 09:36:20 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021223905.715051-1-irogers@google.com> <20261022201453.1717523-1-irogers@google.com>
 <att_boYgsUyMVBQQ@gremlin>
In-Reply-To: <att_boYgsUyMVBQQ@gremlin>
From: Ian Rogers <irogers@google.com>
Date: Fri, 23 Oct 2026 09:36:09 -0700
X-Gm-Features: AclHuK8WDiSB5DLq7nz-VotGGBIQIYDZRwbhaBSVewZSiH6-vm_k_QRci59FMgE
Message-ID: <CAP-5=fX2+o1CCV7pEx9=CbAftRse1m5uTLmrTxQ4NWrxd_SnTQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/19] tools/perf: Adopt kernel compiler-context-analysis.h
 annotations
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, ndesaulniers@google.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 8:48=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> It doesn't seem clear to me why you are constantly respinning this series
> without feedback since v2 (AFAICT)?

There is a minor build issue that appears in the tools/perf build with
kernel header code we try to keep in sync between the kernel and
tools. There was discussion on resolving this, and I believe this
settles it (the tag was carried forward to the newer versions):
https://lore.kernel.org/linux-perf-users/CANpmjNP=3D4T4pRpoiW_Y442KQbWyVtEC=
UD3_SYs5ZYrdwkWh2rQ@mail.gmail.com/

> Also not sure if in-reply-to is perf style, but neomutt is struggling wit=
h
> this thread at this stage :)
>
> Anyway, it's no comment on the series, but my workload dictates I won't b=
e
> able to review this unfortunately, so could you take me off cc- moving
> forwards? Thanks!

get_maintainers added you presumably due to the kernel header change,
I'm happy to drop you and stop the noise - sorry for this. Fwiw, the
different versions are addressing locking issues the annotations are
throwing up when adopted more widely in the perf tool. Whilst I'm
using clang and internal AI to minimize this, the stochastic nature of
AI means that new things pop up from Sashiko.

Thanks,
Ian

> --
> Cheers, Lorenzo
