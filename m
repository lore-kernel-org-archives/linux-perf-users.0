Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E361448D9;
	Tue, 25 Jun 2024 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338949; cv=none; b=qqOKgehPvvOwe99TWLaTCzbsC+xaaOm3tGzkIaHXlin7qwHGwDcMKwsaMZeREycjcHOS28ri7BnL6brrBXmMuauD39cpmtb9D4+UNgRX98juFUx9vqKVphl2ZDzowbF41axrD+KTnzQVi0rBc5D8TfV4BjRu7HGv+4/iEjt5AjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338949; c=relaxed/simple;
	bh=X6dODJt9HRGZcv6YOgMM8RDXMQm+Ja6irJod0YhbYwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1MKJ8KRj+TmQ8eWJ+6Sa03KPSLOprt7ZQuLfFP5aBTWJm1E6e82x9lmVwDeOfsv+3wdD9kweW3cSIH1/4/yO4RaPBeRKwF8TWpeQjkogSsN9HlqDzD+EJTl1CfqGTjYYcnU77LfNshJyWVWKLqVUTXVT2Xilr+j+FCDg5c4e1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12325339;
	Tue, 25 Jun 2024 11:09:31 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B5DD3F73B;
	Tue, 25 Jun 2024 11:09:03 -0700 (PDT)
Message-ID: <1237a235-3d80-464d-8db7-a7895d45aa4a@arm.com>
Date: Tue, 25 Jun 2024 19:09:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] perf: build: Only link libebl.a for old libdw
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Quentin Monnet <qmo@kernel.org>,
 Changbin Du <changbin.du@huawei.com>, Fangrui Song <maskray@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Guilherme Amadio <amadio@gentoo.org>
References: <20240610095433.336295-1-leo.yan@arm.com>
 <20240610095433.336295-4-leo.yan@arm.com> <ZnYPev8QPeNOFAR7@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <ZnYPev8QPeNOFAR7@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/22/24 00:40, Namhyung Kim wrote:
> 
> On Mon, Jun 10, 2024 at 10:54:30AM +0100, Leo Yan wrote:
>> Since libdw version 0.177, elfutils has merged libebl.a into libdw (see
>> the commit "libebl: Don't install libebl.a, libebl.h and remove backends
>> from spec." in the elfutils repository).
>>
>> As a result, libebl.a does not exist on Debian Bullseye and newer
>> releases, causing static perf builds to fail on these distributions.
> 
> What about libebl.so?  I'm curious why it's ok with dynamic build and
> causing a problem with static builds.

For the new Debian / Ubuntu distros, libebl has been merged in libdw so
merged into libdw, so libebl.so doesn't exist.

'-lebl' is only included only for static building (see below code piece,
it detects '-static' in ${LDFLAGS}).  This is why dynamic build has no
issue.

>> This commit checks the libdw version and only links libebl.a if it
>> detects that the libdw version is older than 0.177.
> 
> Have you tested on the older versions too?

IIRC, I did test on the Debian buster (which contains the libdw version
is 0.176).

>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   tools/build/feature/Makefile | 12 +++++++++++-
>>   tools/perf/Makefile.config   | 12 +++++++++++-
>>   2 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
>> index 084f803093c3..b23b3e8ad5e4 100644
>> --- a/tools/build/feature/Makefile
>> +++ b/tools/build/feature/Makefile
>> @@ -171,7 +171,17 @@ $(OUTPUT)test-libopencsd.bin:
>>
>>   DWARFLIBS := -ldw
>>   ifeq ($(findstring -static,${LDFLAGS}),-static)
>> -DWARFLIBS += -lelf -lebl -lz -llzma -lbz2
>> +  DWARFLIBS += -lelf -lz -llzma -lbz2
>> +
>> +  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
>> +  LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
>> +  LIBDW_VERSION_2 := $(word 2, $(subst ., ,$(LIBDW_VERSION)))
>> +
>> +  # Elfutils merged libebl.a into libdw.a starting from version 0.177,
>> +  # Link libebl.a only if libdw is older than this version.
>> +  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
>> +    DWARFLIBS += -lebl
> 
> I'm not sure if it's ok to change the order as libebl might depend on
> later libraries like libz.

I confirmed that this change works on Debian Buster (Debian 10) and
Bookworm (Debian 12).

Thanks,
Leo
