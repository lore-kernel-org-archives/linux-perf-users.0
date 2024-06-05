Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B0F1946BA;
	Wed,  5 Jun 2024 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575574; cv=none; b=gnw7OV0IXW7z/TmV3uO7iXe2ALoZBZZwgWdvhhQPSnDyrra06JA60QQu3zhtqEVTMOC6Z3BIg0ZiPn6xGvPHWorjLQSpAYIoVuTKLN64abXdSTuoMUaXcW5IK5LgifAvvoLqk2OigltbInOLnBpeod3wlnYtu/vX7wk6hpLp9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575574; c=relaxed/simple;
	bh=J11oghjLd2OL4EAzmLeais99j3IPznPLv+/4AFGSym4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6+jb6bnzmr8amvd1eN8QuLxyg+Xdle7xbkVqQelMwORLL5d3GHKGzLgfPRg9sILEX+YhLToRHPMyfQ4spl5SsSNwi2pgOUQkitOWk3inpRBjg9uLwWlpq0yllR7nrBTnx2FDS8+krd/SLVec5l3pjhKSGHblASkdSFnu2IAQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81375DA7;
	Wed,  5 Jun 2024 01:19:55 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF1BF3F762;
	Wed,  5 Jun 2024 01:19:26 -0700 (PDT)
Message-ID: <e0434947-4fe9-43f8-87dd-91e6eb491341@arm.com>
Date: Wed, 5 Jun 2024 09:19:24 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] perf auxtrace: Allow number of queues to be
 specified
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org,
 coresight@lists.linaro.org, suzuki.poulose@arm.com,
 gankulkarni@os.amperecomputing.com, mike.leach@linaro.org,
 leo.yan@linux.dev, anshuman.khandual@arm.com
References: <20240604143030.519906-1-james.clark@arm.com>
 <20240604143030.519906-3-james.clark@arm.com>
 <12c09d40-788d-4af1-9eb6-0f5699875d70@intel.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <12c09d40-788d-4af1-9eb6-0f5699875d70@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/06/2024 06:26, Adrian Hunter wrote:
> On 4/06/24 17:30, James Clark wrote:
>> Currently it's only possible to initialize with the default number of
>> queues and then use auxtrace_queues__add_event() to grow the array. But
>> that's problematic if you don't have a real event to pass into that
>> function yet.
>>
>> The queues hold a void *priv member to store custom state, and for
>> Coresight we want to create decoders upfront before receiving data, so
>> add a new function that allows pre-allocating queues. One reason to do
>> this is because we might need to store metadata (HW_ID events) that
>> effects other queues, but never actually receive auxtrace data on that
>> queue.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Again ;-)
> 

Oops yeah I should have picked that up. This one was already applied to
perf-tools-next as well.

Thanks

>> ---
>>  tools/perf/util/auxtrace.c | 9 +++++++--
>>  tools/perf/util/auxtrace.h | 1 +
>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index 3684e6009b63..563b6c4fca31 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -218,15 +218,20 @@ static struct auxtrace_queue *auxtrace_alloc_queue_array(unsigned int nr_queues)
>>  	return queue_array;
>>  }
>>  
>> -int auxtrace_queues__init(struct auxtrace_queues *queues)
>> +int auxtrace_queues__init_nr(struct auxtrace_queues *queues, int nr_queues)
>>  {
>> -	queues->nr_queues = AUXTRACE_INIT_NR_QUEUES;
>> +	queues->nr_queues = nr_queues;
>>  	queues->queue_array = auxtrace_alloc_queue_array(queues->nr_queues);
>>  	if (!queues->queue_array)
>>  		return -ENOMEM;
>>  	return 0;
>>  }
>>  
>> +int auxtrace_queues__init(struct auxtrace_queues *queues)
>> +{
>> +	return auxtrace_queues__init_nr(queues, AUXTRACE_INIT_NR_QUEUES);
>> +}
>> +
>>  static int auxtrace_queues__grow(struct auxtrace_queues *queues,
>>  				 unsigned int new_nr_queues)
>>  {
>> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
>> index 55702215a82d..8a6ec9565835 100644
>> --- a/tools/perf/util/auxtrace.h
>> +++ b/tools/perf/util/auxtrace.h
>> @@ -521,6 +521,7 @@ int auxtrace_mmap__read_snapshot(struct mmap *map,
>>  				 struct perf_tool *tool, process_auxtrace_t fn,
>>  				 size_t snapshot_size);
>>  
>> +int auxtrace_queues__init_nr(struct auxtrace_queues *queues, int nr_queues);
>>  int auxtrace_queues__init(struct auxtrace_queues *queues);
>>  int auxtrace_queues__add_event(struct auxtrace_queues *queues,
>>  			       struct perf_session *session,
> 
