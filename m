Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5113CC7DF
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jul 2026 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078755; cv=none; b=uN9w1VhVZJdhZq18XOQ50cIMAQtxqoLD/BInaQ2dw2t+m0ESBoZ1vhM/PR4V2TxIonWh09i9l+D+Mc0uPc8DgUu1S8cQPlaZQzTxOFj2pRSxGc6uPSkxj0FcYmVUxKJU0S1xiolzAa+vaozSduhuH/cH8vEenKq74xuRYFEWm5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078755; c=relaxed/simple;
	bh=HTuWxujs7lhBqsGN8sDhd5w5xbwAqpF+EezVu1G84XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEG3PrmCMI2miGjecNI4r8ymh3VpKLtrQapn108qi7whSC79Xljr45NnhnFHhc0ohH7FlFlUnU2utxd+mtdqXeWC5rwOOolpv5iBV3OJQs/uwQk6QTVwSZgBFg6FiNIdmo1BTFDvkB744nu0e87SHX3qg+Y/rbd1TPRHvdk6CLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhMFQx+D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gi97/jix; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhMFQx+D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gi97/jix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783078753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OLchXC5VTZDu4RU5sMVkomKCaHx+xb1Y8HfxV81VH8=;
	b=WhMFQx+DwB+ZY1ezXUAVYW/tvIkR9dYdEVRALk2Mii7U24A2L7RoZ8zsksLu0RL4wM40qv
	m3Xmfrd89d1xQTwmvUz+7VzRLGdASbT56HuJ5zudRL+ahcEmM+PLCcBTncKCxyziNTpWa1
	+x6+hNfVj49048QEJsNBdCffxxNP+SQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74--EVPi_GoNqazZYiEgsUazA-1; Fri, 03 Jul 2026 07:39:12 -0400
X-MC-Unique: -EVPi_GoNqazZYiEgsUazA-1
X-Mimecast-MFC-AGG-ID: -EVPi_GoNqazZYiEgsUazA_1783078751
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493caa3c54eso4610045e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jul 2026 04:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783078751; x=1783683551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OLchXC5VTZDu4RU5sMVkomKCaHx+xb1Y8HfxV81VH8=;
        b=Gi97/jixKKpDElTaSqTpLVOFs3di98zoem+wEyb01J3WXehUztIIZYMPrFIuMTzkZe
         zqHbITnTidLE9pMJ/gX7LADY7bhpDoLgUSJPxLG6iyeJLNZhqtR4RWv2g/Z458W1VF4T
         j4dgJgj95BIjIrtdidHl85bXvsmkSduoaJ4yZLmM54KA/o7Vx0L6ZlIVQZOMbyjFZTvR
         PF582WcC/XoNCDW1MOJc4veDiSwTtUjliRTQKfOAblDDLef2NphIgbWZVurlvgFXpOjT
         2YIK3nk/Tp9zbewoEJIKq5gLKqizzTotuvnXqPLDbKh6O/Cty+aAw6cMLC1AwSHOlhmn
         dGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783078751; x=1783683551;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OLchXC5VTZDu4RU5sMVkomKCaHx+xb1Y8HfxV81VH8=;
        b=DgE+DC+r0ZtmCzDB7qPUuclF/cCQZRQaKqLPCLc0yIyfCRYimy6j/RevoixhtE3NQZ
         +tAB6HpXFSYAqtbZZSt8CaVxBUleOeJw6i0qJ/cFdEUYZldBOPY1HKN80uq8EgpiZVMX
         m+G05RmiTXDNIuITXGj8HPV24jXRuPhUXg1f8F73P27+nlJ/H0jE4k+HltFYc9R2Bin2
         BtWK33PloQWjKEuoDPCryd5cACmTtOeu35NGPLVNUpS3XVbdmiEu3YlSoQkbMDv8rRrH
         xLoXjCY6Sjf3cFwK1g9PqO4MT5lk9g32Pp88aqkAVP2D7oXtgYXqpMHVa4TJ8TBfR7uC
         3lAw==
X-Gm-Message-State: AOJu0Yyw+DsrSWbyik9fq/uPfLjPKr90LY4fI52NbkGRkLLpzsiAF/b8
	+5OaMR7DW87+b8vJ8BLwnrU+R27ik7hgiLKgzyXJcbDNPU9UFTE0xQi8Ex8ncpQ2GjoWS78VAXB
	1ihwYw2nDrBCQNSi4OSHsZ+wSZlMC1A0NP/XgZ2QK8Skk+EQYiPp/puJCqFf2OcKAmiHz/A==
X-Gm-Gg: AfdE7cnvTQyl9c4X7zldQJa0qFM0ccdfv0PHD0XhqTZxe3OYp1BE48IX/xW4zarKpZD
	7UlEDiebVSY0Wt/ypn7CS5FjftSvHAx9DgoZOKluui10xWIebfIJdS4dUvFm7Sin6MTP1MnTEe3
	iWwBFBVAjDtEODPZ8+xCZT+JT6DLrrPWCNXUpSyF2SkvGq/0Mp9wGM4cmoqf/t+iPwkUcvlli2s
	idyHssGrnONg9LYZiCYHOFp1R98hwlhRH1zSDg7JVSqoy8TaPdBHQwpwNjoB74YVxr8hT8/0jgt
	R2TLKcZkq+1Rqh01xt4wKPi13k+ermxABYoysRvfYToW2UK+3O58+eapehMDQJgP45peiw8RfWu
	CQRaWhMBz9S3u9dR/D7YXVL5XAkJWCy/GM3UL0BAz
X-Received: by 2002:a05:600c:63d5:b0:493:b87c:c87d with SMTP id 5b1f17b1804b1-493c2b4c910mr94562725e9.11.1783078750889;
        Fri, 03 Jul 2026 04:39:10 -0700 (PDT)
X-Received: by 2002:a05:600c:63d5:b0:493:b87c:c87d with SMTP id 5b1f17b1804b1-493c2b4c910mr94562505e9.11.1783078750512;
        Fri, 03 Jul 2026 04:39:10 -0700 (PDT)
Received: from [192.168.0.199] (adsl-dyn37.91-127-59.t-com.sk. [91.127.59.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c636ec8asm106968465e9.1.2026.07.03.04.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 04:39:10 -0700 (PDT)
Message-ID: <f6ac51ab-318d-4a00-9e97-e76d0f86122a@redhat.com>
Date: Fri, 3 Jul 2026 13:39:08 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf trace: Refactor augmented_raw_syscalls using
 bpf_for
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <cover.1783070132.git.vmalik@redhat.com>
 <8ceb8f3323d0742163c42c343eb9d26843fe9e9b.1783070132.git.vmalik@redhat.com>
 <20260703104554.CAE821F000E9@smtp.kernel.org>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20260703104554.CAE821F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/26 12:45, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Removing the `(int)` cast in the buffer augmentation condition makes it unconditionally false, completely breaking buffer payload collection.
> - [Medium] Huge buffer sizes (where the MSB is set) fail to be augmented, whereas previously they were safely clamped to `TRACE_AUG_MAX_BUF`.
> - [Low] Multi-line comment does not follow the required BPF subsystem style.
> --
> 
> commit 0a122bc3ab16635b5165b20566e6e1890cba855b
> Author: Viktor Malik <vmalik@redhat.com>
> 
> perf trace: Refactor augmented_raw_syscalls using bpf_for
> 
> This commit replaces the standard loop in augment_sys_enter with a bpf_for
> loop to prevent BPF verifier -E2BIG errors. It also drops some workarounds
> previously added to help the verifier.
> 
>> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> index cbdd5ce19a2f6..60babc06f3812 100644
>> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> 
> [ ... ]
> 
>> @@ -464,11 +473,13 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>>  	} else if (size > 0 && size <= value_size) { /* struct */
>>  		if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
>>  			augmented = true;
>> -	} else if ((int)size < 0 && size >= -6) { /* buffer */
>> +	} else if (size < 0 && size >= -6) { /* buffer */
> 
> [Severity: High]
> Does removing the (int) cast make this condition unconditionally false?
> 
> Since size is an s64 assigned from an unsigned int beauty_map[i], a negative
> marker (e.g. 0xFFFFFFFF) is zero-extended to a positive s64 value.
> Without the (int) cast to truncate and sign-extend it back, size < 0 is
> always false, breaking buffer payload collection.

Correct, size should have been made int. Will fix that.

>>  		index = -(size + 1);
>>  		barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>>  		index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
>> -		aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
>> +		aug_size = args->args[index];
>> +		if (aug_size > TRACE_AUG_MAX_BUF)
>> +			aug_size = TRACE_AUG_MAX_BUF;
> 
> [Severity: Medium]
> Will huge buffer sizes (where the most significant bit is set) fail to be
> augmented here?
> 
> args->args[index] is an unsigned long. If the most significant bit is set,
> assigning it to the s64 aug_size makes it negative. The subsequent
> if (aug_size > TRACE_AUG_MAX_BUF) is a signed comparison and will evaluate
> to false. The length remains negative, causing the later if (aug_size > 0)
> check to fail, skipping buffer processing entirely instead of clamping it.

Yeah, the original version was better, will revert to that.

>>  
>>  		if (aug_size > 0) {
>>  			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
> 
> [ ... ]
> 
>> @@ -521,14 +530,29 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>  	/* copy the sys_enter header, which has the syscall_nr */
>>  	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
>>  
>> -	for (int i = 0; i < 6; i++) {
>> -		written = augment_arg(args, i, beauty_map, payload_offset);
>> -		if (written < 0)
>> -			return 1;
>> -		if (written > 0) {
>> -			output += written;
>> -			payload_offset += written;
>> -			do_output = true;
>> +	if (bpf_ksym_exists(bpf_iter_num_new)) {
>> +		bpf_for(i, 0, 6) {
>> +			written = augment_arg(args, i, beauty_map, payload, output);
>> +			if (written < 0)
>> +				return 1;
>> +			if (written > 0) {
>> +				output += written;
>> +				/* guide the verifier to forget range of `output`, which
>> +				 * helps to prove convergence of the loop
>> +				 */
> 
> [Severity: Low]
> This isn't a bug, but this multi-line comment does not follow the preferred
> BPF subsystem style where the opening /* is on its own line.

Will fix that, too.

I'll wait for some human reviews and will send v3 with the fixes.

>> +				output += ZERO;
>> +				do_output = true;
>> +			}
>> +		}
> 

