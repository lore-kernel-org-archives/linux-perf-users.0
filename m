Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7519D8A8
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Feb 2026 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771379323; cv=none; b=L+ZtJB5w2NugMzJYbGobQXteUOOoC7SBMy8Unyr2ABStrLIAlpW8wr281GdnJZqqPjtk/0mqz/MGfq4kwTZAazpN0XCZMnHKUb4j6W7uhIH/bvN+ON/BdmSy3pna0dXCnG7HawGsUAfYNcJYkhZQ7nsrqYo65KgPr595+fHYYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771379323; c=relaxed/simple;
	bh=RgfrS1WOyS0dUate+Voi0bX7LM27ckd43JDPDgeHMHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PqhlogTK4No8fnNCiY4wACB3iqb+kJh3CjR+nrP2+iqORh5jdKMnzh0WQjlDF2L42HPdteFohB0g7Yeyc9raenLQWv+5bxFtxujOpx4R64bxucwoCIn02ofGNtZPRcJZ5PHfyW1xeV0khqUujHXb0rt7Zx2M5rM4CXNXFkFjBow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=firstfloor.org; dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b=PM9F2sNy; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="PM9F2sNy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
	s=mail; t=1771378864;
	bh=RgfrS1WOyS0dUate+Voi0bX7LM27ckd43JDPDgeHMHE=;
	h=From:To:Cc:Subject:Date:From;
	b=PM9F2sNyxfN1leGYhvcSrBB/VH9ViUDn5Xln//Hpug5Yv4fXK7XOEkLgTUZ/Cxnvh
	 c+sOzq9P8i0pxA6jGG77Fn9HoM4nj3d4iYXvIoUAdqf0AmB+aFtyfncrKdVjaSiLhp
	 T25mMIQ7SqwDR2pVvZKXhflWMVQHBwbwulPx+4EA=
Received: from firstfloor.org (c-24-20-246-137.hsd1.or.comcast.net [24.20.246.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 64D145D9CC
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Feb 2026 02:41:04 +0100 (CET)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 58899162B56; Tue, 17 Feb 2026 17:41:01 -0800 (PST)
From: Andi Kleen <andi@firstfloor.org>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH] perf, script: Fix brcntr output with --xed
Date: Tue, 17 Feb 2026 17:40:56 -0800
Message-ID: <20260218014056.3454977-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

brcntr in perf script brstack insn currently outputs

$ perf record -j any,counter ...
$ perf script -F +brcntr,+brstackinsn
...
            BC1s 3450809 5665912.127194:     100127
cpu_core/cycles/:      7f0475d6cc89 handle_intel.constprop.0+0x2b
(/usr/lib64/ld-linux-
x86-64.so.2)
        intel_check_word.constprop.0+224:
        00007f0475d6ca7e        insn: 00 4b db                  br_cntr: # PRED 21 cycles [21]
...

This has two issues:
- The description says no event is a single dash, but that is not what is printed.
- The b in brcntr is ambigious with the hex numbers in insns, which
  breaks with --xed. It parses the b as another instruction byte and
merges the instruction with a missing b and no space:

$ perf script -F +brstackinsn,+brcntr --xed
...
        00005618c6d683b5                        jnz 0x5618c6d683bdr_cntr:       # PRED 5 cycles [1396] 8.60 IPC

This patches fixes these two problems. It moves the brcntr output into
the "#" comment which also looks nicer and also fixes the no event case.

$ perf script -F +brstackinsn,+brcntr --xed
...
        00005618c6d6624f                        jnz 0x5618c6d65fb7 # br_cntr: -  MISPRED 1 cycles [1398] 3.00 IPC

Since the old broken format has shipped for a few releases there is a
risk of breaking some existing parser, but since this is a obscure
feature I hope they're not too common and can adapt.

Signed-off-by: Andi Kleen <andi@firstfloor.org>
---
 tools/perf/builtin-script.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 62e43d3c5ad7..ac361aa51094 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1264,11 +1264,11 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 
 	if (PRINT_FIELD(BRCNTR)) {
 		struct evsel *pos = evsel__leader(evsel);
-		unsigned int i = 0, j, num, mask, width;
+		unsigned int i = 0, j, num, mask, width, numprinted = 0;
 
 		perf_env__find_br_cntr_info(evsel__env(evsel), NULL, &width);
 		mask = (1L << width) - 1;
-		printed += fprintf(fp, "br_cntr: ");
+		printed += fprintf(fp, "\t# br_cntr: ");
 		evlist__for_each_entry_from(evsel->evlist, pos) {
 			if (!(pos->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS))
 				continue;
@@ -1276,16 +1276,20 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 				break;
 
 			num = (br_cntr >> (i++ * width)) & mask;
+			numprinted += num;
 			if (!verbose) {
 				for (j = 0; j < num; j++)
 					printed += fprintf(fp, "%s", pos->abbr_name);
 			} else
 				printed += fprintf(fp, "%s %d ", pos->name, num);
 		}
-		printed += fprintf(fp, "\t");
+		if (numprinted == 0 && !verbose)
+			fprintf(fp, "-");
+		printed += fprintf(fp, " ");
 	}
 
-	printed += fprintf(fp, "#%s%s%s%s",
+	printed += fprintf(fp, "%s%s%s%s%s",
+			      !PRINT_FIELD(BRCNTR) ? "#" : "",
 			      en->flags.predicted ? " PRED" : "",
 			      en->flags.mispred ? " MISPRED" : "",
 			      en->flags.in_tx ? " INTX" : "",
-- 
2.52.0

