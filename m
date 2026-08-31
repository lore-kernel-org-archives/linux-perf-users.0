Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA751C345;
	Mon, 31 Aug 2026 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188830; cv=none; b=qS73fgzEUhSHcm9VN6cKNZCbpM/Tw//C/j/rpN8qin9H4rt1b8Wz2Nwy4glgNzkR4uMrZvBQ6J6dExpNR0lKA/4vhoYJWHEYOS0ZMLbyZhnjrc9zm6JpjDGm5wuDF0po3vFj3UZfwF1fquCwF1X4OJEh3na2Ndm/ee9Fi1j0nmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188830; c=relaxed/simple;
	bh=oEzBS9MSTO4m71nv/6/Z+N5hFTx4RNl75btZPHL13EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKROu9wre2qcbz/4WpYcAzQlk+o5XRlIOZI0dANdktdf6d4QfLwhvRT0YnYSza5FqRM1y02hD4x2uovZUmrkWiDMqvkATZBev2w+j4hoHOdgm6ogSRiD7HvPnI7ZBorHVbPG0nL5XpYuQ4QdyncetqM05zeC5t0FP3qPn7VpGFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 14B065DBF9;
	Mon, 31 Aug 2026 17:07:06 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 0180C16225B; Mon, 31 Aug 2026 08:07:03 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	tglx@kernel.org,
	x86@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	Andi Kleen <ak@kernel.org>
Subject: [RFC v1 03/19] uprobes: Print warning for missing breakpoint install
Date: Mon, 31 Aug 2026 08:04:39 -0700
Message-ID: <20260831150651.1134594-4-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831150651.1134594-1-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When installing a uprobe break point fails the error is currently
silently ignored. There is no obvious place to return it to, but
at least print a rate-limited warning to make it easier to debug.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 kernel/events/uprobes.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4287c4ff4c0f..941b52c47858 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1630,7 +1630,13 @@ int uprobe_mmap(struct vm_area_struct *vma)
 		if (!fatal_signal_pending(current) &&
 		    filter_chain(uprobe, vma->vm_mm)) {
 			unsigned long vaddr = offset_to_vaddr(vma, uprobe->offset);
-			install_breakpoint(uprobe, vma, vaddr);
+			int err = install_breakpoint(uprobe, vma, vaddr);
+
+			if (err)
+				pr_warn_ratelimited(
+					"uprobes: probe %pD+0x%llx failed to install (%d)\n",
+					vma->vm_file,
+					(unsigned long long)uprobe->offset, err);
 		}
 		put_uprobe(uprobe);
 	}
-- 
2.54.0

