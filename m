Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CF2770B;
	Thu, 16 Jan 2025 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055077; cv=none; b=IqcLvNh68LZIN+wdrGdnZsgoJvtZfh3C5KcCKrH1iLebL8blG6GP7TJOLUlSfjO9hj3mrXPlO6e+tjdDBXJMasUrVUgRwm2vuaWFDlAmLSA4P5vVpaf5SBDACrXCxsTGHKcqZF2NVJaerN52DI5k3PnBQ3rTh6QSBG5cFeKuS+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055077; c=relaxed/simple;
	bh=7K74G0KpbMnNmZ6t6sLh3JLeIVgEDg+82LEBCs5gUIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7BaaNQhgPkt9+TXK216gyA68deDK3j0Ue9RJwxh8kNDbUnotYAoGresBHYvFWI5Rr0y4dVMocgHaNnlNivArqZPHCnHwqQuqz7HHTLG2IccI50Ks0/xgwVdheDzE/ZPY8iqVI5DtH4qHmPrATRbsUZSlH1Pa9/7lf5e9FLju7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E6BC4CED6;
	Thu, 16 Jan 2025 19:17:55 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:18:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Michael Petlan <mpetlan@redhat.com>, Veronika
 Molnarova <vmolnaro@redhat.com>, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] tracing: gfp: Fix the GFP enum values shown for user
 space tracing tools
Message-ID: <20250116141800.31d519eb@gandalf.local.home>
In-Reply-To: <CAHk-=wiFEeyY5HE3NMvDYd254yHynzaQyzwYhv5gzRj7KU+gjA@mail.gmail.com>
References: <20250116132359.1f20cdec@gandalf.local.home>
	<CAHk-=wiFEeyY5HE3NMvDYd254yHynzaQyzwYhv5gzRj7KU+gjA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 11:00:20 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 16 Jan 2025 at 10:23, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > --- a/include/linux/gfp_types.h
> > +++ b/include/linux/gfp_types.h  
> 
> No - please do these somewhere else.
> 
> This header is included by *everything*.
> 
> Put it in some tracing header that isn't.
> 

But they are only defines, they are not created until used. Are you worried
that it will slow down the compile?

I wanted this to stay close to where they are crated so they can keep in
sync, and not break when something new is added.

Another way is to have something like:

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 4591a3e1711d..65c61c7b9f22 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -23,41 +23,66 @@ typedef unsigned int __bitwise gfp_t;
  * include/trace/events/mmflags.h and tools/perf/builtin-kmem.c
  */
 
-enum {
-	___GFP_DMA_BIT,
-	___GFP_HIGHMEM_BIT,
-	___GFP_DMA32_BIT,
-	___GFP_MOVABLE_BIT,
-	___GFP_RECLAIMABLE_BIT,
-	___GFP_HIGH_BIT,
-	___GFP_IO_BIT,
-	___GFP_FS_BIT,
-	___GFP_ZERO_BIT,
-	___GFP_UNUSED_BIT,	/* 0x200u unused */
-	___GFP_DIRECT_RECLAIM_BIT,
-	___GFP_KSWAPD_RECLAIM_BIT,
-	___GFP_WRITE_BIT,
-	___GFP_NOWARN_BIT,
-	___GFP_RETRY_MAYFAIL_BIT,
-	___GFP_NOFAIL_BIT,
-	___GFP_NORETRY_BIT,
-	___GFP_MEMALLOC_BIT,
-	___GFP_COMP_BIT,
-	___GFP_NOMEMALLOC_BIT,
-	___GFP_HARDWALL_BIT,
-	___GFP_THISNODE_BIT,
-	___GFP_ACCOUNT_BIT,
-	___GFP_ZEROTAGS_BIT,
+#define GFP_BITS_GENERAL			\
+	EM(DMA)					\
+	EM(HIGHMEM)				\
+	EM(DMA32)				\
+	EM(MOVABLE)				\
+	EM(RECLAIMABLE)				\
+	EM(HIGH)				\
+	EM(IO)					\
+	EM(FS)					\
+	EM(ZERO)				\
+	EM(UNUSED_BIT)				\
+	EM(DIRECT_RECLAIM)			\
+	EM(KSWAPD_RECLAIM)			\
+	EM(WRITE)				\
+	EM(NOWARN)				\
+	EM(RETRY_MAYFAIL)			\
+	EM(NOFAIL)				\
+	EM(NORETRY)				\
+	EM(MEMALLOC)				\
+	EM(COMP)				\
+	EM(NOMEMALLOC)				\
+	EM(HARDWALL)				\
+	EM(THISNODE)				\
+	EM(ACCOUNT)				\
+	EM(ZEROTAGS)
+
 #ifdef CONFIG_KASAN_HW_TAGS
-	___GFP_SKIP_ZERO_BIT,
-	___GFP_SKIP_KASAN_BIT,
+# define GFP_BITS_KASAN				\
+	EM(SKIP_ZERO)				\
+	EM(SKIP_KASAN)
+#else
+# define GFP_BITS_KASAN
 #endif
+
 #ifdef CONFIG_LOCKDEP
-	___GFP_NOLOCKDEP_BIT,
+# define GFP_BITS_LOCKDEP			\
+	EM(NOLOCKDEP)
+#else
+# define GFP_BITS_LOCKDEP
 #endif
+
 #ifdef CONFIG_SLAB_OBJ_EXT
-	___GFP_NO_OBJ_EXT_BIT,
+# define GFP_BITS_SLAB				\
+	EM(NO_OBJ_EXT)
+#else
+# define GFP_BITS_SLAB
 #endif
+
+# define GFP_BITS				\
+	GFP_BITS_GENERAL			\
+	GFP_BITS_KASAN				\
+	GFP_BITS_LOCKDEP			\
+	GFP_BITS_SLAB
+
+
+#undef EM
+#define EM(a)	___GFP_##a##_BIT,
+
+enum {
+	GFP_BITS
 	___GFP_LAST_BIT
 };
 

Then I could just use the GFP_BITS and redefine the EM() to add the
TRACE_DEFINE_ENUM() around them. Or something similar.

But I didn't think you would go for that.

-- Steve

