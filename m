Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899F1189B94
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664355; cv=none; b=JZVShWmNYa4B8k633eg/GLfLY0/7xfil/rKuo9Dr0+0+toTKSIfpW7Sl7ASJ8BMIz3aHCsfK9KGDADMToPa50Qvv/KOiBey3DL/qKxlXYDXuJaGBuu+FsvwIZhnAP/RHbS9uZDftcVZ6cZZwRZnDT1t69ree8Xs+UKSHwDbqpAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664355; c=relaxed/simple;
	bh=liHqjDLQhFyftWAMkULSYdCycOr3/L4o7hVwGI1o6pM=;
	h=Date:From:To:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QBn4X9MnLQiXrOZJkhzRaP7KyOiaVXUngbH68pyqfaRrXBffBDEx5Gky1lA6+pDvzx2sAyJgnwoyHEzU+oQOCt1edTLS84q1rqWFHjY56eXmI2rUQhty585bzkzSrj1xRzUF4cWOqX4dWD8bIqBB8Nu+g9nTvfJs+EG4t4eyTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=Jbi7xYjY; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="Jbi7xYjY"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XyfDF63Lbz9t4B
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Nov 2024 00:39:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	s=MBO0001; t=1732664349;
	h=from:from:reply-to:subject:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=CHs3S9xcHOKrcvMBWJcL0uZBykTDYrm0PPEPZkh8EPc=;
	b=Jbi7xYjY/K+c+yPaMRzPpAmu6OfGgLdobELl1UxAUDPk/l5H2D/qzAXzLqTBVZ3Sav3MMG
	Q2Iez7lk6HVut7b0zOseN0JsWju191YkYMbIBDIcRSELM3BrZlUzHqjCVjQlyjEuevliPz
	ghammgQjuRYq9/lj4VxoRG2Z3b1jPRO2S3Tt3nJP8bhUL1aQdrhgd3Bf8Y9tJ7WaoN+oU9
	NUQgJ+2KwGCdfPj28a38OxjIVLtRRZLYwxWj6seWuchhw/pQ8IoxYeMVEk7O620BHqsL1u
	c1bCCtg+nq7oMDJ8GeyYYKKsYbwJtZtDx3OjZRcB6kuq8Q8SDo7XVeCVTZ13kA==
Date: Tue, 26 Nov 2024 17:39:07 -0600
From: Michel Lind <michel@michel-slm.name>
To: linux-perf-users@vger.kernel.org
Message-ID: <Z0ZcG2Zn/1/iGTFA@hyperscale.parallels>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 4XyfDF63Lbz9t4B

From ab2bdf2e20a99b8d0298435328055daa59d2b640 Mon Sep 17 00:00:00 2001
From: Michel Lind <salimma@fedoraproject.org>
Date: Tue, 26 Nov 2024 17:37:44 -0600
Subject: [PATCH] perf MANIFEST: add license files

The standalone tarballs should include the license files - both the
COPYING declaration as well as the text of GPLv2.

Signed-off-by: Michel Lind <michel@michel-slm.name>
---
 tools/perf/MANIFEST | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index dc42de1785ce..47b7a12f5780 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -1,3 +1,5 @@
+COPYING
+LICENSES/preferred/GPL-2.0
 arch/arm64/tools/gen-sysreg.awk
 arch/arm64/tools/sysreg
 tools/perf
-- 
2.47.0

