Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6252C184E;
	Wed,  3 Jul 2024 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719969853; cv=none; b=bSIR3eaapr1ClxZ97fFo3gm+9OA8NqArbYSopy2M1rWyaF73O9eRxt2HDhG5YXVcI8PJZmiZZvBkfkjS6X3XP0kM4KKI2YA62REazaDf0hKl1SowPlDc0E8ay3yi2/b1M3FGEcwBIsGeMl7yg+1ZHf4V+rUbVTkB076uKMi2VRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719969853; c=relaxed/simple;
	bh=aT1n/TcfiZA8fO3fOhhChEPt+/wXzY6RutDc7C3ik30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkXIxpl/g883mO/82d/bLLmdxqwErBOMWPXtrFCMgl3s0gwIj0JRFsmdUvxpIJz3RFXfXP3ckTK9y2A3aP2vev1FtHJgsD6EW+2y9RVWMhiQkbWxIOHQPybgpEGIwZ3mbnB4jZS9h4G83kZLV/hRZ6mEPSxIWoFpEo98Z2lZhYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzoRzgPJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzoRzgPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FA3C116B1;
	Wed,  3 Jul 2024 01:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719969853;
	bh=aT1n/TcfiZA8fO3fOhhChEPt+/wXzY6RutDc7C3ik30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzoRzgPJP89Yo11Kfu8CTFoy7kXV83DJdnsWfIud6ESrdQS1dRTgCfLOC8OWIO2o+
	 cilpDR/c0wAIDnqvMZzv67B85zGBFADy0GcdCS74CLdsUSPbs1e+hADrhaQE2qQ8ge
	 iqqrnaSqpkPWYxMijOq56ixNXp3DizI326GG45mWIzeaMslLY9Lt/tNv2KNltVNfq0
	 8OOk85kyha2sCWPjpvAiurS6KvzOIC8vOYPeWeSSekjzxMCT9ONE3ZNQAeheOXl67k
	 omghVROweaKJv473hLKvbNwI1Qe3qm26DMF2cOGaGTViAfZVbBY9KPTdowzR5hG/W3
	 kkb9JUi19lhWA==
Date: Tue, 2 Jul 2024 18:24:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, segher@kernel.crashing.org,
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH V5 05/17] tools/perf: Add support to capture and parse
 raw instruction in powerpc using dso__data_read_offset utility
Message-ID: <ZoSoO7IHKreTpkbt@google.com>
References: <20240701043430.66666-1-atrajeev@linux.vnet.ibm.com>
 <20240701043430.66666-6-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701043430.66666-6-atrajeev@linux.vnet.ibm.com>

On Mon, Jul 01, 2024 at 10:04:18AM +0530, Athira Rajeev wrote:
> Add support to capture and parse raw instruction in powerpc.
> Currently, the perf tool infrastructure uses two ways to disassemble
> and understand the instruction. One is objdump and other option is
> via libcapstone.
> 
> Currently, the perf tool infrastructure uses "--no-show-raw-insn" option
> with "objdump" while disassemble. Example from powerpc with this option
> for an instruction address is:
> 
> Snippet from:
> objdump  --start-address=<address> --stop-address=<address>  -d --no-show-raw-insn -C <vmlinux>
> 
> c0000000010224b4:	lwz     r10,0(r9)
> 
> This line "lwz r10,0(r9)" is parsed to extract instruction name,
> registers names and offset. Also to find whether there is a memory
> reference in the operands, "memory_ref_char" field of objdump is used.
> For x86, "(" is used as memory_ref_char to tackle instructions of the
> form "mov  (%rax), %rcx".
> 
> In case of powerpc, not all instructions using "(" are the only memory
> instructions. Example, above instruction can also be of extended form (X
> form) "lwzx r10,0,r19". Inorder to easy identify the instruction category
> and extract the source/target registers, patch adds support to use raw
> instruction for powerpc. Approach used is to read the raw instruction
> directly from the DSO file using "dso__data_read_offset" utility which
> is already implemented in perf infrastructure in "util/dso.c".
> 
> Example:
> 
> 38 01 81 e8     ld      r4,312(r1)
> 
> Here "38 01 81 e8" is the raw instruction representation. In powerpc,
> this translates to instruction form: "ld RT,DS(RA)" and binary code
> as:
> 
>    | 58 |  RT  |  RA |      DS       | |
>    -------------------------------------
>    0    6     11    16              30 31
> 
> Function "symbol__disassemble_dso" is updated to read raw instruction
> directly from DSO using dso__data_read_offset utility. In case of
> above example, this captures:
> line:    38 01 81 e8
> 
> The above works well when perf report is invoked with only sort keys for
> data type ie type and typeoff. Because there is no instruction level
> annotation needed if only data type information is requested for. For
> annotating sample, along with type and typeoff sort key, "sym" sort key
> is also needed. And by default invoking just "perf report" uses sort key
> "sym" that displays the symbol information.
> 
> With approach changes in powerpc which first reads DSO for raw
> instruction, "perf annotate" and "perf report" + a key breaks since
> it doesn't do the instruction level disassembly.
> 
> Snippet of result from perf report:
> 
> Samples: 1K of event 'mem-loads', 4000 Hz, Event count (approx.): 937238
> do_work  /usr/bin/pmlogger [Percent: local period]
> Percent│        ea230010
>        │        3a550010
>        │        3a600000
> 
>        │        38f60001
>        │        39490008
>        │        42400438
>  51.44 │        81290008
>        │        7d485378
> 
> Here, raw instruction is displayed in the output instead of human
> readable annotated form.
> 
> One way to get the appropriate data is to specify "--objdump path", by
> which code annotation will be done. But the default behaviour will be
> changed. To fix this breakage, check if "sym" sort key is set. If so
> fallback and use the libcapstone/objdump way of disassmbling the sample.
> 
> With the changes and "perf report"
> 
> Samples: 1K of event 'mem-loads', 4000 Hz, Event count (approx.): 937238
> do_work  /usr/bin/pmlogger [Percent: local period]
> Percent│        ld        r17,16(r3)
>        │        addi      r18,r21,16
>        │        li        r19,0
> 
>        │ 8b0:   rldicl    r10,r10,63,33
>        │        addi      r10,r10,1
>        │        mtctr     r10
>        │      ↓ b         8e4
>        │ 8c0:   addi      r7,r22,1
>        │        addi      r10,r9,8
>        │      ↓ bdz       d00
>  51.44 │        lwz       r9,8(r9)
>        │        mr        r8,r10
>        │        cmpw      r20,r9
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/disasm.c | 101 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index ddb861a0b043..e400dcab4029 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -25,6 +25,7 @@
>  #include "srcline.h"
>  #include "symbol.h"
>  #include "util.h"
> +#include "sort.h"
>  
>  static regex_t	 file_lineno;
>  
> @@ -1645,6 +1646,91 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
>  }
>  #endif
>  
> +static int symbol__disassemble_dso(char *filename, struct symbol *sym,

Again, I still think this should be named to symbol__disassemble_raw()
because it only uses the raw binary codes.  Using dso__data_read_offset
is not important here and it's just a way of implementing it.

Thanks,
Namhyung


> +					struct annotate_args *args)
> +{
> +	struct annotation *notes = symbol__annotation(sym);
> +	struct map *map = args->ms.map;
> +	struct dso *dso = map__dso(map);
> +	u64 start = map__rip_2objdump(map, sym->start);
> +	u64 end = map__rip_2objdump(map, sym->end);
> +	u64 len = end - start;
> +	u64 offset;
> +	int i, count;
> +	u8 *buf = NULL;
> +	char disasm_buf[512];
> +	struct disasm_line *dl;
> +	u32 *line;
> +
> +	/* Return if objdump is specified explicitly */
> +	if (args->options->objdump_path)
> +		return -1;
> +
> +	pr_debug("Reading raw instruction from : %s using dso__data_read_offset\n", filename);
> +
> +	buf = malloc(len);
> +	if (buf == NULL)
> +		goto err;
> +
> +	count = dso__data_read_offset(dso, NULL, sym->start, buf, len);
> +
> +	line = (u32 *)buf;
> +
> +	if ((u64)count != len)
> +		goto err;
> +
> +	/* add the function address and name */
> +	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
> +		  start, sym->name);
> +
> +	args->offset = -1;
> +	args->line = disasm_buf;
> +	args->line_nr = 0;
> +	args->fileloc = NULL;
> +	args->ms.sym = sym;
> +
> +	dl = disasm_line__new(args);
> +	if (dl == NULL)
> +		goto err;
> +
> +	annotation_line__add(&dl->al, &notes->src->source);
> +
> +	/* Each raw instruction is 4 byte */
> +	count = len/4;
> +
> +	for (i = 0, offset = 0; i < count; i++) {
> +		args->offset = offset;
> +		sprintf(args->line, "%x", line[i]);
> +		dl = disasm_line__new(args);
> +		if (dl == NULL)
> +			goto err;
> +
> +		annotation_line__add(&dl->al, &notes->src->source);
> +		offset += 4;
> +	}
> +
> +	/* It failed in the middle */
> +	if (offset != len) {
> +		struct list_head *list = &notes->src->source;
> +
> +		/* Discard all lines and fallback to objdump */
> +		while (!list_empty(list)) {
> +			dl = list_first_entry(list, struct disasm_line, al.node);
> +
> +			list_del_init(&dl->al.node);
> +			disasm_line__free(dl);
> +		}
> +		count = -1;
> +	}
> +
> +out:
> +	free(buf);
> +	return count < 0 ? count : 0;
> +
> +err:
> +	count = -1;
> +	goto out;
> +}
>  /*
>   * Possibly create a new version of line with tabs expanded. Returns the
>   * existing or new line, storage is updated if a new line is allocated. If
> @@ -1769,6 +1855,21 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  		strcpy(symfs_filename, tmp);
>  	}
>  
> +	/*
> +	 * For powerpc data type profiling, use the dso__data_read_offset
> +	 * to read raw instruction directly and interpret the binary code
> +	 * to understand instructions and register fields. For sort keys as
> +	 * type and typeoff, disassemble to mnemonic notation is
> +	 * not required in case of powerpc.
> +	 */
> +	if (arch__is(args->arch, "powerpc")) {
> +		if (sort_order && !strstr(sort_order, "sym")) {
> +			err = symbol__disassemble_dso(symfs_filename, sym, args);
> +			if (err == 0)
> +				goto out_remove_tmp;
> +		}
> +	}
> +
>  #ifdef HAVE_LIBCAPSTONE_SUPPORT
>  	err = symbol__disassemble_capstone(symfs_filename, sym, args);
>  	if (err == 0)
> -- 
> 2.43.0
> 
