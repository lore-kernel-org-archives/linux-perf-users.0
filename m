Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21C641C2FB
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079071; cv=pass; b=oSmqnpjFwbk48J91EYBrG2pgYQGEa/CGGKKmyuJpklV5DrQul14Votz5GjAOnC4pGG58YIlC5AT6qSJyxMR+w5ZHzYRS2Xs7No56qUF3pJElbz7GXWY6x5lgQ+hYB28m6CSBP9mmuiPHZuw8U/XyYdwJKcDAYAxKJW6NNl7KLrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079071; c=relaxed/simple;
	bh=bi/0kzUFQaV8p3doZRD93rVlwd2uelaWqK+VBjCrW5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tI9dH8DNSMlhCFFRxJbx+qFLuExZ1YL5lX7yAru60l5IYUA3XvgC0/KUZhNeJUD9zLHHJB6UafU/5UVNNw/tk+tN/7yHuec5Eey8jtcCI68Bs+WRsssMryAPAz2Vxv7HauLEdd0gtcO9miPBr2QXRDAzitbcVPBM22LVRQoCYdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gx2DEeRl; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gx2DEeRl"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae3f822163so12645ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:57:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079067; cv=none;
        d=google.com; s=arc-20240605;
        b=ULNDCJpF6de+06zSlbJpLqW5vvWA9KKM9deqguZCtJ4c9SqBJOVc7zTT1LmwV2JaMm
         dooYZs2gYUM6SSFTVZxkZV73TSpnCCuST0oYpQieFOGRqaKDAPO1DDYHXFicM3o6XrRB
         ptmydzMyCYdHPeHjrLj9pCuw2QkbR8twHN9nRASC5UumJQcdqOI+VRDyx2s4hS8CWm3w
         m23o+1oOkRO+ts3S3IhgN9Rn9/1bowcsvYBXukc5893cuk2K1lx6M6mWCozwVTX+18vo
         grjUn5uN2LB+yaTkrCYqJFjJMWfgOla9qh/V4iMk21gP4UOJibRARepckZaJSupU8fJU
         +xAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vDlEc+C10LHwn7mMynGp+oAsPyPidhsvHXmfLuBSVbU=;
        fh=FZRz2qJqqfWCyIMJw7mRNXippOUSI6R5Vt+Huhz5KCU=;
        b=Ans5fg+VvyhPYzSu8e0XRFt8mfkFD5yio/vtX6h8tcrws9BTdJKAdkYm7c4Bl63KiO
         szHjgvT6/sggV9l7RTyPNUYE9fcW6oR/mzFV6REo5lLU7Tq2U+43uytk4OHCuPCxnx0U
         qH+57tnoGf0xSeT88ZlVtEv87VIrh/gYhzRLdm5jsIiTZT2HVvMjQj3PrGwjynhYtExC
         /tmgmVZUoTGY/t4kZXtzEFXfPrG7CNF9kXfef+e3A9EhATVhJ0qwSWuPjUFcasr75X5K
         HzSY4ID4lRB8SmTa54O5jT3mt1gONZkyjhRZI8+RZdi17jx8n9QWV3naYneEzKPVP3OV
         hrTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079067; x=1773683867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDlEc+C10LHwn7mMynGp+oAsPyPidhsvHXmfLuBSVbU=;
        b=gx2DEeRlRHQNr8/WHpJTel+e0k/DZydgp19ppwvZdahC4wi7nMalsSX9NRv26DZs5u
         e4rNlHY5efFHD6Q3/7C+UBxrtazLRVe+8nWQWVBDZ9+3geBOn38APAv/IZDH+tbi6oTN
         oiBdSB54yjHWjQxza7yPzV3I5esuNxaNZ2k3LfrjdGwOZ3qlfNjvIuuZw0cw+suUJtR8
         kWntTqkfE8SGDRgPwsbh+SaAHCaUNkqAN3mcCECtkjQ4LGeE2Os9cI0vLy6uJpYgiKX5
         wjdF4C9mpIwX7sH1w3otZbDnlQGKO9NOUKDuhkiZropZJwCY32M3cd5uFmP6HnQwAPRv
         RmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079067; x=1773683867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vDlEc+C10LHwn7mMynGp+oAsPyPidhsvHXmfLuBSVbU=;
        b=pzIGJKssnSaRr+NkBHLkJykJtCpw0eiic5xBAM7PChuzX1Aclng5MuT6H2U13ndCRM
         CKJt+Z/wL3j23wRpXv4OxzKPfNUhrl0hOJ8vqAxDx9Went92JxcM6eInFh0+4pRbg1pp
         hGE80VFNJiZ5fHm4UuUK3RdVFeX20aLUmnbu38iOQ1vdX9KqKzf0viRBuEEyUvP0wI1x
         RN0kszxSrpr1pQG9pmWi5JRZ1OlAykr2Wubbe7JqJGR29L2jiVudXx1q+e8ulTOhvw9N
         6/WwOz3Gr2iyjcLN6qS9TjlsbLTu3hincg0OsZQqDicD1CRKu9zCMPjoB3BwQjOVTVzc
         UOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAqhlbnHUn3gAKuC0iysiNjLHAzNtD1D8lH9Qt37MuOMjVdkdMZqIYR0OWIo7JHPxEboRjb+xu43vo1Xc7WwqR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2JgLsa39/hbESQS1TGbHoe2AZfydWBgqHPEbk8tM8GOCplKZO
	5p8GclED/kjpGqvXol5/S8FMzWVcmzOnXPE69Vre7AuyIKsj045htprSytrUP6SHkHtc3pRc/EC
	zYLNxtQ5Qz9JTYjGjlQ7cu1YO3dvTm0W/y/Kif2Kf
X-Gm-Gg: ATEYQzyRqnm8OC0FZmTElGR3Q57HyJnhmg1Sr54u4C/V8gaNctTtyYP0VoRFgZtqGG+
	BuZZgYZ3CGZBWOotYdUFrU25V1yESzgQC3UbkO8lzM29kB6R1jwedumnvx9gG2BDMtRoyX3Ge7D
	OUZ+zpprFQFCWdyMIzQpGXGUksJMJ2zD+9hoYgWVcK5tyWmePtEaB+XjLj7qG+DEFT/zRRHC0YP
	QAjI7QdDiP5E/TGLs+yL80vOIJ+oPTdWg1msfjO2nZ9Z3sXkfGHuxgrkhcKXDS3ptbkR4pg8Thg
	kMBLLtsin9wrd2syOa1BS6TmQhSM3g47HSs=
X-Received: by 2002:a17:902:aa85:b0:2ae:8039:fcb0 with SMTP id
 d9443c01a7336-2aea3122a7cmr131785ad.5.1773079066411; Mon, 09 Mar 2026
 10:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-14-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-14-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:57:35 -0700
X-Gm-Features: AaiRm52StTlx-ugeD48VkaRFXPHj3olO-UKSkeOjK7TIFhirgpNgc7cDU1gN2Ws
Message-ID: <CAP-5=fVTKXfV0qqt_Fj6r6wZ-O2X-gqjM2mkPfbawnDJQj7U-Q@mail.gmail.com>
Subject: Re: [PATCH v3 14/30] tools: gpio: Append extra cflags
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
>  tools/gpio/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
> index 342e056c8c665ac075041ff7c7ca7ba94c691187..206fb6c91a569d64b1e4b906a=
da5ec866323053c 100644
> --- a/tools/gpio/Makefile
> +++ b/tools/gpio/Makefile
> @@ -16,6 +16,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS +=3D -r
>
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>  ALL_TARGETS :=3D lsgpio gpio-hammer gpio-event-mon gpio-watch
>
> --
> 2.34.1
>
