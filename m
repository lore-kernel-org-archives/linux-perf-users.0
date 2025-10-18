Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3D1A0BE0
	for <linux-perf-users@vger.kernel.org>; Sat, 18 Oct 2025 05:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760764791; cv=none; b=MRH/RKDb7I7Se2zCQGQjAVgwIYybjPc7gr66POZy8NM3nKU+L9ZbOouaodbWzWYLUdfKm3bJW9GMHH2N7UvfVsO0H1eSLcRjN6ia0uq14SZpELK5pFvjlIpY2ut8uBRQyfX0Sz7J5UeRrcuCmzomPeZptawlS8/8qbfRmpXETQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760764791; c=relaxed/simple;
	bh=m9Q3wCPB0ojOMK2Varp7yF7jF6NgI0u/1w2UonBZYmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baXZQHXEPwZ202SZ2xryItKoeFeDe0zFZdoD4+TyNlvx6n62kWYeTLcdFFajpIDU/z9dTxMmY+/s8fNVnjC5soMdcigbzxCj4KaLQxiRXhthepvB1FYtRq8pFQKIfg6IrgJ3IlFdQe0y4Adfw2Ce7Yi9rXPFYhNR3/H/bE26lDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0FgaumR; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0FgaumR"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-879b99b7ca8so40356916d6.0
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 22:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760764789; x=1761369589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZogXjcOIkSnlm6m1dI9qrbTyG/Vvh6qq2QtKDAWZ9F4=;
        b=X0FgaumRDZh+kg+rkLaYfXBA+Uc92IpnIvhAV1pP9+az1ld95nDPJKIOOJB3Ta/txc
         DyjWvXwq56gWvDkKIMkped7uMZvbQFpxNF7p2Q3aXLOZDsIFCHr3maCt8K/6S8beBG1+
         FrBOYEXPk2bqY3lFwUcdlUXfZHDK8u9q5w0+aI3J503yifiKrsOdQ1PqeV9moE7JR3a2
         VFdEztYsEbxSGyP/DNQ5ctXBkKZXfQgM0iF3aVvPwlo200Z7ga0oDCbnw4GkJM/FapxQ
         ynHn2Wc0HSwMFiS9wtwyUQE5iNumbP4d0WMOPBGNTTDzG73a+itSWmeh/tT89Ryj3fCT
         2+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760764789; x=1761369589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZogXjcOIkSnlm6m1dI9qrbTyG/Vvh6qq2QtKDAWZ9F4=;
        b=AG3bjvtC+OhIKHJ9c5uWQ2awT1A57IIlDSYypVFzBOYZpN1itqfPQOxSV/Rc4vd9rw
         F51ZGFkvEZ/tWTOCjbrDZSnS8cBsaQ+xHEBKwZX/xJ+GvT4aPll+KPWnKPX+kfSsUc12
         L1vxf5PHwcTX9AqX//hMQpbOcmXlyxIv0k0CJPeJKanBx8hFwuMl5dHrSBRLqFzoVve0
         u865LG+E6AGl/V1v+IdsBbTomPRW6/uZ67BnftsOs/eUelbQHLEJF7dChnRTV+EY7eN9
         0wVb/FoElS0n8+2VPRZIcIiBFW2IrPIvICbrt/FJBnVrcj2PyHg1NdOizWVc/FIqLofM
         wWRg==
X-Forwarded-Encrypted: i=1; AJvYcCU6DDqf/w390Ad7VUAmtSLPrSJncfBVM3tpHa6SONL5I5Cq+Sytxu2YWKK5OSKRWO/hYNGVgahksBOAdkuh7oFr@vger.kernel.org
X-Gm-Message-State: AOJu0YzVtAtNPbafryOLxVCqFlLdliVko0jqmBkrezfAzWz5wEee4U1N
	SXSNaSiIl20Lj0v4HaZPLB1Z0v/qcaIXk1nF/b7YTgO1rkgOoQlldw/D0jSzogG1uzNE34vJdPu
	IZoJMyl46dQDUOzQx4gAyD88W8qBK6v8=
X-Gm-Gg: ASbGncuX4BhI6R7rQePTgMTXsYA4231+sMt0WtKOV7pxpR9kJ7XQ98N+pFp2OhFkFRX
	k7yxMQHMWlCFJ2aO+tImUfvqq5zU82/Q1cNnCxONgmsmGPFodDXdU0jYAKQAc0Kbdr+uchjpipr
	h8Hn81iGSkZE8fdg5LADIWbd9uz0GUCUGzz85IXumhekqvSZtG+ZFLOKuCkHzdk5TeaJSU9Gk83
	9xVR6azcgPSM4jYPcYgw3b5Ut9ex/5W362SSSoOIyzhRR15/FltRIYhSwU8i5FcUoNZrfHZpNcV
	fZOM
X-Google-Smtp-Source: AGHT+IHhSo84IPocM9veFr1T8h8TCcjVP2GqaH2UgQmyQF5cTThsv1inzPHCl7GpEyOCHDd+u1vl/TmG8y+dcznfJ3Y=
X-Received: by 2002:a05:6214:d4c:b0:787:8e43:5761 with SMTP id
 6a1803df08f44-87c2081dfdbmr84963416d6.56.1760764788714; Fri, 17 Oct 2025
 22:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018045902.21665-1-irogers@google.com>
In-Reply-To: <20251018045902.21665-1-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 17 Oct 2025 22:19:37 -0700
X-Gm-Features: AS18NWDzgNuxVyTAzbzE5rLpbz_CXvPxcUXsFNspFB4ai4PPU3p4_sGq25mvINY
Message-ID: <CAH0uvohAneSDaXoDfNdOhg8Osnk4AYye4B59zhS=NaGj4upM5A@mail.gmail.com>
Subject: Re: [PATCH v1] perf trace: Don't synthesize mmaps unless callchains
 are enabled
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

(It's been a while, forgot to switch on plain text mode)

On Fri, Oct 17, 2025 at 9:59=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Synthesizing mmaps in perf trace is unnecessary unless call chains are
> being generated.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

> ---
>  tools/perf/builtin-trace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c607f39b8c8b..a743bda294bd 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2005,7 +2005,9 @@ static int trace__symbols_init(struct trace *trace,=
 int argc, const char **argv,
>
>         err =3D __machine__synthesize_threads(trace->host, &trace->tool, =
&trace->opts.target,
>                                             evlist->core.threads, trace__=
tool_process,
> -                                           true, false, 1);
> +                                           /*needs_mmap=3D*/callchain_pa=
ram.enabled,
> +                                           /*mmap_data=3D*/false,
> +                                           /*nr_threads_synthesize=3D*/1=
);
>  out:
>         if (err) {
>                 perf_env__exit(&trace->host_env);
> --
> 2.51.0.858.gf9c4a03a3a-goog
>
>
