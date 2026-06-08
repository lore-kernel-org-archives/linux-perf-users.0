Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30102F872;
	Mon,  8 Jun 2026 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948237; cv=none; b=SNkF1H8UN9aGWSvKrIGJmLjXgJCBwDRNldY6fJ+cCz29F9/oeBt+LZfV28QPfoiARwq883CVYRmr8ohadT2rsCDjovbIAOGacTe5BziQLxeUA+IYaWD32QzYd7hAHeBrAYIluRXhfXJOH+CRePKdxFFAx4+lDBy8SDhmXMPxHy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948237; c=relaxed/simple;
	bh=YC4suG9zoQngodTkAEIykCIY8LXVYqHR1o5/XR80jJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imPO7g50dc0Hd152CPM3CVMhW0iFm8bAARlJP5TsDiQ4ru8RG02WAlbf3iN9rBzWOyvaPhTsHZG+4lx/RObc0t9ueR/gcdVVfmRqBHVsY5fZuZhpI5fGWLHFdoaoen+bwIaji6opbSgPTGziC2cGC4/rgvioFBPGTckTbkK3b6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wWfdT-00000001vCJ-26sT;
	Mon, 08 Jun 2026 21:27:47 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] perf riscv: fix register name strings
Date: Mon,  8 Jun 2026 21:26:38 +0200
Message-ID: <20260608192731.708606-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On risc-v, pref probe generates an invalid syntax for a named register in
a kprobe.

$ perf probe --debug verbose --add "n_tty_write tty"
...
Writing event: p:probe/n_tty_write _text+8922528 tty=%"%a0":x64
Failed to write event: Invalid argument

The problem is the combination of

   #define REG_DWARFNUM_NAME(reg, idx) [idx] = "%" #reg

and entries such as

   REG_DWARFNUM_NAME("%a0", 10)

where #reg will escape the quotes of the first macro parameter.

Update the macro definition to produce the correct syntax for a named
register in a kprobe, i.e. the unquoted register name with only one
leading %.

Fixes: a90c4519186d ("perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 tools/perf/arch/riscv/include/dwarf-regs-table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/riscv/include/dwarf-regs-table.h b/tools/perf/arch/riscv/include/dwarf-regs-table.h
index a45b63a6d5a8..c0a6e84e7a75 100644
--- a/tools/perf/arch/riscv/include/dwarf-regs-table.h
+++ b/tools/perf/arch/riscv/include/dwarf-regs-table.h
@@ -2,7 +2,7 @@
 #ifdef DEFINE_DWARF_REGSTR_TABLE
 /* This is included in perf/util/dwarf-regs.c */
 
-#define REG_DWARFNUM_NAME(reg, idx)	[idx] = "%" #reg
+#define REG_DWARFNUM_NAME(reg, idx)	[idx] = reg
 
 static const char * const riscv_regstr_tbl[] = {
 	REG_DWARFNUM_NAME("%zero", 0),
-- 
2.43.7

