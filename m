Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4F7081D;
	Wed, 13 Nov 2024 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731536461; cv=none; b=KuDKEx7rMiEMTLZxswdGhvVziw46KjzGfADkizFBgyKt2QY6TyGws674Y4LmCSNMpmLCl43VJCYeePZrqbFqNQAAjN1/OiXDdN6vU0LvF0hNMHoqzhT3LRyVxdGecUOYIOroj0mIGUMTFy8LpVE40ft0vtVaJVEqVnmgiysGa68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731536461; c=relaxed/simple;
	bh=jaCgkVrjqdFRoXcmyT5u0vZq+LcNAv9DOc0Nl7LGbn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lg7CH3AkiFLqJo3tFon7jZaneULeoJhl/phjOc4nN/R/oZSmf4QI0MDkiAi2hDEuwgLkZIo6DfEvWxvSzIFUsK67ODFKTShgLJO4wxEW8W8gYdrxidv7gqiZ0Qj+NskuSh35MG69bwC63tknGpBL5BPIRkN8TEPm0DramOqlMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C89EC4CEC3;
	Wed, 13 Nov 2024 22:20:58 +0000 (UTC)
Date: Wed, 13 Nov 2024 17:21:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, Indu Bhagat
 <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Florian Weimer <fweimer@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241113172118.6db57c42@gandalf.local.home>
In-Reply-To: <20241113171326.6d1ddc83@gandalf.local.home>
References: <cover.1730150953.git.jpoimboe@kernel.org>
	<42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
	<1f83be89-b816-48a3-a7ee-9b72f07b558e@linux.ibm.com>
	<20241113155040.6a9a1bed@gandalf.local.home>
	<20241113211535.ghnw52wkgudkjvgv@jpoimboe>
	<20241113171326.6d1ddc83@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


[ This reply fixes the linux-trace-kernel email :-p ]

On Wed, 13 Nov 2024 17:13:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> BTW, the following changes were needed to make it work for me:
> 
> -- Steve
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 434c548f0837..64cc3c1188ca 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -842,7 +842,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	int first_pt_load = 1;
>  	unsigned long error;
>  	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
> -	struct elf_phdr *elf_property_phdata = NULL, *sframe_phdr = NULL;
> +	struct elf_phdr *elf_property_phdata = NULL;
> +	unsigned long sframe_vaddr = 0;

Could not just save the pointer to the sframe phd, as it gets freed before we need it.

>  	unsigned long elf_brk;
>  	int retval, i;
>  	unsigned long elf_entry;
> @@ -951,7 +952,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  			break;
>  
>  		case PT_GNU_SFRAME:
> -			sframe_phdr = elf_ppnt;
> +			sframe_vaddr = elf_ppnt->p_vaddr;
>  			break;
>  
>  		case PT_LOPROC ... PT_HIPROC:
> @@ -1344,8 +1345,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  					    task_pid_nr(current), retval);
>  	}
>  
> -	if (sframe_phdr)
> -		sframe_add_section(load_bias + sframe_phdr->p_vaddr,
> +	if (sframe_vaddr)
> +		sframe_add_section(load_bias + sframe_vaddr,
>  				   start_code, end_code);
>  
>  	regs = current_pt_regs();
> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 933e47696e29..ca4ef0b72772 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
> @@ -73,15 +73,15 @@ static int find_fde(struct sframe_section *sec, unsigned long ip,
>  		    struct sframe_fde *fde)
>  {
>  	struct sframe_fde __user *first, *last, *found = NULL;
> -	u32 ip_off, func_off_low = 0, func_off_high = -1;
> +	s32 ip_off, func_off_low = INT_MIN, func_off_high = INT_MAX;

The ip_off is a signed it. I wrote a program to dump out the sframe section
of files, and I had:

	ffffed88: (1020) size:      16 off:     146 num:       2 info: 1 rep:16
	ffffed98: (1030) size:     336 off:     154 num:       2 info:17 rep:16
	ffffefe1: (1279) size:     113 off:       0 num:       4 info: 0 rep: 0
	fffff052: (12ea) size:      54 off:      15 num:       3 info: 0 rep: 0
	fffff088: (1320) size:     167 off:      26 num:       3 info: 0 rep: 0
	fffff12f: (13c7) size:     167 off:      37 num:       4 info: 0 rep: 0
	fffff1d6: (146e) size:     167 off:      52 num:       4 info: 0 rep: 0
	fffff27d: (1515) size:      22 off:      67 num:       4 info: 0 rep: 0
	fffff293: (152b) size:     141 off:      82 num:       4 info: 0 rep: 0
	fffff320: (15b8) size:      81 off:      97 num:       4 info: 0 rep: 0
	fffff371: (1609) size:     671 off:     112 num:       4 info: 1 rep: 0
	fffff610: (18a8) size:     171 off:     131 num:       4 info: 0 rep: 0

The above turns was created by a loop of:

	fde = (void *)sframes + sizeof(*sframes) + sframes->sfh_fdeoff;
	for (s = 0; s < sframes->sfh_num_fdes; s++, fde++) {
		printf("\t%x: (%lx) size:%8u off:%8u num:%8u info:%2u rep:%2u\n",
		       fde->sfde_func_start_address,
		       fde->sfde_func_start_address + shdr->sh_offset,
		       fde->sfde_func_size,
		       fde->sfde_func_start_fre_off,
		       fde->sfde_func_num_fres,
		       fde->sfde_func_info,
		       fde->sfde_func_rep_size);
	}

As you can see, all the ip_off are negative.

>  
>  	ip_off = ip - sec->sframe_addr;
>  
>  	first = (void __user *)sec->fdes_addr;
> -	last = first + sec->fdes_nr;
> +	last = first + sec->fdes_nr - 1;

The above was mentioned before.

>  	while (first <= last) {
>  		struct sframe_fde __user *mid;
> -		u32 func_off;
> +		s32 func_off;
>  
>  		mid = first + ((last - first) / 2);
>  
> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> index 11aadfade005..d9cd820150c5 100644
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c
> @@ -97,7 +97,7 @@ int unwind_user_start(struct unwind_user_state *state)
>  
>  	if (current_has_sframe())
>  		state->type = UNWIND_USER_TYPE_SFRAME;
> -	else if (IS_ENABLED(CONFIG_UNWIND_USER_FP))
> +	else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))

This was mentioned too.

>  		state->type = UNWIND_USER_TYPE_FP;
>  	else
>  		state->type = UNWIND_USER_TYPE_NONE;
> @@ -138,7 +138,7 @@ int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries)
>  static u64 ctx_to_cookie(u64 cpu, u64 ctx)
>  {
>  	BUILD_BUG_ON(NR_CPUS > 65535);
> -	return (ctx & ((1UL << 48) - 1)) | cpu;
> +	return (ctx & ((1UL << 48) - 1)) | (cpu << 48);

And so was this.

-- Steve

>  }
>  
>  /*

