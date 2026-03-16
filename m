Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC81F0E2E
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670643; cv=pass; b=STjtgZJJWivL4Lvsdl8zXOMtR8by5bj8Raq/a5mot0Ax+tSpMa+GhOmUz4vI6F1FpPrA/Me7Kzre7TVnxIdPhz17wy//eI18EG/l/2DttBhZNbQLyUlHQ75zmoG6sKgJKqZBbFV+/6o3gFjFsUGo55Y1jRnoyWJ7T+sPEk5FhjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670643; c=relaxed/simple;
	bh=5ExJGKQqqkgOKiYAl01vajNqrVmhutAhhk5RAfQPwdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKH/x/qimF3Qo/lLg4WSGi6R+YrvkfopI1r60aCUvhyGBoCbDLqERRcCA5XNWnf8e+23D9wpfSyPjui1y8UGjFqQloivTWBaDE3cL6X8IZPti3vetT/W9c8+9s5kd7ykWCspF3Y8aaE89nNvd/uASruB+dJZ8/tPJnZ+qaEukeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUc/i+b4; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUc/i+b4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-482f454be5bso52945895e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 07:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773670640; cv=none;
        d=google.com; s=arc-20240605;
        b=EfaYzK96htEdEz8/sdR/zkaJVoTKCOQY3kpLJZTxs4/bRMYa4+0kvGJjvDS+xC+5Ae
         yi5mLVnTtkd5F+ZrCIZ7FIt/zWlIVWkZC2sJFUFvSoJ0HIa5lMYYFd6DOdJvDBGdO1tI
         9JwmJ1wt8sVMzT1o7g/MhoRZoXhdKPZSKlyjv+gY84lEdNIHuUr40sWi+lhKq3fyBpgo
         jiEwNjaW1y1I72NpZ4z1k4yJjmuALyrqTCLY+G+oywis3n02JLk/qcIfk991XAs4JBiD
         34VkeE+f5KWWQf7ocZDV7S/B7lgPAzXjJzBSXo2KrdPZtazJ0tS63vEzXIwm8OPwq/hS
         Wt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lmBn1aXsKzUNTVIGoWkY2AXVOYef5Jy5uJj2KWu6G54=;
        fh=T+B0DDaR9QfhvlMnufsFqehgocM5GaNNqcazmUGoBOk=;
        b=LJyOP3U7rd+Jnh2kwowfmGjUC3fXvgHerbrp3USs99sxpvMcIu7P30MHSKkfdvmzLl
         RpWwvJw7F0kSGNVh62wigiztRG5/8X9u+KT8xorAcwjB8fpr2gjo6kj9AbLmh3ge9Eip
         OkvfAG8ODVbyOqjKjhdiCENSxvCmWVlOtFiYGSwYiqI1eM8UOtIaJNzEw9+GGIn2yC9B
         ZulXBzbwLxh61lWSQ+yETVTqwRPPnZD0BA7BdD3+GZ/PI0XEsF82CohXCvJBwN4H6D4V
         9k5PuFAnVtOl5e5qaNBGX1ka//t02xQYswNV4CcQtoiBe0QG5HeMnY9YlwR56nLVt6P6
         yN+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773670640; x=1774275440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmBn1aXsKzUNTVIGoWkY2AXVOYef5Jy5uJj2KWu6G54=;
        b=MUc/i+b4a82D4pWwB1wRLJI9NT/+CBuN+DxuLbm8D2Nob5nPTApzb3pf61dWc29JAW
         clnvek8WcoUN7z2tvHsy6Wwb/dlApRwjGbn8b+FsXL+PUqpJ176ibsodV+7pDysEShQF
         WBLTfNfZ93H3Lhzexb2Q58oC7eBKJ4JvYAvtgRbifdqwDPzcXddYBZ/0yQJELwGMVCTS
         ZVBnmOER8xL3lMlqkWBypwyFbeaZXqjX27qoOxIWs8YluIc9f1yByJ+izVCIcItO9tCD
         FBuKeqv83UWA5Qd9Bl1bpodbdZh2MSuQ38vqIqFJR0H0Mvuj0OgA+tV/wcuFUhQvn8+Q
         2Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773670640; x=1774275440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lmBn1aXsKzUNTVIGoWkY2AXVOYef5Jy5uJj2KWu6G54=;
        b=UzdpfSjOAd5Db2P3WixBroka4UZVEFivw2tXZ3xows8BdSiYNxGvivgJI40PKsnE9C
         /q0z1JF3y06dwsaY8rW73gOLZqx6bTeKd03IVsGIGKXTO6dAdX6GitEUkAuSwTZ+75oi
         snZ9n/TUFlkoQHOKzV4U1S15V1uXv769qBvsevFCwzDSTpyREX/uoEMONLOJ9YUm8wRp
         AJEjE/Tz0GJBoWKmQ95CcBrl5U2SsrX8S6MPoqCvANJAVqDRa9nSoJAwHWHqlSb0jz1O
         vaWqQQpqdPGW/nUV4tGx1wYn3sI8mcxPwfy2ewvg8NH0FsNBIdGlfdmuzuaU8RfYr7AT
         kMpA==
X-Forwarded-Encrypted: i=1; AJvYcCVL7yL6BYziIDyqh/T1mb9LttsmajMIcpEh5O3zIP5yA+4lgifX4Jj6lxWfX341jn8Ldh5tawqwabajvHLnBV9Z@vger.kernel.org
X-Gm-Message-State: AOJu0YzMv2UomBb6UlP/6Up4W8qnuNvd9JqYZyROkx+JVCpFgdNzoJL6
	yI7hzV4CLrzzW+3ct0x7mz0xxYstGXdk9HY1TLUHV9SWkZEa7wVW/vSwpOj0j/7FQccDisxyJBI
	B57qw1aBXt296DN+H/c+q6pPKEBvAMyw=
X-Gm-Gg: ATEYQzyxRzjDbHL2iGPOzwECD2erUbVbM7kOvwYhDxtMkEg/EQbNfdx9Hbob1alyTqp
	UNpd3TSSnC+/gPsHVrEjzLCea5J4EZT0yKW02wX+lArha+B99vdronQQmID84T3BtDobrgZCFud
	+HDZUiaWT4V4p2+f5SscloIpAcsrqLUONieS7qIuPkNQaLcjtQM73WbcXUHDZFM6sEmmt0h1q2/
	sDoI1YDMlu2Mb+YS2m9TLtzYEoySp6AFD82E4AsxIVQ3DDEM0hvTfAfla6VwI6//EYS+GWaWOsM
	QByFLvGWt2tyTokm9jDmJANrbXu4YXGDVZCdNVOAkB52mAK5B/Yhe7V5wUJMcwknOY42Qpc4VE6
	duw==
X-Received: by 2002:a05:6000:3109:b0:439:c560:bb78 with SMTP id
 ffacd0b85a97d-439fe1a069dmr30731666f8f.22.1773670639789; Mon, 16 Mar 2026
 07:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
 <20260311-tools_build_fix_zero_init-v4-7-9e35bdb99cb3@arm.com> <20260316101800.GB8048@e132581.arm.com>
In-Reply-To: <20260316101800.GB8048@e132581.arm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 16 Mar 2026 07:17:08 -0700
X-Gm-Features: AaiRm52U4nGYmhrhg5_rJVsmWgv2fI-zySEYrY3v3DyOI4rw9kmBbiG37OT5JGw
Message-ID: <CAADnVQLN6bYHnusnC5QnDoGGUO-A=qnM6fP9bhEVXEHD6_y9EQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/30] libbpf: Initialize CFLAGS before including Makefile.include
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kees Cook <kees@kernel.org>, Quentin Monnet <qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, bpf <bpf@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 3:18=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi BPF maintainers,
>
> On Wed, Mar 11, 2026 at 08:29:32AM +0000, Leo Yan wrote:
> > tools/scripts/Makefile.include may expand EXTRA_CFLAGS in a future
> > change.  This could alter the initialization of CFLAGS, as the default
> > options "-g -O2" would never be set once EXTRA_CFLAGS is expanded.
> >
> > Prepare for this by moving the CFLAGS initialization before including
> > tools/scripts/Makefile.include, so it is not affected by the extended
> > EXTRA_CFLAGS.
> >
> > Append EXTRA_CFLAGS to CFLAGS only after including Makefile.include and
> > place it last so that the extra flags propagate properly and can
> > override the default options.
> >
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
>
> Before sending a new version, I'd check if you have a chance to review
> the libbpf patches.  The libbpf change is crucial for this series.
>
> Another reason for pinging because I received a bpf-ci report about test
> failures for this series [1].  The failures looks to be unrelated, as
> the tests fail starting from the first patch, which is irrelevant to BPF
> code [2].  I tried reaching kernel-ci@meta.com last week but haven't
> received a response yet.
>
> If bpf-ci testing is mandatory for libbpf patches, could you advise me
> on the correct workflow (e.g., whether the patches should be based on a
> specific branch)?

yes. It is mandatory and libbpf patches must go through bpf-next tree,
so pls send them separately.
