Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBBA16DC03;
	Wed, 26 Jun 2024 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719436630; cv=none; b=YcIqSYx1NPczjGlbezfF1WpGCBToyNTVy3hiNzCI8u+wn2zdl8Ru2RLRSpozNNTgICp3UBe9WXJ6JVS7E4dXGvD7iXdYHKGQJgtqW5kCJK2q6QMkPrT0R403JZ4LAKzaAcEpHhvN+kQISwTLIi4b09uZIOSw7MVLA9Idvhlq9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719436630; c=relaxed/simple;
	bh=xnBvbtkr+krg9eOnoyPvmkL0Vo7bx1Jml/6pqm7xWvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StoCp5dNBAfFVTkGhwE+wPeImLlcCtESi778aOzxR+F2stcfFdzUNjQfqAUf9zmp0teHAto/UgSmBNW5zwNN0vV588DNh37DzV3wdAKNVzDDg0049w5elXrztm/+VSjjIelHEXtHmh/TgRGjpn5ooqAhry/yAI58Wk7L+IvU0R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8dF3Iv7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8dF3Iv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D638CC116B1;
	Wed, 26 Jun 2024 21:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719436630;
	bh=xnBvbtkr+krg9eOnoyPvmkL0Vo7bx1Jml/6pqm7xWvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K8dF3Iv7f4Qe/n7OIonxeS5mjKUCftTEAvUy0DjScGUYSYdlGf+OXf5U3gCCg7UPx
	 +HxvfhS0f6XFiQq6hXlsABOlcrRU3Rv15Yxy9xyYBEtZFa4Daop7a7rvzZcpS9/o+s
	 myzv++ckeIllQ/TbyCrNX2zcjtMNpWEMkKHruOh4HdlBnInzj5k3HW2ALabIcKdpha
	 N3vgw95FCb4WoFpUw7/FOGC15Z2y7EpEpzs/azR4K9jbdB/3jwjQaIPR2CGFU0Ul7G
	 IK7M9sKia7RGX5E/3/llnPArGcIT/01jO7LQe7uFGTm70SVk0jcw7e7MM2eaQHKVys
	 OpM8yTWbaDmKg==
Date: Wed, 26 Jun 2024 14:17:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	akanksha@linux.ibm.com, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Disha Goel <disgoel@linux.vnet.ibm.com>
Subject: Re: [V4 05/16] tools/perf: Add disasm_line__parse to parse raw
 instruction for powerpc
Message-ID: <ZnyFVE22bcdilUyL@google.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
 <20240614172631.56803-6-atrajeev@linux.vnet.ibm.com>
 <ZnpYBvXLhyAqZzvh@google.com>
 <E2A1A4AA-E344-4B42-86CE-E0EDD82A398F@linux.vnet.ibm.com>
 <ZnsQOD3arkR0qoPJ@google.com>
 <40DB645D-BFA7-44EA-B937-ADE81EEC1316@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40DB645D-BFA7-44EA-B937-ADE81EEC1316@linux.vnet.ibm.com>

Hello,

On Wed, Jun 26, 2024 at 09:38:28AM +0530, Athira Rajeev wrote:
> 
> 
> > On 26 Jun 2024, at 12:15 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > On Tue, Jun 25, 2024 at 06:12:51PM +0530, Athira Rajeev wrote:
> >> 
> >> 
> >>> On 25 Jun 2024, at 11:09 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >>> 
> >>> On Fri, Jun 14, 2024 at 10:56:20PM +0530, Athira Rajeev wrote:
> >>>> Currently, the perf tool infrastructure disasm_line__parse function to
> >>>> parse disassembled line.
> >>>> 
> >>>> Example snippet from objdump:
> >>>> objdump  --start-address=<address> --stop-address=<address>  -d --no-show-raw-insn -C <vmlinux>
> >>>> 
> >>>> c0000000010224b4: lwz     r10,0(r9)
> >>>> 
> >>>> This line "lwz r10,0(r9)" is parsed to extract instruction name,
> >>>> registers names and offset. In powerpc, the approach for data type
> >>>> profiling uses raw instruction instead of result from objdump to identify
> >>>> the instruction category and extract the source/target registers.
> >>>> 
> >>>> Example: 38 01 81 e8     ld      r4,312(r1)
> >>>> 
> >>>> Here "38 01 81 e8" is the raw instruction representation. Add function
> >>>> "disasm_line__parse_powerpc" to handle parsing of raw instruction.
> >>>> Also update "struct disasm_line" to save the binary code/
> >>>> With the change, function captures:
> >>>> 
> >>>> line -> "38 01 81 e8     ld      r4,312(r1)"
> >>>> raw instruction "38 01 81 e8"
> >>>> 
> >>>> Raw instruction is used later to extract the reg/offset fields. Macros
> >>>> are added to extract opcode and register fields. "struct disasm_line"
> >>>> is updated to carry union of "bytes" and "raw_insn" of 32 bit to carry raw
> >>>> code (raw). Function "disasm_line__parse_powerpc fills the raw
> >>>> instruction hex value and can use macros to get opcode. There is no
> >>>> changes in existing code paths, which parses the disassembled code.
> >>>> The architecture using the instruction name and present approach is
> >>>> not altered. Since this approach targets powerpc, the macro
> >>>> implementation is added for powerpc as of now.
> >>>> 
> >>>> Since the disasm_line__parse is used in other cases (perf annotate) and
> >>>> not only data tye profiling, the powerpc callback includes changes to
> >>>> work with binary code as well as mneumonic representation. Also in case
> >>>> if the DSO read fails and libcapstone is not supported, the approach
> >>>> fallback to use objdump as option. Hence as option, patch has changes to
> >>>> ensure objdump option also works well.
> >>>> 
> >>>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >>>> ---
[SNIP]
> >>>> +/*
> >>>> + * Parses the result captured from symbol__disassemble_*
> >>>> + * Example, line read from DSO file in powerpc:
> >>>> + * line:    38 01 81 e8
> >>>> + * opcode: fetched from arch specific get_opcode_insn
> >>>> + * rawp_insn: e8810138
> >>>> + *
> >>>> + * rawp_insn is used later to extract the reg/offset fields
> >>>> + */
> >>>> +#define PPC_OP(op) (((op) >> 26) & 0x3F)
> >>>> +
> >>>> +static int disasm_line__parse_powerpc(struct disasm_line *dl)
> >>>> +{
> >>>> + char *line = dl->al.line;
> >>>> + const char **namep = &dl->ins.name;
> >>>> + char **rawp = &dl->ops.raw;
> >>>> + char tmp, *tmp_raw_insn, *name_raw_insn = skip_spaces(line);
> >>>> + char *name = skip_spaces(name_raw_insn + 11);
> >>>> + int objdump = 0;
> >>>> +
> >>>> + if (strlen(line) > 11)
> >>>> + objdump = 1;
> >>>> +
> >>>> + if (name_raw_insn[0] == '\0')
> >>>> + return -1;
> >>>> +
> >>>> + if (objdump) {
> >>>> + *rawp = name + 1;
> >>>> + while ((*rawp)[0] != '\0' && !isspace((*rawp)[0]))
> >>>> + ++*rawp;
> >>>> + tmp = (*rawp)[0];
> >>>> + (*rawp)[0] = '\0';
> >>>> +
> >>>> + *namep = strdup(name);
> >>>> + if (*namep == NULL)
> >>>> + return -1;
> >>>> +
> >>>> + (*rawp)[0] = tmp;
> >>>> + *rawp = strim(*rawp);
> >>>> + } else
> >>>> + *namep = "";
> > 
> > Then can you handle this logic under if (annotate_opts.show_raw_insn)
> > in disasm_line__parse() instead of adding a new function?
> > 
> > Thanks,
> > Namhyung
> 
> Hi Namhyung,
> 
> We discussed to have a per-arch disasm_line_parse() here:
> https://lore.kernel.org/all/CAM9d7ci1LDa7moT2qDr2qK+DTNLU6ZBkmROnbdozAjuQLQfNog@mail.gmail.com/#t
> 
> So I added it as a new function : disasm_line__parse_powerpc
> Since it is not used by other archs, we can go with having new function ?

Ok, I thought it'd be quite different from disasm_line__parse() but it
seems that it's mostly similar except for the raw insn.  So I think it's
better to add the logic to the generic disasm_line__parse().  Sorry for
the inconvenience.

Thanks,
Namhyung

> >>>> +
> >>>> + tmp_raw_insn = strdup(name_raw_insn);
> >>>> + tmp_raw_insn[11] = '\0';
> >>>> + remove_spaces(tmp_raw_insn);
> >>>> +
> >>>> + dl->raw.raw_insn = strtol(tmp_raw_insn, NULL, 16);
> >>>> + if (objdump)
> >>>> + dl->raw.raw_insn = be32_to_cpu(strtol(tmp_raw_insn, NULL, 16));
> >>> 
> >>> Hmm.. can you use a sscanf() instead?
> >>> 
> >>> sscanf(line, "%x %x %x %x", &dl->raw.bytes[0], &dl->raw.bytes[1], ...)
> >>> 
> >>> Thanks,
> >>> Namhyung
> >>> 
> >> Sure will address in V5
> >> 
> >> Thanks
> >> Athira
> >>>> +
> >>>> + return 0;
> >>>> +}
