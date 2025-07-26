Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08315E8B
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753492774; cv=none; b=dh6BocZq9NzeZknjDykVqFdBTqpG990jqi2Tr0BoLiz22ociWz4a3otzu6Z/IzZZ+Ms6XGNG7XMPHlExHDqO34MqpF2XcanXV2gmV/USpBIbA4IEggsQb8TRNs8Xcsau+9y+WxCpRjGkBsTYOavstYeZ05ejqVrCvUZqnt8/Zl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753492774; c=relaxed/simple;
	bh=MNVnAn9lPopswiMaYYvJPW3FqrRZbZlytTwJl/V0hHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+It1SdngWVxN/gRGgdWDcGYIDFLqYm/nKsrn2OF/I+w+YLXUmUHPgD5rl80ohQ94CTuMOkYU8zrifmD2m1jMz1er0ZiVO6MMt3LFWGNoML7Xd02umFugIIFk5kIlV2FtdSufG6mnOjXi/bd0+FoDzqEoMTw+cUuOvTQ0dNhfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbgydL2a; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbgydL2a"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2357c61cda7so41915ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 18:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753492772; x=1754097572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZVdBwsMKuczQR9Eb14UbIMxx5M0fil/YqZ9yzK2ioU=;
        b=KbgydL2aFRegQTzreLXfXSshSgMoP3pJyvPzOBN3csmiZ8/taAsRSE7Q/nstGE/pCi
         UlXqMe7QclmX0Bpb+kpcUZy1LbaYK/AN1oTQonCN1V2Vt8gYiDqCp4Tsa5xSE3jWyBAD
         Ad10LwjkFTvU5xuVMOpp+bCBIX7UIs6HCs5jIDPavz2zHJk5wImB0EHxZ0hjJaslTPuD
         Zl9gbHwKK0PAYYI5vvjZ+EtvfDAMeHxobC1EMsPPpo4cOp0tfooDEB2xWb+OeUWYZciZ
         u2D2ohUoSRv9MGfftoPbY+51LfpRIDPIzbR8PBwVYhHIBPVtHgg6LMctMnUUxipRlayH
         fmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753492772; x=1754097572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZVdBwsMKuczQR9Eb14UbIMxx5M0fil/YqZ9yzK2ioU=;
        b=qAYoggYd160/RngSQGJ3JMgkcgA4pR6Uv4S+Ya6tNwPS3kM1pyeYmtA6oWgln76Mu4
         9vIM4FVcr6aP375UvWcyudquSz1/0oUacykAvCsMa2xmr1jy8GDidEtO4C24yVwey4VV
         ge+DKm5JKf6spHMMSAIayIJIu9iAXt2X29twGSkqRz1HQsf0/FY8olE+ov1G3EaXR+Ng
         79fIY1Z3MDUXNJQxe9Ehwcp52Mo425EJVYMansAuSoc3+dg6Dx5yFdb4R0r8WECNwyQh
         fos3owwR8+HVF5QFCIEhCI0i46YIRdKtl5wTXlmShvEUAZcl4UK2pUZGH7L+krqu9JqJ
         49vA==
X-Forwarded-Encrypted: i=1; AJvYcCXIBjDPI2RWzBfK45NOuPvPZrDEwUZ4Bl7rv+LFYiocaADNoiUptOmK0I/ya4oe+4arEhaajwG5oyO3SWC84Hbj@vger.kernel.org
X-Gm-Message-State: AOJu0YzbvvzBMlpQYYZq3zkKNNNbbH+7nbK3W6giG1zrS9JNp10V89oe
	ixVRbjZn/s3Es8BqkSKSQkSgPc1EBzNLBQxa7o7t412HNRfFC3t5Z//SJ3xdjK9vYRUdeeRzvXy
	4oFu8HlHca81TGLm3zeB7y7R6rNOQU+KPkmBI+fER
X-Gm-Gg: ASbGncuod/oS0q28vYlICDWv2YqO3IhiZCOqgvXzf04KDYyRM1m+pePqyYddAWuKbTi
	s7W2ocYGX2HQ5t0Aa94FHNNLKCf6tNgbaDMRmF3KQiU5eINLV1/qSIYy6hAaVw5fAOBHrkImuHF
	MHgWswF1o8zDTZCvC91qoXZxASeIssAb5r8v/v65SNgRs8JL76/H1bu6RKzN0swbkRKrbjQvqsu
	fawFu7/
X-Google-Smtp-Source: AGHT+IE2KBNQfEYnirio4X2BL59DvsBPRPrHrVtbCtttpSUwFkqwbI1HzyDQ7upg0GF6894GNX2yoSeQvnGUT2+jAmU=
X-Received: by 2002:a17:903:40cf:b0:234:9f02:e937 with SMTP id
 d9443c01a7336-23fc599401fmr718285ad.25.1753492772185; Fri, 25 Jul 2025
 18:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725202809.1230085-1-zecheng@google.com> <20250725202809.1230085-5-zecheng@google.com>
In-Reply-To: <20250725202809.1230085-5-zecheng@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 18:19:20 -0700
X-Gm-Features: Ac12FXwZdtVe8wo8O-ldHOoXnQDxjvVqsJUQylN-ONGvqKrz8lvYkYCXaQieQbE
Message-ID: <CAP-5=fXyrLbQRSkhbqWWNnuinQ2H7p2wfriEBvp0ZO0AJbdL6w@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf annotate: Skip annotating data types to lea instructions
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Zecheng Li <zli94@ncsu.edu>, Xu Liu <xliuprof@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 1:28=E2=80=AFPM Zecheng Li <zecheng@google.com> wro=
te:
>
> Remove type annotation on lea instructions since they are not accessing
> memory. It should be counted as `no_mem_ops`.
>
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/annotate.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 0dd475a744b6..0d6f85ab9170 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2729,6 +2729,11 @@ __hist_entry__get_data_type(struct hist_entry *he,=
 struct arch *arch,
>                 return &stackop_type;
>         }
>
> +       if (!strncmp(dl->ins.name, "lea", 3)) {
> +               istat->bad++;
> +               return NULL;
> +       }

Should this be conditional on the arch being x86?

Thanks,
Ian

> +
>         for_each_insn_op_loc(&loc, i, op_loc) {
>                 struct data_loc_info dloc =3D {
>                         .arch =3D arch,
> --
> 2.50.1.470.g6ba607880d-goog
>
