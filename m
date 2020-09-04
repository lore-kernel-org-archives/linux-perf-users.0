From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v7 2/5] perf/jevents: Add new structure to pass json
 fields.
Date: Fri, 4 Sep 2020 13:59:22 +0530
Message-ID: <d8f98c89-0a11-3844-01f2-3562ff2bdea9@linux.ibm.com>
References: <20200902160439.335232-1-kjain@linux.ibm.com>
 <20200902160439.335232-3-kjain@linux.ibm.com>
 <34566244-88ba-562b-71cf-414a0ba307f4@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <34566244-88ba-562b-71cf-414a0ba307f4@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>, acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org



On 9/2/20 10:35 PM, John Garry wrote:
> On 02/09/2020 17:04, Kajol Jain wrote:
>> This patch adds new structure called 'json_event' inside jevents.h
>> file to improve the callback prototype inside jevent files.
>> Initially, whenever user want to add new field, they need to update
>> in all function callback which make it more and more complex with
>> increased number of parmeters.
>> With this change, we just need to add it in new structure 'json_event'.
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> 
>> +static int json_events
> 
> Adding 'static' should have really been in the previous patch ...

Hi John,
   Right, Thanks for pointing it, I will update.

Thanks,
Kajol Jain
> 
