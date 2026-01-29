Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287723E34C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 03:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769655797; cv=none; b=ILXVdOmPOBnDn7RIXAHZR7dfwCAsPU/YBfBh80ybnVqlllivjEiXULPlTydkCnS5DDx3OdzpxB6JYY1ewn+AX+moHo04wVYZqinkgclR1XXvmpQBF6CIxF+9AlQTU0WXscS487e4+AA0EKUiRUO5+NMAo+UVrSUm3FcG6AIWm0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769655797; c=relaxed/simple;
	bh=P6xf8lFB1hTmPq1NVVLE+dooHI5xqpYcpXWYE5P0BAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQbS7ErxDibPmWbFcSF07QZJVLNtOF/+spEXpCxjYAut9apvyz6cNPfxTv/k/AlvwLzNGYzCpcNlffXgLRudk0djnb1GlgONqZiRL+1hTUDdjtP2vmSH09kqgBUQ83yRScm1wET9VqrU0a94FAx7huftPLH8ta4HcQxOWJwKqEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S+gvwAXH; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S+gvwAXH"
Message-ID: <459af099-540f-4ce3-945e-fdf38896d03c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769655792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evNmSKHBc95d34h6t/+bPmvmGHn/9tXbG9cMw4fwkfU=;
	b=S+gvwAXHrPnOF5+rIrYovEQTKjWbvgM6EJNzkx9LlNL1KmYBAKRjgZTu1rqzWjXfyTNhru
	VHCGh2WhT0zt5uWXtv8ifqlhCd7giUFNWtzQ3lCEtFHht48+8nvC01+HJAQbi7WPQ5i44k
	d9Jo4jvvvgUIG2TjodmEk2q1G4eC+1k=
Date: Thu, 29 Jan 2026 11:03:02 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 1/3] perf: Add rctx in perf_callchain_entry
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-2-chen.dylane@linux.dev>
 <20260128085945.GF3372621@noisy.programming.kicks-ass.net>
 <00fd7c67-dffa-4647-8370-59a195a41deb@linux.dev>
 <CAEf4BzY5tQYSnn4Jwg+cwypnwG6BLLOu6e6=f938d33eSCDObg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzY5tQYSnn4Jwg+cwypnwG6BLLOu6e6=f938d33eSCDObg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/1/29 02:59, Andrii Nakryiko 写道:
> On Wed, Jan 28, 2026 at 8:53 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> 在 2026/1/28 16:59, Peter Zijlstra 写道:
>>> On Mon, Jan 26, 2026 at 03:43:29PM +0800, Tao Chen wrote:
>>>> Record rctx inside the perf_callchain_entry itself, when callers of
>>>> get_callchain_entry no longer care about the assignment of rctx, and
>>>> will be used in the next patch.
>>>
>>> Sorry, what?
>>>
>>> The recursion context is very much about the caller, and very much not
>>> about the data. This just doesn't make sense.
>>
>> Well, Andrii, it seems we have to go back to the original way.
> 
> Huh, why? Peter is confused by your wording, he didn't say that what
> you are doing is broken.
>

I see, will update the changelog, thanks.
> The point is to couple rctx with the exact perf_callchain_entry
> returned to the caller in that recursion context. There is no
> contradiction.
> 
> It's purely about simplifying the interface. While previously the
> caller would have to juggle perf_callchain_entry and rctx separately
> (but still ensure that entry and rctx do match each other when calling
> put_callchain_entry), now it's more convenient and less error-prone
> because returned entry will record rctx it was retrieved with.
> 
> That perf_callchain_entry should not be reused by anyone else between
> successful get_callchain_entry and put_callchain_entry, so there is no
> problem here.
> 
>>
>> --
>> Best Regards
>> Tao Chen


-- 
Best Regards
Tao Chen
