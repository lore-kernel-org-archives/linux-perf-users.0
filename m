Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20457161328;
	Fri,  9 Aug 2024 20:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234246; cv=none; b=EF5GOw3Sn6t0Jk5hAdYMHlz9gd8AGI2/PH6qoyLLzdL484MFjaLAYfJAuCAI6mX28R+P2UBs/2h7XjMDFOxibgy9Tuk8QjyVCBfLKspD4tlFR2eoNacLOJIhGFRx2OdhFcu1rvbTvfAlDPCgdOs9ebXymJUpgn2aHiZRO6URtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234246; c=relaxed/simple;
	bh=jS4HNxS5YVlzJK+dlPLdW3J1aGFuw3+BwsgCSMaNG+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aLn96KA2IU2p5oMzJm7Y+WR4Xn/sYh9vNwAFyNXoFmJhqS4z1jAWgvs8JlBa+63F973LUDzvdYx4i4J71kjx6d3khALEbI2h7hunvBgV7zOT7gm5Wb6yuTI1ZSb2fn0l3/7u+trg19xdnQDEYATGb0JQ2fwoOF6S11JgtE2BFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pE6BAC6z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pE6BAC6z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=nt6sGjTIM7+4LXnH/dUk3qctUYRRVzNRPbE3hRVC2Gk=; b=pE6BAC6zUQvLEzpOVv/+uO7xJ9
	euwNlaRTco/Bgs3obsSOPBeZ5WszDJ09+DcRhxY0d0uxXbi8/nBEZYg1ATmuUrUYKXLPDDceR3Ri6
	y179ov+bUbuyaVL3b2FGhUusZL48Vh//BKNyCbSSEYBFMVhxqEeDKlANMvc+FTSHOo+l20P55hX/w
	1VCnIchdD8C9IhxDR391v+zMfHlhQJgQwX7iBP3/bQrn4WqJCsrSfplWFf4oK/bW32dsydR1FZyXz
	nkuJeMpRJnQeut2vShgKi/qC74aMxJOaitOhjTjjGrfCuh0uXO1umEpDfpZMnDW/4ObQjqd5WDyKx
	WWxDDewA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scVwh-0000000B6t6-0H2X;
	Fri, 09 Aug 2024 20:10:43 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: Remove setting of page->index and ->mapping
Date: Fri,  9 Aug 2024 21:10:36 +0100
Message-ID: <20240809201038.2648058-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have no idea why perf is setting these fields.  There should be
no need to do this.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 kernel/events/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..f55ab04f3df0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6221,8 +6221,6 @@ static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
 		goto unlock;
 
 	get_page(vmf->page);
-	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
-	vmf->page->index   = vmf->pgoff;
 
 	ret = 0;
 unlock:
-- 
2.43.0

