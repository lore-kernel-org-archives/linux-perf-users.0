Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994E41E5702
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728962; cv=none; b=tx1bOOYmYc5aliksze6NdTD4jCK4Mw3rqk6GWDggCR2CWvi99RxD4mkp3hBjjyWfk9sdenOtkqNBuiPZm9O7l3hmns5WGwPi0K8YQ53SoPT6RLHxJV1QYUZDbqUuSOqsxaqfouvHd2+3qxGz1TUCsTLDUjt4a6KI1IKPRyOMosI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728962; c=relaxed/simple;
	bh=eCiKRyoDAzKNcTc0XsJk4iW3vQZugoEMQp0SQuxx7CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BB8yrZTAfYPhZsPfoeOUtDO8JeYoN3cmNLYZGKB5m2yZu5QdZVpPvrPkc/WJk2Uk5U/lp0HRWeLdlvpsf0uenRz85JR1qLWq92ACnYO1481CAAsIzVsPwMbb6j084GaGjAouVIY4/P3cGY2qTr+TSTdUgiREI4s+Jh1/vq8bLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjHacC/8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjHacC/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4EDC2BCB3
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 06:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773728962;
	bh=eCiKRyoDAzKNcTc0XsJk4iW3vQZugoEMQp0SQuxx7CA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VjHacC/8FdACMbK6ZQ3iSWuPyV3khiCNBlCPf3ZLxirZ7gQYmgHytqYXG3Ss3utf2
	 ib1639oiQIddZPKO2RsdlurBgzHCUTBD6nfwPntBJ0jCwPOiVmrF5QekBOCS/H5Qq1
	 xgjOCXElPosQY4Hlf7LebOJXJsxbPdh8VW/n1Vk5Rm3TxeA5ETssbdfPtDL+3XaBO9
	 /JuL6bfB/vHVk3051d91dpGc8ApeJbBhBPWEruW5YTgl6LWvZhTvO/ZKKaEvS8GBVM
	 327YTigTfgIT0sCJbIgWiv5EYe8k4ZFfiJIIc/Qdr3scZxGE5xWJtf9W8sTzTLPSXm
	 n8212MZTDwKLA==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so63965335e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 23:29:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhB8RaAV1zf30TficqUncCD9EzlSmbKR8R6TzOBFHZigeHwCvjhaHbqN3H1Ac8aY3H8HoUQRUFrs+ljESy7duB@vger.kernel.org
X-Gm-Message-State: AOJu0YxyM5YIm9HxQML4FJeZa8mItO5Uf6NZYOJUbQN9CVrj+nB6WRA2
	N7C2ca9QqSeMcI6Gq6mESs8zmTJdrY9wjJ95vfFqTNuv/WgLKS2p25bBuNS3L7TtdrMelCkAheN
	2sxnoXDovGS2lrzI+ySgwvUm8KzPm1HY=
X-Received: by 2002:a05:600c:c4ac:b0:485:40a4:364 with SMTP id
 5b1f17b1804b1-4855670c2a5mr259125285e9.26.1773728960630; Mon, 16 Mar 2026
 23:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317034847.4136-1-cp0613@linux.alibaba.com>
In-Reply-To: <20260317034847.4136-1-cp0613@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 17 Mar 2026 14:29:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRYfvFCeHx4yxdh8tfn1GLTC+UN7vtrTokmkmb2Z6=vKg@mail.gmail.com>
X-Gm-Features: AaiRm515znQBvPe7b1QWk6C1XHuW373cVtMlbUs1J4rEm3b0iHNiaSsIo_5SmLg
Message-ID: <CAJF2gTRYfvFCeHx4yxdh8tfn1GLTC+UN7vtrTokmkmb2Z6=vKg@mail.gmail.com>
Subject: Re: [PATCH] perf symbol: Add RISCV case in get_plt_sizes
To: cp0613@linux.alibaba.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, irogers@google.com, pjw@kernel.org, alex@ghiti.fr, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 11:49=E2=80=AFAM <cp0613@linux.alibaba.com> wrote:
>
> From: Chen Pei <cp0613@linux.alibaba.com>
>
> According to RISC-V psABI specification, the PLT (Program Linkage Table)
> has the following layout:
> - The first PLT entry occupies two 16-byte entries (32 bytes total)
> - Subsequent PLT entries take up 16 bytes each
>
> This aligns with the binutils-gdb implementation which defines the same
> PLT sizes for RISC-V architecture.
>
> Update get_plt_sizes() to set plt_header_size=3D32 and plt_entry_size=3D1=
6
> for EM_RISCV, matching the architecture's standard ABI.
>
> Since AARCH64, LOONGARCH, and RISCV have the same PLT size definition,
> they are merged together.
>
> Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc
> Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dbfd/e=
lfnn-riscv.c

I don't think putting Link here is a good idea. Just copy the part of
the psabi spec v1.0 here:

8.4.6. Program Linkage Table
...
The first entry in the PLT occupies two 16 byte entries:
...
Subsequent function entry stubs in the PLT take up 16 bytes and load a
function pointer from the GOT.

For others:
Reviewed-by: Guo Ren <guoren@kernel.org>


>
>
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  tools/perf/util/symbol-elf.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 76912c62b6a0..806936d95523 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -372,10 +372,8 @@ static bool get_plt_sizes(struct dso *dso, GElf_Ehdr=
 *ehdr, GElf_Shdr *shdr_plt,
>                 *plt_entry_size =3D 12;
>                 return true;
>         case EM_AARCH64:
> -               *plt_header_size =3D 32;
> -               *plt_entry_size =3D 16;
> -               return true;
>         case EM_LOONGARCH:
> +       case EM_RISCV:
>                 *plt_header_size =3D 32;
>                 *plt_entry_size =3D 16;
>                 return true;
> --
> 2.50.1
>


--=20
Best Regards
 Guo Ren
