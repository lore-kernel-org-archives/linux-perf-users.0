Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDA02DB7B8
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079147; cv=pass; b=cT5z473hhAnSv6L99W5UxphCLZknc/zc4+JF27c/JnyTA/nOAdxsAUbmuwnBR9CPvR14jqIosQ3pjZABo1nl+1ikm41cLnMbO0kC1v0qFpVcB1GveL1SRQQi1xAIWCfm4h5WBf8Smc8UpJ/jtrzDtbncTzpJG/uAo/sywQn4PrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079147; c=relaxed/simple;
	bh=K9KvPWrinhMHT35zdp7wWeOdqTqba23yLvkTaWHsvhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrrchTOoPUccoEaXIG4gy2Fxp6d/Deo9+sRaPOaxoYTjhUHlpwH6bz0/dLfasiI9YVtlrl0zk55eVlc8WhqOCn8ige0NieNZU4FnAKfr1uUgPVzjCgETvLmnbIypbK1fu3LrYOUtzrHXImb2n1xdxSYu/iSEOgUMaN52vLWOiI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FXjxLhzh; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FXjxLhzh"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae4b40999bso15025ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079145; cv=none;
        d=google.com; s=arc-20240605;
        b=d0YxpJ6AEcywwCGatiOe2rGXQfE7DJlvi+6JmWknq8qM/j3SvXw41XwQB/t5RN7+Ql
         sBKg9grUVTFYKk6Wbip3VCbKqJZYzn++k9E3BuR2lQGzkvBsJOMKHJwBQgt/KpT8fJaR
         y26+pbCgUDS7Z4x1E3YRE+HF0CMx1y3YasxRjV7V5IK3COg5lkE13UpVKXvT4K9u/8yR
         Vmh5gmhvFx2z76/msFt6yCJ+1ID07Rn3GQ9StFLmkNqjsQS2yQBe9UrcUN2HutAtBGX/
         xdpYVIIn2vrmxmAxRulRO21CYCwQC8bMW4JfwVI9e58S9XS/dwKmOBkCuP4eov8AhmNY
         Mu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aDreSjYEwoLVTucpTragxMff4MtZhsK4TyZGpsfQmdA=;
        fh=Cq/w9rC8ZWs63LtOTDXcc0oB6q8VAjsqRVa342SUIHw=;
        b=g7Qjf0YuNz+5yPzWsBl3CHpAYsiyFAX/aXx2xWa5G1dcZ/DqWTs9mlcz28siGQhJKg
         KOArwzdQtXrnhPObWC8VmH1B50yxoKbBBM+rv5vwf++tALpa69BsY1Jin2AKDA5PyGjK
         4djSKkbx/F+dU2Rt/IAFWZD8mtyJ8Uh6D6Y+LzKbmqnvgZ4xTnnKiVx9kIwHVhS7rsri
         9RznTczPBQ2BZiry1moeJYEvRkaeT0u21dZ/SQUUDyv0P6c9CnpD4/MOgeFUSypa1haN
         REfD3AQTH9JfFPEAU0KHVklBaicfLAyod467LFojKYUCqjmA6HFwYsqPhntNBzJ4WrD2
         JxVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079145; x=1773683945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDreSjYEwoLVTucpTragxMff4MtZhsK4TyZGpsfQmdA=;
        b=FXjxLhzhK5I+7rJHMQD7PQ9l7YRiR+stKFJqLX/0Hm2m5CKzhA8Jet0oqOUqAjGxtB
         9K0mhWZDZ0d7RS8PlzS4F2P698fyhLIpGV9pPtbjvfxm8PHmeR3ad72TBsFCTLbhZBXC
         F+TVuSCDnwESM5tKcnJoDf8PBkjR1Cp4z6/vmqvur/VmqcnW/9VqwFx8+wtV/CwRbEQF
         1y+sG8gl+6cOqNu/Bz25vG8rYqkIehC5YYjvBSCh4H++GimMMCXiev6cxPukjfoMTl/H
         dBZw3s7UCAELpHisaYa1ITE3jWmCKlUnNrYxYuEmc5HWfgSpUaOOEhYufHGGKvxTNwnV
         hpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079145; x=1773683945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDreSjYEwoLVTucpTragxMff4MtZhsK4TyZGpsfQmdA=;
        b=oJ7bXJb350ycF/bwfGk4HHghD0Y6hQRRuGIoOw3BZSm1hnNX39nm1iKtjbyYdLMg6o
         Ilx942R3CW0iVp4qrWA4fFhtU/zuu2qenstbJ+6otPVzESwQ8+yCm3vvATXjSGsbExoC
         3WAcdwNJQfzLiq1PPGzE8X6NPOD+t8QOFt8MZvaVSu1Za/QWS6TQ5K+Jxivm4hEGZ/TU
         CKywrRkIOHwF9MZXrALl7hoiMhWGVp06gOMbIBf6kwYs8OjikLyQdWl/p89R0HR1sI5L
         cyru1Iy0nIkpMP/CoOoaoqNeoYjLzIMxBF6ofadbOVntsN/AZWD5P4ixZpB4gJH39WAO
         MdiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh7OXxOKq02QC7kl2ZnlTj8EjOyiDAfwkBWCit629Cpx1TH4hmoveqXIYX9NuHzyqKBXOmGiOCyAnxtyPJv8pG@vger.kernel.org
X-Gm-Message-State: AOJu0YybMYe3HxBanQQ40kea3kgOeN8ns5fw9HQUc6AqhZDOmB67sJAB
	Ioiu3JX4vvSFJjS1CR1csBzy+IYZQUcNR8KiyVg7PlsaXthMgNwLb5n7hpqJtF9lA9eRIPkXwf4
	upbUn/sAElUM4ZFn6QpWij7QeSan3e5t7jkJMiJSu
X-Gm-Gg: ATEYQzz6j76tRtksIAofc5pKa2UJsPNpWH/alTYzfrkyPLCLg8jtMK5NHSedn7Yy8em
	FcscczBwPV2FcnuEACMLzjL6MLEujmAboky6seh8ETge/w2bpxCvF5gZylnOzqtmDux+254qSU7
	trL5ickVIrunpoMctai5CIT9js+6KB7C32GOvUnGPsyEuRVpho2lx5CtT0a99z732z9c420TeP9
	yRaWmAbEh5YlSUO2XgBF7P2rUKiWN8LB4YyIGUs/Z5xsl/G4+uaui0mdE3X7hNiXes9GlKm071d
	pe8euirZp5hDj73PHqC7MQcB+YRlaV05DcY=
X-Received: by 2002:a17:902:d4d0:b0:2ae:80a3:cd11 with SMTP id
 d9443c01a7336-2aea311f196mr241605ad.7.1773079145133; Mon, 09 Mar 2026
 10:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-16-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-16-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:58:53 -0700
X-Gm-Features: AaiRm52uvKkGWQKOUhlbyvaGeNyxJc-w_yEiNj_NYeHVrpEtOTjr68aBFV5Bu78
Message-ID: <CAP-5=fXSK7fFp-=W7MavSMKbqpxffFSXKEmd=jt=7xhzvYt+vQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/30] tools: iio: Append extra cflags
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
>  tools/iio/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index 3bcce0b7d10f42208765be83dac047faa2e0ceb1..c189af6286751d141348957e4=
d63d33b87410381 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -12,6 +12,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS +=3D -r
>
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>  ALL_TARGETS :=3D iio_event_monitor lsiio iio_generic_buffer
>
> --
> 2.34.1
>
