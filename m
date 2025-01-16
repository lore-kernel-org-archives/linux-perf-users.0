Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396822B585
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038075; cv=none; b=UrbRV00AXs5yDkHjU/QLNyOB8ppi7LvmXAW2etuWolEq1Ebvh/2vbUFEEc64Xgk8JqD3MTrwoDTfnCAhZvHwFDcCmraahjTrCgmPw9Wj7nF4fCKDM3eN5ojHAlOAzaXv0lkvhPVDRmdDaymz1bZ5p24UjimElgan6Q4xBTB72qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038075; c=relaxed/simple;
	bh=IhPCl110K3kK1/Mt8s1pU3zE4XJXrjW3zj7Hl7SH5JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPBRxB0ey5ea7vgL2PQMMbneAaPkVWB3Lcto9R5K1H6e6wxowIl9FqmH0dy0NGqZxlendaUbINyjSeqk7jkdGj39gzcE5n6dRtaA/9s09GVRJ+oSKZuqmFKkpp9GOs/gWF/xKKqZerxtu+DfJ96w9ZWsqF2xOHF0Uqh8Om8sv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUsW1FSZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUsW1FSZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737038072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlVUZEGdNiUP4ymo2bPnpZQRc11SVsEuAtqv0GA7FOE=;
	b=NUsW1FSZMelcbgqxxS3JEFlvdamGmIBCJPzYhf0NRkWNwIFij9vTFa9hRIvRaCAMQQaWKx
	4aUsXHBk+nPdBftFZwxSn7crUIdU0ZBbuudrzGaZ2iVGne9kSd4vpZU93nr1JXo9uwyaFh
	koJzcJ77AOsn6jKkuxA1miJkMT+kDiE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-BExd9ODSPDuETvu3HtJMeQ-1; Thu, 16 Jan 2025 09:34:31 -0500
X-MC-Unique: BExd9ODSPDuETvu3HtJMeQ-1
X-Mimecast-MFC-AGG-ID: BExd9ODSPDuETvu3HtJMeQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361ac8b25fso4842045e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 06:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737038070; x=1737642870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SlVUZEGdNiUP4ymo2bPnpZQRc11SVsEuAtqv0GA7FOE=;
        b=nXj/KEhQ9k8Ht0sfLQ7K6rJ7mwJmqXu0pyAW/RLZvo2uAwHX8QBCTiNapkllq/MmNC
         DItiePyoMVDrwKTlJvm7Ctljjd0HHVAuHWWxuTz6+m2mr0zEBBpAee+li5LMOMoQITTr
         XCma76s482GqfVf6JhgNclFiRUW6ZH+GIbIjWBnGF9Va6StVgf2vaZ8BsOvrR3R9lAXY
         sPz3zRH48mJJ/Ki5N64NdMCfTV7C65x1Bh9/qihy0d753/f6ZlgmrOVom2mKezh4Ijz3
         vdR5T03RAZEXDQ2hDMyRUhK2X3SzOI7awd/ZLbuQWq+fr6fjOAtE3vi1yyav7HSMVisL
         MZHQ==
X-Gm-Message-State: AOJu0YzCVPu8rmgi0pyxquWVDD/Evp1N/LQG0bUW1n4k2u3Lodk4F/6g
	BpPSdMsd11I1zjWe4sKIxKOE72n5QBUHTkA+LmIgWRVQ6HqK7mVR97Pqm8JEClxqres2Iqs8PcE
	v3eYH43Ye6S5AVBqNrlW4Fwm5e+O7tQUWypli/C/dC6ryRpqtUiULl19Q1opnbIp/Y1s=
X-Gm-Gg: ASbGnctnN9C3QaWoMbPdU/9jNG/Fswad3uWoI6zMyk0Ol6KqZX2MB057oiMJJtbfWo5
	oEJd3FS28/kIMaGGoow528/2zLigOn1X8G3WZIZe8+11irveI73+yA3V39sfHI4LYTUTlw2XCIY
	EP8X+yQPeJNcif8fIXqhTdGiT9qht5xaeyglL+IObR9HuVIlaKqKD9wt9kM/GaXLS7TFb5Ebjsw
	bULax7m60F1wdXBRxw0Mx/m84ClAA/w7SfWvxR6vHy6Ut+c6DaMeIPQP7f71uMKP2k+jmHVkbj/
	1J7zSAnMeCk=
X-Received: by 2002:a05:600c:1552:b0:434:fb65:ebbb with SMTP id 5b1f17b1804b1-436e26be5a3mr330748585e9.17.1737038069942;
        Thu, 16 Jan 2025 06:34:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEa76TR3MKycVQl9SMPVCKzQ43IgjBdPHU2kCQq9eJUFNO6UIGhk2rvGTtL3WQvOIi1gvemw==
X-Received: by 2002:a05:600c:1552:b0:434:fb65:ebbb with SMTP id 5b1f17b1804b1-436e26be5a3mr330748295e9.17.1737038069512;
        Thu, 16 Jan 2025 06:34:29 -0800 (PST)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221c25sm33133f8f.23.2025.01.16.06.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 06:34:29 -0800 (PST)
Message-ID: <2ccbae71-0a65-439d-825a-26dc2261fbcf@redhat.com>
Date: Thu, 16 Jan 2025 15:34:28 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf kmem --page stat and gpf_flags translation
To: Steven Rostedt <rostedt@goodmis.org>, Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org
References: <87be5f7c-1a0-dad-daa0-54e342efaea7@redhat.com>
 <20241121100326.645bd0d7@gandalf.local.home>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <20241121100326.645bd0d7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/21/24 16:03, Steven Rostedt wrote:
> On Thu, 21 Nov 2024 14:54:25 +0100 (CET)
> Michael Petlan <mpetlan@redhat.com> wrote:
> 
>> Hello Steve and others,
>>
>> We have found out that perf kmem --page stat sometimes fails like the
>> following:
>>
>> # perf kmem --page stat
>> 0x2aa28 [0x8]: failed to process type: 68 [Operation not permitted]
>> error during process events: -1
>>
>> This seem to happen on s390x KVM machines.
>>
>> When we tried to investigate for the reasons, it seems that the problem
>> is caused by incorrect/unexpected translation of gpf_flags for event
>> kmem:mm_page_alloc.
>>
>> # perf script
>> perf   96553 [003] 100299.663963: kmem:mm_page_alloc: page=0x1a8f9 pfn=0x1a8f9 order=0 migratetype=0 gfp_flags=0x500cc2
>> perf   96553 [003] 100299.663995: kmem:mm_page_alloc: page=0x1bc3f pfn=0x1bc3f order=0 migratetype=0 gfp_flags=0x40cc0
>> perf   96553 [003] 100299.664001: kmem:mm_page_alloc: page=0x1a9d9 pfn=0x1a9d9 order=0 migratetype=0 gfp_flags=0x40cc0
>> perf   96553 [003] 100299.664011: kmem:mm_page_alloc: page=0x1788b pfn=0x1788b order=0 migratetype=0 gfp_flags=0x40cc0
>> perf   96553 [003] 100299.664023: kmem:mm_page_alloc: page=0x17993 pfn=0x17993 order=0 migratetype=0 gfp_flags=0xcc0
>>
> 
> Does the same thing happen with trace-cmd record?
> 
>  # trace-cmd record -e mm_page_alloc
> [ run tests, hit Ctrl^C ]
> 
>  # trace-cmd report
> 
> ?
> 
> If so, could you send the trace.dat file to me.
> 
> Thanks,
> 
> -- Steve
> 

Hi,

is there any progress on this issue?

Thanks,
Veronika

