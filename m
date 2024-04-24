Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C71F15F406
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Apr 2024 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982207; cv=none; b=VkSCNFy1hq/JB573Vd0mHHZh3trWdofKao/XrCAiyh92eFDQvN5Fn60U/lV6zKNZMEeP+9guXTRH/GPPv2ZoVgfrmA3vIxB7RUvz1bhtwalOJKTpfd6i1HWKnoOUUwnPxr2WyHjAXq/mDlycyKVy37xF8NYiWQsbFjf6OrDfTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982207; c=relaxed/simple;
	bh=jW/Q55tFYbDjApVjeRiSYiCAMWJJXza1aMX93bHT510=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnClXEcxmdkyNkSEdJTnWeerUXNtt82qgnDWFwVcN0/UpkxlcGLQfdXbIaZTHxkFyzkSiHT+a9ah2IqHgDkToHTyzPZ/ceoMvYVVzbxgYXzFuh45bwcIu9+iJp2uoi6T59RGT/8xCDYN3JQ6kkjpM5nz+LNwB01YVkqjuxIMBLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QW+Bi4CO; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QW+Bi4CO"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-434ffc2b520so17761cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Apr 2024 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713982203; x=1714587003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0p7tew2agWpR4bqy2GNP4coWXMPXtcWBzHy2OtkeHU=;
        b=QW+Bi4COtIuCXgUr7kZfIbEl0vXLBMhdIEEAmPplYqi0qOwCPfGKmDbOaag2M0YYEH
         9TF/RpYP4mdani2KGWMD0LUuHwTEfoxQRSneoXgIwnE9e7LfTvxeSMutEEAzdw2g5nGC
         Xv26mMqd5TtkyRGnJ/Q3cr0vuEQ/zVJEeV/TasgrOV193xIJ66aiGehjf4uOUy/uMuL/
         uLKCKUqkdR0CibqQKXJ1LvWzz7sF3yLRf+e6JRlKHsCDp8cteW+0Hs6+8vXDvT5AwkDV
         rrk77kL9LNj4Uf76SbGKUmRDHN9yL+0mvlsKWuf6PsDxA0Ysb29MOaDDYPqBfyPFYDQT
         gK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713982203; x=1714587003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0p7tew2agWpR4bqy2GNP4coWXMPXtcWBzHy2OtkeHU=;
        b=gAUQypG6w8BfEn5FxKfaMToQaEycVVN3ijzBvDtAgiKvIRDkLJEExY7g+yrgWnwyy8
         VhS+8DrIcEe3u3KzOn5wWvzSYksMo50CwcDie4Zm1urJcSjUvQKkEZLho2VJVDCCjBAF
         wT9ZUmC55A/DVzFJt20490YRQnExB4Td8cg8f8ds9tUoI0EBuC6R8OLaFznCOD+Q6VgM
         qfWHdEa5AQwE+e/id/O7P75oZ2j6lCijCcVj86LirK66W/vYcDJoBeyPgnz0K/UcQJHR
         M4ZxzxvRseFHnRGeitVek+FNVarBWD4xiaKj2/f1kJ99wLiIFZD0gOZn+Rb6e3aSMXlu
         GlMw==
X-Forwarded-Encrypted: i=1; AJvYcCW1nmIwk0TVy5xNUgF9EdXR6gCz4s7i21GOYczkNlk0VZynRRIABA2H1jnqhUEpwSdtxabAXDcE5uXsLiy4a46N/Fw5Y5uaSm7D/L5dYFXdiA==
X-Gm-Message-State: AOJu0Yw57nQSyOpGXbvbzhrh1hu7vtuzfK2RKPpIzdSaCr/YggpfciEN
	B9KpUKeP3Q54olaOqzX9vNR6HVNFH0fjhHL/aBf6OU953ArDxHj8FjbxS36u0pUulFGZ0P0jpcU
	Io2UfPFbZOtUrTtjnub2RMVSd7IDZzifvVgQL
X-Google-Smtp-Source: AGHT+IEf1xK91w8EzNnQxjP/YvLQLVL0MX8bH38rlLCAsYIwB/Wz6ve1x9vMseOWLCGw26FrjLwHxWb/DuvT4Zwzs8U=
X-Received: by 2002:ac8:134a:0:b0:437:8ba1:ee1 with SMTP id
 f10-20020ac8134a000000b004378ba10ee1mr9969qtj.5.1713982203329; Wed, 24 Apr
 2024 11:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424001231.849972-1-namhyung@kernel.org>
In-Reply-To: <20240424001231.849972-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Apr 2024 11:09:48 -0700
Message-ID: <CAP-5=fWNWiuiLOKyNHYcuT9xmJkciUBodjCX1E_TRrTMMsM4uw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add a new test for perf annotate
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 5:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Add a basic perf annotate test
>
>   $ ./perf test annotate -vv
>    76: perf annotate basic tests:
>   --- start ---
>   test child forked, pid 846989
>    fbcd0-fbd55 l noploop
>   perf does have symbol 'noploop'
>   Basic perf annotate test
>            : 0     0xfbcd0 <noploop>:
>       0.00 :   fbcd0:       pushq   %rbp
>       0.00 :   fbcd1:       movq    %rsp, %rbp
>       0.00 :   fbcd4:       pushq   %r12
>       0.00 :   fbcd6:       pushq   %rbx
>       0.00 :   fbcd7:       movl    $1, %ebx
>       0.00 :   fbcdc:       subq    $0x10, %rsp
>       0.00 :   fbce0:       movq    %fs:0x28, %rax
>       0.00 :   fbce9:       movq    %rax, -0x18(%rbp)
>       0.00 :   fbced:       xorl    %eax, %eax
>       0.00 :   fbcef:       testl   %edi, %edi
>       0.00 :   fbcf1:       jle     0xfbd04
>       0.00 :   fbcf3:       movq    (%rsi), %rdi
>       0.00 :   fbcf6:       movl    $0xa, %edx
>       0.00 :   fbcfb:       xorl    %esi, %esi
>       0.00 :   fbcfd:       callq   0x41920
>       0.00 :   fbd02:       movl    %eax, %ebx
>       0.00 :   fbd04:       leaq    -0x7b(%rip), %r12   # fbc90 <sighandl=
er>
>       0.00 :   fbd0b:       movl    $2, %edi
>       0.00 :   fbd10:       movq    %r12, %rsi
>       0.00 :   fbd13:       callq   0x40a00
>       0.00 :   fbd18:       movl    $0xe, %edi
>       0.00 :   fbd1d:       movq    %r12, %rsi
>       0.00 :   fbd20:       callq   0x40a00
>       0.00 :   fbd25:       movl    %ebx, %edi
>       0.00 :   fbd27:       callq   0x407c0
>       0.10 :   fbd2c:       movl    0x89785e(%rip), %eax        # 993590 =
<done>
>       0.00 :   fbd32:       testl   %eax, %eax
>      99.90 :   fbd34:       je      0xfbd2c
>       0.00 :   fbd36:       movq    -0x18(%rbp), %rax
>       0.00 :   fbd3a:       subq    %fs:0x28, %rax
>       0.00 :   fbd43:       jne     0xfbd50
>       0.00 :   fbd45:       addq    $0x10, %rsp
>       0.00 :   fbd49:       xorl    %eax, %eax
>       0.00 :   fbd4b:       popq    %rbx
>       0.00 :   fbd4c:       popq    %r12
>       0.00 :   fbd4e:       popq    %rbp
>       0.00 :   fbd4f:       retq
>       0.00 :   fbd50:       callq   0x407e0
>       0.00 :   fbcd0:       pushq   %rbp
>       0.00 :   fbcd1:       movq    %rsp, %rbp
>       0.00 :   fbcd4:       pushq   %r12
>       0.00 :   fbcd0:  push   %rbp
>       0.00 :   fbcd1:  mov    %rsp,%rbp
>       0.00 :   fbcd4:  push   %r12
>   Basic annotate test [Success]
>   ---- end(0) ----
>    76: perf annotate basic tests                                       : =
Ok
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Looks good, thanks for this!

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/annotate.sh | 83 ++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100755 tools/perf/tests/shell/annotate.sh
>
> diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/=
annotate.sh
> new file mode 100755
> index 000000000000..7820d13eebae
> --- /dev/null
> +++ b/tools/perf/tests/shell/annotate.sh
> @@ -0,0 +1,83 @@
> +#!/bin/sh
> +# perf annotate basic tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +shelldir=3D$(dirname "$0")
> +
> +# shellcheck source=3Dlib/perf_has_symbol.sh
> +. "${shelldir}"/lib/perf_has_symbol.sh
> +
> +testsym=3D"noploop"
> +
> +skip_test_missing_symbol ${testsym}
> +
> +err=3D0
> +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +testprog=3D"perf test -w noploop"
> +# disassembly format: "percent : offset: instruction (operands ...)"
> +disasm_regex=3D"[0-9]*\.[0-9]* *: *\w*: *\w*"
> +
> +cleanup() {
> +  rm -rf "${perfdata}"
> +  rm -rf "${perfdata}".old
> +
> +  trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +test_basic() {
> +  echo "Basic perf annotate test"
> +  if ! perf record -o "${perfdata}" ${testprog} 2> /dev/null
> +  then
> +    echo "Basic annotate [Failed record]"
> +    err=3D1
> +    return
> +  fi
> +
> +  # check if it has the target symbol
> +  if ! perf annotate -i "${perfdata}" 2> /dev/null | grep "${testsym}"
> +  then
> +    echo "Basic annotate [Failed missing symbol]"
> +    err=3D1
> +    return
> +  fi
> +
> +  # check if it has the disassembly lines
> +  if ! perf annotate -i "${perfdata}" 2> /dev/null | grep "${disasm_rege=
x}"
> +  then
> +    echo "Basic annotate [Failed missing disasm output]"
> +    err=3D1
> +    return
> +  fi
> +
> +  # check again with a target symbol name
> +  if ! perf annotate -i "${perfdata}" "${testsym}" 2> /dev/null | \
> +         grep -m 3 "${disasm_regex}"
> +  then
> +    echo "Basic annotate [Failed missing disasm output]"
> +    err=3D1
> +    return
> +  fi
> +
> +  # check one more with external objdump tool (forced by --objdump optio=
n)
> +  if ! perf annotate -i "${perfdata}" --objdump=3Dobjdump 2> /dev/null |=
 \
> +         grep -m 3 "${disasm_regex}"
> +  then
> +    echo "Basic annotate [Failed missing disasm output from objdump]"
> +    err=3D1
> +    return
> +  fi
> +  echo "Basic annotate test [Success]"
> +}
> +
> +test_basic
> +
> +cleanup
> +exit $err
> --
> 2.44.0.769.g3c40516874-goog
>
