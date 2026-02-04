Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9572DF716
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2026 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198009; cv=none; b=kfQVjcfVpnOU1cH7yivBDzXwnRTB+s6OgbNkN3Jvh+rPWyfpWwqHF+E+1qK8wJ4RRzovpvblNXLsLCRnc8enOioIqdNgVsSp3s+zDg/bRnG8axzqdNNoKe+epEA67uUNSwOz0tf8Bf1GzcI2Q/afhDYdv+ifrMvpTRNHnIf3djQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198009; c=relaxed/simple;
	bh=i+tMwR8PgF4T+hs6r8iJfE3UFr7FIBDyC43bIKljGog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXyOwhhLRRpaLaYndu+QmewEnwqWRLKXKb4INgjhNBTdYXHdlxNYkDnOIdYVFtBxLcuXH2eeb3YC5YUFDjDyxXzaQH+uBzMe2Eqr+jZ9D/bdMCoMFI7BpJ9GV7uOydrXMCx8wtwairhpf97Pd7nNj5MJy8P12+aVGJZkzzpr3jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xnToy6Ol; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnToy6Ol"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-482f454be5bso5526995e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Feb 2026 01:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770198007; x=1770802807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3tJ6Qi8Bz24xLteFtRp4QzJzrwP9HlrIMjD2FnYyI4=;
        b=xnToy6OlPUTnGZASRBNe4m8wYcpRzQj8SDEl/k1n3UTZTrLfG70AWEgS1a4eUNbeMf
         FiEIMzZ5j2uCbLlLi4IymD0Lcvk9pSqGE9GyZGt07gAgY5EHRsKaz4Zb/PPWEFkIkbaw
         19HPNFJRvwDH8j2KjeHXjfSGvZS6H0FBPj/SNkKUn+hdLUBRaYEmWcZQEv8jKMICtjNb
         4ApdSObvyEPIIoYBr1FCSFBmFGXYGlEpUjOwaOVbREXSyTHBuMdWSzShanwcPpYBSTl1
         S7rZuSfv4Cj+DJatNOGIb/FaNGlxv8lEfsoPd4tKIsV/3H7WN38ccBfgeZmnvnZ77H4u
         2X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770198007; x=1770802807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3tJ6Qi8Bz24xLteFtRp4QzJzrwP9HlrIMjD2FnYyI4=;
        b=KaEzyexQwccHT4BmQRsLKfFWUros3uh+SrlLYYYq6K0hBktFhLW3sluEemLzZH//x5
         RI69M6VAIJK5Sb7DZnzultHCyhWPYILGtCKTWa2l24IWjR0xyMo9GB6d10zZaYi1bL6L
         367QvMC0G+LZzel2C7UenGUJKguS8nyRunyCgmu+5HJ5Je0eWqi3iLNrR/n69pHpNta/
         yOLkZOasrLkPBLV7b35Gm34XE7iAe1SdsV7MKz22kGsnw3CpI+zVrkuxe6s8bTlrVw8r
         8UB9/DR4+IPj2hwMQXHycMvnK5msxJczFR3iHsB6I2BDskk+BzKvhlixK3fkRAUkXE09
         a53A==
X-Gm-Message-State: AOJu0YxgzTe2Uxd9vkSVuIsYEXuyBcBQQeLga3eaixzmklfXQ0VjU8l+
	IMeasdZ/1HsLmQ6BfWItjGghIL9+wFzknBhXZ98zfO2sYXfZdfna0tw8jFcOXBs3qiQ=
X-Gm-Gg: AZuq6aJ4KfBYMcofxsYRndEBJwGnLl8Rm8TegUnusXemdt5PxnZHMJG+F9y6Vd8xHwl
	GS+cdQjIYjX0DJ6mNAXOA+vrkA98/129HJ0TAHaN5nGeh2YrkIaL0qE9yi8BeohpndmqAUqNFux
	5XMGGwK0H0m1dm2fxUCXCYuiA8FqszCsnfLOgRYJLWzf9KKK35PIY/ONASmjFqasNmCPOaO5d0r
	IQ4HO+eS9ubFFtbG3m5fkjHy5PeI517zd0QcBwvsWYLYaroiajIaZCsNdUeMdHrlXxmgXd9Z4Sa
	/eQzwEQma3SJYPoPdgSGZsC+zb8n6otxgv3FYDDFVNlXcAlWz/QcGfFCvoG9GNJRgIzNaPTML6k
	TqSsyLDX6kM94yh5WbsBmcaZXb4udZvjDuODA5pKjqTQ2OVQXn/hQCabP3hRfaSZI9ETHnlkob9
	YwIrkG8qtOw2OR5cIG
X-Received: by 2002:a05:600c:3542:b0:480:4a90:1afd with SMTP id 5b1f17b1804b1-4830eab97dfmr29921165e9.0.1770198006902;
        Wed, 04 Feb 2026 01:40:06 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618057f93sm5046844f8f.24.2026.02.04.01.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 01:40:06 -0800 (PST)
Message-ID: <9d7eb5cf-e998-4b77-9b8d-7f0ff6b2da36@linaro.org>
Date: Wed, 4 Feb 2026 09:40:05 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf tests: mmap: skip rdpmc tests when sysfs disabled
To: Qiao Zhao <qzhao@redhat.com>, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, leo.yan@linux.dev, namhyung@kernel.org,
 mpetlan@redhat.com, acme@kernel.org, vincent.weaver@maine.edu
References: <20260203141608.14128-1-qzhao@redhat.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260203141608.14128-1-qzhao@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/02/2026 2:16 pm, Qiao Zhao wrote:
> Some architectures control user-space rdpmc access via sysfs or sysctl,
> for example /proc/sys/kernel/perf_user_access on arm64/riscv or the
> rdpmc attribute under event_source devices on x86_64.
> 
> The mmap-based rdpmc tests currently assume rdpmc availability purely
> based on perf_event configuration, which leads to false failures when
> the system globally disables rdpmc access.
> 
> Introduce a helper to detect rdpmc availability via sysfs and skip
> user space counter reading tests when rdpmc is disabled by the system.
> 
> The check is only applied to USER_READ_ENABLED tests. User-read disabled
> tests continue to run unconditionally, as they validate perf_event mmap
> semantics independent of rdpmc availability.
> 
> Additionally, tighten the unsupported rdpmc check to require a valid
> counter index, avoiding false failures when cap_user_rdpmc is set but
> no counter is assigned.
> 
> v1->v2
> - Check rdpmc availability via sysfs before running USER_READ_ENABLED tests
> - Handle both perf_user_access and rdpmc sysfs interfaces
> - Avoid false failures when cap_user_rdpmc is set but no counter index exists
> 
> Testing:
> - arm64: rdpmc disabled by perf_user_access (tests correctly skipped)
> - x86_64: no behavior change compared to v1
> 
> Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> ---
>   tools/perf/tests/mmap-basic.c | 45 +++++++++++++++++++++++++++++++++--
>   1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index 3313c236104e..67d6d83dbedb 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -220,6 +220,37 @@ static enum user_read_state set_user_read(struct perf_pmu *pmu, enum user_read_s
>   	return old_user_read;
>   }
>   
> +static bool rdpmc_sysfs_enabled(struct perf_pmu *pmu)
> +{
> +	char buf[8];
> +	int events_fd, fd;
> +	ssize_t len;
> +
> +	/* ARM/RISC-V style or similar */
> +	fd = open("/proc/sys/kernel/perf_user_access", O_RDONLY);
> +	if (fd > 0) {
> +		len = read(fd, buf, sizeof(buf));
> +		close(fd);
> +		if (len > 0)
> +			return buf[0] == '1';
> +	}
> +
> +	/* x86_64 style rdpmc file or similar */
> +	events_fd = perf_pmu__event_source_devices_fd();
> +	if (events_fd >= 0) {
> +		fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDONLY);
> +		close(events_fd);
> +		if (fd >= 0) {
> +			len = read(fd, buf, sizeof(buf));
> +			close(fd);
> +			if (len > 0)
> +				return buf[0] == '1';
> +		}
> +	}
> +
> +	return false;
> +}
> +
>   static int test_stat_user_read(u64 event, enum user_read_state enabled)
>   {
>   	struct perf_pmu *pmu = NULL;
> @@ -247,7 +278,7 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
>   		struct perf_evsel *evsel = NULL;
>   		int err;
>   		struct perf_event_mmap_page *pc;
> -		bool mapped = false, opened = false, rdpmc_supported;
> +		bool mapped = false, opened = false, rdpmc_supported, sysfs_enabled;
>   		struct perf_counts_values counts = { .val = 0 };
>   
>   
> @@ -300,6 +331,16 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
>   		else
>   			rdpmc_supported = (enabled == USER_READ_ENABLED);
>   
> +		if (enabled == USER_READ_ENABLED) {
> +			sysfs_enabled = rdpmc_sysfs_enabled(pmu);
> +			if (!sysfs_enabled) {
> +				pr_debug("User space counter reading for PMU %s [Skip rdpmc disabled by sysfs]\n",
> +					pmu->name);
> +				ret = TEST_SKIP;
> +				goto cleanup;
> +			}
> +		}
> +
>   		if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index)) {
>   			pr_err("User space counter reading for PMU %s [Failed unexpected supported counter access %d %d]\n",
>   				pmu->name, pc->cap_user_rdpmc, pc->index);
> @@ -307,7 +348,7 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
>   			goto cleanup;
>   		}
>   
> -		if (!rdpmc_supported && pc->cap_user_rdpmc) {
> +		if (!rdpmc_supported && pc->cap_user_rdpmc && pc->index) {
>   			pr_err("User space counter reading for PMU %s [Failed unexpected unsupported counter access %d]\n",
>   				pmu->name, pc->cap_user_rdpmc);
>   			ret = TEST_FAIL;

Not sure I understand this test, shouldn't it be (pc->cap_user_rdpmc || 
pc->index)? As in, you don't expect either of them to be set if 
!rdpmc_supported. But then it's the exact opposite of the one above so I 
don't think it does anything.

Either way the test now passes or skips properly on Arm:

Tested-by: James Clark <james.clark@linaro.org>


