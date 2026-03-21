Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C119C566
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 02:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774061374; cv=pass; b=bV7yxeXcfzFNDzboWS+Ir0ZnAy10PtJf7MnwrryhkXwFqq0xD1c8QwtdHb3Vn36lX5BI+GlF7gqboDm8jyU5W/2wC4t6LCcVoKwtKo6kmsfMINmS81Qo8oXTyJU+CDjFoT6d4RjsjQMh7KxUO96fZk2ciVtjLNRH6XG6ZVxZsHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774061374; c=relaxed/simple;
	bh=ffFD9XcSOd8nuoLfBRxGUsSaC5VME/WepQCF5m/Ufn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2HGLWdXBbH6gQnmNNC1vVjuvE0OKARs28QHnX03ttpGq2+lGYOom0RjYY49KR6SzsAcpAF/KjApLQXYYLNAFsX2sA6vH0yTdkyxxAB230L1oQoMAP5jmAFwrFBRAUTgChulwW8RyQ8fqm7Ya/RQNZ4zZvnAIGs8jT10y8sa8nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxTuGUJE; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxTuGUJE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b052562254so52115ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774061372; cv=none;
        d=google.com; s=arc-20240605;
        b=SuBh+ya7oyk2Pc5sVRbx2tovF96tbY6rKa86sDz4yjPoEXTGnb7BmuGnKJmDYKsf5k
         IM4qdEjFh12TI0i0bd0dlq10tQ8t0bmGMUiKnThSn4s49m6yEzVEDaM6EOolw/CovdPJ
         ucfQOmDa64nyxwbU1kYPoUkikuFUVUm3TmHNRsFe2ekfj4wKx8i8gfMFViKArhCCgT7v
         G4oP7bGQHlE5hZEbsqfVUa4FwNv/7O8ev15m+XqJoZaA9BEle2brzWhnsBzyhT9DQ8fk
         9iDdll5RzOpqFBz9xOFEnauKId49BqdmndnqiXN60UmmU8lvSH0zogfamy1ODN86GNAY
         BpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zD7QMCveAmOfKUNZc/1ySnxxJapp+lsQtf5koAH6ieQ=;
        fh=amqe93aqenonYXouAVwkRz0C1zo28cfiAD48L1T5k/Y=;
        b=h2mZsey/kaCgAk+wTc6EIdwzMF01lFF3Uh703h+CuMYi14O2rueGJLd0iZHwpk0cQy
         fukK7sS+LTP3TYvOx4xDar3AnKgZs0P07Gj8WNeoBK08+aNgDsMdp+Sh3h9GF8TOC+Uv
         CWNdiJdRVPjwgpanFp9vXymI0kKWpU1qhSDvef/QWVIQ6EFKrp4GikGnpvYkWS8R5J1s
         I4HLXLCqwgyzgf2gdJxOpcvDRdLb2JpUxJTOUDUd4nN0kcmXDAfC6gMmNSPCXyegNU6h
         EVdiG7LUJI5rYJvBQAEv5Vb/GeLhfwfFMfP5ty0GwEaw+6ZX4OpV7U4k7gOPfAZWPUrA
         IoAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774061372; x=1774666172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD7QMCveAmOfKUNZc/1ySnxxJapp+lsQtf5koAH6ieQ=;
        b=bxTuGUJEcL/b4YYA85XaW+R0ad2qX2LXAimqzSz9Vep3LKiu6GdIM20YiG7EiHoJZk
         jxW8l7sPP2eF2ixKj9Omq8V7SxMGf684aGx/WYrSG0Ixt2HDJjWgBq1YVPG0UDaGEqfq
         YJNa2aC/1FzaWNC7habxorkgfQZBJ/iYninfC1paU4ikJX2OpZMSG5qempxL7usfwDD5
         6GIWMXk712gOtWvwEGQv6FHcO9c0kzZHHF/hrTfuwbknvfsHOXJ2wO5bBjHxC/I2H6Vb
         eqJHZpRBykeEAYm0p60FCf/dMRaOtHRv1g/kuy+wIv/Qncm2FtsSs3W3U86k6AiXB4I4
         Oakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774061372; x=1774666172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zD7QMCveAmOfKUNZc/1ySnxxJapp+lsQtf5koAH6ieQ=;
        b=kFXNbT3NSqyz/KWo2kMfj966o4CyOvxoeu8uLLORMmH4rx9cJuWytE10VJRgCLsLq5
         8dgHkLbE6PJXdc14H+X2nnqfszviYS1AtEZe18dK1AGSrIM6orNr6dtd2HUP01cBCu93
         h6krP3NbBtx/wYPOWtS+SnDYOf6N3XGaZChrWNNauF0B98GdPtLTb4azrMIor/qGrgI6
         SUzTpxWAgyloqUuFZ9N7r3yUQ+C/OJD/+nk0ZIU//XAwpSl/5fasYugYQN/GtFcIUuqF
         1Em3rl048zGQa/GCEUpOKUqSl4yaprlyLvhSqnXSVTySZ4E/RR36jRdpwOuOjzOIFFnC
         6maA==
X-Forwarded-Encrypted: i=1; AJvYcCXSuPM9g97BzyrbVUaeijCzDSEddWdlWkv9r2xflNSX4dwsQV3bRIBASB2u7LsMqX7+M23jjvBIYe8YfJv7J8Fc@vger.kernel.org
X-Gm-Message-State: AOJu0YyVpalYgPk5bAcS4LauOAx8elDql1CX2e8e/Ngibq3gDkdVx7XG
	GBrrGyheNgY8z7lHPuOOhLTYZI7OlnJU4xOq11wtdGimnx6zxisQQZpryPo48LjxQ58Og/exRVu
	j++L3O9mY5SauK6m9jU8tmUgJfy+xsBuhnggiHs09
X-Gm-Gg: ATEYQzz/C6Ns/kQ6Wz9BncYzIwmIhI9NQgCyV/XSkP9C8GH4mWWSkJXljGgeOGRSanF
	EuEdIJ+xdv2C4dzYqMLsZiD45zy7c+eJHLibpaSospy+BwWe7X7gUTJGEm/wuUNdPaFG5GHNuO0
	VBNLBa8PPvzUwIm72fdFbyICoukaoeq+t/RYLmU3AohqkiyO9fw7+tC5sAZZZZsZ934NsHzf+N+
	ROQfIySsqS+MizEDnfftuHoyFGmFDRMW9iFW0d3odqqSkzTeDjpyhZYMTYJcQsK/izAszFLksun
	UKEZ9oTr
X-Received: by 2002:a17:903:988:b0:2ae:bf32:20e8 with SMTP id
 d9443c01a7336-2b08b4c7412mr1448275ad.18.1774061371523; Fri, 20 Mar 2026
 19:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abR-4crLwfNW2R7N@google.com> <20260320224248.536449-1-irogers@google.com>
In-Reply-To: <20260320224248.536449-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Mar 2026 19:49:20 -0700
X-Gm-Features: AaiRm52QU0QX8X9-0WBTekwTLB3f_WpbO7iWryWR-QKn7VfrWwYFqpyyF38SHBA
Message-ID: <CAP-5=fVro6E6fowmmJ7gmKX-5SN8bFU7-5KJk_wFG-bQuVnMHw@mail.gmail.com>
Subject: Re: [PATCH v2] perf build: Revert "enable -fno-strict-aliasing"
To: namhyung@kernel.org
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ebiggers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 3:42=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> This reverts commit 55a18d2f3ff7 ("perf build: enable
> -fno-strict-aliasing"). With (get|put)_unaligned_* using memcpy
> -fno-strict-aliasing is no longer necessary as memcpys are assumed to
> possibly alias.

Sashiko noted strict aliasing violations in hashmap, so I sent out a fix [1=
]:

The commit message notes that put_unaligned_*() no longer requires this
flag, but does this change safely account for the hashmap API's type punnin=
g?

The hashmap API heavily uses type punning via hashmap_cast_ptr(), casting
pointer-to-pointer arguments (e.g., struct syscall_stats **stats or
struct hashmap_entry **entry) into long * for functions like hashmap_find()=
.

Inside hashmap_find(), the pointer is written via *value =3D entry->value;
where value is of type long *. Under C strict aliasing rules, a long and a
pointer type are incompatible. When -fstrict-aliasing is active (the defaul=
t
at -O2 or -O3), the compiler is allowed to assume that the write through
long * does not modify the caller's pointer variable.

If perf is compiled with Link-Time Optimization (LTO), the compiler can
analyze the cross-module call and conclude that hashmap_find() cannot
modify the caller's pointer variable.

Could this cause the compiler to optimize out the assignment, leading to
silent NULL pointer dereferences or the use of uninitialized memory?

[1] https://lore.kernel.org/lkml/20260321024446.692008-1-irogers@google.com=
/T/#t

Thanks,
Ian

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a8dc72cfe48e..1d3dcefd8c95 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -19,10 +19,6 @@ detected_var =3D $(shell echo "$(1)=3D$($(1))" >> $(OU=
TPUT).config-detected)
>  CFLAGS :=3D $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNIN=
GS))
>  HOSTCFLAGS :=3D $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
>
> -# This is required because the kernel is built with this and some of the=
 code
> -# borrowed from kernel headers depends on it, e.g. put_unaligned_*().
> -CFLAGS +=3D -fno-strict-aliasing
> -
>  # Set target flag and options when using clang as compiler.
>  ifeq ($(CC_NO_CLANG), 0)
>    CLANG_TARGET_FLAGS_arm       :=3D arm-linux-gnueabi
> --
> 2.53.0.959.g497ff81fa9-goog
>
