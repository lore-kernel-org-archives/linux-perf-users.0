Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407BA1BC4B;
	Thu,  9 May 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266003; cv=none; b=PUT5thYbrWAqJYSuZIN4eQF2Tczq/BmXUE28wHQ0oh3TBZKomGHcke8xjODLyVbfR2GiLsz2WB/PHDbV0TEeRt6Col+C6d18dmgen5mSg4u9ecEMd9rHyqJkU/Bp5bwmaG4TbGRk7UkZ291Kx+XHg5hwMCRs4HlhvpTrcYjcLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266003; c=relaxed/simple;
	bh=rucQE/twYzCIsQtJnDOh9iW/UvTTt3EfUCzRoR2xgt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxS7DMcbkP8rZtlg1ZvE7NvrVduU+rXjSaXvpd7GSO8VHSglhnzadsamiJ0S8NvoIxH5wLj/kTwftTR/JBYHL8wYH5CS1KOtbLOh89yvVvVK17Tc7vbCiq/nXecItBqvpCCjtocRF2N3cROL/1MSKyQuXDdmSZ3+J6a8wSTeWdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD7B4106F;
	Thu,  9 May 2024 07:47:05 -0700 (PDT)
Received: from [10.1.31.15] (PF4Q20KV.arm.com [10.1.31.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A3653F641;
	Thu,  9 May 2024 07:46:38 -0700 (PDT)
Message-ID: <438f8725-ef3f-462f-90e2-840cab478ee5@arm.com>
Date: Thu, 9 May 2024 15:46:28 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf maps: Process kcore maps in order
To: Markus Elfring <Markus.Elfring@web.de>, linux-perf-users@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ian Rogers
 <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 James Clark <james.clark@arm.com>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240505202805.583253-1-leo.yan@arm.com>
 <4294f69b-a317-4f09-b775-52439e2ea6fc@web.de>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <4294f69b-a317-4f09-b775-52439e2ea6fc@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/8/2024 6:02 PM, Markus Elfring wrote:
>>                                                        … To fix it, this
>> patch adds kcore maps in the tail of list, …
> 
> * How do you think about to add the tag “Fixes”?
> 
> * Would you like to use imperative wordings for an improved changelog?

I will add Fixes tag and refine changelog. Thanks for suggestions.

Leo
