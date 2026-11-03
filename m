Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702846;
	b=H9k5n7ro616oTBks2WowayPw1TmfG8GzkeR2X7FdIRCG2jyGwE5V7q3Au0IbRURB+M3O
	 F+nn1iySgS0ogi0nf6R4j8+fxPNuFOv7hujpUhssyHRc5xa6DOC5oWI8zqPOx1EXvI8Pm
	 1afEQwe97k0POcrx9AGN6d1pJD3jbO4aoifQMHWnk69nItoWotbulySKaLEI2+pdsQAZ1
	 x9Y7rfzeaRW1YjqmWCWn3LKjfI7BZIwrTZhUpRAbxb6XA0VDe0U4lvCdZu3PeX07zaeZh
	 zsHYxqs9LXkGc9vqXUdIXw1ckpyICac1IHZ9TeVfeXc2NUhMQK1IYDufRELdXflSUPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702846;
	h=DMARC-Filter:DKIM-Signature:Content-Type:To:Cc:Subject:
	 X-Lms-Return-Path:From:Message-Id:Mime-Version:Date:X-Original-From:
	 In-Reply-To:References:User-Agent:Content-Transfer-Encoding;
	bh=4nQFqetGIINz3bS3DjkIqIu/AbSp7Br0OBHcXNCcZzg=;
	b=aY9MVHwQ5GQfbo5hx9dtOXwzAmwe664coAhijOVyyGYifdY6gt1l7pKhWJkhLdlNE86y
	 5EhGhILeUr4GMizLjStCfWdt1NRIv9jaYgoItyno2Yi9Nvxd3UKzCHawb169SXLBzi4Hu
	 tgZASdZ+6gQfZQ0Ucb5Z6O6Z0rt55KGk7rmb9a33/jtAdnwsM/gqeWYaEBOKKH+m2p3jX
	 hyO5cWVqslFiENksmL2CJ5B9us+JuQFNjQ7N0u3+VpCgyd5xqLzywAJynrVoQbDK6Pw0/
	 FTHlE2xZCPlIEWRRNCaoMKQaZipUcyRCQ6vpwqej3DabzNDJskeWBNIc6MFnWUSGJjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=ThXAPP9p;
	arc=none smtp.remote-ip=209.127.230.114
Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924B606C5BE
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 10:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4924B606C5BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=ThXAPP9p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1793702840; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=4nQFqetGIINz3bS3DjkIqIu/AbSp7Br0OBHcXNCcZzg=;
 b=ThXAPP9pIWIwUQGkgwvt48WcNWzT+o68PfSdlQwYd0bTMTlXkvScGPBVDDQhK56LfNGCYf
 TVXy9oXDIIGS/5VLBCEUcB9nhZiYYeEeetGiowAekQ/oxgM/XbAGFPHPdrrs4y+UH64xnZ
 DfH5OsGnG91wudPLyulYN6HdmQ6XlPilzAqkeySjxDA10n5GFSrCuGlO849IMmruKwyjRY
 CkMy3K1Y4ibPyEx3wx3N23byO4Z/69BfS1rz3/6ja3mDl+vx5eYDCXHAwFzjv15l7iu+St
 jB/gutUBM9kUQCSpqtFwNm3HC/eLLRtCjEmkBeJ4qfIIe8TAav78buE8J7MwmA==
Content-Type: text/plain; charset=UTF-8
To: <sashiko-reviews@lists.linux.dev>
Cc: <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf/riscv: Guard PMU counter indices and user access
X-Lms-Return-Path: <lba+26ae9bbb6+9087df+vger.kernel.org+zhaogongyi@bytedance.com>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Message-Id: <c09a3399-15a2-4931-a858-b4e52c22367b@bytedance.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Date: Tue, 3 Nov 2026 18:47:06 +0800
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
In-Reply-To: <sashiko-outbox-194990@kernel.org>
References: <20261103093709.81605-1-zhaogongyi@bytedance.com> <sashiko-outbox-194990@kernel.org>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: 7bit

Hi,

Thanks for the review.

On 11/3/26 5:57 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] perf/riscv: zero counter count in pmu_sbi_get_ctrinfo() derefs ZERO_SIZE_PTR
> --
> 
> commit 8efed03034c08f98dfc2b34e375ed58087ac3e08
> Author: Zhao Gongyi <zhaogongyi@bytedance.com>
> 
> perf/riscv: Guard PMU counter indices and user access
> 
> This commit adds bounds validation on PMU counter indices before accessing
> counter state or CSR mappings, preventing out-of-bounds accesses when a
> disabled event is mmaped before hw.idx is assigned or when SBI returns
> invalid counter values.
> 

The zero-counter issue predates this patch, since the existing code
also accepts a zero return value and allocates a zero-sized
pmu_ctr_list. However, the reported failure path is valid and is
directly related to the SBI result validation added here.

I will reject zero counter counts in both pmu_sbi_find_num_ctrs() and
pmu_sbi_get_ctrinfo() in v2.

Thanks,
Gongyi
