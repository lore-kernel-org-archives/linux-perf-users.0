Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B031B0415
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jan 2025 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226426; cv=none; b=Rw5Du1C0Etw5EvR6pFav4SC/AsK+rL9XUNbLlDwf0hez3lHtTW2KC8NTQqrRnvAMgZFv4u42P00CTBVorQpYcqOFu9UC7SHSuOJibw49HJkJF4fXNTu9qOOrvRAkT6NKSQTUicg3LdRcI5ikNvigOrNa7HgYB98Xz1ye0LyyRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226426; c=relaxed/simple;
	bh=JiJ59dIbSg8BMwGYdii+KCyk3SoO/RD5iZOJ276Rbso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDYTgWjce3XJ+TDHjfxFHP+QRT4UUHfg8MZbuuXf5b30Ekr+Orl6B5c1LKSIbjlSF+D1b7FJFxTXzOWNiTe0ZNuyGcdKSRWDfa18zZpBBKSveqvIxGCzFOKNHziACQl2fle2ppfyWtCTR4Fmo18NrCzpw6IBnmU+SrH/Mc/zlAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qz7nHiyc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qz7nHiyc"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38be3bfb045so1160300f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Jan 2025 00:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738226423; x=1738831223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5zjMjP/LPUXmnqwR0OYUyowGGr5DSPAz2cDaxob+RE=;
        b=qz7nHiycr5yZKuQORokxr5vg/48cfCkzetBVAIWNAZAjGyjJ5f6L1cjPKzFQl5yky+
         BS3UQokYEOSbSqZR1O5waIQzPMZVLSJ88nLjmF7DlsOxu+zOgDQBrHokB5z4Qj1zcQrs
         ix9F0Ii/YnTBpBU1IUZCTgVNUmPrLxENiqRA6P8CL38vKCaO+CBjcSKafTQlxwiFV8Cr
         a0KHtRPyBkKwQfveex06+Kg87cHa/Nr34IBfgRfvYt2kqKbbzQcSoaUXc+tOd8UHFjbe
         PA9ov943Hf/ESWBtp0B5eKasE+uNel4TCipriU2eCNhRLwMXWkPSS9qPc4tbbSbCdGYs
         RL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738226423; x=1738831223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5zjMjP/LPUXmnqwR0OYUyowGGr5DSPAz2cDaxob+RE=;
        b=aVApQqSXTBWXbRrzthbfYBgYkXEJTW6bzD18+q82UjmmQWcQ93E6fhCetaUmSV2sGx
         ggvbbg3CyGtLLTgehvz+7y51jS+lWCL2qRbY5re9YlQ+uH1ODHBhCevrSmGp1rN42YOK
         iZubDrDh0uAUrLYfoV9wRrmTUjLV82f9gxc10IafQ3fzfSrBqycTswtz91pO3m6679+R
         O0s3OA+NQxWGcHLbh53AjgOpQwR7qBo8h9wMI5yQbDzhFHdL3YIdgBZl+XqN++J1BVgo
         5rSG0nb9iqByLhbgiZUh9ch6NByQjG5S5ky2uYP1faIkK/uP1ST/QDC4kALuUTfS4/sm
         pUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi5QIblqoPSzQ1w+l1W0tzzSLOcifmwrMaJu2YMw1j8M2SrzhOR9lyIjO8SfuJQO2YICZYA9wEdrZd/qp67xjU@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBUe92vgZekcPqtuatksPByU72STZph+/FE3qqZ36/XizV9mK
	a2Fyj4pJsVCO3SfjTSt1pyL2P0hyVfxf6Sht9djcmgG24M4uUktPgPRRVI4xZnF/OAw9XqULu0r
	lH2o1TWyk+0EMby/uodN+Ka7p6cZpV+u2uZm7
X-Gm-Gg: ASbGncvo+AFmQv6835IRVMyNQFKfUXh9XzU1FNOY2VpzymId8HX7E1dXcUHLZu0dBwv
	Yog9oMgJ5YQKJFJwTqp9FJ3g1UsGECERkTH6+7t5weAhTUxdyB98gnvGNHgZ7+Nyi/jyfDjfxZB
	nlW5s7FqFph5HIKWqbYVTdj7CgWcY=
X-Google-Smtp-Source: AGHT+IEoJ+rSlDzuke2JvbADbiW0vKr4Xk55Wi/Q/eIxGvI4r7agApPnyTloSncexZBowwtAPXxVickXMsySVDOksIw=
X-Received: by 2002:a5d:64e4:0:b0:386:3bde:9849 with SMTP id
 ffacd0b85a97d-38c5a9846cdmr1875667f8f.12.1738226422987; Thu, 30 Jan 2025
 00:40:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129193037.573431-1-irogers@google.com>
In-Reply-To: <20250129193037.573431-1-irogers@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 30 Jan 2025 09:40:10 +0100
X-Gm-Features: AWEUYZmMsKHcGcmyGkj9Vm741ytqm96LYwiVaZJAR832Tgm_7ICzhS8b04qWrzs
Message-ID: <CAH5fLggW1i+eO1hhuHrX-LX7B4=M5a0-dZw4En990fD2biJU1A@mail.gmail.com>
Subject: Re: [PATCH v1] perf symbol: Add rust v0 demangling support
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 8:30=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Implement symbol demangling based on:
> https://doc.rust-lang.org/rustc/symbol-mangling/index.html
>
> Ensure recommended demangling examples match the expectations in the
> documentation.
>
> This was requested by Daniel Xu <dxu@dxuuu.xyz> in:
> https://lore.kernel.org/lkml/jgxfnphfo3nzlfipnuuzdlfc4ehbr2tnh2evz3mdhynd=
6wvrsu@fcz6vrvepybb/
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> This change is on top of the 18 patch v3 series:
> https://lore.kernel.org/lkml/20250122174308.350350-1-irogers@google.com/
> ---
>  tools/perf/tests/Build                   |   1 +
>  tools/perf/tests/builtin-test.c          |   1 +
>  tools/perf/tests/demangle-rust-v0-test.c |  82 +++
>  tools/perf/tests/tests.h                 |   1 +
>  tools/perf/util/Build                    |   1 +
>  tools/perf/util/demangle-rust-v0.c       | 661 +++++++++++++++++++++++
>  tools/perf/util/demangle-rust-v0.h       |   7 +
>  tools/perf/util/symbol-elf.c             |  31 +-
>  8 files changed, 771 insertions(+), 14 deletions(-)
>  create mode 100644 tools/perf/tests/demangle-rust-v0-test.c
>  create mode 100644 tools/perf/util/demangle-rust-v0.c
>  create mode 100644 tools/perf/util/demangle-rust-v0.h
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 165ba84dc93f..d59d88abf0da 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -56,6 +56,7 @@ perf-test-y +=3D genelf.o
>  perf-test-y +=3D api-io.o
>  perf-test-y +=3D demangle-java-test.o
>  perf-test-y +=3D demangle-ocaml-test.o
> +perf-test-y +=3D demangle-rust-v0-test.o
>  perf-test-y +=3D pfm.o
>  perf-test-y +=3D parse-metric.o
>  perf-test-y +=3D expand-cgroup.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index e77bf446e821..16937e7e313a 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -126,6 +126,7 @@ static struct test_suite *generic_tests[] =3D {
>         &suite__maps__merge_in,
>         &suite__demangle_java,
>         &suite__demangle_ocaml,
> +       &suite__demangle_rust,
>         &suite__parse_metric,
>         &suite__expand_cgroup_events,
>         &suite__perf_time_to_tsc,
> diff --git a/tools/perf/tests/demangle-rust-v0-test.c b/tools/perf/tests/=
demangle-rust-v0-test.c
> new file mode 100644
> index 000000000000..ab6613e02c94
> --- /dev/null
> +++ b/tools/perf/tests/demangle-rust-v0-test.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +#include "tests.h"
> +#include "debug.h"
> +#include "demangle-rust-v0.h"
> +#include <linux/kernel.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +static int test__demangle_rust(struct test_suite *test __maybe_unused, i=
nt subtest __maybe_unused)
> +{
> +       int ret =3D TEST_OK;
> +       char *buf =3D NULL;
> +       size_t i;
> +
> +       struct {
> +               const char *mangled, *demangled;
> +       } test_cases[] =3D {
> +               { "_RNvMsr_NtCs3ssYzQotkvD_3std4pathNtB5_7PathBuf3newCs15=
kBYyAo9fc_7mycrate",
> +                 "<std::path::PathBuf>::new" },

I think you would normally not have the < and > here? I usually only
see that when you do <type as trait>.

Alice
