Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF4D3FB076
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851938; cv=pass; b=G4/VYLLuAP3NCAeKWDZpb/7PQrsYlrCmnDMEH4YEj6qDGNRjoNg+K4SdID6J79Mhg35LSJiFIgIwmZLtz/2F8DgTKsIcUjtnzZjYVVnFtoG8HyLt3TI/Cl5ryEK5LYlh6jY8WDBvoEq1UZpLvWi90XRum7bDYmbdAEdlE8UrDLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851938; c=relaxed/simple;
	bh=pQRo/AIDHbWYmQiKbzY1fu0YoqvFJr3p4qbPZJOQBWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u26uJ9WSxXkA5xUz2ORLHdK7VPfRTlD9nbkS6yq4c46JI8zu4BU0i+LSgzAU+epa48uEPjZBRU40Elr9EwGi+Pl4or/wzwS6QMIHHMDHtTgMm1Hterintm/r0B4k3WwxjB/ldO1Lr4jPH+T5aPe/T3dVr9oBdt32Seo4SjkbzgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sXoQMXd5; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXoQMXd5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b052562254so119555ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 09:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773851936; cv=none;
        d=google.com; s=arc-20240605;
        b=AoYm7UelUfXCnaHCkymVXgU5joutYvueQITH328+K/HFc9ljYnPTjMO666Ll2BzUNA
         shPurZhgJDNcewwLk4+NMbXVpe2w2pB3AksvjsR3D02GZ4EWAcrRpsd4A8xcIMnKxUCS
         4oflXaNezqcxhRX82FwMLhl+Uwi1ZL5xVSTFbwZfCpZcI3ocCNM/ji83ewuec3TPxeaJ
         rd2Mo1ISBO7bWNdthGw0P47RK40bM08k/8z5fjZdQaTW4UybRydpdp1i0QerxENr1WkR
         gIvWGAaUbmHzGzY6OAtwqotbBd8i8h1Ho6JJrEc8hIUx6IjqgOhIv25j3HzKmYktkuAm
         jiOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hcjCxyCQZIThfXRlEgtWrMDq+8GZ2+bJDcg2rHRM0J0=;
        fh=jWqxwEUwFf2KYMSe0N1vdUnCjJ8wkYVwCj31a/1L5rs=;
        b=AKEUCjPjfwPA0h09zSJ/FMPMWZFTH1MTNNn4Ag28KoCcLeHYoYgMvK9YERvk8BXokP
         B/BmcGTlz1liqvS0iaHgN6Bt6DClw5LoNl/gIF4wf2uYcub5fVjGWMDbz3+EBScjErYU
         uEmLyEU1KFyOA9bDN1uG4gCyYMKMRKfikiJCfGRNaTiQvQJ/brhOOT/Q889jpIL7JeP9
         2+80WtBW36WygYiZ2qOYdv92BLhg74EYxFW3OUarjqIn6ZyYD81Lmf+alf8DAbgsPERu
         hbUFXsToCW1m1oay5tHXxPe0OU08g0SIIUi+18Ff+OZMFhnmKbg8djba+pNdPIlyshRb
         /fYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773851936; x=1774456736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcjCxyCQZIThfXRlEgtWrMDq+8GZ2+bJDcg2rHRM0J0=;
        b=sXoQMXd5ZK4ltkomyXip5wfycxB848TA6ndxmvZnfnfoLg0w56TKga3hCE+XmdIpZh
         FiBQln4YgfTJQv+KbxpSj5SGwcJVU9hyK6Vc5HGZeCnYkGu2bBJ9E57e/lB4Au5xXkvs
         knPpw6PcA0xCJ5lJ5wD7EhV57f6HNmz6+Dhyb6C2EieysCmF5ymXG3n/sldNGEzmXn4g
         9SyqPr7w6c3+sxEDBH4+HtJXfk/eQ7hIRNc8Y44m1TZw1Uj+JcekXy139NwDrKYvkrJi
         l9jrm45RauBkDS+4gFQwLJ6BcNOUfpHo6zY4m1llx7bwPK4Za3xxdKr76Qc8S9xntF/q
         LwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851936; x=1774456736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hcjCxyCQZIThfXRlEgtWrMDq+8GZ2+bJDcg2rHRM0J0=;
        b=retvM2Tb0evi95McpQCGML+xEg0N61xrLvMarZCD00In+KUkvi/wFrt3ewwGhZlIyS
         6yaD54cnIV5Ap9JCEmXeCiBWjyd9T5wZkgn/1t0++QS9sEgAZJ64ILvC6aBcO13fInnR
         c5YFWmvv2Vs7xYaF7JCjkGe4y+ohI9m2GujsYjkh2jo2Scts2JETfupmRCPrNsp+6yHe
         kGCD/8jJJyeYqqpkOiPNu6jT3Fc/qsWUOZf653Y2mOpxfbVhy+exZPLADG4vctCyEbEd
         3mUkfvnT9OEB+34aaYseb74+luOwJpyCIBaZjbTlZAphilg5c/kYv5nUqOtvKRTZ6qsY
         H3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjSVtF6BZhESJAaFQ9wgzoU2dTlwV1SvUrsNgP4wYmMTy0rYsQw7OjmojUixG+23h8y3ZM9HsCFtnnrLC2oYea@vger.kernel.org
X-Gm-Message-State: AOJu0YyCG7KOd3/a211HU8Dmnw6p+m2lr7uqnDEEiL9uPwc4nxUju5Bf
	95Oqoi9ZthuVAd5GZLpXXF11K8GrrPlsXjJ1GzbZL7FJ3y6E0mPVHr/6A6DLJEw4QEZHj8r0kG2
	lCojUA5V+oUEDgsgKEvzyR7esZsUMUI2xrhBOwXNB
X-Gm-Gg: ATEYQzzQ7KFyxNWrs6WzgknRDFRn3XMzbhS7MaXfwYI9TFutHwPYzgpKXxdLY34aBHh
	rm0131eiMG33IHR+nD71dJvDaYQ4rsispvkKM0SFmh5tqte1zbY/b08nQnW0ZW6tgc3iGwo41do
	/tXqCvTzr9ZhhVaypC5b2l0gS0DnsMTjlVRLN0ma117m/7H3Iz0F9Co41aX8ahdkcyFiOdeptv5
	yxeMkYdaimvJJUeGyneGsqgwni/wDpHOhJJf8i31dOBAXsiC4U9kxxTOrrd8ALzBom9U0RlnGlv
	AGOSXnhM
X-Received: by 2002:a17:903:22c7:b0:2ae:c566:bd99 with SMTP id
 d9443c01a7336-2b06e88a5f7mr4276635ad.22.1773851935141; Wed, 18 Mar 2026
 09:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-tools_build_fix_zero_init-v5-0-bbeffd8da199@arm.com> <20260318-tools_build_fix_zero_init-v5-6-bbeffd8da199@arm.com>
In-Reply-To: <20260318-tools_build_fix_zero_init-v5-6-bbeffd8da199@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Mar 2026 09:38:43 -0700
X-Gm-Features: AaiRm50hpzLMMjzX6OI5eZpFyBk6BPkQvLc7onrrMNrR4VNp8m3oc-g1ki8itfQ
Message-ID: <CAP-5=fV_ObgCokJ3bKAQBYn-DPrGadGVzqvrzbuy8aEcsfkp8w@mail.gmail.com>
Subject: Re: [PATCH v5 06/26] tools build: Append -fzero-init-padding-bits=all
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

On Wed, Mar 18, 2026 at 2:18=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
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
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/scripts/Makefile.include | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
> index b5ecf137febcae59f506e107a7f2e2ad72f4bef4..a2397ceae512c1bc54adb15cb=
1a111ff34e28e43 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -137,6 +137,36 @@ else
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
> +FLAG_ZERO_INIT :=3D $(call cc-option,-fzero-init-padding-bits=3Dall)
> +override EXTRA_CFLAGS +=3D $(FLAG_ZERO_INIT)

Sashiko [1] noted a possibly unintended consequence of this change for libb=
pf:

Does this override unintentionally drop the default compiler flags for libb=
pf?

Looking at tools/lib/bpf/Makefile, the default compiler flags like -g and -=
O2
are only applied if EXTRA_CFLAGS is undefined:

tools/lib/bpf/Makefile:
ifndef EXTRA_CFLAGS
EXTRA_CFLAGS :=3D -g -O2
endif

Since tools/scripts/Makefile.include unconditionally appends to EXTRA_CFLAG=
S
here, the variable will be defined before tools/lib/bpf/Makefile evaluates =
it.

This causes libbpf to silently drop the default -g and -O2 flags.

While later commits in this series fix this exact issue for
tools/lib/thermal/Makefile, it appears tools/lib/bpf/Makefile was missed.

Thanks,
Ian

[1] https://sashiko.dev/#/patchset/20260318-tools_build_fix_zero_init-v5-0-=
bbeffd8da199%40arm.com

> +HOST_FLAG_ZERO_INIT :=3D $(call host-cc-option,-fzero-init-padding-bits=
=3Dall)
> +override HOST_EXTRACFLAGS +=3D $(HOST_FLAG_ZERO_INIT)
> +
>  ifneq ($(findstring $(MAKEFLAGS), w),w)
>  PRINT_DIR =3D --no-print-directory
>  else
>
> --
> 2.34.1
>
