Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9723CE
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Feb 2024 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708770914; cv=none; b=g2c5/beD+c1E43vC2bCxoHrI8zkEDCipEq4t8UlWvBfvNBvWTBJJrAgzI2Z99NG8tOO2FnqFkILicXsSiJiNAEX8GgYPq6D4AzfuxzKXRrLOz+/lf2AN+h3nM1DOvzNehKWWwqufe6j6hzT+NAgf57q3d1wwN1vXf7lRymH0JXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708770914; c=relaxed/simple;
	bh=FKVmx7HpE2ep54ZS8eZHiCvcg/1cKYk/1oKsrQ+s+sU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=dOkFuZyg3cULt8PGOTpZXj7xiZrL8UM5+RhYG8XCyuWYj4qJt9s+ezbNF8oGWhDSxsjvhSzlIOh1cbzJsXpjj2npRoqqAx2GTKIxQgApphVDxZJpEy2nBOh0qzapMaUR/85h8Vo8wmcTHt6XBPaiBCbXS91Iv6S+zkwdJbClFlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=L+sCxD86; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="L+sCxD86"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708770609; bh=JakpM4UpT9WYC+dBrABZ4HnlbAhvwlK1yGteAKNIH+E=;
	h=From:To:Cc:Subject:Date;
	b=L+sCxD86ctMNDKC3SXM/rxpus5vEsoqVF/yXnJXbXjUZVhk4hU2LeghogRxCnKemY
	 bfKMWwdgY9SRowMsHkNPCJAXJ1qyQ+pP2iLVW/lNk+4QqfeRhQyiigxV0Uyr2wcihM
	 0yWCuHmRnUwwlXnC9FJj6thP30CUXzXsgiDj6g0Y=
Received: from localhost.localdomain ([153.3.164.50])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7861CABA; Sat, 24 Feb 2024 18:30:06 +0800
X-QQ-mid: xmsmtpt1708770606tm0ddc59u
Message-ID: <tencent_088804E150842691191FD0021AEE8649EB0A@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaOdGZZpJJ3799IWdt1+NiWL4BNUWo1Bx4tCkhNDvqXhvPEh/qGL
	 iBOJlnBuZVivtyd2vNm4pCf3RGWVtqUIn3zJfC1kL0Gjhiok2Y+SWIM02Vt8heXevfTMq6d2zPCT
	 3v0pi/AkS4hm4VwJamQt75chtZ8VM6h2VGs/3QeXACVajLxYkjEfl7amUr6VoIRhzrlvsCifQTjg
	 z3uWDpDyBObbYrC7fgLUkoSNf9V+al2J4UyE9ZH4bs7C75br5ytVZ3RIGm3/datk1zh3Om75dwH9
	 49dDkGcjBWX6yu/6QzpVsegEigXAN/j08HS/ESpiXnESkWLHNmXppdAkf4g/fOcayNU1kCtZzFxe
	 kqFVu5u388bpsfuLGKpVYLzHgCKIygHiYkLWClvDxo+ywLnP/Qc9xB9hq49+eQNP/tY4hL17MAbe
	 5hl5j0T3y3npONMOKjVGQ3kp1tEGMjD+QQl3XEtQdRKNijpQHGOcq0/FfBTvQ5PAXoiSnS2odcEo
	 YRbOC8d6m+3noj8tCbpC9jimpTDO+Z/4iVImY16kp38B9FUnibxFIHfEmODfeDFdxVMGp6YaF2AD
	 quC51p9pVX2pKaI82ATMleV08QokfwwUV2gd6S50WV4QgareSAqV64fPqD2fiaFEAH/R9VSer6Jk
	 5sEfkoqb6Rys5O0/46/nvRGNZhFUY9mt7DD/tjUpC63pwhKkL+abBqEmxKzGH5bbes2ZNBTtDiia
	 QnWS4/37WpxetcLzBMX1R5W3lTgx7qRlnXshcqthwwJPLJdulv84phKNgqTnwWfgSUUDfdxnbxqh
	 ZDNF4bantifcdeyf/vZKjyyD0EA2seJjYbd0z3lQTwTM3OzN/W8xd3nCMzVFKTxmCmYoBH/1PIIK
	 Zaiq3zwjIGFtZx49boURPANaxoMpjb9T5Q9i6PoUhbY5gpR5rXwflCB4bi+T9CvV4DYZAknjGTXv
	 H+MoDsConeTSaAmZfoaK4DLvsFnnjnBBweRHi3JEwEkq9a5ilpYpxGKJ3ui5Z6OQYuxhOLgVLfXm
	 hNzQWirQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: linke li <lilinke99@qq.com>
To: 
Cc: lilinke99@qq.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] uprobes: use READ_ONCE() to read mm->uprobes_state.xol_area in concurrent environment
Date: Sat, 24 Feb 2024 18:25:19 +0800
X-OQ-MSGID: <20240224102519.19874-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function get_xol_area(), mm->uprobes_state.xol_area is read using 
READ_ONCE() in line 1534

1534   area = READ_ONCE(mm->uprobes_state.xol_area); /* ^^^ */

while read directly in line 1530

1530   	if (!mm->uprobes_state.xol_area)
1531	    __create_xol_area(0);

In the same environment, reads in two places should have the same
protection.

Signed-off-by: linke li <lilinke99@qq.com>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 929e98c62965..e110941fbc6b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1527,7 +1527,7 @@ static struct xol_area *get_xol_area(void)
 	struct mm_struct *mm = current->mm;
 	struct xol_area *area;
 
-	if (!mm->uprobes_state.xol_area)
+	if (!READ_ONCE(mm->uprobes_state.xol_area))
 		__create_xol_area(0);
 
 	/* Pairs with xol_add_vma() smp_store_release() */
-- 
2.39.3 (Apple Git-145)

