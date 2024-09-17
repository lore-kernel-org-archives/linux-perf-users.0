Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D3B1E4A6
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2024 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726572707; cv=none; b=Kowld1mPMGOqdzv3kxvZkpBnzeYZFhu/xwVEFipYKVjIeMcHOmomwqW5xVsSzFpcKMFw+r0zHrosIK76JKRf7XTYbZlmTHyTqFd9zxLLYWkvKQd9vxXM+Vp7aYXbLgmAlqfW55Xfzv2YRrwvUtcaChw7xoUkasZlrOLbmaGgVUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726572707; c=relaxed/simple;
	bh=4bjNKuWWw046PH8j5NUWvAfjfjaVMZDU0UtUhBsJzsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvN81ceAA3g/rLamkcvRbSY229wq96I2YzuW+ICHRPN0Vplz4UadAc4aqdwE9iKWUCBgi4YePwyAfbEnxIyNdG3LSPa/Xi8dXXBW9zRWllTXkgaIL/p4cbsWJSFc++hh1gpzBbaOtNvzTPzThkjPvd+xJ8iC7wlCmzVjt5wJCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ws0Y8SBl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws0Y8SBl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726572705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oul+0D/MDGitLa0XxGud62DDDYkyjjPr6iJYhvpm5HA=;
	b=Ws0Y8SBlro5uhGlKl48YeakpbVfjf+Ll/o3GyprslMZBB27lvSzRor7jCD1bmzcA1WPbbu
	6SMZ8MK3hNCam9ItjLlDolgFl4Up83ZpffNS1ZmyJGPnmdylaeXt+kadF6GAUsIkyZr5xL
	uleCpzIEGSIiMryFC0KrsHdP8dXxJho=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-4q23mGZsMMawKF0qx69IYA-1; Tue, 17 Sep 2024 07:31:43 -0400
X-MC-Unique: 4q23mGZsMMawKF0qx69IYA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53661a13121so1785019e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2024 04:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726572702; x=1727177502;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oul+0D/MDGitLa0XxGud62DDDYkyjjPr6iJYhvpm5HA=;
        b=YqStTP7pb+tEwgUSExDF0rP3T8l6wGCp/CDd+HOLKCo+ZUdmIGI9segKrNYKceFKcW
         wh0RVY9skOc+/vKk32aMYPRk0FDUvWbM87bTbkj/EpQRufE0D6Kn+N1lb9pXOqqA+ux8
         55xVkxzZwV4QB/Ns5lmGXz5dRxedMStcyV2p3N1Jejin9m+r1vGDD2HQKJNMNzjTwOub
         6N0hMbiAuYzqa+JOju3vpXhCymVWpUQ/xXRJLtpfpXvh7WIt5TFgt+Oiukuto5plThcR
         oCnQtvwQiNzONSE097nDYRgqmJLyFc/UAaZj/hEdN1J/HmVeOrCbXN5sT7dQ+PoF1ykP
         o92Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbUy8yOn/d6Me1hoEI/6h3yR7tFmWoGK/0muc9YdpxwprpaAEIOfTemYmug1XhgQ8KBnh77yLq8NUVhiVQ0QIA@vger.kernel.org
X-Gm-Message-State: AOJu0YxZrvS48tq9Qj/qlgHhMekXBvEzaV+LdI7YjGc2/4Y8beXGPkOb
	sJsKPp2/MbbZou18dsb/8HQbgHcq1Vg0xKrBgY77Xi5vnMI5JQ8iGYYutq50eG+6FmFblrx1GyT
	+io0aYJ0HZffy1TwDabT2nbSXkoT5NbfQuWtqId+ER6XU2PFJ2LqFiTugMbetWYpiO/M=
X-Received: by 2002:a05:6512:1242:b0:533:448f:7632 with SMTP id 2adb3069b0e04-5367feba053mr7554870e87.1.1726572702218;
        Tue, 17 Sep 2024 04:31:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvGVKtqN3ILBeZBk9xYEyrdcbPUlznGq75QoE8BG0n/NvnMUhaFxW/EXPIZ8zLsf4a5/FruQ==
X-Received: by 2002:a05:6512:1242:b0:533:448f:7632 with SMTP id 2adb3069b0e04-5367feba053mr7554843e87.1.1726572701637;
        Tue, 17 Sep 2024 04:31:41 -0700 (PDT)
Received: from [192.168.55.136] (tmo-067-108.customers.d1-online.com. [80.187.67.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb949bdsm3535380a12.84.2024.09.17.04.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 04:31:40 -0700 (PDT)
Message-ID: <5af75d55-f65d-4c3d-be85-402386ece04d@redhat.com>
Date: Tue, 17 Sep 2024 13:31:37 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/7] x86/mm: Drop page table entry address output from
 pxd_ERROR()
To: Dave Hansen <dave.hansen@intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
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
 <c4fe25e3-9b03-483f-8322-3a17d1a6644a@redhat.com>
 <be3a44a3-7f33-4d6b-8348-ed6b8c3e7b49@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <be3a44a3-7f33-4d6b-8348-ed6b8c3e7b49@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.24 13:19, Dave Hansen wrote:
> On 9/17/24 03:22, David Hildenbrand wrote:
>> Not a big fan of all these "bad PTE" thingies ...
> 
> In general?

In general, after I learned that pmd_bad() fires on perfectly fine 
pmd_large() entries, which makes things like pmd_none_or_clear_bad() 
absolutely dangerous to use in code where we could have THPs ...

Consequently, we stopped using them in THP code, so what's the whole 
point of having them ...

> 
> Or not a big fan of the fact that every architecture has their own
> (mostly) copied-and-pasted set?

Well, that most certainly as well :)

-- 
Cheers,

David / dhildenb

