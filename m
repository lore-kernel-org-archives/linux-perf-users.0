Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596462E11AA
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763147577; cv=none; b=EmwXbYO2SvJfGooKFgBdOGBbauT/6PTeuuNiOOOnkD9mKoE1ETs9lzBgHdv658c9PcPtHeEUvVon+tf3WNY+nls0mq5b+B7QrMQ9n0Vt5lOP3wpZZ0sVeCUnV0aqpZSjzz/uItZ76uRe6meh50P78kav1T4LSPECLKXYZxIRDlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763147577; c=relaxed/simple;
	bh=+F3OVJ+IEOr15tu96sm8GR3U/EgXEX0j1JW9zr22qLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=F15YlK/ciWOCHeVwL6OjSviU5l+3trVK0TlX0Hsg+52ixjLtBMgICEm5y/qEsIBfiFLp8R9lo2sDHhiz/kpb/9LLBo0w/ktDeLgEKE5vI3GtR79+5aMRSf2tAjKXGbBMeuEhEhqjf1JqcVjgTLZwp4TO90LZvR6oE6LaLz9Oly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7vSoJei; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7vSoJei"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so17119125e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 11:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763147573; x=1763752373; darn=vger.kernel.org;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECLdnz+RzZfBcg21IkQyyzTrn2zfRl3emdrxEYSuK8g=;
        b=Q7vSoJeifWgZ5rdt8AcyNn1nzmxVMMNy4mBx2PJXjHJafn8ZklND2Jz/dGwAB/TPCZ
         XVGjCifk8gVgh94CGkgzY1uKmvXbERW0cSWvpNB2jjZqMHeghm8bhyUpJJcURc1LwJ93
         fGEbhqmbBihlokizXqxLHv8or872V7s6RsaSD0ys+UPF4ggbhmWbg1/i2bQHhOnLADTO
         u82gbBsJPL9odvz7BJghgXwWxRGhEzjz3o5ZGdf63MhE+4qIQcgHoeBgrZFaGX6VHiyy
         OY3jWCSb65H7JLTeZuuIpzSvLzNOXtwsGHnFFSKNkbSKdI08oE7GYMpa7gX6O1FvTWxQ
         aPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763147573; x=1763752373;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECLdnz+RzZfBcg21IkQyyzTrn2zfRl3emdrxEYSuK8g=;
        b=s2R8AvSr0IEGxqBZdZon9Jx2OWy8FX8TRRSnCuKhQJl00HFEq0QU3pC1BkDeJiP1fh
         LFz9YMHMIwZgMm1CPUcDWKhDxPAj491ldmQKROxm7LRYRRArRbrgo/HXmjd1jnvzekbX
         HJgWMvLKKgS7M7tovzm2jYTjUGns56dG3P0MLa03nF4yv/OnV0SBklZOanskijwaQp+x
         c9jE7avPJp+BliCQ5b9S87tI1myYdYDpLAWitFu7kKLI4eVOB2qvmBU8+55PSV8edQyn
         B653UAL9nTTt+wu6ij+ToYowCRh2Nu+1bxSBObLhj3tnh7tVb0SLwcR/cDzdeRcqu+sY
         pJgw==
X-Gm-Message-State: AOJu0YxUqnUAFL0kbbQJFmGYVi8ayVUUWp9CR/WERcXM+pdHpzDqzNpE
	5FlxVyQ4QzauMMTADZVh2WXQOTgb1LetEzf9tzlnfENPm0VK1bhiWMlFfyighSjAfyPeADpFhuO
	G7sI+9/UwZK0y2DPYxDJIXZl4Uv6Ohcyr0/p7las=
X-Gm-Gg: ASbGncvKg/9EkQd5rly/mrw9XZmThIlPj2hPo/JCp5y7xffuHkK4ZEqNNJCxroH9cBp
	ovqsB3s2hALVWZGI7pnHNGXUDAxifq9oAAHpiXy7CIz5+gVrttQ344CcGCgIFOBmowIsRuDNI8n
	/SQmtLYFrl+RGN7q7sLA/AGVFrulhi4SY+1inIcUWAcizvps0g52dNDiuQPv/lXkK6bc8jmgstY
	ZOkFSKzG5i4HgLWYLY0yjrajOkEZfJs2aywOY4Ty90lHBA+ZBIlDsmYBvENFik1qlnz9ct9jgL+
	lomovoylej8hsr7byoWZJdmSe01Nqm7pefsaBXJ7+MH+e5+Cghthee7nvg1nyazNzsJF
X-Google-Smtp-Source: AGHT+IEtlTIOYqyVhdgTiv/aTiBp4oi1wcJRoGRcZNs8Nm5zS/S1Q27IIeSCVKWkLF07gmSYp6JO2LO/63wVz9hLc90=
X-Received: by 2002:a05:6000:2c09:b0:429:d6fa:da32 with SMTP id
 ffacd0b85a97d-42b59398a2dmr3510381f8f.59.1763147573184; Fri, 14 Nov 2025
 11:12:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092914.217533-1-namhyung@kernel.org> <20251114092914.217533-2-namhyung@kernel.org>
In-Reply-To: <20251114092914.217533-2-namhyung@kernel.org>
From: Pablo Galindo Salgado <pablogsal@gmail.com>
Date: Fri, 14 Nov 2025 19:12:42 +0000
X-Gm-Features: AWmQ_blLAuaNhaeLoc_GPqSX5vfQwVPhmY4WXFhV3PUU309qKVuCyNEEwro9WMk
Message-ID: <CAFjbc8FK_qs9XqMEf5k81VRNCNXSyda=VUSuJwp8LALOq8fGvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Add python JIT dump test
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

One important aspect to have in mind here is that Python 3.13 was the
first version to add Perf JIT support. In older versions -Xperf_jit is
a noop. You may want to check for the version in your test and skip if
the running version of Python is lower or alternatively ensure you
always run with 3.13+.

> +
> +SHELLDIR=$(dirname $0)
> +PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXXX)
> +
> +echo "Run python with -Xperf_jit"
> +perf record -k 1 -g --call-graph dwarf -o "${PERF_DATA}" -- python -Xperf_jit ${SHELLDIR}/jitdump-test.py


On Fri, 14 Nov 2025 at 09:29, Namhyung Kim <namhyung@kernel.org> wrote:
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
>   [ perf record: Captured and wrote 1.180 MB /tmp/__perf_test.perf.data.XbqZNm (140 samples) ]
>   Generate JIT-ed DSOs using perf inject
>   Add JIT-ed DSOs to the build-ID cache
>   Check the symbol containing the script name
>   Found 108 matching lines
>   Remove JIT-ed DSOs from the build-ID cache
>   ---- end(0) ----
>    84: python profiling with jitdump                                   : Ok
>
> Cc: Pablo Galindo <pablogsal@gmail.com>
> Link: https://docs.python.org/3/howto/perf_profiling.html#how-to-work-without-frame-pointers
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/jitdump-python.sh | 41 ++++++++++++++++++++++++
>  tools/perf/tests/shell/jitdump-test.py   | 14 ++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100755 tools/perf/tests/shell/jitdump-python.sh
>  create mode 100644 tools/perf/tests/shell/jitdump-test.py
>
> diff --git a/tools/perf/tests/shell/jitdump-python.sh b/tools/perf/tests/shell/jitdump-python.sh
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
> +
> +SHELLDIR=$(dirname $0)
> +PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXXX)
> +
> +echo "Run python with -Xperf_jit"
> +perf record -k 1 -g --call-graph dwarf -o "${PERF_DATA}" -- python -Xperf_jit ${SHELLDIR}/jitdump-test.py
> +
> +_PID=$(perf report -i "${PERF_DATA}" -F pid -q -g none | cut -d: -f1 -s)
> +PID=$(echo -n $_PID)  # remove newlines
> +
> +echo "Generate JIT-ed DSOs using perf inject"
> +perf inject -i "${PERF_DATA}" -j -o "${PERF_DATA}.jit"
> +
> +echo "Add JIT-ed DSOs to the build-ID cache"
> +for F in /tmp/jitted-${PID}-*.so; do
> +  perf buildid-cache -a "${F}"
> +done
> +
> +echo "Check the symbol containing the script name"
> +NUM=$(perf report -i "${PERF_DATA}.jit" -s sym | grep -c jitdump-test.py)
> +
> +echo "Found ${NUM} matching lines"
> +
> +echo "Remove JIT-ed DSOs from the build-ID cache"
> +for F in /tmp/jitted-${PID}-*.so; do
> +  perf buildid-cache -r "${F}"
> +done
> +
> +rm -f ${PERF_DATA} ${PERF_DATA}.jit /tmp/jit-${PID}.dump /tmp/jitted-${PID}-*.so
> +
> +if [ "${NUM}" -eq 0 ]; then
> +    exit 1
> +fi
> diff --git a/tools/perf/tests/shell/jitdump-test.py b/tools/perf/tests/shell/jitdump-test.py
> new file mode 100644
> index 0000000000000000..b427363ae4956db6
> --- /dev/null
> +++ b/tools/perf/tests/shell/jitdump-test.py
> @@ -0,0 +1,14 @@
> +def foo(n):
> +    result = 0
> +    for _ in range(n):
> +        result += 1
> +    return result
> +
> +def bar(n):
> +    foo(n)
> +
> +def baz(n):
> +    bar(n)
> +
> +if __name__ == "__main__":
> +    baz(1000000)
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
