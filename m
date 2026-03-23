Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793BD370D6E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281488; cv=none; b=rzXUHXasJg9IRopzQ+44b69XCW4JeQmmKnEk5KUo/pIgSuXKUARNGBuH9UZBf3MxuTrBv3TkRpHfdhzw2mLWp7ZqnJSkQ7n4kQdqYft97uHWf/TALSF5WrduKkZv9NlGXZcF+Q270aPGPj2yEkptiln4sIEZXn5ns9lfNtNr+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281488; c=relaxed/simple;
	bh=OrRFUFoYFq9AuO+BAG5MSacfRAIKA/wkfTvfheQzan0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGlEJU3N8ddtaVvbPfIaBylM03raenm9LZYsUKM5qQImbqBTDmUepdV1oGscylCa0sehm0htBXZqqqk+ZHb7BWd9oJboMZ03MVxhXXS2c8Pa3U1jsLmYENRVUCbW430IkQOXZVSQTfW1plw9BNed4AXfrPzIKhXtxhl3sxXScEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHsqvQoe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHsqvQoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760E4C4CEF7;
	Mon, 23 Mar 2026 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774281488;
	bh=OrRFUFoYFq9AuO+BAG5MSacfRAIKA/wkfTvfheQzan0=;
	h=From:To:Cc:Subject:Date:From;
	b=DHsqvQoel0W0w5qKzmgFEJpoh4WGNcT3EqQ0DTRLxvgad0+8dw18Un3qbWhTEc23S
	 2oTpjH8N/eCbutV5DQaH3BuIMTP6T9ytuHTzP9FKVatujbGzasBOdvSoT1RsbsEBn5
	 t2fgIdFiSNYJ0XtItmj3CXHVT842SRhWV/vayCVCccS9Kk6U/UySlfJf6KWp+yFpbP
	 77UYtip4usDESBmd0o6xO9G2ooAC8SMkmol4j+ICXVSqxSI93bJ38mr7wALu5oTwYm
	 cxlIexaczfAob6I73ej5QZ28N/f/k7o5Z4C1XyOF2jAosstP65EvOXLaGUs5k4mtmH
	 RKHth/ho7a2Tw==
From: Chuck Lever <cel@kernel.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] perf symbols: Fix module symbol resolution for non-zero .text sh_addr
Date: Mon, 23 Mar 2026 11:58:04 -0400
Message-ID: <20260323155804.7216-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

When perf resolves symbols from kernel module ELF files (ET_REL),
it converts symbol addresses to file offsets so that sample IPs
can be matched to the correct symbol. The conversion adjusts each
symbol's st_value:

  sym->st_value -= shdr->sh_addr - shdr->sh_offset;

For vmlinux (ET_EXEC), st_value is a virtual address and sh_addr
is the section's virtual base, so subtracting sh_addr and adding
sh_offset correctly yields a file offset.

For kernel modules (ET_REL), st_value is a section-relative
offset. The module loader ignores sh_addr entirely and places
symbols at module_base + st_value. Converting to file offset
requires only adding sh_offset; subtracting sh_addr introduces an
error equal to sh_addr bytes.

When .text has sh_addr == 0 -- the historical norm for simple
modules -- both formulas produce the same result and the bug is
latent. As modules gain more metadata sections before .text (.note,
.static_call.text, etc.), the linker assigns .text a non-zero
sh_addr, exposing the defect. For example, nfsd.ko on this kernel
has sh_addr=0xa80, kvm-intel.ko has sh_addr=0x1e90.

The effect is that all .text symbols in affected modules
shift by sh_addr bytes relative to sample IPs, causing perf
report to attribute samples to incorrect, nearby symbols. This
was observed as 13% of LLC-load-miss samples misattributed
to nfsd_file_get_dio_attrs when the actual hot function was
nfsd_cache_lookup, approximately 0xa80 bytes away in the symbol
table.

Use the existing dso__rel() flag (already set for ET_REL modules)
to select the correct adjustment: add sh_offset for ET_REL,
subtract (sh_addr - sh_offset) for ET_EXEC/ET_DYN.

Fixes: 0131c4ec794a ("perf tools: Make it possible to read object code from kernel modules")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/perf/util/symbol-elf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 76912c62b6a0..968e269d9be1 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1356,8 +1356,12 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 	char dso_name[PATH_MAX];
 
 	/* Adjust symbol to map to file offset */
-	if (adjust_kernel_syms)
-		sym->st_value -= shdr->sh_addr - shdr->sh_offset;
+	if (adjust_kernel_syms) {
+		if (dso__rel(dso))
+			sym->st_value += shdr->sh_offset;
+		else
+			sym->st_value -= shdr->sh_addr - shdr->sh_offset;
+	}
 
 	if (strcmp(section_name, (dso__short_name(curr_dso) + dso__short_name_len(dso))) == 0)
 		return 0;
-- 
2.53.0

