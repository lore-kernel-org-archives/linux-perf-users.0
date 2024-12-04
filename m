Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932F19046E
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Dec 2024 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300493; cv=none; b=nQlwxPV750vJ8f38f4319zeQTU32t5/T6kHCwaPEI9lLMEMgZfscu7YXcmjKdO7ykm4E98viJe8oaT3ePsV7ciS8j2zP33N6vpclaau0w6QsqHGqmfRPZkoJG3ZArezBKcTcTc5T7H007myK6g/5ULMluVAxdLzoj3WinCHNR9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300493; c=relaxed/simple;
	bh=INY9mpqFaulyLsWmDzV/MGEDnFkmp60CsqzTyDC4cGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+P0W3FhaUuSxsxK74eHsApBwO6AayHjGRHz6pezTb+EKKZDUo1sxG3Yky7JX8RWpRqrdN3YPXaRNdP+sxGl2D2ErS98PLWi7rnTLpkV1q95XBxz+IXeqZqMBcv8ggH/dN9kW+8oYKUmc7THpi/NcqkVOfcxCWzm0zmgjr4faww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RhEPhAr3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RhEPhAr3"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7251731d2b9so461200b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Dec 2024 00:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733300491; x=1733905291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kk1sTvFp0qvnbFsozJPsxYQlZYVQ3TP1Z7kQcIXY9c=;
        b=RhEPhAr3lH9gBVU95tWbX/M2Bzr3qno5vsGlxa9Q/k7bnf1Ufq+BxGE1OBAx9Imy47
         61DQL4oWrIIzSsPFL/zHEz+Z43Y6caUOk07QM3SNJcc3HU0t1dgmVIZQqV3SKbPLAH5n
         JC94keM1cscktR6a7p1jeW3z4T6SUoAfoz4AJk8Aei8r+cyPnnKSkrAF+3NSp4syYJaB
         HOA29aBUPeHNOw9OmdqI0+GhhW8/FzmGwh/YnogsXbBLPUxSovpe0xNqpgZ6dr7ykQBq
         u565L/qdqDtsg/ISMtJpu3lqnY3LxbTPM+2jUPfU/kn+N0wVdZtRQoYKo5fpPW/HTqT8
         zfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733300491; x=1733905291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kk1sTvFp0qvnbFsozJPsxYQlZYVQ3TP1Z7kQcIXY9c=;
        b=IabWmfhwZ6uPiFRE5uburMUFXJEtz34440Y8oAY1iPkfYv8IGLFO+Nn4/zHmfEoNfX
         cAGlwJwKHuM6EWEKlXn6t0k2Xi5OGvJr4NxylOOoQOl937AB08YvL+TWSlWBC5RYclbl
         JqrOam/kTfE5QrlkRMqoqGW9vGVNtmAPofDxTUnZdUHVxhCe7yQEJcH8+jaKZjZAa0EU
         DpBqxR4XjkCoKtgESHbmYW6LavTek4DUUEqtJuNbqu5YxIUwjUuTDufzCWgVRkAKO6pK
         Q6PvopTXmUQ6BCsI6kgSgWQRjPBLU532Jw/ghril/M7pCK2GG4mZu9UBleGhurOXxYpd
         WlHA==
X-Forwarded-Encrypted: i=1; AJvYcCVH8DQpsxyBzWRRHkV7+rHyBQSLLfXvP2Fu8HszhxJ14dXjuhwXZUVFqsTjizv6C8IR71qeQ663+tXlLUt+9NKY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj9/TDrMkHwGYIcAbYms/x6pR31fYocwVtxvOC+anpj39F/QoP
	8uh57zwSJpR2MUMrFgTYFRYdCZ1AvyleKhtgxTAf72c4Xah47gDtAHwsObmosXs=
X-Gm-Gg: ASbGncv6G67dsaul8Uf2K3LvFZzYvAwKi5K6Hv4hayWr/47de7KTZYQiapLH0bmgVJl
	hLaqGmtbBeY2Q0PRsyH25I+NUTq8f7E50eswJjNLjNMR42ffJdVPr+g6aR95yiVz0Re3mG+kMEJ
	SQMJy3n7S1JO/uaHtRi5z+NNJPmmxqW1XY7O6RXeTSBJQSiNMsuumMWIqIWbBISGWiOO9HT6AI4
	nip8ZGQrOK3wCT2gQiBb60R9TeyNCoN8yB4BxSIWI7uFb7i7K62MbQq7fMwUyY=
X-Google-Smtp-Source: AGHT+IHauJW3oHSpYN/fZyF2uIkgp9nqj3VGAEVSKprGisc+iDmv5O+n3P6YIq2EjN0jwGqKndR22Q==
X-Received: by 2002:a17:902:f64d:b0:215:8fd3:d1b6 with SMTP id d9443c01a7336-215be6fca4fmr91701425ad.23.1733300491208;
        Wed, 04 Dec 2024 00:21:31 -0800 (PST)
Received: from [10.255.194.25] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21548e144b0sm84821105ad.68.2024.12.04.00.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:21:30 -0800 (PST)
Message-ID: <528036f5-cb79-4a7f-9421-5cfa17a849b7@bytedance.com>
Date: Wed, 4 Dec 2024 16:21:24 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC 00/12] perf record: Add event action support
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 james.clark@arm.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <Z0jPPRA8JXSrwyaC@x1>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <Z0jPPRA8JXSrwyaC@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 11/29/24 04:14, Arnaldo Carvalho de Melo wrote:
> On Thu, Nov 28, 2024 at 09:35:41PM +0800, Yang Jihong wrote:
>> In perf-record, when an event is triggered, default behavior is to
>> save sample data to perf.data. Sometimes, we may just want to do
>> some lightweight actions, such as printing a log.
> 
>> Based on this requirement, add the --action option to the event to
>> specify the behavior when the event occurs.
> 
> 'perf record' is centered on saving data to disk without processing
> events, while it has sideband events for some needs, like processing BPF
> related events (PERF_RECORD_BPF_EVENT to catch PERF_BPF_EVENT_PROG_LOAD
> and UNLOAD), doing things in a "live" way as your patchkit does seems
> more appropriate to do in 'perf trace' :-)

Ok, we can put it in "perf trace".

> 
> I'll take a look at the rest of the patch series.

Thanks for reviewing this patchset. Currently, this patchset only 
implements a print() call and only supports attaching to tracepoints. 
The functionality is relatively simple.

Eventually, we can use bpf prog to allow users to customize the sampled 
data to and the processing of the data.

we can continue to expand the functionality (for example, attaching to 
kprobe events, printing the parameters and return values ​​of the target 
function)


Thanks,
Yang
