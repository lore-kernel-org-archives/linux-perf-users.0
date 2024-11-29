Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1C749620
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Nov 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732891721; cv=none; b=CdzwKLvTfcKuVFqQm0QGHnRa6gEQq7rOhGzo2GHsiQgniLud18TddvUs9WUFFJuZiJq7bMc8YZ31XbtYN9letq+raz7Y1SYuAesGEVqWGO15jHPr17Bu0Xb7+xWDyIzWYctZQe5B2FUnwmTXSLHooC0koMfieE9pXLeUVH7u930=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732891721; c=relaxed/simple;
	bh=EgDVrHEPSKvYoPz3Ab1UXXESviQrnxrpBaaJBsesJVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpiNT6yCCkIYcdWgM/qILQR8uZGQip5b2ECaqrVFAjYWVtZ0seL4jHAWLH3EqBzEJQysuCbaVFTgysEGwY2xRfYFN/xZIHz3SLRFto/cDNsDN013r8irDsLbEstukydFp7kRCjfwDFGL5wyOLYvoQqxt8Er7wI51mzLRCKAXXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IybcU/wy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IybcU/wy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732891718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3TvSFUCpPDPD2n7HyfIOdg4+sstUSObKdBGjGfqxcFU=;
	b=IybcU/wyQwOZ7q/WY6qdpM+qfnTE9jIIkyYjhy+KIR85Tvpex/yTqj/zFjWfyxkF9cBc1/
	zic7nI0xQI8neCz29anji7/Q4XwCdrbIfilPlE/K/hxTtGhTBrb0S8kdTv3Mq+oNLoVmyQ
	rbLcjk/bWUXPWNWcyJS7VvbI3V16CA0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-cq1csReHPva809qLolFubw-1; Fri, 29 Nov 2024 09:48:36 -0500
X-MC-Unique: cq1csReHPva809qLolFubw-1
X-Mimecast-MFC-AGG-ID: cq1csReHPva809qLolFubw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d6ee042eso1004922f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Nov 2024 06:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732891715; x=1733496515;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3TvSFUCpPDPD2n7HyfIOdg4+sstUSObKdBGjGfqxcFU=;
        b=CnRjoFEXLgb4queCTUuqbd75t9NHgkkFWpYbGdylNyWQ8b2z1qUhmwmHexCXYi+0/y
         ltqmQzeO2/UHIOxNdkvsQ7M5xQCzqN3aYwqf0HnsO856jqQE3ix4/yy8y1ex39GRwHTX
         fOtUnfSvFabUFuqZZkLph4O4wePj9PkTccI0RslbMPGOqQQEbdhRttUGItkz+PQ9gpM2
         ttOl7mtDnBqMLSeLbix6aCgkTgmDAYUzo/IhaUPAoDSwoNPcHC/HefioHjcgJKopROwH
         t7x8WkL6rVtIAk9fE63oIaFua/UK8q7ecvvX3VNWg4o5ILrIrSM3HSv2SC3wcjJ6IAdj
         fXEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYCgwLsN+eozW6WsaMD3UfXXdY7Ix0LnD4ab9uQa4I+f3Gpf0+rKb6D02kIuHIMwvcwh4ZC17lY0KoSpYLQQ2B@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj1c/YNIYysKU+6vWC9fJoKZVHSlLHxDfJkKbT0fPAm/FYFm6o
	0Kx+5yahxQRYb0UbbIPpK7k2/C1DFnP9IXZoubhw2RasT2JGJgOxlsVVGONa7tWVZav55ybewMy
	j+La0wb4lexSy5SEgW4go/JvSoTWEjx5AHlw0H7mArRL4PWji6w3HygIm7okOMhf3sv0=
X-Gm-Gg: ASbGnctWsCOIzr+WiJuRV4kbfGivSSe4A8kBbcGlgD4o8+6ctx+l8xl0xty4dGlTYYy
	2GzLx3KCjx7VT6Y0EnznaDbCXp21SO30dWvczuWD7IheDN8sa3wFfZ9xKSxFRd+U5qHJ1AARk6E
	zezZmCfT2QhzlpmRZlyv+fxu58MyDhCJ/euLpO+Mrq80BK4usLG33Tz6D0ptIGeLTwNYo/bw5q7
	Gd+2sWREJsyqkjjfdnenWQsrdlFRxpTgC5qPdInh5IkvsThvzpurDZc2jj3BcOZMbTkcZeQWtYx
	tPu6FF0aF6wP1/IdczzYjh2DaYt5XcCXSng+IXYQLHqAnzi5ryPmwJROberuESbo5UCHS9xOyRq
	GpA==
X-Received: by 2002:a05:6000:178a:b0:37d:4647:154e with SMTP id ffacd0b85a97d-385c6eb4accmr10632000f8f.9.1732891715435;
        Fri, 29 Nov 2024 06:48:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcbDqLb3JhI7c5XLyTnT3Uu+6hKcZ8X6uq7BkxnOYm+G5JeKcSB7UxV7nolFXZ2cuLzYFBtA==
X-Received: by 2002:a05:6000:178a:b0:37d:4647:154e with SMTP id ffacd0b85a97d-385c6eb4accmr10631976f8f.9.1732891715063;
        Fri, 29 Nov 2024 06:48:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:a700:bba7:849a:ecf1:5404? (p200300cbc71ca700bba7849aecf15404.dip0.t-ipconnect.de. [2003:cb:c71c:a700:bba7:849a:ecf1:5404])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385df74157asm1559438f8f.0.2024.11.29.06.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 06:48:34 -0800 (PST)
Message-ID: <fda2336c-7d00-4a5d-8a81-4cb1e58bb8ce@redhat.com>
Date: Fri, 29 Nov 2024 15:48:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: map pages in advance
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>
References: <e97dba32-b5a8-43b1-9bea-e42daf6078c1@lucifer.local>
 <9d6be5bd-ffb9-4a27-b56d-521cf6b7486e@redhat.com>
 <6cab3e8a-dff7-41d1-af22-f18b8f2820dc@lucifer.local>
 <c8ecd378-c197-4e06-94ef-e03b5ee28616@redhat.com>
 <94dabe57-232b-4a21-b2cf-bcfbda75c881@lucifer.local>
 <6795cc9a-6230-431f-b089-7909f7bc4f30@redhat.com>
 <60191c97-dce2-4a92-8b47-c402478ba336@lucifer.local>
 <9d4ef1a2-11fb-455f-8b37-954215bf25d2@redhat.com>
 <14895682-a013-419f-bee8-1476540ddedd@lucifer.local>
 <f637de06-41de-44be-8e1f-6a5d429e0ec9@redhat.com>
 <be33a685-f6e0-41b0-ba3b-d1d7c2d743b8@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <be33a685-f6e0-41b0-ba3b-d1d7c2d743b8@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.11.24 15:35, Lorenzo Stoakes wrote:
> On Fri, Nov 29, 2024 at 03:09:49PM +0100, David Hildenbrand wrote:
>>>>> I just tested it and write() works fine, it uses uaccess afaict as part of the
>>>>> lib/iov_iter.c code:
>>>>>
>>>>> generic_perform_write()
>>>>> -> copy_folio_from_iter_atomic()
>>>>> -> copy_page_from_iter_atomic()
>>>>> -> __copy_from_iter()
>>>>> -> copy_from_user_iter()
>>>>> -> raw_copy_from_user()
>>>>> -> copy_user_generic()
>>>>> -> [uaccess asm]
>>>>>
>>>>
>>>> Ah yes. O_DIRECT is the problematic bit I suspect, which will use GUP.
>>>>
>>>> Ptrace access and friends should also no longer work on these pages, likely
>>>> that's tolerable.
>>>
>>> Yeah Peter can interject if not, but I'd be _very_ surprised if anybody expects
>>> to be able to ptrace perf counter mappings in another process (it'd be kind of
>>> totally insane to do that anyway since it's a ring buffer that needs special
>>> handing anyway).
>>
>> I think so as well. Disallowing GUP has some side effects, like not getting
>> these pages included in a coredump etc ... at least I hope nobody uses
>> O_DIRECT on them.
> 
> We set VM_DONTDUMP anyway (set by remap_pfn_range() also) so this part won't be
> a problem, and I can't see anybody using O_DIRECT on them, sensibly.

Ah, even better.

>>
>> Actually, the whole thing is on my todo list, because messing with the RMAP
>> with vm_insert_pages() doesn't make any sense (whereby the refcount might!).
>> See the TODO I added in __folio_rmap_sanity_checks().
> 
> How long is your TODO list I wonder? :)) I imagine it requires a huge page to
> map at this point..

:D

Too long, but as some of these TODOs stand in the memdesc way, 
fortunately other people might be able to give a helping hand at some 
point ;)

I'll play with using a page type for some of these "simple" cases and 
see how hard it will get.

> 
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>
> 
> Cool will respin and send out shortly with an appropriately 'forgive us father
> for we have sinned' comment.
> 
> Thanks for taking the time to discuss this! Much appreciated.

Thanks for bearing with me. Whenever PFNMAP/MIXEDMAP is involved it gets 
tricky, and as soon as PFNMAP/MIXEDMAP is inevitable, things get ugly. :)

-- 
Cheers,

David / dhildenb

