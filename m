From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/1] perf tools: Fix Symbol Address for ET_DYN
Date: Mon, 29 Sep 2014 11:33:35 +0900
Message-ID: <87ppefi29s.fsf@sejong.aot.lge.com>
References: <CAPp4yYwTHbXiypxR_1WJGS9DYQNJ24t_Ykdo_sfQ48Ak-K3Z7g@mail.gmail.com>
	<20140911150123.GH10158@kernel.org>
	<CAPp4yYzRwoTBzH1_TwcdvAOryZppV9-BwnX2bOtN1qrEqrdBww@mail.gmail.com>
	<20140911203806.GA25763@kernel.org>
	<CAPp4yYzT66+J_dHC5_0TiTEdSK874OS-PH9nAtcr5-Luj69+7w@mail.gmail.com>
	<CAPp4yYxripyJvr87TtVqNMi5=K+UQGeKTomQiJarFnVGyjtofA@mail.gmail.com>
	<87fvffj5o0.fsf@sejong.aot.lge.com>
	<CAPp4yYzPR-FozYeuDUFqR0hhE5tioSqNy22cZ7WjSdBXoxeNxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:37938 "EHLO
	lgemrelse7q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611AbaI2Cdi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 28 Sep 2014 22:33:38 -0400
In-Reply-To: <CAPp4yYzPR-FozYeuDUFqR0hhE5tioSqNy22cZ7WjSdBXoxeNxw@mail.gmail.com>
	(Tong Shen's message of "Thu, 25 Sep 2014 22:53:22 -0700")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Tong Shen <endlessroad@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Tong,

On Thu, 25 Sep 2014 22:53:22 -0700, Tong Shen wrote:
>>>>>> +/**
>>>>>> + * is_non_relocatable_dyn - check if ELF file is ET_DYN, but not relocatable
>>>>>> + * @ehdr: ELF header of the ELF file
>>>>>> + * @shdr: a section header in the ELF file
>>>>>> + *
>>>>>> + * For ELF files with type ET_EXEC and ET_REL, we adjust symbol addresses in
>>>>>> + * symbol table in dso__load_sym() so that later we can always locate symbols
>>>>>> + * by sym.st_value + map_address_of_ELF_file.
>>>>>> + *
>>>>>> + * But ELF files with type ET_DYN may need adjusting as well, if they are
>>>>>> + * not relocatable. There's no standard way to tell if an ELF file with type
>>>>>> + * ET_DYN is relocatable. One possible way to do that is checking if
>>>>>> + * sh_addr == sh_offset for .text section.
>>>>>> + */
>>>>>> +static bool is_non_relocatable_dyn(GElf_Ehdr *ehdr, GElf_Shdr *shdr,
>>>>>> +                                   Elf_Data *secstrs) {
>>>>>> +     return ehdr->e_type == ET_DYN &&
>>>>>> +            elf_sec__is_text(shdr, secstrs) &&
>>>>>> +            shdr->sh_offset != shdr->sh_addr;
>>>>>> +}
>>>>>> +
>>>>>>  int dso__load_sym(struct dso *dso, struct map *map,
>>>>>>                 struct symsrc *syms_ss, struct symsrc *runtime_ss,
>>>>>>                 symbol_filter_t filter, int kmodule)
>>>>>> @@ -914,8 +935,9 @@ int dso__load_sym(struct dso *dso, struct map *map,
>>>>>>                       goto new_symbol;
>>>>>>               }
>>>>>>
>>>>>> -             if ((used_opd && runtime_ss->adjust_symbols)
>>>>>> -                             || (!used_opd && syms_ss->adjust_symbols)) {
>>>>>> +             if ((used_opd && runtime_ss->adjust_symbols) ||
>>>>>> +                 (!used_opd && syms_ss->adjust_symbols) ||
>>>>>> +                 is_non_relocatable_dyn(&ehdr, &shdr, secstrs)) {
>>>>>>                       pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
>>>>>>                                 "sh_addr: %#" PRIx64 " sh_offset: %#" PRIx64 "\n", __func__,
>>>>>>                                 (u64)sym.st_value, (u64)shdr.sh_addr,

Hmm.. IIUC for normal dso (ET_DYN), shdr->offset == shdr->sh_addr for
text section right?  And we always adjust ET_EXEC and ET_REL..  What
about always trying to adjust symbol address then?  We may precalculate
adjust offset and subtracting it from symbol values.  And the offset of
0 effectively means no adjust.  This way we can simplify the logic IMHO.

Thanks,
Namhyung
