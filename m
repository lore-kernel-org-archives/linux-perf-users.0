Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AD3AEF22
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074241; cv=pass; b=bTmuzW+EwxRyakM85XkUrw0e7w9iZeskWiEzPG+6U9GbBRqIazmCQTb4OANvN4GMkJqhKapHUBNW5+rKcMlxzVXPrwMDpahntcJMbQE7WrwPqMsickTa7nMz8c8mXKxPUmq/vQV/6peAfy6tG86ZmT4q05X3Vyo3Qc63KGU6Ed0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074241; c=relaxed/simple;
	bh=/xVvyD0Lqn/lAfbvI9yNkpJEV7R1uzy3kwW07nfLaKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bS4Iqz9KV7kToS9RaD3rDRhG93U676uJYitW+ITHUXgPZeRjpf8R7Oy/iCAqhWwJbcMZdvBe0UpLfJ1b6Uia3yIXwwx991+llNP+kyF4ezyEGFZjlXvprscPQpOzfnpa8NztDkkscSm2STcXmmUPmQeuOaiAnoMjX521sqjvG3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yr1LTfWL; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yr1LTfWL"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae49120e97so1225ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 09:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773074240; cv=none;
        d=google.com; s=arc-20240605;
        b=Rhcrmld5vM2A0vXRaAmqlPnGIKLh6m5XkWX4KofyXfW1XJlikexIRWACP8BGook6Hm
         EozbObjXeqS/L7F7EE8AKOr4yX+9+3PTsVnqEzWJliO/9i7jeabQXa1KCCTBT5u1LxXo
         T7jfVPiDav11F4EEN0Va0BTR9cBalo9q1mnVcte95WOnHoZZQDxeOepaMpDMBAMWgdy2
         wfM6ix/7jVz445uqZ0C4zA/2kSl371VKuYs509x1y1VnRCQlx2YQfVOz+DU47hxHdioX
         WjiCHOKjiRfQowJ7CeALvDUkc3spqQYEPWUTZ8/lnWMO0KjdLMrAepFmYXerRroXyzmp
         00Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c8Tx6Ml8LCMcseT9tf2wyQ8mZ0fxne/KMVLw9eyT1gw=;
        fh=AzFr3rUAjULrD5rdCYD7v6zaeDTqDvOUxfpcf48E44Y=;
        b=NlHyejLtoLE35A/JwF454QPJ7mv8Bg9+nVNqFWdSDgOyKSK5NKY/WoLm2B2qJdUcU0
         6q3KIzKIOaa4NDH56Ba+iEgEI1m2bCIHz9/hp0aNgakyofwkjGcn+NqE44xBboIqyqkO
         mS4eHR3WozlqNzRF5c5tsXFzg7vTA0jSO/frltczVyWZsayWhrLf5JAu28SQryicK+9W
         Gh8fFJCrmgNx0sLQhs5q9KxbKjjfuSAydO7g8xq+PJ2Df80NHasSBolHqIX4nbcafL+e
         vY0BQ+3K9GrjwvCpjJqFesgBeG6tmCji/cFSiFt72P18lwspaHeKpLHrw3ulOH/8xdmI
         QsMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773074240; x=1773679040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8Tx6Ml8LCMcseT9tf2wyQ8mZ0fxne/KMVLw9eyT1gw=;
        b=Yr1LTfWLk6ccaQbsjiQW0i0d0CCRFWodupiTvfLJrDQM5BKKyC1JcPik9YZ3XNKs4x
         w1dLJohfjorzxddlDE8D2IZ9PyYW+MQvvWgwq5CEusXSOSgBm7NPt6CcrmhxANc9qRP0
         UMrToZX/bZWJwLyk237DVjkMX5MH5mvRiMb7IagBvFrsdyT7vpx9iBAQjFWYFRhuM1Ps
         OtcnJS+643oP8xu0MHir/DO5fAoADSw8Gdbhx/Xo57CQmn3DQF4g8FmuQEruZcHPOEfB
         xhrQfjeQAWAU3FbHiKi7VT06GdutY1T3BJFRgBWSOFR0MzUtqOupPCWekcGS/MbfS3zS
         OXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074240; x=1773679040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8Tx6Ml8LCMcseT9tf2wyQ8mZ0fxne/KMVLw9eyT1gw=;
        b=gAcsp5+H1guuMHhXpEdbEnVgY34KSvbHXgyc/UMZB6h4NL5bwuarU3efU0rCFQ/06A
         AeiGbRCBy3eGkY0pGkq5Z548uE8AFa/xIRJHjBIcgCvS7WVPcarkF1xzSIeMCp1mZlGW
         CacxEoWZBnQyEmFahieMsOLrlE2LXDYF+KarQqAhMZkSle153y8TvYiRnfR70+69Sky3
         j/OK+7e1jz9YX6X8LGqSEe0L9UKfAuzS2CfxXGLqsrMJwZ2y3mFx8/oeck0DQoMb6TOI
         dGvpDmuiPSCNz8XegCmAjPTZfWQ/fGi7ZX63NV+uBTWER5GaYZ1J9LBApgHfVpvI4haP
         /eEg==
X-Forwarded-Encrypted: i=1; AJvYcCW5nwiFmpuamvh3g7nM1+dj2aLw1+c4Ng6w25uuO9+HYBD82QtnGPG/sfdsWtLi23FYvpr+XvLw0S1aqZ8oOzjB@vger.kernel.org
X-Gm-Message-State: AOJu0YwtkrbOVM7zED0/HEphxzjVFd5oHzS6o1OeUvu16zUMUYcj8CKx
	l4AlZ80k2nWqy+VicB0rUoiw2hPGFjavIa9QVkUbJWmoFimT8toUWc23ISXVyY0xuRNRO7L/QV5
	09av3rQUbD63vf688nBzIafL74FauNFadd8OW0uFf
X-Gm-Gg: ATEYQzy74/7iPboF4uw/ihdiT1pH1pLmUMl+johY+otri3M8EHIRNnFHghz6cff69T5
	CnEGwt5xm9DkEYlH65TDxgmGFC/Uy9vn9iFheB0/XKP+rSwwAe406TmmJIkNgZVQwO1YWrQl3hj
	Kv6XbC+2F1bmvMIKE/2bbw5jwOBg0Zodf942bwOsuVIjK2eBwK4QpqHUBLK3jaXUNxvDO3EGFBy
	HKce4+g3w+olizXPRmjMfx9AdWhFhXh9v7ZU2Adg2DqWufLOT0mdK1lTNIuPoqnr9kS/ALNPKSV
	F5PTxbLulY/9L2Ip9BaApwYrvxkYnAC1nI4=
X-Received: by 2002:a17:902:cf4a:b0:2ae:4e8e:954e with SMTP id
 d9443c01a7336-2ae8b99a09fmr3540605ad.5.1773074239351; Mon, 09 Mar 2026
 09:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
 <20260308-tools_build_fix_zero_init-v3-24-6477808123b7@arm.com> <20260309114413.09e05127@gandalf.local.home>
In-Reply-To: <20260309114413.09e05127@gandalf.local.home>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 09:37:07 -0700
X-Gm-Features: AaiRm51Y_hOVZDhnwqzBMfs_foRdCHZgFLdwNP1ZXf1eU_ewkridlTQIwkfdNsE
Message-ID: <CAP-5=fU4JF6=aocKhgyZqyqm0NOKpAKEmruFj2mgBHfkqbN2yw@mail.gmail.com>
Subject: Re: [PATCH v3 24/30] tools: tracing: Append extra cflags
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
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
	Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:44=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Sun, 08 Mar 2026 16:46:29 +0000
> Leo Yan <leo.yan@arm.com> wrote:
>
> > Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied t=
o
> > the compiler.
> >
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Not a problem with the change but running this patch through an AI
agent brought up:

  Should CFLAGS be initialized with default optimization and warning flags
  (e.g., -g -O2 -Wall)?

  Currently, latency-collector is built without these standard compilation
  flags because they are missing from the Makefile. In other commits in thi=
s
  series (like for libbpf and thermal), CFLAGS was explicitly initialized t=
o
 -g -O2 or -g -Wall when EXTRA_CFLAGS is not set.

  Additionally, should EXTRA_WARNINGS (provided by
  tools/scripts/Makefile.include) be appended to CFLAGS here, similar to
  how it is done for other tools?

Thanks,
Ian
