From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf report does not resolve symbols on s390x
Date: Wed, 12 Jul 2017 11:05:28 +0200
Message-ID: <371172f0-ecb9-c1c9-a478-e618c0f63c51@linux.vnet.ibm.com>
References: <eb00bf70-936d-e405-5867-015d4067202f@linux.vnet.ibm.com>
 <20170705155007.GH27350@kernel.org>
 <67eb6f70-fc34-95cd-b43c-349bbc24ee5d@linux.vnet.ibm.com>
 <5ead7c5a-5b91-107a-51ca-ea464fe8cfba@linux.vnet.ibm.com>
 <20170711190304.GH27350@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38275 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750741AbdGLJFg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2017 05:05:36 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6C95JpE064410
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2017 05:05:36 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bncjcgy23-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2017 05:05:34 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 12 Jul 2017 10:05:32 +0100
In-Reply-To: <20170711190304.GH27350@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, zvonko.kosic@de.ibm.com, Adrian Hunter <adrian.hunter@intel.com>

On 07/11/2017 09:03 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jul 07, 2017 at 02:17:25PM +0200, Thomas-Mich Richter escreveu:
>> On 07/06/2017 02:35 PM, Thomas-Mich Richter wrote:
>>> On 07/05/2017 05:50 PM, Arnaldo Carvalho de Melo wrote:

[...]

>> The fog has lifted and I found the root cause. Digging into machine__resolve was the
>> right hint...
> 
>> What happens is this (short version)
>> machine__resolve has map and sym pointers ( al->map:0x32629190 al->sym:0x32776f40 )
>> --> sample__resolve_callchain al->map:0x32629190 al->sym:0x32776f40
>>     --> thread__resolve_callchain al->map:0x32629190 al->sym:0x32776f40
>>         --> thread__resolve_callchain_sample
>>             creates a new struct addr_location to find the ip addr and its details.
>>             --> add_callchain_ip (cpumode:2 --> user space address indicator)
>>                 --> thread__find_addr_map 
>>                     this function can not resolve the address and as a last action
>>                     tries to resolve the address within kernel address space 
>>                     --> machine__get_kernel_start
> 
>> Now this function is interesting:
> 
>> int machine__get_kernel_start(struct machine *machine)
>> {
>>         struct map *map = machine__kernel_map(machine);
>>         int err = 0;
> 
>>         /*
>>          * The only addresses above 2^63 are kernel addresses of a 64-bit
>>          * kernel.  Note that addresses are unsigned so that on a 32-bit system
>>          * all addresses including kernel addresses are less than 2^32.  In
>>          * that case (32-bit system), if the kernel mapping is unknown, all
>>          * addresses will be assumed to be in user space - see
>>          * machine__kernel_ip().
>>          */
>>         machine->kernel_start = 1ULL << 63;
>>         if (map) {
>>                 err = map__load(map);
>>                 if (map->start)
>>                         machine->kernel_start = map->start;
>>         }
>>         return err;
>> }
> 
>> It determines the kernel starts at address 1<<63 and loads the kernel address mapping.
>> On s390x
>> - The kernel starts at 0x0 (value of map->start) and thus all checks in function 
>>   thread__find_addr_map() fail and no symbol is found for the specified addresses
>>   because the kernel starts at 0x8000000000000000. Which is wrong the kernel start at 0x0.
> 
> Hi Thomas, really nice debugging session!

Thanks for the credit.... :-)
> 
> I'm trying the one-liner below, Adrian, can you please check this and
> provide an ack? I think that that comment about the address that it will
> default when map__load() fails needs rewriting in light of Thomas
> comments about other arches (see further below)?
> 
> I did a quick check of machine->kernel_start usage in Intel PT and since
> on x86 that assumption about partitioning the address space holds, no
> problem should be introduced by the one-liner fix, right?
> 
> - Arnaldo
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 5de2b86b9880..2e9eb6aa3ce2 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2209,7 +2209,7 @@ int machine__get_kernel_start(struct machine *machine)
>  	machine->kernel_start = 1ULL << 63;
>  	if (map) {
>  		err = map__load(map);
> -		if (map->start)
> +		if (!err)
>  			machine->kernel_start = map->start;
>  	}
>  	return err;
> 
> 

I like this patch. I have done a new build and removed all my debug output to start
from scratch. Without your patch I get this:

 To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 4  of event 'cpu-clock'
# Event count (approx.): 1000000
#
# Children      Self  Command  Shared Object     Symbol                  
# ........  ........  .......  ................  ........................
#
    75.00%     0.00%  true     [unknown]         [k] 0x00000000004bedda
            |
            ---0x4bedda
               |          
               |--50.00%--0x42693a
               |          |          
               |           --25.00%--0x2a72e0
               |                     0x2af0ca
               |                     0x3d1003fe4c0
               |          
                --25.00%--0x4272bc
                          0x26fa84


and with your patch (I just rebuilt the perf tool, nothing else and used the same
perf.data file as input):

# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 4  of event 'cpu-clock'
# Event count (approx.): 1000000
#
# Children      Self  Command  Shared Object               Symbol                            
# ........  ........  .......  ..........................  ..................................
#
    75.00%     0.00%  true     [kernel.vmlinux]            [k] pgm_check_handler
            |
            ---pgm_check_handler
               do_dat_exception
               handle_mm_fault
               __handle_mm_fault
               filemap_map_pages
               |          
               |--25.00%--rcu_read_lock_held
               |          rcu_lockdep_current_cpu_online
               |          0x3d1003ff4c0
               |          
                --25.00%--lock_release


Looks good to me....

>> -- 
>> Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
>> --
>> Vorsitzende des Aufsichtsrats: Martina Koederitz 
>> Geschäftsführung: Dirk Wittkopp
>> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 


-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
