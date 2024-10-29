Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D6205E1C;
	Tue, 29 Oct 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208444; cv=none; b=Ra44FUJDWcI5IE4+1lYDoXvEdBjyems6486MF1+nhW23ys6BLVPOuIhYUq+dG0fUwNmgSI0e7EBQ5E15M0YxCx1WhbofxdS0RdLfc4sLZgLboza1csR/4bDZw/Yxtl0dKTmBpm9YxkYIFejgUKBRUbsftG2eDhSwj/mtnQ33Aco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208444; c=relaxed/simple;
	bh=6CDclU0L0kldK4wkaesKTrF6A4Gr+4LWe9ewf6wha6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVCiyb8TwXMmt498ZzPH5ySdgq3js8x/M783RvwjNXb3X1+LZ9aDPhOJVcmu6KnvZZxylUtsJWOt/Mr5XuXFXbzG5oAkHDmgcQKwwLBYYA1nLoz/+YTWxYsbeS3IXKzuKp0l8cbIrAKnmgvq8XEQPkyJYesc/yah6uFa6oW5N1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G4jQZu0Q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G4jQZu0Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w6IQVSueTu4Omi8gbl34oVf+2SG+3VHCX43r2tsjj8k=; b=G4jQZu0QV1UoEL3JWNAZwrG/ak
	AAS99ez/uPBTgNEmsMJtA9WAzxMcPmqDPFl5vUBQX/fKDjmYWw/uFL6I4ZVbAPxVua+EjYVU5pi00
	Oi7tt0x2GXYk5jZ2qoHfDn5shbYAA16qIj1+GT2mmrI8U6Wzs7iY9YjLydrR4snaxN6ljr7rqg/d/
	Irv0nEzLy7LZpJgv/wCxY6r176AnXY42Kys2lQP+M5nFudc7IPLbvBkdu/pG8uNRtSy+6yw9LBph+
	zEaO5KVbj4a6+bXrVZACbDY27tSn9lD35DiVD5dpITelC0UBKgUAH8MVRx/OP6hqT+CRcBEDck/b6
	QNnlrgcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5mFa-00000009uJi-1uF6;
	Tue, 29 Oct 2024 13:27:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C86EB30073F; Tue, 29 Oct 2024 14:27:09 +0100 (CET)
Date: Tue, 29 Oct 2024 14:27:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
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
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241029132709.GY14555@noisy.programming.kicks-ass.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>

On Mon, Oct 28, 2024 at 02:47:36PM -0700, Josh Poimboeuf wrote:

> +static int __sframe_add_section(unsigned long sframe_addr,
> +				unsigned long text_start,
> +				unsigned long text_end)
> +{
> +	struct maple_tree *sframe_mt = &current->mm->sframe_mt;
> +	struct sframe_section *sec;
> +	struct sframe_header shdr;
> +	unsigned long header_end;
> +	int ret;
> +
> +	if (copy_from_user(&shdr, (void __user *)sframe_addr, sizeof(shdr)))
> +		return -EFAULT;
> +
> +	if (shdr.preamble.magic != SFRAME_MAGIC ||
> +	    shdr.preamble.version != SFRAME_VERSION_2 ||
> +	    !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
> +	    shdr.auxhdr_len || !shdr.num_fdes || !shdr.num_fres ||
> +	    shdr.fdes_off > shdr.fres_off) {
> +		return -EINVAL;
> +	}
> +
> +	sec = kmalloc(sizeof(*sec), GFP_KERNEL);
> +	if (!sec)
> +		return -ENOMEM;
> +
> +	header_end = sframe_addr + SFRAME_HDR_SIZE(shdr);
> +
> +	sec->sframe_addr	= sframe_addr;
> +	sec->text_addr		= text_start;
> +	sec->fdes_addr		= header_end + shdr.fdes_off;
> +	sec->fres_addr		= header_end + shdr.fres_off;
> +	sec->fdes_nr		= shdr.num_fdes;
> +	sec->ra_off		= shdr.cfa_fixed_ra_offset;
> +	sec->fp_off		= shdr.cfa_fixed_fp_offset;
> +
> +	ret = mtree_insert_range(sframe_mt, text_start, text_end, sec, GFP_KERNEL);
> +	if (ret) {
> +		kfree(sec);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int sframe_add_section(unsigned long sframe_addr, unsigned long text_start,
> +		       unsigned long text_end)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *sframe_vma;
> +
> +	mmap_read_lock(mm);

DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
	     mmap_read_lock(_T), mmap_read_unlock(_T))

in include/linux/mmap_lock.h ?

> +
> +	sframe_vma = vma_lookup(mm, sframe_addr);
> +	if (!sframe_vma)
> +		goto err_unlock;
> +
> +	if (text_start && text_end) {
> +		struct vm_area_struct *text_vma;
> +
> +		text_vma = vma_lookup(mm, text_start);
> +		if (!(text_vma->vm_flags & VM_EXEC))
> +			goto err_unlock;
> +
> +		if (PAGE_ALIGN(text_end) != text_vma->vm_end)
> +			goto err_unlock;
> +	} else {
> +		struct vm_area_struct *vma, *text_vma = NULL;
> +		VMA_ITERATOR(vmi, mm, 0);
> +
> +		for_each_vma(vmi, vma) {
> +			if (vma->vm_file != sframe_vma->vm_file ||
> +			    !(vma->vm_flags & VM_EXEC))
> +				continue;
> +
> +			if (text_vma) {
> +				pr_warn_once("%s[%d]: multiple EXEC segments unsupported\n",
> +					     current->comm, current->pid);
> +				goto err_unlock;
> +			}
> +
> +			text_vma = vma;
> +		}
> +
> +		if (!text_vma)
> +			goto err_unlock;
> +
> +		text_start = text_vma->vm_start;
> +		text_end   = text_vma->vm_end;
> +	}
> +
> +	mmap_read_unlock(mm);
> +
> +	return __sframe_add_section(sframe_addr, text_start, text_end);
> +
> +err_unlock:
> +	mmap_read_unlock(mm);
> +	return -EINVAL;
> +}

> +int sframe_remove_section(unsigned long sframe_addr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct sframe_section *sec;
> +	unsigned long index = 0;
> +
> +	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
> +		if (sec->sframe_addr == sframe_addr)
> +			return __sframe_remove_section(mm, sec);
> +	}
> +
> +	return -EINVAL;
> +}

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
> @@ -2784,6 +2785,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
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

So I realize that mtree has an internal lock, but are we sure we don't
want a lock around those prctl()s?


