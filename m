Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C80520468A
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733859340; cv=none; b=J09/qUpA1TiMUguW8ABv1ruSU08TaseHipKy3CgHFNDzPIV7echo/+58ws+lpfpbpE43/q5bg5CR5DdRTKljL6mGRH7HsiWir4LalD7A8SqRJnNIQxD4r8ZI9wN7P93LCMS0U9ZRvV89ZySUwW9OfXUsfWO2xTggfWN1VVXGG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733859340; c=relaxed/simple;
	bh=D4Tzn9/NmXEN0TXG1AxK8mUxfuuCZ+u36vl8FHG0j5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDQd4IT+qbMjSCrRY63ydNU8t+gxHrgxujNfZ1R4Pdy2g24C7yAeZ9UlzXCOyY9yVVCVSvYE2yVT2J3iUFrjuKTupj5cnfr4ZKpsnehf+cGuMjcRT+zNEglTIj/tfwcG3v7HUKv3X04+tkvY29FIL92GqIPUl/LRvs9PkYoR/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQXmL0ui; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQXmL0ui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733859337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KDnAKXJwYVbACBYDkjpxdvLPwteH3j/a2Tcuj6fTOwc=;
	b=AQXmL0uiZ4mgh5FADvKRRRg3Ff/sjs0QeLtWtXF4/rercT5PPH/9I5DHLO+C1MBLlWBzKR
	7Z9FviHXkbrGu7khN8aPOGWKb04FoX9RmwMbnRkLS+9xm1w5clFi+waS5+gAK7lmbNQUZm
	aFlWDDwsDAY0nNNSaaA/OB59+V4E/Zo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-SYwBeQAoOUyOGPD2uEXmMA-1; Tue, 10 Dec 2024 14:35:35 -0500
X-MC-Unique: SYwBeQAoOUyOGPD2uEXmMA-1
X-Mimecast-MFC-AGG-ID: SYwBeQAoOUyOGPD2uEXmMA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434fe2b605eso13019715e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 11:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733859334; x=1734464134;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KDnAKXJwYVbACBYDkjpxdvLPwteH3j/a2Tcuj6fTOwc=;
        b=UOtthncEWA1XxXq+ZQKbx0Qpo9FMDV7taeHECnYNd0mgqlf5BigNTer1DsgGlK2Phj
         Q5eq5tS0r5D/QvYKi1mfEiQmJV+nnJo5dyyTxFnwIt8HHadHpx4UR95TkeHpVGIOEfJy
         P8hHxIdTT2cCxLcesBWHNYL6PZBYMqa1Xrgdwdw33Hf7HtZ806cev0qg2xYnXkrtUUSN
         Fp5YQUCRa+sH2cmfghAT1H00tlF2WY0yGWE9joJAF5f5AobuS28Ka8axQijT+jNCJWqk
         heGm70QdaMsPbXgGheiBbnIy5C6md+HIVK5UINu41PmrbRgVko8JdcxepTJqHvzcb9EJ
         2Lvw==
X-Forwarded-Encrypted: i=1; AJvYcCUXO0r4QhdCILuydmWILGeBja2jsWZmC4GbpCUO77lT+AoHfucAQ2uCLUysWsk3x6mLUK4jvrOaib/kuVLHJ542@vger.kernel.org
X-Gm-Message-State: AOJu0YzZyuYoBo5IRGAM8AWbGVgm7kaAnaoIeAEuepIBszzgjmJ7wdrT
	Y9+FdjshOjtxeh+0WCth5sexc4G5UkT08KTt/4mcjliBbNGn25Mw+txX4tT4mgJabtJqW1DGMfB
	MEf0V69zxpDsS3adU+suT5NJMoaWQ0g2algs5MS2C2Hpbhgr2I60qCZ1y7tr+UVu4feE=
X-Gm-Gg: ASbGncs3jlf0tG33e96a6uRxo5hrmsv6IviA2XdiAIs+P1dC2B62hGKwvnwiHWL19iZ
	2mO/r1iZiQm1LEe6gPTO0CG6C7/ptfQRVo+FlraPu9gNyUBLjS3dADlPOdYz1mIN4gUPcuxbbgx
	UalS+HiB7uGMuflOKUpjAlNSGrwMEExZISIQfP2HMTgfvBOt54S5YaSBwf4tYEppi+F8lOCAGBD
	gsB2jjNkBJ/HlWMWdfje08m5sixb5N9Sh7hLp7lApz+HoIv32YVhwIyQnveaE3h7/VuDRPMxaxc
	B4adxLM=
X-Received: by 2002:a05:600c:b86:b0:436:1c04:aa9a with SMTP id 5b1f17b1804b1-4361c374ac1mr630735e9.14.1733859334472;
        Tue, 10 Dec 2024 11:35:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBUXHjhtlw8/1QueJHpMGcjVCrJT3F2y9hBP2xWGRVmtvdEvEWnAe3y7oVbtr0ovUSi9vGUA==
X-Received: by 2002:a05:600c:b86:b0:436:1c04:aa9a with SMTP id 5b1f17b1804b1-4361c374ac1mr630555e9.14.1733859334123;
        Tue, 10 Dec 2024 11:35:34 -0800 (PST)
Received: from [192.168.3.141] (p5b0c61ad.dip0.t-ipconnect.de. [91.12.97.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-435aab63baesm27114775e9.38.2024.12.10.11.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 11:35:32 -0800 (PST)
Message-ID: <3bd43f87-571a-4bc6-b068-69056ec18d85@redhat.com>
Date: Tue, 10 Dec 2024 20:35:30 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fork: avoid inappropriate uprobe access to invalid mm
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, Peng Zhang <zhangpeng.00@bytedance.com>,
 syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com
References: <20241210172412.52995-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241210172412.52995-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.12.24 18:24, Lorenzo Stoakes wrote:
> If dup_mmap() encounters an issue, currently uprobe is able to access the
> relevant mm via the reverse mapping (in build_map_info()), and if we are
> very unlucky with a race window, observe invalid XA_ZERO_ENTRY state which
> we establish as part of the fork error path.
> 
> This occurs because uprobe_write_opcode() invokes anon_vma_prepare() which
> in turn invokes find_mergeable_anon_vma() that uses a VMA iterator,
> invoking vma_iter_load() which uses the advanced maple tree API and thus is
> able to observe XA_ZERO_ENTRY entries added to dup_mmap() in commit
> d24062914837 ("fork: use __mt_dup() to duplicate maple tree in
> dup_mmap()").
> 
> This change was made on the assumption that only process tear-down code
> would actually observe (and make use of) these values. However this very
> unlikely but still possible edge case with uprobes exists and unfortunately
> does make these observable.
> 
> The uprobe operation prevents races against the dup_mmap() operation via
> the dup_mmap_sem semaphore, which is acquired via uprobe_start_dup_mmap()
> and dropped via uprobe_end_dup_mmap(), and held across
> register_for_each_vma() prior to invoking build_map_info() which does the
> reverse mapping lookup.
> 
> Currently these are acquired and dropped within dup_mmap(), which exposes
> the race window prior to error handling in the invoking dup_mm() which
> tears down the mm.
> 
> We can avoid all this by just moving the invocation of
> uprobe_start_dup_mmap() and uprobe_end_dup_mmap() up a level to dup_mm()
> and only release this lock once the dup_mmap() operation succeeds or clean
> up is done.

What I understand is: we need to perform the uprobe_end_dup_mmap() after 
the mmput().

I assume/hope that we cannot see another mmget() before we return here. 
In that case, this LGTM.

-- 
Cheers,

David / dhildenb

