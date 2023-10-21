Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FD07EA
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Oct 2023 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECD3D7A;
	Fri, 20 Oct 2023 18:47:38 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SC43n6PLHzNnGr;
	Sat, 21 Oct 2023 09:43:33 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 21 Oct 2023 09:47:34 +0800
Subject: Re: [PATCH] perf data: Increase RLIMIT_NOFILE limit when open too
 many files in perf_data__create_dir()
To: Namhyung Kim <namhyung@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231013075945.698874-1-yangjihong1@huawei.com>
 <CAM9d7cjQ_ZT2wdvFO8v2f8cN+GGH0nLOa=Fvzf4okAr8b27t_w@mail.gmail.com>
From: Yang Jihong <yangjihong1@huawei.com>
Message-ID: <70653005-d149-6ecf-b2fb-93a77376a504@huawei.com>
Date: Sat, 21 Oct 2023 09:47:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjQ_ZT2wdvFO8v2f8cN+GGH0nLOa=Fvzf4okAr8b27t_w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected

Hello,

On 2023/10/20 13:59, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Oct 13, 2023 at 1:01 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> If using parallel threads to collect data, perf record needs at least 6 fds
>> per CPU. (one for sys_perf_event_open, four for pipe msg and ack of the
>> pipe, see record__thread_data_open_pipes(), and one for open perf.data.XXX)
> 
> Yep, probably one more for the dummy event.
> 
>> For an environment with more than 100 cores, if perf record uses both
>> `-a` and `--threads` options, it is easy to exceed the upper limit of the
>> file descriptor number, when we run out of them try to increase the limits.
>>
>> Before:
>>    $ ulimit -n
>>    1024
>>    $ lscpu | grep 'On-line CPU(s)'
>>    On-line CPU(s) list:                0-159
>>    $ perf record --threads -a sleep 1
>>    Failed to create data directory: Too many open files
>>
>> After:
>>    $ ulimit -n
>>    1024
>>    $ lscpu | grep 'On-line CPU(s)'
>>    On-line CPU(s) list:                0-159
>>    $ perf record --threads -a sleep 1
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 0.394 MB perf.data (1576 samples) ]
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   tools/perf/util/data.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
>> index fc16299c915f..098f9e3bb2e7 100644
>> --- a/tools/perf/util/data.c
>> +++ b/tools/perf/util/data.c
>> @@ -17,6 +17,7 @@
>>   #include "util.h" // rm_rf_perf_data()
>>   #include "debug.h"
>>   #include "header.h"
>> +#include "evsel.h"
>>   #include <internal/lib.h>
>>
>>   static void close_dir(struct perf_data_file *files, int nr)
>> @@ -35,6 +36,7 @@ void perf_data__close_dir(struct perf_data *data)
>>
>>   int perf_data__create_dir(struct perf_data *data, int nr)
>>   {
>> +       enum rlimit_action set_rlimit = NO_CHANGE;
>>          struct perf_data_file *files = NULL;
>>          int i, ret;
>>
>> @@ -54,11 +56,21 @@ int perf_data__create_dir(struct perf_data *data, int nr)
>>                          goto out_err;
>>                  }
>>
>> +retry_open:
>>                  ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
>>                  if (ret < 0) {
>> +                       /*
>> +                        * If using parallel threads to collect data,
>> +                        * perf record needs at least 6 fds per CPU.
>> +                        * When we run out of them try to increase the limits.
>> +                        */
>> +                       if (errno == EMFILE && evsel__increase_rlimit(&set_rlimit))
> 
> It seems weird that we have this helper with evsel prefix and
> it does nothing with evsel.  But it's a separate concern, so
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
Thanks for the Acked-by tag.

Uh... The name of this helper doesn't seem to be appropriate.
Okay, I'll submit a patch to fix this helper name.

Thanks,
Yang
