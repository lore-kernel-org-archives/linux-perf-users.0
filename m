Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D14B04AC;
	Sat,  8 Aug 2026 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786174383; cv=none; b=YlPlWGTPTS6Z6SiNbwMwGZ4tgtbxFpryMI96jjmRVgruDbzgxUMuabF28+1mKf5ZZS0qK+qvIUS1WVR/tyReVe7wi4KfmGv4+JvcfJTTMBs9DE4B2w8U6bnteW4XuNQO5HXiXXD/eeTxfnT3husm/JSxH4HYinO4m/cC9OogFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786174383; c=relaxed/simple;
	bh=HChMSOzLztJXRYp5Rm23S0LWQB5UFl5/gH3kY079diQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kkt8S7DFYm0qt8LybnEd9d3OT3MKugniE4Amzbl/tMuv3/fNQEAk1N+w/kJHCIUrPKku6BSUS1Lp71AQ1v5uhuIY0HXeU+lFn3HifZtBvPnidPDZX+jBTPjh7WggoR+/vnZvgfv2unzJPPO+lblQV+ORy9jCGhd3/nBDlzW4YXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iovclzJp; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iovclzJp"
Message-ID: <f29e9ffc-80bd-4bd0-91a5-22feb081ac60@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786174378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCzgX6JVLx9Ko3n6wKYEJsdgvY6Ca+XBEhJnvXYRW5o=;
	b=iovclzJpjR+LMVlQGMDC1PXGZcwCK7PEsPVXonLV3I6GYXXstpcVN2tQErwnvJQubWeZkW
	SeShr/mMhxwjUHw1ENdLhSGDivCiBRGJQ/ejL80ujQs1mOQN9teOlOUsNYf1YkdNDn/vij
	ctovi6HgvbyGlh6y6/v+IOE/V1+36d8=
Date: Sat, 8 Aug 2026 00:32:49 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 05/22] RISC-V: Define indirect CSR access helpers
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
 <20260701-counter_delegation-v8-5-7909f863a645@meta.com>
 <1b20aa77-0f0f-08c7-9439-972983adf709@kernel.org>
 <920aee80-5297-4d70-a1ea-616976db7f70@linux.dev>
 <09a1260b-aa91-f993-e81e-0c636cfd7942@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <09a1260b-aa91-f993-e81e-0c636cfd7942@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/7/26 6:04 PM, Paul Walmsley wrote:
> On Wed, 5 Aug 2026, Atish Patra wrote:
>
>> On 8/4/26 5:39 PM, Paul Walmsley wrote:
>>> On Wed, 1 Jul 2026, Atish Patra wrote:
>>>
>>>> From: Atish Patra <atishp@rivosinc.com>
>>>>
>>>> The indirect CSR requires multiple instructions to read/write CSR.
>>>> Add a few helper functions for ease of usage.
>>>>
>>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>>> Thanks.  These macros seem better implemented as static inline functions.
>>> That also nicely aligns the code with what you write in the patch
>>> description.
>> I don't think inlining these macros in the following way will work because of
>> the following reason. It won't build once anything calls it.
>>
>> csr_read()/csr_write() stringify the CSR argument straight into the inline asm
>> template:
> Yes, you're right; I should have caught that.  Too bad, there are multiple
> keyhole CSR index registers in use, otherwise it would have been a
> reasonable thing to do.
>
> What's up with the subsequent followup message?  Looks like a
> cut-and-paste from an LLM.
Oops. Ha ha. LLM agent was parsing the lore and preparing a draft response.
It produced so much garbage that I replied manually. I have no idea what 
prompted
it to send it after I sent the response! Sorry for the spam.
>
> - Paul
