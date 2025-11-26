Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6848309EEA
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149367; cv=none; b=rm5PqOyPN2cgmpMF8LscIqopqS3VhkNjyevYp2VJ5DBEDkWi5PpE7pgcqpMbpp5cPvzFlR7scrUd5FgXA/pjLy5jkhzdqtjja95BeE4JSTGwieu/fIMfDLEUb6P5YTjTxACPRe+dBBhVML43FoeAD2GnD4KNJZ5elT9PffBW+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149367; c=relaxed/simple;
	bh=GC99hb77UWnEnm28EUGHOhrCiQq3dsAhYdNfjDaBqx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PR1Y6QDNOg/GufAwO9pmoxq/5M50oZy+bREsTzX/srzm4Bu7EcXiyVK/9N5yG/4eQTz3+7wVjc8xY69gAFwDxThLQzfgz+nMhaGiCcWlDWv0RfQeopcLljhIodfIYNk+Y2QBa2pDm87Qa79NI4eYu5lLtAuvJNlEVDTjVLEKdSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iujxercK; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iujxercK"
Message-ID: <7b82e322-eab7-4fc2-9de1-d10ad8251378@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764149363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyvxBUAQtvL7MLXjozd2sOG3RxdZ5x/jz3IM+iSQnko=;
	b=iujxercKX5myW8jvCC8bZIszUqjIHqFuuXCfZjhQ8/+ltO/GjfcaRJ6V8trg2t1uq7E7sP
	8G7UBYks3QUmsLj5geyeMrer1ubOHYsgrP6jPhERvCivkZzS5lm36sZmrIBr8Xma1wRpxE
	gfrwCFP5qCS2u5sRXUMNVj0qC+Yb9H0=
Date: Wed, 26 Nov 2025 17:29:12 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/2] bpf: Hold the perf callchain entry until
 used completely
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <c41372ad-1591-4f2b-a786-bc0e19f8425c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/11/14 00:01, Yonghong Song 写道:
> 
> 
> On 11/12/25 8:31 AM, Tao Chen wrote:
>> As Alexei noted, get_perf_callchain() return values may be reused
>> if a task is preempted after the BPF program enters migrate disable
>> mode. The perf_callchain_entres has a small stack of entries, and
>> we can reuse it as follows:
>>
>> 1. get the perf callchain entry
>> 2. BPF use...
>> 3. put the perf callchain entry
>>
>> And Peter suggested that get_recursion_context used with preemption
>> disabled, so we should disable preemption at BPF side.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 

Hi eBPF maintainers,

This patch appears to have missed the eBPF maintainers on the list, 
please review it again, thanks.

-- 
Best Regards
Tao Chen
