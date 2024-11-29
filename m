Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B57B15958A
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Nov 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732884349; cv=none; b=BCAUcF9QpmiRRDIQqv/3lNapR+Q/qMaNiFn0MINjZ/A9ARxC/4keOtAzYigwMBY1oMe6y2F0bIe4EfRwvOm/oXnSMR+8qAZyQWUzPv5O55DYWWN6ivt8VPuf70SOV9hep9a+pJ5Lgyur/hoZ8YzqihyZhiwo1zfWC5ju6N9GNRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732884349; c=relaxed/simple;
	bh=XmAs56Z86xKhGpq9RSgeRY7OGzAJPY6eJyiGQY5kjtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESRuAgomDgFVdhsMOJZTdvQ2m8SVxdw5cb0H/qIv5QlXi4nIIApZIJyG4YPBHptXZAVvIAxFWY5Lp3qRs9YazfOuBZjbJjBlBsmpu1bL4i3eVULvGDlbh+UVpWKAyq79cs91UQOXFyPXmIMu/2ENvW4NJJUUUUaAjuVo/FZtA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgOVjQoK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgOVjQoK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732884346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rTqikPE9quEJAwZiJ8tB25L8aNEPncKZ/0BfRuOUOKI=;
	b=BgOVjQoKeaU+aZ4FbvxnMq4lfU/aWE68ZX+CJI3weHy9fGDQ6cy+eN5iLQ2X+ZBr6bht5P
	pkDRQBQyvyGrcgy0Bcdknh6UPDaTN7RxNAeqIVb2VDu3WAf3YA8ESJezCGfwQy8+PBzgSI
	6vmO/UeeMZRsIcunaElauNGLbXi6rKY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-ur8SN-GCOX2QydOub4eNUg-1; Fri, 29 Nov 2024 07:45:45 -0500
X-MC-Unique: ur8SN-GCOX2QydOub4eNUg-1
X-Mimecast-MFC-AGG-ID: ur8SN-GCOX2QydOub4eNUg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4349cda1899so13913905e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Nov 2024 04:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732884344; x=1733489144;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rTqikPE9quEJAwZiJ8tB25L8aNEPncKZ/0BfRuOUOKI=;
        b=TN1nFKzJmwld2i3ve0JjGgMX1F19dpnit53zvYEPTho48FGq3JCx8YrOMvfs9WRh91
         GleUxUp/pk79xg1CkWNBdfDk/NV5b+FX9fJBhmRYqrB7OgVNSUaKo0fYfW+1VacucEcs
         rBMwIiwt0h8vIesy9kaocVe2JnXnWxstCq56UDMZsdWqk7QbwagAlvADqPhP8uBeh1AY
         jnWNl72l+EARGAf/cnUpJFqY6cObjw5TZphqxBfrKuHmAjiyzaj+nk0ZK1/iDF9xWVuM
         q8fVq9iswqVntTwKP5mKQ+Za/gtK0wO0NJ0invlhZsgKWTAqgNxHw3t1dU9CdNqeqUJk
         8Xow==
X-Forwarded-Encrypted: i=1; AJvYcCUEFP0ZleOECsFNyu2v5pg5DV0IVeD0+0IIrLQrc2RzSWTh2DHjSa6wQMs2+cyGsjkn00fgxmpxmxaoJjdPJwRW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpk+FcaMbh7nEjKnjRWiSpGHL88SQmqZqV9dyoJerUfyS1xCo8
	e0GhO+ITi22aDgz+UAr0ahmI782Aq1IGBSlYcPC0XAdRFQE8jTfuIYvtGQq+qhHgr5WWnh8WIkP
	kFxeMK5BD2bOJ9X1U+WcEi4lZLAjmOvV6S6Y5qgZXz27wGc7Tqm55X63ZkW59rVnkIQQ=
X-Gm-Gg: ASbGncumoJyvMU2RYivSMrt5Ht8KTw7kpLZBi3eNyS3Ic67rgfpmJAr635HQu+iXVkD
	7wWBvP+pcgsCTjg8JRsVaADkrBrQ3jqV5ZizSUjG73NLeSbXw+ueHsOF0aMLpd/9ko7PWMZIMxk
	Wf3tApE6gSNLdwa4b5mPSKRtJHAjpAxel46zkwEVvfC79KggP+9ZB2EP1Zz7jSXTAkjRBbjG4Q9
	2odkAcwJI/3K/IdwuYBs+VEg3xt4u92g2MYawbpbNaHS5r1E1cE3zI9/YRUQ0oshbbdIsAa+jVu
	lkRqUwrUpWlwq6fOF/2dH60+VNRZ16PD+SC/6j/ykvn7iXg/6vkKWU98fetUX5DZkLlvus22T7X
	c5A==
X-Received: by 2002:a05:600c:314a:b0:434:a902:415b with SMTP id 5b1f17b1804b1-434a9dc3c69mr125231695e9.10.1732884344206;
        Fri, 29 Nov 2024 04:45:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfIVICx4newpAkOgyg2u/7j0dqWcM8Au2pFLmwQ9c2FMN+rayeZo5LhCEc7d9ZMyfJhPy3rg==
X-Received: by 2002:a05:600c:314a:b0:434:a902:415b with SMTP id 5b1f17b1804b1-434a9dc3c69mr125231405e9.10.1732884343888;
        Fri, 29 Nov 2024 04:45:43 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:a700:bba7:849a:ecf1:5404? (p200300cbc71ca700bba7849aecf15404.dip0.t-ipconnect.de. [2003:cb:c71c:a700:bba7:849a:ecf1:5404])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa763a59sm83405695e9.11.2024.11.29.04.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 04:45:43 -0800 (PST)
Message-ID: <74be541b-22ad-42b5-b3c5-79b201e28f04@redhat.com>
Date: Fri, 29 Nov 2024 13:45:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: map pages in advance
To: Peter Zijlstra <peterz@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>
References: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
 <9f9fd840-6421-43b5-9a12-edfa96e067cc@redhat.com>
 <1af66528-0551-4735-87f3-d5feadadf33a@lucifer.local>
 <926b3829-784f-47b8-9903-ea7b9ad484ac@redhat.com>
 <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
 <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
 <20241129122624.GH24400@noisy.programming.kicks-ass.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241129122624.GH24400@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.11.24 13:26, Peter Zijlstra wrote:
> On Fri, Nov 29, 2024 at 01:12:57PM +0100, David Hildenbrand wrote:
> 
>> Well, I think we simply will want vm_insert_pages_prot() that stops treating
>> these things like folios :) . *likely*  we'd want a distinct memdesc/type.
>>
>> We could start that work right now by making some user (iouring,
>> ring_buffer) set a new page->_type, and checking that in
>> vm_insert_pages_prot() + vm_normal_page(). If set, don't touch the refcount
>> and the mapcount.
>>
>> Because then, we can just make all the relevant drivers set the type, refuse
>> in vm_insert_pages_prot() anything that doesn't have the type set, and
>> refuse in vm_normal_page() any pages with this memdesc.
>>
>> Maybe we'd have to teach CoW to copy from such pages, maybe not. GUP of
>> these things will stop working, I hope that is not a problem.
> 
> Well... perf-tool likes to call write() upon these pages in order to
> write out the data from the mmap() into a file.

I think a PFNMAP as used in this patch here will already stop making 
that work ....

-- 
Cheers,

David / dhildenb

