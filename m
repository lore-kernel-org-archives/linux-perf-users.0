Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C5E311967
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078810; cv=pass; b=FIigoUc6ZW1qGeM3E8ua85RUoJg2uwGzdZMwGqtciASWK2Ga3tkskOs/AT8I7LW5k6YzAqSoxrdC4+HiQ6uyXN1cEd5nEOmLEYKC7HopU3Db3QllQCvI7osxn7YtlHcGdtGwBRjT4eMBvHzQuR1Xd45uJKt/NETS4Q2zmiwPmkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078810; c=relaxed/simple;
	bh=SeWt//XSlE7FH97wAOv/MRdhXb4yjQFM3ji/K8xaQqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGY9yc9nqD/gR8lNqoY+aZq5z8xxSydjR7m/qyBlZ7CND7MflVNrMemcD1ebO9v52T5+JTAIcGlrYIagWXPMqmSb35MI3tvanah31G0cLjvw89x+A1CiP19oe6CpQp2m6QgxFm50T2oNmTSWf89OzUMeEST+klT/TRfMtPPfosk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y/fO9i+E; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/fO9i+E"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae49120e97so15845ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773078805; cv=none;
        d=google.com; s=arc-20240605;
        b=e0THRltSAcgniHBRXM7gf8magsmBDG/vAyg7W99uEhugC4Fn/LPgyorHyLRfl4xNSk
         dk54k8fMy4gsZS5NOPuHX89pg37ZN5DCm8Ab+UEE+6NN3s0vOLRdzqQc9balcrjwadCL
         qnsBxwTJcXIbhNwalSy2YIxDAIZ5iYyj/5pu7QRXsOCCDY1JTCkI3cXBdJJ18BJAI7gF
         pg3dAGYZGfeoiYHX90R2PtJppkdV/hLIVVHsGHJ3MckCmZPcN/D/cSBgU23lf7DvmmIO
         Wf12Nby/CpqRe90r9vP1CcjiMtR8QbwlfXd4VjHsHV65Qyh5j/rdhJRilA8aHkZKFzMH
         gq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZPvt17sBw48Uy9b6qgDNm1YzVe8WydV5Zk9wwY2Hrr0=;
        fh=I6n6u5S9d6AIHnT3xcmOFTLM6Zh25tQo5N8mrbINeeA=;
        b=hP36K5z1iF+nWSSpSfTeJFK4j64elaay67D5D2OcjPOsSae4N8cbvhzqZfWEBwPkT4
         nB9beZLZVUIlrNiHhwZYHzeO6taEHFEUL9q4MNUZ9jdY0BoHANhYEOL3f6aUupCLDGpx
         E8wjXAGzts4AkTtuytZbJdC4OVxCl1hUwDflkcBJXWdEB9qmfs/7JMfgM9QSp+M8odKn
         4fPQ09Y/sSSSrhIeZdnjxhBbfBuSCKTu6u11D0KUGg8brAGiGqZxdcemehukRLEY/pmt
         +d+WuA5iMALG+TzqgNS73SZQEfMVcz9RPVgvmJs08silBEzDzX34ANnuEEiQQbi6yqAG
         qPkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773078805; x=1773683605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPvt17sBw48Uy9b6qgDNm1YzVe8WydV5Zk9wwY2Hrr0=;
        b=Y/fO9i+EVobtRUdlgy12NnwkYs07I3cNqZngk7kvG97Pl1b7nN1wezhs1qvbQqE7sT
         L0bxgyrgsfbRgROFZZzZfUTWwEA68BsPXAA5lspoOfhNiNNzBhRGh/0cUPEfqZj5TNIn
         GZWsReZH4o9W6qFuZUD4Z+t5Rd4bSR1sG++UKRqdRZ+L/VQKwpbeHnw8ih9q4SNcr76Q
         3SPDBFWELMERQMNsXSAlWsv04sLE1C9tWGdz1bcbphex84NmSaYEn68W78p1kC8SPz6/
         G/QJ/FnCdfk9ePA17+IHT78XC3iC56as2tLtNMDT/r6qSpWNpf/d+w1+a0MdIIzvP8/6
         6LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078805; x=1773683605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZPvt17sBw48Uy9b6qgDNm1YzVe8WydV5Zk9wwY2Hrr0=;
        b=mFSVO6GtBLLpymIAoaIHCRxFk/+Bt1HQN+CBrHTGxfxmFFjrE3LhIlq9g7PNviYkyJ
         4oSAciLvbjJcp3LZj/c5vUZUK6uYMqEtZKqVRxWaJOp/00g77jzgowvPbpHcoWJLI9sr
         OMBrfzYJUjmQrEJOyPCyq6PqJpcrrKJ6cOuA3f9SXJ6ffz2BRg/xUjJJvuJ5AD8/+cZG
         3LObQtRE0uEn/w8amZI29O5eXwjmwzldRM6snoDNlXKz81axKCk9EBEM8rKwCf03VaSP
         sC4RgY18IPqB0vYYVFjeovpihuvkxlbV2czUHzKLwmvfm/FXY/WB2/OfWeFmgNVp0/JQ
         brxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyQpTTZxqt+nSaB40ZYEVZGHsY6S3WZum2U+wi2r00n2fsAeot24BD6LI7PXV2knRkkpfn5jZyLJrcwV1Qt/CB@vger.kernel.org
X-Gm-Message-State: AOJu0YwtybVhVDJLIUCaNe6X5+kJqkQimqfbQ9QRXv+kMZL0OCdBKQQu
	Y8qNKvjAhUsn827baNfkZwozniu7by5gHnm+UDoEAqcpPJSJaD8VdPeSpNE7iCOfhP69axghJww
	MrWvIis/s8Q1C7AuguzDCGfmKgbEbtZz70ABhRPRj
X-Gm-Gg: ATEYQzxEeG253OR0JIG1MRI++ASo5xK8Rng2nOXNhMJ67U5VETXlRZ4VuTNANPyxWHT
	jM0PKmAEQnVCklz7WSzJ4upTBMIr5WjaH3xLLQsU9itKwC9uqQj3sc3tV1zskf8oTizBlPL4ouy
	sAr549nQEzgaxRdLzizpvA3GxnFx+hkcScZO50wr/ZPeYiFgli6OPCS/VETegpf2D0wjJERsKRR
	bK0raRYnEHl1RNhDFXT981/OWguUga9DrtpcdoRDIFjn6d8o8lJRA3aLdou1IpKwm4U7JqjIGpH
	JeF0PVNFnZVZLFMcEZLJb3SF5In+edytFw8=
X-Received: by 2002:a17:903:37cc:b0:2ae:46c6:e4e1 with SMTP id
 d9443c01a7336-2aea30cfc85mr220315ad.18.1773078804518; Mon, 09 Mar 2026
 10:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-11-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-11-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:53:12 -0700
X-Gm-Features: AaiRm51jJv0K2rf94QzPgrcYebl4loRMt-0YaQXZssGW2-L2HjxaFLVTS-jTCdg
Message-ID: <CAP-5=fWHe0JaJ0FPm7jKfL4YMb8y+o0YcnOfSs=DCgHyNsyYyw@mail.gmail.com>
Subject: Re: [PATCH v3 11/30] tools: bootconfig: Append extra cflags
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
>  tools/bootconfig/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
> index 90eb47c9d8de67b0ccc74a8de0af3a7e0b97feeb..6bbf4dfdb5b56fcb2a43ccda1=
8b59a270778267b 100644
> --- a/tools/bootconfig/Makefile
> +++ b/tools/bootconfig/Makefile
> @@ -10,6 +10,7 @@ srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
>  endif
>
>  LIBSRC =3D $(srctree)/lib/bootconfig.c $(srctree)/include/linux/bootconf=
ig.h
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -Wall -g -I$(CURDIR)/include

Should the EXTRA_CFLAGS be appended last so that the user can override
the default CFLAGS (e.g. switching off warnings) ?

Thanks,
Ian

>  ALL_TARGETS :=3D bootconfig
>
> --
> 2.34.1
>
