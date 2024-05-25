Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4FC3A1C7
	for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716634093; cv=none; b=HdEhdUxoNM2gLvsFY3uUt8VSim2zS9IhDcfSpWU68aB577nGNe7t0QcD3vRx0dLW9UJYVIjjApYW3YpQZ6Nv6B/ySjZMSWjhllVjyqYgsANYm8+b9nb7Vkg7frRlWL8e98HYfzNGpioddg3g1/koacJ90oYLaD5J9COtsfpO0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716634093; c=relaxed/simple;
	bh=2lqPOceltLwRczEmThPV0eUtcRU8lZHDrOgk/+NdHEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LOnyE5m5JiBldh+ak1cmKIqPzRoNIgFZ/BEfBmgLdvCNm8vwH75VoFTWYfk7mExfiok97krILOmeJys3XttAMSjjFHQnRqDQR/mmE6TQX1DlKlqN6NU1ZDvKnC/It2flAoUaD71p51TWZPIW6GIAdPBPlYRLAIcXNOK8uxghQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vngge9AZ; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vngge9AZ"
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-529663e467fso1133804e87.3
        for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 03:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716634088; x=1717238888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x33LW9A7dVK5EVTAPgwg05LtwyjW2o2CH4TqOgwA89I=;
        b=Vngge9AZKQmQnjLG5WUU459h6cwkTPxN4rt+W4JWJRb4y0qoCVx2/K3Fs8Ozw0yrdU
         Ecgy3XFhDS7nKs29pATcoYrT6fE1fahIVMpNPO1QoAWYx09Vh2DUxTRKPocHp1vEe3QZ
         u2Hl0/zThA7C2dzTkDlj+ybwqHGp6aylLWCtVn/9bRvrHJixc7V+4vg7qnM0LZFSWRqF
         D3CHHYmX7kISjM0jEIAL4rjiE5yLNchfXZmcVWinzCYncgjq5gsIPfnGXKbmiBUHKa5D
         3GOtfg1+ssdvblpqNOkkQ3vOPOs18q+oOA80YBecJ0e64BMUADO35hhpXGAGRg9zdEJb
         Buhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716634088; x=1717238888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x33LW9A7dVK5EVTAPgwg05LtwyjW2o2CH4TqOgwA89I=;
        b=VoW1xs3SS6EIQBc3lcugKAuGunGrc9aVzzMhvJK/Nxg8Or3Iw7B8rxbiertshaBUjH
         2bKBmT8PhUddoSXIz4Ja3G+wrrVj4SUEtvGwe4C9zmSKZFAGozrtXY0snrGndUUgr9O0
         MgQ3VwUfoSUPL6RF67RyCu7C6xzs5y9P7P56lITp/Q++vDoGx9JapvbL2rblHeLvkUZd
         kL2jY6voty+D1iYj6AnmNDzwVGgBfl7MaSVeVuW2LU4v7oi175hKei/NQu45hyM7f5Gg
         lwFITo0Bj0wcTfmhTXOMpgvYyLVwy4NcyX2pUMON2Qc8ljO80MZ8GUPWbzoI+AMdDvFS
         kcBA==
X-Gm-Message-State: AOJu0YzjwIgjBKxgURMrtV/a0T76aAzprFAyfgnCdXMPZFhUo6jpAMQD
	XrBX0wgqYDlUdIUXTqPT5nCTJt8Imdp6zmezY9jFIdlyM4DRk4dxkKURDBfcILVIb9lixKoN9g=
	=
X-Google-Smtp-Source: AGHT+IGN6xVdZAkSrm56Sh9UHyxZz/GpA8d9fzFyHMmnzeWi8Ie7DGT0rYA4SiFems0Hx2Nk/ziYNi4Fkw==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:8cba:1aee:d3cd:626f])
 (user=sesse job=sendgmr) by 2002:a05:651c:10b1:b0:2e9:570e:1d5 with SMTP id
 38308e7fff4ca-2e95b273f56mr41271fa.5.1716634088029; Sat, 25 May 2024 03:48:08
 -0700 (PDT)
Date: Sat, 25 May 2024 12:47:54 +0200
In-Reply-To: <20240525104755.324014-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240525104755.324014-1-sesse@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240525104755.324014-2-sesse@google.com>
Subject: [PATCH v6 2/3] perf annotate: split out read_symbol()
From: "Steinar H. Gunderson" <sesse@google.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	irogers@google.com, "Steinar H. Gunderson" <sesse@google.com>
Content-Type: text/plain; charset="UTF-8"

The Capstone disassembler code has a useful code snippet to read
the bytes for a given code symbol into memory. Split it out into
its own function, so that the LLVM disassembler can use it in
the next patch.

Signed-off-by: Steinar H. Gunderson <sesse@google.com>
---
 tools/perf/util/disasm.c | 90 +++++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 72aec8f61b94..c0dbb955e61a 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1396,6 +1396,53 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
 	return 0;
 }
 
+static u8 *
+read_symbol(const char *filename, struct map *map, struct symbol *sym,
+	    u64 *len, bool *is_64bit)
+{
+	struct dso *dso = map__dso(map);
+	struct nscookie nsc;
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 end = map__rip_2objdump(map, sym->end);
+	int fd, count;
+	u8 *buf = NULL;
+	struct find_file_offset_data data = {
+		.ip = start,
+	};
+
+	*is_64bit = false;
+
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	fd = open(filename, O_RDONLY);
+	nsinfo__mountns_exit(&nsc);
+	if (fd < 0)
+		return NULL;
+
+	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
+			    is_64bit) == 0)
+		goto err;
+
+	*len = end - start;
+	buf = malloc(*len);
+	if (buf == NULL)
+		goto err;
+
+	count = pread(fd, buf, *len, data.offset);
+	close(fd);
+	fd = -1;
+
+	if ((u64)count != *len)
+		goto err;
+
+	return buf;
+
+err:
+	if (fd >= 0)
+		close(fd);
+	free(buf);
+	return NULL;
+}
+
 static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 				  struct annotate_args *args, u64 addr)
 {
@@ -1458,19 +1505,13 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms.map;
-	struct dso *dso = map__dso(map);
-	struct nscookie nsc;
 	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
-	u64 len = end - start;
+	u64 len;
 	u64 offset;
-	int i, fd, count;
+	int i, count;
 	bool is_64bit = false;
 	bool needs_cs_close = false;
 	u8 *buf = NULL;
-	struct find_file_offset_data data = {
-		.ip = start,
-	};
 	csh handle;
 	cs_insn *insn;
 	char disasm_buf[512];
@@ -1479,31 +1520,9 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	if (args->options->objdump_path)
 		return -1;
 
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
-	if (fd < 0)
-		return -1;
-
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
-			    &is_64bit) == 0)
-		goto err;
-
-	if (open_capstone_handle(args, is_64bit, &handle) < 0)
-		goto err;
-
-	needs_cs_close = true;
-
-	buf = malloc(len);
+	buf = read_symbol(filename, map, sym, &len, &is_64bit);
 	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, len, data.offset);
-	close(fd);
-	fd = -1;
-
-	if ((u64)count != len)
-		goto err;
+		return -1;
 
 	/* add the function address and name */
 	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
@@ -1521,6 +1540,11 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 
 	annotation_line__add(&dl->al, &notes->src->source);
 
+	if (open_capstone_handle(args, is_64bit, &handle) < 0)
+		goto err;
+
+	needs_cs_close = true;
+
 	count = cs_disasm(handle, buf, len, start, len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
 		int printed;
@@ -1565,8 +1589,6 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	return count < 0 ? count : 0;
 
 err:
-	if (fd >= 0)
-		close(fd);
 	if (needs_cs_close) {
 		struct disasm_line *tmp;
 
-- 
2.45.1

