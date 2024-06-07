Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73074AEC3;
	Fri,  7 Jun 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764634; cv=none; b=AGPorczmUNCEg6lxJHZUNc7vOiAfJbedwNrOkTcnXTLFk4WpdiFV47Ax+QsweZ+fKQISnJqqjSbM1Cr9cqA9qgfQhwJvZHPDGbS7sVXlQM2bfWzm9N2u0hZKZodFcC+u0UllR7Mtjkc5uKCmWD3+vw1RlpfCUH/oberj6WeZEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764634; c=relaxed/simple;
	bh=rFPbE5w/AjL8MhqCMSlMUzFyf6vFNmsE+KMk/g1o8bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LN6WHEkl1lfT3+L9w/a/nVLDDw3a1xI2/d6CHMddh52ctuWWz5KEpjCOKzsm2+fnp6JENSovrNwJst3+ZKmlsJ5RlYcPxa9zeQPd7Yj5rXc0Krck83QMHY9L2YkX5GOuwaOfFURiRv0Ty2ztdGwCv4vlNGS5C8C5nt/J2DgKcaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E1FB13D5;
	Fri,  7 Jun 2024 05:50:55 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F8193F762;
	Fri,  7 Jun 2024 05:50:29 -0700 (PDT)
Message-ID: <0a578e84-6a28-4477-9aa4-dcfb37fc28b0@arm.com>
Date: Fri, 7 Jun 2024 13:50:28 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] perf: build: Setup PKG_CONFIG_LIBDIR for cross
 compilation
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, James Clark <james.clark@arm.com>,
 Ian Rogers <irogers@google.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Terrell <terrelln@fb.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Changbin Du <changbin.du@huawei.com>, Fangrui Song <maskray@google.com>,
 Mateusz Kowalczyk <fuuzetsu@fuuzetsu.co.uk>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240604093223.1934236-1-leo.yan@arm.com>
 <20240604093223.1934236-2-leo.yan@arm.com> <ZmHx2EFK9cSWgUIK@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <ZmHx2EFK9cSWgUIK@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Namhyung,

On 6/6/24 18:28, Namhyung Kim wrote:

>> --- a/tools/build/feature/Makefile
>> +++ b/tools/build/feature/Makefile
>> @@ -82,7 +82,19 @@ FILES=                                          \
>>
>>   FILES := $(addprefix $(OUTPUT),$(FILES))
>>
>> -PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
>> +PKG_CONFIG ?= pkg-config
>> +
>> +ifdef CROSS_COMPILE
>> +  ifndef PKG_CONFIG_LIBDIR
> 
> Can we do that only if the cross-compile-pkg-config is not available?

Makes sense for me.  I will update for this.

Thanks,
Leo
