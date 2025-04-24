Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D539B292935;
	Thu, 24 Apr 2025 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522657; cv=none; b=TuJ8Px38LwT0i6C6vvfkI/b51KsoWUrnJp5KjHb83LDEa6fq9jA5WRCnAkL4CXO3LA4igf1w6K1ABf8tKQq9PyNTH0M5NJyNzOM+J+7tdk25sefdWB5muu3pI94sGCnnMHtqTpU8RIzKDIhl0SlQcL31/IEWaAtPZLeYVI0HrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522657; c=relaxed/simple;
	bh=dfMNrL0VGe5/RSdy86NJBFdTFayMrVUvzrtLKBAtJ7I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BvCL8AG9RMQlNewtse/Z6Dmt9f1Yi+PQqhYnajea7FmouIe49kUVyLChgyqUVloZ0aQQyoO8ijrngVGPxvyOPS1/jhIwf3g/ohLNo9EMBtL1BP3MZhZ4w0vPp4jEiHhlqbxKO5T55YeWy76YfXwrExgSPHxPr2CD7bcCt7pA+fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66496C4AF12;
	Thu, 24 Apr 2025 19:24:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u82D7-0000000H2Rf-2peF;
	Thu, 24 Apr 2025 15:26:13 -0400
Message-ID: <20250424192613.526636593@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 15:25:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org,
 Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>,
 Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Alexander Aring <aahringo@redhat.com>
Subject: [PATCH v5 7/9] mm: Add guard for mmap_read_lock
References: <20250424192456.851953422@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

This is the new way of doing things.  Converting all existing
mmap_read_lock users is an exercise left for the reader ;-)

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/mmap_lock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 4706c6769902..cfa5ab84054a 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -222,4 +222,6 @@ static inline int mmap_lock_is_contended(struct mm_struct *mm)
 	return rwsem_is_contended(&mm->mmap_lock);
 }
 
+DEFINE_GUARD(mmap_read_lock, struct mm_struct *, mmap_read_lock(_T), mmap_read_unlock(_T))
+
 #endif /* _LINUX_MMAP_LOCK_H */
-- 
2.47.2


