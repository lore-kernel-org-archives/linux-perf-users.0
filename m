Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D108212F08;
	Wed,  2 Oct 2024 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893384; cv=none; b=h5CPPrpEqrplFdHTWT+AULuYuPNi9XmkQPFbuOYH7iC+arprYXZXtTeM6xSaB9M5Dhw2/ztNrT02LD9LTrYR0CsQ6c2M6mbOlcRb7uUpZ0f08j7COJ4SkdjvO4CeGTfxt6dngaJSvOrfAWdAuOA8VeZ4DV1W6Gm8iKU1rc7bB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893384; c=relaxed/simple;
	bh=3UH1ssGS+wlG4XHDhzqO3P+CkzUcfba6BeYYyCCfZqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujmYtwVST6WkQN3o+YXU9zJBlZpAa8ZkOuGfB+hLnGO1U/ctQplIfSsw4sbOB5CzTvXzIvX4FfBPW/PYDywaXZxX4NO9jdSaSB2wTPn/cz68Ek0nxCU7V8y/bzRYPkLIQHYBIIltv4UtajTVH7WurLNo8238VBIGng7TlbaWN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXIcj9y7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXIcj9y7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4C3C4CECD;
	Wed,  2 Oct 2024 18:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727893383;
	bh=3UH1ssGS+wlG4XHDhzqO3P+CkzUcfba6BeYYyCCfZqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fXIcj9y7XyycgqKxUQf+We7qdZOZiGr8BvX8w0SDToLxLGqQEyauiZWTKAniu5vmu
	 0itaiXuiz7hqJEubJGfpfv4XTioXTogOqMnVwDw76VrhWjUVbDvOeDULBsLTFUOOAY
	 gVvuRvy4LHEh2Qg2GypTIfz/x5jxMJDp05GW2vo85iVdFeq/qp/0O5u4xLK2bRuzIT
	 72r6/tFDtkmKe4OYSGRdOFVxKch7BxF1du9CUwRciRA9EVQNSoDemFjOFlPp0Ia45u
	 fgc6Ad9z1ZFESthug6RcjP1VrMRGRLyVNqkfgzK6Hiy4lUhLwd2g78QbMyTm8ijoFV
	 51C/Eir34j+2Q==
Date: Wed, 2 Oct 2024 11:23:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] perf tools: Cope with differences for
 lib/list_sort.c copy from the kernel
Message-ID: <Zv2PhTIo9tcVRLUr@google.com>
References: <20240930202136.16904-1-acme@kernel.org>
 <20240930202136.16904-3-acme@kernel.org>
 <ZvtWwJ87xzViwZqI@google.com>
 <Zv2I7TYx_WqCgE5F@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zv2I7TYx_WqCgE5F@x1>

On Wed, Oct 02, 2024 at 02:54:53PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 30, 2024 at 06:56:16PM -0700, Namhyung Kim wrote:
> > On Mon, Sep 30, 2024 at 05:21:36PM -0300, Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > With 6d74e1e371d43a7b ("tools/lib/list_sort: remove redundant code for
> > > cond_resched handling") we need to use the newly added hunk based
> > > exceptions when comparing the copy we carry in tools/lib/ to the
> > > original file, do it by adding the hunks that we know will be the
> > > expected diff.
> > > 
> > > If at some point the original file is updated in other parts, then we
> > > should flag and check the file for update.
> > > 
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Kan Liang <kan.liang@linux.intel.com>
> > > Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > I'm seeing this but I think it's ok since we're adding a patch file as a
> > content.
> > 
> >   Applying: perf tools: Cope with differences for lib/list_sort.c copy from the kernel
> >   .git/rebase-apply/patch:21: space before tab in indent.
> >    			struct list_head *a, struct list_head *b)
> >   .git/rebase-apply/patch:23: space before tab in indent.
> >    	struct list_head *tail = head;
> >   .git/rebase-apply/patch:25: trailing whitespace.
> >    
> >   .git/rebase-apply/patch:26: space before tab in indent.
> >    	for (;;) {
> >   .git/rebase-apply/patch:27: space before tab in indent.
> >    		/* if equal, take 'a' -- important for sort stability */
> >   warning: squelched 6 whitespace errors
> >   warning: 11 lines add whitespace errors.
> > 
> > And build doesn't show the message for lib/list_sort.c anymore. :)
> > 
> > I think it's nice to update for later changes, just put the diff in a
> 
> What kind of update you thinks its nice for later changes?

I meant it's good. :)  It'd be convenient if we have some changes that
need to be handled separately like this in the future.

> 
> > file with the same name under check-header_ignore_hunks directory.
> 
> Isn't it like that already? Was the intention:
> 
> .../check-header_ignore_hunks/lib/list_sort.c | 31 +++++++++++++++++++
> 
> It is the same name as tools/lib/list_sort.c and lib/list_sort.c
> 
> Or did you mean something else?

No, I just said about possible future work and glad to have this.

> 
> > Good job!
> 
> Assuming all is right, thanks! 8-)

Thanks,
Namhyung

> > 
> > > ---
> > >  .../check-header_ignore_hunks/lib/list_sort.c | 31 +++++++++++++++++++
> > >  tools/perf/check-headers.sh                   |  5 ++-
> > >  2 files changed, 35 insertions(+), 1 deletion(-)
> > >  create mode 100644 tools/perf/check-header_ignore_hunks/lib/list_sort.c
> > > 
> > > diff --git a/tools/perf/check-header_ignore_hunks/lib/list_sort.c b/tools/perf/check-header_ignore_hunks/lib/list_sort.c
> > > new file mode 100644
> > > index 0000000000000000..32d98cb34f80a987
> > > --- /dev/null
> > > +++ b/tools/perf/check-header_ignore_hunks/lib/list_sort.c
> > > @@ -0,0 +1,31 @@
> > > +@@ -1,5 +1,6 @@
> > > + // SPDX-License-Identifier: GPL-2.0
> > > + #include <linux/kernel.h>
> > > ++#include <linux/bug.h>
> > > + #include <linux/compiler.h>
> > > + #include <linux/export.h>
> > > + #include <linux/string.h>
> > > +@@ -52,6 +53,7 @@
> > > + 			struct list_head *a, struct list_head *b)
> > > + {
> > > + 	struct list_head *tail = head;
> > > ++	u8 count = 0;
> > > + 
> > > + 	for (;;) {
> > > + 		/* if equal, take 'a' -- important for sort stability */
> > > +@@ -77,6 +79,15 @@
> > > + 	/* Finish linking remainder of list b on to tail */
> > > + 	tail->next = b;
> > > + 	do {
> > > ++		/*
> > > ++		 * If the merge is highly unbalanced (e.g. the input is
> > > ++		 * already sorted), this loop may run many iterations.
> > > ++		 * Continue callbacks to the client even though no
> > > ++		 * element comparison is needed, so the client's cmp()
> > > ++		 * routine can invoke cond_resched() periodically.
> > > ++		 */
> > > ++		if (unlikely(!++count))
> > > ++			cmp(priv, b, b);
> > > + 		b->prev = tail;
> > > + 		tail = b;
> > > + 		b = b->next;
> > > diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> > > index 55aba47e5aec9292..f1080d4096663ba1 100755
> > > --- a/tools/perf/check-headers.sh
> > > +++ b/tools/perf/check-headers.sh
> > > @@ -193,7 +193,6 @@ check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
> > >  check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
> > >  check include/linux/ctype.h	      '-I "isdigit("'
> > >  check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B'
> > > -check lib/list_sort.c		      '-I "^#include <linux/bug.h>"'
> > >  
> > >  # diff non-symmetric files
> > >  check_2 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl arch/x86/entry/syscalls/syscall_32.tbl
> > > @@ -211,6 +210,10 @@ done
> > >  check_2 tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
> > >  check_2 tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
> > >  
> > > +# Files with larger differences
> > > +
> > > +check_ignore_some_hunks lib/list_sort.c
> > > +
> > >  cd tools/perf || exit
> > >  
> > >  if [ ${#FAILURES[@]} -gt 0 ]
> > > -- 
> > > 2.46.0
> > > 
