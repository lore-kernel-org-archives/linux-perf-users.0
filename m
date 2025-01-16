Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64379139CFF;
	Thu, 16 Jan 2025 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051835; cv=none; b=EFzLqh3q6tGG2qCxDcK5WiWqPC9+T6PkFNZ4c6Dx36Bku4oUkI1Zdpey9tTBRK2bnDjel9mtrzMIyWDh0NS51g/Esd4YJuCUWmfVDcKkjj8WSWM2WRxvxlT1lvBwM2H8e4WYZ4EeRcatLvLkRG1JCJt+QscyPbHS0gCMoNyeR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051835; c=relaxed/simple;
	bh=9jLlGWE5R6qRiPuUFWH0LyBDz6L1DSm74odLKmg/PAk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LOweObqXt+iz3nLRQw10SV5bjqeVHWfC+pFVWX98+MsT0Rsz4fbQkhrXn/I+hp7r3aIYx14KKB0ipPW8dfoqHbC2kVfq8XJ+V0nIErNtpy/A7inAt7fTEWyf6B/Qa8oS+KqlNMWklbef8WFmJ2QemfpQ/iTmWmL5C1WmyIr13v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B31C4CED6;
	Thu, 16 Jan 2025 18:23:53 +0000 (UTC)
Date: Thu, 16 Jan 2025 13:23:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Michael Petlan <mpetlan@redhat.com>, Veronika
 Molnarova <vmolnaro@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] tracing: gfp: Fix the GFP enum values shown for user space
 tracing tools
Message-ID: <20250116132359.1f20cdec@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

Tracing tools like perf and trace-cmd read the /sys/kernel/tracing/events/*/*/format
files to know how to parse the data and also how to print it. For the
"print fmt" portion of that file, if anything uses an enum that is not
exported to the tracing system, user space will not be able to parse it.

The GFP flags use to be defines, and defines get translated in the print
fmt sections. But now they are converted to use enums, which is not.

The mm_page_alloc trace event format use to have:

  print fmt: "page=%p pfn=0x%lx order=%d migratetype=%d gfp_flags=%s",
    REC->pfn != -1UL ? (((struct page *)vmemmap_base) + (REC->pfn)) : ((void
    *)0), REC->pfn != -1UL ? REC->pfn : 0, REC->order, REC->migratetype,
    (REC->gfp_flags) ? __print_flags(REC->gfp_flags, "|", {( unsigned
    long)(((((((( gfp_t)(0x400u|0x800u)) | (( gfp_t)0x40u) | (( gfp_t)0x80u) |
    (( gfp_t)0x100000u)) | (( gfp_t)0x02u)) | (( gfp_t)0x08u) | (( gfp_t)0)) |
    (( gfp_t)0x40000u) | (( gfp_t)0x80000u) | (( gfp_t)0x2000u)) & ~((
    gfp_t)(0x400u|0x800u))) | (( gfp_t)0x400u)), "GFP_TRANSHUGE"}, {( unsigned
    long)((((((( gfp_t)(0x400u|0x800u)) | (( gfp_t)0x40u) | (( gfp_t)0x80u) |
    (( gfp_t)0x100000u)) | (( gfp_t)0x02u)) | (( gfp_t)0x08u) | (( gfp_t)0)) ...

Where the GFP values are shown and not their names. But after the GFP
flags were converted to use enums, it has:

  print fmt: "page=%p pfn=0x%lx order=%d migratetype=%d gfp_flags=%s",
    REC->pfn != -1UL ? (vmemmap + (REC->pfn)) : ((void *)0), REC->pfn != -1UL
    ? REC->pfn : 0, REC->order, REC->migratetype, (REC->gfp_flags) ?
    __print_flags(REC->gfp_flags, "|", {( unsigned long)((((((((
    gfp_t)(((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))|((((1UL))) <<
    (___GFP_KSWAPD_RECLAIM_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_IO_BIT)))
    | (( gfp_t)((((1UL))) << (___GFP_FS_BIT))) | (( gfp_t)((((1UL))) <<
    (___GFP_HARDWALL_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_HIGHMEM_BIT))))
    | (( gfp_t)((((1UL))) << (___GFP_MOVABLE_BIT))) | (( gfp_t)0)) | ((
    gfp_t)((((1UL))) << (___GFP_COMP_BIT))) ...

Where the enums names like ___GFP_KSWAPD_RECLAIM_BIT are shown and not their
values. User space has no way to convert these names to their values and
the output will fail to parse. What is shown is now:

  mm_page_alloc:  page=0xffffffff981685f3 pfn=0x1d1ac1 order=0 migratetype=1 gfp_flags=0x140cca

The TRACE_DEFINE_ENUM() macro was created to handle enums in the print fmt
files. This causes them to be replaced at boot up with the numbers, so
that user space tooling can parse it. By using this macro, the output is
back to the human readable:

  mm_page_alloc: page=0xffffffff981685f3 pfn=0x122233 order=0 migratetype=1 gfp_flags=GFP_HIGHUSER_MOVABLE|__GFP_COMP

Cc: stable@vger.kernel.org
Reported-by: Michael Petlan <mpetlan@redhat.com>
Closes: https://lore.kernel.org/all/87be5f7c-1a0-dad-daa0-54e342efaea7@redhat.com/
Fixes: 772dd0342727c ("mm: enumerate all gfp flags")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/gfp_types.h      | 47 ++++++++++++++++++++++++++++++++++
 include/trace/events/kmem.h    |  2 ++
 include/trace/events/mmflags.h |  2 ++
 3 files changed, 51 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 65db9349f905..57efa0310900 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -104,6 +104,53 @@ enum {
 #define ___GFP_NO_OBJ_EXT       0
 #endif
 
+/* Need to have GFP flags convert to numbers in trace event format files */
+#define TRACE_DEFINE_GFP_FLAGS_GENERAL			\
+	TRACE_DEFINE_ENUM(___GFP_DMA_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_HIGHMEM_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_DMA32_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_MOVABLE_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_RECLAIMABLE_BIT);	\
+	TRACE_DEFINE_ENUM(___GFP_HIGH_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_IO_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_FS_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_ZERO_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_UNUSED_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_DIRECT_RECLAIM_BIT);	\
+	TRACE_DEFINE_ENUM(___GFP_KSWAPD_RECLAIM_BIT);	\
+	TRACE_DEFINE_ENUM(___GFP_WRITE_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_NOWARN_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_RETRY_MAYFAIL_BIT);	\
+	TRACE_DEFINE_ENUM(___GFP_NOFAIL_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_NORETRY_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_MEMALLOC_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_COMP_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_NOMEMALLOC_BIT);	\
+	TRACE_DEFINE_ENUM(___GFP_HARDWALL_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_THISNODE_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_ACCOUNT_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_ZEROTAGS_BIT);		\
+	TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
+
+#ifdef CONFIG_KASAN_HW_TAGS
+# define TRACE_DEFINE_GFP_FLAGS_KASAN			\
+	TRACE_DEFINE_ENUM(___GFP_SKIP_ZERO_BIT);	\
+	TRACE_DEFINE_ENUM(___GFP_SKIP_KASAN_BIT);
+#else
+# define TRACE_DEFINE_GFP_FLAGS_KASAN
+#endif
+#ifdef CONFIG_LOCKDEP
+# define TRACE_DEFINE_GFP_FLAGS_LOCKDEP			\
+	TRACE_DEFINE_ENUM(___GFP_NOLOCKDEP_BIT);
+#else
+# define TRACE_DEFINE_GFP_FLAGS_LOCKDEP
+#endif
+
+#define TRACE_DEFINE_GFP_FLAGS			\
+	TRACE_DEFINE_GFP_FLAGS_GENERAL		\
+	TRACE_DEFINE_GFP_FLAGS_KASAN		\
+	TRACE_DEFINE_GFP_FLAGS_LOCKDEP
+
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
  *
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index b37eb0a7060f..e32098c0f187 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -9,6 +9,8 @@
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
 
+TRACE_DEFINE_GFP_FLAGS
+
 TRACE_EVENT(kmem_cache_alloc,
 
 	TP_PROTO(unsigned long call_site,
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index bb8a59c6caa2..522bbe3a5fe1 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -15,6 +15,8 @@
 
 #define gfpflag_string(flag) {(__force unsigned long)flag, #flag}
 
+TRACE_DEFINE_GFP_FLAGS
+
 #define __def_gfpflag_names			\
 	gfpflag_string(GFP_TRANSHUGE),		\
 	gfpflag_string(GFP_TRANSHUGE_LIGHT),	\
-- 
2.45.2

