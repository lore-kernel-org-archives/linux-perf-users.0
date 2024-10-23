Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8A159583;
	Wed, 23 Oct 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692035; cv=none; b=QkSffGglMyaukwGv6W3sIibRglv4scQg49aOevkM9Px41bMXL/fi2X/NqJBi/TM4p12glHvIK1hp4OHA//KCviEy/H99Y6o1uMCaxm+NEQLB5g/oUfNrUvcGaR80TO6xbGIfbH++LSigqMYshRpD8eIzfUAgVi+uulI9DeOVqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692035; c=relaxed/simple;
	bh=+vJahf9DuO/Bz2KGPv9G5JkgYCWns7+KVxe4BARkWNE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jdLs40f+56RLn66L1xAUV4x6MmIQGxONMwiNbyIa2mrl1BKdzw2/rxcAxxFY5pkmh2BQmtNUKeVeugBLp+sIVXfijYF/JhN3TXAu0vE/oauyL7CQoQ0N9uzT1ZTMDTt/7V0cU0Jj+PEk8HaCf+gJjVTx735US9tkE5Q+NzeXFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eVgC6p1f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eVgC6p1f"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NDUh68014736;
	Wed, 23 Oct 2024 14:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mHBXYH
	4PBQbqt5YhQkm6dQ6z/sFv09YFyCOj1CPp+t4=; b=eVgC6p1fR02wkEMNpkpiYz
	ZbqG9hisltku1B7NeAjxmAmGOolz15yxFQq5jhH4q9LBUCEb0ABwITZVGcjn8Akb
	RfjBuRR2AghZqy/QC2mY7WFsLZLq4Py6y0e8YxE9D7E8MtPXR3xR+PDZ6HAm/7J/
	8EciFcbe/cM0KQ+GLhRXRLyruOl4B9njVfIaS33VZE536ZwPk7WnIxxemKFxUX/H
	4bNOx8x7M5+LASHXl0VgplZN2FrJx1ZDAYiAfIz07hx6RYl6Lv/qVWBj65tEq49/
	99HDg2TibpveHMqNWn9Nm/QXuwkZ0iLhKO6XF7kMJf6S42ftfsNMEHhGu+DBxu1g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaductp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 14:00:03 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49NE027Z021469;
	Wed, 23 Oct 2024 14:00:02 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaductb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 14:00:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBaY51012594;
	Wed, 23 Oct 2024 14:00:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emhfb5d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 14:00:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NDxvA153150116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:59:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73E8E2004E;
	Wed, 23 Oct 2024 13:59:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B62122004B;
	Wed, 23 Oct 2024 13:59:54 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 13:59:54 +0000 (GMT)
Message-ID: <c967505c-fbdc-4a46-a5b6-d164fe79e2e3@linux.ibm.com>
Date: Wed, 23 Oct 2024 15:59:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] unwind: Introduce SFrame user space unwinding
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
        Sam James <sam@gentoo.org>, x86@kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <ca2e603ae3dcfa3e836162ed8c301fd4d9fd4058.1726268190.git.jpoimboe@kernel.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <ca2e603ae3dcfa3e836162ed8c301fd4d9fd4058.1726268190.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CKaFb1HcVREZwIUEvrHfDjS46eDD1s3K
X-Proofpoint-GUID: 8I8BTx4c9dThG_TLUseMHoVlS9B_B2cy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230082

Hello Josh!

On 14.09.2024 01:02, Josh Poimboeuf wrote:
> Some distros have started compiling frame pointers into all their
> packages to enable the kernel to do system-wide profiling of user space.
> Unfortunately that creates a runtime performance penalty across the
> entire system.  Using DWARF instead isn't feasible due to the complexity
> it would add to the kernel.
> 
> For in-kernel unwinding we solved this problem with the creation of the
> ORC unwinder for x86_64.  Similarly, for user space the GNU assembler
> has created the SFrame format starting with binutils 2.41 for SFrame v2.
> SFrame is a simpler version of .eh_frame which gets placed in the
> .sframe section.
> 
> Add support for unwinding user space using SFrame.
> 
> More information about SFrame can be found here:
> 
>    - https://lwn.net/Articles/932209/
>    - https://lwn.net/Articles/940686/
>    - https://sourceware.org/binutils/docs/sframe-spec.html
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/Kconfig                |   3 +
>   fs/binfmt_elf.c             |  47 +++-
>   include/linux/mm_types.h    |   3 +
>   include/linux/sframe.h      |  46 ++++
>   include/linux/user_unwind.h |   1 +
>   include/uapi/linux/elf.h    |   1 +
>   include/uapi/linux/prctl.h  |   3 +
>   kernel/fork.c               |  10 +
>   kernel/sys.c                |  11 +
>   kernel/unwind/Makefile      |   1 +
>   kernel/unwind/sframe.c      | 420 ++++++++++++++++++++++++++++++++++++
>   kernel/unwind/sframe.h      | 215 ++++++++++++++++++
>   kernel/unwind/user.c        |  14 ++
>   mm/init-mm.c                |   4 +-
>   14 files changed, 774 insertions(+), 5 deletions(-)
>   create mode 100644 include/linux/sframe.h
>   create mode 100644 kernel/unwind/sframe.c
>   create mode 100644 kernel/unwind/sframe.h
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index b1002b2da331..ff5d5bc5f947 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -428,6 +428,9 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
>   config HAVE_USER_UNWIND
>   	bool
>   
> +config HAVE_USER_UNWIND_SFRAME
> +	bool

I found this unwinder of userspace using SFrame to depend on your 
generic unwinder of userspace framework. Does this warrant to add:

	depends on HAVE_USER_UNWIND

> +
>   config HAVE_PERF_REGS
>   	bool
>   	help
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 19fa49cd9907..923aed390f2e 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -47,6 +47,7 @@
>   #include <linux/dax.h>
>   #include <linux/uaccess.h>
>   #include <linux/rseq.h>
> +#include <linux/sframe.h>
>   #include <asm/param.h>
>   #include <asm/page.h>
>   
> @@ -633,11 +634,13 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>   		unsigned long no_base, struct elf_phdr *interp_elf_phdata,
>   		struct arch_elf_state *arch_state)
>   {
> -	struct elf_phdr *eppnt;
> +	struct elf_phdr *eppnt, *sframe_phdr = NULL;
>   	unsigned long load_addr = 0;
>   	int load_addr_set = 0;
>   	unsigned long error = ~0UL;
>   	unsigned long total_size;
> +	unsigned long start_code = ~0UL;
> +	unsigned long end_code = 0;
>   	int i;
>   
>   	/* First of all, some simple consistency checks */
> @@ -659,7 +662,8 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>   
>   	eppnt = interp_elf_phdata;
>   	for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
> -		if (eppnt->p_type == PT_LOAD) {
> +		switch (eppnt->p_type) {
> +		case PT_LOAD: {
>   			int elf_type = MAP_PRIVATE;
>   			int elf_prot = make_prot(eppnt->p_flags, arch_state,
>   						 true, true);
> @@ -688,7 +692,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>   			/*
>   			 * Check to see if the section's size will overflow the
>   			 * allowed task size. Note that p_filesz must always be
> -			 * <= p_memsize so it's only necessary to check p_memsz.
> +			 * <= p_memsz so it's only necessary to check p_memsz.
>   			 */
>   			k = load_addr + eppnt->p_vaddr;
>   			if (BAD_ADDR(k) ||
> @@ -698,7 +702,28 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>   				error = -ENOMEM;
>   				goto out;
>   			}
> +
> +			if ((eppnt->p_flags & PF_X) && k < start_code)
> +				start_code = k;
> +
> +			if ((eppnt->p_flags & PF_X) && k + eppnt->p_filesz > end_code)
> +				end_code = k + eppnt->p_filesz;
> +			break;
>   		}
> +		case PT_GNU_SFRAME:
> +			sframe_phdr = eppnt;
> +			break;
> +		}
> +	}
> +
> +	if (sframe_phdr) {
> +		struct sframe_file sfile = {
> +			.sframe_addr	= load_addr + sframe_phdr->p_vaddr,
> +			.text_start	= start_code,
> +			.text_end	= end_code,
> +		};
> +
> +		__sframe_add_section(&sfile);
>   	}
>   
>   	error = load_addr;
> @@ -823,7 +848,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>   	int first_pt_load = 1;
>   	unsigned long error;
>   	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
> -	struct elf_phdr *elf_property_phdata = NULL;
> +	struct elf_phdr *elf_property_phdata = NULL, *sframe_phdr = NULL;
>   	unsigned long elf_brk;
>   	int retval, i;
>   	unsigned long elf_entry;
> @@ -931,6 +956,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
>   				executable_stack = EXSTACK_DISABLE_X;
>   			break;
>   
> +		case PT_GNU_SFRAME:
> +			sframe_phdr = elf_ppnt;
> +			break;
> +
>   		case PT_LOPROC ... PT_HIPROC:
>   			retval = arch_elf_pt_proc(elf_ex, elf_ppnt,
>   						  bprm->file, false,
> @@ -1316,6 +1345,16 @@ static int load_elf_binary(struct linux_binprm *bprm)
>   				MAP_FIXED | MAP_PRIVATE, 0);
>   	}
>   
> +	if (sframe_phdr) {
> +		struct sframe_file sfile = {
> +			.sframe_addr	= load_bias + sframe_phdr->p_vaddr,
> +			.text_start	= start_code,
> +			.text_end	= end_code,
> +		};
> +
> +		__sframe_add_section(&sfile);
> +	}
> +
>   	regs = current_pt_regs();
>   #ifdef ELF_PLAT_INIT
>   	/*
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 485424979254..1aee78cbea33 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1019,6 +1019,9 @@ struct mm_struct {
>   #endif
>   		} lru_gen;
>   #endif /* CONFIG_LRU_GEN_WALKS_MMU */
> +#ifdef CONFIG_HAVE_USER_UNWIND_SFRAME
> +		struct maple_tree sframe_mt;
> +#endif
>   	} __randomize_layout;
>   
>   	/*
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
>   enum user_unwind_type {
>   	USER_UNWIND_TYPE_AUTO,
>   	USER_UNWIND_TYPE_FP,
> +	USER_UNWIND_TYPE_SFRAME,
>   };
>   
>   struct user_unwind_frame {
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index b54b313bcf07..b2aca31e1a49 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -39,6 +39,7 @@ typedef __s64	Elf64_Sxword;
>   #define PT_GNU_STACK	(PT_LOOS + 0x474e551)
>   #define PT_GNU_RELRO	(PT_LOOS + 0x474e552)
>   #define PT_GNU_PROPERTY	(PT_LOOS + 0x474e553)
> +#define PT_GNU_SFRAME	(PT_LOOS + 0x474e554)
>   
>   
>   /* ARM MTE memory tag segment type */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 35791791a879..69511077c910 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -328,4 +328,7 @@ struct prctl_mm_map {
>   # define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
>   # define PR_PPC_DEXCR_CTRL_MASK		0x1f
>   
> +#define PR_ADD_SFRAME			74
> +#define PR_REMOVE_SFRAME		75
> +
>   #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index cc760491f201..a216f091edfb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -104,6 +104,7 @@
>   #include <linux/rseq.h>
>   #include <uapi/linux/pidfd.h>
>   #include <linux/pidfs.h>
> +#include <linux/sframe.h>
>   
>   #include <asm/pgalloc.h>
>   #include <linux/uaccess.h>
> @@ -923,6 +924,7 @@ void __mmdrop(struct mm_struct *mm)
>   	mm_pasid_drop(mm);
>   	mm_destroy_cid(mm);
>   	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
> +	sframe_free_mm(mm);
>   
>   	free_mm(mm);
>   }
> @@ -1249,6 +1251,13 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
>   #endif
>   }
>   
> +static void mm_init_sframe(struct mm_struct *mm)
> +{
> +#ifdef CONFIG_HAVE_USER_UNWIND_SFRAME
> +	mt_init(&mm->sframe_mt);
> +#endif
> +}
> +
>   static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>   	struct user_namespace *user_ns)
>   {
> @@ -1280,6 +1289,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>   	mm->pmd_huge_pte = NULL;
>   #endif
>   	mm_init_uprobes_state(mm);
> +	mm_init_sframe(mm);
>   	hugetlb_count_init(mm);
>   
>   	if (current->mm) {
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 3a2df1bd9f64..e4d2b64f4ae4 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -64,6 +64,7 @@
>   #include <linux/rcupdate.h>
>   #include <linux/uidgid.h>
>   #include <linux/cred.h>
> +#include <linux/sframe.h>
>   
>   #include <linux/nospec.h>
>   
> @@ -2782,6 +2783,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>   	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
>   		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
>   		break;
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
>   	default:
>   		error = -EINVAL;
>   		break;
> diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
> index eb466d6a3295..6f202c5840cf 100644
> --- a/kernel/unwind/Makefile
> +++ b/kernel/unwind/Makefile
> @@ -1 +1,2 @@
>   obj-$(CONFIG_HAVE_USER_UNWIND) += user.o
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
> +
> +	ip_off = ip - sec->sframe_addr;
> +
> +	first = (void *)sec->fdes_addr;
> +	last = first + sec->fdes_nr;
> +	while (first <= last) {
> +		mid = first + ((last - first) / 2);
> +		if (get_user(func_off, (s32 *)mid))
> +			return -EFAULT;
> +		if (ip_off >= func_off) {
> +			found = mid;
> +			first = mid + 1;
> +		} else
> +			last = mid - 1;
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
> +
> +static int find_fre(struct sframe_section *sec, struct sframe_fde *fde,
> +		    unsigned long ip, struct user_unwind_frame *frame)
> +{
> +	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
> +	unsigned char fre_type = SFRAME_FUNC_FRE_TYPE(fde->info);
> +	s32 fre_ip_off, cfa_off, ra_off, fp_off, ip_off;

Doesn't fre_ip_off need to be u32 (see also below)? The SFrame format 
specification states the FRE sfre_start_address is either u8, u16, or u32:
https://sourceware.org/binutils/docs/sframe-spec.html#The-SFrame-FRE-Types

> +	unsigned char offset_count, offset_size;
> +	unsigned char addr_size;
> +	void __user *f, *last_f;
> +	u8 fre_info;
> +	int i;
> +
> +	addr_size = fre_type_to_size(fre_type);
> +	if (!addr_size)
> +		return -EINVAL;
> +
> +	ip_off = ip - sec->sframe_addr - fde->start_addr;
> +
> +	f = (void *)sec->fres_addr + fde->fres_off;
> +
> +	for (i = 0; i < fde->fres_num; i++) {
> +
> +		SFRAME_GET_USER_UNSIGNED(fre_ip_off, f, addr_size);

You already use SFRAME_GET_USER_UNSIGNED() to read it.

> +
> +		if (fde_type == SFRAME_FDE_TYPE_PCINC) {
> +			if (fre_ip_off > ip_off)
> +				break;
> +		} else {
> +			/* SFRAME_FDE_TYPE_PCMASK */
> +			if (ip_off % fde->rep_size < fre_ip_off)
> +				break;
> +		}
> +
> +		SFRAME_GET_USER_UNSIGNED(fre_info, f, 1);
> +
> +		offset_count = SFRAME_FRE_OFFSET_COUNT(fre_info);
> +		offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(fre_info));
> +
> +		if (!offset_count || !offset_size)
> +			return -EINVAL;
> +
> +		last_f = f;
> +		f += offset_count * offset_size;
> +	}
> +
> +	if (!last_f)
> +		return -EINVAL;
> +
> +	f = last_f;
> +
> +	SFRAME_GET_USER_UNSIGNED(cfa_off, f, offset_size);

As far as I know the CFA offset from CFA base register is signed in the 
SFrame file format. See Binutils include/sframe-api.h, 
sframe_fre_get_cfa_offset(). Therefore use SFRAME_GET_USER_SIGNED(). 
Both cfa_off and struct user_unwind_frame cfa_off are already defined as 
s32.

> +	offset_count--;
> +
> +	ra_off = sec->ra_off;
> +	if (!ra_off) {

On s390 there is no fixed RA offset from CFA ...

> +		if (!offset_count--)
> +			return -EINVAL;

... and the RA must not neccessarily be saved (e.g. at function entry). 
But we can address this when sending patches for s390 support.

> +		SFRAME_GET_USER_SIGNED(ra_off, f, offset_size);
> +	}
> +
> +	fp_off = sec->fp_off;
> +	if (!fp_off && offset_count) {
> +		offset_count--;
> +		SFRAME_GET_USER_SIGNED(fp_off, f, offset_size);
> +	}
> +
> +	if (offset_count)
> +		return -EINVAL;
> +
> +	frame->cfa_off = cfa_off;
> +	frame->ra_off = ra_off;
> +	frame->fp_off = fp_off;
> +	frame->use_fp = SFRAME_FRE_CFA_BASE_REG_ID(fre_info) == SFRAME_BASE_REG_FP;
> +
> +	return 0;
> +}
> +
> +int sframe_find(unsigned long ip, struct user_unwind_frame *frame)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct sframe_section *sec;
> +	struct sframe_fde fde;
> +	int srcu_idx;
> +	int ret = -EINVAL;
> +
> +	srcu_idx = srcu_read_lock(&sframe_srcu);
> +
> +	sec = mtree_load(&mm->sframe_mt, ip);
> +	if (!sec) {
> +		srcu_read_unlock(&sframe_srcu, srcu_idx);
> +		return -EINVAL;
> +	}
> +
> +
> +	ret = find_fde(sec, ip, &fde);
> +	if (ret)
> +		goto err_unlock;
> +
> +	ret = find_fre(sec, &fde, ip, frame);
> +	if (ret)
> +		goto err_unlock;
> +
> +	srcu_read_unlock(&sframe_srcu, srcu_idx);
> +	return 0;
> +
> +err_unlock:
> +	srcu_read_unlock(&sframe_srcu, srcu_idx);
> +	return ret;
> +}
> +
> +static int get_sframe_file(unsigned long sframe_addr, struct sframe_file *file)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *sframe_vma, *text_vma, *vma;
> +	VMA_ITERATOR(vmi, mm, 0);
> +
> +	mmap_read_lock(mm);
> +
> +	sframe_vma = vma_lookup(mm, sframe_addr);
> +	if (!sframe_vma || !sframe_vma->vm_file)
> +		goto err_unlock;
> +
> +	text_vma = NULL;
> +
> +	for_each_vma(vmi, vma) {
> +		if (vma->vm_file != sframe_vma->vm_file)
> +			continue;
> +		if (vma->vm_flags & VM_EXEC) {
> +			if (text_vma) {
> +				/*
> +				 * Multiple EXEC segments in a single file
> +				 * aren't currently supported, is that a thing?
> +				 */
> +				mmap_read_unlock(mm);
> +				pr_warn_once("unsupported multiple EXEC segments in task %s[%d]\n",
> +					     current->comm, current->pid);
> +				return -EINVAL;
> +			}
> +			text_vma = vma;
> +		}
> +	}
> +
> +	file->sframe_addr	= sframe_addr;
> +	file->text_start	= text_vma->vm_start;
> +	file->text_end		= text_vma->vm_end;
> +
> +	mmap_read_unlock(mm);
> +	return 0;
> +
> +err_unlock:
> +	mmap_read_unlock(mm);
> +	return -EINVAL;
> +}
> +
> +static int validate_sframe_addrs(struct sframe_file *file)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *text_vma;
> +
> +	mmap_read_lock(mm);
> +
> +	if (!vma_lookup(mm, file->sframe_addr))
> +		goto err_unlock;
> +
> +	text_vma = vma_lookup(mm, file->text_start);
> +	if (!(text_vma->vm_flags & VM_EXEC))
> +		goto err_unlock;
> +
> +	if (vma_lookup(mm, file->text_end-1) != text_vma)
> +		goto err_unlock;
> +
> +	mmap_read_unlock(mm);
> +	return 0;
> +
> +err_unlock:
> +	mmap_read_unlock(mm);
> +	return -EINVAL;
> +}
> +
> +int __sframe_add_section(struct sframe_file *file)
> +{
> +	struct maple_tree *sframe_mt = &current->mm->sframe_mt;
> +	struct sframe_section *sec;
> +	struct sframe_header shdr;
> +	unsigned long header_end;
> +	int ret;
> +
> +	if (copy_from_user(&shdr, (void *)file->sframe_addr, sizeof(shdr)))
> +		return -EFAULT;
> +
> +	if (shdr.preamble.magic != SFRAME_MAGIC ||
> +	    shdr.preamble.version != SFRAME_VERSION_2 ||
> +	    !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
> +	    shdr.auxhdr_len || !shdr.num_fdes || !shdr.num_fres ||
> +	    shdr.fdes_off > shdr.fres_off) {
> +		/*
> +		 * Either binutils < 2.41, corrupt sframe header, or
> +		 * unsupported feature.
> +		 * */
> +		pr_warn_once("bad sframe header in task %s[%d]\n",
> +			     current->comm, current->pid);
> +		return -EINVAL;
> +	}
> +
> +	header_end = file->sframe_addr + SFRAME_HDR_SIZE(shdr);
> +
> +	sec = kmalloc(sizeof(*sec), GFP_KERNEL);
> +	if (!sec)
> +		return -ENOMEM;
> +
> +	sec->sframe_addr	= file->sframe_addr;
> +	sec->text_addr		= file->text_start;
> +	sec->fdes_addr		= header_end + shdr.fdes_off;
> +	sec->fres_addr		= header_end + shdr.fres_off;
> +	sec->fdes_nr		= shdr.num_fdes;
> +	sec->ra_off		= shdr.cfa_fixed_ra_offset;
> +	sec->fp_off		= shdr.cfa_fixed_fp_offset;
> +
> +	ret = mtree_insert_range(sframe_mt, file->text_start, file->text_end,
> +				 sec, GFP_KERNEL);
> +	if (ret) {
> +		kfree(sec);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int sframe_add_section(unsigned long sframe_addr, unsigned long text_start, unsigned long text_end)
> +{
> +	struct sframe_file file;
> +	int ret;
> +
> +	if (!text_start || !text_end) {
> +		ret = get_sframe_file(sframe_addr, &file);
> +		if (ret)
> +			return ret;
> +	} else {
> +		/*
> +		 * This is mainly for generated code, for which the text isn't
> +		 * file-backed so the user has to give the text bounds.
> +		 */
> +		file.sframe_addr	= sframe_addr;
> +		file.text_start		= text_start;
> +		file.text_end		= text_end;
> +		ret = validate_sframe_addrs(&file);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return __sframe_add_section(&file);
> +}
> +
> +static void sframe_free_rcu(struct rcu_head *rcu)
> +{
> +	struct sframe_section *sec = container_of(rcu, struct sframe_section, rcu);
> +
> +	kfree(sec);
> +}
> +
> +static int __sframe_remove_section(struct mm_struct *mm,
> +				   struct sframe_section *sec)
> +{
> +	struct sframe_section *s;
> +
> +	s = mtree_erase(&mm->sframe_mt, sec->text_addr);
> +	if (!s || WARN_ON_ONCE(s != sec))
> +		return -EINVAL;
> +
> +	call_srcu(&sframe_srcu, &sec->rcu, sframe_free_rcu);
> +
> +	return 0;
> +}
> +
> +int sframe_remove_section(unsigned long sframe_addr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct sframe_section *sec;
> +	unsigned long index = 0;
> +
> +	sec = mtree_load(&mm->sframe_mt, sframe_addr);
> +	if (!sec)
> +		return -EINVAL;
> +
> +	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
> +		if (sec->sframe_addr == sframe_addr)
> +			return __sframe_remove_section(mm, sec);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +void sframe_free_mm(struct mm_struct *mm)
> +{
> +	struct sframe_section *sec;
> +	unsigned long index = 0;
> +
> +	if (!mm)
> +		return;
> +
> +	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX)
> +		kfree(sec);
> +
> +	mtree_destroy(&mm->sframe_mt);
> +}
> diff --git a/kernel/unwind/sframe.h b/kernel/unwind/sframe.h
> new file mode 100644
> index 000000000000..aa468d6f1f4a
> --- /dev/null
> +++ b/kernel/unwind/sframe.h
> @@ -0,0 +1,215 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2023, Oracle and/or its affiliates.
> + *
> + * This file contains definitions for the SFrame stack tracing format, which is
> + * documented at https://sourceware.org/binutils/docs
> + */
> +#ifndef _SFRAME_H
> +#define _SFRAME_H
> +
> +#include <linux/types.h>
> +
> +#define SFRAME_VERSION_1	1
> +#define SFRAME_VERSION_2	2
> +#define SFRAME_MAGIC		0xdee2
> +
> +/* Function Descriptor Entries are sorted on PC. */
> +#define SFRAME_F_FDE_SORTED	0x1
> +/* Frame-pointer based stack tracing. Defined, but not set. */
> +#define SFRAME_F_FRAME_POINTER	0x2
> +
> +#define SFRAME_CFA_FIXED_FP_INVALID 0
> +#define SFRAME_CFA_FIXED_RA_INVALID 0
> +
> +/* Supported ABIs/Arch. */
> +#define SFRAME_ABI_AARCH64_ENDIAN_BIG	    1 /* AARCH64 big endian. */
> +#define SFRAME_ABI_AARCH64_ENDIAN_LITTLE    2 /* AARCH64 little endian. */
> +#define SFRAME_ABI_AMD64_ENDIAN_LITTLE	    3 /* AMD64 little endian. */
> +
> +/* SFrame FRE types. */
> +#define SFRAME_FRE_TYPE_ADDR1	0
> +#define SFRAME_FRE_TYPE_ADDR2	1
> +#define SFRAME_FRE_TYPE_ADDR4	2
> +
> +/*
> + * SFrame Function Descriptor Entry types.
> + *
> + * The SFrame format has two possible representations for functions. The
> + * choice of which type to use is made according to the instruction patterns
> + * in the relevant program stub.
> + */
> +
> +/* Unwinders perform a (PC >= FRE_START_ADDR) to look up a matching FRE. */
> +#define SFRAME_FDE_TYPE_PCINC	0
> +/*
> + * Unwinders perform a (PC & FRE_START_ADDR_AS_MASK >= FRE_START_ADDR_AS_MASK)
> + * to look up a matching FRE. Typical usecases are pltN entries, trampolines
> + * etc.
> + */
> +#define SFRAME_FDE_TYPE_PCMASK	1
> +
> +/**
> + * struct sframe_preamble - SFrame Preamble.
> + * @magic: Magic number (SFRAME_MAGIC).
> + * @version: Format version number (SFRAME_VERSION).
> + * @flags: Various flags.
> + */
> +struct sframe_preamble {
> +	u16 magic;
> +	u8  version;
> +	u8  flags;
> +} __packed;
> +
> +/**
> + * struct sframe_header - SFrame Header.
> + * @preamble: SFrame preamble.
> + * @abi_arch: Identify the arch (including endianness) and ABI.
> + * @cfa_fixed_fp_offset: Offset for the Frame Pointer (FP) from CFA may be
> + *	  fixed  for some ABIs ((e.g, in AMD64 when -fno-omit-frame-pointer is

Nit: Two consecutive spaces in "fixed  for".

> + *	  used). When fixed, this field specifies the fixed stack frame offset
> + *	  and the individual FREs do not need to track it. When not fixed, it
> + *	  is set to SFRAME_CFA_FIXED_FP_INVALID, and the individual FREs may
> + *	  provide the applicable stack frame offset, if any.
> + * @cfa_fixed_ra_offset: Offset for the Return Address from CFA is fixed for
> + *	  some ABIs. When fixed, this field specifies the fixed stack frame
> + *	  offset and the individual FREs do not need to track it. When not
> + *	  fixed, it is set to SFRAME_CFA_FIXED_FP_INVALID.
> + * @auxhdr_len: Number of bytes making up the auxiliary header, if any.
> + *	  Some ABI/arch, in the future, may use this space for extending the
> + *	  information in SFrame header. Auxiliary header is contained in bytes
> + *	  sequentially following the sframe_header.
> + * @num_fdes: Number of SFrame FDEs in this SFrame section.
> + * @num_fres: Number of SFrame Frame Row Entries.
> + * @fre_len:  Number of bytes in the SFrame Frame Row Entry section.
> + * @fdes_off: Offset of SFrame Function Descriptor Entry section.
> + * @fres_off: Offset of SFrame Frame Row Entry section.
> + */
> +struct sframe_header {
> +	struct sframe_preamble preamble;
> +	u8  abi_arch;
> +	s8  cfa_fixed_fp_offset;
> +	s8  cfa_fixed_ra_offset;
> +	u8  auxhdr_len;
> +	u32 num_fdes;
> +	u32 num_fres;
> +	u32 fre_len;
> +	u32 fdes_off;
> +	u32 fres_off;
> +} __packed;
> +
> +#define SFRAME_HDR_SIZE(sframe_hdr)	\
> +	((sizeof(struct sframe_header) + (sframe_hdr).auxhdr_len))
> +
> +/* Two possible keys for executable (instruction) pointers signing. */
> +#define SFRAME_AARCH64_PAUTH_KEY_A    0 /* Key A. */
> +#define SFRAME_AARCH64_PAUTH_KEY_B    1 /* Key B. */
> +
> +/**
> + * struct sframe_fde - SFrame Function Descriptor Entry.
> + * @start_addr: Function start address. Encoded as a signed offset,
> + *	  relative to the current FDE.
> + * @size: Size of the function in bytes.
> + * @fres_off: Offset of the first SFrame Frame Row Entry of the function,
> + *	  relative to the beginning of the SFrame Frame Row Entry sub-section.
> + * @fres_num: Number of frame row entries for the function.
> + * @info: Additional information for deciphering the stack trace
> + *	  information for the function. Contains information about SFrame FRE
> + *	  type, SFrame FDE type, PAC authorization A/B key, etc.
> + * @rep_size: Block size for SFRAME_FDE_TYPE_PCMASK
> + * @padding: Unused
> + */
> +struct sframe_fde {
> +	s32 start_addr;
> +	u32 size;
> +	u32 fres_off;
> +	u32 fres_num;
> +	u8  info;
> +	u8  rep_size;
> +	u16 padding;
> +} __packed;
> +
> +/*
> + * 'func_info' in SFrame FDE contains additional information for deciphering
> + * the stack trace information for the function. In V1, the information is
> + * organized as follows:
> + *   - 4-bits: Identify the FRE type used for the function.
> + *   - 1-bit: Identify the FDE type of the function - mask or inc.
> + *   - 1-bit: PAC authorization A/B key (aarch64).
> + *   - 2-bits: Unused.
> + * ---------------------------------------------------------------------
> + * |  Unused  |  PAC auth A/B key (aarch64) |  FDE type |   FRE type   |
> + * |          |        Unused (amd64)       |           |              |
> + * ---------------------------------------------------------------------
> + * 8          6                             5           4              0
> + */
> +
> +/* Note: Set PAC auth key to SFRAME_AARCH64_PAUTH_KEY_A by default.  */
> +#define SFRAME_FUNC_INFO(fde_type, fre_enc_type) \
> +	(((SFRAME_AARCH64_PAUTH_KEY_A & 0x1) << 5) | \
> +	 (((fde_type) & 0x1) << 4) | ((fre_enc_type) & 0xf))
> +
> +#define SFRAME_FUNC_FRE_TYPE(data)	  ((data) & 0xf)
> +#define SFRAME_FUNC_FDE_TYPE(data)	  (((data) >> 4) & 0x1)
> +#define SFRAME_FUNC_PAUTH_KEY(data)	  (((data) >> 5) & 0x1)
> +
> +/*
> + * Size of stack frame offsets in an SFrame Frame Row Entry. A single
> + * SFrame FRE has all offsets of the same size. Offset size may vary
> + * across frame row entries.
> + */
> +#define SFRAME_FRE_OFFSET_1B	  0
> +#define SFRAME_FRE_OFFSET_2B	  1
> +#define SFRAME_FRE_OFFSET_4B	  2
> +
> +/* An SFrame Frame Row Entry can be SP or FP based.  */
> +#define SFRAME_BASE_REG_FP	0
> +#define SFRAME_BASE_REG_SP	1
> +
> +/*
> + * The index at which a specific offset is presented in the variable length
> + * bytes of an FRE.
> + */
> +#define SFRAME_FRE_CFA_OFFSET_IDX   0
> +/*
> + * The RA stack offset, if present, will always be at index 1 in the variable
> + * length bytes of the FRE.
> + */
> +#define SFRAME_FRE_RA_OFFSET_IDX    1
> +/*
> + * The FP stack offset may appear at offset 1 or 2, depending on the ABI as RA
> + * may or may not be tracked.
> + */
> +#define SFRAME_FRE_FP_OFFSET_IDX    2
> +
> +/*
> + * 'fre_info' in SFrame FRE contains information about:
> + *   - 1 bit: base reg for CFA
> + *   - 4 bits: Number of offsets (N). A value of up to 3 is allowed to track
> + *   all three of CFA, FP and RA (fixed implicit order).
> + *   - 2 bits: information about size of the offsets (S) in bytes.
> + *     Valid values are SFRAME_FRE_OFFSET_1B, SFRAME_FRE_OFFSET_2B,
> + *     SFRAME_FRE_OFFSET_4B
> + *   - 1 bit: Mangled RA state bit (aarch64 only).
> + * ---------------------------------------------------------------
> + * | Mangled-RA (aarch64) |  Size of   |   Number of  | base_reg |
> + * |  Unused (amd64)      |  offsets   |    offsets   |          |
> + * ---------------------------------------------------------------
> + * 8                      7             5             1          0
> + */
> +
> +/* Note: Set mangled_ra_p to zero by default. */
> +#define SFRAME_FRE_INFO(base_reg_id, offset_num, offset_size) \
> +	(((0 & 0x1) << 7) | (((offset_size) & 0x3) << 5) | \
> +	 (((offset_num) & 0xf) << 1) | ((base_reg_id) & 0x1))
> +
> +/* Set the mangled_ra_p bit as indicated. */
> +#define SFRAME_FRE_INFO_UPDATE_MANGLED_RA_P(mangled_ra_p, fre_info) \
> +	((((mangled_ra_p) & 0x1) << 7) | ((fre_info) & 0x7f))
> +
> +#define SFRAME_FRE_CFA_BASE_REG_ID(data)	  ((data) & 0x1)
> +#define SFRAME_FRE_OFFSET_COUNT(data)		  (((data) >> 1) & 0xf)
> +#define SFRAME_FRE_OFFSET_SIZE(data)		  (((data) >> 5) & 0x3)
> +#define SFRAME_FRE_MANGLED_RA_P(data)		  (((data) >> 7) & 0x1)
> +
> +#endif /* _SFRAME_H */
> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> index 5d16f9604a61..3a7b14cf522b 100644
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c
> @@ -8,6 +8,7 @@
>   #include <linux/sched.h>
>   #include <linux/sched/task_stack.h>
>   #include <linux/user_unwind.h>
> +#include <linux/sframe.h>
>   #include <linux/uaccess.h>
>   #include <asm/user_unwind.h>
>   
> @@ -29,6 +30,11 @@ int user_unwind_next(struct user_unwind_state *state)
>   	case USER_UNWIND_TYPE_FP:
>   		frame = &fp_frame;
>   		break;
> +	case USER_UNWIND_TYPE_SFRAME:
> +		ret = sframe_find(state->ip, frame);
> +		if (ret)
> +			goto the_end;
> +		break;
>   	default:
>   		BUG();
>   	}
> @@ -57,6 +63,7 @@ int user_unwind_start(struct user_unwind_state *state,
>   		      enum user_unwind_type type)
>   {
>   	struct pt_regs *regs = task_pt_regs(current);
> +	bool sframe_possible = current_has_sframe();
>   
>   	memset(state, 0, sizeof(*state));
>   
> @@ -67,6 +74,13 @@ int user_unwind_start(struct user_unwind_state *state,
>   
>   	switch (type) {
>   	case USER_UNWIND_TYPE_AUTO:
> +		state->type = sframe_possible ? USER_UNWIND_TYPE_SFRAME :
> +						USER_UNWIND_TYPE_FP;
> +		break;
> +	case USER_UNWIND_TYPE_SFRAME:
> +		if (!sframe_possible)
> +			return -EINVAL;
> +		break;
>   	case USER_UNWIND_TYPE_FP:
>   		break;
>   	default:
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index 24c809379274..c4c6af046778 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -11,6 +11,7 @@
>   #include <linux/atomic.h>
>   #include <linux/user_namespace.h>
>   #include <linux/iommu.h>
> +#include <linux/sframe.h>
>   #include <asm/mmu.h>
>   
>   #ifndef INIT_MM_CONTEXT
> @@ -44,7 +45,8 @@ struct mm_struct init_mm = {
>   #endif
>   	.user_ns	= &init_user_ns,
>   	.cpu_bitmap	= CPU_BITS_NONE,
> -	INIT_MM_CONTEXT(init_mm)
> +	INIT_MM_CONTEXT(init_mm),
> +	INIT_MM_SFRAME,

This does not compile on s390, as INIT_MM_CONTEXT() is defined with a 
trailing comma, leading to two consecutive commas. Already reported by 
the kernel test robot for other architectures.
Same if INIT_MM_SFRAME expands into nothing there would be two 
consecutive commas.

>   };
>   
>   void setup_initial_init_mm(void *start_code, void *end_code,

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303) and z/VSE Support
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des 
Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der 
Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

