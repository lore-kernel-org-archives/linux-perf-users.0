Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EDB84D04;
	Wed, 12 Jun 2024 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718224380; cv=none; b=WK3jQYl1bL8mefoChpwRfEB+9z55twzojZHNxrjODj9fjaqRd2uwELZs/tR1zH7eaiQIhRRwI+PPm1WOTZZd/BHMO2QUz55nicIx56jtpg0MzUvGMzJAs5nTow8siuLROjoK4ZQ/sOBQCssYTViB9i11bsH3hIqoDupy5l55Wpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718224380; c=relaxed/simple;
	bh=2nCR64Zc31pzpiWEW5Gs2Jv/fYZlIieQTBon12415e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZEyCpeynwtrdgHgNYZb4vpjwbQ9NvNrRndI3iBmLelhehEGJLTn9XfIOtZWH90tLG+i+x7c3VdWmHBCu1k2wenSVcLrKy0NHWHHqArU5nKXBqvwzyLnEdcHid6ytpY68TGwfRVLcKEWLaWOv0f7sNt43szyLYGxElang0NI9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EA8B1042;
	Wed, 12 Jun 2024 13:33:21 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9108F3F5A1;
	Wed, 12 Jun 2024 13:32:54 -0700 (PDT)
Message-ID: <cc1b0673-13b3-439f-afdf-c9cb450f8fed@arm.com>
Date: Wed, 12 Jun 2024 21:32:53 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf arm: Workaround ARM PMUs cpu maps having offline
 cpus
To: Ian Rogers <irogers@google.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yicong Yang <yangyicong@huawei.com>
References: <20240607065343.695369-1-irogers@google.com>
 <23ee1734-7e65-4f11-aede-fea44ada3cc4@arm.com>
 <CAP-5=fUP69NJ+j6+9rUnp+UPBxcopJ=BOY-LeOjs8vYdt4soMA@mail.gmail.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <CAP-5=fUP69NJ+j6+9rUnp+UPBxcopJ=BOY-LeOjs8vYdt4soMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Ian,

On 6/10/24 18:33, Ian Rogers wrote:

[...]

>> Just a nitpick and I think it is not an issue caused by this patch.
>> After hotplug off one CPU and then if specify the CPU with option '-C',
>> the 'perf stat' command still continues to run. This is inconsistent
>> with the 'perf record' which exits with failures immediately.
>>
>> Maybe consider to send an extra patch to address this issue?
> 
> As you say, this doesn't relate to the problem fixed here. I don't
> have a problem with the command line behavior change but I think my
> getting shouted at budget is fairly well exhausted.

I understand you put much efforts on fixing issues, on Arm platforms and
other platforms. This is also why I want to contribute a bit for testing
the patches.

> How about we trade issues, if the following get fixed:
> 
> Renaming of the cycles event in arm_dsu_pmu.c - I'd say this is a top
> priority issue right now.

I cannot promise this. The main reason is that I still believe the
'cycles' event (or, generally speaking, all events) should be managed by
the tool rather than by the uncore PMU drivers. Additionally, the perf
tool currently has handled these symbolic events effectively.

> Fixing ARM hybrid default perf stat (it is crazy we can accept this
> being broken), opening events on both BIG.little PMUs as done here.

Yeah, James is working on this.

> I'll address this.

Anyway, I appreciate your work.

Thanks,
Leo
