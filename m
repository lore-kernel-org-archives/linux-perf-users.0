Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575C82F49F6
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078046; cv=pass; b=dRG6h+ROR/Dg0egUshb6WJ2+/SYthg7MZfwSctAGPdLS2jooFw/exG2UkPIX0A8bKl/JDyg8QlXwYke3F+ygjcsZ6X1Z9oMYbTIGkUA6+vqRwUivjJhDsMDgwKE40M3ba8g0b6h2LY6SYf2kjlCg+bO7X9Tp5ZAuWGSSE9zB6KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078046; c=relaxed/simple;
	bh=n75q7FQkEfbF8c0uFYyEvlysohLp/IeXvVTwRBBtQUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zo37DraMaQdCAqP1i5tXXvRdhuBP/R9UmxAlnLsl5Xva6zsmfLG89HkWveyrMQTedkRvpyLbGrtmvNzVQw9UIRlFsYfz17Pm21KItO5ja98omKq+TD3M90i/U3q3n0R4rwMMRLCb5p/NRKgklaUhe93oa1I1dx5CAxxkpYRBHRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEACXYe+; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEACXYe+"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae49120e97so13295ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773078045; cv=none;
        d=google.com; s=arc-20240605;
        b=B4O9jc13WSqrRp8JanD50VvZfeS4CpaqHbvNzMRf2C59+3xeR4zJDHe3izaz02QHuE
         96L/MyZFMujgpudrbtenSLZJkfOWEPy4gTG5DALHyQJV+1YNk76oFnkvVTVyKJOnb3MI
         mTT6o/j12RE7gG/vZD+nkLtKjEkA+PjF247aPyiDt1Hzia1Gh2pMuMUeG0EulpvKtWa6
         P0Apmd+qq/T4dLL1rogn8Pfe8EtsuvHk1PIcqvBcTZaBfPG9FRjyin7OgHdm62oSeoie
         JROp4W2zr10IixiBvVO5xK65uUbDA/RvII+pxVK11TGHprtODxg7m5w+Xsq3CxLBGBXC
         2fYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=43itZXu9qIpHkrE/yaiQXvWJBibTFZU4J0qcAKp3nP4=;
        fh=9dojzq6e7lPTELptaGi8CRGNfI4G2aWhysU3cNnONVw=;
        b=D2Xab1hPg1a8o2a9l3x9r24KriM7VeW7FUGo3YYPrrzqqAFKTOkUHQFIlZuzA8Ta4o
         zJGVLAEPYEhFOllm6hjXexCoK9o1i//DsshCEYBNaplREKH1aNDryz8tlHi4p/2mFdgR
         vB84xXR+Tzura0OEDRIvm9WBs3kNsj1cs2XTiVKrdnRNofkMe2Vwbaszx4L4ZgQ6QN90
         m/2qQo34SKGi6usRyIFpFu8WpUYWcWbn2ooLCJ+aPcBB7eJwW1mtvRebummXk1/etV9J
         0Fy/7mfzTbqdBUm9tibCPbQctwFGn1NTal7DfDWl1gvBHoL7G0jlBZSJqP+t7kahAHuQ
         iLPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773078045; x=1773682845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43itZXu9qIpHkrE/yaiQXvWJBibTFZU4J0qcAKp3nP4=;
        b=WEACXYe+eMpVtuFwRLhSOaPUXruLfrYT+MLPY6DbfOUhoBpt//781IKfJPlmnYRaSZ
         3GbOzqzuFCsKlea16k8R47DpwV+dvIo1vZVbAJ6NYT+O+vtS/ujQ7t/qNSdXgr0iEoJI
         PLU/2NsC1pV0WOKgXlK/wa3qkUj7SFdea5+y6eExFW/6ZdY5VcZM+7KJvV6JNlRl1UJg
         xi78y9fRjOhsbqCNnHnqcIKTKW2IXjFgT+D8d43J095FA5v35zG2AEjn2vAFGGxHPjNB
         bDHr7levlCEUEwSejp79x+FxPYwU9Bkd7sKw0QE+F7h/K6ZLuaEYWzmA9ywQxqn44E2g
         jeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078045; x=1773682845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=43itZXu9qIpHkrE/yaiQXvWJBibTFZU4J0qcAKp3nP4=;
        b=JvahJEyuLjP91iOli7aY+kN8UIc9tA2qzk5nY8+GEW87LMqJQxzuugFjdAlEc79Eo5
         QJId3j36CfLCZmlOs78Oimglojf80eG08UGnqqfk/mOuM/OSsiG+ml6+HEpvvRNgMbJY
         W2M49VgD5yE9sFUSDZQBase9zkx74w5Q+oclqZAL71UQ1fZkKzJVs/BbxNdnNhqmuATv
         21couoWzY4pksmJKUZBaF3E8JdtZ0WXPVlNdrR72X3+1OHHQMudvGOnKFwEVKLJvktqG
         guDm8t8wnkOsZ1FScnROnnNjn8GLR+PoT90R0L9pn0nzSM70M5jEmxdd7n3RjaVLAnEM
         Q70Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoAsWzAizpXwk4IHrawuaZcwNCTSHOrOH5S+jf+UbkX/4rgTNgFDbBtRC4UR45dXCpcSv1SW0MEAGhnrovqi8m@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUfFIMa9ocIqQjByHDPdBxUmNnZBmX9m8GGxmfEc3BhpF6kem
	3ZYijeGf+q8uXENGsH5RLOfvXGqrnSJmGPopVz1YphqFQtRvS83e2D/4hbkexxlaKzuVUjjyqGl
	drDiXeoeGH6o5TntUJ0aN/qQyOJ15Jwp+jbcn+18B
X-Gm-Gg: ATEYQzwESLuUvFW++uPPungOfS9XRE0BD1h6Yys4G0yioNna954hiu2uReXeMsH1Nvm
	nApJQGVtp5kwdKZiVnaP4nfEXW3K6nDy+Z+zWpng12b4HsxdH9TiKaAFsdqr1E1/pPZYkTev2QU
	Sgh0DgYvmNcZ76NG00U1OyScOXD5KA+scBPUMxUgxuJZ7Gx5K1Vun7X10qVnzn88MlPcM8DF/Oh
	FDoBYuLPzSYwT6ZYEhR1ojLf10OUHxy9o9x87ohnqkl1z9QbYgKrw7L8lNln+hajprdyzfujphB
	PDBlEsifC/NlkCsYxyyT70OTUFuqfJiFTDQ=
X-Received: by 2002:a17:902:e5c8:b0:2ae:5a44:ea91 with SMTP id
 d9443c01a7336-2aea30d03bfmr173965ad.22.1773078044165; Mon, 09 Mar 2026
 10:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-1-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-1-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:40:33 -0700
X-Gm-Features: AaiRm50xMh2x6blfn_3hS50syuGxpKu5Drg312ff5ApM7P2oqhep_6Y9V5rZ_XU
Message-ID: <CAP-5=fUaowg5c5GRVrTATCbkFrRa8WUyp3_h3O_6t2Vy4rBsmQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/30] bpftool: Avoid adding EXTRA_CFLAGS to HOST_CFLAGS
To: Leo Yan <leo.yan@arm.com>, Quentin Monnet <qmo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
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
> Prepare for future changes where EXTRA_CFLAGS may include flags not
> applicable to the host compiler.
>
> Move the HOST_CFLAGS assignment before appending EXTRA_CFLAGS to
> CFLAGS so that HOST_CFLAGS does not inherit flags from EXTRA_CFLAGS.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/bpf/bpftool/Makefile | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 519ea5cb8ab1c0ee31acc67fc5f96b40e21005c2..3e7d8359e1b2a81a29a47544b=
e8539e3b191a0e8 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -81,6 +81,12 @@ CFLAGS +=3D -DPACKAGE=3D'"bpftool"' -D__EXPORTED_HEADE=
RS__ \
>  ifneq ($(BPFTOOL_VERSION),)
>  CFLAGS +=3D -DBPFTOOL_VERSION=3D'"$(BPFTOOL_VERSION)"'
>  endif
> +
> +# This must be done before appending EXTRA_CFLAGS to CFLAGS to avoid
> +# including flags that are not applicable to the host compiler.
> +HOST_CFLAGS :=3D $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUD=
E),\
> +               $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
> +
>  ifneq ($(EXTRA_CFLAGS),)
>  CFLAGS +=3D $(EXTRA_CFLAGS)
>  endif
> @@ -88,8 +94,6 @@ ifneq ($(EXTRA_LDFLAGS),)
>  LDFLAGS +=3D $(EXTRA_LDFLAGS)
>  endif
>
> -HOST_CFLAGS :=3D $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUD=
E),\
> -               $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
>  HOST_LDFLAGS :=3D $(LDFLAGS)

This isn't an issue with the patch but AI code review is noting that
"LDFLAGS +=3D $(EXTRA_LDFLAGS)" happens above, and then here,
"HOST_LDFLAGS :=3D $(LDFLAGS)". This means something like
EXTRA_LDFLAGS=3D"--sysroot=3D/my/target" in the build would cause the host
ld to pick up the --sysroot flag and probably break host builds which
likely use the host `bpftool` when cross-compiling (perf's build
should use the host `bpftool`). If the HOST_LDFLAGS were set to
LDFLAGS before EXTRA_LDFLAGS are appended, this would not be an issue.

Thanks,
Ian

>  INSTALL ?=3D install
>
> --
> 2.34.1
>
