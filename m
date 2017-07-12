From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf report does not resolve symbols on s390x
Date: Wed, 12 Jul 2017 10:21:22 +0200
Message-ID: <ddb4aaca-6529-5f9a-45ca-c6d05cbd48e4@linux.vnet.ibm.com>
References: <eb00bf70-936d-e405-5867-015d4067202f@linux.vnet.ibm.com>
 <20170705155007.GH27350@kernel.org>
 <67eb6f70-fc34-95cd-b43c-349bbc24ee5d@linux.vnet.ibm.com>
 <5ead7c5a-5b91-107a-51ca-ea464fe8cfba@linux.vnet.ibm.com>
 <20170711190304.GH27350@kernel.org> <20170711193828.GI27350@kernel.org>
 <20170711194853.GJ27350@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59597 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933336AbdGLIVb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2017 04:21:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6C8KsGn089724
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2017 04:21:30 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bncjcfbyw-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2017 04:21:30 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 12 Jul 2017 09:21:28 +0100
In-Reply-To: <20170711194853.GJ27350@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Zvonko Kosic <zvonko.kosic@de.ibm.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 07/11/2017 09:48 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 11, 2017 at 04:38:28PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Tue, Jul 11, 2017 at 04:03:04PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Fri, Jul 07, 2017 at 02:17:25PM +0200, Thomas-Mich Richter escreveu:
.....

> 
>> Argh, this is also broken:
> 
>> static inline bool machine__kernel_ip(struct machine *machine, u64 ip)
>> {
>>         u64 kernel_start = machine__kernel_start(machine);
>>
>>         return ip >= kernel_start;
>> }
>>
>> We can't judge if a address is in the kernel like that :-\
> 
> So, this is used by:
> 
> [acme@jouet linux]$ find tools/ -name "*.[ch]" | xargs grep -w machine__kernel_ip
> tools/perf/builtin-script.c:	kernel = machine__kernel_ip(machine, start);
> tools/perf/builtin-script.c:	if (kernel != machine__kernel_ip(machine, end)) {
> 
> That is just for "brstackinsn", would that make sense for Sparc, S/390?

No we don't have that on s/390
> 
> tools/perf/util/intel-bts.c:	if (machine__kernel_ip(machine, ip))
> tools/perf/util/intel-bts.c:		if (!machine__kernel_ip(btsq->bts->machine, branch->from) &&
> tools/perf/util/intel-bts.c:		    machine__kernel_ip(btsq->bts->machine, branch->to) &&
> 
> Intel specific stuff, so should be ok.
> 
> tools/perf/util/event.c:		    machine__kernel_ip(machine, al->addr)) {
> 
> For this last one, that affects all arches, I think we can just remove
> this check and look at the kernel when not finding it anywhere else?
> 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index dc5c3bb69d73..8e435baaae6a 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -1432,8 +1432,7 @@ void thread__find_addr_map(struct thread *thread, u8 cpumode,
>  		 * in the whole kernel symbol list.
>  		 */
>  		if (cpumode == PERF_RECORD_MISC_USER && machine &&
> -		    mg != &machine->kmaps &&
> -		    machine__kernel_ip(machine, al->addr)) {
> +		    mg != &machine->kmaps) {
>  			mg = &machine->kmaps;
>  			load_map = true;
>  			goto try_again;
> 
>>>> This raises 2 questions:
>>>> 1. s390 has a 64 bit address space for user and kernel. The processor status word (PSW)
>>>>    determines which address space to use. That requires the PSW in the sample. Not sure
>>>>    this is the case?
>>>> 2. How does this work on sparc and other architectures with the same addressing scheme?
>>>>
>>>> Thanks.
>>>> --
>>>> Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
