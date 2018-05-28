From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf test 39 (Session topology) dumps core on s390
Date: Mon, 28 May 2018 08:50:13 +0200
Message-ID: <9042034b-0d46-0bfb-7737-717e7d5803d6@linux.ibm.com>
References: <20180524135600.77128-1-tmricht@linux.ibm.com>
 <610eac04-1e34-9032-0a95-2f9818a31a9b@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <610eac04-1e34-9032-0a95-2f9818a31a9b@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 05/28/2018 05:49 AM, Ravi Bangoria wrote:
> Hi Thomas,
> 
> On 05/24/2018 07:26 PM, Thomas Richter wrote:
>> @@ -95,7 +98,7 @@ int test__session_topology(struct test *test __maybe_unused, int subtest __maybe
>>  {
>>  	char path[PATH_MAX];
>>  	struct cpu_map *map;
>> -	int ret = -1;
>> +	int ret;
> 
> This is failing for me:
> 
> tests/topology.c: In function ‘test__session_topology’:
> tests/topology.c:101:6: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   int ret;
>       ^
> cc1: all warnings being treated as errors
>   CC       util/intlist.o
> mv: cannot stat 'tests/.topology.o.tmp': No such file or directory
> /home/ravi/Workspace/linux/tools/build/Makefile.build:96: recipe for target 'tests/topology.o' failed
> make[4]: *** [tests/topology.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> 
> 
> Thanks,
> Ravi
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Thanks for the pointer, will provide V2.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
