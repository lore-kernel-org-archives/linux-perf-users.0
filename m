Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E07615382E;
	Tue, 25 Jun 2024 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340756; cv=none; b=PTmiHwDKo0xCLRihiPE7o16fOuwZM+aAFJIGDQ9SqS2hLjt7deehALUeZLLQM7Y/SUYHUncmGoKtLV3okxPn0XbcToB1NKI4/LmkXfO+kTvbD1F3hzFffRcJO37YaN8yPbcwQoM0Cow5CSWbwlMZ0U0jOMa1R2ps3TQSsyEUb0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340756; c=relaxed/simple;
	bh=mwdzdxZpVEVZ1zCBE51emz8QymqVopARr8duAzP6eC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opU/dtLO4552LfrtwofgiCPsUPUOQTfRckOO7YgSAL6SpTBtavsxvwtAxwmwhfLnFU3Mv4eiLL9J9t719Pr5KyWqt2tXAIIVgc97Am/GFI0v1yJDy6vBQz+L9ruWWw7T2Ps+90Nlao43Kk/sJXS3U3DiQqzZ6wVJAn2qSL+DP+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMRdTTMx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMRdTTMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851A3C32781;
	Tue, 25 Jun 2024 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719340756;
	bh=mwdzdxZpVEVZ1zCBE51emz8QymqVopARr8duAzP6eC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMRdTTMxtJyc8KClWxIWxTd2HSHixHI0soc287gjuE9L7gNr3/mWMcxYnVTAi3F/U
	 S1FGa6xwXF3EUtoMnTNCIIB1rmsNoyGs8iddiyKXuaJqL2Bw7RuWj801D6Eu/D/HT6
	 W66t8Zj0z/DHpSm8+0dhMdOuFL8YnRzlNvN7FMK/l8UrdReQOEhJqkMTnkG/f5xD2g
	 dbM9aUnr1rNZM9zLK3sy7lO/eBLltrsKZXQ/2BzMDbrUtnWVB6WMU8GxONYvg5kPek
	 0IQnHlMfX3x4tERmEVZZVqEXs1EQlXSbTyRt6uz+v6vuv5PdJDWN9abmvzpXo87tyu
	 oVtNKA9kD4KtQ==
Date: Tue, 25 Jun 2024 11:39:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
	maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [V4 03/16] tools/perf: Add support to capture and parse raw
 instruction in powerpc using dso__data_read_offset utility
Message-ID: <ZnsO0cmpL640TxJp@google.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
 <20240614172631.56803-4-atrajeev@linux.vnet.ibm.com>
 <ZnpVn1yLtDnRnTBh@google.com>
 <B834FFD2-AC2E-4F7F-9B0B-15CBFB19A6A7@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B834FFD2-AC2E-4F7F-9B0B-15CBFB19A6A7@linux.vnet.ibm.com>

On Tue, Jun 25, 2024 at 06:08:49PM +0530, Athira Rajeev wrote:
> 
> 
> > On 25 Jun 2024, at 10:59 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > On Fri, Jun 14, 2024 at 10:56:18PM +0530, Athira Rajeev wrote:
> >> Add support to capture and parse raw instruction in powerpc.
> >> Currently, the perf tool infrastructure uses two ways to disassemble
> >> and understand the instruction. One is objdump and other option is
> >> via libcapstone.
> >> 
> >> Currently, the perf tool infrastructure uses "--no-show-raw-insn" option
> >> with "objdump" while disassemble. Example from powerpc with this option
> >> for an instruction address is:
> >> 
> >> Snippet from:
> >> objdump  --start-address=<address> --stop-address=<address>  -d --no-show-raw-insn -C <vmlinux>
> >> 
> >> c0000000010224b4: lwz     r10,0(r9)
> > 
> > What about removing --no-show-raw-insn and parse the raw byte code in
> > the output for powerpc?  I think it's better to support normal
> > annotation together.
> Hi Namhyung,
> 
> Yes, In the other patch in same series, I have added support for normal annotation together.
> Patch 5 includes changes to work with binary code as well as mneumonic representation.
> 
> Example representation using --show-raw-insn in objdump gives result:
> 
> 38 01 81 e8 ld r4,312(r1)
> 
> Patch5 has changes to use “objdump” with --show-raw-insn to read the raw instruction and also support normal annotation.

Ok, that's good!


> In case of data type profiling, with only sort keys, (type, typeoff) there is no need to disassemble and then get raw byte code.
> Binary code can be read directly from the DSO. Compared to using objdump, directly reading from DSO will be faster in this case.

Sounds like an optimization.  Then I think you'd better handle the
general case first and optimize later.  Probably you want to merge
patch 3 and 4 together.

Thanks,
Namhyung


> In summary, current patchset uses below approach:
> 
> 1. Read directly from DSO using dso__data_read_offset if only “type, typeoff” is needed.
> 2. If in any case reading directly from DSO fails, fallback to using libcapstone. Using libcapstone to read is faster than objdump
> 3. If libcapstone is not supported, approach will use objdump. Patchset has changes to handle objdump result created with show-raw-ins in powerpc. 
> 4. Also for normal perf report or perf annotate, approach will use objdump
> 
> NOTE:
> libcapstone is used currently only for reading raw binary code. Disassemble is currently not enabled. While attempting to do cs_disasm, observation is that some of the instructions were not identified (ex: extswsli, maddld) and it had to fallback to use objdump. Hence enabling "cs_disasm" is added in comment section as a TODO for powerpc. Patch number 13. 
> 
> Thanks
> Athira
> 
> > 
> >> 
> >> This line "lwz r10,0(r9)" is parsed to extract instruction name,
> >> registers names and offset. Also to find whether there is a memory
> >> reference in the operands, "memory_ref_char" field of objdump is used.
> >> For x86, "(" is used as memory_ref_char to tackle instructions of the
> >> form "mov  (%rax), %rcx".
> >> 
> >> In case of powerpc, not all instructions using "(" are the only memory
> >> instructions. Example, above instruction can also be of extended form (X
> >> form) "lwzx r10,0,r19". Inorder to easy identify the instruction category
> >> and extract the source/target registers, patch adds support to use raw
> >> instruction for powerpc. Approach used is to read the raw instruction
> >> directly from the DSO file using "dso__data_read_offset" utility which
> >> is already implemented in perf infrastructure in "util/dso.c".
> >> 
> >> Example:
> >> 
> >> 38 01 81 e8     ld      r4,312(r1)
> >> 
> >> Here "38 01 81 e8" is the raw instruction representation. In powerpc,
> >> this translates to instruction form: "ld RT,DS(RA)" and binary code
> >> as:
> >> 
> >>   | 58 |  RT  |  RA |      DS       | |
> >>   -------------------------------------
> >>   0    6     11    16              30 31
> >> 
> >> Function "symbol__disassemble_dso" is updated to read raw instruction
> >> directly from DSO using dso__data_read_offset utility. In case of
> >> above example, this captures:
> >> line:    38 01 81 e8
> >> 
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >> ---
> >> tools/perf/util/disasm.c | 98 ++++++++++++++++++++++++++++++++++++++++
> >> 1 file changed, 98 insertions(+)
> >> 
> >> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> >> index b5fe3a7508bb..f19496133bf0 100644
> >> --- a/tools/perf/util/disasm.c
> >> +++ b/tools/perf/util/disasm.c
> >> @@ -1586,6 +1586,91 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
> >> }
> >> #endif
> >> 
> >> +static int symbol__disassemble_dso(char *filename, struct symbol *sym,
> > 
> > Maybe rename to symbol__disassemble_raw() ?
> 
> This is specifically using dso__data_read_offset. Hence using symbol__disassemble_dso 
> > 
> >> + struct annotate_args *args)
> >> +{
> >> + struct annotation *notes = symbol__annotation(sym);
> >> + struct map *map = args->ms.map;
> >> + struct dso *dso = map__dso(map);
> >> + u64 start = map__rip_2objdump(map, sym->start);
> >> + u64 end = map__rip_2objdump(map, sym->end);
> >> + u64 len = end - start;
> >> + u64 offset;
> >> + int i, count;
> >> + u8 *buf = NULL;
> >> + char disasm_buf[512];
> >> + struct disasm_line *dl;
> >> + u32 *line;
> >> +
> >> + /* Return if objdump is specified explicitly */
> >> + if (args->options->objdump_path)
> >> + return -1;
> >> +
> >> + pr_debug("Reading raw instruction from : %s using dso__data_read_offset\n", filename);
> > 
> > You may want to print the actual offset and remove the "using
> > dso__data_read_offset" part.
> 
> Ok Sure
> > 
> > Thanks,
> > Namhyung
> > 
> >> +
> >> + buf = malloc(len);
> >> + if (buf == NULL)
> >> + goto err;
> >> +
> >> + count = dso__data_read_offset(dso, NULL, sym->start, buf, len);
> >> +
> >> + line = (u32 *)buf;
> >> +
> >> + if ((u64)count != len)
> >> + goto err;
> >> +
> >> + /* add the function address and name */
> >> + scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
> >> +   start, sym->name);
> >> +
> >> + args->offset = -1;
> >> + args->line = disasm_buf;
> >> + args->line_nr = 0;
> >> + args->fileloc = NULL;
> >> + args->ms.sym = sym;
> >> +
> >> + dl = disasm_line__new(args);
> >> + if (dl == NULL)
> >> + goto err;
> >> +
> >> + annotation_line__add(&dl->al, &notes->src->source);
> >> +
> >> + /* Each raw instruction is 4 byte */
> >> + count = len/4;
> >> +
> >> + for (i = 0, offset = 0; i < count; i++) {
> >> + args->offset = offset;
> >> + sprintf(args->line, "%x", line[i]);
> >> + dl = disasm_line__new(args);
> >> + if (dl == NULL)
> >> + goto err;
> >> +
> >> + annotation_line__add(&dl->al, &notes->src->source);
> >> + offset += 4;
> >> + }
> >> +
> >> + /* It failed in the middle */
> >> + if (offset != len) {
> >> + struct list_head *list = &notes->src->source;
> >> +
> >> + /* Discard all lines and fallback to objdump */
> >> + while (!list_empty(list)) {
> >> + dl = list_first_entry(list, struct disasm_line, al.node);
> >> +
> >> + list_del_init(&dl->al.node);
> >> + disasm_line__free(dl);
> >> + }
> >> + count = -1;
> >> + }
> >> +
> >> +out:
> >> + free(buf);
> >> + return count < 0 ? count : 0;
> >> +
> >> +err:
> >> + count = -1;
> >> + goto out;
> >> +}
> >> /*
> >>  * Possibly create a new version of line with tabs expanded. Returns the
> >>  * existing or new line, storage is updated if a new line is allocated. If
> >> @@ -1710,6 +1795,19 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> >> strcpy(symfs_filename, tmp);
> >> }
> >> 
> >> + /*
> >> +  * For powerpc data type profiling, use the dso__data_read_offset
> >> +  * to read raw instruction directly and interpret the binary code
> >> +  * to understand instructions and register fields. For sort keys as
> >> +  * type and typeoff, disassemble to mnemonic notation is
> >> +  * not required in case of powerpc.
> >> +  */
> >> + if (arch__is(args->arch, "powerpc")) {
> >> + err = symbol__disassemble_dso(symfs_filename, sym, args);
> >> + if (err == 0)
> >> + goto out_remove_tmp;
> >> + }
> >> +
> >> #ifdef HAVE_LIBCAPSTONE_SUPPORT
> >> err = symbol__disassemble_capstone(symfs_filename, sym, args);
> >> if (err == 0)
> >> -- 
> >> 2.43.0
> 
> 
