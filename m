Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7C37D118
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 21:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303031; cv=pass; b=FaTItkfIt/4sPk8Yo6+Iy9+8b0iwFKfzzQfSXBRXksbB5hhBwFONOOAZu+vL+0xheWFioeE/786VXMLCUwIXMnHZjs8J9OSSGAAotQsWSBTGxb9nIWmOtg8Y9ASn8eVWmXeYSuBD3BiNVE87w/YJyDUHTEwMMdHVUde69x/ejsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303031; c=relaxed/simple;
	bh=3HDKDC0lIjXTJkZf5wCHM5TLTGOaJOrpuDL9QRVrxN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWm8IHuKSpLRRpc5i+pVVphD/RH9WNFdDk6DM2feT8X/R58MzdIH5/kamxokBcPo64YYjnBlsy9Wimk71XewDyT16wkduVK6aXJmV7ruw5Xx0DQwCjNMkMD6XchOVgRT3rpDqHbd5R8sXg06LdnS8hiXoqpjCIjy8ybWalnuyiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n0xLtvnQ; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0xLtvnQ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b052ec7176so13125ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 14:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774303028; cv=none;
        d=google.com; s=arc-20240605;
        b=avMQOT04UhaqPKYzskofB+ZsTgodHYQQtrtGuUJzE74AX8MEFv+uxTXH4dfjU3yL68
         E/H9j9OlF8XJC1YMVjQYXFZ3Q0290IFoYZnanlX2eK1+9JLnRYotninqE+EBIXM/+AsD
         qJyLuIFx8xMoHCJ4GFANgMWLqE4RFxecDrU0ayn+2qShQ6gZn5v3vKgzKeXm/xvsr/rH
         Zz20tQHmpYuviCf96sxyb/BjEAA/hycgpDLc1G2i9GlgDTKEQ7UiO8xEV+YxwP2SlcLU
         QqFLPIi9QdjluutUCkmkfAjVm9r87M6j7Us8XQupsQYQF5mehTAhVfjQCiz1c3/npC6S
         Lp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GPXQMzfpmnH00CqVoNsc4m4ItRTdzOmQSngWvXhXTrU=;
        fh=nTf77ZmQnnquWijzMDdTN5cjmexLaNsZ7oIKWKThV8A=;
        b=ENn2pltQ4+YD9+QAse9qi97Um7/q3n144zg8QMxzN7vEMIpNqPtc6VhqSXYn1/Dz3V
         oT/N4SI0pQuQ0NEoXrmTb9rVANnADE7kp8UV5csqdl7eEIxFwKV9rLsReym0KTxFC3bR
         2ct5wd28kj0Z1mk44XMnpJZUkUoAVmLtojk4gbwMElF4MdeJth8LMp7KA+IYs0dHTvJR
         3JbowWjyOMY74AiOqPqqftYTYClJHgCIT+Xcm6x0sYGZi2VEVKoMgyAje8AcdAo4ttZL
         ONAWzqsbLQW2qkT3WYQcNKdoQ7Heee49P1zFcD1lY6NwAfNt44orx7Ny5yhzwoTSaiWG
         LLXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774303028; x=1774907828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPXQMzfpmnH00CqVoNsc4m4ItRTdzOmQSngWvXhXTrU=;
        b=n0xLtvnQiuLwU+BcqKVwFg9mWUk+skirS1+G9tPL9iFk6uIsBVQc0H6oXlDgw8Ise5
         X8ekqLlz2jJYzdeixW5q3E6byLupjMR292w+srfX3uR5k/4QMqtiJ4qjgadmSHXk4C+c
         JiE/Nv/9RH/hszi/TxyCnHpyxfUX/T4faM87AjKm8V7n/aiXYCUkr3Ajfrkf93/s+B3t
         urak7CqNKtRmudomuc0KHuV3PTR2UZwSd3uKkbZRwmdpbkf2AW1Neifgg7BtW+y9Ag+7
         vM8kOWamIKgd28TT7717GCPlmHZWXLfZQLXnubvXOU9lb4l8E7LXo3ZrBupnyZYMPbe9
         xPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303028; x=1774907828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GPXQMzfpmnH00CqVoNsc4m4ItRTdzOmQSngWvXhXTrU=;
        b=WYizzUa40flS21gtatSRQ9MjKD7Q0nYc/xeExvwb9qHlqUkCmIHmm/habrUkRoeCl7
         UUus5PSwmjZbMYs+lEZxJrAU+aIUZ5SYgG9P2DAFrabHdFaVpqQaFiHZnDEj2YLNhVJH
         W+BkbXccj+UEHe1cSLQsxq1neDoDYs94ImzryGNQIrlFgHC0UUatTEMEpmcYDHdUqMk0
         q969/MxLKCCTuv2NIY4tdIpcfTpWylbg5sYJgLAjDntT7fEzSEyPuDBkj5b3yiwSuOLL
         rsRfH8ZSGUOyp9yrYUJM5tXJVvV+21Z8X4MS/RWw67LQXLYTPb5vhvfF12/KfVKTs4EN
         RnHw==
X-Forwarded-Encrypted: i=1; AJvYcCU7leRAsADSeKQEBhJQsLD8Jd9k73tMCEs0nq26X9JTJ0cBsVbR8n1y3z2Hw0Ge7rR90jY980+L6CaeUJhf0S7U@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz0onO+f4e73tnZIE1Dyh3ADP6IwzzRunVjklO30UL26kfDx4z
	e0MTkypxenRtpUYA+EpIdlHZjU6KknXDS983poLJ/sb5IIXYLkcAlhqArRIaSwFRmQo9ulGA0Zl
	rBw5No8U22VYGWp55KMCRHgPWbD0+mYkJWoa0G64F
X-Gm-Gg: ATEYQzwvwY36jHsByaAtAdJ5M9UjEi65hobWR1o4x7jzkyxWglrvIscKyRzxA1LjB3I
	P4hIt1cyP+nOOvHAYRF8Z2RrZWNRatQrUfB/n6QiyemhXW+wUL0taE8pBNymQtroRyN0ZJu+Qm9
	z/KUDi7ie21pxBal0k0ERJRIslN28a5QsU4psC91MkW14oA+JIRmRePT88247SuvmGFA54iuydU
	utDG+KBnSzdJinUqs+TKcwkjXK8SNbdqMDEaMYXjmP4HpwTqPOCf/4TX/2xjotihTXonRNT5uc6
	axT3My9kp7ue2nBJK/G2wgB9I51a2dMU9TVMnA==
X-Received: by 2002:a17:903:120a:b0:2ad:6f9b:3b2e with SMTP id
 d9443c01a7336-2b0a68b2e39mr495165ad.23.1774303027835; Mon, 23 Mar 2026
 14:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-tools_build_fix_zero_init-v6-0-235858c51af9@arm.com>
In-Reply-To: <20260323-tools_build_fix_zero_init-v6-0-235858c51af9@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Mar 2026 14:56:56 -0700
X-Gm-Features: AaiRm53Mbi7zqSsMY0cu3Z1F6OSpsSyLgKtXFt41Q7y5VHPGKQjwCjs0jV7idMM
Message-ID: <CAP-5=fWzqV6fSr1XX9azDKkvu=a3C4k3qDYFFcKh0MpPYK8tUA@mail.gmail.com>
Subject: Re: [PATCH v6 00/24] tools build: Append -fzero-init-padding-bits=all option
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 8:13=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> GCC-15 doesn't guarantee that a {0} initializer clears the whole union [1=
].
> This may cause bugs if data is not intialized properly.
>
> The kernel enabld the -fzero-init-padding-bits=3Dall option to tackle the
> issue, which was merged in commit dce4aab8441d ("kbuild: Use
> -fzero-init-padding-bits=3Dall").
>
> This series propagates the same flag to the tools build.  It uses
> tools/scripts/Makefile.include as the central place to add the
> option to EXTRA_CFLAGS and HOST_EXTRACFLAGS for the CC and HOSTCC
> compilers.  Each project under tools/ appends the variables as needed.
>
> BPF/bpftool related patches will be sent separately, as maintainers
> prefer them to go via the BPF tree.
>
> The changes are organized into three parts:
>
>   Patches 01 =E2=80=93 04: Fixes for thermal build.
>   Patch 05:        Propagate -fzero-init-padding-bits=3Dall to
>                    EXTRA_CFLAGS and HOST_EXTRACFLAGS for the
>                    CC and HOSTCC compilers, respectively.
>   Patches 06 =E2=80=93 24: Apply EXTRA_CFLAGS and HOST_EXTRACFLAGS in
>                    project Makefiles.
>
> The change has been verified:
>
> Test 1: Cross compiling perf
>         host: gcc 15.2.0 (x86_64), target: aarch64-linux-gnu-gcc
>
>   make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- LDFLAGS=3D"-static=
" \
>             -C tools/perf VF=3D1 CORESIGHT=3D1 NO_JEVENTS=3D1 DEBUG=3D1
>
> Test 2: Cross compiling selftest bpf and sched_ext
>         host: gcc 15.2.0 (x86_64), target: aarch64-linux-gnu-gcc
>
>   export ARCH=3Darm64
>   export CROSS_COMPILE=3Daarch64-linux-gnu-
>   make -C tools/testing/selftests/ TARGETS=3D"bpf sched_ext" SKIP_TARGETS=
=3D""
>
> Test 3: Native compiling selftest bpf and sched_ext
>         host: gcc 15.2.0 (x86_64)
>
>   make -C tools/testing/selftests/ TARGETS=3D"bpf sched_ext" SKIP_TARGETS=
=3D""
>
> Test 4: BPF CI test (with BPF patches sent separately)
>
>   https://github.com/kernel-patches/bpf/actions/runs/23439834394
>
> [1] https://gcc.gnu.org/gcc-15/changes.html
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

At some point the AI reviews appear to be increasingly off in the
weeds. I believe the nolibc stuff, read-only file system things, etc.
in:
https://sashiko.dev/#/patchset/20260323-tools_build_fix_zero_init-v6-0-2358=
58c51af9%40arm.com
are not a major concern. Thanks for humoring them, they were able to
consider a far wider impact than I could from a snippet of Makefile.

Thanks,
Ian

> ---
> Changes in v6:
> - Gathered Acked tags (thanks Jonathan!)
> - Left out bpftool patches and will send together with other BPF patches =
(Quentin)
> - Added back complete info in cover (Peter.Z)
> - Link to v5: https://lore.kernel.org/r/20260318-tools_build_fix_zero_ini=
t-v5-0-bbeffd8da199@arm.com
>
> Changes in v5:
> - Gathered Acked tags (thanks Daniel, Namhyung, Benjamin!)
> - Appended HOST_EXTRACFLAGS after KBUILD_HOSTCFLAGS (Ian)
> - Appended CFLAGS for libc-test (Thomas)
> - Left out BPF patches and will send out separately (Alexei)
> - Rebase on v7.0.0-rc4
> - Link to v4: https://lore.kernel.org/r/20260311-tools_build_fix_zero_ini=
t-v4-0-9e35bdb99cb3@arm.com
>
> ---
> Leo Yan (24):
>       tools: lib: thermal: Fix typo
>       tools/thermal: Fix typo
>       tools: lib: thermal: Initialize CFLAGS before including Makefile.in=
clude
>       tools/thermal: Initialize CFLAGS before including Makefile.include
>       tools build: Append -fzero-init-padding-bits=3Dall to extra cflags
>       perf build: Append extra host flags
>       tools build: Append extra host cflags
>       tools: bootconfig: Append extra cflags
>       tools: counter: Append extra cflags
>       tools: dma: Append extra cflags
>       tools: gpio: Append extra cflags
>       tools: hv: Append extra cflags
>       tools: iio: Append extra cflags
>       tools: mm: Append extra cflags
>       tools: objtool: Append extra host cflags
>       tools: power: acpi: Append extra cflags
>       tools: power: x86/intel-speed-select: Append extra cflags
>       tools: sched_ext: Append extra cflags
>       tools: spi: Append extra cflags
>       tools: tracing: Append extra cflags
>       tools: usb: Append extra cflags
>       selftests/hid: Append extra cflags
>       selftests/nolibc: Append extra cflags
>       selftests/sched_ext: Append extra cflags
>
>  tools/bootconfig/Makefile                   |  1 +
>  tools/build/Makefile                        |  6 ++++--
>  tools/counter/Makefile                      |  1 +
>  tools/dma/Makefile                          |  1 +
>  tools/gpio/Makefile                         |  1 +
>  tools/hv/Makefile                           |  1 +
>  tools/iio/Makefile                          |  1 +
>  tools/lib/thermal/Makefile                  | 20 ++++++++++---------
>  tools/mm/Makefile                           |  1 +
>  tools/objtool/Makefile                      |  2 ++
>  tools/perf/Makefile.config                  |  2 +-
>  tools/power/acpi/Makefile.config            |  1 +
>  tools/power/x86/intel-speed-select/Makefile |  1 +
>  tools/sched_ext/Makefile                    |  1 +
>  tools/scripts/Makefile.include              | 30 +++++++++++++++++++++++=
++++++
>  tools/spi/Makefile                          |  1 +
>  tools/testing/selftests/hid/Makefile        |  1 +
>  tools/testing/selftests/nolibc/Makefile     |  7 +++----
>  tools/testing/selftests/sched_ext/Makefile  |  1 +
>  tools/thermal/lib/Makefile                  | 20 ++++++++++---------
>  tools/tracing/latency/Makefile              |  1 +
>  tools/usb/Makefile                          |  1 +
>  22 files changed, 77 insertions(+), 25 deletions(-)
> ---
> base-commit: bfec8e88ff6022b056615ec71506703e7e54de82
> change-id: 20260224-tools_build_fix_zero_init-dc5261bd8b8b
>
> Best regards,
> --
> Leo Yan <leo.yan@arm.com>
>
