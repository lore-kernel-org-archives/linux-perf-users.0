From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] perf report fix module symbol adjustment for s390x
Date: Thu, 3 Aug 2017 11:37:02 +0200
Message-ID: <8b684e81-5af9-4b61-0116-3b2ff6492318@linux.vnet.ibm.com>
References: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
 <20170802184202.GK12201@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33875 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751345AbdHCJhJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Aug 2017 05:37:09 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v739ZBXS018782
        for <linux-perf-users@vger.kernel.org>; Thu, 3 Aug 2017 05:37:08 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c3y4fqhfp-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Aug 2017 05:37:08 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 3 Aug 2017 10:37:06 +0100
In-Reply-To: <20170802184202.GK12201@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, linux-perf-users@vger.kernel.org

On 08/02/2017 08:42 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 24, 2017 at 04:35:13PM +0200, Thomas Richter escreveu:
>> +++ b/tools/perf/util/symbol-elf.c
>> @@ -793,6 +793,12 @@ static u64 ref_reloc(struct kmap *kmap)
>>  void __weak arch__sym_update(struct symbol *s __maybe_unused,
>>  		GElf_Sym *sym __maybe_unused) { }
>>  
>> +u64 __weak arch__sym_set_address(GElf_Sym *sym, GElf_Shdr *shdr,
>> +				 struct map *map __maybe_unused)
>> +{
>> +	return sym->st_value - (shdr->sh_addr - shdr->sh_offset);
>> +}
>> +
>>  int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>>  		  struct symsrc *runtime_ss, int kmodule)
>>  {
>> @@ -973,7 +979,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>>  
>>  			/* Adjust symbol to map to file offset */
>>  			if (adjust_kernel_syms)
>> -				sym.st_value -= shdr.sh_addr - shdr.sh_offset;
>> +				sym.st_value = arch__sym_set_address(&sym, &shdr, map);
> 
> Since this is just used when "adjusting" the symbol wrt file offset,
> can we have a more descriptive name? Like:
> 
> void __weak arch__adjust_sym_map_offset(GElf_Sym *sym, GElf_Shdr *shdr,
> 					struct map *map __maybe_unused)
> {
> 	sym->st_value -= shdr->sh_addr - shdr->sh_offset;
> }
> 
> Then have it as:
> 
> -			/* Adjust symbol to map to file offset */
>  			if (adjust_kernel_syms)
> -				sym.st_value -= shdr.sh_addr - shdr.sh_offset;
> +				arch__adjust_sym_map_offset(&sym, &shdr, map);
> 
> I.e. the weak function name becomes the comment :-)
> 

Ok , I will provide a version 2 with your findings fixed. I'll include a 
Reviewed-by:
if this is ok with you.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
