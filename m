Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D338F633
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713911; cv=pass; b=WvinpsxAxroUrEpkPyjlOca9zgpFuolMCOe7eVkH7Q/yTgNqETP0PzpE7Rg83zxnjzly5Xsv27ww2cEM3+tbQ4PwlOvmX/GdUqCe4LF0v0uNI9S4e4p4otf+g16kx1t/P4qlI9kUtG0qb78CeE3pVzRvTZMsJY1h4g3sYrZoM4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713911; c=relaxed/simple;
	bh=i1H+K9jkJuLF3cDDGMza2xPD61PoNmnTbtlqBy7e0cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEu5CXgewWkuJqYKzASXQg3rFoZISrTC+51t8OJ3sQtkaJLnRb87AYkeCbFHM87MKL7w3DxTao5MPsCbYWCRhh32RJ4i7sVM/fCaRDzPAjuHYYcbZPHkQx04kMGjpCjYlkCTj9lT/W+FmKbaOZvnHwoY4t8TRLlLJBRXbWmL9xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKYbJ+P3; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKYbJ+P3"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba180a022dso15175ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778713909; cv=none;
        d=google.com; s=arc-20240605;
        b=fv/lspfCL5YrkAwqhqfQchvTkh+lC7rJM3ICdIWLQn5IZnirqrbG7pRSnWOYyjZcNq
         IGAb7cZIo8RMBG2JGgRJnfNb1QOqI3RM69W1Rl4o61Crxb3mO2M0dJ2+hKfxfy+v6x1s
         accSQcztURu+ZVtjkVIpITvT1v9fKWgfhyRTfqyKGpis89fG9TcCWHBj0o3WlBzgHREy
         IoprOHFezi73DpYpUa3AqEpI3CPYxR+CD2tJEiYWBTC8acoOgvcHkBwwyvqgi5mmg4gD
         2ZVYVfgAUSVRJBIEOPfnsd5IqOc5KpfIW8ALcvpb7XjZd0/H2h5+uOoIf5Wbne4SkOko
         OMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y7oHsVgzONedd/NOQ/D+5RaAW0/IiAT14ms3smWc8EY=;
        fh=STiQgPuH91cBr1tFwE0jRiK+98BDSBK2whh0GHPDomg=;
        b=Mv9BEq8G4599VG65/nzgwyo3D3vEKtTWf7poSj/FIL6b16MzeyrKbVMUhR9e8NHef4
         ypy9pQ/UcKFRlMwk5z6jyrUc6YdUcrEdKD6+QcaOUa9kAI6VqjW0U/eagxRo0cxV2LKR
         LP/NvoCuX7x8FgdBB8/TPKrEBeVtWeOkR5U/1J2Jhd2K3cxpBPGj5pD6I+PxWSP5+F3I
         rLRzK4clJN6FPVl9450e67Hd0uLq4yq77tviukvEW2uGcW18swNEhdsM3VvAqEuwwWf/
         gnZ+oxOWNsgK3Uv0f24JqqDWAZmpqz+nEYJf4lpfz/GxPqGHOhWTw9+nQTpFO+jG+Ng7
         dvGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713909; x=1779318709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7oHsVgzONedd/NOQ/D+5RaAW0/IiAT14ms3smWc8EY=;
        b=VKYbJ+P3a9lZBgo/k0WGmhKGokJ/1ZqLbrmezxh82XiVNfT8xLITILKK8Cy2ebQvr0
         VPOyRg+/hoPkjuBx4u1krfZKyqXO/FKOOuCx9gGg76ViQQ4YievnBxVAQ58A+1DV2MVE
         8dVbpuZD0XpmoArroTn9mBBtKlXtW3B9VXmLRki2eNteIzBMRLL/EokypUaAEVwogszo
         8mgZyHGr9/9UAiG7B2sG0Rz2rRocH+qtdbmGjk12G4hnDQA/y6aQ4/61aKmOiPzkYfUB
         EDiXclVnWtWEHY+5eiwXxZ6zI7OmAEaFvN3buaUzsxrsnoMTEHtxNbr0ZN2lnf85nQMp
         hejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713909; x=1779318709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y7oHsVgzONedd/NOQ/D+5RaAW0/IiAT14ms3smWc8EY=;
        b=aHouQolKpj24hIwGjbeIrPy8ckxjqJJXo5hD0jg1hjYvz398eUmK4vM9E0ItGsyuXl
         pzeo0m8x5Bj7KmQ/yrnFCMzQa/X+BN4PzoAH/mcUXuhnR4oRcfOVjUeL66jgJrz6shEx
         gawsLJsKJS5mGsu/Z3zLvPLjmSZICgIGzU5VZFEA/ILOEEKSinVigyGjdkzrP4v7U4NL
         zWDpU4VpdJl3ei8tkLn/DRjwkwNuqMx/wAUVs/nWiLvibMEVlkaEHnC65lBZs+6rnv7W
         T8RPyr+DqAiWfQR/TXDCOXDmV7S/PFrP4h9K7CWKEjzdMW6uEeSJ+NuPOq9moKHCkDF2
         sIAA==
X-Forwarded-Encrypted: i=1; AFNElJ8BrbtQaFxrhLM/mZbxHcSKmvCnxpG3RK70YqFFJCUgW2Msb3XziI38PK6aBBlYj0ib43BOGup++PbGkZaGNXww@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lEQaqRWY4HySShoCb5tCy5SLU3Pm3CB3IVkfUZsge+JPT50R
	72593j9F3T0VE9TAKLZ0d3ctndbJx8JwTlDPw2c2o3tCVRyk4gFie/SlNCLTHWbU3Kf8uyuUnL2
	mtZE8NduS8qpf1Q4OLij+26ZN9gEslCE/ZfLtbq6P
X-Gm-Gg: Acq92OFyT2m7/Vi1aXqLWzx+i8WoKUbhd04iyV0j3FEjIdwF5ymoD2RQTspIAqGjNMN
	ln3fR8jnVRkqoG3nX4B9p5ehN+DRkWDSKuSkgwviPhiVm3u+L9PCRfMOzuKuv4aaSui+xrROm4+
	n/+VQzKwoUC9a/XutW5iCgLFE0pOgFWuk4P/EKDUgF2PyFcyg9NvBjCn3DMYfcDva1MiRpvff0+
	CfSnl7rxn19zDOUBs7FOYveblAxdvhpxU4n8hm4bece7TkCdAWF5x+76S+NYUvCS0a1M8QkHgYK
	qgPJerLexHtrkkrFC0yR6tYnjpG7iMc/pY8QNdaAvj8D1pk=
X-Received: by 2002:a17:903:37c4:b0:2a9:5ef5:399b with SMTP id
 d9443c01a7336-2bd5e59a451mr755895ad.19.1778713908880; Wed, 13 May 2026
 16:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513154851.1085334-3-guanli.oerv@isrc.iscas.ac.cn> <20260513180721.1179904-1-guanli.oerv@isrc.iscas.ac.cn>
In-Reply-To: <20260513180721.1179904-1-guanli.oerv@isrc.iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 May 2026 16:11:37 -0700
X-Gm-Features: AVHnY4JI3zBs2s7CKrkzH-aajogXxsqtGXv-WR7gpfwi-u81Dnspy4M5jx-xnDM
Message-ID: <CAP-5=fVUPH4cry7kkp1H8qx4-bJQuWOw+oPJPXYk8fHh-PoCBQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf riscv: Fix discarded const qualifier in _get_field()
To: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	palmer@dabbelt.com, pjw@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 11:12=E2=80=AFAM Li Guan <guanli.oerv@isrc.iscas.ac=
.cn> wrote:
>
> The assignment of strrchr() return values to non-const char * variables
> triggers a -Werror=3Ddiscarded-qualifiers warning when building with GCC =
14.
> This happens because in newer glibc versions, strrchr() returns a
> const char * if the input string is const.
>
> Properly declare 'line2' and 'nl' as const char * to match the glibc
> function signature and ensure type safety. This avoids the need for
> explicit type casting and aligns with the design pattern of not
> modifying read-only memory in the perf tool.
>
> Signed-off-by: Li Guan <guanli.oerv@isrc.iscas.ac.cn>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v2:
>  - Drop the auxtrace decoupling and weak stub approach as they interfered
>    with the cross-platform analysis intent, per Ian's feedback.
>  - Focus on a clean fix for the const qualifier issue in RISC-V header.c
>    by properly declaring local variables as const.
>  - Use Li Guan as the preferred name format for consistency.
>  - Verified that this fix is not yet present in acme/perf-tools-next.
>
>  tools/perf/arch/riscv/util/header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/riscv/util/header.c b/tools/perf/arch/riscv/=
util/header.c
> index 4b839203d4..891984e909 100644
> --- a/tools/perf/arch/riscv/util/header.c
> +++ b/tools/perf/arch/riscv/util/header.c
> @@ -19,7 +19,7 @@
>
>  static char *_get_field(const char *line)
>  {
> -       char *line2, *nl;
> +       const char *line2, *nl;
>
>         line2 =3D strrchr(line, ' ');
>         if (!line2)
> --
> 2.54.0
>
>
