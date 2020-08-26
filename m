From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Date: Wed, 26 Aug 2020 16:55:30 +0530
Message-ID: <d4e97b8c-1b7f-d5a6-9fc4-f98e2982a292@linux.ibm.com>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
 <20200825154721.GP1509399@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200825154721.GP1509399@tassilo.jf.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: acme@kernel.org, jolsa@redhat.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org



On 8/25/20 9:17 PM, Andi Kleen wrote:
> On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:
>> This patch adds new structure called 'json_event' inside jevents.h
>> file to improve the callback prototype inside jevent files.
>> Initially, whenever user want to add new field, they need to update
>> in all function callback which make it more and more complex with
>> increased number of parmeters.
>> With this change, we just need to add it in new structure 'json_event'.
> 
> Looks good to me. Thanks.
> 
> I wouldn't consolidate with event_struct, these are logically
> different layers.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
Hi Andi,
   Thanks for reviewing the patch.

Thanks,
Kajol Jain
