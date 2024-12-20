Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234071BC066
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688618; cv=none; b=TV8tUUlNgT65jDpZRS/oo/rrpfPqxF+HBiIKLyJgti+3c3dV68SOvZyCMyiKgVpcXMDFgCk7legKVhO61W4JctNjdV0cURp81g/r2QEzRHQ0lwDdLVimKq0cLQG7SzF1MhlIAMo4ciVzkbrFAgwP1E7OeWDhCJeqouM+cjE582E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688618; c=relaxed/simple;
	bh=OVny/AXtixMFvKFOagQoj6t0AXtlIqCEpDx2kK3Xpdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWdqQFWAKZ5HgEiYRiESOB1owJZtw89MYbeHWshfpS7OXuVHhYkjrn4a6F98hlAKrZ4I+hTl4wxBjgSII9LCuBWYZDKufnq6gAIOURbN40AHQDXy+2cf5+uku3hZWXdckeh4aUSKYK8RRRKtvAvj8GR/iD54vhD/Z05kg5D2Qcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdf+wIYJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdf+wIYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734688616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aAn7wUrKhAMSo1SMl4QHxYqrV9u3UZ2RsCxedakHxRA=;
	b=fdf+wIYJTxXHctAZNtmA/Pr5h5b6gg48dYDFuz3SRwHk/MYLvwhuYL0gHf5AkReQYy658d
	4sQC9TgkcI2Rj6eeQaBqdDyhChyRnMj3eNQsZIRtK7lkdEAEgUqG+U1D/uiRHMiCFnuGyu
	BjriKmHM3Im6eErCzjCQmAniahTY72U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-VdI5rkAFP2uPv4ll74A5jg-1; Fri, 20 Dec 2024 04:56:54 -0500
X-MC-Unique: VdI5rkAFP2uPv4ll74A5jg-1
X-Mimecast-MFC-AGG-ID: VdI5rkAFP2uPv4ll74A5jg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385ed79291eso1453421f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 01:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734688613; x=1735293413;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aAn7wUrKhAMSo1SMl4QHxYqrV9u3UZ2RsCxedakHxRA=;
        b=SWwamkeUonFj0nV+2jXrHuZ3xAGX8anVLdpQbb1cKfS2RKaT2KJiyY2nzZx3A3vTQ0
         mOU9W9os7Z28D+6B7e/wJi96nuLaRxz8oqb2s2gF1gsFhIlURuVQj4HjUph3SOXdrkjO
         2KjyNrCRYVG5f0n4ksTBh336PkuRjELoleNI16k02/s9T3B3IScXBRHYxC/kAqT5oroO
         ovpcYIq0Kxr1D4uZY5OHOL487PjT8FadtQcz+hM+qlpx2AJBRLL6uISERfvgKuqLFIFz
         +Qw9SIJkTvR4/d8g/qjAAU9kSJqXAHpJwZ3VT1b0SdsWbQSZRhD4LQzpm0L6yc3TCR5J
         xsmg==
X-Forwarded-Encrypted: i=1; AJvYcCXFlKa95Jv1J4QmIls86O+zGukSe5KZ/GDrlLj2UzHIEXumihV2Cx2V+TgowEF7U5sHuawflr8qTPnBAnM+gb00@vger.kernel.org
X-Gm-Message-State: AOJu0YzWKYQ1xO4w+51qAqLyZy4qrX641/qDZFfgQuCwPJq4U0Iopkxg
	1NvspNYxhlKb7UykJ3jCEPJKfGvnYaCEfq26c/wAWejR+v9zX8RE7tq129+mj0RMDohGz4PkKEh
	dWhvhoEtluI9BASXfMEHhyh0uQIQK2BT/ap3VDTllkEm/vESGI9Bue+DK+SBOzaMKhq4=
X-Gm-Gg: ASbGncvv6B/c6KNFf4fky2h2mh/2iTgYxp7Mt5r+1JnnIMOGqeOkxa/lDY8yBCyPqOh
	+c20ywBC2QbIBGWqx8RRjZmj+uYxdP55QhfnQCKfbl6CqsTCXFSiA98FlXecCZVyqmvHIaDcf5u
	szHP2ecexQzGAIULZ+q0q0j9zJCw/PD6ngT10XMdr1+teuhOySQYIED58aQnxAiMzcBNg6LO5PQ
	eY6LS8VkVDDHgdBUEuJd8VF0v49okdDTs6T680iKUPWEM3zqxqq1WdJ0mntE8xCMgSWt8dXY4vk
	vOm7dhkuLJOZmuq4udYfLeaqDh2u0jPhl8V/PWW7FrmqTvqxvhs4wdpkkq2iuJ3y9zoJeNMdd1Q
	W/N5078XW
X-Received: by 2002:a05:6000:2af:b0:385:e8e7:d09a with SMTP id ffacd0b85a97d-38a229ed1b2mr1745105f8f.2.1734688613358;
        Fri, 20 Dec 2024 01:56:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGk49YfqQvSIXDFkv29nq4afbHvPBr7rc992l6Hb4edkWWbmDgXyiuQivOAWXlySoKq4q5gw==
X-Received: by 2002:a05:6000:2af:b0:385:e8e7:d09a with SMTP id ffacd0b85a97d-38a229ed1b2mr1745072f8f.2.1734688612984;
        Fri, 20 Dec 2024 01:56:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3? (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de. [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8ace0esm3569887f8f.106.2024.12.20.01.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 01:56:52 -0800 (PST)
Message-ID: <860a1ef0-678d-414d-8511-9695b90c3ca0@redhat.com>
Date: Fri, 20 Dec 2024 10:56:50 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf: map pages in advance
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Chen, Zide" <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>, Yi Lai <yi1.lai@linux.intel.com>
References: <20241205082948.56212-1-lorenzo.stoakes@oracle.com>
 <65a04f0d-668b-47b6-a532-d1e11ef4835a@intel.com>
 <4ded2d63-03dd-498e-9810-690a9eff0c22@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4ded2d63-03dd-498e-9810-690a9eff0c22@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.12.24 10:31, Lorenzo Stoakes wrote:
> On Thu, Dec 19, 2024 at 01:17:44PM -0800, Chen, Zide wrote:
> 
>> With this patch, it seems perf tool has some problems in capturing the
>> kernel data with Intel PT.
>>
>> Running the following commands, the size of perf.data is very small, and
>> perf script can't find any valid records.
>>
>> perf record -e intel_pt//u -- /bin/ls
>> perf script --insn-trace
>>
>>
> 
> Hi,
> 
> I'm on leave (and should really go back to relaxing :>), returning on 2nd
> Jan so can't really dig into this.
> 
> But I tried it on my intel box and it 'works on my machine' with and
> without patch with commands provided, so I'm not sure this is actually a
> product of this change (which shouldn't impact this).

Zide Chen, can you try with and without this patch to see if it 
introduces the issue?

-- 
Cheers,

David / dhildenb

