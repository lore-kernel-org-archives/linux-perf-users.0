From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf list: Add s390 support for detailed/verbose pmu
 event description
Date: Mon, 9 Apr 2018 15:03:32 +0200
Message-ID: <975962f2-3d85-2325-da31-b74951863cbe@linux.vnet.ibm.com>
References: <20180409110015.20793-1-tmricht@linux.ibm.com>
 <20180409113732.6k3plpp6pqdcbzrh@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409113732.6k3plpp6pqdcbzrh@lakrids.cambridge.arm.com>
Content-Language: en-IE
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 04/09/2018 01:37 PM, Mark Rutland wrote:
> Hi,
> 
> On Mon, Apr 09, 2018 at 01:00:15PM +0200, Thomas Richter wrote:
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
> I don't think this is quite right.
> 
> On arm, we specifically look for PMU directories which have a
> file called CPUs. e.g.
> 
>   /sys/bus/event_source/devices/arm_pmuv3/cpus
> 
> ... where "arm_pmuv3" is the PMU name.
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
>> +	if (stat(path, &st) == 0)
>> +		return 1;
> 
> IIUC here we return true if the PMU has a sysfs directory, but all PMUs
> (including uncore PMUs) should have such a directory, so this will make
> is_pmu_core() always return true.
> 
> Can you match the "cpum_" prefix specifically, instead?
> 
> Thanks,
> Mark.
> 

I am sorry, I don't follow you.
When I look at the code function sequence

perf_pmu__scan()
+---> pmu_read_sysfs()
      This functions scans directory /sys/bus/event_source/devices/
      and calls for each entry in this directory. For s390 these entries exist:
      cpum_sf cpum_cf tracepoint and software
      +---> perf_pmu__find();
            +---> pmu_lookup()
                  +---> pmu_format()
                        Looks for file /sys/bus/event_source/devices/cpum_cf/format/event
                        and parses its contents. This returns 0 on s390.
                  +---> pmu_type() 
                        Looks for file /sys/bus/event_source/devices/cpum_cf/type and
                        and parses its contents. This returns 0 on s390.
                  +---> pmu_aliases() 
                        Looks for directory /sys/bus/event_source/devices/cpum_cf/events and
                        reads out every entry name which is treated as a event name and added
                        to the list of PMU-Aliases together with the file contents. For example
                        /sys/bus/event_source/devices/cpum_cf/events/SF_CYCLES_BASIC with the
                        file contents event=0xb0000. This is the raw event number.
                        +----> pmu_aliases_parse() + perf_pmu__new_alias()
                               Check and add alias name to a list.
                  +---> pmu_cpumask()
                        This tests for files /sys/bus/event_source/devices/cpum_cf/cpus or
                        /sys/bus/event_source/devices/cpum_cf/cpumask which do not exist on
                        s390.
                  +---> pmu_add_cpu_aliases() adds the list of aliases such as cpum_sf/SF_CYCLES_BASIC/
                        to the global list of aliases. But ths happens only when
                        +---> is_pmu_core()
                              function returns true.
                              And for s390 it needs to test for /sys/bus/event_source/devices/cpum_sf/ and
                              /sys/bus/event_source/devices/cpum_cf/
                              directories.
                              These directories are used to read the alias names in function
                              pmu_aliases() above.
                        
Maybe I misunderstand this whole scheme, but with this patch the perf list commands works...

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
