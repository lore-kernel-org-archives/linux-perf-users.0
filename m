Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEEF20C00A;
	Tue, 29 Oct 2024 23:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244777; cv=none; b=ElkneU5u+bYTq9ub7bJz/d78HMZ33P53TGPT+u50VA1bkH+FybDq4PVSy0s4pxOE6V55AJD9OhWxifoubDqQlfqcZdFLm8171LCpOSKtCIKLKqSf3aB9MG46rPvQsm9BU2nu1SIADkRXso7tUkOJKC1Z4iCXhXV6nmxApEMnXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244777; c=relaxed/simple;
	bh=PH58iDodTTubnkEujlIaUFS7AbT7jcag+SlgzrD26AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbTKv3+ht7Msx2HwVlc8Wdyf/jxcYUkl8E/QX0XsoxT2nPzrZB9kEQVmiBg8KKFAV3dCnDp7xWoI7lKUEDs+HbztVVBYYQOtC3ma4f+69gEJZzY1XEwF3jkb7EHTNlklf3y/RqS/fnls4AZYy0uvQhJq2SOcmjYpo/LhtYGZJ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMqYZUtQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMqYZUtQ"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7eda47b7343so3879941a12.0;
        Tue, 29 Oct 2024 16:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730244774; x=1730849574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7emS6FqxxtwGK42f+Iy69RznkACs0efmp5R7LUKm2Os=;
        b=lMqYZUtQZRFvmUcjQ/mrTKGGQoeVLhCl7voQwLjb6xXPZnCeLqHfZGYhT0cY9Odf83
         K/X2yBjFgyzTWxShd09Q6CuYNFDvpqV+wdbcZZahBAyjPU8yOxkCKvgmK/L4e8eYHox5
         2W+SPgmj42IhyFUAvlHN1P8KVrwlvA5rLanEhHOAjB7830HAEBI16uk7kaHwD1zU1phw
         VPuklasvl83kY+P8dDqMFWsvwVT4NOPGD3zrk6MZCYuD0SiQ2aVaXVv/MEdPTyq7mDZY
         CaQfkusSbAsgx5NHOkR3IcR/2KgLdpRHflRKFXEcgLwdH9hCCmCftdLj/ElCOzuflIgz
         CdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730244774; x=1730849574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7emS6FqxxtwGK42f+Iy69RznkACs0efmp5R7LUKm2Os=;
        b=NqZtQrEhdqMX+j5Y2GvQN6W99Z6YOBaiUy71YmkOKBkP7LYBIwTmNL70WRqZLA/7o7
         mHv4l9QdLt7UCYRYsVHnX7NBIhs7tm7oFlVAtlYZ3hf6j7rEFplOk3dHBH0wToX7ghtT
         lnxM+lmeD6WxOFd90rRYVRojKIv7qEilGJfSKCOWsl5nvpdwkH64s5GfXA6XMg1UI14r
         6SY61nM/GRZOpacfvJ8oLXrq2VvP/ra5WAyibvhInQ16YuBqrDpZr8WPWIFJ9Ps2lt3u
         bB2wQMthploxs9hjkN/DA/+BzHog6Q7TTOw7qrVWzfqvVgwBJlHD/JvMoKhsd0ypQ03u
         E3uw==
X-Forwarded-Encrypted: i=1; AJvYcCVYw4xDdpyD+LB5V5hanrWp4LCMnE15kSykZAT84v+EG7sEZ1thQYp6nO92CbntzbG3Ug5imVv71X0+TqM9tj2eAw==@vger.kernel.org, AJvYcCXdz+oxkL7IHSJZaXMiHtDpDfankM5ahafexWWvlW0PGRen2dKl4wifVjepodBF0yxvpHFjH5oMXlFBiDI=@vger.kernel.org, AJvYcCXfyeHgZy720faiISgrveOqGDon7v7QOIAbsFl5VJoIqdv1n8j3TeP3jE42D2uXFCKIUKCu1SaPiEfgyehU2usn0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJ26z/HKD34JnaZ54uvq1qooalykeNZOMbEPxmQRW0XsACeEd
	c9ZoA/M1rlla56y7eK/085P2GuNwwuA5tIPg+F6qrzfShNHXULdOot+isJUCO0GdV1UdcamdibW
	SZ1s+mxEqcl/8pOSoH9zRNH2KJbU=
X-Google-Smtp-Source: AGHT+IHDz43omOfLmggEhx0HF4xQLnfIv3KEkuhXMCCHCXyHLt8e+1uVqZMoaT+Ct1JFceU1FTjP7T09eViPCMhHEO8=
X-Received: by 2002:a17:90b:4b04:b0:2d3:c976:dd80 with SMTP id
 98e67ed59e1d1-2e8f11dd117mr13904064a91.39.1730244773740; Tue, 29 Oct 2024
 16:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730150953.git.jpoimboe@kernel.org> <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
In-Reply-To: <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Oct 2024 16:32:40 -0700
Message-ID: <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 2:48=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> Some distros have started compiling frame pointers into all their
> packages to enable the kernel to do system-wide profiling of user space.
> Unfortunately that creates a runtime performance penalty across the
> entire system.  Using DWARF instead isn't feasible due to the complexity
> it would add to the kernel.
>
> For in-kernel unwinding we solved this problem with the creation of the
> ORC unwinder for x86_64.  Similarly, for user space the GNU assembler
> has created the sframe format starting with binutils 2.41 for sframe v2.
> Sframe is a simpler version of .eh_frame.  It gets placed in the .sframe
> section.
>
> Add support for unwinding user space using sframe.
>
> More information about sframe can be found here:
>
>   - https://lwn.net/Articles/932209/
>   - https://lwn.net/Articles/940686/
>   - https://sourceware.org/binutils/docs/sframe-spec.html
>
> Glibc support is needed to implement the prctl() calls to tell the
> kernel where the .sframe segments are.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/Kconfig                |   4 +
>  arch/x86/include/asm/mmu.h  |   2 +-
>  fs/binfmt_elf.c             |  35 +++-
>  include/linux/mm_types.h    |   3 +
>  include/linux/sframe.h      |  41 ++++
>  include/linux/unwind_user.h |   2 +
>  include/uapi/linux/elf.h    |   1 +
>  include/uapi/linux/prctl.h  |   3 +
>  kernel/fork.c               |  10 +
>  kernel/sys.c                |  11 ++
>  kernel/unwind/Makefile      |   3 +-
>  kernel/unwind/sframe.c      | 380 ++++++++++++++++++++++++++++++++++++
>  kernel/unwind/sframe.h      | 215 ++++++++++++++++++++
>  kernel/unwind/user.c        |  24 ++-
>  mm/init-mm.c                |   6 +
>  15 files changed, 732 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/sframe.h
>  create mode 100644 kernel/unwind/sframe.c
>  create mode 100644 kernel/unwind/sframe.h
>

It feels like this patch is trying to do too much. There is both new
UAPI introduction, and SFrame format definition, and unwinder
integration, etc, etc. Do you think it can be split further into more
focused smaller patches?


> @@ -688,7 +692,7 @@ static unsigned long load_elf_interp(struct elfhdr *i=
nterp_elf_ex,
>                         /*
>                          * Check to see if the section's size will overfl=
ow the
>                          * allowed task size. Note that p_filesz must alw=
ays be
> -                        * <=3D p_memsize so it's only necessary to check=
 p_memsz.
> +                        * <=3D p_memsz so it's only necessary to check p=
_memsz.
>                          */
>                         k =3D load_addr + eppnt->p_vaddr;
>                         if (BAD_ADDR(k) ||
> @@ -698,9 +702,24 @@ static unsigned long load_elf_interp(struct elfhdr *=
interp_elf_ex,
>                                 error =3D -ENOMEM;
>                                 goto out;
>                         }
> +
> +                       if ((eppnt->p_flags & PF_X) && k < start_code)
> +                               start_code =3D k;
> +
> +                       if ((eppnt->p_flags & PF_X) && k + eppnt->p_files=
z > end_code)
> +                               end_code =3D k + eppnt->p_filesz;
> +                       break;
> +               }
> +               case PT_GNU_SFRAME:
> +                       sframe_phdr =3D eppnt;

if I understand correctly, there has to be only one sframe, is that
right? Should we validate that?

> +                       break;
>                 }
>         }
>
> +       if (sframe_phdr)
> +               sframe_add_section(load_addr + sframe_phdr->p_vaddr,
> +                                  start_code, end_code);
> +

no error checking?

>         error =3D load_addr;
>  out:
>         return error;
> @@ -823,7 +842,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>         int first_pt_load =3D 1;
>         unsigned long error;
>         struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata =3D NU=
LL;
> -       struct elf_phdr *elf_property_phdata =3D NULL;
> +       struct elf_phdr *elf_property_phdata =3D NULL, *sframe_phdr =3D N=
ULL;
>         unsigned long elf_brk;
>         int retval, i;
>         unsigned long elf_entry;
> @@ -931,6 +950,10 @@ static int load_elf_binary(struct linux_binprm *bprm=
)
>                                 executable_stack =3D EXSTACK_DISABLE_X;
>                         break;
>
> +               case PT_GNU_SFRAME:
> +                       sframe_phdr =3D elf_ppnt;
> +                       break;
> +
>                 case PT_LOPROC ... PT_HIPROC:
>                         retval =3D arch_elf_pt_proc(elf_ex, elf_ppnt,
>                                                   bprm->file, false,
> @@ -1321,6 +1344,10 @@ static int load_elf_binary(struct linux_binprm *bp=
rm)
>                                             task_pid_nr(current), retval)=
;
>         }
>
> +       if (sframe_phdr)
> +               sframe_add_section(load_bias + sframe_phdr->p_vaddr,
> +                                  start_code, end_code);
> +

error checking missing?

>         regs =3D current_pt_regs();
>  #ifdef ELF_PLAT_INIT
>         /*
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 381d22eba088..6e7561c1a5fc 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1052,6 +1052,9 @@ struct mm_struct {
>  #endif
>                 } lru_gen;
>  #endif /* CONFIG_LRU_GEN_WALKS_MMU */
> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> +               struct maple_tree sframe_mt;
> +#endif
>         } __randomize_layout;
>
>         /*
> diff --git a/include/linux/sframe.h b/include/linux/sframe.h
> new file mode 100644
> index 000000000000..d167e01817c4
> --- /dev/null
> +++ b/include/linux/sframe.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_SFRAME_H
> +#define _LINUX_SFRAME_H
> +
> +#include <linux/mm_types.h>
> +
> +struct unwind_user_frame;
> +
> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> +
> +#define INIT_MM_SFRAME .sframe_mt =3D MTREE_INIT(sframe_mt, 0),
> +
> +extern void sframe_free_mm(struct mm_struct *mm);
> +
> +/* text_start, text_end, file_name are optional */

what file_name? was that an extra argument that got removed?

> +extern int sframe_add_section(unsigned long sframe_addr, unsigned long t=
ext_start,
> +                             unsigned long text_end);
> +
> +extern int sframe_remove_section(unsigned long sframe_addr);
> +extern int sframe_find(unsigned long ip, struct unwind_user_frame *frame=
);
> +
> +static inline bool current_has_sframe(void)
> +{
> +       struct mm_struct *mm =3D current->mm;
> +
> +       return mm && !mtree_empty(&mm->sframe_mt);
> +}
> +

[...]

> diff --git a/kernel/sys.c b/kernel/sys.c
> index 4da31f28fda8..7d05a67727db 100644
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
> @@ -2784,6 +2785,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
 arg2, unsigned long, arg3,
>         case PR_RISCV_SET_ICACHE_FLUSH_CTX:
>                 error =3D RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
>                 break;
> +       case PR_ADD_SFRAME:
> +               if (arg5)
> +                       return -EINVAL;
> +               error =3D sframe_add_section(arg2, arg3, arg4);

wouldn't it be better to make this interface extendable from the get
go? Instead of passing 3 arguments with fixed meaning, why not pass a
pointer to an extendable binary struct like seems to be the trend
nowadays with nicely extensible APIs. See [0] for one such example
(specifically, struct procmap_query). Seems more prudent, as we'll
most probably will be adding flags, options, extra information, etc)

  [0] https://lore.kernel.org/linux-mm/20240627170900.1672542-3-andrii@kern=
el.org/

> +               break;
> +       case PR_REMOVE_SFRAME:
> +               if (arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +               error =3D sframe_remove_section(arg2);
> +               break;
>         default:
>                 error =3D -EINVAL;
>                 break;

[...]

> +static unsigned char fre_type_to_size(unsigned char fre_type)
> +{
> +       if (fre_type > 2)
> +               return 0;
> +       return 1 << fre_type;
> +}
> +
> +static unsigned char offset_size_enum_to_size(unsigned char off_size)
> +{
> +       if (off_size > 2)
> +               return 0;
> +       return 1 << off_size;
> +}
> +
> +static int find_fde(struct sframe_section *sec, unsigned long ip,
> +                   struct sframe_fde *fde)
> +{
> +       struct sframe_fde __user *first, *last, *found =3D NULL;
> +       u32 ip_off, func_off_low =3D 0, func_off_high =3D -1;
> +
> +       ip_off =3D ip - sec->sframe_addr;

what if ip_off is larger than 4GB? ELF section can be bigger than 4GB, righ=
t?

and also, does it mean that SFrame doesn't support executables with
text bigger than 4GB?

> +
> +       first =3D (void __user *)sec->fdes_addr;
> +       last =3D first + sec->fdes_nr;
> +       while (first <=3D last) {
> +               struct sframe_fde __user *mid;
> +               u32 func_off;
> +
> +               mid =3D first + ((last - first) / 2);
> +
> +               if (get_user(func_off, (s32 __user *)mid))
> +                       return -EFAULT;
> +
> +               if (ip_off >=3D func_off) {
> +                       /* validate sort order */
> +                       if (func_off < func_off_low)
> +                               return -EINVAL;
> +
> +                       func_off_low =3D func_off;
> +
> +                       found =3D mid;
> +                       first =3D mid + 1;
> +               } else {
> +                       /* validate sort order */
> +                       if (func_off > func_off_high)
> +                               return -EINVAL;
> +
> +                       func_off_high =3D func_off;
> +
> +                       last =3D mid - 1;
> +               }
> +       }
> +
> +       if (!found)
> +               return -EINVAL;
> +
> +       if (copy_from_user(fde, found, sizeof(*fde)))
> +               return -EFAULT;
> +
> +       /* check for gaps */
> +       if (ip_off < fde->start_addr || ip_off >=3D fde->start_addr + fde=
->size)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +

[...]

> +int sframe_add_section(unsigned long sframe_addr, unsigned long text_sta=
rt,
> +                      unsigned long text_end)
> +{
> +       struct mm_struct *mm =3D current->mm;
> +       struct vm_area_struct *sframe_vma;
> +
> +       mmap_read_lock(mm);
> +
> +       sframe_vma =3D vma_lookup(mm, sframe_addr);
> +       if (!sframe_vma)
> +               goto err_unlock;
> +
> +       if (text_start && text_end) {
> +               struct vm_area_struct *text_vma;
> +
> +               text_vma =3D vma_lookup(mm, text_start);
> +               if (!(text_vma->vm_flags & VM_EXEC))
> +                       goto err_unlock;
> +
> +               if (PAGE_ALIGN(text_end) !=3D text_vma->vm_end)
> +                       goto err_unlock;
> +       } else {
> +               struct vm_area_struct *vma, *text_vma =3D NULL;
> +               VMA_ITERATOR(vmi, mm, 0);
> +
> +               for_each_vma(vmi, vma) {
> +                       if (vma->vm_file !=3D sframe_vma->vm_file ||
> +                           !(vma->vm_flags & VM_EXEC))
> +                               continue;
> +
> +                       if (text_vma) {
> +                               pr_warn_once("%s[%d]: multiple EXEC segme=
nts unsupported\n",
> +                                            current->comm, current->pid)=
;

is this just something that fundamentally can't be supported by SFrame
format? Or just an implementation simplification?

It's not illegal to have an executable with multiple VM_EXEC segments,
no? Should this be a pr_warn_once() then?

> +                               goto err_unlock;
> +                       }
> +
> +                       text_vma =3D vma;
> +               }
> +
> +               if (!text_vma)
> +                       goto err_unlock;
> +
> +               text_start =3D text_vma->vm_start;
> +               text_end   =3D text_vma->vm_end;
> +       }
> +
> +       mmap_read_unlock(mm);
> +
> +       return __sframe_add_section(sframe_addr, text_start, text_end);
> +

[...]
