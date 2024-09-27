Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E596188A13;
	Fri, 27 Sep 2024 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426509; cv=none; b=f6+raVPRQZ6+b0OZJJY9VfaxCzIAUDeH6zFpQaOT7wS8lxxGg11oH7QOIjfpNuB7Vytm0lWbr4A7QxmCbn5hlYEUsZDT3Gdl8eJbPURLsEC7oyl7Dd1mHbMMxBv4mJYzgThfotp8Gv8aqs+g+arz3JkH6jQg2mGH8EwtpmHIsEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426509; c=relaxed/simple;
	bh=k6IPul6QqP2NRZRkRdqXT5XX/D2WFC18ReEXpaAGfZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjqyUAkm1cuSFdi60pbyBXG4Eq3QYhWi4mkG9yS88HsHLw7UOYhvIz786c3/ypk6CQaQuk004w3+J7l6nSHEp3TSTH4/hy/UeDTMtXbxDPkNIb06bPzXunDxTjtgtbtThRu4B8+FTmFiCgM5BAreDrQ54Dw2FYN0C99OeFh2i8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AFE414BF;
	Fri, 27 Sep 2024 01:42:16 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77E873F6A8;
	Fri, 27 Sep 2024 01:41:44 -0700 (PDT)
Message-ID: <f948b332-0df8-451f-aaf6-407340752b04@arm.com>
Date: Fri, 27 Sep 2024 09:41:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] perf arm-spe: Introduce metadata version 2
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240914215458.751802-1-leo.yan@arm.com>
 <61d9e213-d2ca-48c9-b176-03e7d01524c9@arm.com> <ZvZMXpLnyzhFMrLb@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <ZvZMXpLnyzhFMrLb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Namhyung,

On 9/27/24 07:10, Namhyung Kim wrote:

>> Hi Arnaldo, Namhyung,
>>
>> Gentle ping. There is a bit backlog for Arm SPE patches, so I would
>> like to bring up this series and the series [1] for the Arm SPE data
>> source refactoring (which is dependent on the current series).
>>
>> Please kindly review and pick it up if it is fine for you.
> 
> While it seems like general changes, I'd like to see some ARM folks
> reviewing this series.

Fair point. I will chase review internally after sending a new spin (I think I 
turned my eyes to James ;)).

Thanks a lot for review!

Leo
