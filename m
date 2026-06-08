Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAF94C81
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949322; cv=pass; b=sxWoB+1PsAs9/NKW2HkrGdyuHSLHekp1UnI+IiKsKMB+2eIvbiadel163LruJvfLVjcEt9Ntif9lfYIRQxixjDn0yjXkPMn4Ju5tjQkdOc2DtgVkXmkLNv0JgSjhuue5jelKRl6CM6pEiKMqKK6LFvUzN8TudiCytw/4CiNBZM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949322; c=relaxed/simple;
	bh=6GqqiuBEtgX+Iq32apaoxeaFBqaU+WcYX3pbSGs+8kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxDMs8Qyu6XnPFeqqjZzwDMcOXRquQaDNzaNv/8PMpsCkEZJATDFc4IpigUgX9ZDqy5I5rDC/HJwzlS9BJ7EZgP+jEbLPKyys+TmnLEBxNsVbH1e8b3IhodoWU4Yf4J6BxgcOqtQeH8VfOIbTBy3zktToXXwJUT8tisK0Vuu7ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JeK25HH+; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JeK25HH+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0b1a48855so431905ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 13:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780949321; cv=none;
        d=google.com; s=arc-20240605;
        b=Uo9jGbZxrbfSXe7zxIg3VezS8ZcuzCHYUSXMMPd500IqeUJ+oadttROogm1xYzTO8s
         KzTJre7pa4gHIFtywTiDihPFS+AOeinya2DMMunYr2LoZate9Ob4v4mmcIRXiS+L1976
         cbZkSShjl1UDLyfakjycdsLkz1MT7TrTEEBoUEBu2yuS7P07qs8MwFtYZ8lQ9+mxduJV
         eW0x/HRXwZG/iGvhLPaqJr6sKHOuzCfWtf9MmSRx2NBSV3F1QDyKlLETok7XX83VbL/s
         BMRoYavWRzaTi1txArRvNQxKjL4Qqa/ZSsDONqphl6lx1vEsv9EuVQ8LhSRKYPxPxSoU
         3fuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JhGyqWzUSwBZkC9kfsvV+E1iIFlhf+/51y1w2Uq65IE=;
        fh=ii4IksjN0q8zqOn8fb1Rg5BZlT0fulN2InTuH5cb2f8=;
        b=GMSeMmwYLQjOKn7JnhJdAFzV1kA4oxHvsxWzwoUioJcd4nlNNIqHnVSnFXrKVVgqsU
         2w5zN7SRBWCBNJI2rKyAPZHX+Tc0TMrDH7JsVVBljZdqSq1lZxqYqAjdko9dtpmtZF58
         qXuGsom/YaQkofY1ET3aj5zzFJfJKIivAFAj/9NqXzP3SEujwRUuABuvlpw/HF/ckvNl
         ATnQTUWumHZ+CPzV4podeRraiiq4lT/A4sv+n7y4X0LmxU6Q0BbR2y/MeArdfMJko4vO
         KwtVKQHgep5V2oRmlBuRIZPWyJXbf64tUhs5gEwBRvGLDlS8iu9G1A5k+cyo9KMfbCgK
         9fCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780949321; x=1781554121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhGyqWzUSwBZkC9kfsvV+E1iIFlhf+/51y1w2Uq65IE=;
        b=JeK25HH+gtwVqPu+qVxFhj+YglHY5pddAG1EbXlgUJagq8cvpfkg5IO8S67UrwfgCH
         KgnG7YnAQ8MI0AOoCCD/QSzTfmLlwT5SAR9W0/F9jReiSRFB7lW2mV6B6FWuM7mUBkP9
         7MAE5mvWv3xe99fOrQuLkX4InnBLCvwT7/ZSJOnVOBpv8r9xqvQMGSPudm53t8dW9rtb
         uoP5ZGStCC3dneRsh6++1c26tMAhpi6efFzZAvE5Rl7ItVOJo2Dsi1/tMhksKrFXSVWQ
         boOHNIzm41MwrgfUb8LN2e9L/Cyhx/cWXAGqh97pnREu31NMxuZT78xLCBGiR0JPBxuQ
         HeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780949321; x=1781554121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JhGyqWzUSwBZkC9kfsvV+E1iIFlhf+/51y1w2Uq65IE=;
        b=Jr2btNcn67hqRIjtl6jOtoAJakXX1FNdxFskwaLI9YuxO4FH9SrvO9QpTTZAmEi2xX
         oxKvrgplIzqxHcTuN05PgRs4zw8YUIXquf51G6kvAieeqeo5l31AghUR9Lozb8PoEnRc
         UfqwJ5xjYHZlve7Djh0S+ZeZzGc14sNmTHzcZDrSwD8Ja7hKjmsoKmNP9z7YumatbX3U
         llrKq1IoJ1WHxOQuda5NLFA6ZBnVfayRQUWmKTknXh/7QwBmGGesjVte7YlYJy9XX2WZ
         mtVtWTOoL0qFMfkPO3y2/WsakPZpZ64AzLEOOIfnrYBgdD1w/Esi0GxNQOGm5fkv5Nem
         SrzA==
X-Forwarded-Encrypted: i=1; AFNElJ+/TNZoe5xm8Lv1op0CA2pJEEtRhtN71GKc3RMvnEyDpDHRKiBjpNa1eKXev6pmKDZa76MVW//kstYNwSXNARs1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9lNPXytuARzOL7EgCAo9n6+wbXuRQe60Tj9preFW7QAbiB7SA
	pxUcMtIx+OVgrzAJ0Q5gYGcr8UHmO6TzUHtkZxqfrM8DdzmX7HtF2wzHdMrrNrI/Hb4Q4neDWKc
	EfE1qCPezdKMfM9dMh+BDgeKfghOQIZCW3jFRZJsM
X-Gm-Gg: Acq92OHjD1GVuewD1UUiJ0UEaXT9ReIHo2bpRPm9SRaCaCrgffxl0j8TGhfccqXVwY/
	Qm9Z8WJYBfeVLd9cgfD9KbX+3KyzI3LFtgS4RBp3k3o0RmzqM9rZCyLxPqpbiXVGwbbi1Nm1T2j
	AszM4t0KRoJ/ohoqc9kvpSsJF0klVfPB+ZlDZM8PjF+ge6g86ElVBTf4D4jx62brQ/AxTxRqsFq
	E96Cnuxir+bPwsvIrmNMeTqQdcUoUiib3qDUyIsoOA3m5ziIq0R9Ni/E/VFqVG6GTGjfnAr1t5v
	EEBDKxpD0EO9apYDCmSyrIKaN6ScOB+9tYfupR5R7QIjVZjd
X-Received: by 2002:a17:902:e748:b0:2c0:c3ac:fdf9 with SMTP id
 d9443c01a7336-2c1ebd8045amr6976935ad.14.1780949319619; Mon, 08 Jun 2026
 13:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608192731.708606-1-martin@kaiser.cx>
In-Reply-To: <20260608192731.708606-1-martin@kaiser.cx>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 13:08:28 -0700
X-Gm-Features: AVVi8Ccpv2VNR8IlTlAflu_TOc1h3kWP7AkWNbhV-B39Ex9xRA8e8I4MJrypezc
Message-ID: <CAP-5=fV6tVQA1TO_j9TDzPXV+ik3ww-mxX-VaO_XCGkAWYffag@mail.gmail.com>
Subject: Re: [PATCH] perf riscv: fix register name strings
To: Martin Kaiser <martin@kaiser.cx>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 12:27=E2=80=AFPM Martin Kaiser <martin@kaiser.cx> wr=
ote:
>
> On risc-v, pref probe generates an invalid syntax for a named register in
> a kprobe.
>
> $ perf probe --debug verbose --add "n_tty_write tty"
> ...
> Writing event: p:probe/n_tty_write _text+8922528 tty=3D%"%a0":x64
> Failed to write event: Invalid argument
>
> The problem is the combination of
>
>    #define REG_DWARFNUM_NAME(reg, idx) [idx] =3D "%" #reg
>
> and entries such as
>
>    REG_DWARFNUM_NAME("%a0", 10)
>
> where #reg will escape the quotes of the first macro parameter.
>
> Update the macro definition to produce the correct syntax for a named
> register in a kprobe, i.e. the unquoted register name with only one
> leading %.
>
> Fixes: a90c4519186d ("perf riscv: Remove dwarf-regs.c and add dwarf-regs-=
table.h")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for catching this! Sashiko is also green for this change:
https://sashiko.dev/#/patchset/20260608192731.708606-1-martin%40kaiser.cx

Thanks,
Ian

> ---
>  tools/perf/arch/riscv/include/dwarf-regs-table.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/riscv/include/dwarf-regs-table.h b/tools/per=
f/arch/riscv/include/dwarf-regs-table.h
> index a45b63a6d5a8..c0a6e84e7a75 100644
> --- a/tools/perf/arch/riscv/include/dwarf-regs-table.h
> +++ b/tools/perf/arch/riscv/include/dwarf-regs-table.h
> @@ -2,7 +2,7 @@
>  #ifdef DEFINE_DWARF_REGSTR_TABLE
>  /* This is included in perf/util/dwarf-regs.c */
>
> -#define REG_DWARFNUM_NAME(reg, idx)    [idx] =3D "%" #reg
> +#define REG_DWARFNUM_NAME(reg, idx)    [idx] =3D reg
>
>  static const char * const riscv_regstr_tbl[] =3D {
>         REG_DWARFNUM_NAME("%zero", 0),
> --
> 2.43.7
>
