Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA2272E7F;
	Wed, 20 Aug 2025 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713066; cv=none; b=pNuR9q3xFRfK6Gfpb/7m0cpHAOXbAzk+wcRFyV2tAc8ZHJuM3RHfNeznyurMokRZhHI9q3NdKTvbs+vvXBsTEYSh2coexRzayjgerrezRQgxQ/DZX9ccuS329e+EtMa39k5WpGtdJsLQbfm30/8EseTJ2fMbQyWuKmeR52n7LKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713066; c=relaxed/simple;
	bh=ZPPxOS8JJqyE2lskJsv5zWXilVEAeOpsd6+esNUD/68=;
	h=Message-ID:Date:From:To:Cc:Subject; b=hb6W6vDT8uXf6vSmlQyqBiX8cC4EUlniFrz82MiUCuW1NHOh6eCFAlmNuytENKr8shm/iWD1HfLzxMmvvQtMtCzdf2JwgMSrd+yckohVe7JiwCupHI5/gVMI0Yv2fKF7qjp9GLJ0qjDgb43lgQPiaWi5Z1KcwRrsH0Usn71zCjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ui72LFHT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ui72LFHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D32C113CF;
	Wed, 20 Aug 2025 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755713065;
	bh=ZPPxOS8JJqyE2lskJsv5zWXilVEAeOpsd6+esNUD/68=;
	h=Date:From:To:Cc:Subject:From;
	b=ui72LFHTrEyucOAjH+63pKF0+H1jsbQ8U33Fmgd4fMFTN8T8HXJHe8NCezt7EWAdq
	 ajkFxidjQ11PqkYivi6WFoF3qUPbfSCLmU7UvXiwWbACMuXZ/+c3wkJuMx9H2sANgs
	 euXL2XPa0sFyJTSmbOQiyGwb6OBfvMBxeZsbb2rQaC1PDliXkwktTmqBV6JApA1rD5
	 xLR7EQgBV0FZxONrjA49bQlqkUFh6SgYeDJJL/zj8FRq3kbpPC6P0j4GeTHzS6KlrT
	 mCwft/S798JmV3uTv8IcucaZmP1QpFTwoyuC+fMVDfRb6nBD7Smg6CGJGxDJSR45i3
	 N5sqLnC3sUf1A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uonAi-00000000rsk-0y1X;
	Wed, 20 Aug 2025 14:04:28 -0400
Message-ID: <20250820180338.701352023@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 20 Aug 2025 14:03:38 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [RESEND][PATCH 0/5] perf: Clean ups and simplifications
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>


This is a resend from: https://lore.kernel.org/linux-trace-kernel/20250717173125.434618999@kernel.org/

It cleanly applied on top of the latest tip/perf/core:
  448f97fba901 ("perf: Convert mmap() refcounts to refcount_t")

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
