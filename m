Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3AE3EDAB8
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917005; cv=none; b=CQqbOWcQ3kHCt8cm/4CEhA16/5WUnDV+frv60yJJx8Mz0tRwRezvwcayd5UIWvfHEZB6Y8ASWrCLqGcdkyz1UzSVQyuA4GoY0NqRcWpGCyhQL9jg7NkjOFkaZxGrNvbH8C1eG424LYkbIqVIYPiqOiphzI56o8pArWyGmWUkZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917005; c=relaxed/simple;
	bh=754UbD0IZ3ZyfpJxh2pTTxSr7mf9C/gSQTgvqP3EsIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Esuzmo37Nxq6gmGBzFGoBlRKE+zweXna9/7rAHP+QU6dMRK1FVC56OxEBRQYR/nQvOZ0F7vVfjT1u/MHfkdaBmNQLcQ57Qh3QIuw6wniIu0zwaYq9tnn4Sp7hw8SpNjm28qP1eb2QXyFxBraxnDTuu9a9uxBNyXFb2dyRf4api8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nDWtB1o8; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nDWtB1o8"
Message-ID: <83784ad9-a51d-4c68-af78-f4f3010ba8a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785916991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSsEJ/sE1Eczg1jKOdFsL+iRe6l4DBX81fNWGZNDqJw=;
	b=nDWtB1o83TQelmp7M8sA6wsvFikCj5DjJ26GgkJMraqmpL1TeA5hZC+Agy6SthA7GB1ouG
	9iR9t/GKx3AFNc4xORkrk2aIDnpzXH8NehczDiRacma1KG6EuQO5fE9v+mpQZ6fZcbxz93
	Qb4aZ5w3aPlvMw2L9+NvjMoO2ew5r8A=
Date: Wed, 5 Aug 2026 01:03:03 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 00/22] Add Counter delegation ISA extension support
To: Paul Walmsley <pjw@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh@kernel.org>, Anup Patel <anup@brainfault.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>,
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <09a2dde3-788b-555e-22ba-2f2582a89524@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <09a2dde3-788b-555e-22ba-2f2582a89524@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/4/26 7:14 PM, Paul Walmsley wrote:
> Hi Atish,
> 
> On Wed, 1 Jul 2026, Atish Patra wrote:
> 
>> This series adds the counter delegation extension support. It is based on
>> very early PoC work done by Kevin Xue and mostly rewritten after that.
>> The counter delegation ISA extension(Smcdeleg/Ssccfg) actually depends
>> on multiple ISA extensions.
> 
> So as you've probably seen, I've started adding some of the prerequisite
> ISA support patches from your series to the RISC-V for-next branch.
> Looks like you're planning to repost the series at least one more time;

Yes. There are couple of comments that I need to address and one bug 
that sashiko found. I will send it tomorrow.

> you can either include those patches again, or base it on RISC-V for-next
> as you wish, but if you include those patches again, please note in your
> cover letter if you've changed anything.

Thanks for queuing the base patches for-next. I will rebase on top of it 
(except the macro vs inline function patches) and send the whole series 
again so that it  easier to apply the remaining patches.

> 
> 
> thanks,
> 
> - Paul
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

