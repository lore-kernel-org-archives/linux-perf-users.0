Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D603ED11A
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079337; cv=pass; b=AzDFcGD/XKOy99o+omfTvrfS9KK/Fv7JzqQ31ZFei2L/LqD+3YMHxfddekimcTnUTdv2lgWkKhLHKQygRmAsH+VobL31e1pRw478BoEzHI5rccnLm1QIkQthc6KLuf0/CRRABIzGA8q2hjwKozvZOudoQqM8HeKPGXqCoUJwuhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079337; c=relaxed/simple;
	bh=sXd2n3r58atsTHalU8kH+eYu9sbWGdifgWknmudkZ24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JW2JsuMG0RuKL3u+ts35wF/UhU4F+TDCzEvN4ceGljTNpSl/VGOcmoeGpbVAKkc4tMg2T389i2rq4upeJjsrIP0U/ayrCdksKIVBCIQmXLs4Etjz5gubbtj0uT9/ihr1d2ZGSVc8mewCopR3/yx/GFVJjmTnm4aKroC0VhkSOnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1pYvwzqb; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1pYvwzqb"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae49120e97so17785ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 11:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079335; cv=none;
        d=google.com; s=arc-20240605;
        b=hXiihASqsq8lbEjTVboCzaZgUJumrWkdduXz0GGhLiqfr5IoJkWzGbVHwu/NJ2AqUr
         vuHfoyGL0Ap/X6zsRjXhOWM6obDUXgIeM3zmZ72KFVLFmWuxonSaXfjCSJyndizNZpAl
         o0XF7MYXcUMUqrrwEzAtND11yfvy/hBV1URsLr+zjTroQDYYJr2eIT0QRM3FFbQnmqKy
         C84TTTd/516+zcAv0/JxOTr2le09T2TFfYB23C4sG5jT7FJZMNOB4EpYMmTihC95uI3h
         7zZCca8UflhaxKuXSagU9hEl7598CYvbc4TIRpRUXL8AgMhDDe+z/IqvZU/QRwagSmcU
         mE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3LJscPu/LCmEc0GMnCIHYIEIVJSUttXk0NscrVDqh4U=;
        fh=Zn7ssdQlpDGdTpxvah0tO7yMo7V3pgN9mYyEJ+Y0Y74=;
        b=LlQ5TjKhmpsQP4mEQXlgfujhnPI7JX3jXyThBLBFprA0pZ9JzbLbLb30Bem+zrTI1I
         02ddubleVTYVGS4YNGekHh4Nhv1dKQ3LxXxa0YNHNzP76gAbStwmEBXSIWCNpx0qkyvj
         ylSG90E/fJN0uBQTGmTrmA6oX3vyxPcmGX2yPvTpkOhNBZgqgNZgp5sM6g7pwHuGVjrc
         LTppeO0h8tZ6a/atxyev9B/Vyd+79yiO48XybcZ/5NvWJFdcvjDHQ+CgwkrptopUhmXK
         W83HOGGlWNZCleZJxDYHM8f+99RNtmGTX5PhLbiPknkzbyN39HyTFHGCG/2+hAEqk6Bj
         Lz4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079335; x=1773684135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LJscPu/LCmEc0GMnCIHYIEIVJSUttXk0NscrVDqh4U=;
        b=1pYvwzqbxIsi4b1//rsj9ww80cW6ue8Q37z//Oqr4FMhbVJGhrBTf99Q+wQobzmcAK
         r7M1xwYl69ABFuN28riLdTtC4zjCZegKehewPua7S0TY1b7pwrqR8FyrVfmc5tv22ngJ
         VyFQV40sjhwUAe96xBXBv+W2OszKkCFSY0NJg7DXpyZo7KqeFBJr89i3/XZNfNHDB7l9
         9TXJu0og9fUzELT89y4lBH2KCBu05HdKFB5QvrwuXBcRqNK2UTwqlPRudj7+IHQhrQwm
         EE+/8b4tTzOKSSyzz45Kll1dzxYtmu5wpvQAzkRhNbkylQ0lvuyO2gV5MZxKi481jm1j
         vx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079335; x=1773684135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3LJscPu/LCmEc0GMnCIHYIEIVJSUttXk0NscrVDqh4U=;
        b=PvzEFpu5P7Psa0sfBg0D0iPyn3Tp6b++y7o82dBqOit/Jwnaze4U9gQEdNjRpCeNjV
         F2M/LVGBMfuo+4sIhna30Rw/fh9JBq9hn1JByM3Jbf1HBxxEhmc/jhvLDe4/BFrzbR3R
         R84LoQ5/X1Ha4W/oNoOBQbq/0GjPuj3vVBiGYXqY7mSZoXywdPin4HfoG/6GeJcjxpW1
         Q/N36S6dRTvqnswaJpIVV08NxlL2B4Q4d014bFm3/x2t/Iim5d5mNY/OTPUKRepT5/xI
         YJwgGjPJBin3HJdyGHljFZjOld9LnbCrPmqZ4FFG72LCHTQvOv2IQoNWTIkvqSApz17e
         3TyA==
X-Forwarded-Encrypted: i=1; AJvYcCXkn/yHjqA/PzuIW6WuFf5Z1OZGieAlQjrRGc9Hhrb42uMd8OYAN9qf6UUSLPs8b8R131qaP/tkZXgZShfx1pGO@vger.kernel.org
X-Gm-Message-State: AOJu0YxLGEDIE/AxCjIDATeOQL1WxrpZ1WSHYN1KY9kRaCST+XfWeSIk
	a6khlCoXRBAjhc2TFKWHKxeg9Qd20NuReFeKITSubP+yK08tnmnFWCXmGBsP6ClbyyAvgPzQMBI
	GNrNQxNjXKPdoM7cn2hTzDn/VCZS1Utwj3T1Qqu6E
X-Gm-Gg: ATEYQzwfep5iGWkgw0QgVcgJYfn5dvSF8YNVeGKNrYsoePje/ZEhfy9/LDJNa4PS/nO
	Ys0BgEeYskrfcXv3DjUqMASjRPPBDFSzWbXD1P+9MlviBhzMF7nbvWIqRdHxqrLezwJ9FKQbjHT
	SsGsN6DRF5/L+g6BfcQF7jepg6LAjDT48HBOelW1Lxi124kfEX1ymW2qzoMM2id1ajHoU8S5onP
	Ot6nrAYCUvKgljGptJN1JspBjA1CLlA9tpG005gMcZV7VIZJa0qWXOdXWrMyi6Gz/hVIBTv5XmY
	ciFvH8f5OJXEfcTeVr0Gtp7huH4eGskHnHlX5c051D488A==
X-Received: by 2002:a17:903:18d:b0:2a8:fe50:2933 with SMTP id
 d9443c01a7336-2aea2f2bc3amr316945ad.0.1773079334115; Mon, 09 Mar 2026
 11:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-21-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-21-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:02:03 -0700
X-Gm-Features: AaiRm53eNfFq2R6M6Fsx3M04tNIq8R1bV70kYSKB5eTnuoUy08rbJqrR2yINWgQ
Message-ID: <CAP-5=fUkk6vDQQYJoRbGaA2zc9pZds9xHtoFOvQvO8q_D8ahAg@mail.gmail.com>
Subject: Re: [PATCH v3 21/30] tools: power: x86/intel-speed-select: Append
 extra cflags
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
>  tools/power/x86/intel-speed-select/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/power/x86/intel-speed-select/Makefile b/tools/power/x8=
6/intel-speed-select/Makefile
> index 6b299aae2ded89c3a70a3649996e258b98001ee7..61d6e81f3cf1d6427addb4f31=
c1369ac663ba3d6 100644
> --- a/tools/power/x86/intel-speed-select/Makefile
> +++ b/tools/power/x86/intel-speed-select/Makefile
> @@ -19,6 +19,7 @@ ifeq ($(NL3_CFLAGS),)
>  NL3_CFLAGS =3D -I/usr/include/libnl3
>  endif
>
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include $(NL3=
_CFLAGS)

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>  override LDFLAGS +=3D -lnl-genl-3 -lnl-3
>
>
> --
> 2.34.1
>
