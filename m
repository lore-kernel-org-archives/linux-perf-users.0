Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F410E3;
	Wed,  3 Jul 2024 01:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719970915; cv=none; b=NXIuG9Vntm3punule+s13e+/DCX29zbaWBmdOnd8EO31LnD1VkdyS7UMsXWGgrIsdgRmC8uda5WIdMx9GBDhxb0agSruijG/IE0scF5iD3qfiIvzTcFsU0dIochudfBBWkeTKul3IqR0mif7yADBem9OQmvwEifRo694iiBse2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719970915; c=relaxed/simple;
	bh=I3wgToB6YzUOnGJa+NGixSKtZcxSXXX+GVhEWbx+N8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFZ7gLRniToY8aG85e1Xe4N3GZQd3P4asYG1a6JAcVWgqLwuWHPkW4+L9gkcynv+ypEwxz0rb8H9t7uBavFzC/oBT/olMsp7HniGkfUXzM7WpkIIcww9SlzPOdK9NFWP8E1lIE69/loA16dwemC5WZM1TUB11oFU46wAfVz3V2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN2nycnY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN2nycnY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4A9C116B1;
	Wed,  3 Jul 2024 01:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719970914;
	bh=I3wgToB6YzUOnGJa+NGixSKtZcxSXXX+GVhEWbx+N8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SN2nycnYtaKr5S6AEH0cujt/AEXdQnhj7sUBwuPVH6j95h7jRUxx33sgANXEkBiXq
	 diKjRfeJUA+jtACQI3ej863L/JIohUTkqoI/pG2npfOgB2our0Q9bKOhluuYDSxOlr
	 RdlY4UO/yVIXPxEvhErxMj7vvqY+nIHds7Jch8QXB9ifSn1Si/KXMp6tRH2jZLgh+6
	 ROIb/etZlJN9LEjcddlT4Uuo76JA/VJOwvXLyVNplEsHLT17zO2lcGFYBE3EuCibcw
	 aXOHrCgEUePJwGzEbCeHQRvYqEV5qBEGCkgZ6GiX7YhNWS3y8o2/5FZwSG5cYKRNHy
	 4gx8gH+jOsmQQ==
Date: Tue, 2 Jul 2024 18:41:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, segher@kernel.crashing.org,
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH V5 15/17] tools/perf: Add support to find global register
 variables using find_data_type_global_reg
Message-ID: <ZoSsYEhrUKh747aA@google.com>
References: <20240701043430.66666-1-atrajeev@linux.vnet.ibm.com>
 <20240701043430.66666-16-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701043430.66666-16-atrajeev@linux.vnet.ibm.com>

On Mon, Jul 01, 2024 at 10:04:28AM +0530, Athira Rajeev wrote:
> There are cases where define a global register variable and associate it
> with a specified register. Example, in powerpc, two registers are
> defined to represent variable:
> 1. r13: represents local_paca
> register struct paca_struct *local_paca asm("r13");
> 
> 2. r1: represents stack_pointer
> register void *__stack_pointer asm("r1");
> 
> These regs are present in dwarf debug as DW_OP_reg as part of variables
> in the cu_die (compile unit). These are not present in die search done
> in the list of nested scopes since these are global register variables.
> 
> Example for local_paca represented by r13:
> 
> <<>>
>  <1><18dc6b4>: Abbrev Number: 128 (DW_TAG_variable)
>     <18dc6b6>   DW_AT_name        : (indirect string, offset: 0x3861): local_paca
>     <18dc6ba>   DW_AT_decl_file   : 48
>     <18dc6bb>   DW_AT_decl_line   : 36
>     <18dc6bc>   DW_AT_decl_column : 30
>     <18dc6bd>   DW_AT_type        : <0x18dc6c3>
>     <18dc6c1>   DW_AT_external    : 1
>     <18dc6c1>   DW_AT_location    : 1 byte block: 5d    (DW_OP_reg13 (r13))
> 
>  <1><18dc6c3>: Abbrev Number: 3 (DW_TAG_pointer_type)
>     <18dc6c4>   DW_AT_byte_size   : 8
>     <18dc6c4>   DW_AT_type        : <0x18dc353>
> 
> Where  DW_AT_type : <0x18dc6c3> further points to :
> 
>  <1><18dc6c3>: Abbrev Number: 3 (DW_TAG_pointer_type)
>     <18dc6c4>   DW_AT_byte_size   : 8
>     <18dc6c4>   DW_AT_type        : <0x18dc353>
> 
> which belongs to:
> 
>  <1><18dc353>: Abbrev Number: 67 (DW_TAG_structure_type)
>     <18dc354>   DW_AT_name        : (indirect string, offset: 0x56cd): paca_struct
>     <18dc358>   DW_AT_byte_size   : 2944
>     <18dc35a>   DW_AT_alignment   : 128
>     <18dc35b>   DW_AT_decl_file   : 48
>     <18dc35c>   DW_AT_decl_line   : 61
>     <18dc35d>   DW_AT_decl_column : 8
>     <18dc35d>   DW_AT_sibling     : <0x18dc6b4>
> <<>>
> 
> Similar is case with "r1".
> 
> <<>>
>  <1><18dd772>: Abbrev Number: 129 (DW_TAG_variable)
>     <18dd774>   DW_AT_name        : (indirect string, offset: 0x11ba): current_stack_pointer
>     <18dd778>   DW_AT_decl_file   : 51
>     <18dd779>   DW_AT_decl_line   : 1468
>     <18dd77b>   DW_AT_decl_column : 24
>     <18dd77c>   DW_AT_type        : <0x18da5cd>
>     <18dd780>   DW_AT_external    : 1
>     <18dd780>   DW_AT_location    : 1 byte block: 51    (DW_OP_reg1 (r1))
> 
>  where 18da5cd is:
> 
>  <1><18da5cd>: Abbrev Number: 47 (DW_TAG_base_type)
>     <18da5ce>   DW_AT_byte_size   : 8
>     <18da5cf>   DW_AT_encoding    : 7   (unsigned)
>     <18da5d0>   DW_AT_name        : (indirect string, offset: 0x55c7): long unsigned int
> <<>>
> 
> To identify data type for these two special cases, iterate over
> variables in the CU die (Compile Unit) and match it with the register.
> If the variable is a base type, ie die_get_real_type will return NULL
> here, set offset to zero. With the changes, data type for "paca_struct"
> and "long unsigned int" for r1 is identified.
> 
> Snippet from ./perf report -s type,type_off
> 
>     12.85%  long unsigned int  long unsigned int +0 (no field)
>      4.68%  struct paca_struct  struct paca_struct +2312 (__current)
>      4.57%  struct paca_struct  struct paca_struct +2354 (irq_soft_mask)
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/annotate-data.c      | 42 ++++++++++++++++++++++++++++
>  tools/perf/util/annotate.c           |  8 ++++++
>  tools/perf/util/annotate.h           |  1 +
>  tools/perf/util/include/dwarf-regs.h |  1 +
>  4 files changed, 52 insertions(+)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 721235e1e6cf..c919b2259f54 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1175,6 +1175,42 @@ static int find_data_type_block(struct data_loc_info *dloc,
>  	return ret;
>  }
>  
> +/*
> + * Handle cases where define a global register variable and
> + * associate it with a specified register. These regs are
> + * present in dwarf debug as DW_OP_reg as part of variables
> + * in the cu_die (compile unit). Iterate over variables in the
> + * cu_die and match with reg to identify data type die.
> + */
> +static int find_data_type_global_reg(struct data_loc_info *dloc, int reg, Dwarf_Die *cu_die,
> +		Dwarf_Die *type_die)
> +{
> +	Dwarf_Die vr_die;
> +	int ret = -1;
> +	struct die_var_type *var_types = NULL;
> +
> +	die_collect_vars(cu_die, &var_types);
> +	while (var_types) {
> +		if (var_types->reg == reg) {

Reduce the indent level by using for and continue.  Like

    for (vt = var_types ; vt != NULL; vt = vt->next) {
        if (vt->reg != reg)
	    continue;
	...
    }

> +			if (dwarf_offdie(dloc->di->dbg, var_types->die_off, &vr_die)) {
> +				if (die_get_real_type(&vr_die, type_die) == NULL) {
> +					dloc->type_offset = 0;
> +					dwarf_offdie(dloc->di->dbg, var_types->die_off, type_die);
> +				}
> +				pr_debug_type_name(type_die, TSR_KIND_TYPE);
> +				ret = 0;
> +				pr_debug_dtp("found by CU for %s (die:%#lx)\n",
> +						dwarf_diename(type_die), (long)dwarf_dieoffset(type_die));
> +			}
> +			break;
> +		}
> +		var_types = var_types->next;
> +	}
> +
> +	delete_var_types(var_types);

You should remember the start of var_types to free them properly.

Thanks,
Namhyung


> +	return ret;
> +}
> +
>  /* The result will be saved in @type_die */
>  static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  {
> @@ -1222,6 +1258,12 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  	pr_debug_dtp("CU for %s (die:%#lx)\n",
>  		     dwarf_diename(&cu_die), (long)dwarf_dieoffset(&cu_die));
>  
> +	if (loc->reg_type == DWARF_REG_GLOBAL) {
> +		ret = find_data_type_global_reg(dloc, reg, &cu_die, type_die);
> +		if (!ret)
> +			goto out;
> +	}
> +
>  	if (reg == DWARF_REG_PC) {
>  		if (get_global_var_type(&cu_die, dloc, dloc->ip, dloc->var_addr,
>  					&offset, type_die)) {
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index ce99db291c5e..8db2f32700aa 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2425,6 +2425,14 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
>  			op_loc->reg1 = DWARF_REG_PC;
>  		}
>  
> +		/* Global reg variable 13 and 1
> +		 * assign to DWARF_REG_GLOBAL
> +		 */
> +		if (arch__is(arch, "powerpc")) {
> +			if ((op_loc->reg1 == 13) || (op_loc->reg1 == 1))
> +				op_loc->reg_type = DWARF_REG_GLOBAL;
> +		}
> +
>  		mem_type = find_data_type(&dloc);
>  
>  		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 9ba772f46270..ad69842a8ebc 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -475,6 +475,7 @@ struct annotated_op_loc {
>  	bool mem_ref;
>  	bool multi_regs;
>  	bool imm;
> +	int reg_type;
>  };
>  
>  enum annotated_insn_ops {
> diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
> index 8fb987818b1a..fda7098c13e1 100644
> --- a/tools/perf/util/include/dwarf-regs.h
> +++ b/tools/perf/util/include/dwarf-regs.h
> @@ -5,6 +5,7 @@
>  
>  #define DWARF_REG_PC  0xd3af9c /* random number */
>  #define DWARF_REG_FB  0xd3affb /* random number */
> +#define DWARF_REG_GLOBAL 0xd3affc /* random number */
>  
>  #ifdef HAVE_DWARF_SUPPORT
>  const char *get_arch_regstr(unsigned int n);
> -- 
> 2.43.0
> 
