Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BAE198A31;
	Tue, 29 Oct 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220621; cv=none; b=N0eA0bw8/QL4rKwrc8rUltfFRZgMlyOgu5uEqVBNNLH5SjoyXpBAkBGiNymgLvovxw+1848s7WNs0W58eprki/1is3HptsxrpW3Pg9rX7fdc4lZqHCrM2D7lbDF0KogwuPkyMMgokswXwlB3QNehPxH/3OzYcqrCwZ9wQ2RZLoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220621; c=relaxed/simple;
	bh=RugY9MXnIBg69Un0Ga4QChO5ZrWqKRP/q8kSSIgXKVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emjoUJhb4e/cz0PNQJsMnmgimBx/JLJ+kzsXUfqLg8QLRdVbxqEZucJjoouzfwAaOUkHFckIdOm6+iXR04aT3+P/nqUlH4hOvGeERoQ4Tphkxy/fDKwfUjqdNfCBi4t4B6ESoFEWIKzl3dCuVA3nKU1YgiveGwb3L2pKqCwlhxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMBwiV6M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMBwiV6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115C9C4CECD;
	Tue, 29 Oct 2024 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730220621;
	bh=RugY9MXnIBg69Un0Ga4QChO5ZrWqKRP/q8kSSIgXKVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMBwiV6MRlLzfTXB1mZaEh85j+VsNeoZSyUFSnJBNzbZkO6wpttTEp9IOQV3Q+/+3
	 NLgeVbaM9Zrmi9fhvoM1TcpNeBGpK8VhMc1lLJkrmsi9S5kGle2PqyMgmOZBgN8RNY
	 RLmFcgjsyrB1AxxPX6wMmgQkwOAPZc/oNiGhKMJFzOP7PjcXqo8dN6oiP/iMLjFY7d
	 CL5T7x2l6r4DtnUHvwHSBnVm11IIkrkzytUvDvICkiVU0X4gi3AHPkMRltffqxb4V+
	 /wamKn9HdzSftsWhgEjIFVbCakatQ9C1zaqmyU/NE5AYRsfRThAHclC1g5fdF62IB8
	 LCPqiNAVbT+yA==
Date: Tue, 29 Oct 2024 09:50:18 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20241029165018.r4l5wix24s3f22c6@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <20241029132709.GY14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029132709.GY14555@noisy.programming.kicks-ass.net>

On Tue, Oct 29, 2024 at 02:27:09PM +0100, Peter Zijlstra wrote:
> > +int sframe_add_section(unsigned long sframe_addr, unsigned long text_start,
> > +		       unsigned long text_end)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +	struct vm_area_struct *sframe_vma;
> > +
> > +	mmap_read_lock(mm);
> 
> DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
> 	     mmap_read_lock(_T), mmap_read_unlock(_T))
> 
> in include/linux/mmap_lock.h ?

Will do.

> > @@ -2784,6 +2785,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> >  	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
> >  		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
> >  		break;
> > +	case PR_ADD_SFRAME:
> > +		if (arg5)
> > +			return -EINVAL;
> > +		error = sframe_add_section(arg2, arg3, arg4);
> > +		break;
> > +	case PR_REMOVE_SFRAME:
> > +		if (arg3 || arg4 || arg5)
> > +			return -EINVAL;
> > +		error = sframe_remove_section(arg2);
> > +		break;
> >  	default:
> >  		error = -EINVAL;
> >  		break;
> 
> So I realize that mtree has an internal lock, but are we sure we don't
> want a lock around those prctl()s?

Not that I can tell?  It relies on the mtree internal locking for
atomicity.

For sframe_remove_section() it uses srcu to delay the freeing until all
sframe_find()'s have completed.

-- 
Josh
