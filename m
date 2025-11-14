Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711EC341ADD
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142276; cv=none; b=HPB8IbM0Dptpem5WQv3NhIT94PaBCZsCv5+eZBciUOICqw2DbOIPzJmcLf6Cp9wUuL9OQhSHZucs6bOLAXWORCp97eh0+LAMNEOKxk4/JGVgImPCjOT0h90nS7RNeRIdqsnK3ANsgkGPD7BO3hVgbHczAoe0Xt14ZImnam8sbkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142276; c=relaxed/simple;
	bh=Hs6I3LV7mgfzgOurOkQDDFPCx7UQeiJNPnOfo9HnLso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fet9/HQ56PHmzyXwGXnCKQXQW3iUlNOKdtxwqhGlTP607cZ65Y1aLSZ6ViEzrJriO/+ziyJUHMm6EfdhKD8d5GDzpFHyGIXrFP69iQcbhU7Hh5eqn7A8464p83NwgZSjJkNmZBNq+ajMkCz7quLOvZlfowT2FiEKrmqoPsiYQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJO0C74y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJO0C74y"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-295c64cb951so4055ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 09:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763142273; x=1763747073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMcA7vDthqd3Ke97trhty+zRH/m+Q9ICA22EAh64cZk=;
        b=lJO0C74yN1tn8etY4ubnQD9xTmWE+FTYQ2QIuvZ3gBEQ2cL3GqwWwE57h1/FpQiT7g
         Ns4/YPDpgAV2iPkbIbrqLHf/5n7uGmx7BPgi4p73A1FjIxZtvn1mfltdLrmG1rf+l4fJ
         gFUoHd6BsEh8xdQEtwSx02NQbupQlzES0sPqebjihQH9FUHvg1HghJJdbqB8yAWGQqCJ
         y9QIGAardElbZA4xNZtkDMMyUDBQdLmvmfr86HA9w7VLmSyju62SVXeyaTYFFOIr4uf/
         KGUSx302onbF6tmCYp9QJ9QZIYLX4M9Z57PF3V0ssJlNuU+sQcvbTEoD3qqfwh9yCh/y
         BIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142273; x=1763747073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FMcA7vDthqd3Ke97trhty+zRH/m+Q9ICA22EAh64cZk=;
        b=uSRir4zEzH+o9lTX+wbJs8U/F+Y47jLgqbcoluRnPvp7B16trEZPejdR9Fdo7V1CAB
         tYR/CauDIu4xNHSJFogNob8wh3o8jpTv8Cl24mrjIss8WIzcFKTHLc5juywL/dhj721L
         4voGlRqSxeQRVy+WQJA3w4cOrfOyj4MIK/UMR76C1XLK7xZRKoP+FtHFUA1X9VJhIetR
         XWIHRgnnE0K3de/jTTnzyNxYtKjYjmB1IQEt03LUVO9hKMk0ypr0pkQJolMn0Y0Xr8S4
         +TnCwuUgPfCunJvuruwqFlmZ5YbtycEAbpzG2qMpC7gbsbdOtOj6FYOBSas7Zv8fRF+K
         80yg==
X-Forwarded-Encrypted: i=1; AJvYcCUY8zkCDo4dcY9qrW/z0JH3muUC8E1q7JyU0zA6sfxvmP9pX4szXwKUvOBpMHc2iG558LXTw+QyxsVuMN9W9Mtm@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJYVCqvHeZm26Y1M81GbtImRrjnp3TdT2hr42SXG86hGnhGuk
	9S8pRFr1lqe8HWOwIg0cyYDwKTHlBqUhsz5LZHd9wKOFH4Wr7an81O3PmKpS3IzQ+Frdguy5vFs
	D70/SbREGCFxpIh0NqQ500rECQ2kyFhht/3w52pUl
X-Gm-Gg: ASbGnctwHEnToFcb93Nk99WJrHZ1rjE90dk3/SzzsefFcrEqC8NwINhAoSHPQRrKxvu
	2tAgP6sH6HRsMaLV0AKze+IKCM82YwQB+nTj4vszzLztHE8djONKfPBYa3BMpAVYaTFSlGvAIUU
	owf0Ma+NVJczCmaQSnidosMx2noEPQnaFK5TacEvELjLdvhi2ImtA/7mJKc7IsiWy4DuvPGHgq0
	Jc73+R5mh5yyDU2izSJRRVWDCgSrodTmRi+HqU/Ha/qnmd68oi/tWfb/Me7lyonUJVpYt4Lm2pI
	3Asqgnt+gOSFmLFm9OM=
X-Google-Smtp-Source: AGHT+IHPQB4mPZVwu3tmUmJXG/t8IM4ABHpXI+Fbw+B+yLrMm4EV4Lr/ERe2ch59sznkWCaNyzNNLYAAeo3XcrqqY+Q=
X-Received: by 2002:a17:903:1cd:b0:290:d7fd:6297 with SMTP id
 d9443c01a7336-29869ac65d6mr4977125ad.2.1763142273057; Fri, 14 Nov 2025
 09:44:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092914.217533-1-namhyung@kernel.org> <20251114092914.217533-2-namhyung@kernel.org>
In-Reply-To: <20251114092914.217533-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 09:44:21 -0800
X-Gm-Features: AWmQ_bkBxRqiWGJJ3zi6HoHwwYN48yvVm0kAuHNr-Wb6g7uL1AbsqX4x1rS1c2U
Message-ID: <CAP-5=fWLGQJ+jdc1kqSo0+wy6AVa2Dm-yp7OX8q+bNw94aV3FA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Add python JIT dump test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Pablo Galindo <pablogsal@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:29=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Add a test case for the python interpreter like below so that we can
> make sure it won't break again.  To validate the effect of build-ID
> generation, it adds and removes the JIT'ed DSOs to/from the build-ID
> cache for the test.
>
>   $ perf test -vv jitdump
>    84: python profiling with jitdump:
>   --- start ---
>   test child forked, pid 214316
>   Run python with -Xperf_jit
>   [ perf record: Woken up 5 times to write data ]
>   [ perf record: Captured and wrote 1.180 MB /tmp/__perf_test.perf.data.X=
bqZNm (140 samples) ]
>   Generate JIT-ed DSOs using perf inject
>   Add JIT-ed DSOs to the build-ID cache
>   Check the symbol containing the script name
>   Found 108 matching lines
>   Remove JIT-ed DSOs from the build-ID cache
>   ---- end(0) ----
>    84: python profiling with jitdump                                   : =
Ok
>
> Cc: Pablo Galindo <pablogsal@gmail.com>
> Link: https://docs.python.org/3/howto/perf_profiling.html#how-to-work-wit=
hout-frame-pointers
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/jitdump-python.sh | 41 ++++++++++++++++++++++++
>  tools/perf/tests/shell/jitdump-test.py   | 14 ++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100755 tools/perf/tests/shell/jitdump-python.sh
>  create mode 100644 tools/perf/tests/shell/jitdump-test.py
>
> diff --git a/tools/perf/tests/shell/jitdump-python.sh b/tools/perf/tests/=
shell/jitdump-python.sh
> new file mode 100755
> index 0000000000000000..101c15e65da1a0c0
> --- /dev/null
> +++ b/tools/perf/tests/shell/jitdump-python.sh
> @@ -0,0 +1,41 @@
> +#!/bin/bash
> +# python profiling with jitdump
> +# SPDX-License-Identifier: GPL-2.0
> +
> +if ! command -v python > /dev/null; then
> +    echo "Skip: no python found"
> +    exit 2
> +fi

Can this just reuse the python set up logic in:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/lib/setup_python.sh?h=3Dperf-tools-next

> +
> +SHELLDIR=3D$(dirname $0)
> +PERF_DATA=3D$(mktemp /tmp/__perf_test.perf.data.XXXXXX)
> +
> +echo "Run python with -Xperf_jit"
> +perf record -k 1 -g --call-graph dwarf -o "${PERF_DATA}" -- python -Xper=
f_jit ${SHELLDIR}/jitdump-test.py

We can avoid an additional file by using the REPL, this is why the
java test is using jshell:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/test_java_symbol.sh?h=3Dperf-tools-next#n41

> +
> +_PID=3D$(perf report -i "${PERF_DATA}" -F pid -q -g none | cut -d: -f1 -=
s)
> +PID=3D$(echo -n $_PID)  # remove newlines
> +
> +echo "Generate JIT-ed DSOs using perf inject"
> +perf inject -i "${PERF_DATA}" -j -o "${PERF_DATA}.jit"

Thomas Richter did a workaround in the Java version to avoid debuginfod que=
ries:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/test_java_symbol.sh?h=3Dperf-tools-next#n59

> +
> +echo "Add JIT-ed DSOs to the build-ID cache"
> +for F in /tmp/jitted-${PID}-*.so; do
> +  perf buildid-cache -a "${F}"
> +done
> +
> +echo "Check the symbol containing the script name"
> +NUM=3D$(perf report -i "${PERF_DATA}.jit" -s sym | grep -c jitdump-test.=
py)
> +
> +echo "Found ${NUM} matching lines"
> +
> +echo "Remove JIT-ed DSOs from the build-ID cache"
> +for F in /tmp/jitted-${PID}-*.so; do
> +  perf buildid-cache -r "${F}"
> +done
> +
> +rm -f ${PERF_DATA} ${PERF_DATA}.jit /tmp/jit-${PID}.dump /tmp/jitted-${P=
ID}-*.so

It'd be nice to have this in a function that also gets run if there is
a trap. It looks like the Java test is missing a call to cleanup_files
on the success path.

Thanks,
Ian

> +
> +if [ "${NUM}" -eq 0 ]; then
> +    exit 1
> +fi
> diff --git a/tools/perf/tests/shell/jitdump-test.py b/tools/perf/tests/sh=
ell/jitdump-test.py
> new file mode 100644
> index 0000000000000000..b427363ae4956db6
> --- /dev/null
> +++ b/tools/perf/tests/shell/jitdump-test.py
> @@ -0,0 +1,14 @@
> +def foo(n):
> +    result =3D 0
> +    for _ in range(n):
> +        result +=3D 1
> +    return result
> +
> +def bar(n):
> +    foo(n)
> +
> +def baz(n):
> +    bar(n)
> +
> +if __name__ =3D=3D "__main__":
> +    baz(1000000)
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
