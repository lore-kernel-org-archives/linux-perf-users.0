Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E471B806;
	Tue, 25 Jun 2024 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719295707; cv=none; b=l/TE4vgamPVgtxUEofSf40UIzDMLD3QPQpIswCskdTQo4wKoNs+hz3yWh9RC71WpsS19U75Re4R/BzpN1hF3mKcMSZVOQXKlZr9Ff+sBZepM6EpA9DvB+WQm5fNIsTp68lvcmZ+IV68FW/TNl0v2U8BKjSrBmhIWZrC/ZWiDnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719295707; c=relaxed/simple;
	bh=YheT6XJSWxvWrGdd5p4tPW/TvajXMH7U/RKaMngpCVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mbpc3aguIFb1EdOyT7ihII90jFE+t/VRLNWAHgE8//bvc74tqePvS7aX+eowhf92a2e+ZuqdS/L4Lerkgv/s4GV1I61DxzEB+UdJHwuaQnX0vjAGlr8i1JJYnOGpxwhgrqEjGnRbn3WgUFZqGwBDFZhZ84frqOThPjc86qkPAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsFFYSSc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsFFYSSc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4FAC32781;
	Tue, 25 Jun 2024 06:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719295706;
	bh=YheT6XJSWxvWrGdd5p4tPW/TvajXMH7U/RKaMngpCVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AsFFYSSciGejWlKLPd4AbBx3lCvglTbstX2jHmJvXGFivhXGcJYCY3RPuuCf+N4yb
	 T/KuXzTpZqiNZc74T/1uxVledlF7yjUeBhY5dSjJc62oHf8T8HsM1IuRgknTc8UPY6
	 YQoWIVysu4caN2Qp0otVDGZY5MU3lP0Wxk0qoVI8Q5yqnmHEGuOKXkB6aaMDpbaNJa
	 NFjR6X9HlWkYIPF0VjeC/NoOU7WM9J9M7gPAPYmiqVaTApB0cDa+/fmNhJ+UTuSSOD
	 BNQBrXPfMtHLk+aICWaV7AHEvD86PIPq4plDvYtq4N/9YD7ZBl9DxJzTP8ei9L5GLI
	 37en2YdMNKbQg==
Date: Mon, 24 Jun 2024 23:08:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, segher@kernel.crashing.org,
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [V4 13/16] tools/perf: Add support to use libcapstone in powerpc
Message-ID: <Znpe2BHCUXvfR5Bk@google.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
 <20240614172631.56803-14-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240614172631.56803-14-atrajeev@linux.vnet.ibm.com>

On Fri, Jun 14, 2024 at 10:56:28PM +0530, Athira Rajeev wrote:
> Now perf uses the capstone library to disassemble the instructions in
> x86. capstone is used (if available) for perf annotate to speed up.
> Currently it only supports x86 architecture. Patch includes changes to
> enable this in powerpc. For now, only for data type sort keys, this
> method is used and only binary code (raw instruction) is read. This is
> because powerpc approach to understand instructions and reg fields uses
> raw instruction. The "cs_disasm" is currently not enabled. While
> attempting to do cs_disasm, observation is that some of the instructions
> were not identified (ex: extswsli, maddld) and it had to fallback to use
> objdump. Hence enabling "cs_disasm" is added in comment section as a
> TODO for powerpc.

Well.. I'm not sure if I understand it correctly but it seems this
function effectively does nothing more than the raw disassemble.
Can we simply drop this patch for now?  Or did I miss something?

Thanks,
Namhyung

> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/disasm.c | 143 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 143 insertions(+)
> 
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 43743ca4bdc9..987bff9f71c3 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1592,6 +1592,144 @@ static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
>  	}
>  }
>  
> +static int symbol__disassemble_capstone_powerpc(char *filename, struct symbol *sym,
> +					struct annotate_args *args)
> +{
> +	struct annotation *notes = symbol__annotation(sym);
> +	struct map *map = args->ms.map;
> +	struct dso *dso = map__dso(map);
> +	struct nscookie nsc;
> +	u64 start = map__rip_2objdump(map, sym->start);
> +	u64 end = map__rip_2objdump(map, sym->end);
> +	u64 len = end - start;
> +	u64 offset;
> +	int i, fd, count;
> +	bool is_64bit = false;
> +	bool needs_cs_close = false;
> +	u8 *buf = NULL;
> +	struct find_file_offset_data data = {
> +		.ip = start,
> +	};
> +	csh handle;
> +	char disasm_buf[512];
> +	struct disasm_line *dl;
> +	u32 *line;
> +	bool disassembler_style = false;
> +
> +	if (args->options->objdump_path)
> +		return -1;
> +
> +	nsinfo__mountns_enter(dso->nsinfo, &nsc);
> +	fd = open(filename, O_RDONLY);
> +	nsinfo__mountns_exit(&nsc);
> +	if (fd < 0)
> +		return -1;
> +
> +	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
> +			    &is_64bit) == 0)
> +		goto err;
> +
> +	if (!args->options->disassembler_style ||
> +			!strcmp(args->options->disassembler_style, "att"))
> +		disassembler_style = true;
> +
> +	if (capstone_init(maps__machine(args->ms.maps), &handle, is_64bit, disassembler_style) < 0)
> +		goto err;
> +
> +	needs_cs_close = true;
> +
> +	buf = malloc(len);
> +	if (buf == NULL)
> +		goto err;
> +
> +	count = pread(fd, buf, len, data.offset);
> +	close(fd);
> +	fd = -1;
> +
> +	if ((u64)count != len)
> +		goto err;
> +
> +	line = (u32 *)buf;
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
> +	/*
> +	 * TODO: enable disassm for powerpc
> +	 * count = cs_disasm(handle, buf, len, start, len, &insn);
> +	 *
> +	 * For now, only binary code is saved in disassembled line
> +	 * to be used in "type" and "typeoff" sort keys. Each raw code
> +	 * is 32 bit instruction. So use "len/4" to get the number of
> +	 * entries.
> +	 */
> +	count = len/4;
> +
> +	for (i = 0, offset = 0; i < count; i++) {
> +		args->offset = offset;
> +		sprintf(args->line, "%x", line[i]);
> +
> +		dl = disasm_line__new(args);
> +		if (dl == NULL)
> +			goto err;
> +
> +		annotation_line__add(&dl->al, &notes->src->source);
> +
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
> +	if (needs_cs_close)
> +		cs_close(&handle);
> +	free(buf);
> +	return count < 0 ? count : 0;
> +
> +err:
> +	if (fd >= 0)
> +		close(fd);
> +	if (needs_cs_close) {
> +		struct disasm_line *tmp;
> +
> +		/*
> +		 * It probably failed in the middle of the above loop.
> +		 * Release any resources it might add.
> +		 */
> +		list_for_each_entry_safe(dl, tmp, &notes->src->source, al.node) {
> +			list_del(&dl->al.node);
> +			free(dl);
> +		}
> +	}
> +	count = -1;
> +	goto out;
> +}
> +
>  static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
>  					struct annotate_args *args)
>  {
> @@ -1949,6 +2087,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  			err = symbol__disassemble_dso(symfs_filename, sym, args);
>  			if (err == 0)
>  				goto out_remove_tmp;
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +			err = symbol__disassemble_capstone_powerpc(symfs_filename, sym, args);
> +			if (err == 0)
> +				goto out_remove_tmp;
> +#endif
>  		}
>  	}
>  
> -- 
> 2.43.0
> 
