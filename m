Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E63E3150
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 05:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798188; cv=none; b=hu0632PR12VI+I3r9aHFbk7Qsjg7L50VHWr/IFoechGotI30yEg7qPk98XhNk7W0dc7EdYH+i7yGdDhoIVzMfj3YT4mLq2Xh/X9G+QoThkgQfZFAlNJnNaZFxPbYGW83/jp4b7Qv1Ocmyg49ukk90xdwUo/3ire05lEDSx0SUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798188; c=relaxed/simple;
	bh=9rXZUBsGBmtMoEa+jKKzLo71wF5tmz2Z8X2eRMgLKC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3Hkmz0/H/zveuSkIiZEwhC41oHmHdSgzjii2hKYWPL67EAL9BwSVGpMPJhfY/Kcsv6I0Rm+4A+iHF7LtopH8eOPb1NM1d+bhNrsrkOpdqQyr5T9huAk2LXGZ+JyNwhRSrQ40Kn1MzkETdHQhNLNAVtetfiRLsB6g4hHtd4Lxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEGiTKHx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lZkDQkxM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEGiTKHx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lZkDQkxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782798186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/eDjU5MiOjexozee7SNJIrZyMlG/yERHTdQ3gey+uU=;
	b=dEGiTKHxgYpo19D1e1rZh+4ZpLAKKxZ9SDibQrOWQljI8ludSHZG8jfTYNUbeJXVds8FPS
	axP0nhZCbj3J30wCKpG31Q6HRzN/OO0xkPsu6K6WcUU2e/VTGWvkM1Fn38QBfuIjIRpUHS
	x0LUbbOyThtUtK3xgx8RacU5hoX1Vfk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-4Jv-M9K9MBW7gOOcUrNaeg-1; Tue, 30 Jun 2026 01:43:03 -0400
X-MC-Unique: 4Jv-M9K9MBW7gOOcUrNaeg-1
X-Mimecast-MFC-AGG-ID: 4Jv-M9K9MBW7gOOcUrNaeg_1782798182
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4926d371224so24314025e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 22:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782798182; x=1783402982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/eDjU5MiOjexozee7SNJIrZyMlG/yERHTdQ3gey+uU=;
        b=lZkDQkxMyIJQG+HdGrnGBqvHOFcYRDKCI+h7u8ijSTNYla4xfsh9La1RKXx+ip0pyB
         6yONDkQNFffPxXQ/JbtDgeR5YNOaj1h3V21OVG8uGwA1sN/WA+2Q69NVBKtn+wQ94qpb
         LmoV8hYf34dhi5s2dYVWm5JLIf4ehqTH1hoMPmsD6el/wcc8JG0OyriC4nySSRhL0Osw
         Meivv/Km8HutWPZ5G5NnUWz8yTzcYdtrwoPNHBHmWNzmyR07m1dTXTNOzN5i+BA1feeX
         tao/A5L2jG8+6/MPLP57kJoLvl8ezkwBYeDnWiRnzghcevhyrK0rSeyTNjZtKgNFmaYF
         UPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782798182; x=1783402982;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/eDjU5MiOjexozee7SNJIrZyMlG/yERHTdQ3gey+uU=;
        b=nQXLgwp7Xsub7WU0oCm/toeDvJwqOGvi9bVxIK8+qVHchyL//1xPQ3vi+34/989m0h
         XmpsfR20tMIw0yqIvRGDaRBc/ZWKwGKjvXHTsVd4BbdzClAuV/7XThPqlwiPiFjU8MVB
         YqMM0MyRCfwHEkPwBXofY+7w1Vt+aGf1QaLJ7nJ6mImJ6DS1EoGjXhvHyxTMjsC9zKwl
         giYnNGBh1ZP3liUdHScOrQ9drE9ZjUOGqxBTnRSg76lbd3BZXgE1JMNXT4h2JQ/vnL3q
         EtptlDBRJab4QgvZwEOvUrF0hOYpeQ2femze4u3tCsMU3w+KUh2Bijv49V152YMi3XRw
         6Ixg==
X-Forwarded-Encrypted: i=1; AFNElJ/2Ea1FROhIkSP9V7UIGJN/TmiwZZf+j+0oAF0hdXTnZ0zleFciWKnCGPoDwUj4sQvzZlR5pbKiSamqlyXMogdZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyMVSHp5iZl1cMSGG607ta/0sa7Qs84bS73k6DJ9m0WQ0xzdUws
	t4uMKOikb/6Lbm2dFBIdPAjAvNcpyr+Uqf5coYLqUnHnTGp7Q1N/CeoxDlqWJlfMoy+WIjwmCUN
	3ZA7Th1PISMfpgvKVAuRr7SjEIhZZ9GaYTcrnOhMVKifd5l0RH4NnEdX9qL/h3b+Z30eOww==
X-Gm-Gg: AfdE7ckOZDjryBZRn7r2YMCgJXe4B2C8CR8JQDwu/Cx2SdQoHNsMvftXK1ZZoy7oEYx
	A8F7OcyGSs6CWb+ukCqRa/L5IFWg2CY9YaimzR+lSCADIeCdUBAHyIH/udXJX3Fj8R8dvQQEpss
	9rKckprm3NDbtH1N5rHHkNcpp8VpoKN6p9o8XQ+ziqkGmMwF/QyHqcZCybXU2Wr7kXLzpHSZL4Q
	IopWB9C2WX461gnh789SfEDUv7iML+s6b+7oQKAKBZEPoJrZL6Or8pfrJsDTKIH601/ZkZ9EJJp
	Nr6Qs3FRv62YLAwNdUrtWOda3fuI4E7lFgs9YNcY9M+YciKg5+LT5VTGW94N8FUco8QgNfMpK1/
	dlTHaLR84dpclAM1WvGJkgC/Bh7hqqP2/LzwA7M8e1UyP2g==
X-Received: by 2002:a05:600c:848e:b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-493b82b0f53mr33437915e9.22.1782798182358;
        Mon, 29 Jun 2026 22:43:02 -0700 (PDT)
X-Received: by 2002:a05:600c:848e:b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-493b82b0f53mr33437635e9.22.1782798182012;
        Mon, 29 Jun 2026 22:43:02 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8cb62f1sm70244105e9.15.2026.06.29.22.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 22:43:01 -0700 (PDT)
Message-ID: <c1666061-c3e7-4eda-82ca-d03daf05f4f8@redhat.com>
Date: Tue, 30 Jun 2026 07:42:59 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf trace: Refactor augmented_raw_syscalls using
 bpf_loop
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Michael Petlan <mpetlan@redhat.com>, stable@vger.kernel.org
References: <20260623112533.1151502-1-vmalik@redhat.com>
 <DJGJ9F6WQZV9.2W4WBIHYLJQ97@gmail.com> <ajq98dm4gAwEzkMb@google.com>
 <c2f4e45e-d5c9-42e9-a46b-25fb0cacb267@redhat.com>
 <ajwu7xR6V6MAQOFw@google.com>
 <3c221e35-d642-4036-88fd-d25df7f8807e@redhat.com>
 <akLXCFpnum0WgXGf@google.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <akLXCFpnum0WgXGf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 22:35, Namhyung Kim wrote:
> On Thu, Jun 25, 2026 at 02:05:29PM +0200, Viktor Malik wrote:
>> On 6/24/26 21:24, Namhyung Kim wrote:
>>> On Wed, Jun 24, 2026 at 08:47:38AM +0200, Viktor Malik wrote:
>>>> On 6/23/26 19:10, Namhyung Kim wrote:
>>>>> Hello,
>>>>>
>>>>> On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote:
>>>>>> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
>>> [SNIP]
>>>>>>> +	struct args_loop_ctx loop_ctx = {
>>>>>>> +		.args = args,
>>>>>>> +		.beauty_map = beauty_map,
>>>>>>> +		.payload_offset = payload_offset,
>>>>>>> +		.value_size = value_size,
>>>>>>> +		.output = &output,
>>>>>>> +		.do_output = &do_output
>>>>>>> +	};
>>>>>>> +	iters = bpf_loop(6, process_arg_cb, &loop_ctx, 0);
>>>>>>
>>>>>> bpf_loop() is old and generally not recommended.
>>>>>> Please use bpf_for() then the diff will be one line change and
>>>>>> can scale to any number of args. Not just 6.
>>>>
>>>> Thanks Alexei, I didn't know about this preference.
>>>>
>>>>> One thing we should take care is to support old kernels.  The oldest
>>>>> LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced in
>>>>> 5.17 and bpf_for (bpf_iter_num) was 6.4.
>>>>
>>>> The problematic loop was introduced in 6.12 by a68fd6a6cdd3 ("perf
>>>> trace: Collect augmented data using BPF") so we should be good using
>>>> bpf_for. Or is perf from 7.2 supposed to work on 5.10 LTS kernels?
>>>
>>> Yep, we'd like to support old kernels.
>>
>> How much strict are you on this requirement? IMHO, the very least we
>> need to fix the verifier issue is bpf_loop, so that would still not work
>> on 5.10 and 5.15 LTS kernels.
> 
> I don't think it's an absolute requirement, but I think we don't want to
> break any existing working setup (old kernel + old compiler).
> 
>>
>> We could probably keep the open-coded loop in case bpf_loop is not
>> available but `perf trace` would still fail on kernels without bpf_loop
>> for new perf built with Clang>=22. Also, the code would be a bit ugly
>> and I'm not sure how well the feature check for helpers (bpf_loop) works
>> on old kernels.
>  
> Any chance process_arg_cb() can be called directly in the regular for
> loop on old kernels?

That's my thinking, too. Should be pretty straightforward, I'm going to
give it a try in v2.

Viktor

