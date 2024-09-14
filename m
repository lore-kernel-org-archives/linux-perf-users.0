Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6D154BE0;
	Sat, 14 Sep 2024 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726313048; cv=none; b=HsFZNBdn6Jo0SDpPboV+toLnAYuA48aQJVTy5bNBfjxcKPIeoS0OPBC9KzxKLFuwR20jDCcnktwQjeqYTRB9vcYflbmztyRHG+esCIYcrENX8fpBH3Xf/IcpmBOBLgctc6sgParIz3d/6GxuVs8ZTi7blhWHyDEzcsSqluopajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726313048; c=relaxed/simple;
	bh=2WsiO8GTrDtNy4ePDeyJaB/CNfI7bB9SpVdj4brKP5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7EO/Xrg5HPigZ+aQXNtqZ9uaN6sWwlx7P76KksBNfhfTm3n9Y8l32Y4OC6wE+SgpOetl/QYjZlr/qtYCvoJFXvZgmvox13Ip1JdJqut8W8b6Mtjg1tXF5IaS1GgjngdLPzDX1XRJ7HqIh9AfX5B2+rJ8vzMSfNdHkZgB5tqzAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FA4C4CEC0;
	Sat, 14 Sep 2024 11:24:03 +0000 (UTC)
Date: Sat, 14 Sep 2024 07:23:58 -0400
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
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v2 03/11] unwind: Introduce SFrame user space unwinding
Message-ID: <20240914072358.4afad691@rorschach.local.home>
In-Reply-To: <ca2e603ae3dcfa3e836162ed8c301fd4d9fd4058.1726268190.git.jpoimboe@kernel.org>
References: <cover.1726268190.git.jpoimboe@kernel.org>
	<ca2e603ae3dcfa3e836162ed8c301fd4d9fd4058.1726268190.git.jpoimboe@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 01:02:05 +0200
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> diff --git a/include/linux/sframe.h b/include/linux/sframe.h
> new file mode 100644
> index 000000000000..3a44f76929e2
> --- /dev/null
> +++ b/include/linux/sframe.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_SFRAME_H
> +#define _LINUX_SFRAME_H
> +
> +#include <linux/mm_types.h>
> +
> +struct sframe_file {
> +	unsigned long sframe_addr, text_start, text_end;

Please make each entry a separate line:

	unsigned long		sframe_addr;
	unsigned long		text_start;
	unsigned long		text_end;

It may be fine for declaring variables like this in a function, but it
should not be done in a structure.

> +};
> +
> +struct user_unwind_frame;
> +
> +#ifdef CONFIG_HAVE_USER_UNWIND_SFRAME
> +
> +#define INIT_MM_SFRAME .sframe_mt = MTREE_INIT(sframe_mt, 0)
> +
> +extern void sframe_free_mm(struct mm_struct *mm);
> +
> +extern int __sframe_add_section(struct sframe_file *file);
> +extern int sframe_add_section(unsigned long sframe_addr, unsigned long text_start, unsigned long text_end);
> +extern int sframe_remove_section(unsigned long sframe_addr);
> +extern int sframe_find(unsigned long ip, struct user_unwind_frame *frame);
> +
> +static inline bool current_has_sframe(void)
> +{
> +	struct mm_struct *mm = current->mm;
> +
> +	return mm && !mtree_empty(&mm->sframe_mt);
> +}
> +
> +#else /* !CONFIG_HAVE_USER_UNWIND_SFRAME */
> +
> +#define INIT_MM_SFRAME
> +
> +static inline void sframe_free_mm(struct mm_struct *mm) {}
> +
> +static inline int __sframe_add_section(struct sframe_file *file) { return -EINVAL; }
> +static inline int sframe_add_section(unsigned long sframe_addr, unsigned long text_start, unsigned long text_end) { return -EINVAL; }
> +static inline int sframe_remove_section(unsigned long sframe_addr) { return -EINVAL; }
> +static inline int sframe_find(unsigned long ip, struct user_unwind_frame *frame) { return -EINVAL; }
> +
> +static inline bool current_has_sframe(void) { return false; }
> +
> +#endif /* CONFIG_HAVE_USER_UNWIND_SFRAME */
> +
> +#endif /* _LINUX_SFRAME_H */
> diff --git a/include/linux/user_unwind.h b/include/linux/user_unwind.h
> index 0a19ac6c92b2..8003f9d35405 100644
> --- a/include/linux/user_unwind.h
> +++ b/include/linux/user_unwind.h
> @@ -7,6 +7,7 @@
>  enum user_unwind_type {
>  	USER_UNWIND_TYPE_AUTO,
>  	USER_UNWIND_TYPE_FP,
> +	USER_UNWIND_TYPE_SFRAME,
>  };
>  
>  struct user_unwind_frame {
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index b54b313bcf07..b2aca31e1a49 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -39,6 +39,7 @@ typedef __s64	Elf64_Sxword;
>  #define PT_GNU_STACK	(PT_LOOS + 0x474e551)
>  #define PT_GNU_RELRO	(PT_LOOS + 0x474e552)
>  #define PT_GNU_PROPERTY	(PT_LOOS + 0x474e553)
> +#define PT_GNU_SFRAME	(PT_LOOS + 0x474e554)
>  
>  
>  /* ARM MTE memory tag segment type */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 35791791a879..69511077c910 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -328,4 +328,7 @@ struct prctl_mm_map {
>  # define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
>  # define PR_PPC_DEXCR_CTRL_MASK		0x1f
>  
> +#define PR_ADD_SFRAME			74
> +#define PR_REMOVE_SFRAME		75
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index cc760491f201..a216f091edfb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -104,6 +104,7 @@
>  #include <linux/rseq.h>
>  #include <uapi/linux/pidfd.h>
>  #include <linux/pidfs.h>
> +#include <linux/sframe.h>
>  
>  #include <asm/pgalloc.h>
>  #include <linux/uaccess.h>
> @@ -923,6 +924,7 @@ void __mmdrop(struct mm_struct *mm)
>  	mm_pasid_drop(mm);
>  	mm_destroy_cid(mm);
>  	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
> +	sframe_free_mm(mm);
>  
>  	free_mm(mm);
>  }
> @@ -1249,6 +1251,13 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
>  #endif
>  }
>  
> +static void mm_init_sframe(struct mm_struct *mm)
> +{
> +#ifdef CONFIG_HAVE_USER_UNWIND_SFRAME
> +	mt_init(&mm->sframe_mt);
> +#endif
> +}
> +
>  static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	struct user_namespace *user_ns)
>  {
> @@ -1280,6 +1289,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	mm->pmd_huge_pte = NULL;
>  #endif
>  	mm_init_uprobes_state(mm);
> +	mm_init_sframe(mm);
>  	hugetlb_count_init(mm);
>  
>  	if (current->mm) {
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 3a2df1bd9f64..e4d2b64f4ae4 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -64,6 +64,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/uidgid.h>
>  #include <linux/cred.h>
> +#include <linux/sframe.h>
>  
>  #include <linux/nospec.h>
>  
> @@ -2782,6 +2783,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
>  		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
>  		break;
> +	case PR_ADD_SFRAME:
> +		if (arg5)
> +			return -EINVAL;
> +		error = sframe_add_section(arg2, arg3, arg4);
> +		break;
> +	case PR_REMOVE_SFRAME:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = sframe_remove_section(arg2);
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;
> diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
> index eb466d6a3295..6f202c5840cf 100644
> --- a/kernel/unwind/Makefile
> +++ b/kernel/unwind/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_HAVE_USER_UNWIND) += user.o
> +obj-$(CONFIG_HAVE_USER_UNWIND_SFRAME) += sframe.o
> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> new file mode 100644
> index 000000000000..3e4d29e737a1
> --- /dev/null
> +++ b/kernel/unwind/sframe.c
> @@ -0,0 +1,420 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/srcu.h>
> +#include <linux/uaccess.h>
> +#include <linux/mm.h>
> +#include <linux/sframe.h>
> +#include <linux/user_unwind.h>
> +
> +#include "sframe.h"
> +
> +#define SFRAME_FILENAME_LEN 32
> +
> +struct sframe_section {
> +	struct rcu_head rcu;
> +
> +	unsigned long sframe_addr;
> +	unsigned long text_addr;
> +
> +	unsigned long fdes_addr;
> +	unsigned long fres_addr;
> +	unsigned int  fdes_nr;
> +	signed char ra_off, fp_off;
> +};
> +
> +DEFINE_STATIC_SRCU(sframe_srcu);
> +
> +#define __SFRAME_GET_USER(out, user_ptr, type)				\
> +({									\
> +	type __tmp;							\
> +	if (get_user(__tmp, (type *)user_ptr))				\
> +		return -EFAULT;						\
> +	user_ptr += sizeof(__tmp);					\
> +	out = __tmp;							\
> +})
> +
> +#define SFRAME_GET_USER_SIGNED(out, user_ptr, size)			\
> +({									\
> +	switch (size) {							\
> +	case 1:								\
> +		__SFRAME_GET_USER(out, user_ptr, s8);			\
> +		break;							\
> +	case 2:								\
> +		__SFRAME_GET_USER(out, user_ptr, s16);			\
> +		break;							\
> +	case 4:								\
> +		__SFRAME_GET_USER(out, user_ptr, s32);			\
> +		break;							\
> +	default:							\
> +		return -EINVAL;						\
> +	}								\
> +})
> +
> +#define SFRAME_GET_USER_UNSIGNED(out, user_ptr, size)			\
> +({									\
> +	switch (size) {							\
> +	case 1:								\
> +		__SFRAME_GET_USER(out, user_ptr, u8);			\
> +		break;							\
> +	case 2:								\
> +		__SFRAME_GET_USER(out, user_ptr, u16);			\
> +		break;							\
> +	case 4:								\
> +		__SFRAME_GET_USER(out, user_ptr, u32);			\
> +		break;							\
> +	default:							\
> +		return -EINVAL;						\
> +	}								\
> +})
> +
> +static unsigned char fre_type_to_size(unsigned char fre_type)
> +{
> +	if (fre_type > 2)
> +		return 0;
> +	return 1 << fre_type;
> +}
> +
> +static unsigned char offset_size_enum_to_size(unsigned char off_size)
> +{
> +	if (off_size > 2)
> +		return 0;
> +	return 1 << off_size;
> +}
> +
> +static int find_fde(struct sframe_section *sec, unsigned long ip,
> +		    struct sframe_fde *fde)
> +{
> +	s32 func_off, ip_off;
> +	struct sframe_fde __user *first, *last, *mid, *found;

Need to initialize found = NULL;

> +
> +	ip_off = ip - sec->sframe_addr;
> +
> +	first = (void *)sec->fdes_addr;
> +	last = first + sec->fdes_nr;
> +	while (first <= last) {

So we trust user space to have this table sorted?

> +		mid = first + ((last - first) / 2);
> +		if (get_user(func_off, (s32 *)mid))
> +			return -EFAULT;
> +		if (ip_off >= func_off) {
> +			found = mid;

If it's not sorted, this can return the wrong value.

We should have some check that has something like:

	s32 low_func_off = 0, high_func_off = 0;

			if (low_func_off && low_func_off > func_off)
				return -EINVAL;	
			low_func_off = func_off;

> +			first = mid + 1;
> +		} else
			{ /* Note, this needs a bracket anyway, because
			     rules are, if one if block has a bracket,
			     the other needs one too */

			if (high_func_off && high_func_off < func_off)
				return -EINVAL;

			high_func_off = func_off;

> +			last = mid - 1;
		}

> +	}
> +
> +	if (!found)
> +		return -EINVAL;
> +
> +	if (copy_from_user(fde, found, sizeof(*fde)))
> +		return -EFAULT;
> +
> +	return 0;
> +}

-- Steve
