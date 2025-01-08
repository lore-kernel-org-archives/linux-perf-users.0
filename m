Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6D91F7097;
	Wed,  8 Jan 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329810; cv=none; b=oWhXUxrGoj52M5Xbo1nXzGaAAVgLXpwK1ybQptyuM8FpMWxEsbD5RkHpgFaGTTuaxTDDSrSs5r18V2yZ7mka0nJuHfcP9Jf2CNPqevS1dEG51mPLLti5rd4EF8IIQ+q3bgo0uOnULZdcNNHUMBvJXN9LEcjX0oaAjCaCY4nnT2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329810; c=relaxed/simple;
	bh=zYAGE8QbxKeiF29HDF5A4cvzDluLkNIsa/y7/gNnmaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rN9/fKAlrAjy28RwUZQ2Ox7zwFnhbrl7IoWpZP+QoylRYWwA3pGumeMj9NCf/gMXCNDUOhQdqgzlGRhqXP/UIWMQwl2bqhh8xqYKCqLq+m+lNEoVESOrEx7TRrI/Sn9Pp97zvObX7vUpTZg05dKUtpxOkYeXa7UnQdBwxsK2wo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YSj4k1Tlzz9sTD;
	Wed,  8 Jan 2025 10:17:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ev2o6ECynf8S; Wed,  8 Jan 2025 10:17:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YSj4k0lh3z9sT7;
	Wed,  8 Jan 2025 10:17:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 073E98B768;
	Wed,  8 Jan 2025 10:17:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WA33TRlzg4jX; Wed,  8 Jan 2025 10:17:57 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 960068B767;
	Wed,  8 Jan 2025 10:17:57 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] kallsyms: Always include _edata
Date: Wed,  8 Jan 2025 10:17:54 +0100
Message-ID: <2fec8c50c271dff59f0177ff0884b6c374486ba5.1736327770.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736327874; l=901; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=zYAGE8QbxKeiF29HDF5A4cvzDluLkNIsa/y7/gNnmaE=; b=phUBcQMzGu5s2Any9DFi8D1iChFZ7vYkQDjKS53d6tiKMn4sMiQpDS5WHfeNw2d3Q3TM2ovXy s8XRIyMcqpUCNzZb+YM2+yRyzFNqLlJHQ14jecGoCbMR/pOF8CC1Yk2
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Since commit 69a87a32f5cd ("perf machine: Include data symbols in the
kernel map"), perf needs _edata symbol.

Make sure it is always included in /proc/kallsyms and not only when
CONFIG_KALLSYMS_ALL is selected.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Fixes: 69a87a32f5cd ("perf machine: Include data symbols in the kernel map")
---
 scripts/kallsyms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 03852da3d249..391ab7ebce7f 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -215,6 +215,8 @@ static int symbol_valid(const struct sym_entry *s)
 		if (string_starts_with(name, "__start_") ||
 		    string_starts_with(name, "__stop_"))
 			return 1;
+		if (!strcmp(name, "_edata"))
+			return 1;
 
 		if (symbol_in_range(s, text_ranges,
 				    ARRAY_SIZE(text_ranges)) == 0)
-- 
2.47.0

