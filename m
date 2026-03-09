Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA233E9F82
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076648; cv=pass; b=ctdBhbNk1O7qNVIdUqEsQFytqbtOY3Nrpno30omFbkDQfsYY+63ejHmEoRnarMWm1zyutdDygFoXKYKf95K2mEVtJqdbhOZXSxDYGlhhr3xCdXjCHPLUzXlAXbt47LzjiIqfUBN/j1rHDXa0CnBGOfePcZXl3wAnuxbbSkiBvrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076648; c=relaxed/simple;
	bh=KlVS4uimnGg2P9OAHjWKxIKUvpjpakW2vhNGGc1Iif4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzsdwCduLNVxkhX8s056c1WTXOIxkSu49a9bRslz7Sf2UYTR2rXHXhBdDGxc21ho8PkjWjYSN5TjQg/wfKrSC04sz2Bwewniw/KXAZGJM8lR3m2TCzK5BT+n+g7g6QvVp6LQpSelv3Y2aHqfiX0KxAtDQyNXO2IEMWgG20KCZ5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DtyLz6Xk; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DtyLz6Xk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae49120e97so10325ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773076647; cv=none;
        d=google.com; s=arc-20240605;
        b=lKvZoOBasMABaPv1lOtqwH0am0hh1t7Zv1kawFhSS29utFzsM9uQNsIBfenvH8xKff
         IcqAUCggILL16jZlhKqs5WQviRVFb6YPAZMPpb6q26GHQXGTSniyjDM12iQLXA38lY7O
         XWm+ZHWjWrHb4r9t5ffERai1MCk+lvFq5BquwFVkAePO2rNQEZuCkmTZKX6ribH1LGNg
         DLikE9cflrYuPRq6uFaYXrJ+cBiKsjzvLi/KKCksiN5pou3AcMiXTpHbvSWZytB7cEZj
         fot1DDskCVLRHJoLpLVjKz3px8TTiHas8uk7Iq8hrkMcF5Ay8yPkR54zX+qOFCO6EYjq
         Zofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w45p66NfPrqrjiogvGBWv0oHv9O2Jx2o1hhM+o6/k7c=;
        fh=VrnieCdUq+v0XyySfUghIi6cow6QrTQOAHcrloLhF4k=;
        b=BdFmLCIz12YofGwYLmV+7mtt5pSoG42+wimW9diaSoxLghXphuDpy4fXNyuAZaPVQ/
         o7VltLgku9JqS7AF6tNQdIJxjj3NVKZEojf7woXzd1QjUjhaoWdRGvDSSAFnBR5VUAog
         3HYr4kOuChbNcHcLQPANZWtI5TBeJJHoPn3c7/IkhSG1sRBkVany1m+3PRUdTJJU3BsQ
         RS34ITdmha1ZoN3DFwB0yiYLZ0xZv324Eb/SeaJ2DjCY7vGBp4dJqT+h4wFPx8o4PPsG
         B3A6ajyWFj/w0pORbdZbHBfnxbBr0YC9kvdUZMBZLxm6b0jGYhGPqmmGh+XZ0Y2/JIPl
         JeSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773076647; x=1773681447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w45p66NfPrqrjiogvGBWv0oHv9O2Jx2o1hhM+o6/k7c=;
        b=DtyLz6XkzIZX72KCcwdnzd0cgJZN8c3WRVxl7zo8S+uvNHsUyYLY80oZHy9ZMdhMOm
         dWwieRIJKSYesLiAN8AUZmKeXJvVsUBmx1EZRRQwHr5P8d+dSfsQbOCPiSIcEHe4prAS
         9H1aWRTCUgumLGy5hhUKgzVwptje4ptmK6y+ECi8Mz9l37WHLOjZs2Us/j58tJKzl+hf
         xzwysuIEcUjtYnqlv2pvRWjA3kDlnWgZsg6RZUMdhZyZ7UNhpjLo8x3sJapuwtZNx6X6
         q2D52zpfTLE+iCcL1vXlIyyp2WAJU+eJzXNkTB+jV4t6ICYoeIBTEkEvD2Edvi5gnVdF
         avMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773076647; x=1773681447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w45p66NfPrqrjiogvGBWv0oHv9O2Jx2o1hhM+o6/k7c=;
        b=Kdev3uYhStuKKmj5TeHWhsUh+WssE2YL1Tm5iKAx5yIbz8PSY9YeJl9boP2yMTqwcg
         vrnWbwz7a0G4Y2iyL3N81wVU2YawFiaqeN5sHoR1xZ6JK+KqJSGpokTOowLPHtCgyUcN
         HDAQYBUdeDZpmt4kYi7gHjFd3I04LWdIKjnF6IQ/O9QXjdRvIbldu8NQ50mM7Gd5jdJ+
         9173lBk23pr70ZserG0sFy2AqfT6mpDMhg+Bt66xkSaq+NIrjNXyp+CB6a1WANA0DoxQ
         tX59AuEvHu2GpA4iYrhaTPL86NTjii2z4e9G9zXQ6sluwwHYNVdx+yBolFBFnTCAunbF
         izDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC61HO0ejz0tBUkBANyNw5EvuBNV7XyDP+Nwts3uoconP8CVn5w6WuuAsdSTlTwbZNNjc46I4U6cXlnaa/2WmT@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPNzPmsP8MAun4+Fl282nfT8B1yTPGLrWxXFGEkxgWg8hIvhg
	pYU7K4e2AhX+tBPxpjT3oGzjPX2jhUWL9bynRnAXU17s05IjhlvwhRC7bQXF7wIcWaXpLDr66yR
	TtvzmRYT+ErDpaCXz0RK8iUnBgIJPoOS+vHt35Af+
X-Gm-Gg: ATEYQzyWM9KHFMfWyZTvADbGfm+6H/8KGcXzLLTyooaeRybG9oRaTe3NY+tacss2+OZ
	d5Bafm59LI55mDN2Lt1sRTyebYwSR4C5tJgVY61yRvAdvfaB/hnQWYmGRXMw6aVOhhRODvTusVG
	P+YiSA+1gCv5E2ew2jYsS0z8xgEydGdHw0bsPYE8eEhzWXakWJQQLzBksTYaiVNj7BSyaW7/NYt
	PP0MSnf0dqXh0bUtl3IuDTGJ10e6/w4A9QQFQo+3Z623zf/GBGXLnxNWlkwHavMG2QX912UNNf2
	Ss2QSiaM8L+xapRHvZgpVIzO7/2urE7nZy9h/f7fOJ5rjw==
X-Received: by 2002:a17:903:2345:b0:2ae:4e8e:954e with SMTP id
 d9443c01a7336-2aea3247986mr23025ad.5.1773076645917; Mon, 09 Mar 2026 10:17:25
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-5-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-5-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:17:13 -0700
X-Gm-Features: AaiRm50U-PXwLYjmiDwgX5D5-bqDn4azdaS0klGDRU3-QqWA5WlM1eBYcGFDKIM
Message-ID: <CAP-5=fV5jFCyyywddBmijiedcVLKz+LReU=NPkUOcanjJ5oAsg@mail.gmail.com>
Subject: Re: [PATCH v3 05/30] tools build: Append -fzero-init-padding-bits=all
 to extra cflags
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

On Sun, Mar 8, 2026 at 9:47=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> GCC-15 release claims [1]:
>
>   {0} initializer in C or C++ for unions no longer guarantees clearing
>   of the whole union (except for static storage duration initialization),
>   it just initializes the first union member to zero. If initialization
>   of the whole union including padding bits is desirable, use {} (valid
>   in C23 or C++) or use -fzero-init-padding-bits=3Dunions option to
>   restore old GCC behavior.
>
> As a result, this new behaviour might cause unexpected data when we
> initialize a union with using the '{ 0 }' initializer.
>
> Since commit dce4aab8441d ("kbuild: Use -fzero-init-padding-bits=3Dall"),
> the kernel has enabled -fzero-init-padding-bits=3Dall to zero padding bit=
s
> in unions and structures.  This commit applies the same option for tools
> building.
>
> The option is not supported by any version older than GCC 15, nor is it
> supported by LLVM.  This patch adds the cc-option and host-cc-option
> functions to dynamically detect compiler option and append it to the
> EXTRA_CFLAGS and HOST_EXTRACFLAGS respectively.
>
> [1] https://gcc.gnu.org/gcc-15/changes.html
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/scripts/Makefile.include | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
> index b5ecf137febcae59f506e107a7f2e2ad72f4bef4..bab3174565f0d1e40ec574a36=
0a0fddcee641f7e 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -137,6 +137,34 @@ else
>  EXTRA_WARNINGS +=3D -Wshadow
>  endif
>
> +# output directory for tests below
> +TMPOUT =3D .tmp_$$$$
> +
> +# try-run
> +# Usage: option =3D $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwi=
se)
> +# Exit code chooses option. "$$TMP" serves as a temporary file and is
> +# automatically cleaned up.
> +try-run =3D $(shell set -e;              \
> +       TMP=3D$(TMPOUT)/tmp;              \
> +       trap "rm -rf $(TMPOUT)" EXIT;   \
> +       mkdir -p $(TMPOUT);             \
> +       if ($(1)) >/dev/null 2>&1;      \
> +       then echo "$(2)";               \
> +       else echo "$(3)";               \
> +       fi)
> +
> +# cc-option
> +# Usage: CFLAGS +=3D $(call cc-option,-march=3Dwinchip-c6,-march=3Di586)
> +cc-option =3D $(call try-run, \
> +       $(CC) -Werror $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
> +
> +host-cc-option =3D $(call try-run, \
> +       $(HOSTCC) -Werror $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
> +
> +# Explicitly clear padding bits with the initializer '{ 0 }'
> +override EXTRA_CFLAGS +=3D $(call cc-option,-fzero-init-padding-bits=3Da=
ll)
> +override HOST_EXTRACFLAGS +=3D $(call host-cc-option,-fzero-init-padding=
-bits=3Dall)

Could this slow down builds, as each reference to EXTRA_CFLAGS and
HOST_EXTRACFLAGS will invoke cc-option, which shells out and runs cc?
Perhaps you could evaluate the values once then reference them
something like:
```makefile
FLAG_ZERO_INIT :=3D $(call cc-option,-fzero-init-padding-bits=3Dall)
override EXTRA_CFLAGS +=3D $(FLAG_ZERO_INIT)
HOST_FLAG_ZERO_INIT :=3D $(call host-cc-option,-fzero-init-padding-bits=3Da=
ll)
override HOST_EXTRACFLAGS +=3D $(HOST_FLAG_ZERO_INIT)
```

Thanks,
Ian

> +
>  ifneq ($(findstring $(MAKEFLAGS), w),w)
>  PRINT_DIR =3D --no-print-directory
>  else
>
> --
> 2.34.1
>
