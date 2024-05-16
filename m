Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC0143C4B;
	Thu, 16 May 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715855783; cv=none; b=ANnPXmKMd1kWrAVLa1YidFJX1jtA0SCeqSy6ij12naVcGaksMqzPgvw0o3KUk6LFfrK4pSkxw7USfGycbUv2yLWBJtpaARYyO4AcEuF9M6pfKF0jjmwjs6kDQ2qeBla0HgHpbs/2kccYzbwls1aD41hHk1JTnGTO/U02OC1o6ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715855783; c=relaxed/simple;
	bh=HDoEm5f5wF8Nd0sGgYrQOCtr9e9W5oFM2Z+H/KVQjf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1VrI7AAL5Zpw/K7l4NjlDvxGKLs31Uld3VnZh+D2K9YrX1esSvTwrcZ/OqaSFmDg2vXGMeqMh21qqGG88IPKoJqhccWl21x4g4sf3WKiujgeJbDFlzJoNsVTAQd+Q8vRI+rPy3jJdxwmMumluDrLz4HReu/3+EIPsLciG+0ccA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EBA7DA7;
	Thu, 16 May 2024 03:36:45 -0700 (PDT)
Received: from [10.91.2.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0A5B3F762;
	Thu, 16 May 2024 03:36:18 -0700 (PDT)
Message-ID: <ce6d7e6a-e24a-43b4-a9b8-4e946277c2d8@arm.com>
Date: Thu, 16 May 2024 12:36:21 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: perf: arm64: Catch all Arm files and folders
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-perf-users@vger.kernel.org
Cc: gregkh@linuxfoundation.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240515151221.204163-1-james.clark@arm.com>
 <e92a8423-9172-4aec-acbf-c9f136e6884f@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <e92a8423-9172-4aec-acbf-c9f136e6884f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/05/2024 06:35, Anshuman Khandual wrote:
> 
> 
> On 5/15/24 20:42, James Clark wrote:
>> Catch all files and folders with Arm in the name in tools/perf/ up to
>> two levels deep. There currently no false positives.
>>
>> This catches lots of missing items like these and more:
>>
>>   * util/arm-spe-decoder/
>>     (The existing util/arm-spe* entry only matched files not folders)
>>   * util/perf-regs-arch/perf_regs_arm.c
>>   * scripts/python/arm-cs-trace-disasm.py
>>   * tests/shell/test_arm_spe.sh
> 
> Agreed.
> 
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  MAINTAINERS | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ec0284125e8f..c5d0256d32dd 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17318,9 +17318,10 @@ R:	Leo Yan <leo.yan@linux.dev>
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Supported
>>  F:	tools/build/feature/test-libopencsd.c
>> -F:	tools/perf/arch/arm*/
>> -F:	tools/perf/pmu-events/arch/arm64/
>> -F:	tools/perf/util/arm-spe*
>> +F:	tools/perf/*/*/*arm*
>> +F:	tools/perf/*/*/*arm*/
>> +F:	tools/perf/*/*arm*
>> +F:	tools/perf/*/*arm*/
>>  F:	tools/perf/util/cs-etm*
> 
> Very minor nit, these regular expressions should be arranged as per
> the increasing directory depth levels, just to make it apparent in
> terms of which files are being covered here ?
> 
> F:	tools/perf/*/*arm*
> F:	tools/perf/*/*arm*/
> F:	tools/perf/*/*/*arm*
> F:	tools/perf/*/*/*arm*/
> 

Checkpatch has an alphabetical sort which says they have to be the other
way around, but yes I agree I did write it your way initially.

> But regardless, with or without the above changes
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
>>  
>>  PERSONALITY HANDLING
