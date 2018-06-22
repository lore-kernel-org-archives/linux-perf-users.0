From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH 4/4] perf stat: Add transaction flag (-T) support for s390
Date: Fri, 22 Jun 2018 10:10:01 +0200
Message-ID: <57f6e02e-a8e8-73fb-11d1-24fb6b5e2e9a@linux.ibm.com>
References: <20180621080452.61012-1-tmricht@linux.ibm.com>
 <20180621080452.61012-4-tmricht@linux.ibm.com>
 <87in6bsg2z.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87in6bsg2z.fsf@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 06/22/2018 04:36 AM, Andi Kleen wrote:
> Thomas Richter <tmricht@linux.ibm.com> writes:
>>  
>> +		/* Handle -T as -M transaction. Once platform specific metrics
>> +		 * support has been added to the json files, all archiectures
>> +		 * will use this approach.
>> +		 */
>> +		if (!strcmp(perf_env__arch(NULL), "s390")) {
> 
> Use pmu_have_event() instead.

Done see version v2

> 
> You may need to add support for wildcard pmus to it.
> 
> -Andi
> 

Currently only one PMU on s390 does support transactions, its the PMU with counters
named cpum_cf.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
