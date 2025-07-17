Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D826A1DE3C3;
	Thu, 17 Jul 2025 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773592; cv=none; b=QVtXq6PRigQr1PtHZeptgbS4EMWSP4G62HrZ2awrJeLbpoJlGnFX/pYH2NEogr26U5lf9KBXlmkfLIhFvRVCVA5Y43aPYl6nkakyp7QLfFJQg4XitRKkJA0BvNKvef4rDbQk7mr0hEAnLa5pzm+oml85Z1IIlGnUzlIblHbhSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773592; c=relaxed/simple;
	bh=5ww42+z0hrYgJWDwtISdtP7O2Lue96TDBbDXwkzJlfM=;
	h=Message-ID:Date:From:To:Cc:Subject; b=kVRA3dLN8nMnhzfQHI4NQ9O5E1sgpZ3CE9+IL4HdAvhqV9znkiJ2uHrTbUuh9ntEh+/s40DlCzW/XhDDwgCICicdlUSNFf/aSGuu4cFEh/miYwUeyys/tMNapOThilkAoq0mHfi+LW7Xrm2fjs4iYv90424lj348E11yuEeGh90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jocQDJiX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jocQDJiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6C1C4CEE3;
	Thu, 17 Jul 2025 17:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752773591;
	bh=5ww42+z0hrYgJWDwtISdtP7O2Lue96TDBbDXwkzJlfM=;
	h=Date:From:To:Cc:Subject:From;
	b=jocQDJiXqYkFkrd1N/aldlpaPHubjSZ24uTn7z8KLkSNZAsjWWr/FfZfQAYMROLAV
	 kzo2z/NM5KUgYw/CecnkCSZn/50YradhW4ReVtgXv1BdTIQ13xNRf5r2M7rM4Nll5b
	 cRf9tw+vf1Ud9sW47ZrG6nKoh5C0Vy6t4O066kxDlyEA3EdxNUt0ewY5AM+BbfKVq1
	 I0VCltg1pGAeJLKdaNlDFbxtIITIrgabsgUZ8PH+jK6lIcQjvKyLvBseAZWir9c8BH
	 7pSvlAkjtzcOmk7VeVZA6cMJQ1SHBA7x27I8PTvvKxzqlQKyw/ysm2xsaCyhtegqcY
	 /fFwU9NGTr87A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucSU9-00000006byE-0T8v;
	Thu, 17 Jul 2025 13:33:33 -0400
Message-ID: <20250717173125.434618999@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 17 Jul 2025 13:31:25 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jens Axboe <axboe@kernel.dk>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/5] perf: Clean ups and simplifications
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>


The ongoing work to support sframes[1] in the kernel required a few clean ups
to the perf kernel side. Instead of having these changes in the ongoing
work, there's no reason they cannot be applied now.

These are just clean ups to the perf code to help simplify the updates that
will be made later.

[1] https://lore.kernel.org/linux-trace-kernel/20250708020003.565862284@kernel.org

Josh Poimboeuf (4):
      perf: Remove get_perf_callchain() init_nr argument
      perf: Have get_perf_callchain() return NULL if crosstask and user are set
      perf: Simplify get_perf_callchain() user logic
      perf: Skip user unwind if the task is a kernel thread

Steven Rostedt (1):
      perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL

----
 include/linux/perf_event.h |  2 +-
 kernel/bpf/stackmap.c      |  4 ++--
 kernel/events/callchain.c  | 40 +++++++++++++++++++---------------------
 kernel/events/core.c       |  9 +++++----
 4 files changed, 27 insertions(+), 28 deletions(-)
