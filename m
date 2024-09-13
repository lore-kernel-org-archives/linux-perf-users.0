Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68101C2DBA;
	Fri, 13 Sep 2024 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232610; cv=none; b=q9y269tCnun/3ub1fHtF8P/ieBDSZV6GQ5g7iRW906lut8qxsxZSuD3T3SGbjn6dwGKLhzvWogWYVxnbkE1tlkcPqBrmysJmDkoBqGd6PgpvRjHQiV7yww94h92EPIJKzi4BmQgIGbk2iqSNLhj4uJGDPf/PVZBfogqEaujDl6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232610; c=relaxed/simple;
	bh=oKJMIo0XsQ7HTTEFA7FNZYtl/9AU7uZbxZPH5g532VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8L0OCkgqAl0y9vyQgI/KwUDf0N2XRVK9VjDbKo8kmK0J37bB3TR2lZkiLV5+LyA5PkDx0QNELii8ZE0iE12634QlyTJ/DxThRo1znr8duL33pvOxPWooTJwxdqF5L3L0cfQUbwnV7D99+rkSpJRs5WAOJOpmGVw07DYuVFDVqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EFFD13D5;
	Fri, 13 Sep 2024 06:03:57 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2413D3F73B;
	Fri, 13 Sep 2024 06:03:25 -0700 (PDT)
Message-ID: <37f8d0c3-f1fc-495f-b4c4-549ffa0435d1@arm.com>
Date: Fri, 13 Sep 2024 14:03:23 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] perf cs-etm: Use new OpenCSD consistency checks
To: James Clark <james.clark@linaro.org>
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
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, coresight@lists.linaro.org,
 scclevenger@os.amperecomputing.com
References: <20240912151143.1264483-1-james.clark@linaro.org>
 <20240912151143.1264483-3-james.clark@linaro.org>
 <cfad80e4-3ee8-4a55-9dee-41d0d0256c04@arm.com>
 <332e0654-df8c-44b1-8e55-398aeba37b08@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <332e0654-df8c-44b1-8e55-398aeba37b08@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/13/24 13:09, James Clark wrote:

[...]

>> Just one question: should the flag ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK be set
>> according to ETM version? E.g. it should be only set for ETMv4 or this is
>> fine for ETE as well.
> 
> I asked Mike the same question about ETMv3 and he said none of the flags
> overlap and it was ok to always pass them. So I assume the same applies
> to ETE as well.

Thanks for confirmation. This is my review tag:

Reviewed-by: Leo Yan <leo.yan@arm.com>
