Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA511EB9F8
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736245991; cv=none; b=C8M2l3ANBVPZpShfavooVH+JZXN0z3Tp0Q4ha2NO/++sva3nXvi5x0UjGOCtvsbOiUt6hNwcOyqKG5C5f4XzDWyW7mFB5Q/a85sid/Py7678V2/I0Zc1fiUEUDp3hJ1+wGZl6BG3SVvzgDwHQB9SOH4VoaT87+3kb2cxbJRN0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736245991; c=relaxed/simple;
	bh=Cb5uRRn3US5XEl1u5YseoQmZExghVpMDhHyOw7bElZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=KVxk4MH/1GCRt6fG6LYkq0s1AcdJ9MNPrur07stWwc/MCFbbz0pZ3mZGpYMI4r1yvXDkZAQC8y+mju+9CenpujEKuiabqXu77cQC+9shtzm3qYcswsQclGQanS/4nvEIu6Tw7YhnQz9wv7P24xXEjqwzeGGNhhWofHQEJTYv5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+gr0p6P; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+gr0p6P"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso160308475e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 02:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736245985; x=1736850785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RphMn2e4Q1St9vq+rxp1ToCrnuLL1BhPJJ2B2L9l9eg=;
        b=P+gr0p6PdF28GEsf+dsGjFdVXBHiQtY5QhlqrRPwi8vOa7CdUoyeN3j3/o3TfBAO1S
         PRq4J7fNhrc3tAPRAiSnj+g/xF5j2sbn+Eib09V528uHZiHIRlBMQsGvNz3oN8t63Doq
         m/FGKVZ0rzWW4n3FG3WtEHdjpPIL9DIL1BC9hXDDbos1gJNPCxuSEIRPaZ8L9DO6aK/4
         CruTOqvP3QTQnOmYAZeaegS4OVEtIgo/sB8Olm3SUcAXJJ+TXbk60llA81MCSqVidYSS
         sRLTetsVjxq89LYGYNH/E4+ZRkjA9nZ31ygArRZMoLC/kotyQB0xbGmS8SsWhBrWCY7Y
         bDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736245985; x=1736850785;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RphMn2e4Q1St9vq+rxp1ToCrnuLL1BhPJJ2B2L9l9eg=;
        b=sp7FrkSx2AgIZY7HcJ5t6qHd05W1u0ds0QqwazDb5J+OE7RLOos6/UMTa9IQRZJvSk
         vNLk2mawRanRaFR/JBgnrz9rFy/NLP7r3+nG0+8lDBLpI98i7pzqA2bUU6KIuaB/gWXK
         NIF7e5QiNZjngN9hTn3G6tVvmkOxr9XP+cXXI+ETApq6fphvweV2QkIckhK2pq6pX3y4
         j1iqipv69bPmzu+Fb7iHmXZgYT6+8CuSCB0BlAoYr2fkwCeM5bp/6CdGfgYU/Dn4RP4W
         XifIqbem2sul+TUhe3ZF/IqJcvAYFXyaZeSOZTda3lh+aUBQrB7yhUx0W1vjEwzYAzhK
         oKpg==
X-Forwarded-Encrypted: i=1; AJvYcCVoz6mAdD7wpgF10ngGHgE8iCaXeR/jkcETFcCXh3UmCMyJSniLrrQYOvZwNRTmol01zSAVrGWk7MvAGh0UsNGd@vger.kernel.org
X-Gm-Message-State: AOJu0YyiyHu84L8yCKIGHwO7FZ/ki6nHXw6T4F9cdbUEU6KyDUouYogt
	5BKYSqoK7QoDhyQUGUhBmLlIzgy0PnLnueDAIyWMaeD3SVsman4ZL0OvHzD7sw2Cfh5N3dQkAno
	4
X-Gm-Gg: ASbGncsFA8D0A1xU+oiZH0lHfimy9QkduEflMGgeig8Tsu7t1Qs9nGyjPDX1wmT108c
	hz+FYTwsxq9dWQrbSIT59UWGuIy+7PCs40ebheUpcX2fi3rsEP2HKxMA+/a1CpZfuBetmreSs/L
	ecbM+3Qs2SvITbn00/ppqHQeV7gYbE7OZla2G8Be9p/DHTjPotbZ2FclbP/n3yIr9FjeSUzbaQb
	e4Pi8N1ZqoHgLeEG9PkJMAAqMfuavFdlSk+b+r4raSBgX8EJp0ry/HtrW0mlfFC4V4=
X-Google-Smtp-Source: AGHT+IF4cAbFaDuFO0ANbdGTWbKd/5vdEOwE/yFqLusfL+kY9On8ee5PWPU2n+94M9LSgLICckwu0A==
X-Received: by 2002:a05:600c:1f8f:b0:436:30e4:459b with SMTP id 5b1f17b1804b1-4368a8b6a2emr430163255e9.18.1736245985256;
        Tue, 07 Jan 2025 02:33:05 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436612008casm595653245e9.14.2025.01.07.02.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 02:33:04 -0800 (PST)
Message-ID: <576a50c8-9ca2-4e2f-9bd8-7d9be4862920@linaro.org>
Date: Tue, 7 Jan 2025 10:33:03 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tools build: Fix a number of Wconversion warnings
To: Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@arm.com>
References: <20250106215443.198633-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250106215443.198633-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/01/2025 9:54 pm, Ian Rogers wrote:
> There's some expressed interest in having the compiler flag
> -Wconversion detect at build time certain kinds of potential problems:
> https://lore.kernel.org/lkml/20250103182532.GB781381@e132581.arm.com/
> 
> As feature detection passes -Wconversion from CFLAGS when set, the
> feature detection compile tests need to not fail because of
> -Wconversion as the failure will be interpretted as a missing
> feature. Switch various types to avoid the -Wconversion issue, the
> exact meaning of the code is unimportant as it is typically looking
> for header file definitions.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

What's the plan for errors in #includes that we can't modify? I noticed 
the Perl feature test fails with -Wconversion but can be fixed by 
disabling the warning:

   #pragma GCC diagnostic push
   #pragma GCC diagnostic ignored "-Wsign-conversion"
   #pragma GCC diagnostic ignored "-Wconversion"
   #include <EXTERN.h>
   #include <perl.h>
   #pragma GCC diagnostic pop

Not sure why it needs both those things to be disabled when I only 
enabled -Wconversion, but it does.

> ---
>   tools/build/feature/test-backtrace.c           | 2 +-
>   tools/build/feature/test-bpf.c                 | 2 +-
>   tools/build/feature/test-glibc.c               | 2 +-
>   tools/build/feature/test-libdebuginfod.c       | 2 +-
>   tools/build/feature/test-libdw.c               | 2 +-
>   tools/build/feature/test-libelf-gelf_getnote.c | 2 +-
>   tools/build/feature/test-libelf.c              | 2 +-
>   tools/build/feature/test-lzma.c                | 2 +-
>   8 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/build/feature/test-backtrace.c b/tools/build/feature/test-backtrace.c
> index e9ddd27c69c3..7962fbad6401 100644
> --- a/tools/build/feature/test-backtrace.c
> +++ b/tools/build/feature/test-backtrace.c
> @@ -5,7 +5,7 @@
>   int main(void)
>   {
>   	void *backtrace_fns[10];
> -	size_t entries;
> +	int entries;
>   
>   	entries = backtrace(backtrace_fns, 10);
>   	backtrace_symbols_fd(backtrace_fns, entries, 1);
> diff --git a/tools/build/feature/test-bpf.c b/tools/build/feature/test-bpf.c
> index 727d22e34a6e..e7a405f83af6 100644
> --- a/tools/build/feature/test-bpf.c
> +++ b/tools/build/feature/test-bpf.c
> @@ -44,5 +44,5 @@ int main(void)
>   	 * Test existence of __NR_bpf and BPF_PROG_LOAD.
>   	 * This call should fail if we run the testcase.
>   	 */
> -	return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
> +	return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr)) == 0;

Seems a bit weird to invert some of the return values rather than doing 
!= 0, but as you say, the actual values seem to be unimportant.

Reviewed-by: James Clark <james.clark@linaro.org>

>   }
> diff --git a/tools/build/feature/test-glibc.c b/tools/build/feature/test-glibc.c
> index 9ab8e90e7b88..20a250419f31 100644
> --- a/tools/build/feature/test-glibc.c
> +++ b/tools/build/feature/test-glibc.c
> @@ -16,5 +16,5 @@ int main(void)
>   	const char *version = XSTR(__GLIBC__) "." XSTR(__GLIBC_MINOR__);
>   #endif
>   
> -	return (long)version;
> +	return version == NULL;
>   }
> diff --git a/tools/build/feature/test-libdebuginfod.c b/tools/build/feature/test-libdebuginfod.c
> index da22548b8413..823f9fa9391d 100644
> --- a/tools/build/feature/test-libdebuginfod.c
> +++ b/tools/build/feature/test-libdebuginfod.c
> @@ -4,5 +4,5 @@
>   int main(void)
>   {
>   	debuginfod_client* c = debuginfod_begin();
> -	return (long)c;
> +	return !!c;
>   }
> diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
> index 2fb59479ab77..aabd63ca76b4 100644
> --- a/tools/build/feature/test-libdw.c
> +++ b/tools/build/feature/test-libdw.c
> @@ -9,7 +9,7 @@ int test_libdw(void)
>   {
>   	Dwarf *dbg = dwarf_begin(0, DWARF_C_READ);
>   
> -	return (long)dbg;
> +	return dbg == NULL;
>   }
>   
>   int test_libdw_unwind(void)
> diff --git a/tools/build/feature/test-libelf-gelf_getnote.c b/tools/build/feature/test-libelf-gelf_getnote.c
> index 075d062fe841..e06121161161 100644
> --- a/tools/build/feature/test-libelf-gelf_getnote.c
> +++ b/tools/build/feature/test-libelf-gelf_getnote.c
> @@ -4,5 +4,5 @@
>   
>   int main(void)
>   {
> -	return gelf_getnote(NULL, 0, NULL, NULL, NULL);
> +	return gelf_getnote(NULL, 0, NULL, NULL, NULL) == 0;
>   }
> diff --git a/tools/build/feature/test-libelf.c b/tools/build/feature/test-libelf.c
> index 905044127d56..2dbb6ea870f3 100644
> --- a/tools/build/feature/test-libelf.c
> +++ b/tools/build/feature/test-libelf.c
> @@ -5,5 +5,5 @@ int main(void)
>   {
>   	Elf *elf = elf_begin(0, ELF_C_READ, 0);
>   
> -	return (long)elf;
> +	return !!elf;
>   }
> diff --git a/tools/build/feature/test-lzma.c b/tools/build/feature/test-lzma.c
> index 78682bb01d57..b57103774e8e 100644
> --- a/tools/build/feature/test-lzma.c
> +++ b/tools/build/feature/test-lzma.c
> @@ -4,7 +4,7 @@
>   int main(void)
>   {
>   	lzma_stream strm = LZMA_STREAM_INIT;
> -	int ret;
> +	lzma_ret ret;
>   
>   	ret = lzma_stream_decoder(&strm, UINT64_MAX, LZMA_CONCATENATED);
>   	return ret ? -1 : 0;

