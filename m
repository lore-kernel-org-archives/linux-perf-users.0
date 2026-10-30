Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793374478;
	b=wNroWIaxCbCTeDgKY1+yWNMp8D/0CohnjbiZ1EuY6xOxaqcGzeZwnODtgPVf8dNSQL9E
	 CZ0qdAMOFC4Mkj5CmHPfl13kb/tqBcB/1n5z+BwmHFffhTSMo/4BoJLfGEuTaOOkL0vXH
	 +0pd0pTBP6ZoaXvR9SysGX0mTe8Ve61OhxhPr3kwkXNwjMQ95IFDTyLbR0g/bvAe5yu/u
	 6uDHjcx6qVYtvsCyJeatiDyLprKKzgDFFu7JhVDhGZtpbuPLbmZ64hbQEwHRJEd15skLj
	 G+pOrRlzqfJqHi3huxv/Cp1Ei7m0Vnu/tlZDRCU9H8vy60lvGELWeappp6bN+uMoD4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xJSd91MnDZDt49eYO1tZt1W2RFJUYboF/uKyYyF4zTs=;
	b=bk/vOagGbZK7Sbzrh90icE9tYCMHU0n07Ib5A/VxFR+5wvHH9zWtaec7He6wz4S1L718
	 jTtPEHGxo8cVHYLN5lopKc89RPWe5dDrH4/diEQ1t1wEsizDTn9aLlC22CGLnG5xgCab3
	 pwmpY3iwAlWXTpSYCzlzk+gSmD7jp2ChaognOXogWntDa5fy4eCJreQF2/+Ahy9U3sRFH
	 OTmkSl6f3Z7EELSbdSs98IXTrVmUDjdFqwgie01EhbZ39jqoaGjHQElgy54s98ZPAGl/s
	 1iB2ItrHW/BsIxPFjSoE/3MECaq+EGhod+FVKk/aWkfXqeiRI7emoawRtAA0i8JwMfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iaE4xThZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917AF606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 917AF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iaE4xThZ
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-535f598d126so264251cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 08:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793374476; cv=none;
        d=google.com; s=arc-20260327;
        b=VL8UQQPCekukszTz8kYTlTL8nF0bW0YOPt7TyHfvrrlRXw62Yr4G3AAl6CN/pr95BV
         2ckcCJA9zaaBW+k4vLgFPg/5jnBzah9OzxW/aIQYvYOgn5hASjOMKP3Dm90ALiv0MwHb
         z5E44T57lP0cNdsDMx+8B1/wR3hWRA3FxKUeZ/arVIw4h04nTXced6qXk7S6S0OrYCAm
         pJJfA77Ri1kqE3A4GqEtTJEc82I9/xcCxlYeFb7AHwBLyiXvgUseGp1kGEykNZ7Xov0W
         p9hB4vtQLU49dKomQVSA3qlTCGgjZVgjXGmXVCzqJiSLcqqza677iN8lcWzbK+o9QbJI
         otoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xJSd91MnDZDt49eYO1tZt1W2RFJUYboF/uKyYyF4zTs=;
        fh=2ABY7iYG2csV45wAwTTcO2oCcsthsYHDcpQXSWKqWRc=;
        b=R8RZ+fxutO/ho9/BY5G60vj48ps2AhPLPXCq7YNW7d2r0sVDUbX+rgka5HvXZATvgx
         fOtLGn4+LNCADfsoH47o8895kfADhgaWqI/z8EgP3/5BCINtvyxMt8jP2xMLmjcrOmZU
         T1nsolmnvot37xT/YmHN9UlrEI37vG+hN4QGS1o3LQUa51FJ5BpmWVzyfQ6cME8gPFAx
         ZZEN58NZlTz+zCDwJV3iRW5c/ARA2n1k4D9Fsila3zm/KoL1/xDMTewBqMnmaGlmzouM
         KwzTksTVeYKurgflzhCcUjj5uGTaHP4vTmAFaSQcdgSnUm/IAe7DswfoLQW0hThvjfG2
         bzIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793374476; x=1793979276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xJSd91MnDZDt49eYO1tZt1W2RFJUYboF/uKyYyF4zTs=;
        b=iaE4xThZprOQ3rkefWKh5605B4nMSEySP7fdCAx3m5sxD43qanLAkAZMo9j7bBwOMm
         6BxHyYAY9iuKudTVQ6qjmbctlm8ES/clfvWv72+bCLPFJQhFWI/ZGb1rRLWbJLQYl2pw
         4hXoEQNWM1QYIiqxJp3lnzAKC3MC1USLpof7VG4s39p2LMQcxHv9YMGPxCC4fc12FJUt
         ML+XYaENa6S3WM8ziKqARxZ7kIlZS+DxMHmpqDMg+judj8Lw5CHtKA4aaaGHmC0fPa2n
         5tIzIIGkUmSn8WPBFkSPQilyS43qoV9Hnct+bpEmNVW9e/qQN0HUyH4ddkedheheDEFM
         x+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374476; x=1793979276;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xJSd91MnDZDt49eYO1tZt1W2RFJUYboF/uKyYyF4zTs=;
        b=J/ikO4qcoex4FSeiwsaFgU/E8rUxuyRmFMhiFFKl9hNJp3MnKzPTW3S+R72HUkBedI
         xCORmSlQ86SOXlsDsCvPjk/h6M0mOk/HXnHyIxWSdx10jPlKB94ch9fF01fLNh1yNgjt
         IFiP+CsfKZOkpU5IGLYf8RB22R5MVeInyAgFNL/rJA4v0IPkx5mResbs2KJ0ggEAJC41
         GLrMNtjUEZtDYPwCNvcfuP1mxBiiYLi9jnZLEz2De6oy+2GPZAEwfSxWWwJ2nNqTZEFD
         +wirE69VYnv5aYOeQmWEqbb6PzdAE6PeDOZw8X06J8+VvA2vw4sh6/9XKsP/38u3w051
         BiRw==
X-Forwarded-Encrypted: i=1; AKwUvBypOA11XtPX0tGZOGpqMTpbkYSRgrWskHBIcJB1MT6kuqnFnDRtITjYalPwC3D5dvQ4Q3ZpJRD5f/bqmCh/YXUa@vger.kernel.org
X-Gm-Message-State: AFq9FYI/jswfe16164uDTiL9hOEJkQO2kNZ2xXrQEKVn9fl2jxP5kmho
	Sq82nL6IoVzugoaxdKkF5LChjdpZwhx+0jDN0+usFJ0z3jBhwJWx3p3wOuojyO4ujkOBS0VLv0N
	Jo5oSaE/7bPuCUzEq41MiKfD3PHl9l1PXa3hbZGGs
X-Gm-Gg: AYBFou2QqhsBgMAfygvuvzQdJaax+bop4/JFMgAm4CwocsLLrrrQDbYXK7lRhWynLps
	fkxgZJFnfqZ5uAZEntiUqT0pof+j32aKXTPXw/00mh8iLk2XMXyZcFb5nnSXOfRJlI7pkl9ecqn
	YCDbVSauQQy0YSI8MDBynsqFiQGrMj2n4r+ukYruWak5uk6xHtU4/kkxYIZBR/2a62pIcZM97X1
	GIOOWmVAg6BmbaJnsuYqGH6SEQrqn93udwgGO+2CmEj49xK0mWtDjErTLxlZ4C0YmmwXZluDv8J
	lFKeLNB5g0rG7wjVHte3+Mk/MnBbzcTMk+sCBwvaRICkJmoJPFi8nAAXh9jMTelLiwxNtcAxd18
	2eC0TG69TjJQzXPCJJ5QCR1Z9xDURshPgTqQdVYhrdJri5kMHjYehaM/ZZJd4+Z9N2ik=
X-Received: by 2002:a05:622a:4c19:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-54129d49b08mr49055431cf.2.1793374475740; Fri, 30 Oct 2026
 08:34:35 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com> <20261028-perf-symbol-memory-send-v6-3-7e90415f0101@uber.com>
In-Reply-To: <20261028-perf-symbol-memory-send-v6-3-7e90415f0101@uber.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Oct 2026 08:34:22 -0700
X-Gm-Features: AclHuK83bdTL8Ehtx5SwKCb_R4c0NHYatp5MnU4GItHIuM_WMqwqQwGoR6dn4FE
Message-ID: <CAP-5=fUejV8+M10Z-CtqnOS1qdkoemJ=3GWWQyfw0TAHQps7Og@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] perf symbols: Point to the symbol name instead of
 embedding it
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 4:42=E2=80=AFPM Alireza Haghdoost via B4 Relay
<devnull+haghdoost.uber.com@kernel.org> wrote:
>
> From: Alireza Haghdoost <haghdoost@uber.com>
>
> This patch changes the type of the name field in struct symbol from a
> flexible array (char name[]) to a pointer (char *name). It is a
> refactoring and does not change behavior, but it adds 8 bytes to each
> symbol allocation on 64-bit hosts.

I think it is a little worse as we'll need 3 bytes of padding. You
could reduce the padding by moving name to before namelen in the
struct.

> The next patch creates symbols whose names are read only when they are
> needed. When perf creates such a symbol, it does not know the length of
> the name, so it cannot allocate space for the name after the symbol.
> Perf also cannot allocate a larger symbol after it reads the name,
> because the rb-tree and the callers keep pointers to the symbol. With a
> pointer, perf can allocate the name separately and set the pointer later.
>
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

This change makes sense to me. I'm wondering if any other things
should be cleaned up with this change? For example, namelen is only
referenced in about 8 places and we may be able to replace it with
`strlen(name)`. Anyway, ordering the variables to pack them is a nit.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/ui/stdio/hist.c | 1 +
>  tools/perf/util/symbol.c   | 1 +
>  tools/perf/util/symbol.h   | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
> index 8c4c8925df2c..c65e3aa73a13 100644
> --- a/tools/perf/ui/stdio/hist.c
> +++ b/tools/perf/ui/stdio/hist.c
> @@ -106,6 +106,7 @@ static void init_rem_hits(void)
>                 return;
>         }
>
> +       rem_sq_bracket->name =3D (char *)(rem_sq_bracket + 1);
>         strcpy(rem_sq_bracket->name, "[...]");
>         rem_hits.ms.sym =3D rem_sq_bracket;
>  }
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 2d611c05d000..02c077d7e2a6 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -362,6 +362,7 @@ struct symbol *symbol__new(u64 start, u64 len, u8 bin=
ding, u8 type, const char *
>
>         pr_debug4("%s: %s %#" PRIx64 "-%#" PRIx64 "\n",
>                   __func__, name, start, sym->end);
> +       sym->name =3D (char *)(sym + 1);
>         memcpy(sym->name, name, namelen);
>
>         return sym;
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index d8386c4a7fc5..c231d8e4427c 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -95,7 +95,7 @@ struct symbol {
>         /** Architecture specific. Unused except on PPC where it holds st=
_other. */
>         u8              arch_sym;
>         /** The name of length namelen associated with the symbol. */
> -       char            name[];
> +       char            *name;
>  };
>
>  void symbol__delete(struct symbol *sym);
>
> --
> Git-157)
>
>
