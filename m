Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E4C22D793
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Feb 2025 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532117; cv=none; b=LNxItccKv2ITPcv/boIseWYHYy5YeH3nZaQAOvi4pM329qgFp6VWTgx1yco+ehLC/PTamBM23POXHXfpk0w7JRBTlDgbm677U+GCj5oPphQ8JhXQk7DULhQmmgISNmWSK9watuNaSvvX2C7rw6oo2YqcHqBILRiWFtq2/EEFUHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532117; c=relaxed/simple;
	bh=ezzyWJr26ZdaaidfyJ5r1M6cNnQSyRgTMfJMLrA1HvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=JclM+Li6vISgPDhd8siLVtj0eokIWdDlHeLOpxIooxKmyAVEwlI3Nzdu2LIe7KTyvggdPbbVt16fMf9oIRA6me8HmIvVPMY5iA9JsKHDoJJdyzJUQX6vyAQhwLasGwMbQwMcHfy1r4sAWRlZPrF8AdZpX7hPWaibTpsgAXr5cwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bGWHLdGq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGWHLdGq"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f31f7731fso29106f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Feb 2025 03:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739532114; x=1740136914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VMB8ghyMQuT+XC9tlI2ESvX9kB+AAQwpREhffrh4yvA=;
        b=bGWHLdGqbhnbIT2GtsHn+UUJmkTt+eip/Hq8hLWL43ne5CkCgHbhnRgHi3ngpEhGk9
         93xkhjX+d1lTq2zMnOB+k2qCgXT5KYEDQPRQYWeP6tcws04QjS6PS38zyZ0AgSHDI1D2
         BMir4LFD8lD7CvjSvdHdeR/bvqlZoXVdoZmwaQt2oUC6W9nnBytogfzEBh2mxsmO2Xrg
         V1iqHNmdweloZ+EjIPO1gaBLgZpaPE404s/+tnIF+CsPY5OEh4e3RclIuTwaGjTqBjq/
         N7L+z8/izpVZCLWH+5yndp/7wiqK1GxojjeHEmibeRcnTXmA0+Iem+en+AK2eP45Pp0/
         z3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739532114; x=1740136914;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMB8ghyMQuT+XC9tlI2ESvX9kB+AAQwpREhffrh4yvA=;
        b=lSzcUA+ea1S6bf5CZTsYs6VgF8hg+lwK++0/6BKJYSWf07uQWzz8BLMEyQDKl7ytLb
         14eAGkPC/npGc0TJ2sIZlTZB6kU0IU+VQJFsvbkBt/8G4K+tNg00wihf/U3Hf9K8hc6A
         C4AjVFGTq1bC41lTI1WTDXzE9cbN7ZYvQ2kbej4m1Jk4e2q9ayvkGdYCFLYrWgBdjcgF
         hn43q1hqAFjDkG9liRs3f5qaQ04KAOqNSakVvBYwwxsxpLBSxoieJv4rHmtpvUe/j/8I
         g+Dt65IfQN0yRzYhG1yEbAF+oL56HYCSIqHml3N3I/koCTEg2iD6e6Fx6LVKrk1CvNwT
         XO5w==
X-Forwarded-Encrypted: i=1; AJvYcCVL4ivhpyHVGziCbU8bl3jKrIbP9nyGYgGhkzFXlQVDA9lUdCKoeSbBHqfEjEHGm8z+BLPqsfW1k18Xwul1dUqo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsyn8z3Fr+9R9mAgw6aF9xXJM9A0g97cb45AHKcrejrRifH53h
	mpazZg4LFrMtgiWfMMOu998LbB89c9Bu7pxp8ERE8xejJTawv9svGS3EfkVkqYk=
X-Gm-Gg: ASbGncu+Pu5p12y96gMgrAUar40xX7sJAA9P13S9kS3azXctBjqqirmnPXnHHr9NEAp
	dXsbuJw/mPl7cu6HlvraBZU2bX/1WpgZCQOp0sViwnlWS+GBpqH1duiMT5RAaaVEEHeMWZKcHef
	12umggd7ew1fMSQqolSV+wBD6LIxI+ewgFIBrheiipYzolYuZNJUBomO9uX8qXzHTFWgYZEbOSA
	bVyLi9gJMDyCc5xLFH5grY6MIgKg0H1sNZo9XBpqF61Lzy7bcNu1YqTh6sY0yZP0K0TGKaqeieD
	7smwmi0Mk4KDmNRHjmVO9Hyqfg==
X-Google-Smtp-Source: AGHT+IHC1K05OWMY1r66dsv/3HqdN4RQ44rdAWDIfnre4gXGKY06JyEB7tot1W+W3P3i5F/tU2MN3Q==
X-Received: by 2002:a5d:6dac:0:b0:38d:c433:a97 with SMTP id ffacd0b85a97d-38dea2ece71mr12206225f8f.47.1739532113922;
        Fri, 14 Feb 2025 03:21:53 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618ab352sm41836795e9.40.2025.02.14.03.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 03:21:53 -0800 (PST)
Message-ID: <aa347f0f-ebd3-4744-9053-14dab87d06b8@linaro.org>
Date: Fri, 14 Feb 2025 11:21:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm64: Fix compilation error
To: Leo Yan <leo.yan@arm.com>
References: <20250214111025.14478-1-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250214111025.14478-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/02/2025 11:10 am, Leo Yan wrote:
> Since the commit dc6d2bc2d893 ("perf sample: Make user_regs and
> intr_regs optional"), the building for Arm64 reports error:
> 
> arch/arm64/util/unwind-libdw.c: In function ‘libdw__arch_set_initial_registers’:
> arch/arm64/util/unwind-libdw.c:11:32: error: initialization of ‘struct regs_dump *’ from incompatible pointer type ‘struct regs_dump **’ [-Werror=incompatible-pointer-types]
>     11 |  struct regs_dump *user_regs = &ui->sample->user_regs;
>        |                                ^
> cc1: all warnings being treated as errors
> make[6]: *** [/home/niayan01/linux/tools/build/Makefile.build:85: arch/arm64/util/unwind-libdw.o] Error 1
> make[5]: *** [/home/niayan01/linux/tools/build/Makefile.build:138: util] Error 2
> arch/arm64/tests/dwarf-unwind.c: In function ‘test__arch_unwind_sample’:
> arch/arm64/tests/dwarf-unwind.c:48:27: error: initialization of ‘struct regs_dump *’ from incompatible pointer type ‘struct regs_dump **’ [-Werror=incompatible-pointer-types]
>     48 |  struct regs_dump *regs = &sample->user_regs;
>        |                           ^
> 
> To fix the issue, use the helper perf_sample__user_regs() to retrieve
> the user_regs.
> 
> Fixes: dc6d2bc2d893 ("perf sample: Make user_regs and intr_regs optional")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/arch/arm64/tests/dwarf-unwind.c | 2 +-
>   tools/perf/arch/arm64/util/unwind-libdw.c  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
> index b2603d0d3737..440d00f0de14 100644
> --- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
> +++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
> @@ -45,7 +45,7 @@ static int sample_ustack(struct perf_sample *sample,
>   int test__arch_unwind_sample(struct perf_sample *sample,
>   		struct thread *thread)
>   {
> -	struct regs_dump *regs = &sample->user_regs;
> +	struct regs_dump *regs = perf_sample__user_regs(sample);
>   	u64 *buf;
>   
>   	buf = calloc(1, sizeof(u64) * PERF_REGS_MAX);
> diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/arch/arm64/util/unwind-libdw.c
> index e056d50ab42e..b89b0a7e5ad9 100644
> --- a/tools/perf/arch/arm64/util/unwind-libdw.c
> +++ b/tools/perf/arch/arm64/util/unwind-libdw.c
> @@ -8,7 +8,7 @@
>   bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
>   {
>   	struct unwind_info *ui = arg;
> -	struct regs_dump *user_regs = &ui->sample->user_regs;
> +	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
>   	Dwarf_Word dwarf_regs[PERF_REG_ARM64_MAX], dwarf_pc;
>   
>   #define REG(r) ({						\

Reviewed-by: James Clark <james.clark@linaro.org>

