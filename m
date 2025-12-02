Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E55D2F8BFA
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764709079; cv=none; b=lCoAhdiItF9WxJZcbQF649NNSwYCyVSvThOb83SnBz6taFKn5xcaAEmXTNUJLRtW/cTlYKOsR8UuVnlazNN3v96CAwcO1k2Yg0ctEiLV2/pbzloGyxwJGqkvlG0S7sBGRD4OHyw6SWPNimYeQTWV6is9woGEVkZKUG5M5gb+2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764709079; c=relaxed/simple;
	bh=GQP845qBI9oKETUyhQrI2VT9jtgt+qf7xrS1DOwlua4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibDw+BGYN+VcawUAOYEcN6dgxvm4PjNsFQUXlb538C9rUfPtzDrWQ37iyn0qErJCJLoueyzQkuCd8L3b2pHQmSTo/j0dFF3ZTiEq4SvE6iylHZYAnlSqGM/Jb/xgZFli9XKJQtdCCcyHmzujiswcCHOEE9Uss+V/Lnz6Cvdbn9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWRsAu2D; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWRsAu2D"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-295c64cb951so52455ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 12:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764709078; x=1765313878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajXHk6e5XevCIkKzZj3uDS1dij7DdGd6AS0GZTuW5mo=;
        b=YWRsAu2DRPS2ffdDXfcLAqw0EG4dxhXWKHnBcUwAKd2AWfZHJQGgvvjovt1X0qH5DJ
         fMtc34aYfmDs2gVbE2VpkbzwiSsqn6/Bjh8aIqBCX1Sl1yr/xNM+vd40s5JLidujqSgk
         OvPpN4N/YjpgEohu5GTNMeo8XojGcG5rgLFZfNo+BjyQh6sDBqfzOUl4aeugQ6vbxQNm
         fI/sUsbPkpR5VHbwJvXAGDD5YHWhLEJRhoNw1BMP8P0DGEkalEPAzae/l/sU6kut6TIx
         C9bVq8PLmSp03s2jHf8k6Tv/7/b5Ym0DivLQA/35uA4UGSxffxMFo8JlIhGIkxmV58qg
         KSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764709078; x=1765313878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ajXHk6e5XevCIkKzZj3uDS1dij7DdGd6AS0GZTuW5mo=;
        b=XwoHnkUC84512NRS0XwUDLegFSU29Sy4fhWJTNlhiYHzVreKB1Cvt1MFRkiuazkhn1
         FXGGby18pVfpQ7wt7yunJYV/dGtoUFH1g2pKIt1GCQ/c7A6SGPXP7tDcrEkxllM2qkOX
         9jGDkv3R7V/EZZZzHu8b9OjGwi3Tjm8+gqAIRGdjE/orzo3ztC4dZ73DNmoboPrBk1Ue
         7+55+hGZHcbw1Bc1RVPKBV5ToR2HxeFElZebHtJQTnPOSUuiPUtcWr2evmogdKtoyh7T
         97kk1pZg5ptwF/DrLmMsnnRN2SK+k8zY6CBSOHkeYeM0q50c98Mpv7uoajEtW054+Q7j
         uMnw==
X-Forwarded-Encrypted: i=1; AJvYcCU+XMUDQAfapY4zwOJpjl6S40OCRHUIYA46QvoAK+eA6oQ8/zaDAoaSQNbLHI3kYOvIhkDUiUMPXwEYJxlj+pMO@vger.kernel.org
X-Gm-Message-State: AOJu0YyHAVbkRCT8AI9booz4PrtYlSjLJMTnOJ/Mgkh5Mu3jPCwaWFOL
	TRafi8DGcE30Zqf62BR0mHC3/ggLbQlaa2hbjWkzZACyKrrX8bQ9CKyK9CQQ+ndjqFrEKlpYqps
	QwLHpXLHjYt0KMq4i/x9te0QyBwQE+/LrcZco6Ak6sbAzCirGyJax9MXv
X-Gm-Gg: ASbGncvBiDZ7LYAHkFCKwoYXdA5CDOjGpXU9aePqOVBqzFsK8eAUDZ5LCZKERMF3EHw
	mMtF5IZGmj0w47aTEnrQ9gMRakbIJ/qt4WJEB6VpW9pAYoTu+a231toVxK40SAMvMRTP9vgwDrh
	HjUKRPXM/AeeMyN+3tKB3TNWMsVFT1mJg0tPxIoPAHodkSXDIFTDtXIaw6dDysRhn6crfO7ILv5
	BNDrPgvzUi49hoT7ja729KuFweKK+NWdf8ektumF8iv7o5J85yUpqHfdsu3+hvI6nRUBvKSMztJ
	J53F4Daoj4jZDP8RB2HUf0NN
X-Google-Smtp-Source: AGHT+IFOCTKjmVP2DZtYUc++msXSf69je/iD1ClVUmzhDPbWuBIjoHChBmXbi9Jqvi9J/FmI7ZBMA7sYj+7OjsGX4RE=
X-Received: by 2002:a17:903:32c8:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-29d67f32ca1mr15625ad.7.1764709077647; Tue, 02 Dec 2025 12:57:57
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202081645.931527-1-namhyung@kernel.org> <20251202081645.931527-2-namhyung@kernel.org>
In-Reply-To: <20251202081645.931527-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Dec 2025 12:57:45 -0800
X-Gm-Features: AWmQ_blkesPKhsWNtIT8byyXVHxFWxYHhWPJFuJzAdW9He7YBwCKKLYQ9y46lhI
Message-ID: <CAP-5=fX_Qxmi5WNS5Xd++zJbvoM2kPn0cF-FfVWsUUTvov86Ng@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf tools: Mark split kallsyms DSOs as loaded
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 12:16=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The maps__split_kallsyms() will split symbols to module DSOs if it comes
> from a module.  It also handled some unusual kernel symbols after modules
> by creating new kernel maps like "[kernel].0".
>
> But they are pseudo DSOs to have those unexpected symbols.  They should
> not be considered as unloaded kernel DSOs.  Otherwise the dso__load()
> for them will end up calling dso__load_kallsyms() and then
> maps__split_kallsyms() again and again.
>
> Fixes: 2e538c4a1847291cf ("perf tools: Improve kernel/modules symbol look=
up")

Fixed after 16 years :-)

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/symbol.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index d8fc5ea77f849326..5a38435d90c96092 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -972,6 +972,7 @@ static int maps__split_kallsyms(struct maps *kmaps, s=
truct dso *dso, u64 delta,
>                                 return -1;
>
>                         dso__set_kernel(ndso, dso__kernel(dso));
> +                       dso__set_loaded(ndso);
>
>                         curr_map =3D map__new2(pos->start, ndso);
>                         if (curr_map =3D=3D NULL) {
> --
> 2.52.0.158.g65b55ccf14-goog
>
