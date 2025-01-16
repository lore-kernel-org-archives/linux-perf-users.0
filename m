Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0723F263;
	Thu, 16 Jan 2025 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063872; cv=none; b=bt0mNaRTGpx3FJ3NeEaA/8mPj8XM/dW2E8TzHX90J8rwAz35xO5LkjFMa8saWed5124xh/PqvN+e8VOWSTHc4oAq0ZRtmkZVS5tP4mj7gxbKEkb3Wx8SZZ46pHjlJ4HNnBc+qSuwvto2ZFJwNIEWz8R4h8QhEhw7rilIK2eVKhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063872; c=relaxed/simple;
	bh=kv3ukfpLdeb4tkJ53CInIfhpqO2FDjUljwUBfqXdroQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Z2s0x705iUZlVbyTDl/7RGWC+v+xKP8rPiKfLwMPXTNnuXalN5q8y8QBrCuQIVMQQ4YarTWsuo7RmMSZpfJ2geh/FV6WVW28ltztEPM/RJkRLckxSupGA1Ay52Y1eUQA0Qg7RERRwNimYGf9yQo1FQyQJQ3zvV3wEEjJtW7MBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C79C4CEE3;
	Thu, 16 Jan 2025 21:44:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tYXfL-00000000yyx-17tJ;
	Thu, 16 Jan 2025 16:44:39 -0500
Message-ID: <20250116214439.046082618@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 16 Jan 2025 16:41:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Petlan <mpetlan@redhat.com>,
 Veronika  Molnarova <vmolnaro@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 2/2] tracing: gfp: Remove duplication of recording GFP flags
References: <20250116214123.917928229@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The gfp_flags when recorded in the trace require being converted from
their numbers to values. Various macros are used to help facilitate this,
but there's two sets of macros that need to keep track of the same GFP
flags to stay in sync.

The TRACE_GFP_FLAGS macro holds the enum ___GFP_*_BIT defined bits, and
creates the TRACE_DEFINE_ENUM() wrapper around them.

The __def_gfpflag_names() macro creates the mapping of various flags or
multiple flags to give them human readable names via the __print_flags()
tracing helper macro.

As the TRACE_GFP_FLAGS is a subset of the __def_gfpflags_names(), it can
be used to cover the individual bit names, by redefining the internal
macro TRACE_GFP_EM():

  #undef TRACE_GFP_EM
  #define TRACE_GFP_EM(a) gfpflag_string(__GFP_##a),

This will remove the bits that are duplicate between the two macros. If a
new bit is created, only the TRACE_GFP_FLAGS needs to be updated and that
will also update the __def_gfpflags_names() macro.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/mmflags.h | 41 +++++++++-------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index d36c857dd249..8cabdce23a62 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -78,6 +78,13 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 
 #define gfpflag_string(flag) {(__force unsigned long)flag, #flag}
 
+/*
+ * For the values that match the bits, use the TRACE_GFP_FLAGS
+ * which will allow any updates to be included automatically.
+ */
+#undef TRACE_GFP_EM
+#define TRACE_GFP_EM(a) gfpflag_string(__GFP_##a),
+
 #define __def_gfpflag_names			\
 	gfpflag_string(GFP_TRANSHUGE),		\
 	gfpflag_string(GFP_TRANSHUGE_LIGHT),	\
@@ -91,41 +98,13 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 	gfpflag_string(GFP_NOIO),		\
 	gfpflag_string(GFP_NOWAIT),		\
 	gfpflag_string(GFP_DMA),		\
-	gfpflag_string(__GFP_HIGHMEM),		\
 	gfpflag_string(GFP_DMA32),		\
-	gfpflag_string(__GFP_HIGH),		\
-	gfpflag_string(__GFP_IO),		\
-	gfpflag_string(__GFP_FS),		\
-	gfpflag_string(__GFP_NOWARN),		\
-	gfpflag_string(__GFP_RETRY_MAYFAIL),	\
-	gfpflag_string(__GFP_NOFAIL),		\
-	gfpflag_string(__GFP_NORETRY),		\
-	gfpflag_string(__GFP_COMP),		\
-	gfpflag_string(__GFP_ZERO),		\
-	gfpflag_string(__GFP_NOMEMALLOC),	\
-	gfpflag_string(__GFP_MEMALLOC),		\
-	gfpflag_string(__GFP_HARDWALL),		\
-	gfpflag_string(__GFP_THISNODE),		\
-	gfpflag_string(__GFP_RECLAIMABLE),	\
-	gfpflag_string(__GFP_MOVABLE),		\
-	gfpflag_string(__GFP_ACCOUNT),		\
-	gfpflag_string(__GFP_WRITE),		\
 	gfpflag_string(__GFP_RECLAIM),		\
-	gfpflag_string(__GFP_DIRECT_RECLAIM),	\
-	gfpflag_string(__GFP_KSWAPD_RECLAIM),	\
-	gfpflag_string(__GFP_ZEROTAGS)
-
-#ifdef CONFIG_KASAN_HW_TAGS
-#define __def_gfpflag_names_kasan ,			\
-	gfpflag_string(__GFP_SKIP_ZERO),		\
-	gfpflag_string(__GFP_SKIP_KASAN)
-#else
-#define __def_gfpflag_names_kasan
-#endif
+	TRACE_GFP_FLAGS				\
+	{ 0, "none" }
 
 #define show_gfp_flags(flags)						\
-	(flags) ? __print_flags(flags, "|",				\
-	__def_gfpflag_names __def_gfpflag_names_kasan			\
+	(flags) ? __print_flags(flags, "|", __def_gfpflag_names		\
 	) : "none"
 
 #ifdef CONFIG_MMU
-- 
2.45.2


