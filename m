From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH v2] perf list: Add s390 support for detailed/verbose pmu
 event description
Date: Wed, 18 Apr 2018 16:09:53 +0200
Message-ID: <a6aefb3d-08c7-7d12-e087-428245ae399b@linux.ibm.com>
References: <20180416132314.33249-1-tmricht@linux.ibm.com>
 <20180416144334.zkzxyhhnlm3ia5gy@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416144334.zkzxyhhnlm3ia5gy@lakrids.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On 04/16/2018 04:43 PM, Mark Rutland wrote:
> On Mon, Apr 16, 2018 at 03:23:14PM +0200, Thomas Richter wrote:
>> From: Thomas Richter <tmricht@linux.vnet.ibm.com>
>>
>> Perf list with flags -d and -v print a description (-d) or
>> a very verbose explanation (-v) of CPU specific counter events.
>> These descriptions are provided with the json files in
>> directory pmu-events/arch/s390/*.json.
>>
>> Display of these descriptions on s390 requires the
>> corresponding json files.
>>
>> On s390 this does not work because function is_pmu_core()
>> does not detect the s390 directory name where the
>> CPU specific events are listed. On x86 it is
>>   /sys/bus/event_source/devices/cpu
>> whereas on s390 it is
>>   /sys/bus/event_source/devices/cpum_cf
>>   /sys/bus/event_source/devices/cpum_sf
>>
>> Fix this by adding s390 directory name testing to
>> function is_pmu_core(). This is the same approach as taken for
>> arm platform.
> 
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 1111d5bf15ca..8675ddf558c6 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -562,6 +562,12 @@ static int is_pmu_core(const char *name)
>>  	if (stat(path, &st) == 0)
>>  		return 1;
>>  
>> +	/* Look for cpu sysfs (specific to s390) */
>> +	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s",
>> +		  sysfs, name);
>> +	if (stat(path, &st) == 0 && !strncmp(name, "cpum_", 5))
>> +		return 1;
>> +
> 
> This shouldn't adversely affect ARM, so FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 

Arnaldo,

with Mark Acked-by can you please apply the patch.

Thanks a lot.
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
