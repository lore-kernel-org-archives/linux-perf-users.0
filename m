Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C42E6CA0
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079412; cv=pass; b=QvV4THdC+okg1+1NG8ebNgoRZMBCBB9Smrhk1OV0uroyu0/kVSGzu539hSB7bqQ8NnsAfUOiPn5sdOpM2N4XP2ORdu3M3eZvvtd3Uu9BJYAxojoNCLheUjs4gbEVwPRJxPgrn1VSp42gY+DfmfFYeoKyGhSsU4xA1+che8gbq3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079412; c=relaxed/simple;
	bh=Jmh6F1HA1/DHwO4+8wWz0TgE1rMuRLMuCBybYeE2lhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpEu9VDEngzHWpJJ44K+8kWAw5CZv3MvjttHbbEtBc8KeR3jjoa8mTYaLxgOhike3Tl7imODV4PQDzO9NkKzSznaQ1uh9ydA/ZT6JdEGEUJ5aXvbMtQRfRR3bEG3TW6UUTRKMBQEnIzScr30hiQO6Qgb2GklKnY2YEWqjW9rZew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RUjjNeD2; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RUjjNeD2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae49120e97so18015ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 11:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079411; cv=none;
        d=google.com; s=arc-20240605;
        b=J6le3WfM6On+8y7H95cAQ9GwNEkpSBYuQBzNSpBaUGR4sWOXgaN83rTcC0uJqrVlj+
         2umOrL911Zbf/xY6eJJjdqKtiMlrPiSjmzwtpevVJsDEtZM40ND4uz4wvBiR08un1E0z
         SvDMW73kOIM7jhaRy4l0zfl8/bvhyBQ3bXQO89fKChN1SS2FDB6yyiJFDNpDS4jSsu+3
         fNdH0xtZYd9EHEUrduVoVTdfT03ozrMPkQZBME1GXycrTzwQd5tAFHNJpLtoZLYuH/03
         mN28f+d23Ww1IjINSrGVLGdkhDbiWuw6Rz0eaCpQyLinqvEpWEtHUYwAsJ1r/lj1oICY
         K/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/2Fq8jDmUYvdwrz/G2ys/Pt5cbewWsQscS8yZEetyac=;
        fh=AfRtRGOR5lHxWtA5nsKwIZwCPrYPYatJZGfJS2Y8cDs=;
        b=YxqYA+k0sV51i0XA4DAAkx6rO7Lx9HlxdmkRpJPKP1tRQqocg+NZ47vYxZ+RsKYGDj
         QEXzrXSXNzy+nI59m7R/GNZZn6/zYhaUhLXUgOUDfg7KGqscb3XA8aO8yrDxqp5ASguF
         OX958nOlvN7Am2SgK9q93pQVCJc6Lju47OnOxEnt8PbtdIhbxQxUKCC894k1Lgzzi/kb
         PplVSRapcoy6Xe+9TOLXflP8aSKvtbgdMl8gQG8XfHk1h4io3JlGPUuzIum6Vi+Hf8/z
         X+cRioV6xbkvWq+2vywsgcC0VoAjfiqXRR30EseJpSPnN641TSnHJbKec4qq7pM1LL8m
         npwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079411; x=1773684211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2Fq8jDmUYvdwrz/G2ys/Pt5cbewWsQscS8yZEetyac=;
        b=RUjjNeD2SpN/Wi/gR3CMXFebTmihJt693tZdqo3VxVkdHF/Rb4xG1sEICozrGFwQJR
         5nQE3VTVUX4i7K+i9qBeEgtO03I+LUEYQyhmHXn65F9RSC3luYlr4TI4c9NSdID+a5Cm
         YZUIPrKHvrJ4rkzWdNbDT5++N4CQYwBOpIbbvNHlQ8JRyrdn7eLv7a73BD44xlr2LPYl
         +WNFKaCs243gGIPM2ZweNXs2McugQ06ufUdrFsMnQpYwsypJ/GLW5aKW21l5BFzM1uZR
         WAaetNV0Fa55fEvnMSQ3CE6tf07+fZN8CM7TYlu1Ki8VNjLW7EC3CC7pL4V/gcKpftw2
         dp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079411; x=1773684211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2Fq8jDmUYvdwrz/G2ys/Pt5cbewWsQscS8yZEetyac=;
        b=cQerZJb0q2gSuhmuAXs6D+zPgxdPx2gi3eYk1ld4c1PDwPsTk91PtH34p/mMZqmr7a
         5Zfsxt0/3CgDRh3XGxIwb5M/+x51jlrtvkgwxv8wf9vQOoZZRGPVzJn8K1T+uaiUYPMA
         OOviokgW2o2Lha8EpsUcoPyO6TG+rca/7spWHTHmS7NyG6dmgz99qo8/Qq5bKsTGTdZ3
         BhsN5hJcEvb1wEdbpGcKnjYNKFUSafUrpxHXfsmkUwZLkT/bUovJtVNAuXenCTB80SRn
         a4jGFZaEtn0fOyB8QeyUuWqgDWy76otnTixTXIwv1UuSNh/cCK5JQQt6RGI2pmMgCKQe
         QfCg==
X-Forwarded-Encrypted: i=1; AJvYcCWYP8Rp6SyzpgGyOxkRb7qduTw/5c1SuiGzKKQa8eIhc51b/FRPAdFazXZaJFCuUO7xchYQqhZkvjBHUeEAXEb7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4FAuuprHIg22V2ykOho4GpZd7aH3+JuMpVS9NusYWoh3b3OU
	WU4q6D4Phb/kCel6i1C4P1VU7IWFabWwnPHD0EwQ0EFRgcA7AZ8wBwZRQAhcSJIxOFDwjVuSeyz
	uVkTqK2gzxiR9sW386/P0j64CmDe3jc2ihye84ptS
X-Gm-Gg: ATEYQzyymnISo2pgKdJzRekgXq0h8Sl/C/agT35tAmhHNFsX3rIys7ID8/WUEHh2iC1
	tszIwT8APir39HZwLHCjypoGHvPD1TemLCzCLK2IY/8xVK3DlY2CBPyQfjZwb/HAV4NN3Jn5oGw
	6rL1nXGesisM7E80PPs1R76x27eCtWS1EHjsle58i8Sy9jrClAMVEI2fMDkkmThakSuMl+Q+WvE
	UabngcNrDvFqFga6pq3EVOmdzor3D1qRUROKeXLX+QMlMRL0dLQ5It2uHBueap5DvOa1U56Vbat
	3Go6trg8bx1lylmCCTH/xNjwJxr1/FAR/8M=
X-Received: by 2002:a17:902:f546:b0:2ae:575f:3755 with SMTP id
 d9443c01a7336-2aea30d24bamr264685ad.20.1773079410195; Mon, 09 Mar 2026
 11:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-23-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-23-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:03:18 -0700
X-Gm-Features: AaiRm51m4nYl0m8tFtQlOB_PU4q1W2JI6UKS4mgMHQi7Hrouc_6G7mzkDrAVHLM
Message-ID: <CAP-5=fWzFtZbXK4DrUOCFBtD9e2_e3BG3Em8O84C=Zhfjyf5nA@mail.gmail.com>
Subject: Re: [PATCH v3 23/30] tools: spi: Append extra cflags
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
>  tools/spi/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/spi/Makefile b/tools/spi/Makefile
> index 7fccd245a53515ab019529c8e5e91a044eaaa68b..1e3b3f91634cc2561c434c02f=
812942fa881685f 100644
> --- a/tools/spi/Makefile
> +++ b/tools/spi/Makefile
> @@ -12,6 +12,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS +=3D -r
>
> +CFLAGS +=3D $(EXTRA_CFLAGS)
>  CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>  ALL_TARGETS :=3D spidev_test spidev_fdx
>
> --
> 2.34.1
>
