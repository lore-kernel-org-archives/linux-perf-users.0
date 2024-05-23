Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3F413C9CA
	for <linux-perf-users@vger.kernel.org>; Thu, 23 May 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456573; cv=none; b=JpMJgGJPZIf7LcpoC1bxUTmj8eDafa+AtsIcncduPeEgliSNqQJflyeovDPEN0olRLyvudts3drZ93yTLv3b3ss4opCecM8Njk7xSKS2PmTSpVALuGgnBlPBcUdDEcQC6xHpoiikgMTnmYd9ZAj6+mzi/Llz2vgJ0Pzc9D9VKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456573; c=relaxed/simple;
	bh=2lqPOceltLwRczEmThPV0eUtcRU8lZHDrOgk/+NdHEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dh42ju28ckI0mAJmqrUOIR8/sP8mK/wc9FWGTXtcAb4hM9EH5EdM/rJ20tN4/KJEnjXAqnJhZClQjYT/en2L6RiefajlFgNBe/udPTuokdIlFFa/iSXxlcuTfa+v67Fc2iV+tj2DLGSQ0ACFe9NW1hO7K3o5XMi742x+UqkvJrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dX9GinmR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dX9GinmR"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso26213330276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 May 2024 02:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716456571; x=1717061371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x33LW9A7dVK5EVTAPgwg05LtwyjW2o2CH4TqOgwA89I=;
        b=dX9GinmRCYwIFe+NcXXryKVS69kypLcy1Afnz3NiYe0Wz6ucK8uPOD1xkNSfWk9lrT
         NlQeEZCHQ2t1mZXQszbzD9S6g71odIW7PUFRSkK3akmOzaXhj1lHKjYAqm0Ry6+4mqqn
         KhyCWzwra8kxaYR1y6wIWBlMyFZc041Q8b3da2VPBPnRcrVkDPS0uqmI4h+Bt+EGqslh
         xpN8r9mAswaS/6UuRjnBx0onetszfGbCrLBv+osxqbS+o7SJgwkkqtFBDSj1Wuf6M+r2
         LJVOOrgrjsrldqKuVGoMi9F4PCssA7pXNDz/aIGeoB/kbXzDeXvzms0Q+J0D+RBLC8Rk
         WxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716456571; x=1717061371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x33LW9A7dVK5EVTAPgwg05LtwyjW2o2CH4TqOgwA89I=;
        b=w3NwRET4eWZnnW5bwwVY+Dl+TZQXTmfzv2s19G92rbzrhHjB7cHNHe4R1L5Jbe/1iE
         77RPTRD9xauwo3RxoOE4rofjLl2t4O/b3We695eDSZwrvukkcVeEbPwYKnOy+fQuVBFy
         GWSPZkOCdDKdj6dOLIUm7u0KWbdXWW7eNQ3CZHVjcur2BVUjPEt1v9Ip3bsh33P4vdg7
         xYXPUfetkZoUIEO8c3cH7qyALrSumZl609A4+MgeuW8HNoJa9oOIe47YaBjsZw5lYFP7
         K66qMBG/17u9yUPzkZZV9DJ4QVpZD1WMgXBEK/lT1th8agA8EFcWc0eL8EVlfjciRFa0
         k32w==
X-Gm-Message-State: AOJu0YzYMTyI3WtjTG+BVsPoHS/vTlVpJEQCtHMOWIsCjNg4ZjTGzzOA
	Xc0mfju0h24NURASOWX7pODbJ50tXbN7bfqttgZANDaftoGHuhRAdyi9nZ7pVlbM3Kl8ouZU/A=
	=
X-Google-Smtp-Source: AGHT+IEfMbrKWSNbzDrKw3D76A2VbdpwOn8nW8nwlQhV+NWo3QiOCrd3hQttodNY+bcD+Jc9Jm8ukkeBxw==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:4571:1ce:5c15:9ee])
 (user=sesse job=sendgmr) by 2002:a25:c593:0:b0:de5:3517:c338 with SMTP id
 3f1490d57ef6-df4e0dbe5c4mr1321820276.12.1716456570796; Thu, 23 May 2024
 02:29:30 -0700 (PDT)
Date: Thu, 23 May 2024 11:29:19 +0200
In-Reply-To: <20240523092920.3355004-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240523092920.3355004-1-sesse@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523092920.3355004-2-sesse@google.com>
Subject: [PATCH v5 2/3] perf annotate: split out read_symbol()
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

