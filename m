Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67F3563E2
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216707; cv=none; b=PMhlx0j3cvm3mGurvsJK3ammsAA6HukaC/IhYMGwjtj945u4J2edzHnJkO+IhcRcskr5HnPMeAyRRRGm0sT1bJfCCOmhVxoVuFhkFOuMqJB7kzyOEUKe7afsfJn6oWZdLUqUHmcoScaEKffa8ceLnGH7k4l1dBNTgUdWuoyjCC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216707; c=relaxed/simple;
	bh=jgElorkt8DB4DRZP8ytUF+Gl1IX+6cGum2ZDxITu5uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=aZ+eNoCnNjdKyiL0PHvg/dG57We8FH9GMqghU0yAV9d3AgiALX5fEbh5RXF9xmVxF0i8pqZanD22O7+pUxC/UNTpiRxTTk7EFGfeWq5aAuzXKCvYQDE4j/gdvP7ne+BM0VyCxUCKUhjn5g+E4R9yPduzE/XWI8tVwUHxNHrYfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S4B4+Z1l; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4B4+Z1l"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432dc56951eso1735750f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 03:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768216694; x=1768821494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P8v55bePiqtJd7HWpvJlbHssAQTyEC51w3bUfR4rlEs=;
        b=S4B4+Z1l7A11XQfSme6akuRMOUAcE25d2WLZ6bHKcl0/UyJSIFtdjTkXhr0rFTX1JL
         J2BCxLnOuCDDzePvmyswcTAoHPsCLWVtz0slnvt+LHdunr4Ht9lSe+mXQJuxdWkTSzX7
         lbV2nWUBgedVTuYIDWMYYYf7iyhQrwoAXmW7gt0nTXl0p6oxamsTd5dbk/4tLHxr/jB6
         hGFlZy7+wOnXLTrbZhv4hkd/ytwMxV6BMVjmpfYKngJj56mcbBs5rOZ+Y8CHzIHyQend
         Nr/Wdnz4T2DiONPoq7wNselDxZxPy1a329NQbP5sH80kZeAbKdkV8T6cBPqR414GDx5Y
         w/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768216694; x=1768821494;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8v55bePiqtJd7HWpvJlbHssAQTyEC51w3bUfR4rlEs=;
        b=p3+DYymd/QcGfJErvXYgE1L1QBsS6NQ87+lEyRnBuCunHWRDDoX9UaeM1oZKxOMgcW
         0Gy07h+7ut7wZL+g5Edjxxv9CRdTQRv1gOcLeRUkOm8rBwoppQUmc9SVhEvpXXHZ3QUL
         NSNpb5mPaOAewQHeYZpoGfO1Xd1pDJVqGm+2jp/DJVtrS/P0YquUPmiaAtYZN43VU3bC
         kmmge+5zM64nkz3ifNfwNfBm4Ug84+2kXLT0qXE/0EjU9QJ/SHCn/8HvkMXb8fdSNRtd
         1DztHdkj6hjMMXVtGDbR7pZEgP/KzPtQzsO8WmZhfWPyQduM/iObOPX7pAWquxvZ3unH
         +M8g==
X-Forwarded-Encrypted: i=1; AJvYcCW6H5e+tXqBMPoD7yirPlmNBlib3Y/3AbBCAUddvSABA+1nhJy/l9xL491FN/o3UVGghzcB+eYRw+IYVEtqubnR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsl09hidw0ZK3MEugoiKpwPdW7vIr2G5cE3lJLitWTMeWlCD9+
	ZbyBzN15/Msw9cNue4Iglq5OZMNdWz65zIxMNFdJPCdEVDyz6oJ9hJoaTuWI8GpXs/4=
X-Gm-Gg: AY/fxX4knhUK2k9BmPCWPIGaCz74UlFPnQeAa/BDep2+rSark6z0F8+sA4coo8eWDbh
	U+5WsvozhTpGqLA/whrs3fosSEvVJgSkt7Uw+RbUk1AATI7rnvwYQ2FRo7dyYFVegLMEWzdd22j
	l2IUVn0eNetOFOn6MJSXdFaCb6oqPcxor8Ly0T5yNJQy3P5GQnZncFPKlHCGhhyV4t8E0F3VWcG
	RGa1HfqjDLxOdb6BSim4kQuw0dF6pkWTzN95iLPaBOWGN4FUVfY8vQwdhylk2jawkTl3HgwQZJQ
	H4Y2K25ixFv9LRFaY+uihdktX3HpbtdTOAk8y9NO9wpMMV9ypxLo9vnohl8o01evr2VoIeRm8gw
	pjePNLTqWzsHUwP/7TkG6dyK72aeek09vR47/sj2SMO89RpWfLYbOMOImTQ4Jf4WxThtVUajNq6
	IwYZj+6YL1L9JXW8py
X-Google-Smtp-Source: AGHT+IG10HHtFDDRPfharH8ONQrXQQ1hL5NqxbRjrMWqGGyvJ0wsGRXqQgrTCKYUxrRNQhxwcWfKvg==
X-Received: by 2002:a05:6000:1861:b0:430:f6bc:2f8a with SMTP id ffacd0b85a97d-432c37d2f87mr21023602f8f.47.1768216693861;
        Mon, 12 Jan 2026 03:18:13 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm38494237f8f.8.2026.01.12.03.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 03:18:13 -0800 (PST)
Message-ID: <dbdd0541-0a67-4d61-9ae2-7820920e8f7a@linaro.org>
Date: Mon, 12 Jan 2026 11:18:12 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] perf: Add a libdw addr2line implementation
To: Ian Rogers <irogers@google.com>
References: <20260111041338.1817056-1-irogers@google.com>
Content-Language: en-US
Cc: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Howard Chu <howardchu95@gmail.com>,
 Stephen Brennan <stephen.s.brennan@oracle.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260111041338.1817056-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/01/2026 4:13 am, Ian Rogers wrote:
> addr2line is a performance bottleneck in perf, add a libdw based
> implementation that avoids forking addr2line and caches the decoded
> debug information.
> 
> Allow the addr2line implementation to be picked via the configuration
> file or --addr2line-style with `perf report`.
> 
> Test/fix that inline callchains are properly displayed by perf script.
> 
> An example:
> ```
> $ perf record --call-graph dwarf -e cycles:u -- perf test -w inlineloop 1
> [ perf record: Woken up 132 times to write data ]
> [ perf record: Captured and wrote 32.814 MB perf.data (4074 samples) ]
> $ perf script --fields +srcline
> ...
> perf-inlineloop 1814670 293100.228871:     640004 cpu_core/cycles/u:
>              55a11d6e61ee leaf+0x2e
>    inlineloop.c:21 (inlined)
>              55a11d6e61ee middle+0x2e
>    inlineloop.c:27 (inlined)
>              55a11d6e61ee parent+0x2e (perf)
>    inlineloop.c:32
>              55a11d6e629b inlineloop+0x8b (perf)
>    inlineloop.c:47
>              55a11d69a3bc run_workload+0x5a (perf)
>    builtin-test.c:715
>              55a11d69aa9f cmd_test+0x417 (perf)
>    builtin-test.c:825
>              55a11d6155f5 run_builtin+0xd4 (perf)
>    perf.c:349
>              55a11d61588d handle_internal_command+0xdd (perf)
>    perf.c:401
>              55a11d6159e6 run_argv+0x35 (perf)
>    perf.c:445
>              55a11d615d2f main+0x2cb (perf)
>    perf.c:553
>              7fae3d233ca7 __libc_start_call_main+0x77 (libc.so.6)
>    libc_start_call_main.h:58
>              7fae3d233d64 __libc_start_main_impl+0x84
>    libc-start.c:360 (inlined)
>              55a11d565f80 _start+0x20 (perf)
>    ??:0
> ...
> ```
> 
> v3: Make the caller inline file and line number accurate in the libdw
>      addr2line, rather than using the function's declared location.
>      Fix reference counts in unwind-libdw. Add fixes tag for srcline
>      inline printing.
> 
> v2: Fix bias issue with libdwfl functions. Use cu_walk_functions_at
>      from perf's dwarf-aux to fully walk inline functions. Add testing
>      that inlined functions are shown in the perf script srcline
>      callchain information. Add configurability as to which addr2line
>      style to use.
>      https://lore.kernel.org/lkml/20260110082647.1487574-1-irogers@google.com/
> 
> v1: https://lore.kernel.org/lkml/20251122093934.94971-1-irogers@google.com/
> 
> Ian Rogers (7):
>    perf unwind-libdw: Fix invalid reference counts
>    perf addr2line: Add a libdw implementation
>    perf addr2line.c: Rename a2l_style to cmd_a2l_style
>    perf srcline: Add configuration support for the addr2line style
>    perf callchain: Fix srcline printing with inlines
>    perf test workload: Add inlineloop test workload
>    perf test: Test addr2line unwinding works with inline functions
> 
>   tools/perf/builtin-report.c                 |  10 ++
>   tools/perf/tests/builtin-test.c             |   1 +
>   tools/perf/tests/shell/addr2line_inlines.sh |  47 ++++++
>   tools/perf/tests/tests.h                    |   1 +
>   tools/perf/tests/workloads/Build            |   2 +
>   tools/perf/tests/workloads/inlineloop.c     |  52 +++++++
>   tools/perf/util/Build                       |   1 +
>   tools/perf/util/addr2line.c                 |  20 +--
>   tools/perf/util/config.c                    |   4 +
>   tools/perf/util/dso.c                       |   2 +
>   tools/perf/util/dso.h                       |  11 ++
>   tools/perf/util/evsel_fprintf.c             |   8 +-
>   tools/perf/util/libdw.c                     | 153 ++++++++++++++++++++
>   tools/perf/util/libdw.h                     |  60 ++++++++
>   tools/perf/util/srcline.c                   | 116 ++++++++++++++-
>   tools/perf/util/srcline.h                   |   3 +
>   tools/perf/util/symbol_conf.h               |  10 ++
>   tools/perf/util/unwind-libdw.c              |   7 +-
>   18 files changed, 486 insertions(+), 22 deletions(-)
>   create mode 100755 tools/perf/tests/shell/addr2line_inlines.sh
>   create mode 100644 tools/perf/tests/workloads/inlineloop.c
>   create mode 100644 tools/perf/util/libdw.c
>   create mode 100644 tools/perf/util/libdw.h
> 

I don't see the differences to the other addr2line implementations 
anymore, but only because it falls through to the old ones when libdw 
fails now.

For example when building Perf with LLVM it can't get the line in the 
inlineloop workload, and there's still a few things in libc and other 
system libraries it fails on.

But I think it's fine because it doesn't give the wrong line anymore, it 
just falls through to another working addr2line implementation.


Reviewed-by: James Clark <james.clark@linaro.org>

