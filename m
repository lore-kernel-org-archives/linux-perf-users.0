Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7881E2C95;
	Wed, 30 Oct 2024 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730267597; cv=none; b=FsylXrQYIAKAj7JOYX0XTr0crWgziKgCeXyYOlq8WPXDfR1X+c9MkJX3Y+dm+U/WmXPBybUa8ebU7VeIxuUloqf1u60INV+Wbil5Aqx9ya4FhuvkpG5ruOTwh84Qqow/LP5n98hsFNTREOyT9uI05CyoIulR4Cx8OWtBJ3OMiY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730267597; c=relaxed/simple;
	bh=augGohFjpk+jSI2qAwFC1uxFG7NPGCKrTeaRhwy1o6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhlXKEGk32Pw4OackeFNdZw2I6laAqFa1bMre0jMu4AuG/Tv/WgPiz+YTPBgBem60FKoV6nVHyeHBvje93jydDpkcGmcVV7909WelnmEvHxWYoixTwI0crLPhPuoc0/esSFy2slRiT8TVzvdxm2EifHA67P3pOtFdjRNtUbZorY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSGGm8zF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSGGm8zF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB2CC4CEE4;
	Wed, 30 Oct 2024 05:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730267597;
	bh=augGohFjpk+jSI2qAwFC1uxFG7NPGCKrTeaRhwy1o6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSGGm8zF6fqIUqaYjprVYMefRcTuAtwv8QziTXwT+DlvBcKfYCS/X6zvdDtdI+avt
	 j4vawGQy7ip9PAq8935QoVmN4/YzVS/R2Rmq1x/BosUjmotSpKRdwTl4VKSeY+5A2J
	 JFf31tuw2OeF0Bf6PM61xbW0EKzoJR3m4LR1ZvSN57aDZLQh2mXrRYusA3RsCU2nvn
	 5dd4MPOr0e/h2F9jtUbPo+mBYMqi7LasnwEI9fPzuyW1xiu/jQWUth1DPDJpFoNtFB
	 N8fjhNvsQzDlFk/A0nPvYOng+fUlM7gV8V45l6CdKpYKo4gM7Q8sWG3wXmzz10LZhE
	 DxiSDi3d44HYg==
Date: Tue, 29 Oct 2024 22:53:14 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241030055314.2vg55ychg5osleja@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>

On Tue, Oct 29, 2024 at 04:32:40PM -0700, Andrii Nakryiko wrote:
> It feels like this patch is trying to do too much. There is both new
> UAPI introduction, and SFrame format definition, and unwinder
> integration, etc, etc. Do you think it can be split further into more
> focused smaller patches?

True, let me see if I can split it up.

> > +
> > +                       if ((eppnt->p_flags & PF_X) && k < start_code)
> > +                               start_code = k;
> > +
> > +                       if ((eppnt->p_flags & PF_X) && k + eppnt->p_filesz > end_code)
> > +                               end_code = k + eppnt->p_filesz;
> > +                       break;
> > +               }
> > +               case PT_GNU_SFRAME:
> > +                       sframe_phdr = eppnt;
> 
> if I understand correctly, there has to be only one sframe, is that
> right? Should we validate that?

Yes, there shouldn't be more than one PT_GNU_SFRAME for the executable
itself.  I can validate that.

> > +                       break;
> >                 }
> >         }
> >
> > +       if (sframe_phdr)
> > +               sframe_add_section(load_addr + sframe_phdr->p_vaddr,
> > +                                  start_code, end_code);
> > +
> 
> no error checking?

Good point.  I remember discussing this with some people at Cauldon/LPC,
I just forgot to do it!

Right now it does all the validation at unwind, which could really slow
things down unnecessarily if the sframe isn't valid.

> > +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> > +
> > +#define INIT_MM_SFRAME .sframe_mt = MTREE_INIT(sframe_mt, 0),
> > +
> > +extern void sframe_free_mm(struct mm_struct *mm);
> > +
> > +/* text_start, text_end, file_name are optional */
> 
> what file_name? was that an extra argument that got removed?

Indeed, that was for some old code.

> >         case PR_RISCV_SET_ICACHE_FLUSH_CTX:
> >                 error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
> >                 break;
> > +       case PR_ADD_SFRAME:
> > +               if (arg5)
> > +                       return -EINVAL;
> > +               error = sframe_add_section(arg2, arg3, arg4);
> 
> wouldn't it be better to make this interface extendable from the get
> go? Instead of passing 3 arguments with fixed meaning, why not pass a
> pointer to an extendable binary struct like seems to be the trend
> nowadays with nicely extensible APIs. See [0] for one such example
> (specifically, struct procmap_query). Seems more prudent, as we'll
> most probably will be adding flags, options, extra information, etc)
> 
>   [0] https://lore.kernel.org/linux-mm/20240627170900.1672542-3-andrii@kernel.org/

This ioctl interface was admittedly hacked together.  I was hoping
somebody would suggest something better :-)  I'll take a look.

> > +static int find_fde(struct sframe_section *sec, unsigned long ip,
> > +                   struct sframe_fde *fde)
> > +{
> > +       struct sframe_fde __user *first, *last, *found = NULL;
> > +       u32 ip_off, func_off_low = 0, func_off_high = -1;
> > +
> > +       ip_off = ip - sec->sframe_addr;
> 
> what if ip_off is larger than 4GB? ELF section can be bigger than 4GB, right?

That's baked into sframe v2.

> and also, does it mean that SFrame doesn't support executables with
> text bigger than 4GB?

Yes, but is that a realistic concern?

> > +       } else {
> > +               struct vm_area_struct *vma, *text_vma = NULL;
> > +               VMA_ITERATOR(vmi, mm, 0);
> > +
> > +               for_each_vma(vmi, vma) {
> > +                       if (vma->vm_file != sframe_vma->vm_file ||
> > +                           !(vma->vm_flags & VM_EXEC))
> > +                               continue;
> > +
> > +                       if (text_vma) {
> > +                               pr_warn_once("%s[%d]: multiple EXEC segments unsupported\n",
> > +                                            current->comm, current->pid);
> 
> is this just something that fundamentally can't be supported by SFrame
> format? Or just an implementation simplification?

It's a simplification I suppose.

> It's not illegal to have an executable with multiple VM_EXEC segments,
> no? Should this be a pr_warn_once() then?

I don't know, is it allowed?  I've never seen it in practice.  The
pr_warn_once() is not reporting that it's illegal but rather that this
corner case actually exists and maybe needs to be looked at.

-- 
Josh
