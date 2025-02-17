Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463317B506;
	Mon, 17 Feb 2025 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739778232; cv=none; b=tFRKChoke958kmX6bHcVT7iYppVH2CmrmeMdBZ/h8fCOYWvRzWpun0O9cwul8MZWJKtj7bZsKQCTOyxdwTwR3+THmpUjZmRJwkQNlRyK0cGlQ/drk20I9vAKrIHeV6um9U0PIJnjBs24Hw/A/Nb0fARtzVjprENne50tJ3lXhug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739778232; c=relaxed/simple;
	bh=00sTRUDdu8vbS8MwColUls5lEUvb1WlKlXH6I93MHuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LUw7+HAwl9EdFCkQzmUYrEj0aBzXF72Vr0vydDL281YzabEh0rcZAdHX86S039v0J/cg07I14H6HPtq3UxI/UQscKqOyN2LNrKmsAyqRt/XjqiuAJFK6zEKyWsXm1rr/5N23XOpwmA5JTkrmaukmpGq5HxqXDHi7Z64x6pVFM4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iJFXuCEj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I7PljjRE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iJFXuCEj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I7PljjRE"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739778229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hk1Y9Y+p+iPCClZ+zKo3NZ/M2GuwbcSwKkzVokfVkTA=;
	b=iJFXuCEj+r2/Xxo+pxO6uh7FS2RiEZWHb78ggOWwqndbeeVjkzr9isMTVOag+npsMDZvpN
	TiryTbef/Kzoog7RBx7+jAaKviXVLqxWt6rnw6BmU2rg+m9HbjfQdqhDwOk74ib9z5/AJs
	KXOdm+rYD8/G+5JEVBDERF5yJb0rlZ6Jw4apZi3Qlyo5eBr/luQRmmWSih+TvbyfKwBIYn
	WUH+6qTd7h4BI96CxJaoXEvWWyPwPB1UwTHlRUqE8RPvCPz6/6+XUQEzhC/c6NQTu18mZi
	Kb8OvMTkAvLfjSCig13P+dfZfQ7Zv5lBAAAedIjN+zgiq+Q/jZqQ8ubiJAJ/Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739778229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hk1Y9Y+p+iPCClZ+zKo3NZ/M2GuwbcSwKkzVokfVkTA=;
	b=I7PljjREBaH4KywhHbao1WsFCV70DLKvnWud9CDZJigLx2bTuZBQ3A4mgYuUY72IOvueVg
	XyFk7oNfunxpFPCw==
Date: Mon, 17 Feb 2025 08:43:35 +0100
Subject: [PATCH] uprobes: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-restricted-pointers-uprobes-v1-1-e8cbe5bb22a7@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAKbosmcC/x3MQQ6CMBAF0KuQWTtJW4OgVzEstHxkNm0zU4gJ4
 e42Lt/mHWRQgdGjO0ixi0lODf7SUVxf6QOWuZmCC70LfmCFVZVYMXPJkirUeCua3zAery76290
 PcempDUWxyPe/P6fz/AH5kvhGbQAAAA==
X-Change-ID: 20250217-restricted-pointers-uprobes-830c16917cf5
To: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739778228; l=1302;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=00sTRUDdu8vbS8MwColUls5lEUvb1WlKlXH6I93MHuU=;
 b=qoDczWA9Nsy/IEBtZ8Pu1pCBBe8mT36Ct26fqF3dRHou9S8MpNPl5vjtrLmSFPPvGVRAFU1zR
 oN3PmyVau7WBJKLGMwPPy+zlgD9yBcU9anS/ltNOIMqH+nw5Pm7/U9v
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Restricted pointers ("%pK") are not meant to be used through printk().
It can unintentionally expose security sensitive, raw pointer values.

Use regular pointer formatting instead.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ca797cbe465f2d4a596e4a5d0d2d5a45e5cacf9..bf2a87a0a37878e99d0cf715ddedfdc2d1949c5d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -417,7 +417,7 @@ static void update_ref_ctr_warn(struct uprobe *uprobe,
 				struct mm_struct *mm, short d)
 {
 	pr_warn("ref_ctr %s failed for inode: 0x%lx offset: "
-		"0x%llx ref_ctr_offset: 0x%llx of mm: 0x%pK\n",
+		"0x%llx ref_ctr_offset: 0x%llx of mm: 0x%p\n",
 		d > 0 ? "increment" : "decrement", uprobe->inode->i_ino,
 		(unsigned long long) uprobe->offset,
 		(unsigned long long) uprobe->ref_ctr_offset, mm);

---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250217-restricted-pointers-uprobes-830c16917cf5

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

