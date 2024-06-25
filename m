Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBD333C0;
	Tue, 25 Jun 2024 05:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292551; cv=none; b=IIgmNrT5e1czqrv4ck0MjOeAT22YVbeVFqlvtRbwCcCjCGn2F86WSM4X5kFI6GnE6WPS85fp3esXnIZWks8IUfOsL6fK45Exf3Rx2nGn1i7LntzwrivO1ZWwhN9y2eLomasHLSUyXwbfVa3xwD9/KhQMu9ppguA0zs8znnuDzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292551; c=relaxed/simple;
	bh=OsYRJd0mzx38fP7IO/+BLKZK+fyo5KZ7vxvkr6QdFYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3Rsshhs8P72bhlmRoDQTmPocWB8lmYY1MZur6np4OJTBZSZIHsgDS/Vqf0qOMpAaj8n0LKTnntC+wgn2jsGqEPQgGjkfZcCVhfR5NmZo1Hz6OP+eh/MRodjK4SuY1V1hdf2URRhms/W7uZGIhq6o4RVzKD50ygGuyomOHQ5f/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyJ7bffH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyJ7bffH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972B7C32782;
	Tue, 25 Jun 2024 05:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719292551;
	bh=OsYRJd0mzx38fP7IO/+BLKZK+fyo5KZ7vxvkr6QdFYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SyJ7bffHFjF0pg7enO0XmALW6yes20XyqJ5tG/IAr8Fo091xIFVqhX5RYFm56xXj3
	 OF0Ed4lAIw5jHYSMkJ177gcGQzt0xGLhR9OGUAHp0EnDBkUQcMqMVrLbc1k50qhkeB
	 3VrEW+hOFOq8KzswEdXWGWaqeA59OZOcWYCjQIP3JPtMktRv5D6DF3rmTDAhniKG53
	 +M6T7AWvrZGApb7YCDGght9Q4+6o+GtPlYnercTYnq6NmqCTtQU5mfhunhXvxo1dBW
	 lvQLIT5ANbfV5hj0XRjPAxL9qFNAtKomb0M0F2w8TkajwbLYcwa6mfyI2519rV2smS
	 hK0fB1F1xnIpQ==
Date: Mon, 24 Jun 2024 22:15:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, segher@kernel.crashing.org,
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [V4 01/16] tools/perf: Move the data structures related to
 register type to header file
Message-ID: <ZnpShR7zd9cVdxSj@google.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
 <20240614172631.56803-2-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240614172631.56803-2-atrajeev@linux.vnet.ibm.com>

Hello,

On Fri, Jun 14, 2024 at 10:56:16PM +0530, Athira Rajeev wrote:
> Data type profiling uses instruction tracking by checking each
> instruction and updating the register type state in some data
> structures. This is useful to find the data type in cases when the
> register state gets transferred from one reg to another. Example, in
> x86, "mov" instruction and in powerpc, "mr" instruction. Currently these
> structures are defined in annotate-data.c and instruction tracking is
> implemented only for x86. Move these data structures to
> "annotate-data.h" header file so that other arch implementations can use
> it in arch specific files as well.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/annotate-data.c | 53 +------------------------------
>  tools/perf/util/annotate-data.h | 55 +++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 52 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 965da6c0b542..a4c7f98a75e3 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -31,15 +31,6 @@
>  
>  static void delete_var_types(struct die_var_type *var_types);
>  
> -enum type_state_kind {
> -	TSR_KIND_INVALID = 0,
> -	TSR_KIND_TYPE,
> -	TSR_KIND_PERCPU_BASE,
> -	TSR_KIND_CONST,
> -	TSR_KIND_POINTER,
> -	TSR_KIND_CANARY,
> -};
> -
>  #define pr_debug_dtp(fmt, ...)					\
>  do {								\
>  	if (debug_type_profile)					\
> @@ -140,49 +131,7 @@ static void pr_debug_location(Dwarf_Die *die, u64 pc, int reg)
>  	}
>  }
>  
> -/*
> - * Type information in a register, valid when @ok is true.
> - * The @caller_saved registers are invalidated after a function call.
> - */
> -struct type_state_reg {
> -	Dwarf_Die type;
> -	u32 imm_value;
> -	bool ok;
> -	bool caller_saved;
> -	u8 kind;
> -};
> -
> -/* Type information in a stack location, dynamically allocated */
> -struct type_state_stack {
> -	struct list_head list;
> -	Dwarf_Die type;
> -	int offset;
> -	int size;
> -	bool compound;
> -	u8 kind;
> -};
> -
> -/* FIXME: This should be arch-dependent */
> -#define TYPE_STATE_MAX_REGS  16
> -
> -/*
> - * State table to maintain type info in each register and stack location.
> - * It'll be updated when new variable is allocated or type info is moved
> - * to a new location (register or stack).  As it'd be used with the
> - * shortest path of basic blocks, it only maintains a single table.
> - */
> -struct type_state {
> -	/* state of general purpose registers */
> -	struct type_state_reg regs[TYPE_STATE_MAX_REGS];
> -	/* state of stack location */
> -	struct list_head stack_vars;
> -	/* return value register */
> -	int ret_reg;
> -	/* stack pointer register */
> -	int stack_reg;
> -};
> -
> -static bool has_reg_type(struct type_state *state, int reg)
> +bool has_reg_type(struct type_state *state, int reg)
>  {
>  	return (unsigned)reg < ARRAY_SIZE(state->regs);
>  }
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index 0a57d9f5ee78..ef235b1b15e1 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -6,6 +6,9 @@
>  #include <linux/compiler.h>
>  #include <linux/rbtree.h>
>  #include <linux/types.h>
> +#include "dwarf-aux.h"
> +#include "annotate.h"
> +#include "debuginfo.h"
>  
>  struct annotated_op_loc;
>  struct debuginfo;
> @@ -15,6 +18,15 @@ struct hist_entry;
>  struct map_symbol;
>  struct thread;
>  
> +enum type_state_kind {
> +	TSR_KIND_INVALID = 0,
> +	TSR_KIND_TYPE,
> +	TSR_KIND_PERCPU_BASE,
> +	TSR_KIND_CONST,
> +	TSR_KIND_POINTER,
> +	TSR_KIND_CANARY,
> +};
> +
>  /**
>   * struct annotated_member - Type of member field
>   * @node: List entry in the parent list
> @@ -142,6 +154,48 @@ struct annotated_data_stat {
>  };
>  extern struct annotated_data_stat ann_data_stat;
>  
> +/*
> + * Type information in a register, valid when @ok is true.
> + * The @caller_saved registers are invalidated after a function call.
> + */
> +struct type_state_reg {
> +	Dwarf_Die type;
> +	u32 imm_value;
> +	bool ok;
> +	bool caller_saved;
> +	u8 kind;
> +};
> +
> +/* Type information in a stack location, dynamically allocated */
> +struct type_state_stack {
> +	struct list_head list;
> +	Dwarf_Die type;
> +	int offset;
> +	int size;
> +	bool compound;
> +	u8 kind;
> +};
> +
> +/* FIXME: This should be arch-dependent */
> +#define TYPE_STATE_MAX_REGS  32

Can you please define this for powerpc separately?  I think x86 should
remain in 16.

Thanks,
Namhyung

> +
> +/*
> + * State table to maintain type info in each register and stack location.
> + * It'll be updated when new variable is allocated or type info is moved
> + * to a new location (register or stack).  As it'd be used with the
> + * shortest path of basic blocks, it only maintains a single table.
> + */
> +struct type_state {
> +	/* state of general purpose registers */
> +	struct type_state_reg regs[TYPE_STATE_MAX_REGS];
> +	/* state of stack location */
> +	struct list_head stack_vars;
> +	/* return value register */
> +	int ret_reg;
> +	/* stack pointer register */
> +	int stack_reg;
> +};
> +
>  #ifdef HAVE_DWARF_SUPPORT
>  
>  /* Returns data type at the location (ip, reg, offset) */
> @@ -160,6 +214,7 @@ void global_var_type__tree_delete(struct rb_root *root);
>  
>  int hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel);
>  
> +bool has_reg_type(struct type_state *state, int reg);
>  #else /* HAVE_DWARF_SUPPORT */
>  
>  static inline struct annotated_data_type *
> -- 
> 2.43.0
> 
