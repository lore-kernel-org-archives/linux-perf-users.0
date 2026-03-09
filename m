Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80E13DBA0
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079377; cv=pass; b=Ii5DVI/ijEA5s29IriWRj7+2uAVhE3F5kazVstc5w3rz/CoEY3cMPiLCo4Qi9GFmA/bFFrKfDHSUFbe1RACl9JJXMv8npSfAC2ra0u+XO7xZ0dPnzTDwvLrHTTsEkg47qHD3I0WuhGbBXEPSHmAYb82Z0k2xAy0qCqBuwkiQGGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079377; c=relaxed/simple;
	bh=enJJBtiy6q9G9zGlhNtJO7VBcncRme179U9y2TQsR+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0mNzkb2kQ16UzutgXcl+zNquLEnMInPjdZHgZxGKp2/gvQTip10EbP/N37khhn19g5nKit7svMaQ/FpTu7gCkPs3WSz0nTDj4po+ezvYiv6ymKI+EFy0vyFmyBLHBhMwEDIO9nMnF4T9LUDuAlIhRuKsq6/cLuks0f2jGUCZbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0DUiDaRL; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0DUiDaRL"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae4b40999bso16455ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 11:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079375; cv=none;
        d=google.com; s=arc-20240605;
        b=NlWOsMq+e/YN4RzfGUC90h8C5NGgsqJ7ZXGT29vfBy9dfBqLy8XL27IUt5Jy8Eo/dE
         7w+l2BwrsyIdhSiLTQTGMAU3vZE55Gt+2UYyNm0FClcwLR/1sMGC4guChgteevITpPwj
         5jvCwnbWmtDzcVu+4BnCNKO6EQxbf4phFhQKlQT5kBAi/zzpk+6X6KjaOaUZGQuD/dqt
         U9bYDoLEERc3X5cEyShjNn33uxH2PxEw44HTKRxEeTa8OmlR6Zgp63XcpYKwDXFA1q8t
         U/B2ttPVKWTkEGWlEi3QEtLcm2LWeL6+1JQMelTf3Sx39MAJRwDO+pw4ZfwKnhQIZYXN
         dfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0DTQx0tSE71UMF6lY+qr4IIE8EQg8d4wRW0tM3/p9E4=;
        fh=m8PfNgWXfwg8C/XHsNhbTYILYCP1CLbUsWM+N5/riyo=;
        b=UOfFsXg7IkqSMzYrh9xlmLogHIubr+bPrzdihJmYbgvsPhOI+4rhsSoRlJc5vRgkQX
         WWtXdtbOrNgrD5PyqsP7qkquo+33sau3AaJT9UQNSjHoixAySslUUWeKcu0MCHiT4gSl
         gTrlEG2PeFzhBxWiyVPwKFvMgqWsoKL3F6eJM34cpFOrdgwGYiriKxHoR7gS3IvwJwmZ
         RXqeCudDkaYjH6zVYObSQ3tj2iKGU+yEZBQO9gr2xmf9dO1+m59POMK+v1yxg0bhgdl8
         m6Ni8Kfn60CgjNYtf0D2L5gRZmc5s4a9P9G0gOZSttDTMJUJU84yJ9m/oIMxrzXNXW6L
         YDNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079375; x=1773684175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DTQx0tSE71UMF6lY+qr4IIE8EQg8d4wRW0tM3/p9E4=;
        b=0DUiDaRL3bxMRTyUwQ+T4IGsTQrc99q2+LHBjEjAUPnDoGyCwJQjIuk6h9/cfPEtg+
         tzPCyZ5UcDK1dHhyAn67IxLpdctClhpYzP5vFBkWlnMK8T5V5mDJw8hONtWjX1q4poPP
         66UYCgjd8GaVgm52Jcd3Z+oCITavUjh08HRSfVX/R0glyWx3rKYkGb3QnIv8+5zrF8SO
         fmdlor3V9asiDn9hI2XsfirnON4ZDTUQhgkXXbKHjFoPg5mWULd/H7Ea+lWCSlLVDkeZ
         WmApiK5OPzVY/guqpJDeXLBKvneFxn8V82yLtceHg6Kb1isLtsr+UAPzTQjfmcaR4Ei/
         d32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079375; x=1773684175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0DTQx0tSE71UMF6lY+qr4IIE8EQg8d4wRW0tM3/p9E4=;
        b=pO2nG82tE+CNmZ54+F3x5OCMXU5NV2cdZ1AFH7WqlgIYFBCJOxKwu3u5H/vvyqSMyN
         y7jIvSImGDZbk6axntk2MUvQH6W9HNAKbmUtwpagbis01fxf4Xo4HbB/M31Tjw1RwMO+
         mHwMudKNPSN2Ytg8LWqBTv4h2EGuYhHSLMbzINCKmAk4JXA9gkosHtWX80r+29LdyfV7
         6S+v2SNs+Pgde9udN9U4NXdySt9RCH2cd9zoi9ubh3pblmE8syGVJfdlV9MDa5khZ4IB
         cG+8vkJII6PbYcTh6Tf9bum6Og0HonX+at0kSKOEhAem/bLaHozng0ZFPWIzRHOTIVNU
         WRiw==
X-Forwarded-Encrypted: i=1; AJvYcCWGj1wHc1+mw6OB4g1itEQPXdVDbydj//+VU4v1Ync9FIxI92JR88D8bQRQ8iCeUoCGbEPm+xb7p99R1fylC0Yh@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZ/YK/mYcM8ciqnXcloLj6nR5xb6Sadr88L9JTn+fb9sVATZz
	f63vQZRthg8OLD9bnXKdLkxb3cgXTTMyZSjtB4Z9KWerDYFI4z8TEc4lwUufMc+f4gM66VmE/BQ
	CU8YlADqFdi1GyAOMAh66Fsdk2K9AiE6csYiGmNrs
X-Gm-Gg: ATEYQzw0jWXZBpIRJD2cAvu/EQJ3UQr1WBW8feXxBPeg7HTRmgrjsw+uTsfRFainbtq
	S24TMSFP1XHpwh/13bZrvXPuN48JBHlzRNRphBQ6HQ0UTQkYlJSNdXk+2VyJ95c00BVAi8WTJOd
	iZmLj4sFoVOoDHy3Oqe1qq8M//V6hPLnkcDPcpNikhQgxPEG4wIYHJqDVcAvBAVOZSUNIC8s8vZ
	40QOoEnx6gxDHOg5L8IPHkx4iKmsi0iJAmLh6mTXukPl19G/HKpzKlS08GQbN5wa37AsgYodDfu
	YoMPWg89dxB4BY5sCbHdrnWWVFudNiqWpJqLAF6748Hm9w==
X-Received: by 2002:a17:902:ecc4:b0:2a7:d266:d84a with SMTP id
 d9443c01a7336-2aea325870fmr266715ad.17.1773079373978; Mon, 09 Mar 2026
 11:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-30-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-30-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:02:40 -0700
X-Gm-Features: AaiRm53fepCChw8O6Lh_i9zc0Lx_aXs0tJ85eByc_82LQ2DVnvOinKgsctHPHWQ
Message-ID: <CAP-5=fW+8BXLMXKyZ6GLUq2it1VTVpCg61qCqpfSMDjHeOJfXw@mail.gmail.com>
Subject: Re: [PATCH v3 30/30] selftests/sched_ext: Append extra cflags
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
>  tools/testing/selftests/sched_ext/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/s=
elftests/sched_ext/Makefile
> index 006300ac6dff88a48104977398d8517753e7e385..81d8f4a184245d8c330cf45b7=
5bd868b2a7aa7dc 100644
> --- a/tools/testing/selftests/sched_ext/Makefile
> +++ b/tools/testing/selftests/sched_ext/Makefile
> @@ -53,6 +53,7 @@ ifneq ($(wildcard $(GENHDR)),)
>    GENFLAGS :=3D -DHAVE_GENHDR
>  endif
>
> +CFLAGS +=3D $(EXTRA_CFLAGS)
>  CFLAGS +=3D -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)         =
         \
>           -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)                       =
       \
>           -I$(TOOLSINCDIR) -I$(APIDIR) -I$(CURDIR)/include -I$(SCXTOOLSIN=
CDIR)

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

> --
> 2.34.1
>
