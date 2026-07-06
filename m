Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4C4302F5
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341877; cv=none; b=Sye4V06hUJtMmgiMG/+suWwQXjqr1TczVNzxQr+bBluhUxvMPyDwIujFHB0hLd76ZVjVKtLpmuYB7XqJATWRE1H1SwyvlNl72Y80O0OlDPqCS8zbuVuE293oGA2ePbd3x3qGEL4aZPKB4qsUXrnkXshdCrjwUw8zwlVg9aMmNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341877; c=relaxed/simple;
	bh=A6J3qZ1+JzJgiX28rP9twI3tGY+ys//pbkUnyVWTm5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJvbwwU4el4WUZ+jh6yVTJZ3J0GzXJWFWgE/VDatyV4My5Pgsp59/lZr90rXXvJmUpxFvGvg+zy9XXZrqe9QpiGlCnL4hm/oEA5nwSoAH46YHZmPt8+2ad+xIbLO16r5ygIhOZTJxe9w1bj10+kwsa5FsZXYO8ec1mbflSYOV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5b3biUh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BR4YPo6+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5b3biUh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BR4YPo6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783341874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSNzVEuRNXjbACmsP0kXVdabmw9oRqyKD7jVej0sPKA=;
	b=g5b3biUhpyvWvrlSQ9tVolZfUuJam5DU0o2jKyLaItjRe+R/dur5m4ciPZqk2h8H2u3RPt
	neG+nN/PdFqRmKQf0MShuZlZevX5Jrh8uUOWUOQyfpbb/F+Vk8CVLVSGt72ebAqYig41Pq
	OFDehZzxj+aEPQ6PIvZ52zcj60U35HA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695--wiyqxMrOWi9hJP9VDogNA-1; Mon, 06 Jul 2026 08:44:31 -0400
X-MC-Unique: -wiyqxMrOWi9hJP9VDogNA-1
X-Mimecast-MFC-AGG-ID: -wiyqxMrOWi9hJP9VDogNA_1783341870
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bf840a69so21964805e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jul 2026 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783341870; x=1783946670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSNzVEuRNXjbACmsP0kXVdabmw9oRqyKD7jVej0sPKA=;
        b=BR4YPo6+9EbYOU8X2ywICAI6hx+uwldn9bSioEJ/+61v1WeDNzBERfeN8gCUXIVj5i
         lzs58AgRZHBiUnJr6GkfWkLuRnf3xlflK1R2TSs2j3GRrrcTo16kYm+wDl6UvmG8lL/i
         HVmBZ3oVH013Uvhot1u8kQEhdgkGG1J037fzjMrlK7ATWOy22Cm+j7cpDFybo4YV4jv+
         E5FC9WUDH5zfFfmJD15Dt0m3jnKyhAaZfI5mxR+qTiB5Ns+tDR8TJyOBHeyE1MeToT2q
         z97jw41WUzJlIe8TTdly2Po1lvD5BdD1BG0X58wh/sUNht1gEnZXV6m3laD8nzKv+I2W
         EJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341870; x=1783946670;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSNzVEuRNXjbACmsP0kXVdabmw9oRqyKD7jVej0sPKA=;
        b=X2R1+3gtFOrghhR5a14T0cTg5EKE2YOMrV41iDAouX+XETzsvylc/Z3xWQwCGeqG9Z
         vSCMHgXratlliEJVvENfnS80MtSERFBGwZ1KeSd7BD9QbdxDKUOHgOFyBl+dU32jIrTK
         Q+IIBSZ094/+PqTElFSmIFvshM+X2FAYE7siZojzk471eBjQZ2T7Ne2S+GJd0d4sQFlQ
         u30Nz72j/llVQkKe7NitKikklorUbADZ8a/rzMy5JD9gCcwfZqRAUvpUEKkB/AnroGla
         URXmSzClFlPeYr3V94hBna9CMvR3i5Dz+z/UXQi7DFycMpmslfxIazbSBlaibXDPTLUY
         4cGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCssrF7gbLD7JRvLkmwbaWP8M40DIoiBcsFNhNVhCMmTQlTVRqVBBv//JP7KuDK96+V30WZ3tf86JEQCtQnT1x@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/lH3Sow1gEUC9bz0kw1O7Hkoq+K+yriLW1ZLjCQk1L6dJkGn
	d+ws3UoVPrBdHXqHSueUQlTQdbxcGgYD4wWOzeuCmobNX/So2JXUXA2VEke8ds04saum/uGjo2L
	8ZDpbhtDTq7r6RbrGQgUd2pZUqAXI0NoxSFWrpjilXkN+Qvw8Spe0vrjIipMbqq+vN3iC8za6h4
	TB+vjd
X-Gm-Gg: AfdE7clu5VDREiwp1tBGpBXq47pUGlwZj+VfnlMvI9rnZJAxc54bXTv1uhDb70/gvhR
	Fsww3Wxr6PV9EGacXXlUaR+BC2Yo+p2hj0mYTejHT5a7ZceqGmj7JAYZfJ/gbyZpgW7CgGO3oKV
	SNb//iNOreYnhVSFwmvMBeIwYZjgApou+qdcMWYHwgvFJ3DZQCSoeV7r8F63qZOY8zZfRHGGCTU
	ILTgeIVGlv+MSfZArU5Sssutdm7v+n1u56EsdibFJNzzD05EYIQjc/jO3U0/SMiYFeqSDy2Xk2h
	q7UvjrBa/JyFMGMTPAOgMKzwjY9q/IX9CXgLyAvd0jHz52WBrq4n7Z8/VDuSBvlYlrl94sk4J13
	gOWjgAaId6LYdsAIxONP66dK7zA9yJ2UEDjB47fOf/RL3dg==
X-Received: by 2002:a05:600c:5297:b0:493:d1e0:a4f1 with SMTP id 5b1f17b1804b1-493deffbf21mr4834425e9.0.1783341869873;
        Mon, 06 Jul 2026 05:44:29 -0700 (PDT)
X-Received: by 2002:a05:600c:5297:b0:493:d1e0:a4f1 with SMTP id 5b1f17b1804b1-493deffbf21mr4834055e9.0.1783341869459;
        Mon, 06 Jul 2026 05:44:29 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdb62d3sm303300755e9.8.2026.07.06.05.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 05:44:28 -0700 (PDT)
Message-ID: <c0a3c830-0b28-47a9-96ee-c0a0f34490eb@redhat.com>
Date: Mon, 6 Jul 2026 14:44:27 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] perf trace: Refactor augmented_raw_syscalls using
 bpf_for
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <cover.1783339165.git.vmalik@redhat.com>
 <fdf56026e442e44b2374119c21babde4910f3b6e.1783339165.git.vmalik@redhat.com>
 <20260706121432.8F39A1F00A3A@smtp.kernel.org>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20260706121432.8F39A1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/26 14:14, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The fallback standard `for` loop will fail to load with `-E2BIG` on older kernels when compiled with Clang 15-18, breaking backward compatibility.
> --
> 
> commit be9035b8b528902be67522e81fa232a2f597b164
> Author: Viktor Malik <vmalik@redhat.com>
> 
> perf trace: Refactor augmented_raw_syscalls using bpf_for
> 
> The commit replaces the standard `for` loop in `augment_sys_enter()` with
> `bpf_for` to fix BPF verifier `-E2BIG` errors on newer Clang versions. It
> drops artificial verifier workarounds in `augment_arg()` that were previously
> added to fix these errors. A fallback standard `for` loop is kept for backward
> compatibility with older kernels lacking `bpf_for`.
> 
>> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> index bc036a348079d..215516df5d2a3 100644
>> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> @@ -440,10 +442,11 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>>   */
>>  static inline int augment_arg(struct syscall_enter_args *args, int i,
>>  			      unsigned int *beauty_map,
>> -			      struct augmented_arg *payload_offset)
>> +			      struct beauty_payload_enter *payload, u64 offset)
>>  {
>> -	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>> -	s64 aug_size, size;
>> +	int index, size, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>> +	struct augmented_arg *payload_offset;
>> +	s64 aug_size;
> 
> [ ... ]
> 
>> -	} else if ((int)size < 0 && size >= -6) { /* buffer */
>> +	} else if (size < 0 && size >= -6) { /* buffer */
> 
> [ ... ]
> 
>> @@ -522,14 +529,30 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>> 	/* copy the sys_enter header, which has the syscall_nr */
>> 	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
>>  
>> -	for (int i = 0; i < 6; i++) {
>> -		written = augment_arg(args, i, beauty_map, (struct augmented_arg *)payload_offset);
>> -		if (written < 0)
>> -			return 1;
>> -		if (written > 0) {
>> -			output += written;
>> -			payload_offset += written;
>> -			do_output = true;
>> +	if (bpf_ksym_exists(bpf_iter_num_new)) {
>> +		bpf_for(i, 0, 6) {
> 
> [ ... ]
> 
>> +	} else {
>> +		for (i = 0; i < 6; i++) {
>> +			written = augment_arg(args, i, beauty_map, payload, output);
> 
> [Severity: Medium]
> Will this fallback standard `for` loop fail to load with `-E2BIG` on older
> kernels when compiled with Clang 15-18?
> 
> Since the `(int)size < 0` cast and `s64 size` verifier workarounds were removed
> from `augment_arg()`, it appears the unrolled loop in this fallback path will
> once again fail the BPF verifier checks when evaluated on kernels older than
> 6.4 (where `bpf_ksym_exists(bpf_iter_num_new)` is false). Could this break
> backward compatibility for `perf trace` on those older kernels?

Oh, right, I guess we need that combination to remain backwards
compatible, too. I'll keep the hack in place, then.

Viktor

> 
>> +			if (written < 0)
>> +				return 1;
>> +			if (written > 0) {
>> +				output += written;
>> +				do_output = true;
>> +			}
>>  		}
>>  	}
> 

