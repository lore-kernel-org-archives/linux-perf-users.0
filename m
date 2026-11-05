Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793861416;
	b=RRz47+Y+oao7NWw3C6l0FM2VTrbfS9nTpsP69xdwI0M+Dtx4jDxQn5SuA68bcKW9X0AW
	 HNAoA0SQUO/7QDjLY0HMn4t/sg9YWT9vRwvBls/RNIbkZwrjKw0/4ob97STN/qY5MANLN
	 mHLu7suSIotY5KH9OmZowz8t9cBYosQRzM1QsZMTzO74kAmYG6/wbwK8ohXShrtdx8P4H
	 BkDEyVctx2One/AGHA3DlW/l4BpWAk+OuSNrtuHMP0o3PtJA3s1D3zH1nnDfo4gR4QU+h
	 TKPbWPSH+7nuFpE4EPUGokccmZgfH6+Ps3A9HgRFfNbeDyb0qaTJJ1dHvuHC50gfRRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793861416;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Wx4D5SKaQKDDMgst/lPWwKj+nIgvX9YldD6DLcJmO0k=;
	b=iFeNb4525gtt0lSv3b2WhhHz0IaifFz7QLEbTpl7ScWzGSgctKScHz176Qy72bu6ChRm
	 Mzm26D38nA+rnBDxmxn6KjLcUnWirGAxqH1q3OzH4KihilDnkm7KntF/a64WpJ4/G8tOr
	 m+eXiax/Q9Vo9glkiwvQRoKcHZjSJHgaFir43hfX0NfIEAXupKCYYP0vBTNdM8QaJm8ta
	 KRWJWASY/ajramjvmYjIOJ6AKDRJxXFRhlK7hjss+1jYP/pveU/dyXIPDeKe0qq19nkXO
	 F5VStta+1uhTG9RYlVf4asZ7ZGay6Iv1HzEud4jo6dwRs11rX0w3N2OMAwmIOxUwxvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=FeUDfdD2;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F47C606A33A;
	Thu,  5 Nov 2026 06:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F47C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=FeUDfdD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=FeUDfdD2ywdC8qHnuL3yl2M7lIamQJcTx3jWsb4rThDGJ7KKGnhbBXuEXjR7bMc1iUvXaKXwnTouH
	 7GO63z1Ca6zLz5UBOSZcsZt7FahJVA0445/nfRxvNkjNdJBbvzYB9aw1PYmER4QC0t+t0kCT2Y79qQ
	 0Csgnk8qKljHBpFc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26aec2721171-dfb55;
	Thu, 05 Nov 2026 14:50:09 +0800 (CST)
X-RM-TRANSID:2ee26aec2721171-dfb55
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76aec2719718-3ed8a;
	Thu, 05 Nov 2026 14:50:09 +0800 (CST)
X-RM-TRANSID:2ee76aec2719718-3ed8a
From: Gu Bin <gubin@cmss.chinamobile.com>
To: acme@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf machine: Fix NULL deref in machine__is_lock_function()
Date: Thu,  5 Nov 2026 14:49:57 +0800
Message-ID: <20261105064958.2134-1-gubin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

machine__is_lock_function() looks up __sched_text_start and, if found,
assumes the remaining scheduler/lock text symbols are present too: it
dereferences sym->start for __sched_text_end, __lock_text_start and
__lock_text_end without a NULL check, under a "should not fail from
here" comment.

That assumption has already been broken in practice: on s390,
__sched_text_end shared its address with __cpuidle_text_start and
was dropped by symbols__fixup_duplicate(), causing a SIGSEGV in
"perf lock contention".
commit d8d85ce86dc8 ("perf lock contention: Fix core dump related to
not finding the "__sched_text_end" symbol on s/390") worked around
that particular case by keeping duplicate symbols via
symbol_conf.allow_aliases. The symbols can also be absent when the
kernel image has no lock text, or when the symbol table is otherwise
incomplete.

NULL-check each of the four lookups and share the existing failure
handling through a fail label that records the "failed to get kernel
symbols" state (machine->sched.text_start = 1), so the initialization
is only cached as complete when every lookup succeeded and later calls
bail out early without retrying the symbol lookups.

Fixes: 0d2997f750d1 ("perf lock: Look up callchain for the contended locks")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/perf/util/machine.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 076d167380f2..5eb5efa4eb90 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3324,22 +3324,25 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 		struct map *kmap;
 		struct symbol *sym = machine__find_kernel_symbol_by_name(machine, "__sched_text_start", &kmap);
 
-		if (!sym) {
-			/* to avoid retry */
-			machine->sched.text_start = 1;
-			return false;
-		}
+		if (!sym)
+			goto fail;
 
 		machine->sched.text_start = map__unmap_ip(kmap, sym->start);
 
 		/* should not fail from here */
 		sym = machine__find_kernel_symbol_by_name(machine, "__sched_text_end", &kmap);
+		if (!sym)
+			goto fail;
 		machine->sched.text_end = map__unmap_ip(kmap, sym->start);
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_start", &kmap);
+		if (!sym)
+			goto fail;
 		machine->lock.text_start = map__unmap_ip(kmap, sym->start);
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_end", &kmap);
+		if (!sym)
+			goto fail;
 		machine->lock.text_end = map__unmap_ip(kmap, sym->start);
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__traceiter_contention_begin", &kmap);
@@ -3380,6 +3383,11 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 	}
 
 	return false;
+
+fail:
+	/* failed to get kernel symbols, to avoid retry */
+	machine->sched.text_start = 1;
+	return false;
 }
 
 int machine__hit_all_dsos(struct machine *machine)
-- 
2.55.0.windows.3



