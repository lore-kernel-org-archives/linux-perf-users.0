From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/2] perf report fix module symbol adjustment for s390x
Date: Tue, 25 Jul 2017 19:32:40 +0900
Message-ID: <20170725103240.GC28831@sejong>
References: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
 <20170725061410.GA28831@sejong>
 <8fb23780-a67f-73b1-7f37-3d57271c3e87@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:57342 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbdGYKcm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Jul 2017 06:32:42 -0400
Content-Disposition: inline
In-Reply-To: <8fb23780-a67f-73b1-7f37-3d57271c3e87@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, linux-perf-users@vger.kernel.org, acme@kernel.org, kernel-team@lge.com

On Tue, Jul 25, 2017 at 10:49:24AM +0200, Thomas-Mich Richter wrote:
> On 07/25/2017 08:14 AM, Namhyung Kim wrote:
> > Hello,
> > 
> > On Mon, Jul 24, 2017 at 04:35:13PM +0200, Thomas Richter wrote:
> >> The perf report tool does not display the addresses of kernel
> >> module symbols correctly.
> >>
> >> For example symbol qeth_send_ipa_cmd in kernel module qeth.ko
> >> has this relative address for function qeth_send_ipa_cmd()
> >> [root@s8360047 linux]# nm -g drivers/s390/net/qeth.ko | fgrep send_ipa_cmd
> >> 0000000000013088 T qeth_send_ipa_cmd
> >>
> >> The module is loaded at address
> >> [root@s8360047 linux]# cat /sys/module/qeth/sections/.text
> >> 0x000003ff80296d20
> >> [root@s8360047 linux]#
> >>
> >> This should result in a start address of
> >> 0x13088 + 0x3ff80296d20 = 0x3ff802a9da8
> >>
> >> Using crash to verify the address on a live system:
> >> [root@s8360046 linux]# crash vmlinux
> >>
> >> crash 7.1.9++
> >> Copyright (C) 2002-2016  Red Hat, Inc.
> >> Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
> >>
> >> [...]
> >>
> >> crash> mod -s qeth drivers/s390/net/qeth.ko
> >>      MODULE       NAME        SIZE  OBJECT FILE
> >>      3ff8028d700  qeth      151552  drivers/s390/net/qeth.ko
> >> crash> sym qeth_send_ipa_cmd
> >> 3ff802a9da8 (T) qeth_send_ipa_cmd [qeth] /root/linux/drivers/s390/net/qeth_core_main.c: 2944
> >> crash>
> >>
> >> Now perf report displays the address of symbol qeth_send_ipa_cmd:
> >> symbol__new: qeth_send_ipa_cmd 0x130f0-0x132ce
> >>
> >> There is a difference of 0x68 between the entry in the
> >> symbol table (see nm command above) and perf. The difference is from
> >> the offset the .text segment of qeth.ko:
> >>
> >> [root@s8360047 perf]# readelf -a drivers/s390/net/qeth.ko
> >> Section Headers:
> >>   [Nr] Name              Type             Address           Offset
> >>        Size              EntSize          Flags  Link  Info  Align
> >>   [ 0]                   NULL             0000000000000000  00000000
> >>        0000000000000000  0000000000000000           0     0     0
> >>   [ 1] .note.gnu.build-i NOTE             0000000000000000  00000040
> >>        0000000000000024  0000000000000000   A       0     0     4
> >>   [ 2] .text             PROGBITS         0000000000000000  00000068
> >>        000000000001c8a0  0000000000000000  AX       0     0     8
> >>
> >> As seen the .text segment has an offset of 0x68 with start address 0x0.
> >> Therefore 0x68 is added to the address of qeth_send_ipa_cmd and thus
> >> 0x13088 + 0x68 = 0x130f0 is displayed.
> >>
> >> This is wrong, perf report needs to display the start address of
> >> symbol qeth_send_ipa_cmd at 0x13088 + qeth.ko.text section start address.
> >>
> >> The qeth.ko module .text start address is available in the qeth.ko
> >> DSO map. Just identify the kernel module symbols and correct the
> >> addresses.
> >>
> >> With the fix I see this correct address for symbol:
> >> symbol__new: qeth_send_ipa_cmd 0x3ff802a9da8-0x3ff802a9f86
> >>
> >> I am not sure if this patch uses the perfect approach.
> >> Hints and sugguests welcome.
> > 
> > I saw this problem on x86_64 too and I don't know why we add sh_offset
> > to symbols.  To me, current symbol code is somewhat hacky and needs
> > some love.
> > 
> > Thanks,
> > Namhyung
> > 
> 
> Okay, how do we continue with this issue?
> The patch I submitted uses a __weak function of s390x and does not
> address other platforms.

Not sure.  The symbol code is complex and needs to consider many
cases.  I think we need to rethink the 'adjust_symbols' logic and
to check adding 'sh_offset' is valid.

Thanks,
Namhyung


> 
> > 
> >>
> >> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> >> ---
> >>  tools/perf/arch/s390/util/sym-handling.c | 7 +++++++
> >>  tools/perf/util/symbol-elf.c             | 8 +++++++-
> >>  tools/perf/util/symbol.h                 | 3 +++
> >>  3 files changed, 17 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/arch/s390/util/sym-handling.c b/tools/perf/arch/s390/util/sym-handling.c
> >> index b6cd056..79bf238 100644
> >> --- a/tools/perf/arch/s390/util/sym-handling.c
> >> +++ b/tools/perf/arch/s390/util/sym-handling.c
> >> @@ -19,4 +19,11 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
> >>  	return ehdr.e_type == ET_REL || ehdr.e_type == ET_DYN;
> >>  }
> >>  
> >> +u64 arch__sym_set_address(GElf_Sym *sym, GElf_Shdr *shdr __maybe_unused,
> >> +			  struct map *map)
> >> +{
> >> +	if (map->type == MAP__FUNCTION)
> >> +		sym->st_value += map->start;
> >> +	return sym->st_value;
> >> +}
> >>  #endif
> >> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> >> index 502505c..d3521d4 100644
> >> --- a/tools/perf/util/symbol-elf.c
> >> +++ b/tools/perf/util/symbol-elf.c
> >> @@ -793,6 +793,12 @@ static u64 ref_reloc(struct kmap *kmap)
> >>  void __weak arch__sym_update(struct symbol *s __maybe_unused,
> >>  		GElf_Sym *sym __maybe_unused) { }
> >>  
> >> +u64 __weak arch__sym_set_address(GElf_Sym *sym, GElf_Shdr *shdr,
> >> +				 struct map *map __maybe_unused)
> >> +{
> >> +	return sym->st_value - (shdr->sh_addr - shdr->sh_offset);
> >> +}
> >> +
> >>  int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
> >>  		  struct symsrc *runtime_ss, int kmodule)
> >>  {
> >> @@ -973,7 +979,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
> >>  
> >>  			/* Adjust symbol to map to file offset */
> >>  			if (adjust_kernel_syms)
> >> -				sym.st_value -= shdr.sh_addr - shdr.sh_offset;
> >> +				sym.st_value = arch__sym_set_address(&sym, &shdr, map);
> >>  
> >>  			if (strcmp(section_name,
> >>  				   (curr_dso->short_name +
> >> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> >> index 41ebba9..beb8737 100644
> >> --- a/tools/perf/util/symbol.h
> >> +++ b/tools/perf/util/symbol.h
> >> @@ -343,6 +343,9 @@ int setup_intlist(struct intlist **list, const char *list_str,
> >>  #ifdef HAVE_LIBELF_SUPPORT
> >>  bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
> >>  void arch__sym_update(struct symbol *s, GElf_Sym *sym);
> >> +u64 arch__sym_set_address(GElf_Sym *sym,
> >> +			  GElf_Shdr *shdr __maybe_unused,
> >> +			  struct map *map __maybe_unused);
> >>  #endif
> >>  
> >>  #define SYMBOL_A 0
> >> -- 
> >> 2.9.3
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> -- 
> Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
> --
> Vorsitzende des Aufsichtsrats: Martina Koederitz 
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 
