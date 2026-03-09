Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A9347BA7
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079290; cv=pass; b=HcAXVGIri3fb9lWwqje5poypHLRME4mxJDfRtN8+eMCZF/TlNi4f4eWUR/pc1eSUbr8vImgNkLv+hyfquLjYb79uqW3ZHU+bv41R/B8T5YTHmUApNytLINEXYtg24mSPw1iexw938rx06HqWAfWhHbaDJMooljzPnFYXJDFBXDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079290; c=relaxed/simple;
	bh=PoafOCA89v7UXLaSorz9ixnmscwPr1Rj7wAcGvs6co8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRii2KdT1csysGv7uEIyA1kkJc4jv2ROh3u6xDOK6jX1I1zVCMTZdYv8S9ONXXSV6ius+v4lqs7eTvWLGoIthG3Aytr30HNYw+zIxFK3t8iqVT5zUWn08POI+mjePg7rsTC3JGcPOf1PrFG2f1pgiFssu82TfNQ0R0cqOym1WCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0sXvS3e; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0sXvS3e"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae49120e97so17375ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 11:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079288; cv=none;
        d=google.com; s=arc-20240605;
        b=IEMIaVBV9xiy8ev2+TwnRKKFgUzqxTkChGLsPTjQVStKmu6L8UfXeXBwYNURsCfiBz
         DufNE+dxKGpm7qzqFgfpJaEFJZG5tHCkqMmGcu/YpNFpK3gfN2Y2VVeebKXx8TFvIu17
         04Ii+S6bE1NzV85/J2T90ovlIR2M3BoteX01+hdktsgNg1RhnUZvTbXL8BbLe1CD8cz/
         pE/6/LUSvL0JC9+/EJQJYwQnyhYbmIh7nFihuzWw5kxQ8sE8mCOtrHuUFBKh+FUFWR6S
         RBmurKlMFckpN5Ivabej/dstjCQG3q4ObO13tXzHKWL3qK2T+a+mmAimzhjRJhdulYR7
         mW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r26udjS1htgyNVho4B7xDT7S+9gsz+aLoULdjRjLynY=;
        fh=QZL+/zXTthRddTx5ryaFBzOmLUb4znSVasUTK72u2U4=;
        b=lK81GAFbPZDYEv2uZzMBCAb4Nd7OjcZ4tyyBwxEFK/L+ribYnRWvSA3OoLqEmnFn7+
         zbDwFcdoqN9/1uCuP62mHe5EFl9dE6Kl+fNvNSom6ESYmruPFMa9yoKmD30n5A0H4XZZ
         8wGiGLvXmTay63ZJOclpqodKluOXxYc43cPd8crgmHmMjzlQKdTerk0uUnbkn8bGAcks
         hGJO4IfIy/Rbf7zOoz6ynoXVPguE6Ez9y8C7pz9fzVTZaUUqnkF13ZvdGGxjIQhoXAA4
         UlGYQ8IjXpT47s9hESHcjG/P1cSxxHTj0XgBaRl6QHfJZR9/aRt59gKH7K8XfPOSQcp7
         htag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079288; x=1773684088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r26udjS1htgyNVho4B7xDT7S+9gsz+aLoULdjRjLynY=;
        b=R0sXvS3e/I5akTTuTeCu4/jJIptiWFofAK4uX7F8xV9Q0aix4obyy0OxIWao6C82Dp
         TVw5Vnv7o/aS/xY+tHuyyOtYK3vxD/wn0dV0UHAyKkuRBBll/mPH7objExp5OOyV+dtr
         S2aLBFUha5vpP7DLrIxrHwRQiudeH5DHy4qrQSqSocIVfqeahA+v1tjfUv2gy2DbGwoY
         s/l/1G7RFVPLpQ9cGuKurU830XU5NpNBgS8eaQ3nmN/vl6v2SmNk/zx4CiJse4MYO2a4
         ko0uk2ZmcdrPehXMhEboiNJ1IiaV7n+LsaEb+lRFSfoJ4zi5PjL1SOgRUXqveZnBZxw2
         J6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079288; x=1773684088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r26udjS1htgyNVho4B7xDT7S+9gsz+aLoULdjRjLynY=;
        b=cRKdFwOzQAu3UVYHs0XjIlZpM8SNF8NlU40hZ1P2e05WMGVgag/s6MFejd/tGImgoV
         FXysd+TbRApWuT5SY81XT2ftmQNvCOfwayGe/mzDyL4lWIYoKNZxS7yxs2J4P0W+8e9M
         OPXKtMZdNvITBaTOmN0ZBOSGItEnMihETw1HxLpPv4c6XYab8E/49PgZ+PkNieyHNf5j
         4hAQkCZWpTcGCKM0qCz6TVWSGhkF5L9jIY1HbtvFlny3ma4METcUXym6xeg6cddp/33c
         EPjYv/VvD8h3MMWyhOmYUEsw19+6kSzoRT5OJmJBgA6oVFylMcvLFQNCgvzfR+fxkVhX
         tvyw==
X-Forwarded-Encrypted: i=1; AJvYcCUsg1a64V1cnRuMh3dqDa6EvF/gg/BQx5LWMCd58aEJECgbIuq0BTA1gTQLK1Ye7KEfm9EwGd6GgDT7vC/Vk0Vw@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9kkDM6GZmHH76fh6et4FLPAxaShLC766dpqEJDpglXZa4cXm
	4fs0+ZWFzMqPpAssWcbujlPpf7WRkSCZpFJOIDmIZrrTCk5HOV54Tmj/6NzTNeL9QfEZzC2DVaY
	FGCdbDVjKzfdrmoM7qccIwd7/2haULkt5ddzXIjMk
X-Gm-Gg: ATEYQzxgBUZG1DssZwGoayjOd5dHyY/OfHbK5FwJ9CW+V4KUsdyiFD1/KjU550KGpZ7
	ltLfxPmvh2S7vY/EvhXywOTJIpDuJ1GF3bvYcP1+kPFHeeDx6eOeRIVwgDOF5Xh764vffZDIfZw
	O83AznCRvpcGuJ9pyOAQsckP6kog4XwR653ZZAbK/y8tu5gyKRfFiq+0wY4h/wu39TwZGPyUvd2
	Tnpg5mRtNIvJn9BnK7M4b/zI50WeFDE9GXI7E/e1vhzCyDNW9ViznpJKygKHOqzj9hJ5IYUHdHw
	Xnr3BZizkYhaXNKtZjLNkJBKZjcyn93z8k0=
X-Received: by 2002:a17:902:f546:b0:2ae:575f:3755 with SMTP id
 d9443c01a7336-2aea30d24bamr257805ad.20.1773079287603; Mon, 09 Mar 2026
 11:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-20-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-20-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:01:15 -0700
X-Gm-Features: AaiRm53zbBx4vwMw2frKtxn1Vd5dHWsmKAdma7wTK-CrU2Ft3XFe72ThDfNa_1s
Message-ID: <CAP-5=fWX54+J0Sbf4XYfcNeEgiKXE8t7T6FRKp1mOb2gm1Dg+w@mail.gmail.com>
Subject: Re: [PATCH v3 20/30] tools: power: acpi: Append extra cflags
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

On Sun, Mar 8, 2026 at 9:49=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/power/acpi/Makefile.config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile=
.config
> index cd7106876a5f39dfda38e286c54c3a7c268b34a2..4978c06828af7b0f47e533735=
ad82c962b7e0765 100644
> --- a/tools/power/acpi/Makefile.config
> +++ b/tools/power/acpi/Makefile.config
> @@ -67,6 +67,7 @@ WARNINGS +=3D $(call cc-supports,-Wdeclaration-after-st=
atement)
>
>  KERNEL_INCLUDE :=3D $(OUTPUT)include
>  ACPICA_INCLUDE :=3D $(srctree)/../../../drivers/acpi/acpica
> +CFLAGS +=3D $(EXTRA_CFLAGS)
>  CFLAGS +=3D -D_LINUX -I$(KERNEL_INCLUDE) -I$(ACPICA_INCLUDE)
>  CFLAGS +=3D $(WARNINGS)

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>  MKDIR =3D mkdir
>
> --
> 2.34.1
>
