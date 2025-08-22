Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E42580CF
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880462; cv=none; b=NJg+uiOZL8APAvX6TCu6KtNbwUXq9o3VPowUBvA2YteQPb55So3GmSQ+jrs545NjDFLDAHLRNK7T9ZlxZZ+0xu6FO13MEUvc1gvLCPozlaU36TuBuy8nqGNk0EaezhNOlY7RrFyimD5SEAlarFIJgjlDwPmpNEpX/fQO3oLZXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880462; c=relaxed/simple;
	bh=O26kbNpQZ29uf5FWMn81YzUR6Goj2XaZVIL952w+g7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uja/eP9jkX2TQOnX2uN68oH7h1jfkkCdZ36Ck66MKLy+toQEeOmG3lp1yPWstqucURBl8XF6cw9+7w23sM2PglSbFMBYIk3NHGjBCU0zaMJP6XDiQA51zHCRjWflKyywub2k5VqpI34aNu52w3cztxUFv70yDmC3HImVOaeiLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=np2Wvbla; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="np2Wvbla"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24611734e18so179795ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755880461; x=1756485261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KZvnoDpowHbBxCKIBWeXXKI0VchYJSYQk9OXSBvIs0=;
        b=np2Wvblao3+m7SN8rjGObg/bWFt5OmSE4KWEoE4YYr7jtBUz9ogq9XglTzyRzXZs86
         1zlaGUqYX8C6+krTVi+L8J3Fb5T3Ev2ky9ojHEGyBaP/kbEZ1wN9qExYuu5mBeEmZ/Ac
         R0m5VfKBwgHq56GGsB664zN7b+cqbMIB+Rh4347HQijAX4febhBkWaE3E63KRD61M6Wd
         DhO8ol8ISRVKxDMlVdX7/b03EIbaiWwHhsnMmAHNJQydxoYzuuDrFD63DRm1B8pAT+/3
         BYRUDfsLvXHD1VuaLAnNNT5XLqDEvYiTb3e9I82iW72w9PSvuL1pdQIlrDGGXPYjI0y6
         OWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755880461; x=1756485261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KZvnoDpowHbBxCKIBWeXXKI0VchYJSYQk9OXSBvIs0=;
        b=DxI3J3FVUXvCsZhiOcgBR8V5R0DAZoD9jv/rav1oan00/b3HXD66q3eY9RIKE6vj5n
         X9uBt8/gkPNkHtdvtpyt96wwf3IODFeLRiI7NlcX0iMrKx6AjGrdEPLavo+E96Jq+NKX
         F4keyjjIGLAnb0eIN4y2J2yVJ0zXgg+rZgSy1GRm0diYD5S+3PR8EeXGfjSYS5YWojc9
         XF0oSQqOmXssIJOxci9c022PDTF6kiqDttnrCbS6eHS+efp5rgfHtMXMhR6ujq/dzglP
         L8/QAAutJQFaJceuPTm03pTQD+n+LgAcs20j2BXckigsn5HY+AEsixdifX3ho5PL0ERm
         jS9w==
X-Forwarded-Encrypted: i=1; AJvYcCWt+tM9jsR146tbjE/lsGW9jbo8YxqlryArXdTES7PnhaBXaACqk3l4dMb3JanCU3q+wx9mExjKDMceHwmMWusB@vger.kernel.org
X-Gm-Message-State: AOJu0YztA5pzZfXbGN+zJKEemSoxxlC3DgZEqOWgyX7oPXLd/1Z2YyYG
	Mz3ltLR8fdyyhJMuA5YNaOITl5bPzyT2Z1uriYXRTLUDH6pe7RWP/rGZgYORo9CLEnPp8ZBWOwT
	5uWTaKBeQUiXBZsagTG46Kv6xAXDR05R3kXETiCUg
X-Gm-Gg: ASbGncvFzw21s2tICM8zbL67o7nHjhcK0OdMi8Xn/nsAeIrWIIqiMsAoX1Qn+TlCBM2
	/t54K/E/rsFnG+2blNi7Zm9xi1o87wxeeEoSbnFpdyMqUVUFlcKqYKw+4kbBawPeHIK8qix9PDt
	UrtfpNgr4NbTp6T2YRbN4jilyozKU2HILZEc+4xViPSq2IBv2bqFPsgfawOPo9+n4oYf/Y7Mhvu
	lWFhYBKg93OCTI=
X-Google-Smtp-Source: AGHT+IGGSIuhs3GJS9EYCX9Nq1FLnFppcrk5WGLd58NivGob9/epeE//UhWWfQhRd8FghR2Q7Fw2qH7GI0yQwhNCcLA=
X-Received: by 2002:a17:902:f551:b0:240:589e:c8c9 with SMTP id
 d9443c01a7336-24632886c79mr4427565ad.10.1755880460470; Fri, 22 Aug 2025
 09:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822162506.316844-3-ysk@kzalloc.com>
In-Reply-To: <20250822162506.316844-3-ysk@kzalloc.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 22 Aug 2025 09:34:07 -0700
X-Gm-Features: Ac12FXzt1TRfDXL6mh9uaaicEceXfMfdgG91vqeba--a39pkYR1DOWobi5cFZ2c
Message-ID: <CAP-5=fUcsd--WrwEnRja2pX+-5Z6d4Qyf7t4Fybhixw+WYY-5Q@mail.gmail.com>
Subject: Re: [PATCH] perf util: Fix compression checks returning -1 as bool
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 9:28=E2=80=AFAM Yunseong Kim <ysk@kzalloc.com> wrot=
e:
>
> The lzma_is_compressed and gzip_is_compressed functions are declared
> to return a "bool" type, but in case of an error (e.g., file open
> failure), they incorrectly returned -1.
>
> A bool type is a boolean value that is either true or false.
> Returning -1 for a bool return type can lead to unexpected behavior
> and may violate strict type-checking in some compilers.
>
> Fix the return value to be false in error cases, ensuring the function
> adheres to its declared return type improves for preventing potential
> bugs related to type mismatch.
>
> Fixes: 4b57fd44b61b ("perf tools: Add lzma_is_compressed function")
> Fixes: 88c74dc76a30 ("perf tools: Add gzip_is_compressed function")
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/lzma.c | 2 +-
>  tools/perf/util/zlib.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
> index bbcd2ffcf4bd..c355757ed391 100644
> --- a/tools/perf/util/lzma.c
> +++ b/tools/perf/util/lzma.c
> @@ -120,7 +120,7 @@ bool lzma_is_compressed(const char *input)
>         ssize_t rc;
>
>         if (fd < 0)
> -               return -1;
> +               return false;
>
>         rc =3D read(fd, buf, sizeof(buf));
>         close(fd);
> diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
> index 78d2297c1b67..1f7c06523059 100644
> --- a/tools/perf/util/zlib.c
> +++ b/tools/perf/util/zlib.c
> @@ -88,7 +88,7 @@ bool gzip_is_compressed(const char *input)
>         ssize_t rc;
>
>         if (fd < 0)
> -               return -1;
> +               return false;
>
>         rc =3D read(fd, buf, sizeof(buf));
>         close(fd);
> --
> 2.50.0
>
