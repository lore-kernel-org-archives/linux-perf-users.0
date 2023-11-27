Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WlV1PSJf"
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDB5199A
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 09:35:04 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50babb66dedso4976e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 09:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701106503; x=1701711303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0qraohhsDJyV+XLYjquw/kxd3mqLCTJ1OQXeXtBtQ0=;
        b=WlV1PSJfIoXjvV7PBB0M4WA/2Cole0AGBQqsNcqTq0KRgYZYtHjKxK/zEsGrU9yQIW
         La5Zc7tH+ZXjNmJ38/JB8nfabHO/bCYwWaKZ4u2hO+YKsePus58lx2jmNGLVdoMQaBS5
         MtnUPIHp5jPFGlZloBc6DaJGSTGR44lWpl/4hGtl01DFyrucEDgOsAg4f4iXNBsHNpsg
         sAYfkTskwuT1QAkzsnWBybCBb46Y83+l8alkYRyley5EEM7ycD5OJe4dBryZceq2GFUz
         ClGD6AsKlZDAd5bMONtyTW16rlkcjfiuzt6jD/GQTGkMnKDp6Afrk+ASR2N//y88EHbY
         Z+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701106503; x=1701711303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0qraohhsDJyV+XLYjquw/kxd3mqLCTJ1OQXeXtBtQ0=;
        b=SweZolUpJ4YyVMeTjZlzahGoNFszTAtaBUdaA4tCM7TQBySpOk6fNqjFA4MODfOZ3E
         eTvMACpn2KttxCWJFiD7WWIIUkLj7IvHFuq8TraN14ity55yuPgnrrU4bqmmUeF8CrwG
         vlHqGF9LTTW8DrZQuqEsQs86/hL01cKHmvRyf4pEJEbz6dg1W3EFyQYuqHEA1eXXW72B
         pHPxclLDzvO8XoKMvAtNvxuMs8/VuxRdA9MflLjO94zcOkbt4URIf2leMixtNEJTl2ZZ
         4/3Bs1Jb3E6W7JLCN27Uz0cXGiPBfu3GJhsfvsOLsFwkiDaouOQO+PrKl1PxtGKKPdRt
         nOUg==
X-Gm-Message-State: AOJu0YxygO0qhui7P7ZgXME2C8SL5yBFUX51o8FZpLBEoCLCdCnj1l9i
	bxpE9vHt0r+QHCaOdLhKj9WrLJmrceYY7EvADL+25A==
X-Google-Smtp-Source: AGHT+IHd5BxJVNTF8NcRPo4AZx8UX60AbY/mQ4TL0i06Q0/uZoT+ZXYYVz8M9737OLOSpV3v5Ha3SgJzZrr0AEXRSIQ=
X-Received: by 2002:a05:6512:239e:b0:501:a2b9:6046 with SMTP id
 c30-20020a056512239e00b00501a2b96046mr544129lfv.7.1701106503002; Mon, 27 Nov
 2023 09:35:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123075848.9652-1-adrian.hunter@intel.com>
In-Reply-To: <20231123075848.9652-1-adrian.hunter@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 27 Nov 2023 09:34:51 -0800
Message-ID: <CAP-5=fWnZ9bWCN49v0NhWsAVVYOVOhpyV8x7pMOvHUjeQBtang@mail.gmail.com>
Subject: Re: [PATCH 0/8] perf tests: Reduce inexplicable test failures
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@arm.com>, 
	German Gomez <german.gomez@arm.com>, Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:59=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> Hi
>
> Here are some small changes to help reduce inexplicable perf test failure=
s.
>
> Regards
> Adrian

Thanks for doing this!

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
