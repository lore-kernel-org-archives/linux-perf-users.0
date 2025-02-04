Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B521767A;
	Tue,  4 Feb 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738696222; cv=none; b=oV0Eghkaqw8K1fVfMB7zARaOoixrQ+27eA339OyVjI0wne3K3WJUonQUSpPpGPzl2DYvbMi4fs8eTzW1F2P2BSrfrShZDz5wBl/5NLLQmuc0oWTw8H2nJW+TqjdXJiM627HmTIXP5vzhH0D5t0V5zTGlnaAPBa3B9tN83k5H41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738696222; c=relaxed/simple;
	bh=Zd/gLVjPpiZVgNGhRiKBUZa+V7xvpcsEdefnPBi6Bcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjAZshcQbkp9DTmyUuXuEoF1KZ6Zsj6Iq6O5no520wHW/1zEMkVEDEC8lHhKeQSz7+eqbflj/wAjGKsVr5PpfLxIWOzDpo1BhU8CuHu6R9VUyPh17vt/VuIBB/W35TvElJuuciOw1NbhweVNv4Fir3zG+7Zfod6Uj5XTN9WRd7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYYi2sgQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYYi2sgQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9098EC4CEDF;
	Tue,  4 Feb 2025 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738696221;
	bh=Zd/gLVjPpiZVgNGhRiKBUZa+V7xvpcsEdefnPBi6Bcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYYi2sgQx2dPS5vxgoBjFdCuoEXXoWnive3CuG+8FDu/hzNtVV/rgQOwgSp2NRVHf
	 wv3ZnIEBukU53ZuB2BoC5TR1FqqZfETKL/2HrbIo6VYQw5obmXWVO2mtnKwGSwudLu
	 pH5Zd7X1vW57CHd+lbYj9OtFz4e21JTKC22qB1LoZRsMrP6rQt3hsDfGlyAeOATMwb
	 K31qgrow8x618TsqnxYGCXKDCae9cUoiV9tiZZonSxVnYflmP5DECWLocTnwZhsjoI
	 TEqDB7sFT0YjjbIgSE40dh5qdTsXYKixeBPDC4GEnleo1YJ9re4yKZopUgKxUhFgd7
	 rX0zzc0RCjEYw==
Date: Tue, 4 Feb 2025 11:10:17 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v4 25/39] unwind_user/sframe: Show file name in debug
 output
Message-ID: <20250204191017.iqrew5zgxg7eh4s2@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <7bfb7ffad5fe384fe3dbe6c8ca985f35b98b48bb.1737511963.git.jpoimboe@kernel.org>
 <c9ba301e-8451-441d-8212-2913a76ff32d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9ba301e-8451-441d-8212-2913a76ff32d@linux.ibm.com>

On Thu, Jan 30, 2025 at 05:17:33PM +0100, Jens Remus wrote:
> On 22.01.2025 03:31, Josh Poimboeuf wrote:
> > When debugging sframe issues, the error messages aren't all that helpful
> > without knowing what file a corresponding .sframe section belongs to.
> > Prefix debug output strings with the file name.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> > diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
> 
> > +static inline void dbg_init(struct sframe_section *sec)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +	struct vm_area_struct *vma;
> > +
> > +	guard(mmap_read_lock)(mm);
> > +	vma = vma_lookup(mm, sec->sframe_start);
> > +	if (!vma)
> > +		sec->filename = kstrdup("(vma gone???)", GFP_KERNEL);
> > +	else if (vma->vm_file)
> > +		sec->filename = kstrdup_quotable_file(vma->vm_file, GFP_KERNEL);
> > +	else if (!vma->vm_mm)
> 
> This condition does not appear to work for vdso on s390.

I had a fix for this which somehow got dropped:

diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
index 3bb3c5574aee..045e9c0b16c9 100644
--- a/kernel/unwind/sframe_debug.h
+++ b/kernel/unwind/sframe_debug.h
@@ -67,6 +67,10 @@ static inline void dbg_init(struct sframe_section *sec)
 		sec->filename = kstrdup("(vma gone???)", GFP_KERNEL);
 	else if (vma->vm_file)
 		sec->filename = kstrdup_quotable_file(vma->vm_file, GFP_KERNEL);
+	else if (vma->vm_ops && vma->vm_ops->name)
+		sec->filename = kstrdup(vma->vm_ops->name(vma), GFP_KERNEL);
+	else if (arch_vma_name(vma))
+		sec->filename = kstrdup(arch_vma_name(vma), GFP_KERNEL);
 	else if (!vma->vm_mm)
 		sec->filename = kstrdup("(vdso)", GFP_KERNEL);
 	else
