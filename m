Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DB312A15A
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279910; cv=none; b=TtQszp0jxQKNqzAw33ePiPJpsT8RIExXpDszsomoF6/u7eiT7cdeV3F52GESsZQsYYHWqqgYaCt5SnCunpMiJrJPqH7IeOUEfDwjy0rDyMbXAztxS9L/BjgxYer6IG1lJeTUmS3viNgQEFGqpkE+VpdDc56zrtWU+RyPqLA9Zrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279910; c=relaxed/simple;
	bh=TZeXcbtKOMozMWJ/kUHSgG1n49qX5lbSr1iuS7NKbrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eh2i4q4r0qIiDsBnMYes9qfM4Iqx9yUt0gWwjC/xRGqGIeopy1fW14/t+UEXr9pOpG15JbxB0jvx7ggpdUH/Q3h0c2q7hx60peFNTs8uniQP+6b9zLXgV80HiPgZHhW7ieW6vh4omvpIHBBwReiipCQUdRN23cv9sX+kO5GNoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j1qMiAqO; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1qMiAqO"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36a3a4c9d11so140705ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713279908; x=1713884708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApDEEOzWKbr2lAoaPzmlzkmuB1oGm6TlwwUuSX/oB4U=;
        b=j1qMiAqO1Djo36OTvW0c2h41BH1PDT6QH7S+g1SIvOZkgbjO+8Fap/r47ET47SohVF
         /oLElBDRUelBbxtCRkAyHivZKaIoRW3ocvDZRSRIE0xoXvioIaemMBuhgqnXQwfFsLbL
         xvwkKcA22gYC4hcGfqocb4VencKMPK4Wx0eX52NuRWZo5u07H2eFsWG61vPTzwcKJkZQ
         95bn+mtDmpCoiPbnTiICa9oDgvGud9WKVJF6FFB4oqHiF49G4ZF6XP9yKvezfnfwOWo/
         OIHtOdEOBwWmXihC7/v+Xh8yJeFwo9PM/T6Y0g0HktmhVY+IpFk7nibst304EE9w6v8l
         2SUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713279908; x=1713884708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApDEEOzWKbr2lAoaPzmlzkmuB1oGm6TlwwUuSX/oB4U=;
        b=O/5lkr6Ql3SGD+EvG15RN2kyLsG+ovqbVthqBkfNg4A7usjJdSsIvJNjkVqC34Bqr3
         XuKVqKY7U6+nkYH3SfCyCeB7/ZRcoLfhKTKCnP3KpRsmAMzyvpUDl4hJiPz2KjQmdZ2O
         SCkumR5qBsmNNryWGJizVjMF9r4118eoTD/nSXce154Y6ajUQQs2vF7tWDIZEs7CW8rS
         UOlFXx5eXtMNgjajWeIXMllI3qc3XQjJxyIrfXmH7x2teLM1NhI1SimuIrq/aBEdQclE
         Xvrec/y45EoBGmHDp62QAhxHj+FbPacYpcTh1smKRxAn/AeVSuYa9w6LVDi7cj1UwwjH
         PpCg==
X-Forwarded-Encrypted: i=1; AJvYcCVK09C/oZ7VkF5rrZ/pO5FQ99OYQ3OTRLlgm8ClYO6H44MjekcHaQxXVI4cjNStafdZd2g/Wn2tkvSbtUd/MOSYN6m6SOnHNYzBsxgdfSAjVg==
X-Gm-Message-State: AOJu0YyWh4rfYDKH9BToWJm3wcapPrOwcsdLukxP05y8b0BdVkKr75FV
	0uEDiLMd+qBVODXjPgKCC6MFQquUKR4wxCR/oPpYUTRjBb3OOzSeWMkLqSRyS3HE7Xk0LqpJWtj
	LTJmrOvwD0GXR0R4LgRUCLT1Uuap44VmI6zXf
X-Google-Smtp-Source: AGHT+IHvWDLJmei1CN4y1/p2zSA/lQX+UTvY0I6sNXRKd7s7bQlKSOTx4dMhC3HH0AIyV6T3oZc3Drm71XkXXTumgbI=
X-Received: by 2002:a92:c5cd:0:b0:36a:fcc9:64ec with SMTP id
 s13-20020a92c5cd000000b0036afcc964ecmr186375ilt.1.1713279907511; Tue, 16 Apr
 2024 08:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415095532.4930-1-cp0613@linux.alibaba.com>
In-Reply-To: <20240415095532.4930-1-cp0613@linux.alibaba.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Apr 2024 08:04:55 -0700
Message-ID: <CAP-5=fWZSPTtk+UjssH4Mhw11CAP0-jZcZAbCesdqrVCnZbu2Q@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix compiling with libelf on rv32
To: cp0613@linux.alibaba.com
Cc: palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 2:57=E2=80=AFAM <cp0613@linux.alibaba.com> wrote:
>
> From: Chen Pei <cp0613@linux.alibaba.com>
>
> When cross-compiling perf with libelf, the following error occurred:
>
>         In file included from tests/genelf.c:14:
>         tests/../util/genelf.h:50:2: error: #error "unsupported architect=
ure"
>         50 | #error "unsupported architecture"
>                 |  ^~~~~
>         tests/../util/genelf.h:59:5: warning: "GEN_ELF_CLASS" is not defi=
ned, evaluates to 0 [-Wundef]
>         59 | #if GEN_ELF_CLASS =3D=3D ELFCLASS64
>
> Fix this by adding GEN-ELF-ARCH and GEN-ELF-CLASS definitions for rv32.
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/genelf.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
> index 5f18d20ea903..4e2e4f40e134 100644
> --- a/tools/perf/util/genelf.h
> +++ b/tools/perf/util/genelf.h
> @@ -43,6 +43,9 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void=
 *debug, int nr_debug_ent
>  #elif defined(__riscv) && __riscv_xlen =3D=3D 64
>  #define GEN_ELF_ARCH   EM_RISCV
>  #define GEN_ELF_CLASS  ELFCLASS64
> +#elif defined(__riscv) && __riscv_xlen =3D=3D 32
> +#define GEN_ELF_ARCH   EM_RISCV
> +#define GEN_ELF_CLASS  ELFCLASS32
>  #elif defined(__loongarch__)
>  #define GEN_ELF_ARCH   EM_LOONGARCH
>  #define GEN_ELF_CLASS  ELFCLASS64
> --
> 2.25.1
>
>
