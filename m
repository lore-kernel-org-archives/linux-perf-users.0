Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28DA2D0602
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079171; cv=pass; b=g8w2DF1maCmzlEWjP0Qt6MxZbIhQ9GPSN5X+Ox774h3NF+9np/kOAKOKdeQbRTd3sr4LJGl6G8kbw0cf//8vXIOO1LNNmwlmGmovy5EdRTjN3szXhGV8b1iEUVwdWPNEa5dbmJAwnUwlbQE/+l+00TfI6U8pssFQhLFaBDRQDYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079171; c=relaxed/simple;
	bh=jtXROgFXN+cxX3Q4sedN4Vfye4bLDvRQNMbs+Ut+9NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hh1HNJzMo627axWa00TIa6gwgh8SpSpb0Lfc13klai7yvPBNef2PoRbvq87ugj4phNOZaxxyb311RE4FO0MjdrcC7rkaYyOyrH1KpmddxWs1eAt7MNe3ywzk86asMnLKXz+ctWWsTRoZrW7/6oBVFGenZRuzDYAQNYE6KeYr6tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXcDKtR1; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXcDKtR1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae3f822163so13315ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079169; cv=none;
        d=google.com; s=arc-20240605;
        b=gfAmsM7REtgFswT0WC6p9xwrVYTiKux490jyVAdCJejf66p6a9//G/Aq80CqyL34Ia
         3Xin7NXC0I06dKEeE2ack8OYkSd9yZOJqVLffetf3i2RjMmO4wDaKDwKFRDcTUjs8bVf
         B+glswiW2bfFwz8X50uRwzlEDJ46/XWwgp3vGAgcTUuENwapxtM+SYMnh+Nb6yTkzlsc
         +mUnFjdZDLn+NvXGC/8jnAzDoZ1OaWhAtd0Ama8LHINwJUSLnmrEYJGCMXly0uT0+5AN
         gX9fCsijAJ9AtJMEYsJgXhvzNlVAKJO30noKYhQHaLE8zWc7PL1wKnPSBsnYwLUqbBIy
         xBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ctFWtlUv7s1JIakxz/VQBeCjue+g3dZBcOJ9UZNZBPo=;
        fh=4BWkuBJjeKsN0/5CgOXTm0UE5M5HmUhY+hKb9P+Q/5Q=;
        b=UBg29Oza+mBuZ7dbpFxRI+FfFRmris+k4B/H8+PP8dj7YCOiIQCZdTlm3b1KzV4iOg
         uOfSbVUe34L+uOjqg9KkWScE0ekRmCkiVAIZRGdkJSCg3g2X6MSh+RE4zLvvelY07/jI
         znyn+O3+4s61eTR6nk7yv91oa8cn8tQ7qX8rSjKpCfQRO2tK71fE5DxzQfoVMeDe4v4i
         d9TZq3zNoOe9G3TdmD7vfCAM5BMvkv69Y8FAUeIhP2+zOQzPyz4QRdqCnDGrApTviENL
         Sp9sPK9fxCj/z69uC9eLaOTSC/xlEx2uVvtTFZa2r6Jx5v5Eyo8C2DTfC4NGtQnONtf7
         EFZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079169; x=1773683969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctFWtlUv7s1JIakxz/VQBeCjue+g3dZBcOJ9UZNZBPo=;
        b=JXcDKtR185zHStqooQ2HoiG4ls1woxBQjotTexjxKS87O4Ko/VqFobYehcUvKsoLSv
         nVzaz/+0KvZZKGxmxbDBA4jBlXKbBkTfcEqLvErggtOcP0d+KBNSXLQ3rkWcZ+E3RR6p
         lq/UFl8TkWXjRmMfHPugjs88KXFUZ/ESoI3D7G4v1wwWOLZBeUF0wnXWtsQsl4Z0NiK4
         328lTGmxL7/tsT59PMTl1aPqFW/vpDXlSgglRmcKhvuuvdEsZy4DEz98rt3JuGuplxJB
         WqIBGvWUMmSzUpB/pMt2ftU50wBHK1cQh/rJUeDI0p3ClktpJK/vFC6tcpOqhlkqC34k
         D8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079169; x=1773683969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ctFWtlUv7s1JIakxz/VQBeCjue+g3dZBcOJ9UZNZBPo=;
        b=cJuUeONNm0VhgZzdVNND2NAhNJtATjthSqe5hb1FDY72j7XSShcAAs870b4S00QRCS
         upbKY6Sg7Zv9EcOkUF5PGWSLlQ31n9Onbn65xIbP84phJ5yY7lC5SSu5KFj3XliOLM/G
         yIBL38b9NsEFpWT5XwxdfYg+DE34X/YybD2uGAze5Lu3HrOzz2BQxkOxGVpGGFPt/mBB
         9tQWjzMb5YnOT5BUtjMHMBKZYVQdWfh2+qzSEqNT6FKgTf+BQZQCN6K4f4lLKbdyIoZV
         d3XEssp7kWrn8h1Wx1bt6tszbMpZoFzW8NuShheBxYYd3unJRxeL8XynOn5FiZP661Wl
         LJfA==
X-Forwarded-Encrypted: i=1; AJvYcCW/7vDJExcXLB4CcIG4P/P4pjPl6GEtFAcS5WFqV/s6kmR1CWoQ7D7r+xGmJiXCzF2kUFR3XcQXcPeXKCtT2FbY@vger.kernel.org
X-Gm-Message-State: AOJu0YxrPyCdGEMIwAzQ3+P7n8KV0RBIzutTwZi8pgpMz50k5doX4+wY
	Q6xdfhNDVNE3trSO0kNiJlWnCuAjbnX8GwAa+7Lk4kosclIoo/atTBpihPoLq3WgIvoqQAHx9Au
	fh/zYwswnsA7bFeCfKDKdWWKnceaeobct1VtBtT7H
X-Gm-Gg: ATEYQzzFEZwq0nXBv/mkEB7vCflXNyomgEkOpmlhpL+IuLlPQ0WSDWXBmgHUFadq3Ip
	5tfO2xw2HtOMCMU46fJd+rw0NaxfN8myjh0Jk3A2NSC1EazmEs97Mh6yP/Jrv9KAevQRdmvDMdu
	FB/MyPUVuIa9fh4xhOXlf9mk9XjLmm32Mtm1D4b2oyvpg2MJ7ds9H6DbUYzAh8i46jCFBnTEG3P
	Fd8kQ1UVwcy7MlwE+mH28cxL4b+1aRCHbiwmFev/fQUyW9zFJ3KQvgi3UP6/1YpP1C/Yl4ud3vA
	ACFnLPtLIk2l+GFq2XevRsOe/lrBV3UPUxjYzTbxOss5UA==
X-Received: by 2002:a17:903:98b:b0:2ae:4572:50e8 with SMTP id
 d9443c01a7336-2aea3021bd4mr262895ad.8.1773079168841; Mon, 09 Mar 2026
 10:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-17-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-17-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:59:17 -0700
X-Gm-Features: AaiRm51Mi3jyhZ6d5D7Dts58gg-d_J7aFNrAN6Haonrc-goj4a5d3pqt2PgJB3o
Message-ID: <CAP-5=fWd3wr_jvagN7P9tBtbtva4m1RGRmx8rREVLZVXFeWZaQ@mail.gmail.com>
Subject: Re: [PATCH v3 17/30] tools: mm: Append extra cflags
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

On Sun, Mar 8, 2026 at 9:48=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/mm/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/mm/Makefile b/tools/mm/Makefile
> index f5725b5c23aa261994b5b42f37c443bee2edebf2..742c1639db0a6f7aee59cf8f4=
634cb40eacd49b2 100644
> --- a/tools/mm/Makefile
> +++ b/tools/mm/Makefile
> @@ -9,6 +9,7 @@ INSTALL_TARGETS =3D $(BUILD_TARGETS) thpmaps
>  LIB_DIR =3D ../lib/api
>  LIBS =3D $(LIB_DIR)/libapi.a
>
> +CFLAGS +=3D $(EXTRA_CFLAGS)
>  CFLAGS +=3D -Wall -Wextra -I../lib/ -pthread

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>  LDFLAGS +=3D $(LIBS) -pthread
>
>
> --
> 2.34.1
>
