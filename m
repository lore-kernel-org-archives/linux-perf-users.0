Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A671FA0
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2023 02:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E5CC4;
	Thu, 26 Oct 2023 19:43:37 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SGn2v387cz1L9K2;
	Fri, 27 Oct 2023 10:40:39 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 27 Oct 2023 10:43:33 +0800
Subject: Re: [PATCH] perf evsel: Rename evsel__increase_rlimit to
 rlimit__increase_nofile
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231023033144.1011896-1-yangjihong1@huawei.com>
 <ZTrCS5Z3PZAmfPdV@kernel.org>
 <CAM9d7cjhSSV+18ZCHLdTFpMM+MmpoDkYSGjUa5JKZp02Kx9XRw@mail.gmail.com>
From: Yang Jihong <yangjihong1@huawei.com>
Message-ID: <3458c302-8c43-51e5-f45b-c18657fa7015@huawei.com>
Date: Fri, 27 Oct 2023 10:43:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjhSSV+18ZCHLdTFpMM+MmpoDkYSGjUa5JKZp02Kx9XRw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected

Hello,

On 2023/10/27 6:08, Namhyung Kim wrote:
> Hi Arnaldo,
> 
> On Thu, Oct 26, 2023 at 12:47 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> Em Mon, Oct 23, 2023 at 03:31:44AM +0000, Yang Jihong escreveu:
>>> evsel__increase_rlimit() helper does nothing with evsel, and description
>>> of the functionality is inaccurate, rename it and move to util/rlimit.c.
>>
>>> By the way, fix a checkppatch warning about misplaced license tag:
>>
>>>    WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
>>>    #160: FILE: tools/perf/util/rlimit.h:3:
>>>    /* SPDX-License-Identifier: LGPL-2.1 */
>>
>>> No functional change.
>>
>> Please run 'perf test' before sending patches upstream, I'm checking if
>> what is in perf-tools-next/perf-tools-next is building and I noticed
>> this:
>>
>> ⬢[acme@toolbox perf-tools-next]$ perf test -v python
>> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
>>   14: 'import perf' in python                                         :
>> --- start ---
>> test child forked, pid 2912462
>> python usage test: "echo "import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf" | '/usr/bin/python3' "
>> Traceback (most recent call last):
>>    File "<stdin>", line 1, in <module>
>> ImportError: /tmp/build/perf-tools-next/python/perf.cpython-311-x86_64-linux-gnu.so: undefined symbol: rlimit__increase_nofile
>> test child finished with -1
>> ---- end ----
>> 'import perf' in python: FAILED!
>> ⬢[acme@toolbox perf-tools-next]$
>>
>> The following patch cures it, Namhyung, can you please fold it and force
>> push perf-tools-next/perf-tools-next or let me know if you prefer that I
>> submit a patch fixing this separately.
> 
> Thanks for fixing this.  I prefer having a separate fix.
> Please send it as a formal patch.
> 

Sorry, only rename helper and no function change.
I didn't consider the scenario that might affect test python.

I've submitted a fix that can be used if needed:

https://lore.kernel.org/lkml/20231027023028.1106441-1-yangjihong1@huawei.com/

Also, can we consider identifying this problem at the stage of compiling 
the perf tool?


Thanks,
Yang
