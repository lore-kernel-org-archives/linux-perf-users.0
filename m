Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554915B14F
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568586; cv=none; b=YvY4LNNDDDIr041WvYEbXV3KJTcMXF0CbrpknGU5vp0rPoFHvRuLN6DZucNLVGWMjFVUQMRdLH7PgTM8hz7JDUF6hBSqh+vPfP6TdG5K7ENPNEJfm9St5MpRvojcoVfcl/jjlMS8j7SZjCAYp+GIR8zEN1NQiGIpoTYOQG2WmGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568586; c=relaxed/simple;
	bh=hGi8YXModPaINEUs9neWzaD8fA7G6jKoaUEAHbv6Ne4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMKvrKLHzKNBlxpr7iUgODRkehTfuVw2TA3qirduRmRSRVfNqD5f62jSALpZ2aMBNAPxrDlL16qLjw2qkXlQFvJG9/EOtoWtL/eXoCtPcbNrJzYyS0arpxzUaxR6d7kcCHbPbeQa3gsKklgepe+l1j2fMe6/DEqoZSLOCWkmH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADeXggRK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADeXggRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726568584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ydd/x8z/rWdB1y1aNRkIvJ800tcht5bmAGltsT132Qk=;
	b=ADeXggRKgQoFbnmu9QmpqRUDvAaoj9NdH3euG9zVXQG3aaa0YcrQ3jWc3/NoktCqCe+Vlt
	7fvjJsQxsC7bg3jIRItUsuVbKASSFE1jc71zyMDYuXJWEuCI+y4D9CY80PW1nYq2M2ibBS
	wF/1P5lF1DHh0jHhqJkSJOL8Bx6G2os=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-WHthdfhMPkCSHMwEcLyePg-1; Tue, 17 Sep 2024 06:23:02 -0400
X-MC-Unique: WHthdfhMPkCSHMwEcLyePg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c2486f1f14so3938208a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2024 03:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726568581; x=1727173381;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ydd/x8z/rWdB1y1aNRkIvJ800tcht5bmAGltsT132Qk=;
        b=U3LoToQnem3jdknuJRDBxfahXy/9x8pJgnvm63snLeb2Zu8SZhHt6UuA+8vkqXoJCq
         m1DnbsTexnvIWYhHs2Aa5QE6gGI5W4PaNLJZ/Klmk2w2FfQtwVaZ3r6k7OXz6GOULuPo
         2tOUOK6QOSMbvHcqoei7nYQG1nUkJQPTE8rbkxxdzuj4JEY6UhgPDUsWzTMAg5JxbkkR
         feqRPpGzYjwOKCgchRtU974Lq3jP1o3j4w0SYv2CjAx3enm9zQg5it+rfrxUmYg4DHhB
         4OzUWYDo5vnztcqAOFCxMs3yy3DH3EiICZ29w4DLnvHC4FX8C5/a1wu9djqX8yIEO4x7
         yDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd+xsKvT3QRfTOoEmdQAL0S6LDfU+AqJiuFjmpb4f4Ki4DH7EQs1cjOvxKYB4OKonDSWjiIO6xNYyYWX9YYFCp@vger.kernel.org
X-Gm-Message-State: AOJu0YwN3ZY8ORIaGxuVX+G8YJziy9crP1wLZphvgvKdsewdWUHaI4JZ
	7ulqqT/DaTRfD3wnDBTTd9QjriJ+4wtanAHrtL5WzuO9gIjpEFyn0dDl3cC+3mqAvmyk0TKXJ90
	vRYfPJcrhDezDzzMLEGoHtXJOuwNDprKmivb9awY+6pMB90MMSdigXyOBe3cQqgfz0BA=
X-Received: by 2002:a05:6402:354a:b0:5c2:439e:d6d6 with SMTP id 4fb4d7f45d1cf-5c413e117ebmr17061221a12.11.1726568581567;
        Tue, 17 Sep 2024 03:23:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn7gFPHvRH97LwaZjArKPHMj9F8rHYoTdOrw0TXFOFbnMeRWzKUCJY3AXZKV+B4Vp9xSUVxQ==
X-Received: by 2002:a05:6402:354a:b0:5c2:439e:d6d6 with SMTP id 4fb4d7f45d1cf-5c413e117ebmr17061190a12.11.1726568581014;
        Tue, 17 Sep 2024 03:23:01 -0700 (PDT)
Received: from [192.168.55.136] (tmo-067-108.customers.d1-online.com. [80.187.67.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5fce9sm3504885a12.56.2024.09.17.03.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 03:23:00 -0700 (PDT)
Message-ID: <c4fe25e3-9b03-483f-8322-3a17d1a6644a@redhat.com>
Date: Tue, 17 Sep 2024 12:22:57 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/7] x86/mm: Drop page table entry address output from
 pxd_ERROR()
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20240917073117.1531207-1-anshuman.khandual@arm.com>
 <20240917073117.1531207-3-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240917073117.1531207-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.24 09:31, Anshuman Khandual wrote:
> This drops page table entry address output from all pxd_ERROR() definitions
> which now matches with other architectures. This also prevents build issues
> while transitioning into pxdp_get() based page table entry accesses.
> 
> The mentioned build error is caused with changed macros pxd_ERROR() ends up
> doing &pxdp_get(pxd) which does not make sense and generates "error: lvalue
> required as unary '&' operand" warning.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

Not a big fan of all these "bad PTE" thingies ...

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

