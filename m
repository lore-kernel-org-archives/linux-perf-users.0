Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599060;
	b=dGiXHokmSN+tAwtO47OV1lssGKNfwQdhM7BjYE/zaTILYQOJpUNMnva/qP5DF4gQSUJu
	 Nipi7V14ohWie1hg6HCWK9xAFQXXdWUGVB74gUOENT2ydZTYdHiLXzIPxgXBGF4vjvXJT
	 ToJbVySaILWSPZIWvKe+l4v6XAaYXNuJBS/GhlGRWZXyFePjHPLsUXmjvfwOvNskXYWWI
	 D9jGv9YcPXsMfa/PMGLrQSi9hLkOFjruy5hq3ceN9fzZG0MMGL1sVPB9mzF7MDuYn1uXf
	 VrPfl9tsfTP4OWpgYCwqGye6CcpkfSt0ETxg+xyTjRfHf4NO5XDPP+1/j3+3ZQc/5Yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dBMzagSihcLR+OgRyCjXq3R/npWvu2cSWMevTjvmpMA=;
	b=l94TD8oFgFd8dVAyh+XaFzTUk1NNnNs6J+Er43x33l8p6Ijlo6VL1XYBEo15gBBAG1J1
	 6JV+Q/B8FwSdGfv6KumwnQS12Hfzj9Lry7ui+pAnLdligH99d98ptiANqHp99AWh4S892
	 RO9JyGWcFnGwThNhXr81dFiHYbLcoOFA0saeA9GOoNpKhQoXy++K9KdICbBJATrUx5yhc
	 wWFBb/cuRuB2qvI/B7NchcT885jHXT0l83sf/RYeZAIKCXArqZuzL7yq6ah9EY9ytGIDs
	 vwaYnBJl4Iz4NNG7qNztonEK7Cwrl/r7m/ozqX0JcNiWLJkiney3o59+kb/ZGNH2/kQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WOlWRiXV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D465606A31B
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 16:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D465606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WOlWRiXV
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9f6a16afcso66595ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 09:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792599059; cv=none;
        d=google.com; s=arc-20260327;
        b=iTgS+8kbzrOFXVzZMX9Q/Z9MYmDSvXxmr17okjf+YfTMEIEIFY2xGJqAe8h2+8VHOB
         un9q9JxIJ3QosoykcvaeEHx1EhlQLq7QGeIsC4KbTcdGKWAq/cSuR+RXq8UjVViBWD02
         x98bbmnFHpKCCvoXWg7IkF7u+1VQX8C12qFpRZMt96VIxAWgbShYolrGFBKlTGEBZcHZ
         jfhC8YgjtlWDowaK/n/uU4dUvk8tYI3nkXCjZpZ6McIX0iRNUkR43DXK+L+KawxPFDtS
         4hkYPtHKVbEJUqXUDUD1KqjR2SE0gusBvExtlFlE79a3bhu1c6bfuQuvUEqfGScChYY1
         CMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dBMzagSihcLR+OgRyCjXq3R/npWvu2cSWMevTjvmpMA=;
        fh=skVKCGTy15ctFzdToIGcFjk/2AT33Q/WhUnEtO5AumM=;
        b=bs5Ag4gfd4eQAQhSzDaaZySu8Hxloi5PVAns1xWT3D6fVLThu5icb+tjH91ml5bc2+
         FG8zAgHxRRri4BzAUW5f33yFFNNpZrEobZ7qMpQftuIPVRQInk5n1Lwx31pQk8S3JQVJ
         BcXELxvHTSW7pSAnG7Xs4KsUJpgWP5ftgrPNvF+sUxMoUl/mUGp1+F2aKcQul/W4G+rX
         JS8+JcGHPeyf6C/HoQ7QvN4TiBwabub/d5EZ3jlZvrfZEMTggHark3rW+A9G7Ia/lMxz
         yIPxcBzCvPQKdDGeFHqO8l5DaV9Gwi4I6MgWLr35yzBG33rN5/lpFOK6w0kc/bHwghf0
         l+ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792599059; x=1793203859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dBMzagSihcLR+OgRyCjXq3R/npWvu2cSWMevTjvmpMA=;
        b=WOlWRiXVavEBBM5vAIph0iQUch6mB5PUDFp8xqBWZ6LohrmiMsn2Y7E2HLyhNP/zof
         wf3uLhcaX2N2x4Q7b6lNhyPa6bsx2Zyw9amFhZztMOSxQIC+R7Ur61PS5jjiqUnhsrRA
         gaEuruvHUCI1VtxKi7humVmBR0F4FUZCX1rNDPs0LbsgqBRjCIYETNYDot9PwIIb2iXE
         BI4YOVK7a7qRJHEx5wTHGKW/+PyR73dj6+Q+YuaKg7iseaicGXpQYhNWvsEs/w+sD+Gj
         xXR+AqwZwoGOAxT2OhNn4hIU43mtLUe0QbGquaDfLOV9LL1aEo2d+e6/OAe3XHeLKPf0
         ow2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792599059; x=1793203859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dBMzagSihcLR+OgRyCjXq3R/npWvu2cSWMevTjvmpMA=;
        b=zTOQhPsUhIz4I4SmQibRt7yS7oP2KnMWuapOeztc+KdAEfjMzgMt7+vZ6cY0YjZypl
         ZaVcTTv3l17notnnbXaFOy/lbkZBBMv1AEjKXg+g6Zb7VMM+YqGP+t6HF5zZG37DNMNU
         bVC61f9KXx26Yt6NLEnihNXVAW+7osps1X0q88icAmDUG6x7uBz8ock0TyadqSJRN2sT
         sIqxgnSfP5XC3S/E6TEg9GYYZNrJxg6HVx5wbNK98K2F1lh2v7JzIBC5tvjf43eCS3Ge
         F/4xi1tmNHNrM6gRL7jkZKv+PSAdQWR5EZSN5p/Y/oTGhGUH1HwXBDRrRF1kZ3YlqLWB
         X9Bw==
X-Forwarded-Encrypted: i=1; AKwUvBwMqEAYK/5O1lt4A1SuFhNmC+HIVsZ3ptfJ78tDmDZwG9PTckxepbiL1zFzqRarxgXqq1DKrRpCUovOTWCi8+UG@vger.kernel.org
X-Gm-Message-State: AFq9FYKdblU+ze7ZfwyZO5BTmYkQBMHZS6S25wxVVB+ZrZDvzaqd+Tjl
	7WCcpHRLCpiZolhXVCkLNX/J4re4K/BhbIudPpp8GT4A6aYuJ3nreRpSODPcx+HaiogXp7ai9dr
	g1kb4M/arYMFkYok412o3BFIR0WeC+3AwsbOhnnbLexAAPc0zNCjNPDofWV8=
X-Gm-Gg: AYBFou0sGx2jMn9VGoeYRdRCligB77sVxvDgBgVPMcJaPtpFNtJrhyaiG466HGfWj0q
	WTJnUFSxSFSAoPPA+k69ggFoyh4xF9hS1aBLquLxDY9g6BKHuQOY25BTDtkKZ3bsI8NeFSs4aT9
	5WE1L4nRWv++VvydjOJzFOEGEA3kt7UcVEsXbSD1CIltVOpRUm9NXVh2EFmUDQqAU2m6xFjuEHb
	TMB/o1IxqZiAAIhu//f2k6IDJwwYWBTwtqLPTtP1UOenCN9oQt0s/nMOSZiTcEN+5sb027Y/JU3
	Rhfd/Y+w7NuJFdKAlu3Q1AkBqZ+d08wJgsbcB/QruWIf0MlKqXvUHcaCZWbgWuk/zsVRuT4iJrN
	DHSc1aUBzbsm0cFZ8Rag4GrE4fLK3VS+RnavGaT30heGee30iuonZUhhJANuQb3JYLA==
X-Received: by 2002:a17:902:f606:b0:2e3:981:4cc4 with SMTP id
 d9443c01a7336-2ea1e3c3553mr10748135ad.9.1792599058774; Wed, 21 Oct 2026
 09:10:58 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018133032.24467-1-breno3011alves@gmail.com>
 <20261018134322.26445-1-breno3011alves@gmail.com> <20261018134322.26445-3-breno3011alves@gmail.com>
In-Reply-To: <20261018134322.26445-3-breno3011alves@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Oct 2026 09:10:45 -0700
X-Gm-Features: AclHuK_C5BpDKqLu193wcVkXT5s0qoAMdlZwM9YFf1CsJCDKK7jQ0mXPyuVrBug
Message-ID: <CAP-5=fUs-+Tdv1XNcDX4o=tM_KXh59JuAewVPTsoi8EZia476g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] perf/tests: convert check_*.pl helpers to Python
To: Breno Rodrigues Alves <breno3011alves@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 6:43=E2=80=AFAM Breno Rodrigues Alves
<breno3011alves@gmail.com> wrote:
>
> Faithful re-implementations of the four Perl test helpers in
> tools/perf/tests/shell/common/:
>   - check_all_patterns_found.pl
>   - check_no_patterns_found.pl
>   - check_all_lines_matched.pl
>   - check_errors_whitelisted.pl
>
> Same CLI, same output, same exit codes. All use only the Python
> standard library. TESTLOG_VERBOSITY and TESTLOG_ERR_MSG_MAX_LINES
> environment handling is preserved.
>
> Update all 37 call sites across base_probe/ and base_report/ to
> invoke the .py versions. Update Makefile.perf's install-tests
> target to install *.py files (in addition to *.sh) from
> tests/shell/common/. Remove the four old .pl files.
>
> All four were verified byte-for-byte identical to their Perl
> counterparts on synthetic inputs.
>
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Hi,

The build in perf-tools-next is now running mypy and pylint (when
available) on all python scripts:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/Build?h=3Dperf-tools-next#n100
We disable some options:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next#n317
Applying this patch breaks the build for me because of this and 1
pylint issue. I see:
```
$ make -k -C tools/perf O=3D/tmp/perf12 DEBUG=3D1 all
make: Entering directory '.../tools/perf'
  BUILD:   Doing 'make -j28' parallel build

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                           python-module: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]
...                              libopenssl: [ on  ]
...                                    rust: [ on  ]

  INSTALL libsubcmd_headers
  INSTALL libperf_headers
  TEST    /tmp/perf12/tests/shell/common/check_errors_whitelisted.py.pylint=
_log
  INSTALL libsymbol_headers
  INSTALL libapi_headers
  INSTALL libbpf_headers
************* Module check_errors_whitelisted
tests/shell/common/check_errors_whitelisted.py:13:17: W1514: Using
open without explicitly specifying an encoding (unspecified-encoding)

------------------------------------------------------------------
Your code has been rated at 9.76/10 (previous run: 9.76/10, +0.00)

make[3]: *** [tests/Build:124:
/tmp/perf12/tests/shell/common/check_errors_whitelisted.py.pylint_log]
Error 1
make[3]: Target 'pylint' not remade because of errors.
make[2]: *** [Makefile.perf:690: pylint-tests] Error 2
make[2]: Target 'all' not remade because of errors.
make[1]: *** [Makefile.perf:343: sub-make] Error 2
make[1]: Target 'all' not remade because of errors.
make: *** [Makefile:82: all] Error 2
```

I like the change although the perf tool and kselftests may get merged
through different trees. It may be better to separate the patches.

Thanks,
Ian
