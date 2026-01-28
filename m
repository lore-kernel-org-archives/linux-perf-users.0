Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC736BCF4
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619206; cv=none; b=XdxtkJU292VmZcub8v9Kh541cZ6Czx74w24IBZRh4g8GHOQfp3pr1lMS1OiQfiZA49vJHJAyNpK9ZjpOIO2J2XBABNe0bktTpNoeGNqlGPhsv7TTZVR+F1TZumTCQB7izlnfIJQd/a4XMRSJMXLmKiS/rqMAcB9xO2JtHnTF3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619206; c=relaxed/simple;
	bh=eWpnJKk8UdHoI+ua3o8K4icFP4CnjQc+SkcKnW/Djus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYQtGfyG8UuUfscjiAIf1b/bwcHdjj18fuy6j7JjQpZWJjlvJ6VPZ4xfwgMPKjCKizeIiQcSP5z5ungrKYpZJptIAbzt7JeGDjp8JjmsM59ojRau39XZxAEzj6xV68ydl2VzddGeT4nIpUyoYowYqQbpI2DvXwiKcr868+KXyKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q5HADVNZ; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q5HADVNZ"
Message-ID: <00fd7c67-dffa-4647-8370-59a195a41deb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769619193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7qYZIMiDRH0znoEAGkyJg4qEcfFLVzwdPZrMiNMH/U=;
	b=q5HADVNZJisV5eHOsAweKD+0Jn4lX5FskFED6H50DtNwSGunjQlhW0Lt2iLqNn4z7zode1
	fYFmyCVSfsTN1HsLAqC+RZSw1QCa3k7NYWxu46tVBu2C5649vZqOi9fk2OagX8KFMrCqvu
	OtzCBAjOUBI9ltak+MxVa/o1H/W9qzo=
Date: Thu, 29 Jan 2026 00:52:52 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 1/3] perf: Add rctx in perf_callchain_entry
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 song@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-2-chen.dylane@linux.dev>
 <20260128085945.GF3372621@noisy.programming.kicks-ass.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <20260128085945.GF3372621@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/1/28 16:59, Peter Zijlstra 写道:
> On Mon, Jan 26, 2026 at 03:43:29PM +0800, Tao Chen wrote:
>> Record rctx inside the perf_callchain_entry itself, when callers of
>> get_callchain_entry no longer care about the assignment of rctx, and
>> will be used in the next patch.
> 
> Sorry, what?
> 
> The recursion context is very much about the caller, and very much not
> about the data. This just doesn't make sense.

Well, Andrii, it seems we have to go back to the original way.

-- 
Best Regards
Tao Chen
