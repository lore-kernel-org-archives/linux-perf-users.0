Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0649302163
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078717; cv=pass; b=TcFTHZnBEj3yzJEY4XoeEIUaZ9thh5nBj+2gPU//TS5Bh40EIH7M02LVeli4OBI99B32/ljxsOK8tOl2gccrb06giq9MGkJXnvgpr5hpQuv3fowlQ6EcDLQuwIEKGyyfLcVSr9fJD+qxNnPBCBn+FkgZrjsQHESXYpnkzqCQSTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078717; c=relaxed/simple;
	bh=kkqzTEyvh/URTQ9I+cvN17shvFcTkWcWq4aF5dQy6Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXAkbMm924T+TooYqwcOD+XRX12ZVPh9XJO7a9wG/Ghv90Zp11c3Kn/mfqDLHksvaRl0cF3pRKbkn/uq68C6x6rfBIdY9eVd9LhdTLQwc8MblnsZhJCD+5pZfwDPVgiB5zylAcDbJA3BtsfjAaWFhGk6vorAytqW/SxZqh6VzOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yGTboS3P; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yGTboS3P"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae49120e97so15105ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773078716; cv=none;
        d=google.com; s=arc-20240605;
        b=RALwr5HWWnmAPSV9OfeYXrKYQcFFdAs9aaWEqnvEzP4qoXLtU7LNJDYtLhNrrIWI7D
         +y4IY0eO9jBbMnBmb4B2Eg0Rg/KtRTN4Ya2wMij7B7LaCjZnoig2v1/+x9td47Tv5xsr
         lRzb4WN1I353sUpTH0Jmyo/jYzmIeHvalrhzn3aNtFptH7nynSl7Ql5uHKAqi/A0uUqx
         lQ0uS3Zqkvk0FEJGmgESJGumDR9wfx8Dxvtun5LCz+nF3ThHC0pkru07uNGy1+Pl9fID
         lfsibjdLLRk4JhguvwJeG2T41iQaaQXfCobWoTqTviLFw4LpbRFz42LMIk2ysgR9Cgus
         rK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9FO2/vMdvpebNXVSiHoLYLTKLNZ/3KtLOm8TqnQ8k3Y=;
        fh=+tdMJ1rFUExV203yx1ggd49MsRlOH5Tylg1VfsBvy0w=;
        b=juqAURghrNxs0y5kpJ1jhZadvhufp6pC/r0DIAm27clWWsjLh02ZJAuPhDLeZJwr1S
         G67qED1CNvMP2EtyUlWhSqsZTbF4aNltb9JcnYQyOe4XD58X1Y6j3r8Ntqc9yS+IuSQm
         drf7ZF4s3gFi4Q+1IvDmwl7JKVPzi/eFDtrHb63LLrNBJO7klftj/FjMff1OMHGxpURC
         dydtqItJW3ZV16p/heiYebmY+u2cOUcqXVH8+GOOQlox+otg+0UXCMhpE5VVOyuz7hPV
         YrUQtZQ4bbee0OYiNF1GjzWRh8wPplpo2/5yB8gvZA+cvUkzUnMh/G9olwWqcfOsqT9J
         WOow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773078716; x=1773683516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FO2/vMdvpebNXVSiHoLYLTKLNZ/3KtLOm8TqnQ8k3Y=;
        b=yGTboS3Py1ByT60HznWSS8zoNtHLxhO5ZEtTNy/x/hydjlBX+jr4Xd7BUgroD32Jjy
         UJD8URz/25FWMhwBo1Yq+PTDujMXZsP0IdVNgEh+Wl6SjmhA2O6jae5WpqOtvU7MK4TU
         m4mZffGol1hAVDjUaxw9ECHjoySuU40tR5Rsn7OWNGuKMsawhMsklhEySHDemdO1Nx2g
         qdF4BbVJLM97IpH9gEbV5LcQvZl28X/mtif7sbbCHEhfLuko7L9vtwRxDak6/fCnGiyi
         wn+lBpa8keILLkEqyN2EY5l6TxCwyuzvjSmsHOfKSuhjSb8gmitCW8OO+P+u6mH4ySWt
         aTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078716; x=1773683516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9FO2/vMdvpebNXVSiHoLYLTKLNZ/3KtLOm8TqnQ8k3Y=;
        b=jQpZp3TfWbeWtP00cq56xjbtxiBy0/8duL22XumLDRAPnxKZi5XEDrQrUf3faCq53L
         DZqC9YT+C4ynGrp2MDkdjGd0ppcUvEUXkMTE8NuS6dfF6WO+IIOijMI55JcGsOcqsqGi
         MqYvoiQVgaa0wqLBP4bga+Bb5qI5umUIRiFBkHCl6Klsyc9b+R1UGOixaHveNKsmOoM7
         plSsloPcoYWbCKPM996IXXJH7EgxNWL8wQPWvVcyn3TRiRm+EKsbdY5a5sZT+e7aLAhd
         DpVGNJTFm13SFT8NAUDJ5w94jeEdfW2zwzgm6/LNd7FkFQCrXwgWkdp8WC4DTCQNhDNH
         uYkw==
X-Forwarded-Encrypted: i=1; AJvYcCVMh/Pgr+1JTG/smjVrxvXgS0B8D2vMj0RFekaPxZOiPsahY6Y4Hfo4f+NR16Vu4S4mGmNOMYao7x8N0ssyM8+R@vger.kernel.org
X-Gm-Message-State: AOJu0YwY4SEYh8kceGwizkiakDqJNRHO02eZFxKhyR8129lJM70Md87t
	+AjFfoDLTDSDmla6M23YaKu+PccZqOSDO9A0R5zOn36vlDA7bc2AJw1C1rDGN4PbrcrplLQHmoP
	+eHg2JXzg4Vmmj7vp0WK8oyubofMODTYoiX2gcDMw
X-Gm-Gg: ATEYQzxcdcfJxjkfr9MJtymHKRcRkHlNaqsHRpIyh4yG3g2f/Li/XqihBKDF/eXXG4E
	D8Rznq5g/FdWo5MkRctCbypvwUADiDkLvdi0G8mFargACE6GfpmDfDubn81AObZmbSp80ODD8y/
	mlBeo4CaD9loyEwXlK0GExptqAz7JUlUyzbtgbF/cbGhFxjGeGaooqbuyl7ePRCQUXvcTYx5Z+W
	nJkd+14BEjXaV9XzL0ELuyN9eB3UdYbDGlDOCTG9FOaMOBH6yCLtPxuLMbvX4bkE4Y28rPz2dXf
	icWd7mffxHoeToElXXOOTBSNgPt49q9R4YQ=
X-Received: by 2002:a17:902:da83:b0:2ae:6432:8f77 with SMTP id
 d9443c01a7336-2aea3292d58mr119575ad.17.1773078715506; Mon, 09 Mar 2026
 10:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-10-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-10-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:51:43 -0700
X-Gm-Features: AaiRm50nzx4ov1KA5iy_Znwdr5CiIhbGHwfapJ-T0G5dtQyH0BIhXI3ZAH4nLI8
Message-ID: <CAP-5=fW83wsZfWpa9777ze-RNSFhAB9PnBa3xkVMu0LN64CThg@mail.gmail.com>
Subject: Re: [PATCH v3 10/30] tools build: Append extra cflags for feature
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
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the feature build.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/build/feature/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 1fbcb3ce74d2173072748a417fc63bd9a5b13888..103d8b71e7a4e8d0979242cfc=
95c1c0b946222b5 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -1,6 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  include ../../scripts/Makefile.include
>
> +CFLAGS +=3D $(EXTRA_CFLAGS)
> +

Is this necessary? In Makefile.feature:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/build/Makefile.feature#n11
The build invocation does "CFLAGS=3D"$(EXTRA_CFLAGS)" and so the locally
set CFLAGS appear to be ignored.

Thanks,
Ian

>  FILES=3D                                          \
>           test-all.bin                           \
>           test-backtrace.bin                     \
>
> --
> 2.34.1
>
