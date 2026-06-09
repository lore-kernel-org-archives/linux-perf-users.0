Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DF3E63A8;
	Tue,  9 Jun 2026 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992968; cv=none; b=qwGoj8WTDcsrIU4NF8NEBWx4GtWldggbe3KxkroTbrHErMMZ9o4WBtxoPNMO94WX5+BJ7pqbeGtI4wjaVZg0pMeTtU/teVqVUMWvbLKQ1OtUKqG4tsGoyo53xPb2pwvd3pxuLIWd5qYCdbLu0kymryYCTxLlz7BpmaLfyabVZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992968; c=relaxed/simple;
	bh=d1R5UVWvvineQ2Ttu8qeCgiI9PEeXXg9+Z3YYcs6uJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptvHCqZyvDRDTL3C90J+gUcI1LXLl4Zx7L2QAUShOZSZACRB0ApsB4j7VchTPebfIVrgz2yEYsoSh/N8ZqRhbJuZRwXV0iN/UpGEgQy9vY6QY1qYohZ56YFwwKuAuBSzPcc7elm5qRDb2ouddSaHnpYeoAhgMuO6e3YL1Ul2byM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wWrcx-000000021Mp-1uAO;
	Tue, 09 Jun 2026 10:16:03 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 2/2] perf riscv: fix register name strings
Date: Tue,  9 Jun 2026 10:13:09 +0200
Message-ID: <20260609081500.743861-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260609081500.743861-1-martin@kaiser.cx>
References: <20260609081500.743861-1-martin@kaiser.cx>
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
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 tools/perf/arch/riscv/include/dwarf-regs-table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/riscv/include/dwarf-regs-table.h b/tools/perf/arch/riscv/include/dwarf-regs-table.h
index 009a4e3c51ab..8c42806d34f1 100644
--- a/tools/perf/arch/riscv/include/dwarf-regs-table.h
+++ b/tools/perf/arch/riscv/include/dwarf-regs-table.h
@@ -3,7 +3,7 @@
 /* This is included in perf/util/dwarf-regs.c */
 
 #undef REG_DWARFNUM_NAME
-#define REG_DWARFNUM_NAME(reg, idx)	[idx] = "%" #reg
+#define REG_DWARFNUM_NAME(reg, idx)	[idx] = reg
 
 static const char * const riscv_regstr_tbl[] = {
 	REG_DWARFNUM_NAME("%zero", 0),
-- 
2.43.7

