Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760932BEFED
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075843; cv=pass; b=VfirP3tr0fouXUsOmIRn34ajibAu1CEDXhLJOoiqC8JjWi4+syrNluCamqQk32W0yhL5ct2b5dRbmOZAlryuRevohT15sBpEdSUzoFHsOI/czL9V+xQfYlEGLk6y/4xxTgoYt/P4rziECPkwQk4ZSt6X7B/eZJN2vSwYtt7xRLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075843; c=relaxed/simple;
	bh=ASdF+Mq32+mdYKDjWTsjOQ8jTq7m3B4M/EbHwWyjk4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lv327FkZ+7gCCsQ3RgG7dQ2291FXWGKjt0vbMIGpLD5tzb/4rxOOrRQbv32Ld8WR+n5g4/FPnoe4X8YGYAGnFoVlkd832AQUrJQNldi6KeKAQrIbjTarAiVcqKjjZ3eI0M2D//fyAAeARNNrJayHr8pPiBO5hzrGWX8xOGTGnaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWFGVtEP; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWFGVtEP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae523d54d2so5735ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773075839; cv=none;
        d=google.com; s=arc-20240605;
        b=GLIf3htnKvEJ22S+xOaYkoZOqODHvk+A4IoJtvJ0LpxSF+vtza29Saa/OrAHOxCC2I
         m4Wbsn9lEx3uTg/O0pgGdJwNLi8ywurmS+SpYpVoDClsw5MZUUDB9INrcwLPbWjJHqIi
         H0BnvoyJAIRW97Zt1YRXgyJxOojduurDNLO6Yp+GKtp1w69YEdln0RReNs1BOT+hr976
         YTNnFmWPaYnFCcdawtbqtJSe9HIuMDoZjU7vrKPxZOap/YYQmiReCbjD2g7H4CfOBbkj
         wWjENMQFf0U6lRvlAniO13cAGinhuPLaahW5mQna6i7kwLQA58cJV9WGEtiKih0r2YQ1
         TM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=waNBZBIho4Q6qhndz2br3MqS0TFnbVcCKcfXaRGOh+0=;
        fh=wb0g/g/mpISaJOLRfw2Np5XlpN1I/JzUG1Lsq5mAsq8=;
        b=E1A9aV+CnEuinAFQwC4l63LJoc88K2aDZJLIkwk2wIQ2XBrJueK31Scbd1bBW5j4ua
         N/hLMlJ2CkaQNlCMnwmC2AIrlSG//GUAvLfk3aI8KGN5NoNF68FaQo6o4KswEtj2krpx
         Oyj2A/Zl+mtFS2JUcI2p1YBRFSwK0Vx3QZ3BBdMJj6SvgUWa1VgX5ZHFiSLL6lKwW8UF
         afB7DemxggXs9kaGvrCi9SSr4JbtlksBeX3H+ZlBSaJec58NIGUq+ISDCL5Sl/Lxi6dR
         niN9fO9kacqT0dDlVp/2i8MRkMCJJioqntp2Dn3q80MN1rwhjC9qSrJlZwf5/3rifwYR
         aeDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773075839; x=1773680639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waNBZBIho4Q6qhndz2br3MqS0TFnbVcCKcfXaRGOh+0=;
        b=NWFGVtEPjGwnm3AV97g0SDvhJ/Z3zzMc6n0/jk7mGvJkQlhelIdLrTIkxH1hNMnN7h
         00SwW9XOPz/BOevtUkq7gjPt4TgREwDPd5gn+hiRQ58E4kRke0zIMsmMUXhWH13f8xg8
         aHjQuDIwEwxuQIrxIPNyi7w1mzJ1rsPJJBsxnhNP2TSmVwlLS2YBCVwGzhzYRDgDvLrD
         vgtAs/VP8LdyWRUFzY1zS2f5BBtgMa4Qc3S3QW93Jq8aqTFeX4zwChZkv0gJzgYikdrf
         cP8AqqOfSdkxmfNgFWUZ10S1n5y1ETen0p2GL6UmYfDQQcIUOkhS6Cb3AEPOVIw6hZvz
         58UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075839; x=1773680639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=waNBZBIho4Q6qhndz2br3MqS0TFnbVcCKcfXaRGOh+0=;
        b=jKvO6rZJwp5NylC2qwZ6lA3vKcuwcq9L8mpZnrGau4KsJCrvu5+DqLWsCMZCjrZJet
         tChVKWoXqvoiMZW3SY4zbipZp+mPfZeXRpMh4EKL0VQSD4GgX6SSf7MpxCIgqvYAZlCw
         8Niusf9Qna6txT6/KCIJKQdS3EQ1Kvaphle1+NCQCMP86kX+GjQwxgsfoNEI9kDZokIe
         rg2X9PUNdAf8bONtfaLbGpICFl03VtFoSeWzc9b9PM0gkyqYZWx3nrzfLWhPJEWZty4o
         BGKgCogLV55jtkWcAuJHJSh8LBtWRvcgp9eOH/dQWTFD0b+GJ8cIISj+VDEiE7K7mQzR
         7gPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAWzlbLZjmhnu9Q7v3981yg0v9wnya/NlN1gEO/XWv4QnLzPQ+5KUfSc6yACMw18a+Dz3gDaS9DU5fHLwWyY4G@vger.kernel.org
X-Gm-Message-State: AOJu0YwszUH7rx5junGSzvCebTQkPvAnmMZktxjvaxiCCIlYERH9M/ok
	sVpzpY3THMsRVcmZsfpmXbaNfhVYkUf9b/cU4Z+zgtuWFCiSFqorvpjzED7Ku1b2A4gtC5dEpf1
	kCBDa05jtsidH+BG+BstKQFNttPpOgDcc7J9iS5dd
X-Gm-Gg: ATEYQzxpwoROU6eNY66NcIMQBK1bc+TmPIGXzcFgLYggM3PdZZJ8bfuqXPe4og4QfKJ
	mHF71HdCErP2vZAPV1UNd16FLsvHusgUUXjOSboDD/UDN4oPM7HZn367dIFwQ8YmRB9WjK20QTW
	vtfqgfrtkQbeJDyTUMNdvwltRHvDNZe8XF9J+JHUemD+ePtpImH0WAWRfp7MstzQIu5dXCkyjAm
	jECrWYGShsS7JS86v0/JSUUcZ/43+0SB5ejugQNjzBndkgQiprwHyk5WGYchXGATaFl8N93cznf
	/k+f5gEkWlPseCbMeqdWmdIjf+StUZqysfQ=
X-Received: by 2002:a17:903:40d1:b0:2ae:44db:570c with SMTP id
 d9443c01a7336-2aea3053fbcmr53805ad.12.1773075839042; Mon, 09 Mar 2026
 10:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-2-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-2-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:03:47 -0700
X-Gm-Features: AaiRm53Xzo9WAGNyLfx5oOgp1hEVoxj0zvCDJaSL-xxCQXMap_Y2Qeu5UcpeDVU
Message-ID: <CAP-5=fX7f69cyuvKwXbJWz_njdHNdcoJxY=wWPCcz86XMXBX_A@mail.gmail.com>
Subject: Re: [PATCH v3 02/30] libbpf: Initialize CFLAGS before including Makefile.include
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	William Breathitt Gray <wbg@kernel.org>, Barry Song <baohua@kernel.org>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kent Gibson <warthog618@gmail.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 9:46=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Initialize CFLAGS to the default value before including
> tools/scripts/Makefile.include.
>
> Defer appending EXTRA_CFLAGS to CFLAGS until after including
> Makefile.include, as it may extend EXTRA_CFLAGS in the future.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/lib/bpf/Makefile | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 168140f8e6461bd06db40e23d21a3fb8847ccbf4..76cc802375f67b9d8f589904b=
d9764040947e5dd 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -49,6 +49,14 @@ man_dir_SQ =3D '$(subst ','\'',$(man_dir))'
>  export man_dir man_dir_SQ INSTALL
>  export DESTDIR DESTDIR_SQ
>
> +# Defer assigning EXTRA_CFLAGS to CFLAGS until after including
> +# tools/scripts/Makefile.include, as it may add flags to EXTRA_CFLAGS.
> +ifdef EXTRA_CFLAGS
> +  CFLAGS :=3D
> +else
> +  CFLAGS :=3D -g -O2
> +endif
> +
>  include $(srctree)/tools/scripts/Makefile.include
>
>  # copy a bit from Linux kbuild
> @@ -70,14 +78,8 @@ LIB_TARGET   =3D libbpf.a libbpf.so.$(LIBBPF_VERSION)
>  LIB_FILE       =3D libbpf.a libbpf.so*
>  PC_FILE                =3D libbpf.pc
>
> -# Set compile option CFLAGS
> -ifdef EXTRA_CFLAGS
> -  CFLAGS :=3D $(EXTRA_CFLAGS)
> -else
> -  CFLAGS :=3D -g -O2
> -endif
> -
>  # Append required CFLAGS
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -std=3Dgnu89
>  override CFLAGS +=3D $(EXTRA_WARNINGS) -Wno-switch-enum
>  override CFLAGS +=3D -Werror -Wall

Not a problem with the change but AI assisted code review noticed
something unusual. Below here is:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/lib/bpf/Makefile#n87
```
override CFLAGS +=3D $(CLANG_CROSS_FLAGS)
```
and $(srctree)/tools/scripts/Makefile.include has when CROSS_COMPILE is set=
:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/scripts/Makefile.include#n116
```
CFLAGS +=3D $(CLANG_CROSS_FLAGS)
```
so it looks like the CFLAGS is duplicating $(CLANG_CROSS_FLAGS).

Thanks,
Ian

> --
> 2.34.1
>
