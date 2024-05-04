Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A204803
	for <linux-perf-users@vger.kernel.org>; Sat,  4 May 2024 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782076; cv=none; b=RyIAUE+bI9cYEqg6gMhvK8BqN/N68RyZUorIiCIWSOZczCQETt/1e4mxAuYtoZ6Li/Y75/z1Z4RQWtOJ7Vz/orQCgl5Zm+RtLyyA4iuv2w5/M391uQGMe+8Ekz5PODspm016UvFpiJj2U7KcizfZTdIQYcl0RpWvCtdakmHXmXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782076; c=relaxed/simple;
	bh=4pkLX2tIKtDRJWixipGruzmcNP1Gk2/BdF8vI1u9eY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R7Os9ZEMKWuAGzRw42TKvDKo2E/eBWpBGK0JTeUAfIteyK4ZbjaH1qr6+jX63H7OFftEtjQ0hPtNKoLeJIEU2ubPaXe1XkTa4YlsUne4HaMq5n7BOO4DKHxSuIuTrVcB+LyLwEHTd05CZj0PIp2Vh7+KAie9ia0FS1+vR99s4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SlcIfXUj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SlcIfXUj"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f4472561f1so251154b3a.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 May 2024 17:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714782074; x=1715386874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mExYRTNhcQJivK/lzJ+guJ67JEQzBM0WEToTFcMEnRY=;
        b=SlcIfXUjDkA90YEV9zSyP7CK3HUDB1kgrgTUIIEmVHtED274yWJmXUWrSN0iBIDN52
         nCJnb4popEoROCCZ0cyPSHPRh+HzVBZ+aPV/B1VZFHOimRzhRFDCkmrjQatYdJsXbjde
         xuA3F/jp8ujUgUVQDv4Kp346oDM/jSoqjV1QAaVgRTTI2zRTDCVFLulQEpgwiK9W7+Ai
         w04ER8/g7ViayjzbrLsB6KIxk9HIaNXHkNclEuohcH3sZcGim1EldAABhB+Eo9RVZ//p
         +fIItmd6cCqJkL0tc4oxqy+wGJe+/ooiv95qHpfjsK7CfvkKfno2y7AU9D0UdFnhHtKD
         /6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714782074; x=1715386874;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mExYRTNhcQJivK/lzJ+guJ67JEQzBM0WEToTFcMEnRY=;
        b=bKGfvXu4Unw50yUex7ACXQ0/7M8b7b78/x8PpV+ZjzWgLw/JxoVTFxrPf4vMbvn6rd
         Aesw9XGAzpby4sbRZt3v9DLm3pBt8bQeDgPFt4LK7C6JbQBhaLvPEeAmg8YaYTsJKu/W
         gQu4vt3NHf8uS8JJDm2VnFkYFlY+FOojfbOt3qo/nLT+fr4yg+m7LMr+mPejhYT8ThpO
         xNAEo7LgwYQG7qutf+woP8T/3D4vS4r02twf3QvXU6HVtbGU8nPmtvji9IN0sPGzbZpr
         KbKLSsdqNlYn56sQgl98qKwIRrwtHfm2Lc3MadU3RglR7C1MY1DMxXVZdSycmi4ZcN+a
         gCkg==
X-Forwarded-Encrypted: i=1; AJvYcCVB+y0zLn17AaYYNQFW7z8oT2HPCb1bnOr16EEZaCdGf95P9kM4EVF7MEMoidRM0+A2DqIxgWBUNaqHkmIi4ZTG3STqKD8MW1PR1G0h6qDQCg==
X-Gm-Message-State: AOJu0Yx37jMT36VhRz0umIjKOiM6aPlaZWy29CqTwK6PWNtIzr7ALm+e
	UB0mxrGhPKakkDD3+TC0tGIy/sgg2pePp1AryjJvkwUdao7JQDsiii2gGKJZ/+t6/+gaJKLNWop
	b
X-Google-Smtp-Source: AGHT+IGZf/8IelKf0czmAZbhy0hrD9SWBcxRv4s/ubA/Z/GizLTlA3Rlj38uvnI3jMFEAyUVqxo+Ww==
X-Received: by 2002:a05:6a20:1012:b0:1af:7bc2:fccc with SMTP id gs18-20020a056a20101200b001af7bc2fcccmr4664171pzc.35.1714782073814;
        Fri, 03 May 2024 17:21:13 -0700 (PDT)
Received: from [172.16.0.22] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id j18-20020a056a00175200b006eaa21301a7sm3646412pfc.162.2024.05.03.17.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 17:21:13 -0700 (PDT)
Message-ID: <66b91a63-a953-4bc4-9024-b5b1defa9857@rivosinc.com>
Date: Fri, 3 May 2024 17:21:11 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] perf kvm: Add kvm stat support on riscv
Content-Language: en-US
To: Shenlin Liang <liangshenlin@eswincomputing.com>, anup@brainfault.org,
 atishp@atishpatra.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org
References: <20240422080833.8745-1-liangshenlin@eswincomputing.com>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240422080833.8745-1-liangshenlin@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/24 01:08, Shenlin Liang wrote:
> 'perf kvm stat report/record' generates a statistical analysis of KVM
> events and can be used to analyze guest exit reasons. This patch tries
> to add stat support on riscv.
> 
> Map the return value of trace_kvm_exit() to the specific cause of the
> exception, and export it to userspace.
> 
> It records on two available KVM tracepoints for riscv: "kvm:kvm_entry"
> and "kvm:kvm_exit", and reports statistical data which includes events
> handles time, samples, and so on.
> 
> Cross compiling perf in X86 environment may encounter issues with missing
> libraries and tools. Suggest compiling nativly in RISC-V environment
> 

Indeed. I am able to test the series with native build.
For the entire series:
Tested-by: Atish Patra <atishp@rivosinc.com>


> Simple tests go below:
> 
> # ./perf kvm record -e "kvm:kvm_entry" -e "kvm:kvm_exit"
> Lowering default frequency rate from 4000 to 2500.
> Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
> [ perf record: Woken up 18 times to write data ]
> [ perf record: Captured and wrote 5.433 MB perf.data.guest (62519 samples)
> 
> # ./perf kvm report
> 31K kvm:kvm_entry
> 31K kvm:kvm_exit
> 
> # ./perf kvm stat record -a
> [ perf record: Woken up 3 times to write data ]
> [ perf record: Captured and wrote 8.502 MB perf.data.guest (99338 samples) ]
> 
> # ./perf kvm stat report --event=vmexit
> Event name                Samples   Sample%    Time (ns)     Time%   Max Time (ns)   Min Time (ns)  Mean Time (ns)
> STORE_GUEST_PAGE_FAULT     26968     54.00%    2003031800    40.00%     3361400         27600          74274
> LOAD_GUEST_PAGE_FAULT      17645     35.00%    1153338100    23.00%     2513400         30800          65363
> VIRTUAL_INST_FAULT         1247      2.00%     340820800     6.00%      1190800         43300          273312
> INST_GUEST_PAGE_FAULT      1128      2.00%     340645800     6.00%      2123200         30200          301990
> SUPERVISOR_SYSCALL         1019      2.00%     245989900     4.00%      1851500         29300          241403
> LOAD_ACCESS                986       1.00%     671556200     13.00%     4180200         100700         681091
> INST_ACCESS                655       1.00%     170054800     3.00%      1808300         54600          259625
> HYPERVISOR_SYSCALL         21        0.00%     4276400       0.00%      716500          116000         203638
> 
> Changes from v1->v2:
> - Rebased on Linux 6.9-rc3.
> 
> Changes from v2->v3:
> - Add the missing assignment for 'vcpu_id_str' in patch 2.
> - Remove parentheses that cause compilation errors
> 
> Shenlin Liang (2):
>    RISCV: KVM: add tracepoints for entry and exit events
>    perf kvm/riscv: Port perf kvm stat to RISC-V
> 
>   arch/riscv/kvm/trace.h                        | 67 ++++++++++++++++
>   arch/riscv/kvm/vcpu.c                         |  7 ++
>   tools/perf/arch/riscv/Makefile                |  1 +
>   tools/perf/arch/riscv/util/Build              |  1 +
>   tools/perf/arch/riscv/util/kvm-stat.c         | 79 +++++++++++++++++++
>   .../arch/riscv/util/riscv_exception_types.h   | 35 ++++++++
>   6 files changed, 190 insertions(+)
>   create mode 100644 arch/riscv/kvm/trace.h
>   create mode 100644 tools/perf/arch/riscv/util/kvm-stat.c
>   create mode 100644 tools/perf/arch/riscv/util/riscv_exception_types.h
> 

