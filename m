Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F01547F9
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Aug 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722698422; cv=none; b=hpbLsvb3uG/C/aRs9BojLF2zHyIJT6bGsdDdkNIPRiC431lKyFCtJuwerTPCWFNHULxslXQjO+/7mSez7MJC9PwpWLp/S5p04V5EkdyCXgcnT9bu+KS/JBWXdFEyv2wK+0Lhz60bc/wvvk9TMcUF9//C9WUWRfJEjJNHH3LUytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722698422; c=relaxed/simple;
	bh=atFFZ6Z5FIzQtKPTP23gsn+DvSJjm6Z6g2QIoXa74hg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VyzfEWqyZsCmG7UZd60IfgCkMRQzl28sHX5zVuJAYAgjQfbD73kDjQCIetdBUPpKFVMvounuKUuli2fKAeMC01Cr+SXDhd/d166l+PS3Kyq0LufXsdCocHItcF9pgDtog25V7diaUoZYwLIDHDzSrKLHm+Q/eYILbxDO8tHt85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKT83GIq; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKT83GIq"
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2ef2907e21bso79703511fa.3
        for <linux-perf-users@vger.kernel.org>; Sat, 03 Aug 2024 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722698419; x=1723303219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYsomUCzSWsrZbNlMTeafSAnwYZDCwSdK4Xg/dZo2iE=;
        b=iKT83GIqKulpzwi+1eVS4kP9hx5BuBH0YFTYdkApswZQw72K2KyDb8kNJjeqsY+NMc
         0oTgEN0sUwRBoNLdkDPcuvr/GMycCAPoZoJ9Yg86ugjhPFjATZn4WNFji50KyilJGoBt
         dA+1F4aI2jXaSOcWH/9cqmkG2mOxbTl6Uk9w+9svZwiymjTnDHt+XngZSSk8JZAnULgS
         k52gH3JtwHYs6uKkXbjuVkXtG8G/6I+bgW/0gCN8ULBE9NSXdjxREkgMIyWWjUWEQlyB
         ruuZtSLfviXZEB8x4q3s6/IwhpH0kKQiZ7TFlzOlJmxO2LUnNfiWgEk8rwSRwqzjqFb5
         upLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722698419; x=1723303219;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYsomUCzSWsrZbNlMTeafSAnwYZDCwSdK4Xg/dZo2iE=;
        b=Zssxs5tDT7mlWCsHhcineCd3fF4dM+X9W/bYxFgvH6HboW//d0s7pl5gfPvkDYzI3B
         RL9UjjodEIssvsbl4+SysH3/oBmzeI2cvNr1yh7XWHTNf2WlkP5I+23XSR24BISyB1js
         xFzRnMMM2TCLroWZVnebjQaeTXI794ZoFv5uhpVLNBq02w/cFykSoySjEf+NChRSx2Gb
         14JcMbq/t0DavqcGB1UPJDbEAcw41uwCuaAiChvoLtjeKjmSJgjPCMU55QGrz7s/UGHg
         lMjaxRgvGqFpbhbsDSGJQH4uGyGg8uqLXRnxbJUAg6WG9aA6PMDVd0LtWHdRZjvhvHc8
         8iHg==
X-Gm-Message-State: AOJu0YxTMnhIiubFhHMMbPC9dF6/3wCQXAMUxJq2yGvE/kznFPiQn1Lf
	jJTYCDcFLm8F6Ldhwk6n2XdpPMs49L9sQeQRWcwPWf7XmEyEnnkdgSqtYtkrX68iO6t3G3a17w=
	=
X-Google-Smtp-Source: AGHT+IHOn+BG3PWGTFXEpj1Qsf2sSgK/+OyzWNVcKwaEPBrTntBrC944xIuu9xgMGxcfSEb8Ryk3v9Mvkg==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:521e:7b8e:2bc4:adde])
 (user=sesse job=sendgmr) by 2002:a2e:9892:0:b0:2ef:23af:f1f4 with SMTP id
 38308e7fff4ca-2f15a9fd3afmr79251fa.0.1722698418787; Sat, 03 Aug 2024 08:20:18
 -0700 (PDT)
Date: Sat,  3 Aug 2024 17:20:07 +0200
In-Reply-To: <20240803152008.2818485-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240803152008.2818485-1-sesse@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240803152008.2818485-2-sesse@google.com>
Subject: [PATCH v10 2/3] perf annotate: split out read_symbol()
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
index 85fb0cfedf94..1022b09c7258 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1372,6 +1372,53 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
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
@@ -1572,19 +1619,13 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
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
@@ -1593,31 +1634,9 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
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
@@ -1635,6 +1654,11 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 
 	annotation_line__add(&dl->al, &notes->src->source);
 
+	if (open_capstone_handle(args, is_64bit, &handle) < 0)
+		goto err;
+
+	needs_cs_close = true;
+
 	count = cs_disasm(handle, buf, len, start, len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
 		int printed;
@@ -1679,8 +1703,6 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	return count < 0 ? count : 0;
 
 err:
-	if (fd >= 0)
-		close(fd);
 	if (needs_cs_close) {
 		struct disasm_line *tmp;
 
-- 
2.45.2

