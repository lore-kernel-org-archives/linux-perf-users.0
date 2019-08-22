From: Tan Xiaojun <tanxiaojun@huawei.com>
Subject: Re: [RFC PATCH 3/3] perf report: add --spe options for arm-spe
Date: Thu, 22 Aug 2019 09:44:51 +0800
Message-ID: <184ef2f7-654c-4f24-952b-37cfa3681387@huawei.com>
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
 <1564738813-10944-4-git-send-email-tanxiaojun@huawei.com>
 <8e8deead-6d59-9203-a01a-fe63362ebdf0@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e8deead-6d59-9203-a01a-fe63362ebdf0@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Clark <James.Clark@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@redhat.com" <jolsa@redhat.com>, "namhyung@kernel.org" <namhyung@kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>, "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>, "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>, "songliubraving@fb.com" <songliubraving@fb.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Kim Phillips <Kim.Phillips@arm.com>
Cc: "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>, "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>, "liwei391@huawei.com" <liwei391@huawei.com>, "huawei.libin@huawei.com" <huawei.libin@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Linton <Jeremy.Linton@arm.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, nd <nd@arm.com>
List-Id: linux-perf-users.vger.kernel.org

On 2019/8/21 20:38, James Clark wrote:
> Hi,
> 
> I also had a look at this and had a question about the --spe option.
> It seems that whatever options I give it, the output is the same:
> 
> 	perf report 
> And
> 	perf report --spe=t
> 
> Both give the same result:
> 
> 	# Samples: 4  of event 'llc-miss'
> 	# Event count (approx.): 4
> 	#
> 	# Children      Self  Command  Shared Object      Symbol                    
> 	# ........  ........  .......  .................  ..........................
> 	#
> 	...
> 	# Samples: 0  of event 'tlb-miss'
> 	# Event count (approx.): 0
> 	#
> 	# Children      Self  Command  Shared Object  Symbol
> 	# ........  ........  .......  .............  ......
> 	#
> 
> 	# Samples: 83  of event 'branch-miss'
> 	# Event count (approx.): 83
> 	#
> 	# Children      Self  Command  Shared Object      Symbol                   
> 	# ........  ........  .......  .................  .........................
> 	#
> 	...
> 
> I would have expected it to not include the branch and LLC sections for the second
> command with --spe=t.
> 

Hi,

Sorry, this should be a bug in my code.

> And that leads me to another point. Does it make sense to have this option as a post
> processing step? SPE already has support for filtering events at collection time with
> the PMSFCR_EL1 register.
> 
> Should we try to make the interface more like PEBS, where you specify which events you
> are interested in doing precise tracing on like this?
> 
> 	perf record -e branch-misses:pp
> 
> And then perf could use the modifier to configure SPE so that it only records branch
> misses? The benefits of this would be keeping the user interface for precise tracing
> similar between platforms.
> 

Good suggestion. And I need to spend some time thinking about how to implement it.

Thank you for your reply.
Xiaojun.

> Thanks
> James
> 
> On 02/08/2019 10:40, Tan Xiaojun wrote:
>> The previous patch added support in "perf report" for some arm-spe
>> events(llc-miss, tlb-miss, branch-miss). This patch adds their help
>> instructions.
>>
>> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
>> ---
>>  tools/perf/Documentation/perf-report.txt | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
>> index 987261d..d998d4b 100644
>> --- a/tools/perf/Documentation/perf-report.txt
>> +++ b/tools/perf/Documentation/perf-report.txt
>> @@ -445,6 +445,15 @@ include::itrace.txt[]
>>  
>>  	To disable decoding entirely, use --no-itrace.
>>  
>> +--spe::
>> +	Options for decoding arm-spe tracing data. The options are:
>> +
>> +		l	synthesize llc miss events
>> +		t	synthesize tlb miss events
>> +		b	synthesize branch miss events
>> +
>> +	The default is all events i.e. the same as --spe=ltb
>> +
>>  --full-source-path::
>>  	Show the full path for source files for srcline output.
>>  
>>
