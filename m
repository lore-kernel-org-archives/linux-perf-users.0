Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536421CFF6
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754459; cv=none; b=koFhjhjYX02Tzp9GpwUQhxsrt7w9ErXNGny0Lr01UwklMSJBMVDKbqVYtRuaHWpn2MmTSUsYaBg+Te7rQHoFSFj3xx+7r/bN7QkJ38qkjfdDtbGVchYh6VPdvIcp7j6TbSboW3XXGfWHyY0toos9cOXbb94PWC5aVwladgWZJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754459; c=relaxed/simple;
	bh=0pUTBTrWOl8vMGRJx5bO7WE+waJ3ARqGwRgiHBOo3nQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VBh+cZLC7j6OACiMFxj+9+Oe9SXWGH6kui7N4TTNgwPXMsZVfd1sbELcs/8USYB6ublR7fUD8qehDaMwXS75nVYmnzdQ6rK+MinNEJ9mfbGWZz8f/BvdNeFpQmO2mXQl/rKoPm5wN+w6bW708K0IMY8gUqvGUvkNOg+Q+3XfY58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=inK4SRCw; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="inK4SRCw"
Message-ID: <42627219-fa33-441d-b8cb-eb48ab3230d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764754443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ze5QiKE4t50u1X7fPBtOrmNysQ7fIpo2Qo0fD1u03Po=;
	b=inK4SRCwjrw64hrP/g8a9/GJoEI1Vv9gN9G74fIQeIia4xJdSo/MxKgtYqXg32Fd20jnVt
	YwBhbRhn9lx0T4TbPk2o3F257J3K9aRRrfEIFjPtFA25DVG7RXHqfk8+Qh4la02LT+lfMs
	JX+X9hRzcna6eE3xyyebb0jDPoIqLlU=
Date: Wed, 3 Dec 2025 17:33:29 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/2] bpf: Hold the perf callchain entry until
 used completely
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251112163148.100949-1-chen.dylane@linux.dev>
 <20251112163148.100949-3-chen.dylane@linux.dev>
 <c41372ad-1591-4f2b-a786-bc0e19f8425c@linux.dev>
 <7b82e322-eab7-4fc2-9de1-d10ad8251378@linux.dev>
In-Reply-To: <7b82e322-eab7-4fc2-9de1-d10ad8251378@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/11/26 17:29, Tao Chen 写道:
> 在 2025/11/14 00:01, Yonghong Song 写道:
>>
>>
>> On 11/12/25 8:31 AM, Tao Chen wrote:
>>> As Alexei noted, get_perf_callchain() return values may be reused
>>> if a task is preempted after the BPF program enters migrate disable
>>> mode. The perf_callchain_entres has a small stack of entries, and
>>> we can reuse it as follows:
>>>
>>> 1. get the perf callchain entry
>>> 2. BPF use...
>>> 3. put the perf callchain entry
>>>
>>> And Peter suggested that get_recursion_context used with preemption
>>> disabled, so we should disable preemption at BPF side.
>>>
>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>
> 
> Hi eBPF maintainers,
> 
> This patch appears to have missed the eBPF maintainers on the list, 
> please review it again, thanks.
> 

ping...

-- 
Best Regards
Tao Chen
