Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2E763B9
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2025 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885416; cv=none; b=dRNlHejVnH/OqUsdgKFoHXtfM4rjCeZoJUQn3OD+/2e5JSXo22Kk9BRfSEdcxAWjp0HDL48Uavf5yEEGZVdHCvV0il4LLkCkpgl6HDZxuqNFC7lc04KpymAtp2pXK1tKZi0AkWpgj/Zgf8yavt3nusY/DGec00qwcBMT3iy9tNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885416; c=relaxed/simple;
	bh=rHd91RDVZblAGkL9tzN0XV7AHBKS9VBYY+yYlPibRN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KM7K8u3jbi/Jdb+kVIMktO0nbebwv7x/xzYKVRBwr6ozN/qk+CJNYCLeC0mocRFbMTegUJaesms5lgzCS3sgdNoJlO6GqLkdWVO6mn5gls/hZF70YY8R9Q8NevV7jkRgRVLkz/5/vOpGJyPC1I66zSF/oqFvWo93cTxpBDLQs4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vIhwNBwy; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vIhwNBwy"
Message-ID: <87b67a79-d97e-4f81-9bf2-aa34d613b5bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741885402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wcq4k6tGNSE5Yn0/7eafZbLAzGJWuw56xZay697EIM4=;
	b=vIhwNBwyHcr4PEAJ+pjazisIdLm3yG/A5zwei8NPmLqDjQ6IOTHy01O/9FtFgD6hh3KdfR
	+7fCO5ZSKg4n0VsNshOry0CZdgerepmy+4FyKS8bDo2lstBFkYTAa/fXRAaJlV8/jMZwbn
	bUTKZu4eXRYgg2qhMFH5982CoukTRy4=
Date: Fri, 14 Mar 2025 01:03:13 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH linux-next] perf/ring_buffer: Add EPOLLRDNORM flag for
 poll
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250313051047.2436098-1-chen.dylane@linux.dev>
 <Z9Kt57aAC7XET7Na@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <Z9Kt57aAC7XET7Na@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/3/13 18:05, Ingo Molnar 写道:
> 
> * Tao Chen <chen.dylane@linux.dev> wrote:
> 
>> The poll man page says POLLRDNORM is equivalent to POLLIN,
>> so add EPOLLRDNORM here.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/events/ring_buffer.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
>> index 59a52b1a1..5130b119d 100644
>> --- a/kernel/events/ring_buffer.c
>> +++ b/kernel/events/ring_buffer.c
>> @@ -19,7 +19,7 @@
>>   
>>   static void perf_output_wakeup(struct perf_output_handle *handle)
>>   {
>> -	atomic_set(&handle->rb->poll, EPOLLIN);
>> +	atomic_set(&handle->rb->poll, EPOLLIN | EPOLLRDNORM);
> 
> So what does EPOLLRDNORM mean to begin with? There doesn't seem to be
> separate/specific handling of it anywhere in the kernel that I can
> see...
> 

It seems that if user set pollfd with POLLRDNORM, perf_poll will not 
return until timeout even if perf_output_wakeup called, whereas POLLIN 
returns.

> Thanks,
> 
> 	Ingo


-- 
Best Regards
Tao Chen
