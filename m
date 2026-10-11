Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88A3DB33C
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791755291; cv=pass; b=g+R3KEuXJ6FSr5IEKHWhjqkDYMn+0/QNzDCG6CYA/LmYHjacNXzq9hMyyV0ceSfXRDHQJnIIDFS78PKuc/vHODbBJh4FtOKEanl6aPru3NyfOL6WUUo6J/b8NNVgrO6aoxvimm/59WCqcIYekZlf6reUFCfAte5fQ0SiyC3/bqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791755291; c=relaxed/simple;
	bh=yGC7Wvk88O3E7QKKMndYn3qemkncNe4qFrBd2PU6+HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/wzQzuiN125bosJ+IpJiu1Oxgx1rRzPZjsaNf9ZtJwml1/TEQtPVls619uctqK56mrORxeGr4/kfHoBPiS21SvYfMwDYG/yDKSQ5oRxl5KWz+qbT9QHDc/1pRnyXxQ23uo1ghuwqqj8ETHaJ7FWD9UFzRyRqy8Fgk7GstUhbIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUdDBLpa; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUdDBLpa"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5337c7b9937so196021cf.0
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 14:48:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791755285; cv=none;
        d=google.com; s=arc-20260327;
        b=iMX6e1OOdQhaRYmFI+ogHs1rH549tPjnl5ybbhaYHmma5rljqgt91oo2gKTI4KZT1u
         ooAlXh2CoepmkJndNgWhKBwV5cl7j9UDf6ZkHWcBVv1AsLsQpglR43f7GLllS5eQS7j7
         dpD36vhM1i+V7YmYzd15uoKPVNp39Lr6D9GT3NnqzmD6ZDLjPrSqSyV7PdN4NEHFNDUw
         f5pQW/Tr48DwnfDI5f+m7gnHpPLtY4tm8leZFM501qe0yfND8DGEPodLa6bs4nF7M1j+
         2YSkMUI0NjLfcPoLMcUy2FIjPDtBRt6YrWQOrL3wRH7ZMq+qpkBUNA1lo/DP2nq3ZdBI
         LE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pSoGFJkMmBNVwjYD5umh+SpMh3+8g4woByg9LqJWVSM=;
        fh=+QRCHa5Nc6Iew3yC153TrnZnVpo0JZUEbQqLS4dOuR8=;
        b=crrqqBprLgzzkXGaimXl/vYyuTWK+b1OLOUvKmnnSdkX1mLPBFaD9+om9r4h4rvKh6
         IpRnVI6gEtSbTilUDSVGlU6xO4JixtyiZwda0HsLiFaNtpnM5UiKnFqgjjg5MffcfTJI
         Wecg1NW0e68GuOWFSvH2OsAOMv7jt9QP7aWpko8vTg9mbTvCr1B67I6cUj1ncZKWSM7u
         /ErEvfPa3Jip9TQ7xXQ6eS8f+7u+x6SgbJNQ7s2kFl9RxdS7oZtag3QQyi3ITUfdQVPr
         0fxHXq7Fjk52GTfIJo75fKlH4orw5E/yf2Pt3UTDMArK8DWTy0wQFQcKlCuHdtaxzUm5
         TQEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791755285; x=1792360085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pSoGFJkMmBNVwjYD5umh+SpMh3+8g4woByg9LqJWVSM=;
        b=BUdDBLpa/EXu3XY/NMqf0FVbyOWfBWcg3IKBW9JrN9IycTJv7WMpeccYUXkabFFJ4T
         bF34KCdNrCaXht5ItucP7FhVQ8ZADG95VsRfXUn2kcfyFL7P1kEoTGRvQtlYnHJELvB2
         GN4oQp88szYi90EG45FVUpDN0If4ettCJyJQFu9yism4yI8Q/q24b5ZutzWBXK5cwKJX
         rMjK+5GBqxsqnZY4qK/NpZ1Cbb2gMC8MEteKyNhdI3YFIkvJe4Y8ukdw210YVkwss2Os
         7FGMVGgZGPfWJ3kVFKbXr5SQqH4ZAWgz5zL1nasseg8jqhfKfvx23X0oqC8bFqc1YQuM
         smjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791755285; x=1792360085;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pSoGFJkMmBNVwjYD5umh+SpMh3+8g4woByg9LqJWVSM=;
        b=iwoLAahmeX/Wi4ZQ6zoRerlZ5yM5Z7U3qrPWjPzcWxmCdq1hslNJDk74gCZfxv3+5u
         09iZiCV6B4p4fhrDN3PODqR/gwyd6hIuaZsHDo/qyxpfIsPjQlT+bWVUIjK5t7jqUujT
         Q5Zudy0EpVahPu8v9RL5uY7oj1okkjbCMFvIbi3YvpQiDkZNhYhKoIfqLVyl3Dp7OT2D
         eVKSGEYFUwsxdIWxCInp/ryXY0NYyIa8tkuifNvTNOhDAd41pa5HIvINheAa81AUXtmu
         Sz8i7xJheID5pMGfBI1u3XNYmrtaTK7Ax8prtoFfXut+VZVqQj8XxqIrxSv+hq4fO7rw
         sxXw==
X-Forwarded-Encrypted: i=1; AKwUvBw1PpRe0Ag1qMIRAsWRLLZ5G4KTRifVZjoDB/eXVkr+ImH6mgLTs3H6Ss6PYvVTmG03WQNzR0cQDSGAWamdWwkk@vger.kernel.org
X-Gm-Message-State: AFq9FYL1dsxXwX0uVK4tl9BHwOIV7NBd+GLW8jsH+nPdqYhgAkzpB+m6
	i4fmfdL3RLV73OwYES0mEgHgF73NGrYCxvwOWgvvJC3y9Whzs9MiO7dNCOjg4NalYCohdYafM5u
	qzB2fRxbq9hKA/kF4973W6xxf3yaHRQuugdIxuinV
X-Gm-Gg: AYBFou2jxM35OmcU3USn8KUNrzaIyHO28Z9aLdqIXHfb06/cCeF1Wkw6le2EOh78u0U
	QeQEa6eY37ro0xNAM7HTuHBSvWdcuEupPpXHeGHt2hKcI8oJlnQ0qCtJB6QR4jzOPMrVImOOTD0
	qCWiUm2Mz0mNC1HBw5yKnT5mLz4QXDQ9p3qeNarteAxmalvbsNoyCDtpoCHuCS0wayn7o+xBz2t
	9yeTnwMB+bOFy8pwoTSMdBSSZFt0LbDu+K6OARhKgtu6t2/g19V0y4a5NGCIbAsxezkoLLZv4M2
	LPP2tenZRqTBL/LAE7BpqoO05kiwD0u8lU2LafyLZioKnyrQCt/McWHg
X-Received: by 2002:a05:622a:1116:b0:532:a17b:9581 with SMTP id
 d75a77b69052e-535b3122949mr20485051cf.3.1791755284649; Sun, 11 Oct 2026
 14:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011-alpha-perf-regs-v3-v1-0-eaa625a39712@gmail.com>
In-Reply-To: <20261011-alpha-perf-regs-v3-v1-0-eaa625a39712@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 11 Oct 2026 14:47:53 -0700
X-Gm-Features: AclHuK-IE1KAcxUEfRF4ivWBjkQ6viea8MAPDf15Zv9dPut0fJ3asy0p1dyVVfk
Message-ID: <CAP-5=fXcWRrsxYMCmb_2BK58PHMtGwQx2iKDE0hEZLc+7_DHBA@mail.gmail.com>
Subject: Re: [PATCH 0/4] alpha: perf register sampling and user stack dumps
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Magnus Lindholm <linmag7@gmail.com>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 1:16=E2=80=AFPM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> This lets perf sample registers and dump the user stack on alpha, which
> perf record --call-graph dwarf needs to unwind user space.
>
> r9-r15 are not in pt_regs, so they cannot be sampled. An unwinder
> therefore cannot get past a first frame that uses $15 as its frame
> pointer (-O0 code or alloca).
>
> The perf tool side is a separate patch for perf-tools-next. libdw also
> needs alpha unwinding support, which I am sending to elfutils-devel.
>
> ---
> Matt Turner (4):
>       alpha: fix stale user_stack_pointer()
>       alpha: stop storing the user stack pointer in pt_regs
>       alpha: use user_stack_pointer() in KSTK_ESP() and dump_elf_thread()
>       alpha: add HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP support

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

>  .../features/perf/perf-regs/arch-support.txt       |  2 +-
>  .../features/perf/perf-stackdump/arch-support.txt  |  2 +-
>  arch/alpha/Kconfig                                 |  2 +
>  arch/alpha/include/asm/processor.h                 |  3 +-
>  arch/alpha/include/asm/ptrace.h                    |  7 +--
>  arch/alpha/include/uapi/asm/perf_regs.h            | 45 ++++++++++++++++=
+
>  arch/alpha/include/uapi/asm/ptrace.h               |  2 +-
>  arch/alpha/kernel/Makefile                         |  1 +
>  arch/alpha/kernel/asm-offsets.c                    |  1 -
>  arch/alpha/kernel/entry.S                          |  5 --
>  arch/alpha/kernel/perf_regs.c                      | 56 ++++++++++++++++=
++++++
>  arch/alpha/kernel/process.c                        |  2 +-
>  arch/alpha/kernel/ptrace.c                         | 12 +++++
>  arch/alpha/kernel/traps.c                          |  8 ----
>  14 files changed, 122 insertions(+), 26 deletions(-)
> ---
> base-commit: 8f5dbfb93440d1aba216a1a34369a65654b94be9
> change-id: 20261001-alpha-perf-regs-v3-7e23508c1ca2
>
> Best regards,
> --
> Matt Turner <mattst88@gmail.com>
>
>
