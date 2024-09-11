Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFAA64A8F;
	Wed, 11 Sep 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042494; cv=none; b=Oe6BoxkK+h6YDYIeNwcoiwDQVhIl959HMqbraA5JTcSG4hC5A2mMBbUosnXR7UcuSB6w+CDhvNYmQEq3kGGVJY5bCfmeq3ZXKTT6GXsSBVU2RfpbX+th42Hmc36z9fKRnmHHEl7SnCQNS7WUnFNurEM39QC3vq6Amdgb3Qbtzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042494; c=relaxed/simple;
	bh=lk81Xyb6sjUQMBo9+yiVeJMpHclNk7u2HMNWphdknXU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z5Wg1gGNhsVcLG/AdMiqvudYGtHFH9SpTMF0ZkHFadfCGkSLibSxw8avNxblHUvfxvnINb/KDKz4P0MLdlJlRf4h4+L3b3y2FU7Rf9c0oxEk+TwlrBkgJ+wcMCh/Nxw0xWj8oHcn3ybj8nMzQmP9G7ZfdMPqpF3fkAbrJazZlRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B01161007;
	Wed, 11 Sep 2024 01:15:19 -0700 (PDT)
Received: from [10.1.27.34] (unknown [10.1.27.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D24D3F66E;
	Wed, 11 Sep 2024 01:14:47 -0700 (PDT)
Message-ID: <1e55f148-37d8-4fbe-b863-d604fdfaafaf@arm.com>
Date: Wed, 11 Sep 2024 09:14:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] perf cs-etm: Don't flush when packet_queue fills up
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, coresight@lists.linaro.org,
 scclevenger@os.amperecomputing.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Ben Gainey <ben.gainey@arm.com>, Ruidong Tian
 <tianruidong@linux.alibaba.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240905105043.160225-1-james.clark@linaro.org>
 <20240905105043.160225-2-james.clark@linaro.org>
 <5a0d9510-eccb-4074-964e-ae068b4ee31e@arm.com>
Content-Language: en-US
In-Reply-To: <5a0d9510-eccb-4074-964e-ae068b4ee31e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/10/2024 9:28 PM, Leo Yan wrote:
> On 9/5/2024 11:50 AM, James Clark wrote:
> 
> [...]
> 
>> cs_etm__flush(), like cs_etm__sample() is an operation that generates a
>> sample and then swaps the current with the previous packet. Calling
>> flush after processing the queues results in two swaps which corrupts
>> the next sample. Therefore it wasn't appropriate to call flush here so
>> remove it.
> 
> In the cs_etm__sample(), if the period is not overflow, it is not necessarily
> to generate instruction samples and copy back stack entries. This is why we
> want to call cs_etm__flush() to make sure the last packet can be recorded
> properly for instruction sample with back stacks.
> 
> We also need to take account into the case for the end of the session - in
> this case we need to generate samples for the last packet for complete info.
> 
> I am wandering should we remove the cs_etm__packet_swap() from cs_etm__sample()?

Sorry for typo. I meant to remove the cs_etm__packet_swap() from cs_etm__flush().

Thanks,
Leo
