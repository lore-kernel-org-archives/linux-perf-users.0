Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD662375F;
	Wed,  8 May 2024 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154786; cv=none; b=PYGRJD6LEXzfVGXKKf+Xyh6Klk7A+HulLc1CbP4HugXX6yYOMEr27vouaBN2z1uFzSN6abAq3bSch9gcXliL71niC6nVzZROY255gqQighA8tKRjqD65euScSDLMoAniNbQmwy2vOzzjjTHXASyEbyP5oOCEnf1YdZktk/huuds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154786; c=relaxed/simple;
	bh=2/OMdH6RI9ACcVmYMHGTGaQdO1YJfSC4XaASPUvEz40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4Po4TkEEez2BCREk+0Gu/pBD6hmmj4uUBGGevCwVqTJ64pQyqz+ZcWM0EY50ZFRqM+NrOxJRmS3BCWl+X+sXO1KQhmhoPZXfjdqvk89VFc9S522sSHpft+aRCpywIFD2/PdmRh7z+zrCYvbqQjO7rm993lqHEhFUSw5pROATiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72E9B1063;
	Wed,  8 May 2024 00:53:28 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2895A3F762;
	Wed,  8 May 2024 00:53:01 -0700 (PDT)
Message-ID: <a0c3641a-0b30-45d0-bb66-16d0d69dc176@arm.com>
Date: Wed, 8 May 2024 08:52:59 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] perf maps/symbols: Various assert fixes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com,
 irogers@google.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20240507141210.195939-1-james.clark@arm.com>
 <ZjpEqyR74rl92jhb@x1> <ZjpE5KfP_Wm3fxNm@x1>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <ZjpE5KfP_Wm3fxNm@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/05/2024 16:12, Arnaldo Carvalho de Melo wrote:
> On Tue, May 07, 2024 at 12:11:42PM -0300, Arnaldo Carvalho de Melo wrote:
>> On Tue, May 07, 2024 at 03:12:04PM +0100, James Clark wrote:
>>> A few different asserts are hit when running perf report on minimal
>>> Arm systems when kcore is used, or the .debug/ info can't be loaded or
>>> /boot isn't mounted etc.
>>>
>>> These result in some less common paths being hit for resolving symbols
>>> and things are done in an order that breaks some assumptions. I'm not
>>> sure if we could do something to make the tests pick this up, but maybe
>>> not easily if it would involve mocking the filesystem or even a specific
>>> kernel. I tried a few different variations of --kcore and --vmlinux
>>> arguments but ultimately I could only reproduce these issues by running
>>> on specific kernels and root filesystems.
>>
>> Please consider adding Fixes tags so that we can help the work of
>> backporters/stable?
> 
> Sorry, you already did it for the last two patches in the series, so you
> couldn't find easily what were the csets that introduced the problems in
> the first two patches?
> 
> - Arnaldo

1,3 and 4 are all fixes and have tags. 2 is just a tidyup so I didn't
add the tag. I probably should have explained that in the cover letter.

>>  
>>> James Clark (4):
>>>   perf symbols: Remove map from list before updating addresses
>>>   perf maps: Re-use __maps__free_maps_by_name()
>>>   perf symbols: Update kcore map before merging in remaining symbols
>>>   perf symbols: Fix ownership of string in dso__load_vmlinux()
>>>
>>>  tools/perf/util/maps.c   | 14 ++++++------
>>>  tools/perf/util/symbol.c | 49 ++++++++++++++++++++++++----------------
>>>  2 files changed, 36 insertions(+), 27 deletions(-)
>>>
>>> -- 
>>> 2.34.1
> 
