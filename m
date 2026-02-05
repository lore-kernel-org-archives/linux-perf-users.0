Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419DD3A9D83
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289113; cv=none; b=OWYkUjnyIzGIwleUz4l2OL+cPQjf3tRGmvr29dKLr9MmB9Ig5zS68aGQnzKzp1NNbYMYmn1QcoiG4f/rs/aEZXUmq8DuZVDna010GG5ViLdy1ODwIan2VJlEXG4X6pU1DUnW4MKawloKXP+ZAoEqEDwbg6f+Jx/zZaok9AxrbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289113; c=relaxed/simple;
	bh=573tJg47wVhIcULvX5ZwSjIgw9jvNX+FISFCDQXxSQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eHvV1y31ec2REt7blZLX7XmJiHE5Raew3izbX0gxC1FPijKyf4rXabcNctfwEvRzTonzGwL/mruOnVXQwJZtkJTuKhUNkZQWsD0Cwiqpu5vij82dC1qygo7sSdf9EwXwT1thKmaRfXszEPz39+3uNjFoC5yyNo1d20v0Jq0OdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jl4cZyeg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6okSlGZ7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jl4cZyeg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6okSlGZ7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jl4cZyeg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6okSlGZ7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jl4cZyeg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6okSlGZ7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B73295BD8E;
	Thu,  5 Feb 2026 10:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770289105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gPIduljmZXCIWAQ9DidbUQdmBn0Lyb8HiV/il4JNxcQ=;
	b=jl4cZyegDIFWiWUKUmCdDJPC+w/xh1bd9LmsPv0WonczlxM/7IUGa+uaDJLSeOBV5/G6Z/
	Sv8zmlB8TklsXl0sq/IjtGnwFUaoDBqYt5mngHjB7htg284uZR3AT2MuDi9t0Ogezaqnsv
	EX2wHvEi48e3ga/MrkiqEAHUeuSgKlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770289105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gPIduljmZXCIWAQ9DidbUQdmBn0Lyb8HiV/il4JNxcQ=;
	b=6okSlGZ7NhjUaRHG8x6X1WyjTBvlw0hWEi6ZLnHguA6iXzZA4RTqt2m/QRvckl7QYaiSQ/
	Xw/qDPq/KFOkh2CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jl4cZyeg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6okSlGZ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770289105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gPIduljmZXCIWAQ9DidbUQdmBn0Lyb8HiV/il4JNxcQ=;
	b=jl4cZyegDIFWiWUKUmCdDJPC+w/xh1bd9LmsPv0WonczlxM/7IUGa+uaDJLSeOBV5/G6Z/
	Sv8zmlB8TklsXl0sq/IjtGnwFUaoDBqYt5mngHjB7htg284uZR3AT2MuDi9t0Ogezaqnsv
	EX2wHvEi48e3ga/MrkiqEAHUeuSgKlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770289105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gPIduljmZXCIWAQ9DidbUQdmBn0Lyb8HiV/il4JNxcQ=;
	b=6okSlGZ7NhjUaRHG8x6X1WyjTBvlw0hWEi6ZLnHguA6iXzZA4RTqt2m/QRvckl7QYaiSQ/
	Xw/qDPq/KFOkh2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D234F3EA63;
	Thu,  5 Feb 2026 10:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l0aXMNB3hGmRJQAAD6G6ig
	(envelope-from <clopez@suse.de>); Thu, 05 Feb 2026 10:58:24 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org (open list:UPROBES)
Subject: [PATCH] uprobes: replace deprecated kmap_atomic() with kmap_local_page()
Date: Thu,  5 Feb 2026 11:57:25 +0100
Message-ID: <20260205105725.298340-1-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.51
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B73295BD8E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

kmap_atomic() has been deprecated for a few years, and kmap_local_page()
should be used instead, so replace it. Since the uprobes code relied on
kmap_atomic() disabling page faults to access user pages, add the
required calls to keep the existing behavior.

Signed-off-by: Carlos López <clopez@suse.de>
---
 kernel/events/uprobes.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d546d32390a8..38898435acfe 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -179,16 +179,24 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
 
 void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
 {
-	void *kaddr = kmap_atomic(page);
+	void *kaddr = kmap_local_page(page);
+
+	pagefault_disable();
 	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
-	kunmap_atomic(kaddr);
+	pagefault_enable();
+
+	kunmap_local(kaddr);
 }
 
 static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
 {
-	void *kaddr = kmap_atomic(page);
+	void *kaddr = kmap_local_page(page);
+
+	pagefault_disable();
 	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
-	kunmap_atomic(kaddr);
+	pagefault_enable();
+
+	kunmap_local(kaddr);
 }
 
 static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *insn,
@@ -323,9 +331,10 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
 		return ret == 0 ? -EBUSY : ret;
 	}
 
-	kaddr = kmap_atomic(page);
+	kaddr = kmap_local_page(page);
 	ptr = kaddr + (vaddr & ~PAGE_MASK);
 
+	pagefault_disable();
 	if (unlikely(*ptr + d < 0)) {
 		pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
 			"curr val: %d, delta: %d\n", vaddr, *ptr, d);
@@ -336,7 +345,8 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
 	*ptr += d;
 	ret = 0;
 out:
-	kunmap_atomic(kaddr);
+	pagefault_enable();
+	kunmap_local(kaddr);
 	put_page(page);
 	return ret;
 }

base-commit: f14faaf3a1fb3b9e4cf2e56269711fb85fba9458
-- 
2.51.0

