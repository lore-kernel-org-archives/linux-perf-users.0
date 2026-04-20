Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5A277035
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676607; cv=none; b=VP/cLw+5tQKLbFWf4zHCIUIKW4urb9g540VU4hqb73E9xm8DY1f1OJ50oNq2s3o/YN3wl84NKsGp+0NlMW7VFu9lY4ezkxg83v/ci3I9pEuv+VJxWeIRStFH/4y0TGJoo3Sk2lG/9hthGWEvxY4gqCEupeY8PSfL+LLYbUnJgpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676607; c=relaxed/simple;
	bh=0u7s7OdRRqv5aE5o36d3vPC5dHuzyC07aujDS6QjbK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7L8VMW9lX6+zGHfDieqqWPLRicejwAOlQ047fS2ZAkrQiJDPsLtohfvCPfmkJ7TQMTt8W3kWOrss9nehjNVJoif3SQPiq6jRyGad5FTu41J65rC5chTQKsrU82UBl3mM1ObmmUSzszLmLFh2aB6Y1Km9QAzkgrRM7gw4KKZbdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dUpFezg5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dUpFezg5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dUpFezg5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dUpFezg5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D4625BD1B;
	Mon, 20 Apr 2026 09:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1776676604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CQVMt/nwmvdC4aLWh2feF4IWYAWPMMt31/pIymKulAc=;
	b=dUpFezg5BYtaT/06Ap1bKCGQDZ9j+tzwjh0AkwNjvSIP/+KFwk4hJyj8L09wAKjtSPohzg
	CKOyuYJE3iqxkF2x7rb7bQlQdpAimcydS249IG4Hsaqlab9g1WftdIfXvGPSw3F4zudy/S
	dsk8cd7b76Mczp1CWHJa9jrscaLFK2w=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dUpFezg5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1776676604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CQVMt/nwmvdC4aLWh2feF4IWYAWPMMt31/pIymKulAc=;
	b=dUpFezg5BYtaT/06Ap1bKCGQDZ9j+tzwjh0AkwNjvSIP/+KFwk4hJyj8L09wAKjtSPohzg
	CKOyuYJE3iqxkF2x7rb7bQlQdpAimcydS249IG4Hsaqlab9g1WftdIfXvGPSw3F4zudy/S
	dsk8cd7b76Mczp1CWHJa9jrscaLFK2w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5828593AE;
	Mon, 20 Apr 2026 09:16:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lAcLM/vu5Wm3PQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 20 Apr 2026 09:16:43 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
Date: Mon, 20 Apr 2026 11:16:28 +0200
Message-ID: <20260420091634.128787-1-jgross@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	URIBL_BLOCKED(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 4D4625BD1B
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

This is a RFC for renaming the main MSR access functions. The main
motivations for doing that are:

- Prepare for wide spread use cases of WRMSRNS by making it easily
  visible whether a MSR write is serializing or not. This has the
  advantage that new use cases of MSR writes would need to decide
  whether a serializing MSR write is needed or not. Using today's
  MSR write interfaces would probably result in most new use cases
  to use the serializing form, having a negative performance impact.

- Use functions instead of macros for accessing MSRs, which will drop
  modifying variables passed as a parameter.

- Eliminate multiple accessors doing exactly the same thing (e.g.
  rdmsrl() and rdmsrq()).

- Instead of having function names based on the underlying instruction
  mnemonics, have functions of a common name space (msr_*()).

This series is containing only a needed prerequisite patch removing a
name collision with the new access functions, 3 patches introducing
the new access functions, and 2 example patches adapting users to use
the new functions instead the old ones.

I have selected the 2 example patches based on the needed code changes:

Patch 5 is very simple, because all the changes are really trivial.
While using a mixture of serializing and non-serializing MSR writes,
the non-serializing form is used only in case another MSR write is
following in the same function, resulting in each function doing MSR
writes having still serializing semantics (it might be possible to
change that later, but I wanted to be conservative just in case).

Patch 6 is a little bit less simple, as there are a couple of cases
where the new functions are no direct replacements of the old
interfaces. The new functions only work on 64-bit values, so in cases
where 2 32-bit values are needed, "struct msr" is used as a conversion
layer. I thought about adding macros for the same purpose, but in the
end this seemed to be a more simple and readable solution.

In case the general idea is accepted, I'd do the conversion of the rest
of the users (this will be probably a rather large, but mostly trivial
series).

As this series is RFC, I have done only basic compile testing.

Juergen Gross (6):
  x86/msr: Rename msr_read() and msr_write()
  x86/msr: Create a new minimal set of local MSR access functions
  x86/msr: Create a new minimal set of inter-CPU MSR access functions
  x86/msr: Rename the *_safe_regs[_on_cpu]() MSR functions
  x86/events: Switch core parts to use new MSR access functions
  x86/cpu/mce: Switch code to use new MSR access functions

 arch/x86/events/core.c            |  42 ++++++-------
 arch/x86/events/msr.c             |   2 +-
 arch/x86/events/perf_event.h      |  26 ++++----
 arch/x86/events/probe.c           |   2 +-
 arch/x86/events/rapl.c            |   8 +--
 arch/x86/include/asm/msr.h        |  87 ++++++++++++++++++++++---
 arch/x86/kernel/cpu/amd.c         |   4 +-
 arch/x86/kernel/cpu/mce/amd.c     | 101 +++++++++++++++---------------
 arch/x86/kernel/cpu/mce/core.c    |  18 +++---
 arch/x86/kernel/cpu/mce/inject.c  |  40 ++++++------
 arch/x86/kernel/cpu/mce/intel.c   |  32 +++++-----
 arch/x86/kernel/cpu/mce/p5.c      |  16 ++---
 arch/x86/kernel/cpu/mce/winchip.c |  10 +--
 arch/x86/kernel/msr.c             |  16 ++---
 arch/x86/lib/msr-reg-export.c     |   4 +-
 arch/x86/lib/msr-reg.S            |  16 ++---
 arch/x86/lib/msr-smp.c            |  20 +++---
 arch/x86/lib/msr.c                |  12 ++--
 18 files changed, 263 insertions(+), 193 deletions(-)

-- 
2.53.0

