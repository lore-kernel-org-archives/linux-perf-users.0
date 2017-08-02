From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] perf report fix module symbol adjustment for s390x
Date: Wed, 2 Aug 2017 13:25:55 +0200
Message-ID: <19971276-2b20-681f-b284-2f8b140f30de@linux.vnet.ibm.com>
References: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
 <20170725061410.GA28831@sejong>
 <8fb23780-a67f-73b1-7f37-3d57271c3e87@linux.vnet.ibm.com>
 <20170725103240.GC28831@sejong> <20170725142049.GB11990@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752958AbdHBL0D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Aug 2017 07:26:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v72BPjpR086759
        for <linux-perf-users@vger.kernel.org>; Wed, 2 Aug 2017 07:26:02 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c387uh1h5-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Aug 2017 07:26:02 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 2 Aug 2017 12:26:00 +0100
In-Reply-To: <20170725142049.GB11990@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, linux-perf-users@vger.kernel.org, kernel-team@lge.com

On 07/25/2017 04:20 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 25, 2017 at 07:32:40PM +0900, Namhyung Kim escreveu:
>> On Tue, Jul 25, 2017 at 10:49:24AM +0200, Thomas-Mich Richter wrote:
>>> On 07/25/2017 08:14 AM, Namhyung Kim wrote:
>>>> Hello,
>>>>
>>>> On Mon, Jul 24, 2017 at 04:35:13PM +0200, Thomas Richter wrote:
>>>>> The perf report tool does not display the addresses of kernel
>>>>> module symbols correctly.
>>>>>
>>>>> For example symbol qeth_send_ipa_cmd in kernel module qeth.ko
>>>>> has this relative address for function qeth_send_ipa_cmd()
>>>>> [root@s8360047 linux]# nm -g drivers/s390/net/qeth.ko | fgrep send_ipa_cmd
>>>>> 0000000000013088 T qeth_send_ipa_cmd
>>>>>
>>>>> The module is loaded at address
>>>>> [root@s8360047 linux]# cat /sys/module/qeth/sections/.text
>>>>> 0x000003ff80296d20
>>>>> [root@s8360047 linux]#
>>>>>
>>>>> This should result in a start address of
>>>>> 0x13088 + 0x3ff80296d20 = 0x3ff802a9da8
>>>>>
>>>>> Using crash to verify the address on a live system:
>>>>> [root@s8360046 linux]# crash vmlinux
>>>>>
>>>>> crash 7.1.9++
>>>>> Copyright (C) 2002-2016  Red Hat, Inc.
>>>>> Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
>>>>>
>>>>> [...]
>>>>>
>>>>> crash> mod -s qeth drivers/s390/net/qeth.ko
>>>>>      MODULE       NAME        SIZE  OBJECT FILE
>>>>>      3ff8028d700  qeth      151552  drivers/s390/net/qeth.ko
>>>>> crash> sym qeth_send_ipa_cmd
>>>>> 3ff802a9da8 (T) qeth_send_ipa_cmd [qeth] /root/linux/drivers/s390/net/qeth_core_main.c: 2944
>>>>> crash>
>>>>>
>>>>> Now perf report displays the address of symbol qeth_send_ipa_cmd:
>>>>> symbol__new: qeth_send_ipa_cmd 0x130f0-0x132ce
>>>>>
>>>>> There is a difference of 0x68 between the entry in the
>>>>> symbol table (see nm command above) and perf. The difference is from
>>>>> the offset the .text segment of qeth.ko:
>>>>>
>>>>> [root@s8360047 perf]# readelf -a drivers/s390/net/qeth.ko
>>>>> Section Headers:
>>>>>   [Nr] Name              Type             Address           Offset
>>>>>        Size              EntSize          Flags  Link  Info  Align
>>>>>   [ 0]                   NULL             0000000000000000  00000000
>>>>>        0000000000000000  0000000000000000           0     0     0
>>>>>   [ 1] .note.gnu.build-i NOTE             0000000000000000  00000040
>>>>>        0000000000000024  0000000000000000   A       0     0     4
>>>>>   [ 2] .text             PROGBITS         0000000000000000  00000068
>>>>>        000000000001c8a0  0000000000000000  AX       0     0     8
>>>>>
>>>>> As seen the .text segment has an offset of 0x68 with start address 0x0.
>>>>> Therefore 0x68 is added to the address of qeth_send_ipa_cmd and thus
>>>>> 0x13088 + 0x68 = 0x130f0 is displayed.
>>>>>
>>>>> This is wrong, perf report needs to display the start address of
>>>>> symbol qeth_send_ipa_cmd at 0x13088 + qeth.ko.text section start address.
>>>>>
>>>>> The qeth.ko module .text start address is available in the qeth.ko
>>>>> DSO map. Just identify the kernel module symbols and correct the
>>>>> addresses.
>>>>>
>>>>> With the fix I see this correct address for symbol:
>>>>> symbol__new: qeth_send_ipa_cmd 0x3ff802a9da8-0x3ff802a9f86
>>>>>
>>>>> I am not sure if this patch uses the perfect approach.
>>>>> Hints and sugguests welcome.
>>>>
>>>> I saw this problem on x86_64 too and I don't know why we add sh_offset
>>>> to symbols.  To me, current symbol code is somewhat hacky and needs
>>>> some love.
>>>>
>>>> Thanks,
>>>> Namhyung
>>>>
>>>
>>> Okay, how do we continue with this issue?
>>> The patch I submitted uses a __weak function of s390x and does not
>>> address other platforms.
>>
>> Not sure.  The symbol code is complex and needs to consider many
>> cases.  I think we need to rethink the 'adjust_symbols' logic and
>> to check adding 'sh_offset' is valid.
> 
> right, there are way too many details, we need more tests in 'perf test'
> and then go on simplifying that code.
> 
> But as a first step I think we can add yet this arch specific bit, at
> least we will have it documented how this works in yet another arch,
> then, when simplifying the code, we would take it into account, and
> retest on those arches.
> 
> - Arnaldo
> 

Arnaldo, Namhyung,

just a quick reminder, do you intend to pick these two patches?
Should I resent them again?

Please let me know?

>> Thanks,
>> Namhyung
>>
>>
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
>>>>> ---
>>>>>  tools/perf/arch/s390/util/sym-handling.c | 7 +++++++
>>>>>  tools/perf/util/symbol-elf.c             | 8 +++++++-
>>>>>  tools/perf/util/symbol.h                 | 3 +++
>>>>>  3 files changed, 17 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/perf/arch/s390/util/sym-handling.c b/tools/perf/arch/s390/util/sym-handling.c
>>>>> index b6cd056..79bf238 100644
>>>>> --- a/tools/perf/arch/s390/util/sym-handling.c
>>>>> +++ b/tools/perf/arch/s390/util/sym-handling.c
>>>>> @@ -19,4 +19,11 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
>>>>>  	return ehdr.e_type == ET_REL || ehdr.e_type == ET_DYN;
>>>>>  }
>>>>>  
>>>>> +u64 arch__sym_set_address(GElf_Sym *sym, GElf_Shdr *shdr __maybe_unused,
>>>>> +			  struct map *map)
>>>>> +{
>>>>> +	if (map->type == MAP__FUNCTION)
>>>>> +		sym->st_value += map->start;
>>>>> +	return sym->st_value;
>>>>> +}
>>>>>  #endif
>>>>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>>>>> index 502505c..d3521d4 100644
>>>>> --- a/tools/perf/util/symbol-elf.c
>>>>> +++ b/tools/perf/util/symbol-elf.c
>>>>> @@ -793,6 +793,12 @@ static u64 ref_reloc(struct kmap *kmap)
>>>>>  void __weak arch__sym_update(struct symbol *s __maybe_unused,
>>>>>  		GElf_Sym *sym __maybe_unused) { }
>>>>>  
>>>>> +u64 __weak arch__sym_set_address(GElf_Sym *sym, GElf_Shdr *shdr,
>>>>> +				 struct map *map __maybe_unused)
>>>>> +{
>>>>> +	return sym->st_value - (shdr->sh_addr - shdr->sh_offset);
>>>>> +}
>>>>> +
>>>>>  int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>>>>>  		  struct symsrc *runtime_ss, int kmodule)
>>>>>  {
>>>>> @@ -973,7 +979,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>>>>>  
>>>>>  			/* Adjust symbol to map to file offset */
>>>>>  			if (adjust_kernel_syms)
>>>>> -				sym.st_value -= shdr.sh_addr - shdr.sh_offset;
>>>>> +				sym.st_value = arch__sym_set_address(&sym, &shdr, map);
>>>>>  
>>>>>  			if (strcmp(section_name,
>>>>>  				   (curr_dso->short_name +
>>>>> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
>>>>> index 41ebba9..beb8737 100644
>>>>> --- a/tools/perf/util/symbol.h
>>>>> +++ b/tools/perf/util/symbol.h
>>>>> @@ -343,6 +343,9 @@ int setup_intlist(struct intlist **list, const char *list_str,
>>>>>  #ifdef HAVE_LIBELF_SUPPORT
>>>>>  bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
>>>>>  void arch__sym_update(struct symbol *s, GElf_Sym *sym);
>>>>> +u64 arch__sym_set_address(GElf_Sym *sym,
>>>>> +			  GElf_Shdr *shdr __maybe_unused,
>>>>> +			  struct map *map __maybe_unused);
>>>>>  #endif
>>>>>  
>>>>>  #define SYMBOL_A 0
>>>>> -- 
>>>>> 2.9.3
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>>
>>> -- 
>>> Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
>>> --
>>> Vorsitzende des Aufsichtsrats: Martina Koederitz 
>>> Geschäftsführung: Dirk Wittkopp
>>> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
>>>
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
