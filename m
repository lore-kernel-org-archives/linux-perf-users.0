Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9241E1DF4
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385782; cv=none; b=gVJ5hsf9ljsP6FQX3WqXsQldQHQFARCkVc3DlMewpZn7JtUMhF4EMynPSP/XB/K3utZGp9cnWJ6QVNeRk13kVWBBsbx6896nScpWtpsT84T0I7RSuAeWVVaYroxjVU3EqVYvb8bBY7T7G9UAogTuImZmE/9fCKrYWI0IBADyFt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385782; c=relaxed/simple;
	bh=0FwV0HNcL+vt4qpXO6jzr792i6b6LgV0sJ5JC4nVi0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxKY2CfR8hoTZTq7uzGOMgg9bcKex6f2o581GI/LhbYz4UuW8A2F3VSIx18G/xan1y0EbCbu1xX2QF4DoL/iZV+7PkRgPx5R/xfjU1QwCIbLL0sifyaGTgeIMBXHBh4RpP/Vz8rpiLHXkwN13umgvJYqqpHuNg08lpbgLDAXchQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y20+15DA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y20+15DA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742385779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7gn15plHVRiqXpFBn0Z9q9dTxOPDKBEPCsHLFphLWXc=;
	b=Y20+15DAQhAkFq3bvd7HKEgB0wHKYqiQcPn9ZtAlUqqQAYzSPTKiRUQvaRqE8r7Gof9Hgm
	87+jiRYSjXGrPHczw+xZqy4KwY+8i2YPtcEpD08bf5eG2q9z+lqvBjT5u947CUNTL72+1M
	QkaUrC4/Zy6/CLAy6+nQfCah4lCf6IE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-SPDL-fy5Ora4Bmy7hpph4A-1; Wed, 19 Mar 2025 08:02:58 -0400
X-MC-Unique: SPDL-fy5Ora4Bmy7hpph4A-1
X-Mimecast-MFC-AGG-ID: SPDL-fy5Ora4Bmy7hpph4A_1742385777
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so32744605e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 05:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385777; x=1742990577;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7gn15plHVRiqXpFBn0Z9q9dTxOPDKBEPCsHLFphLWXc=;
        b=Ke55RYr2C4MUPLuvO7ejrll3laGftSWX6oM1PFM9HrnsBC2Z5xUmlDW4lk+oy5AQCd
         P1VA7PNOUfMypcWdrw0eUwTi14z59y9vTWDq1/DuDQ6Nk7pjVIEV4cp5w8mVTtZ27Lnh
         OEO6D98Dl7EpsPLyxmNJVdVWj3ndMyslB6GMjaPxsiXylwYfV8jK+/xgbH3Ph21x1kRL
         0omcHEDKTpz9LWM06snlz858ZwODMnTWGN+qH8S670/J1Vr+i19b2FBcapedHEWZDfL+
         5r13PuSwFGcPEayV7ZIHt5pTKKlaudKdHpnW4DeOuYhBLiSO67iXWbBSLVP5rNMH1thJ
         haeA==
X-Forwarded-Encrypted: i=1; AJvYcCW2e+HvIBztWfCnrDAza+WzF7/FZFZhebp+QdoM+Tva9g9pNWIF7fpLJDvQ1JQWDchQBjbZTctoMUy8MzhHztMa@vger.kernel.org
X-Gm-Message-State: AOJu0YyjjOupg+dH3l14w/CbizMSgxxm3xt5rI6+RulgM1A+xx9N5T8R
	H+sglxS0jiUmnZ1ju2gxIu+VEz/YZWRFzk5qUAR3GJjVUDn/aDuPLvU7VGqXg/5awg77JO0c7iS
	W+Cg5PQLUFebc0zU4vG4c60E35yXY6g8OmmrdOCCP7AWo6PyXXn09Sb3CLIo9lzPxvuA=
X-Gm-Gg: ASbGncszKHscZahzk2OqG3ySmmUeXPDZ8lhKV5/s+N9AsPzRImjavYfguJIyNqPc1Yl
	ZyAV1po1g4vWldHJB3Cjc/fY7jy2Je141rT9Wyb1hHQwGxdLKK9q2HtTbkmAIxsPZVUPL/KhQQT
	IJtYlQpp29RISnGd+2e0hF4p5UlIvnoSJMeWj2MAqHywByGIo9nxiCUTQ+Wv+bvaFu6IHly0hSh
	K+EM24nCJ8HA5ObXybuOXtxccZr/H/dgqKHZ9ZnHsU52p5jkKEAFyJSSBY808N7mm9c5l+U38ns
	RT1/hI5Z6P//P29A7BjCMx2uEz/elFeWfMtzg8omMdedMq0mApe0/Q5TVmTBC7o70qj02ccqa0V
	LMTYflq4Ci7Coyv867bySjvSNvk8aAcprUz7hgkoLr8g=
X-Received: by 2002:a05:600c:46c6:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-43d43786292mr21442955e9.4.1742385775942;
        Wed, 19 Mar 2025 05:02:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO9wFO2nTkTUlJSs58/meqK0dfmIPHPe7ubDLeTE+LBbIu5UE13qcBy19o/yn3H77bmuGCZw==
X-Received: by 2002:a05:600c:46c6:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-43d43786292mr21439295e9.4.1742385773180;
        Wed, 19 Mar 2025 05:02:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:df00:67e8:5c3d:de72:4929? (p200300cbc705df0067e85c3dde724929.dip0.t-ipconnect.de. [2003:cb:c705:df00:67e8:5c3d:de72:4929])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed4cbsm16960215e9.34.2025.03.19.05.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 05:02:52 -0700 (PDT)
Message-ID: <d0f0cbb3-6284-4060-afdb-ea828b9e909d@redhat.com>
Date: Wed, 19 Mar 2025 13:02:50 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] kernel/events/uprobes: uprobe_write_opcode()
 rewrite
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Tong Tiangen <tongtiangen@huawei.com>
References: <20250318221457.3055598-1-david@redhat.com>
 <20250318221457.3055598-4-david@redhat.com>
 <20250319120028.GA26879@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250319120028.GA26879@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.03.25 13:00, Oleg Nesterov wrote:
> On 03/18, David Hildenbrand wrote:
>>
>> +	if (unlikely(!folio_test_anon(folio))) {
>> +		VM_WARN_ON_ONCE(is_register);
>> +		goto out;
>> +	}
> 
> Don't we need folio_put() before "goto out" ?
> 

Yes, thanks! ... as always, the result of some last-minute reshuffling :)

> Other than that, for this series:
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 


-- 
Cheers,

David / dhildenb

