Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FF3815D8
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302755; cv=pass; b=bT8eTIcj7UAUdw7RSWXsGIloOLkaC4b3/YKR9J//hZL5yROqvRZyp2j8pWtLIZAg8HpU/Rv4m3M92hrxhIi8mSlpwJWbkD/spnkUJex2lSpeQzs1bjCUYX6F1GXochBZvF+tK6ZnJCzq5Ragf1BTxTtVUD+rqnQ/p/YMyns38WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302755; c=relaxed/simple;
	bh=sBpt4JBKJwVjXuMXplkOgOFupV3EsudH585P0A/BF6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dL0QqNHxpnmf2JLoh3NhFHZYnpjyp72/GBWgwN/b3/dpgO63xp/wPltP5ccOfKDcLDclPtKIAKJwcfpIbpMXGP5b677yx7kHyFpiyb4Q4b8S8RP6wzjs+YmyKiBED4RF1eX5Z25HM3zNtPN/vcoW5GQvjkLjbH0XRhMB2rQquzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWZ9n5NB; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWZ9n5NB"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aeab6ff148so14045ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 14:52:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774302752; cv=none;
        d=google.com; s=arc-20240605;
        b=PtW2D/QvJFhdTv+hKWtqhJ7H5fGRoCrr79ZpcyC1JayFBL4HU7rCCm/B3TgkML4wcm
         qwBVThJqHawKoklHaFHAU38uaLPSW5bu6WPSuiNX223gSM8DFOhbxzOyDGmj06EOzHzF
         O2qXalG922FQtC6V/EBNKvauLLKsx210ySmmeHjjxevMd2lmqeBWaL8KYxTcJojkyfXx
         SG2PyJwueL2XXd4SATGfDHyz9ZEkRF2qp9Mj8eYhR09fuW3apn2u4GrSSifq7QxBrt7U
         c5cog7azFOp++CWCbehuVFvWY9afM748bmjXBEHx5ciIUjdmZvAU4Fi/hK7RPviU7Q0C
         EfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YmKAfG81GUfLojTL2WV0FfXjre1ys9QeKFFeiwGpR3k=;
        fh=JGuRdiAbZONIo1CdZGK7UJEEziqZkkCwkn0OAiHw4qU=;
        b=evx4HAHyYjrJ0vFXEn0ODN4fZhhwku9nQT1Wm2JR5GoBa64wlBxdRHcwzvp7jgV9RU
         +MNiq0TTQiZAAZYZbizcloMTCtC/o9i/yxMlDXEtHnNVLg4awv6NSud523BNsfM7EWlJ
         wWE8YFlA174V2qGq3a8DAWWWPMiYaMZs79n4sbzPCIwwBpuumu/Ln1si0hz7OcgfDJaJ
         ZCjYNKB5WVRoqf1rKSdAiQaK47wreQhM5IeMEiJEBUYQSp7Fw62lH7f4MCZyhkRBXUmY
         342ZEvIINT2YftPrzA1gYs72RVualpyYHnjIeoavUyGg/tyEbLPHZ9DmxykidnB0dKFp
         TZTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774302752; x=1774907552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmKAfG81GUfLojTL2WV0FfXjre1ys9QeKFFeiwGpR3k=;
        b=wWZ9n5NBS/9RCgwHRU84wAit0QohoiXmzck4EmORp5UPYtEkCanBTWrcF6oya97kAm
         CoODxVpD/jMmRZvpuu5PotLHvpunW+JpwcxFZQ3UwksEKZViQSYy4YSiddM+m/DDZSF4
         R3wKVWoegqLyuWu9wjtgEJn35p7vo6DSVw5YNtNoqNDs553jlI19Da8Nr/RaY2FtVwfS
         p0l+FbPuMJV6Xb6YAGxCMGADFd4M/0XNGju5Y02DFh7k6kq1YYATXMKZnEz97w7dfFwH
         k46r1vi454I6pOWTxwMG1SQxr9XKIOTHbDmeT+eQtLfvESGLh6ncjTlx1XM1601Ni+0K
         DJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774302752; x=1774907552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YmKAfG81GUfLojTL2WV0FfXjre1ys9QeKFFeiwGpR3k=;
        b=LOv6euYCIP2yccsNyGp6NRGopxq9vWBcLrIm98mlvvaH+3uWmF3eI0LWf3K+wRVRUM
         lRaO0ek87/7DdwyU3SwpNJkV721c/f3iIUDdzFWmYfiPZnuB+Egk/3juZcsJEi4EZ1JT
         uJUCm4jVp4yfV7ZgLYEJdn/BNqfrZZLoHsxz5kpZEMUzmpQ/pdPiSWXk3uzwDVZETCVb
         e6FNtUbM2pWXoFxhb5395onhXgB0mAd+07PKYJhNstpt8YZkNrnA1BX8uwSxN0vuV4qb
         gQi0PTCehtM1D0Z6O2OwmDPBQokRY50Xy7emJv3LmZWLAg4WLzVH7VY4htuT7ls3Tn8f
         VI4w==
X-Forwarded-Encrypted: i=1; AJvYcCV2CtSJL/FmsFzBu4H/XUVKERQbiEoT/G52RXQ0YUSULgUARkpCxl9RSrSTZPMOct+57e3m4trLGvwtwuy8S6ig@vger.kernel.org
X-Gm-Message-State: AOJu0YwiNDAK8IsPDgZXviSH5/TiyfRh6bzauUJyTpo0z2y5d6jTFMDM
	ZTcFUy5imeF/r+XFenZji/DzmXvLUTLmeQYTzxo5Z5K/bgFsf/m/2p8kEYYX/+a1X9H+XZn4ue/
	DitOdbZPVqHCulZiG6Xm3noNRU0G6ew5+DXfV9Nil
X-Gm-Gg: ATEYQzzC/mWNFU/EBIarUiRDFokas3qrTl7qP6LIIgXS2mNgMi1BxakbHX8o5Fjcw3p
	XAAphCqZZdv/kfK7PdbRDdKKh8keCnkVId1059tXYeCheadGESeOhGdZYSuPzs/UzbIy2XiGorN
	BGOtQFiVTybAc3TcqsyoR8qFX4oN5s/CoSzjAO66VhKfI2xeirjSBhm2zmu3WVY0/OYiwC7tb1j
	OVR9cdzmOSHXGGzXJLNQkyN0nSqbhMiz2DES6oxTQADA1LkLypK0XBF/BtVetVPVCrdAWZ4nCVf
	o24jsw7KSQmM2276xp1XE9iGgb3mfnC6Xaqevw==
X-Received: by 2002:a17:903:166e:b0:2b0:5cc5:9405 with SMTP id
 d9443c01a7336-2b0a664d289mr425965ad.1.1774302751322; Mon, 23 Mar 2026
 14:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-tools_build_fix_zero_init-v6-0-235858c51af9@arm.com> <20260323-tools_build_fix_zero_init-v6-15-235858c51af9@arm.com>
In-Reply-To: <20260323-tools_build_fix_zero_init-v6-15-235858c51af9@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Mar 2026 14:52:19 -0700
X-Gm-Features: AaiRm50yylCAkONRByCnsK3y21H-MAkFVEhgsvCDA9ssNccOFZGUuoIYZZ9MJLg
Message-ID: <CAP-5=fW9h2qJK5owk9WNohDTvkUX=Of__nunBsRpjrq6VXT8eQ@mail.gmail.com>
Subject: Re: [PATCH v6 15/24] tools: objtool: Append extra host cflags
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 8:15=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append HOST_EXTRACFLAGS to HOSTCFLAGS so that additional flags can be
> applied to the host compiler.
>
> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/objtool/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index b71d1886022e9b3d9fde52bf73bd502aa20d173e..a41fb2a46217bb14fcd8d0941=
c99d102945c3f2d 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -60,6 +60,8 @@ INCLUDES :=3D -I$(srctree)/tools/include \
>             -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
>             -I$(LIBSUBCMD_OUTPUT)/include
>
> +HOSTCFLAGS      +=3D $(HOST_EXTRACFLAGS)

Sashiko noted here (sharing just for common information, not because I
feel this is necessarily making thigs worse) that:
https://sashiko.dev/#/patchset/20260323-tools_build_fix_zero_init-v6-0-2358=
58c51af9%40arm.com

Will this late addition of HOST_EXTRACFLAGS cause a regression by missing t=
he
feature detection checks that run earlier in the Makefile?

The HAVE_XXHASH feature check uses HOSTCFLAGS inside a shell command:

ifeq ($(ARCH_HAS_KLP),y)
  HAVE_XXHASH =3D $(shell printf "$(pound)include
<xxhash.h>\nXXH3_state_t *state;int main() {}" | \
    $(HOSTCC) $(HOSTCFLAGS) -xc - -o /dev/null -lxxhash 2> /dev/null
&& echo y || echo n)
  ifeq ($(HAVE_XXHASH),y)

Because this check is evaluated immediately by the ifeq ($(HAVE_XXHASH),y)
conditional, the shell command executes during the Makefile parsing phase.

Since HOST_EXTRACFLAGS is appended here after the feature checks, the earli=
er
tests will run without these extra flags. If a user provides necessary incl=
ude
paths via HOST_EXTRACFLAGS to locate xxhash.h, the feature test will fail a=
nd
silently disable Kernel Live Patching (BUILD_KLP) support.

Could HOSTCFLAGS be updated earlier in the Makefile, before the feature che=
cks
are evaluated?

Thanks,
Ian

> +
>  OBJTOOL_CFLAGS  :=3D -std=3Dgnu11 -fomit-frame-pointer -O2 -g $(WARNINGS=
)  \
>                    $(INCLUDES) $(LIBELF_FLAGS) $(LIBXXHASH_CFLAGS) $(HOST=
CFLAGS)
>
>
> --
> 2.34.1
>
