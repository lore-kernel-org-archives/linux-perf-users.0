From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v5 09/11] perf/tools: Enhance JSON/metric infrastructure
 to handle "?"
Date: Wed, 18 Mar 2020 17:14:27 +0530
Message-ID: <0844ce2d-ded7-de30-c1ef-6e4de79c556d@linux.ibm.com>
References: <20200317062333.14555-1-kjain@linux.ibm.com>
 <20200317062333.14555-10-kjain@linux.ibm.com> <20200317150703.GB757893@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317150703.GB757893@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org



On 3/17/20 8:37 PM, Jiri Olsa wrote:
> On Tue, Mar 17, 2020 at 11:53:31AM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
>> index 3b4cdfc5efd6..dcc3c6ab2e67 100644
>> --- a/tools/perf/arch/powerpc/util/header.c
>> +++ b/tools/perf/arch/powerpc/util/header.c
>> @@ -7,6 +7,8 @@
>>  #include <string.h>
>>  #include <linux/stringify.h>
>>  #include "header.h"
>> +#include "metricgroup.h"
>> +#include <api/fs/fs.h>
>>  
>>  #define mfspr(rn)       ({unsigned long rval; \
>>  			 asm volatile("mfspr %0," __stringify(rn) \
>> @@ -16,6 +18,8 @@
>>  #define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF) /* Version field */
>>  #define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF) /* Revison field */
>>  
>> +#define SOCKETS_INFO_FILE_PATH "/devices/hv_24x7/interface/sockets"
>> +
>>  int
>>  get_cpuid(char *buffer, size_t sz)
>>  {
>> @@ -44,3 +48,9 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
>>  
>>  	return bufp;
>>  }
>> +
>> +int arch_get_runtimeparam(void)
>> +{
>> +	int count;
>> +	return sysfs__read_int(SOCKETS_INFO_FILE_PATH, &count) < 0 ? 1 : count;
> 
> is that SOCKETS_INFO_FILE_PATH define used later? if not please
> put the path directly as an argument to sysfs__read_int
> 
Ok will do that.

Thanks,
Kajol
> jirka
> 
