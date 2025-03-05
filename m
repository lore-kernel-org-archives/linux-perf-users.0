Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6A1A23B1
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203429; cv=none; b=CEcqnH4AhTv22s1ENvwGQOiO+nJvtkB5H0CVD6BNzs1fyM10aXtikuzK+UvhR307vkM30NvtFc+/pPNfW2M7smuSQqBtJrus/E75A8X+JnUeJwj5Ho/nA0iVULLiag0WD5WllesAtOGmp3PhCB4cklLnCPhS0E8q6w2zuMHuvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203429; c=relaxed/simple;
	bh=0xil92qxz4YvhToU3vCUISLi/tZfpyikp0AYJFK87VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOes81OcJ9bpopJxglT1VBrAJEWI+C2WN0ZfElPzWGeMFVK8Qze19nJLO3JGPCw6x0B+cxy4JYVY/49e7HpQyhAMMuoHW97z7ZB9x57CCKardpOACQX8Uuhr/gv7zHXVwQ6zvJDcp4lpP1QR8SlKBhScEd9kehxFIItovTaaBhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAvOT8mf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAvOT8mf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741203427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=almcRtRu2TJhiZ4ii+4IWj1G0tD9tQd0bVxdKEf4VkI=;
	b=bAvOT8mfVbgiAXmRvLCToBaIzjRITqVZjIy63AH8w+Q8ADEXxNuMLxQUp4TQOUDtVxYtYb
	E6Ini2dN1A0KUbVDeQi8ZYzi6NOW0ciH/DOR5gH9vTxx5XrUqb/yj826Td2+Gf+sCy9Z2C
	uY0oHi3mC8/OY0K7dQrjVEuq5aQk/zk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-kBmKU_e6N9CnLbZGs_OS4g-1; Wed, 05 Mar 2025 14:37:06 -0500
X-MC-Unique: kBmKU_e6N9CnLbZGs_OS4g-1
X-Mimecast-MFC-AGG-ID: kBmKU_e6N9CnLbZGs_OS4g_1741203425
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912580843fso589247f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 11:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203425; x=1741808225;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=almcRtRu2TJhiZ4ii+4IWj1G0tD9tQd0bVxdKEf4VkI=;
        b=IFtTxQgUpeopBp6tptCSMhOCd5Mb4LXyuWj02ktslPydnhqwU8ca1/nE9wGGQ1h6TX
         U6G4HwhkP+yHRsN2mTfK4H2jvq8mU05Mau7rbLZmpcmXlx/IWhrUAvaFwJiFuuP+SbB6
         ik0HWMGPORj0cG1r4u/78Pi4uzeSSUNlynfrRiqEwjLGHB9oCMcoA3IYk0auGyJ9WSKK
         lTsNpqATVg10Y67Guj79DimntBUq72TPkA88NQw+nZ3RumFxX9Lcewj88xaEdx3nXB0X
         kcFOSbSpQ8yde4wwl28qn7xqfwvWmflPVKevgfPqENlUWvSezqeJdoUNoDDZc2WJxa00
         Hmaw==
X-Forwarded-Encrypted: i=1; AJvYcCVrYgOChStNMgGNB3P6HEcmn3+J+3iS85Jca72UE0XLfSguvCTo+bIkEy+HM7rttJ3Pd9MILwX8VYY9cx0+IdQC@vger.kernel.org
X-Gm-Message-State: AOJu0YyvXjWmDhHRFnZNWuLEFuIvK69ub0ybvriXJR4tHzwTfPQLMjBp
	Fh9jWono5qezFWaWJElEXCkO7rERxDqtoOpSSH77xxjlIgJz2kVSpwwpKDXOSgvQlQVg28sxcXO
	Rav91H0oWEyj0SaTbRl4ChqTN3VF8g0v53MeeGu8LRhFCIU0ZSCOLyf6zL3D8yCDyUc8=
X-Gm-Gg: ASbGncvljO3MO2E+a6cbieTa03Hv1KlP+QnIS+9x4htYhC+CdDQBX0uxkAcdFAz1s60
	WTFAFwnkjKESEopiD9tUAA8FHZ1F+jnDILyF4gjEe+1CpmyQFngqmVoMYFQyO5kd0i+JGL0mQem
	JeZc4HnqKID+cT9Pv2vUAV18Q3YvSD83kaevMyLeH12RdTf7jcD/Z6XVVEKzmDJXPjLGLbprFv5
	axElqZ+LzlPZdb1zeD5dXCiBaXAc3dHQqe70hdMZDe/UpIpghJAIh4pGVRcLavvFCk/IDdQ1URk
	cofWAt3lY8uyJhQXsFvOjndKgHuPzlZf2sLCYDqNQjcZyAcgR4wD1gH8Z8AgiL2IdIDezJ+5R0w
	XKyW1h+QOY7vgoVYfrGK+0sEKlZWaMt+MlExrEUIXXes=
X-Received: by 2002:a5d:64c7:0:b0:390:e1c2:73fc with SMTP id ffacd0b85a97d-3911f7b78femr4977994f8f.43.1741203424769;
        Wed, 05 Mar 2025 11:37:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuQAaENcRG/ZWFzHVNwA/HQ7iYWbxBUSdmLmvLpsooUE1TTBdJxG8aIMztELdolVc7qVGzSw==
X-Received: by 2002:a5d:64c7:0:b0:390:e1c2:73fc with SMTP id ffacd0b85a97d-3911f7b78femr4977967f8f.43.1741203424451;
        Wed, 05 Mar 2025 11:37:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:5b00:84f2:50f3:bdc8:d500? (p200300cbc7395b0084f250f3bdc8d500.dip0.t-ipconnect.de. [2003:cb:c739:5b00:84f2:50f3:bdc8:d500])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7b6asm22428238f8f.51.2025.03.05.11.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 11:37:03 -0800 (PST)
Message-ID: <bf8ac5ba-74ca-4ddb-bf28-1c2834907146@redhat.com>
Date: Wed, 5 Mar 2025 20:37:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v1 3/3] kernel/events/uprobes: uprobe_write_opcode()
 rewrite
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@armlinux.org.uk>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Tong Tiangen <tongtiangen@huawei.com>
References: <20250304154846.1937958-1-david@redhat.com>
 <20250304154846.1937958-4-david@redhat.com>
 <Z8imcXuuW6EK1aLY@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z8imcXuuW6EK1aLY@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.25 20:30, Matthew Wilcox wrote:
> On Tue, Mar 04, 2025 at 04:48:46PM +0100, David Hildenbrand wrote:
>> +static bool orig_page_is_identical(struct vm_area_struct *vma,
>> +		unsigned long vaddr, struct page *page, bool *pmd_mappable)
>> +{
>> +	const pgoff_t index = vaddr_to_offset(vma, vaddr) >> PAGE_SHIFT;
>> +	struct page *orig_page = find_get_page(vma->vm_file->f_inode->i_mapping,
>> +					       index);
>> +	struct folio *orig_folio;
>> +	bool identical;
>> +
>> +	if (!orig_page)
>> +		return false;
>> +	orig_folio = page_folio(orig_page);
> 
> I'd rather write this as:
> 
> 	struct folio *orig_folio = filemap_get_folio(vma->vm_file->f_mapping,
> 			index);
> 	struct page *orig_page;
> 
> 	if (IS_ERR(orig_folio))
> 		return false;
> 	orig_page = folio_file_page(folio, index);
> 

Willy, you read my mind. I was staring at that code and thought "there 
must be an easier way using pages", and folio_file_page() was the 
missing piece.

Thanks!

-- 
Cheers,

David / dhildenb

