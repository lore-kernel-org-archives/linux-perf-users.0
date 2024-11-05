Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7EFEAD2;
	Tue,  5 Nov 2024 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828455; cv=none; b=q1lk44mShoFigL9M6VFTjV4l+gJlUsmbGNU4LY9AlJ5NXfkww0mzDYertvNn7rr0BSIK/zXoc2MzPqUotd3xw2/v7vK66+IgnVh9Uo+/tyc5N1EfKVyqG0dG0QR9laxTRKLMLlSrfn7PelGfo2URl138ViSqTuUn3FEegUlBUUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828455; c=relaxed/simple;
	bh=tp38WzGOIsaq/18EaZQ+5yUjmXbzC6Iy1G/ZJK35JoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mt9xdvIKdCURlQjLQNaTzqDffNCwwF+Z3kCMijyn3K8kYQxw4GJezwiSXXpQgwCmpZaDANyuIQFrjyRZ4qm55189wd01sL5eWkUg8c48UtS6JMV7VRITN/84ZT1jUodc/hrRnb8CUcTVXbKxGpJxo3Z0L1f0fieyT/jcqdT8u+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F9FC4CECF;
	Tue,  5 Nov 2024 17:40:52 +0000 (UTC)
Date: Tue, 5 Nov 2024 12:40:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>,
 linux-trace-kernel@vger.kerne.org, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Florian Weimer
 <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241105124053.523e93dd@gandalf.local.home>
In-Reply-To: <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
	<42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 14:47:56 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 06dc4a57ba78..434c548f0837 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -47,6 +47,7 @@
>  #include <linux/dax.h>
>  #include <linux/uaccess.h>
>  #include <linux/rseq.h>
> +#include <linux/sframe.h>
>  #include <asm/param.h>
>  #include <asm/page.h>
>  
> @@ -633,11 +634,13 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>  		unsigned long no_base, struct elf_phdr *interp_elf_phdata,
>  		struct arch_elf_state *arch_state)
>  {
> -	struct elf_phdr *eppnt;
> +	struct elf_phdr *eppnt, *sframe_phdr = NULL;
>  	unsigned long load_addr = 0;
>  	int load_addr_set = 0;
>  	unsigned long error = ~0UL;
>  	unsigned long total_size;
> +	unsigned long start_code = ~0UL;
> +	unsigned long end_code = 0;
>  	int i;
>  
>  	/* First of all, some simple consistency checks */
> @@ -659,7 +662,8 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>  
>  	eppnt = interp_elf_phdata;
>  	for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
> -		if (eppnt->p_type == PT_LOAD) {
> +		switch (eppnt->p_type) {
> +		case PT_LOAD: {
>  			int elf_type = MAP_PRIVATE;
>  			int elf_prot = make_prot(eppnt->p_flags, arch_state,
>  						 true, true);
> @@ -688,7 +692,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>  			/*
>  			 * Check to see if the section's size will overflow the
>  			 * allowed task size. Note that p_filesz must always be
> -			 * <= p_memsize so it's only necessary to check p_memsz.
> +			 * <= p_memsz so it's only necessary to check p_memsz.
>  			 */
>  			k = load_addr + eppnt->p_vaddr;
>  			if (BAD_ADDR(k) ||
> @@ -698,9 +702,24 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>  				error = -ENOMEM;
>  				goto out;
>  			}
> +
> +			if ((eppnt->p_flags & PF_X) && k < start_code)
> +				start_code = k;
> +
> +			if ((eppnt->p_flags & PF_X) && k + eppnt->p_filesz > end_code)
> +				end_code = k + eppnt->p_filesz;
> +			break;
> +		}
> +		case PT_GNU_SFRAME:
> +			sframe_phdr = eppnt;
> +			break;
>  		}
>  	}
>  
> +	if (sframe_phdr)
> +		sframe_add_section(load_addr + sframe_phdr->p_vaddr,
> +				   start_code, end_code);
> +
>  	error = load_addr;
>  out:
>  	return error;
> @@ -823,7 +842,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	int first_pt_load = 1;
>  	unsigned long error;
>  	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
> -	struct elf_phdr *elf_property_phdata = NULL;
> +	struct elf_phdr *elf_property_phdata = NULL, *sframe_phdr = NULL;
>  	unsigned long elf_brk;
>  	int retval, i;
>  	unsigned long elf_entry;
> @@ -931,6 +950,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  				executable_stack = EXSTACK_DISABLE_X;
>  			break;
>  
> +		case PT_GNU_SFRAME:
> +			sframe_phdr = elf_ppnt;

You need to save the p_vaddr here and not the pointer.

> +			break;
> +
>  		case PT_LOPROC ... PT_HIPROC:
>  			retval = arch_elf_pt_proc(elf_ex, elf_ppnt,
>  						  bprm->file, false,
> @@ -1321,6 +1344,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  					    task_pid_nr(current), retval);
>  	}

Before this code we have:

	kfree(elf_phdata);

And I added:

	if (sframe_phdr)
		trace_printk("after sframe vaddr=%x\n", sframe_phdr->p_vaddr);
	kfree(elf_phdata);
	if (sframe_phdr)
		trace_printk("after sframe vaddr=%x\n", sframe_phdr->p_vaddr);

Which produced:

         scan-fs-940   [007] .....    16.091081: bprint:               load_elf_binary: after sframe vaddr=2298
         scan-fs-940   [007] .....    16.091083: bprint:               load_elf_binary: after sframe vaddr=0

I was wondering why it wasn't working.

-- Steve

>  
> +	if (sframe_phdr)
> +		sframe_add_section(load_bias + sframe_phdr->p_vaddr,
> +				   start_code, end_code);
> +
>  	regs = current_pt_regs();
>  #ifdef ELF_PLAT_INIT
>  	/*
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 381d22eba088..6e7561c1a5fc 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1052,6 +1052,9 @@ struct mm_struct {
>  #endif
>  		} lru_gen;
>  #endif /* CONFIG_LRU_GEN_WALKS_MMU */
> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> +		struct maple_tree sframe_mt;
> +#endif
>  	} __randomize_layout;
>  
>  	/*
