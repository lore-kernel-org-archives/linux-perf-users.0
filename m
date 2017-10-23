From: zhangmengting <zhangmengting@huawei.com>
Subject: Re: [PATCH] perf script: Add option to display guest samples in host
Date: Mon, 23 Oct 2017 14:40:59 +0800
Message-ID: <c656c7fc-8b32-2a32-bbc9-58aa13ac9d39@huawei.com>
References: <1508310594-51519-1-git-send-email-zhangmengting@huawei.com>
 <a1e7fa6d-a427-9e0f-baad-4853d63078cb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:50032 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750756AbdJWG5g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Oct 2017 02:57:36 -0400
In-Reply-To: <a1e7fa6d-a427-9e0f-baad-4853d63078cb@gmail.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, dsa@cumulusnetworks.com, wangnan0@huawei.com, huawei.libin@huawei.com

Hi all,
For sched_switch tracepoint, I guess maybe it would be more reasonable 
to show guest samples together with host samples by default, instead of 
setting an option to display guest samples when we meet with this 
confused situation.
To take care of this issue, the code should be changed as below:

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 0c977b6..dcfab00 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1557,7 +1557,7 @@ static int process_sample_event(struct perf_tool 
*tool,
          return -1;
      }

-    if (al.filtered)
+    if (al.filtered && !(strcmp(evsel->name, "sched:sched_switch")== 0 
&& perf_host &&(al.filtered & (1 << HIST_FILTER__GUEST))))
          goto out_put;

      if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))

Right?

Thanks,
Mengting Zhang


On 2017/10/18 22:37, David Ahern wrote:
> On 10/18/17 1:09 AM, Mengting Zhang wrote:
>> @@ -2771,6 +2772,8 @@ int cmd_script(int argc, const char **argv)
>>   		    "Show context switch events (if recorded)"),
>>   	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
>>   		    "Show namespace events (if recorded)"),
>> +	OPT_BOOLEAN('\0', "show-guest-samples", &script.show_guest_samples,
>> +		    "Show guest samples (if recorded)"),
>>   	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
>>   	OPT_INTEGER(0, "max-blocks", &max_blocks,
>>   		    "Maximum number of code blocks to dump with brstackinsn"),
> At this point we need a 'show-all' option.
>
> .
>
