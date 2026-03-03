Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CFA349B00
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580560; cv=pass; b=XTRMNqNc2oXU81HJ0njXdj4to5XwZwLNvnauSAbhPm4PBjTCxInEPE4S+LzkkO6N30Q3NWecvgrOHemmmHN49+LC58tczO9lenwE1iHVj1voH9xj4TQyCmoczLqNBr+hVwTeNsUAkpyUduc26+1nfQbtozqfo58eAjQVcFs38Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580560; c=relaxed/simple;
	bh=H4/0f0Vkf3bAK0NHlAPK9oM/fReivGRtPyF0jOwe00I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbE+BWNXcDlsM7zoM6Qwpb0/tIlZ+EgANG/DJNfQaOYy/f7TmOUk83ABxiBV/AAttV+EmpGRsISDojYyy9iMNuLsN/9KyHrnQVPS82rAVX2HM4n1tZvkPJzUmXuW8vxO2EK8wvcj2zXFWL5L6T4IL5jmaRyoQYlskNOBR87v+3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S2UFmI7J; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2UFmI7J"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae523d54d2so126935ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 15:29:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772580558; cv=none;
        d=google.com; s=arc-20240605;
        b=VTSNI/WocIpgPrnH5+xJsd57sgg5VsIb4nkhvysvwUlkalKcBcawmgKKeHl+NmuX1b
         5KTE8cV4JhQrliRUuhiBDXyejN3d6GDbcSqP0OyS1s8HJAji2grKmkxA4K2yMKrmHkNi
         dDlRXFB1mVUb8RHixfTvGHs6oqef3z+Y5uLjiJ1yputEZoArbE8ovh7yRlVWdNYJdqI/
         txBDhlgSfDPKfq3+1dVOuv4wPKbxMTAad1BtaLthDrebW+T3Dd9E0AFML52Y+tJA7Iz8
         2g7L0eKr0V5QIUYdBq8JqAhM1/Ft6P38aVKCpsRVkRLE1BA7CvYZfyAF8fahIt9ksUcl
         gv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FiE7foD495KYiSbYPuQi/APgrwKk9G8yzIGB/jUm9ik=;
        fh=UjESp5dXVQZ+BLVB3g/KKPkPWXYnuU9aL4VAFWtFuQg=;
        b=QFmb07w01CsoCVycGutzi3HgcoTMlHTQ1N9+bhR8gcfYlhCqRyjjnI8IRa6VLnQfNT
         ou6pQS3Qo/vUgJF8nrebwQ9CUV4fTgqr7srkP1pUhRXP7nTGwgO+H1GqMT+2HnExR1jp
         ZLJ2fokV0a08cBPTDFygeIW7tNGk9dW8hGGV48Ijendw328s8+KE+FduIAu7VFZ3vM51
         UiudFNO1uef6W4beMUDAgeLpCeiQ7KqaYKQOL1GU+jS6dqnLBgqNP+KNEKAjtLkLfVNk
         GsdmblheejIiOWA2xvU1L3ao2+ZvredxV1ifPHpoDW1i78CsSmBY03V9mM1j2PYPTB16
         OtGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772580558; x=1773185358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiE7foD495KYiSbYPuQi/APgrwKk9G8yzIGB/jUm9ik=;
        b=S2UFmI7JjI34xHqNorJgRY6AYD7dLuzfrz1U+7t06aIIb/FFyClJDEw4a/saoNQLcT
         KwrHU8sVRT1uSCAj+xm9TfTiJ2DAfDOG2r/gYhkYwN7Jl6umnopEm6WFctd13MEG0Yyp
         t0yQIJ40Rtj/MOWfwO8kF0fQ0TBV0i52crxwYq844+tsmAB97DZxkMWDpeeqr+JIVS1s
         YU1HsT+hIC12DDlpfBkHwqWmR5QM7/yaiYByqMohq89bCifc0lCgI0KD2If9K3Jyx/U8
         bQkq17kw+B8GA2wipGbH8RmyQ2PYBnqYiArcVgNmmTFXtvkqH6z3uxz9TG07JECOyrle
         /0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580558; x=1773185358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FiE7foD495KYiSbYPuQi/APgrwKk9G8yzIGB/jUm9ik=;
        b=w2TN1avQvmJMSKHJL+GbRd7O0cNI7s2It5Rg6B9iju6M6q9n2uIznVrEu4pruAmZxi
         +Gjk+Qc2zRWKNB6afH7d9zZWJrva+tOATIRfIxLxvCSeUmxiXCfRmF/8fxOh6gR7DQCA
         jZhXU33i1BC6rjmU+gSoh6OA5Lu7NKF98G7ZQ5TxAuEpoo237UUuaRbprBTYkBS1OZ+t
         P5nxfgJi5q6pykrpzAblj6D5WFoFkQmv4h/jeXdxleziK2PjYj53JQwnbRbsR9Ctb7wt
         xb0j/cjecJu1mIj8Eu3die2BvWVP63gZlRF5B0HMgPIotI9/PFJNraalCtPjGCEe1fHf
         wmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3TsPv3BL0c2qsL4pLx9sWqwlicNdjfFegajrunx0agJW/dnhd9rC8cJu99pZEEBd35NsQ9mJErXQWcLDKluQp@vger.kernel.org
X-Gm-Message-State: AOJu0YymMyZXvvZO4v0pOtPcykf3HcDVCdtUNr7XMc0b3VT4DOsIvE0V
	/EBaJYsh0U1eiS+MenOnd86WRon4Flx3MMhasIGA84A0KLjWIDVeh8634CVR3G1B0eTY+raFyY8
	fKgNJoFVgh2smTnARGI08cm51iU+Cnyoss3eiJ2lO
X-Gm-Gg: ATEYQzxaV2mtbpj+R/47MZZrWZuHCg4UxcxWGOt/gnQagOliCnWq2cLB71+cCS6/M8q
	OJ1dGb7pvn4KJ0tvJwEb5PbFsDSQ/STVwzaa6D7helfn+xb56tz410rfQP5n8iyzO9Q28R+k5pf
	yub9JizXj+3nwc13a3kjoeSwMJYw1jyyS+4mlGvU6DFFSmCnyQix4/XNR0rdrz8I3gIAP5p+USn
	g/zssZg4gbm8LEtUyhqUJAT4fJQkyYCZlX+K39Q9nDW2dnBboezr0iXf97AYC6AAQcUeKEqLB9d
	IG9M8mPdiW/lokUnQd3uU4qbO5gKsK8D+iFx4g==
X-Received: by 2002:a17:902:e54b:b0:2ad:e574:7a7 with SMTP id
 d9443c01a7336-2ae3b5138b9mr7707075ad.11.1772580557297; Tue, 03 Mar 2026
 15:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303230043.2074593-1-pcc@google.com>
In-Reply-To: <20260303230043.2074593-1-pcc@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Mar 2026 15:29:03 -0800
X-Gm-Features: AaiRm51WL95oMqDVkWli8eBGOixYK0T7oHldhYsC3oIhV7q_LwP7pOQfUinyzQo
Message-ID: <CAP-5=fWL0jKGQuqBzP0xMWVkzu48c6JzgwWQ1+NkAxgbpSPpcg@mail.gmail.com>
Subject: Re: [PATCH] perf llvm: Clean up after a failed disassembly
To: Peter Collingbourne <pcc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 3:00=E2=80=AFPM Peter Collingbourne <pcc@google.com>=
 wrote:
>
> An error returned from a failed backend will cause perf to call the next
> backend. If the error happens mid-function, e.g. due to an unrecognized
> instruction, we will end up with duplicated instructions in the output
> unless the backend that failed deletes any instructions that it created
> before failing. The capstone backend was already doing this but the LLVM
> backend was not; fix it.
>
> Link: https://linux-review.googlesource.com/id/I377eef3cd662ab98fbcd69e50=
04a259fa3d7aa06
> Signed-off-by: Peter Collingbourne <pcc@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/llvm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
> index 0d126d233c019..87fceae8488a7 100644
> --- a/tools/perf/util/llvm.c
> +++ b/tools/perf/util/llvm.c
> @@ -261,6 +261,15 @@ int symbol__disassemble_llvm(const char *filename, s=
truct symbol *sym,
>         ret =3D 0;
>
>  err:
> +       if (ret !=3D 0) {
> +               struct disasm_line *tmp;
> +
> +               list_for_each_entry_safe(dl, tmp, &notes->src->source,
> +                                        al.node) {
> +                       list_del(&dl->al.node);
> +                       disasm_line__free(dl);
> +               }
> +       }
>         LLVMDisasmDispose(disasm);
>         free(code_buf);
>         free(line_storage);
> --
> 2.53.0.473.g4a7958ca14-goog
>
