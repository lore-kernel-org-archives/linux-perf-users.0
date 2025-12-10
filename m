Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C292C275AE8
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765404380; cv=pass; b=NBdab8NtFuYTXkBTZDFOPu2yTVPSMe4EkbAcQHMWxDhuwrQabFcl/YBHjqLh6kgiAqc6oI2Vl0EVwg+IN8Ej0GNAfd4jfyFscbg3tKxK2TXIEX+ZMchc1qykpV8SzCFBvIsLEZjLtsZ24bkQg05a+b/ttKV+OdaET/X5bp2s14w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765404380; c=relaxed/simple;
	bh=raOdYDwSfP3cRDaJuaCghAyILRUfmeJT1h4xn/CKEm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etHymjzD5IeRDycsJxx0fplhZVSaTN9KY74de/TcngxUlul+HoNy3W8dGQ6o7ePhnzbcDKECXHfo/yPdBRaeYpPcQnFTxWsedzJMAhw3IAELl8vjziLsxIez1v30zxrZW3YYQYBPCGurxtgSocuFlcVCV2AVzQwyqwkUjqPyayQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6afpLsU; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6afpLsU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29e0753e5d8so28895ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 14:06:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765404378; cv=none;
        d=google.com; s=arc-20240605;
        b=AfCNd+yKzhlLI24YW4csWvV1sPY02VzUyddrLuwUmPD/TFkO0JB/3rVLLjhZDobljc
         lhYNAtW0JwhAgpeQAOxvTOVCUcsxX4RF9NDDQuK2LBT00GulAJXotSHfvWVTBOp36oOL
         fKX3e3FgRbTE3wWtI9T7O4ULC5BENCxy3WBKrFRpkQfqapAnoiAoIc5080o0mzpBn/m9
         ZusJcyRDkBkI1FsMh6G5dAb1PoK1YIXHWdRWp7bDU3UYgIT3MLS8oWqACIUQ3domzVCn
         VsNHPxjuOg6eBIvHQ9QcG8lh8HiLd299MeR76xp/nr3MUvXZp1dhxfFwKEPJaxlFgmNn
         jljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S38on6Cvsnb6DFQ34cZ7B911K41AqGN9P5cx5N9QRg4=;
        fh=p464X2foFtwJWcjXwu6PTNyGdszlbB75WH0LNK/Z3Rg=;
        b=e3xztvsIwJkqsHcy8ap5EoohlZgw9T9h4fW2pxk7g2U/lKiuQSbDrZIlKreuy6j97F
         WChocF2pOsGYh6eJt1DJuzh7U/Zvy9AFAcHJTDZlt/NJI9p1aBd33C7u0S6RLn1MJkR5
         CBGGZNa1dltcumvsbz8FJWnN+3pW0eQxHvNY3bwAOOLHUUAvyyU9TBtMt7KltceWDkP8
         rdjXvysNl0pXTfUgwY1h+TZW5G6FyGJLts303ITGFBHos4MW2xLikIU+LmcuXnhA80yN
         NHNSXpJg4kaAyDkjP789rXH+96ht1eA6Xa0/qvfZAqNGkxrFuuPWPU2/n+GV8TNv6p5t
         n8Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765404378; x=1766009178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S38on6Cvsnb6DFQ34cZ7B911K41AqGN9P5cx5N9QRg4=;
        b=a6afpLsUULolp5bbkY8/QHguxMlM/SMR+exTdoPfqp439zadp6bfzoPp0ITpNW60mU
         NrY1B7QmoGB5FWxM78sQFrRic02CS2m9AxTxUAZ2/0J2XMllMCCLJGXW02fCJZ1ICH6d
         9mWb3rGc5pcxRT/9v3V/lXYD/HCxRFCmaaXhhXsTPptANxwMdhn2P7PmZEO/ZMBZHq9C
         V1CSVG813iACHjk48SbSR/YeNBP6LdgaU9qJrsAu2/519Pivid261tG9S7jr++d/Z1q+
         UhirJWKkjT1ifXILlTjleQdSvt0DRd7yvA6ECQ9WjhOVa7IQ2SUAghuWiJzUzHrR6jmE
         Bftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765404378; x=1766009178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S38on6Cvsnb6DFQ34cZ7B911K41AqGN9P5cx5N9QRg4=;
        b=VWOYi3BFByaLokg1ETwpf7AxCLmZTXG/jokkT7UScENAqg4v0WF56KZpIfQXP63Ola
         z7BiNUTOKDkPDjUf6E3dbbzYa1Id2poMizqL/bsVbi7xxtV8U8pZWBSc6ELWn8gkx2JH
         ceRgEP6++R3UB2NsDqmi95fGM3XX1iy4rXxPwLWloea6yt15lpoYJ3srrs/EGLTfCtxp
         g/X3KOIBK4eofsc6bXAMRWCFlSiNedAzZr1GMFhRf1fX/bXdyGb2nzn5cYtclX1DtClN
         Wrxpg0CvUS96YU/TbKagFbOBksIX1wH/1s5Dwppojnk092KFFS/H86GP+MrInld5C4c7
         pCYg==
X-Forwarded-Encrypted: i=1; AJvYcCWnHi7DPQxgucZzI0X3JdWMbiBFB8QEjYZm0YsiIJ51+kHweA4bVAzewxASR9kpbBWAARCza9bx0R3fL14kPs5K@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8IsT3PtOxcXphbmJendgbmwxsWjKeiELnTbx0zS5soWwaGv5D
	zTmp86qoiQB0IclOlqx0vwUPYYrxxHQileZBVo5RJmMMHry9LbBiqjx7G0sYg8L+CfdR+OB29ok
	gXoXwkUaQs4WZVp/yvkIFVw8JDgSJlIsqm9eisHfz
X-Gm-Gg: AY/fxX7hPllFJQlfSiThov/8OTMYrT7ZCXiG3lVlq/VHh65XeJq5g7mkMQkZK/CM1OP
	Tnd4eGZI8AdIVCFynKUSX0PoB12DJeucSJh32W/BH6k13KZRac/IWVeaQJGbC4R0g/cnZnzJ+fb
	6a6Yu94KtIFq49V1e3AmZT7xLx0cONMkxr1OyuqvIRTXQlzT6YQ9aUXZMkOqRn6vLfwVuRCNoZ0
	uF0XhCYnS/Rdv86V1ykQuIesNwnU6pjfjZgkxJgQXO+PuA1RrFdZr3sXI+otaMpEv17ZW66
X-Google-Smtp-Source: AGHT+IEbUkclFQHItDGaJ9Q69rlkuVc/UsavRwSf50gzoi99+31V5VKzUiePtgwQ7UPR2EbKHZJgGNl5/LCEPcDqImo=
X-Received: by 2002:a17:902:cec2:b0:298:4819:f4d9 with SMTP id
 d9443c01a7336-29eea08f5ebmr1144685ad.8.1765404377684; Wed, 10 Dec 2025
 14:06:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210023327.1669863-1-namhyung@kernel.org> <20251210023327.1669863-3-namhyung@kernel.org>
In-Reply-To: <20251210023327.1669863-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Dec 2025 14:06:06 -0800
X-Gm-Features: AQt7F2pFpJZU55iVlrn-veSW8ElDqDLcV4xM6kHybkwjKPscNvhVYplxkpduJOI
Message-ID: <CAP-5=fWh4+_7Pwy=y6bauiObg0sDG1KRPMUikNZVSNuEC1TPAQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf report: Fix histogram entry collapsing for -F option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 6:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Users can use -F/--fields option to set output fields and sort keys
> together.  But it missed to set perf_hpp_list->need_collapse for sort
> entries that have se_collapse callbacks.  So it ends up with having
> duplicated entries separately.
>
> For example, let's run this command first.
>
>   $ perf mem record -t load -U -- perf test -w datasym
>
> This will record samples for memory access (load) to struct 'buf' and a
> loop condition ('sig_atomic_t') types.  So the following two commands
> should have identical output.
>
>   $ perf report -s type --stdio --percent-limit=3D1 -q
>       87.80%  perf                  buf
>       12.17%  perf                  sig_atomic_t
>
> But using -F option didn't collapse the entries based on types so the
> result looked like below:
>
>   $ perf report -F overhead,type --stdio --percent-limit=3D1 -q
>       23.31%  perf                  buf
>       22.84%  perf                  buf
>       21.26%  perf                  buf
>       20.39%  perf                  buf
>       12.17%  perf                  sig_atomic_t
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/sort.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index a0a5c1c40af0c318..c51604eaae0a4b90 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -3578,6 +3578,9 @@ static int __sort_dimension__add_output(struct perf=
_hpp_list *list,
>         if (__sort_dimension__add_hpp_output(sd, list, level) < 0)
>                 return -1;
>
> +       if (sd->entry->se_collapse)
> +               list->need_collapse =3D 1;
> +
>         sd->taken =3D 1;
>         return 0;
>  }
> --
> 2.52.0.223.gf5cc29aaa4-goog
>
