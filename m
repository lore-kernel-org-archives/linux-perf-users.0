Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00B386C3E
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Mar 2026 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653755; cv=pass; b=MauMV6mOp9s47i5P/yDTN7tLU+Qw7HDBqMtZnu38qjklVV9hLaszL0FtegvpuCK4d96zvB69pUiRtOvg1tTamMiHtf/oFVmFBbKDa3CRbcFICQlK8IcBufRJrBbtKDjANrxg4pUqhdpGbpvwdYMrsCe7ppBoVJrH0orrXqcHv/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653755; c=relaxed/simple;
	bh=kGZofsMoBX9HGyARalV09zYlCVqb7xMFI2++D37F9v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+qBdHU/ZK/W4CADFCnfreMT2ZwU0Zen76Ckuv5XujrUftDvVvbb0olIkfNdDGkUmyHrQkXrXaQTMZDeLd3XOtDMGWe1rGDbZScgxYc/cgRBfShu5UqqPWeNngVRFg4arh0Ph+n3gzW6+0lux882YiKRanEbSmORCSFOpeuDkxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+CW9VK9; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+CW9VK9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae3f822163so13105ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Mar 2026 11:49:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772653754; cv=none;
        d=google.com; s=arc-20240605;
        b=jdLipK6vUHhh4IRGr72nF3yL+hiz4gVYTbCOiT9oN7XcidD24dHAgQI2tJJ3IoTcb/
         /bWOHPIdzXrRj6jg07Ge4xiv+nRwJMGU7SgWkQ+IUup2nuTbChXmWE3CMvLVfajQd/qV
         CFZtHfnIEgcz05OcctW6UIP3gmoWK9hxIm4tj1jmDbg8ZJeDRFlbRYEorOqgC/kwxDxW
         EVTSgZUupg63jAPwPRC6Btf1RNPKiIC+PYbUqn6RZbDbgiDficT0a44mqktMqKMwptZU
         vaC5wtTQD5vhbeoeU2t/WgYFjLsKnQG8ftHWG4E/Jv5xkI7Phzp2P4732z6R1mAQKV0L
         O+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZocDmLUpZEUyLZeVK8DcWh9PC3uLbaKAc4Jz6PpgiF0=;
        fh=npXLMDBuFAjEgHPaXWAFHymWycRkHYdn11AlPFccQt8=;
        b=FJpkeVjw3SreCPSnj311g2ib/FMdQ1AsZNoZI/TUV0Zz/T4yoWU4UIG4DvB5bcWsxv
         RNwiWF90FurJaEcchkMQ5cJvVt3sdoYnyWgwX5Q9GaRaccWfL/Cw4sXIA+cW1M6k2PtM
         aJszhJHiPtODrZe1Uo4c9XjD5NUbimlQWEfVRqMBHRsqy1jRyJeQqtovsArVSvh/8+Nn
         xUf2xnJjYTi27oHW4Kb4EWLJ941HoADm3O+GlmrsqEZTTXncjcSfN98EcoxY/82Fxgk/
         eIR41ry8djPOFy0R6GqF6dAMOPx2aqTdvSHrClBLwSDjRV8qF9T4HniBVmcdFjMgkyis
         OAXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772653754; x=1773258554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZocDmLUpZEUyLZeVK8DcWh9PC3uLbaKAc4Jz6PpgiF0=;
        b=e+CW9VK9oaKUkeLHWV10Lva+tBrihCynK4TE54vDhhPIFYjXlsTroHtLPDdRVZidyQ
         /OE+58hGGe5Hj9h+mwaz6+wSa+8Q2+Rycg0znicNC/3SNsIMhvlxHdWuhre9SnknP0Q3
         0CIjOqVOM/V22v25UC4DREFcPS65LbuFYIsMe6JhxjbQR391IbA2ksUtIKvGAx5txR/j
         uVbkOq55tvQ/htyMU7WNjg233HfOGOeYiwP83nXvGAS6NjgLcuniX36ijqQsFS0UVcmP
         OzIMFH5Tcj9bp778rTqq5QzwvJhCOIgNak9vXDc55rx2itdZyyTcISs2kfi1hZoi4OVZ
         ktPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772653754; x=1773258554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZocDmLUpZEUyLZeVK8DcWh9PC3uLbaKAc4Jz6PpgiF0=;
        b=OhGgNf03RuSX56eMKDD+vsIXJL0zXBOhMwrylX0cQZppr9BgdrZnHWMOW2pb0DyaOi
         x0TakrmiSWu64rzveWR702IY67ufrBsgpeTOwYz0GhqVmbMRpkDgbMxVniMMVwFXXp6g
         OJvy/4mdKnxmzPMwCuNwv1DLSNGhzxGcmxUbPTL+OKsrvhsNae0qVNGmPMFGaiVzUch+
         WV/xkbpWgDaT/F1ejj8/ic6NDY8UMUiwDPBAQ21EsoMmRRBN5sP4Wu0u3JzHE1UFtqQg
         hs5xxcKVVWpbT9AY5f+ETBW4fzvk4cu6192MZopZM3thaqttnYGcR/bcQB1De8JBr1VV
         Q/cg==
X-Forwarded-Encrypted: i=1; AJvYcCXKlZ3mHBYhcxyVfvO6EU+ZKws4TL9O3bGX2fZQbGr1K0UZd2by0XZYzqdTmMTqc4QbQpUTA2EVy9qAP20bc4KF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/qGdCKFU1qKHl+GKD4RRfKkk8G1obCw8jX6WSagIDSLbRSOw
	MMRttaoFmXDE98b9fzhMM5+0V8f7C6cZmeiei/7bvt9yI+2g5Xwsg95hj4tyvqKTYGav9Xa5QfP
	+iK741coRvnkmwFZ5Y1bvddIBG7VV80OVleIuLRnZ
X-Gm-Gg: ATEYQzzzy6YYWim3+C7HeBJAeXUnTej328fz0+aqsEUq0YBKsKfFiK9r7ne3pr5b6ZK
	Wlxm3yAhq0bNXXLCg1CH79G3Qo96A98OVczIllvKdUC1pGCZe1A5AP75K/aFC9uG27Lts+YJkKR
	FH0qNkfNNYD8mtazy3AW3tOYxKLfkcNdGmREkrnaXh7bStUmSDNnAupLm3C9BxSomDQ6oPb+O7K
	7HHxALctgVVjkNM9ynDSrNd+0cTe4q9wxVqXlo2sEuQdBpRoSJoOR6oNC1/Lj0E9fZfUh9LHDCR
	C4Aouy/YNVs+LIs5PSlID7dqJpYgCRjv29vwDQ==
X-Received: by 2002:a17:902:cccb:b0:294:ecba:c8e with SMTP id
 d9443c01a7336-2ae73922533mr365115ad.3.1772653753351; Wed, 04 Mar 2026
 11:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304190613.2507582-1-pcc@google.com>
In-Reply-To: <20260304190613.2507582-1-pcc@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Mar 2026 11:49:02 -0800
X-Gm-Features: AaiRm51ifPkf8exfzeZMqvoPUdPbAwYGghS-ubCp1OWMJ-ciEHNz5WiUAnS-_jQ
Message-ID: <CAP-5=fXZ1JQANk55R7PXKk0m6PP27GBrEW5pTBECa9TYJACeWw@mail.gmail.com>
Subject: Re: [PATCH] perf disasm: Fix off-by-one bug in outside check
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

On Wed, Mar 4, 2026 at 11:06=E2=80=AFAM Peter Collingbourne <pcc@google.com=
> wrote:
>
> If a branch target points to one past the end of a function, the branch
> should be treated as a branch to another function. This can happen
> e.g. with a tail call to a function that is laid out immediately after
> the caller.
>
> Link: https://linux-review.googlesource.com/id/Ide471112e82d68177e0faf08c=
a411d9fcf0a7bdf
> Signed-off-by: Peter Collingbourne <pcc@google.com>

Fixes:  751b1783da78 ("perf annotate: Mark jumps to outher functions
with the call arrow")
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/disasm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index ddcc488f2e5f0..9e0420e14be19 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -384,7 +384,7 @@ static int jump__parse(const struct arch *arch, struc=
t ins_operands *ops, struct
>         start =3D map__unmap_ip(map, sym->start);
>         end =3D map__unmap_ip(map, sym->end);
>
> -       ops->target.outside =3D target.addr < start || target.addr > end;
> +       ops->target.outside =3D target.addr < start || target.addr >=3D e=
nd;
>
>         /*
>          * FIXME: things like this in _cpp_lex_token (gcc's cc1 program):
> --
> 2.53.0.473.g4a7958ca14-goog
>
