Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664CC198A0D;
	Thu, 16 Jan 2025 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063872; cv=none; b=bGGzBvNmiUudXO8Tv+Kkm9A9F0Z1up7zCKqhUhXsOVP+3oFT6gz/uAKkHXYc08GtKeXrBweX687GrWMI6oAW5G94+6UlFqZ5NwoNhhv0f47WvwrhWVhhsxkdAuOfkg33lP8w6oIuZQ9GB1mEAS+pwGi+r1gH9UQ0hjLpMPxfDBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063872; c=relaxed/simple;
	bh=WQjUiQ2ufFWq7U+Kvjd6tTLRkvJdz19mR2F/dtojoUY=;
	h=Message-ID:Date:From:To:Cc:Subject; b=HSXQWlSct1ojxmJWbneVbZ2oiF3OXC/SyY9qx5c0+Iqx7jlB4GLBHAYjxgkRzTeQOkE1jAyg4iN12N/BHEWeIcU57FOzkjB16Xx39v/rIhCauGqpnWmDVbkP5k8n7h5wYRuBNHClPMZw2Nj+tap9Jt2h+8+9jktyUKwwdJHBoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB48EC4CED6;
	Thu, 16 Jan 2025 21:44:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tYXfK-00000000yxc-2opM;
	Thu, 16 Jan 2025 16:44:38 -0500
Message-ID: <20250116214123.917928229@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 16 Jan 2025 16:41:23 -0500
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
Subject: [PATCH v2 0/2] tracing: gfp: Fix regression of printing GFP flags in user space tracing tooling
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>


This fixes a regression that was brought up last year[1], but due
to missing a response it was forgotten about.

The commit 772dd0342727c ("mm: enumerate all gfp flags") introduced
usage of enums in creating of the __GFP_* flags. But enums are not
converted to their values like macros are in the trace event format
files that are exported to user space to allow tools to properly parse
the raw binary events. This broke the parsing of gfp flags.

Instead of having something like:

  gfp_flags=GFP_HIGHUSER_MOVABLE|__GFP_COMP

It would just have a raw hex value:

  gfp_flags=0x140cca

Which is mostly useless or hard to decipher.

Instead of reverting the enums into macros, use the TRACE_DEFINE_ENUM()
macro that informs the tracing subsystem about enums and it converts them
to their proper values.

The first patch is a fix that fixes the regression and should go into
the current rc release as well as be backported to stable.

The second patch is a clean up that removes duplication of the GFP flags
in the macros of mmflags.h and should be added in the coming merge window.

I kept the two together so that one can see why the solution to the first
patch was made. The use of TRACE_GFP_EM() internally was added to make
it easier to reuse the TRACE_GFP_FLAGS macro.

Changes since v1: https://lore.kernel.org/20250116132359.1f20cdec@gandalf.local.home

- Moved the updates to only include/trace/events/mmflags.h

- Removed the macro call in include/trace/events/kmem.h

- Use an internal TRACE_GFP_EM() macro in TRACE_GFP_FLAGS to allow
  it to be expanded later for use with the __def_gfpflags_names()
  macro

- Added the second non critical patch to show he clean up of removing
  duplicate defines of the ___GFP_*_BITs. 

[1] https://lore.kernel.org/all/87be5f7c-1a0-dad-daa0-54e342efaea7@redhat.com/

Steven Rostedt (2):
      tracing: gfp: Fix the GFP enum values shown for user space tracing tools
      tracing: gfp: Remove duplication of recording GFP flags

----
 include/trace/events/mmflags.h | 104 +++++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 31 deletions(-)
