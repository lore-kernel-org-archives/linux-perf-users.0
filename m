Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A221DC075
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Jul 2025 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752269682; cv=none; b=O7gVJb7Nkntes+R8Q1vVHex3efL1lXGd/Su9eGa1GcLsf81OlDKzXBKQqoguDkQiNrnTPBXpuNMRJqMp6P1DAAjR7aimHRvfGqvLIZJFEH+pYiUZPIwfKNUbl//HZIpCKlDENwhkixcN5ctTxtFeYTToTzm7mvfkGhFRXTxY8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752269682; c=relaxed/simple;
	bh=8AjCjaMYARnEByKZpVvwMo5DXE/N8Yd0be8Q3U8qNLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yy+rpq7Po5eAK5i36lL342BKNdU3U+qBdm6tTka5nZ59jnc0bftABW09xqfh/nBnTqmW+E+ceLTLi0jH0dH+WC1P/qtdjF76Fjs0cmT6CABSNJAf91KNABY9hDRY9rY9zrv3BSIX/y2DvAb5i2KBLdsRAsFj07XuXAoOD9t97DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZwXXlej; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZwXXlej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752269679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XyJwCW5qacALhF010Xai575cjd1JXXA08eizMKVZEV8=;
	b=cZwXXlej8guqXyj0+iF00sKRrLqbcSvevy3OPyyzl+RRzSvhzzo7dKmGD8yC9+/RMczWg0
	4FAr0mpY5mRAOD2Sgzk6xtaEM5O+pEO/SyXq6Nvi7/N/iQZSW+sY0Pm+51B+rUSSWdNPGs
	HNH9RJ6vskhpQqJjo9GOBW6bsolzBsU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-_qrSLyKmOL2tp5Bjd4Ulaw-1; Fri, 11 Jul 2025 17:34:38 -0400
X-MC-Unique: _qrSLyKmOL2tp5Bjd4Ulaw-1
X-Mimecast-MFC-AGG-ID: _qrSLyKmOL2tp5Bjd4Ulaw_1752269677
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so1609586f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Jul 2025 14:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752269677; x=1752874477;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XyJwCW5qacALhF010Xai575cjd1JXXA08eizMKVZEV8=;
        b=pHJguzYj4w7ZNT0BrGfAv+Quplyfu/w454Mmx3LUuPa7b1P17Foh9mzvi5O9/OOO/n
         XG86S0sIt0x5PeFBQhMFJb1GnXUdIJqFGwsNxhlnIjA8eyJGyUaOkqDTZCk91yyYaqEV
         2dmojzvkv4UgObxD12EfQ58RJvyZQebRB1bhkZ3KzyDDYrDLyaM4D1vDhurYRWQTCkLY
         BfcgGstzaNOPOH9e6Krq9sNhukqY0vqiI8eIAgsawq/5mJGg7dYGAhkS9Pfqms7Y/u3A
         BMsb1uHvo2MNlqAvOtSQL8MGBdLeBuI1bKTyiMxAJfpZbvvvQSzSJU1yaQVi/GPbwrse
         eR+Q==
X-Gm-Message-State: AOJu0Yznyz+1orHxmpXgmRcs2tmFpXEd2ocp1c1GuYxXoAi7n09VwGTA
	BhROoBKtRbdIN+6F7pjLebWbkAFhUWyRUbW2Ta24a+zLseSK3q9xMmb31vFbfM7TZZVzKZb5Z17
	ZgF+GCUkx7b9hZyv0D/ys9FYWS4rZVV8tOrjnFzKtxxSv/iTmB02LoxaUqP3BiFJFud4pVjg=
X-Gm-Gg: ASbGncvEMkDTmW6Riiu+PtCB+paeLG6uIGu98Nuan6/pJpked2lv26xmcA5mZL81yWu
	se2FZvpN9Ugt+7JZCDSwAam6xuIi4Pu2SJZiKfH3IeAvJ9F86+LWbYCBBX241ouAE+jHUzi8lA+
	1qtrp1SI0nQLQIeIi4e92D/bxrgpru5EEg9+MoUG8hrQUiFKnGmUUx4YgAjOztlHKoW2L3CzoYU
	wNEf7y8UPdW9nIJF9R3gipOoQcSu0tCnPvzWP6LBsVfwNyKhVFQ04LFmbFTNiYt9DnWYBPAfaPA
	jr8K6geVTWw3tH10AxmF+a+DR4OQ1IC3PdlsHWiEJwo3eYH3/IuZsX/zsPZkxIo949vPJ3O2aTY
	88tUT2jzVMXxZtjnZHIhgnRX07a/prYBkdPvYc5bi6fpXYgW9EgYvcd8D3iW8v1lrCaI=
X-Received: by 2002:a05:6000:1884:b0:3a4:ee3f:e9a6 with SMTP id ffacd0b85a97d-3b5f2e45e0fmr3961959f8f.54.1752269676954;
        Fri, 11 Jul 2025 14:34:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn0FKI6OJnOe1nIxhGrRZV7H09iyXwP6aorwn7zO9Lk+mD3VCffznBjXhQb/C7M1wcVnqfdw==
X-Received: by 2002:a05:6000:1884:b0:3a4:ee3f:e9a6 with SMTP id ffacd0b85a97d-3b5f2e45e0fmr3961949f8f.54.1752269676517;
        Fri, 11 Jul 2025 14:34:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0a:2e00:89cb:c7f0:82f2:e43c? (p200300d82f0a2e0089cbc7f082f2e43c.dip0.t-ipconnect.de. [2003:d8:2f0a:2e00:89cb:c7f0:82f2:e43c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50fb874sm98500685e9.28.2025.07.11.14.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 14:34:35 -0700 (PDT)
Message-ID: <a1340d2e-7ea6-4fc6-a107-41a857e1d27d@redhat.com>
Date: Fri, 11 Jul 2025 23:34:34 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] uprobes: relax valid_vma check for VM_MAYSHARE
To: Matt Gilbride <mattgilbride@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>
References: <20250711200705.1545447-1-mattgilbride@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250711200705.1545447-1-mattgilbride@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.25 22:07, Matt Gilbride wrote:
> `valid_vma` returns false when registering a uprobe if the provided VMA
> is writable (`VM_WRITE`) or sharable (`VM_MAYSHARE`). This causes
> `perf_event_open` [1] sys calls to fail silently. A successful return
> code is delivered to the caller even though the uprobe wasn't actually
> attached [2][3].
> 
> Remove the latter restriction (`VM_MAYSHARE`) from this check to allow
> registering uprobes on code that has been "dual mapped" into a
> process' memory space. This is helpful when instrumenting just-in-time
> compiled code such as that of Android Runtime (ART) [4]. ART maps a
> memfd twice, once as RW and once as RX, to uphold W^X for security
> (defense in depth), and also to provide better performance (no need to
> call `mprotect` before and after writing) [5].
> 
> uprobes already work for code that is ahead-of-time (AOT) compiled by
> the Android Runtime (ART), as it resides in a static ELF file [6]. In
> order to attach to just-in-time (JIT) compiled code, the Android OS itself
> can coordinate with ART to isolate to-be-instrumented code in a separate
> memfd, which will be left untouched for the duration of a uprobe being
> attached. Thus, while the VMAs inside the memfd will *technically* have
> the `VM_MAYSHARE` flag, the system will ensure that they will not be
> written to again until after any uprobe as been detached.
> 
> Link: https://man7.org/linux/man-pages/man2/perf_event_open.2.html [1]
> Link: https://github.com/torvalds/linux/blob/088d13246a4672bc03aec664675138e3f5bff68c/kernel/events/uprobes.c#L1197-L1199 [2]
> Link: https://github.com/torvalds/linux/blob/088d13246a4672bc03aec664675138e3f5bff68c/kernel/events/uprobes.c#L1256-L1268 [3]
> Link: https://source.android.com/docs/core/runtime/jit-compiler [4]
> Link: http://cs.android.com/android/platform/superproject/main/+/main:art/runtime/jit/jit_memory_region.cc;l=111-137?q=jit_memory_region.cc [5]
> Link: https://source.android.com/docs/core/runtime#AOT_compilation [6]
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> ---
> We've created a working proof-of-concept in Android that demonstrates
> what is described in the last paragraph of the commit message. Thus, we
> introduce this patch to understand the reasoning behind the original
> `VM_SHARED` (later converted to `VM_MAYSHARE`) restriction, and the risks
> that may be associated with relaxing it. It's not clear to me why the
> restriction is there, and we'd like to get feedback on why it is or is
> not still relevant.
> 
>   kernel/events/uprobes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index a8caaea07ac37..1ecb3fdb853b9 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -123,7 +123,7 @@ struct xol_area {
>    */
>   static bool valid_vma(struct vm_area_struct *vma, bool is_register)
>   {
> -	vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
> +	vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC;
>   
>   	if (is_register)
>   		flags |= VM_WRITE;

It cannot possibly work, unless I am missing something important.

You probably tested this against a kernel 
pre-6e3092d788be1de0aac56b81fc17551c76645cdf.

Before that rework, you would be inserting anonymous pages in shared 
mappings, which is pretty much broken.

If you want a double RX mapping where you can have anon pages in it, 
create that one as MAP_PRIVATE.

-- 
Cheers,

David / dhildenb

