Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841333B6F6
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079487; cv=pass; b=jnuFc6rJypY60z+LeE9E+7kl5QyiKs9MH3NjgAH1lnDEuWnOGZwG3Qm0hE9FMn7VSIGvm/IcF3dFlGcoPWIZYNd8iNBbdX8/GR9NYJjbmpcIaNu4113/h+JbCxFJz+d0GZv3T7FBA6TjNtXYq2RgVU3nLjYZXiTb6qUWeFEqiSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079487; c=relaxed/simple;
	bh=npXWJ1Ogp4AocCs7RB8Gmks+wTJjIc4kyHvjbnfQFFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJNlT2CULDxwxNjRGbk5DMQtObJsUN+kfsFOCP5QCITxnqWnWq80nayEXDQgYM8aoFGHhwQ9dV3ojry/5tKvqwxRHcmudz5kAggbxYsoEOYTQhtKSnW/j//+jlPMZEPaAIK9J5/ljjZxVh7K+Ww+br+1r0UPPdFqDkKCBsu94pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CCQexuhY; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CCQexuhY"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae4b40999bso16975ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 11:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079486; cv=none;
        d=google.com; s=arc-20240605;
        b=EC/ldsZeLpCdm0DHxhaKAbOECuWnvqc0f6c989chbKIDSLEw+D/oKYjuUD04scqguc
         Q6CKQ4KOCSDgRU+Nn9JjoLyuWJdHZ9A60UfIYUosG+25qOfRJUh+HVP5nQa2izbrtyE/
         9wMBWcQsbuKBNd3t7b7j4xuw8aoqw1vLWBuFhkDcotV6W5PzlQGug9u2SodTcHzYPQ60
         WRT3nXKdgQ0GqZS53kVLp1aN95bAtat3RajlMOu+3bQYHaPc1B1pnOnc7upJjoqCH4EM
         bvfkKVE6hL8Orhudj/9XqJyvYHVC0+XPSqNTUKM/L10WKjVdao/nKtDyXC3EIXOhcoPN
         T89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DBqxxD+S7Du6uUzPbzqvi9ezyRX+g2oywK0VLlpuaLI=;
        fh=3utuxp5cM3ZP0bG8EzmorPc2+iVh7gU6WDKcwPOZZys=;
        b=XRMLB4INxJAzDbsf6lQR+R8zUF1rt/ZSKcoHpC0pAa9YKyyobAf80zJ3elekw/oq3w
         7/J+fNafX91Ns63Ef8mMJQ8sr8qAVaOSuuL4O1WigJrtkCq4JdwgQWBz1VQ+Mo+m1amm
         WGi8mnn7eQG8FJKbhqAyQiPF8c1MOgcefI4sJe6edkVPlUBQ6V2hTWHEtGu3e3rMkQ5S
         z024OY1n8P0elVE7jTwcgYWgAkHijFwkwKG7CZ1UXQ6bPa5Tpqz9vfRwOJ+q3JCYbMJr
         BpV6LUOBAmj09GaZn1w8Pu907iXTisOmqItvk0roSkHH5YXUrEIUNHW/W2DbPJGnKiMc
         rUQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079486; x=1773684286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBqxxD+S7Du6uUzPbzqvi9ezyRX+g2oywK0VLlpuaLI=;
        b=CCQexuhY4mc0JNj/a+moQm6hEV4Wx3OgS2MBtGCSp414fB7iumYRo3723/Ern8tROb
         N3XwEYgq4zCaoQOm+9JkoZQATuuWNrVXeU2a+i1rdoBCeD4rdav13LVyRmm7fal1kjQ3
         pLw422X7Th5P81JlLXQL3LI7yFatTG7RX4YIGJICZ3J5gJAhvqGb2lO3ht+fYIz2tTS/
         DQIUVmOKoNQNZYHGFxJb1HgwG12jjx2jiCjjRfkHgULgtExj0b4IpClbgAHEM1+lYbrq
         7hYdgVOvDZKCJTqRUlupKGLdIHwJrv5XslxWDtY87pzhFyFDMUFUk2JyS2x39flw9z7T
         actQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079486; x=1773684286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBqxxD+S7Du6uUzPbzqvi9ezyRX+g2oywK0VLlpuaLI=;
        b=cWopSpzoNlKuKTHl3K6WOWHz1lhxkT2tTxGHhiozy6svY2qW2WxnGgtf4WYuM7kcoU
         ZCgOzAJitSbo5ZuFTrHEG9bwU0hdP/UpFum+eNWwrznipmfYc5UacAJCeGHa3MxZlavr
         +BjPPj6nnNy/qZ9jpye0kEhDtH/7EGrsVsLTNSzvMLdDc0jhCgCEdyfM05vTfRPJvCbe
         hdnJDZTd9LNb7ZPFUPEmxAbpzaeWRcvfHsPtNvCIK6q9u2TRpaPqouZXANJxrpuIwUUS
         w8C3G3iLBB/Y7K0wALeR0cqXGQRXxg/nMoEQx2M47i9DZt3gFqHrTpfTnnl6GUMk2Az0
         zbZw==
X-Forwarded-Encrypted: i=1; AJvYcCWfHfxGAMBrVanOq+RbAv6ztj/Le8sp7WzJxaGlbf3gOzoLzaqWB2GZoKCqT7CKb7N24eui6eAoAf2PmLvcMV7F@vger.kernel.org
X-Gm-Message-State: AOJu0YyecHyuJd/mZsQ7vaAX6tsNOXy59VkJAMig1AL6SaohcuKEf71N
	BF83+j4VmHyqqck3PWbINbplAcOFOgUdcnczlyuB5puPztWZihEhEtjkLI6Z54iFS9AhlojrCQ0
	u9hcFUxIuOn8bt41hKC+KnS93PQmNQ7gkCznUBhCL
X-Gm-Gg: ATEYQzyzNiI4+/7Oo94sXNVXcCeFYuyGmiGWXvl4u3wbO+MBxFBLotlbcUINiEMd2Jm
	3/GhMYQS/NejI6U+Pb1+JLvP3EQqqWjwGKDzrNCE9JIE4VKS67dpRPi1MLXGumOHx5hs2mnv27+
	XncmNuEeTdq8OeJObdrsl4s2kOTr/Io3QdVHVYEiCihwg7jhyP5DQ44TYj6NnExuJdA4XjqSQ7n
	dS2VSB+08HDkJxeK/FwlbB/GEw3H4biZ/k6ZzrM+NGKPDUd9W4ScA3g2piQofUtiQqx39dwrheq
	URtF4KLTrLMRsYvXBiTv2UtWyle5xA3C5cA=
X-Received: by 2002:a17:902:ebd2:b0:2ae:45bb:bc4e with SMTP id
 d9443c01a7336-2aea30ebe48mr266065ad.24.1773079485553; Mon, 09 Mar 2026
 11:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-25-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-25-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:04:34 -0700
X-Gm-Features: AaiRm50lc2gBLiSfkJ4Z4DE1wl9NNkgaEba7Sk-TcENnQ4sOXRAHypkvAN4AJdA
Message-ID: <CAP-5=fVxSoN0EoWMG3BXAxrBxyaRaSOcgONcz-TCjn4=CTh0zg@mail.gmail.com>
Subject: Re: [PATCH v3 25/30] tools: usb: Append extra cflags
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

On Sun, Mar 8, 2026 at 9:50=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/usb/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/usb/Makefile b/tools/usb/Makefile
> index c6235667dd46223b646bbab5c82c810221750182..db2ff5b8e5ab7b76e424df32e=
d5a9458daa5d516 100644
> --- a/tools/usb/Makefile
> +++ b/tools/usb/Makefile
> @@ -13,6 +13,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS +=3D -r
>
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -O2 -Wall -Wextra -g -D_GNU_SOURCE -I$(OUTPUT)inclu=
de -I$(srctree)/tools/include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>  override LDFLAGS +=3D -lpthread
>
>
> --
> 2.34.1
>
