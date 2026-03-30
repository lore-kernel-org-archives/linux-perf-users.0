Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2613C5DBE
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Mar 2026 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865693; cv=none; b=FgTSVAkcBEw6ZpoxVryWKHGTra9ojpiZrjYffWwExynYo0f5+fXlnAJ93gdzseLtzjXtLWkZ4VNxT+mFcTspUavGZFPnSjGkqsoe0HNy5jQvFBuZU4LzA0vKJCbhFQQMBi+3nEmBlqx6qe0uJxD2aBo1/jAF0j6Vi0s2qZfjqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865693; c=relaxed/simple;
	bh=9Wrh1JV3BrIJfrgFf6V+ewHZCBCzWtok4X0acKzYTNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NT2V0CUmw6ZCYg+p1UZl9e9tpDWef3B/SsJjwQRrqXpFOeRmkqi7rupgl5+snylXcly0yuXoDnmbIDQIuFV8A7SUZyuMSiuXDfVaU7O5f4BpIhwqso0OnMrEZXoS/8vs3C5wdces/GftDWetYf1AsAYZc16BXPX40YcwOhnWgTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F3Xk12oW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3Xk12oW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so30505685e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Mar 2026 03:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774865690; x=1775470490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVdNRbecRXBnCCajaQweiZjJmMTMTROjZrR4HHZnbpg=;
        b=F3Xk12oWARSo5fUoDMT+5chSiiEB7Em1ZZgcPke1H+MAP4hkoKuTPtkJuP69SpPNwj
         irjUwGEucPlELrAEUA3oSSjeInWJ2qqdcxJpG8EIGDTq3pghM54v+0zlD18aeEnahcpk
         t+UIcHjPcbzZxJP/XXrm7tGLm1tGz2yQXuwWgedbBzBKanwnDE6J6qBW792wRsgtuT/Z
         rhIsKy5eaPZNQpUsBrhge9zCBkj54fGOLoMEzO9Sqi2V8pljc5w+JrGP/pgCD4ICX8k+
         vcYkNi3xAWHurG9LybHKGS2q3OoFibxCTEhQ9X/Ur49EIOwO9ULpp6lkm0BmctlmkPot
         iYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774865690; x=1775470490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVdNRbecRXBnCCajaQweiZjJmMTMTROjZrR4HHZnbpg=;
        b=lyslNnlAwftqQ+YcvR3Y8wNykBSj6z7DtGITZw8BpAC+8XztbAlg7sFZL/NrGsM3LK
         lKnLayGIAHdzXN5Iu7Qew5B1PvMzLiOpNzZKk8HlNG17J2OvG+zJDNTq8ZiEJRkTgqYO
         N7KPVKikM0x6TDqiqb/BJZFo8QiSjV8qPPCwwHEE45taIMUHgumjw21svcVHkqnH+OB0
         GrgHGQkWYL+ofagsdNl3onQCrxrkOnOmat/Lm+YEFvzA0aRxb27As+8q3spcxR4L2Pui
         UqUWFmecKmv63lFydLzrmpcSO6rB9CPZh/4ZLqsIW3bEdXL2a8lcMbB1EaMMYNeN8q8v
         BaxA==
X-Gm-Message-State: AOJu0YxSjIlUe36aar7QmlAefDUtt9L9FmkJ/AuhhI7s84BgsM4OuP1W
	4Zqh/zGWJXnnCqeIfo+WdtwWvuRSqn0pn+WOf9VDU9KOF2X2zRft+zt6d1xeT8OICaE=
X-Gm-Gg: ATEYQzx2n2reG5TGeauCMYBRVBOrncpQG7NMdEvcq8EWUipkHHU7+ITOcnbx16VAdaN
	R1A5C2tSHy/lOvMy+W+Q+hoR9dTdTJkQbXQtel1nYZLkU/xtFfSbn5TTkWgHCNl9rDr4DP5eU8B
	b2Ungoi4Bk9OS6cvL4m5m7sD5DDJseQVMXejq3Xd0+y1bmBh5ylh7w0eh+9lyvVbCCp7b9sKCT2
	uNr1VeZkFFVnRoFQy3lwCUi8bnb6Z2ka/zeapT5Ju2QqEfolsvxAlz0S0FYih4IKn4/r9OP9dIP
	57k0l2uW/s+syB3sfleupamd08GV8o26N3Xk7nphQjStHA6+3msR4Whvu/RCfSmw1Bap82P+nW1
	9tn1d4FUGcqXtx9tu81XlfzyoJvDl3VnZlwy0Z3kyTtl0XTywGSwPAi8wvumBOfnCJplcXjETcE
	EcHb1xjrBg6pr53yNE+wzemJtULezt
X-Received: by 2002:a05:600c:a012:b0:480:6bef:63a0 with SMTP id 5b1f17b1804b1-48727ede8d3mr210984595e9.21.1774865689689;
        Mon, 30 Mar 2026 03:14:49 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873069d469sm157181035e9.14.2026.03.30.03.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 03:14:49 -0700 (PDT)
Message-ID: <1f378f98-c5a2-48f8-9e63-0ee1d50b4d4f@linaro.org>
Date: Mon, 30 Mar 2026 11:14:48 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3] perf tests: mmap-basic: fix user rdpmc
 detection logic
To: Qiao Zhao <qzhao@redhat.com>, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, leo.yan@linux.dev, namhyung@kernel.org,
 acme@kernel.org, mpetlan@redhat.com
References: <20260330090003.656540-1-qzhao@redhat.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260330090003.656540-1-qzhao@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/03/2026 10:00 am, Qiao Zhao wrote:
> The mmap-basic test incorrectly determined rdpmc availability in
> several environments, leading to unexpected failures on arm64 and
> other architectures.
> 
> Previously the rdpmc capability decision lived in test_stat_user_read(),
> which caused inconsistent behaviour when:
>   - perf_user_access sysctl state is unknown
>   - architectures expose cap_user_rdpmc differently
>   - arm64 platforms where rdpmc semantics differ from x86
> 
> As suggested during review, move the rdpmc capability decision into
> set_user_read() so that the user_read state and expected behavior
> are decided in a single place.
> 
> Changes in v3:
>   - Moves perf_user_access handling into set_user_read()
>   - Simplify test_stat_user_read() expectation logic
>   - Use unified rdpmc_supported calculation
>   - Handle USER_READ_UNKNOWN consistently
> 
> v2:
> https://lore.kernel.org/linux-perf-users/20260203141608.14128-1-qzhao@redhat.com/
> 
> v1:
> https://lore.kernel.org/linux-perf-users/20260120090522.1193981-1-qzhao@redhat.com/
> 
> Note:
> A potential cleanup around perf_event.h mentioned during review is
> intentionally deferred and will be handled in a follow-up change
> to keep this fix minimal and focused.
> 
> Tested on:
>   - ARM64 (armv8_pmuv3): all mmap-basic user-space counter tests pass
>   - X86(include hybrid): all mmap-basic tests pass
>   - IBM Power9: all mmap-basic tests pass
> 
> Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> ---
>   tools/perf/tests/mmap-basic.c | 55 +++++++++++++++++++++++++----------
>   1 file changed, 39 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index 3313c236104e..3633e7c87dc1 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -185,38 +185,57 @@ static enum user_read_state set_user_read(struct perf_pmu *pmu, enum user_read_s
>   {
>   	char buf[2] = {0, '\n'};
>   	ssize_t len;
> -	int events_fd, rdpmc_fd;
> +	int events_fd, fd;
>   	enum user_read_state old_user_read = USER_READ_UNKNOWN;
>   
>   	if (enabled == USER_READ_UNKNOWN)
>   		return USER_READ_UNKNOWN;
>   
> +	// Try the PMU rdpmc sysfs interface or similar
>   	events_fd = perf_pmu__event_source_devices_fd();
> -	if (events_fd < 0)
> -		return USER_READ_UNKNOWN;
> -
> -	rdpmc_fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
> -	if (rdpmc_fd < 0) {
> +	if (events_fd >= 0) {
> +		fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
> +		if (fd >= 0) {
> +			len = read(fd, buf, sizeof(buf));
> +			if (len == sizeof(buf))
> +				old_user_read = (buf[0] == '1') ?
> +					USER_READ_ENABLED :
> +					USER_READ_DISABLED;
> +
> +			if (enabled != old_user_read) {
> +				buf[0] = (enabled == USER_READ_ENABLED) ? '1' : '0';
> +				len = write(fd, buf, sizeof(buf));
> +				if (len != sizeof(buf))
> +					pr_debug("%s write failed\n", __func__);
> +			}
> +			close(fd);
> +			close(events_fd);

Hi Qiao,

This block that writes to the file is duplicated with the fallback 
below. I think a function for this would be better.

> +			return old_user_read;
> +		}
>   		close(events_fd);
> -		return USER_READ_UNKNOWN;
>   	}
>   
> -	len = read(rdpmc_fd, buf, sizeof(buf));
> -	if (len != sizeof(buf))
> -		pr_debug("%s read failed\n", __func__);
> +	// Fallback: perf_user_access interface (arm64, riscv, or similar)
> +	fd = open("/proc/sys/kernel/perf_user_access", O_RDWR);
> +	if (fd < 0)
> +		return USER_READ_UNKNOWN;
>   
>   	// Note, on Intel hybrid disabling on 1 PMU will implicitly disable on
>   	// all the core PMUs.

This comment isn't in the right place anymore because the fallback never 
works for Intel.

> -	old_user_read = (buf[0] == '1') ? USER_READ_ENABLED : USER_READ_DISABLED;
> +	len = read(fd, buf, sizeof(buf));
> +	if (len == sizeof(buf))
> +		old_user_read = (buf[0] == '1') ?
> +			USER_READ_ENABLED :
> +			USER_READ_DISABLED;
>   
>   	if (enabled != old_user_read) {
>   		buf[0] = (enabled == USER_READ_ENABLED) ? '1' : '0';
> -		len = write(rdpmc_fd, buf, sizeof(buf));
> +		len = write(fd, buf, sizeof(buf));
>   		if (len != sizeof(buf))
>   			pr_debug("%s write failed\n", __func__);
>   	}
> -	close(rdpmc_fd);
> -	close(events_fd);
> +
> +	close(fd);
>   	return old_user_read;
>   }
>   
> @@ -295,12 +314,16 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
>   			goto cleanup;
>   		}
>   
> +#if defined(__aarch64__) || defined(__riscv)
> +		rdpmc_supported = pc->cap_user_rdpmc;
> +#else
>   		if (saved_user_read_state == USER_READ_UNKNOWN)
> -			rdpmc_supported = pc->cap_user_rdpmc && pc->index;
> +			rdpmc_supported = pc->cap_user_rdpmc;
>   		else
>   			rdpmc_supported = (enabled == USER_READ_ENABLED);
> +#endif
>   
> -		if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index)) {
> +		if (rdpmc_supported && !pc->cap_user_rdpmc) {

I still don't really get what this is testing. On Arm we do 
"rdpmc_supported = pc->cap_user_rdpmc" and then test that those 
variables are the same value? And removing the pc->index check has 
affected x86 but this fix is only for Arm and RISC-V.

pc->index needs to be checked on Arm as well for the test to make sense. 
When user reading is enabled "cap_user_rdpmc && pc->index" is true. So 
when we've enabled user reading that should always be true and it should 
always be false in the disabled test. That doesn't seem that different 
to x86.

>   			pr_err("User space counter reading for PMU %s [Failed unexpected supported counter access %d %d]\n",
>   				pmu->name, pc->cap_user_rdpmc, pc->index);
>   			ret = TEST_FAIL;

