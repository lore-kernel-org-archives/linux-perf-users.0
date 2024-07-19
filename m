Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343BB1448C9
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401269; cv=none; b=XZb2UFOSUJN87YKmPOEr+q5sXVugPJ2b29P94loe2jT1hMmz9IQnXU6ta9wufcs9KsKrC3BM6o7Dh41j2dXSsbWpYe3UwvD2PlmnOjGN6qwb8AHMXJcWELaAnZU+ylWMwCPB06sr45HiI7YQXen4B/40MMKBsDcgJUHJxW321Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401269; c=relaxed/simple;
	bh=87DblJGlC4okuRwOIcQOoRy/+hVmnRpUFk0Ao5/2Jd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nnHpn312heMSL2jpPOgXwQqNjCCToPvhUA9pQHdED8rx7eY8w1kN3i9CHtEArR/G1eoT+4OxT0/K9dnXEYukINjAdi2oozWqb2kGJWF/+C9pdEd9tA85nn3bAGAwwCSE4JdZpkrDpR2jkbuneiUg9b52eZaDt88e10hcb8tqy3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HG9zLknl; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HG9zLknl"
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-52eaef92c91so1844892e87.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721401266; x=1722006066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPiADhp3bgAoFT/E9bp4X8n3H9+3Meo8ZcVJRc4Pjz4=;
        b=HG9zLknl/zyFzDYYxtjtq0SYCgFcGgHDFV0o8LZjCnHgEmiWMCUNIHfcK406ckeoIF
         PlvlQUXz0hcaIX93MLwpJuKDH4t+FthmXNHIcNTpNuBcdU0JR17SE+Z/Sc0ToehLmwlW
         m4aqKnBXsiRoK1ChuQH33AHZMg4HdvAPkqGRp0F4J7EZ17eq/mfIYZvjH5EwzEVCm+ak
         9CFvLrL/Q2gdntS5qTwEeKaprs7jTNmYnOTmpI6ahfqqpc+QfEp0giVsKkqU6A7XKZiI
         14QYhomEinQCK8yO6NP94m4E8j9CPCzPzdi2cHtiss5zBmSseg1l8kvIH8G9efR0RkY/
         l+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721401266; x=1722006066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPiADhp3bgAoFT/E9bp4X8n3H9+3Meo8ZcVJRc4Pjz4=;
        b=OgP6PnYsjZQM0gv9RAEzQSDzBj6sDWMJ7nvtTSGNSk+jpB7rEN1FBBcywwf8sblJee
         nUt7IO4uW+0ekFLJNuy2wkIpWZnWFHNPPP7Rd2Pj6aNDi7DMN2nNdbVN3zblBKznJIjd
         d4Kuc5YeBZwxiIhdmkocXttXtWcxQ6uLZfod9flS1JkKDWfO24agJmSYECAvfCgRKxJQ
         1+/YMOH3Q1lAuOOJhKm5XivEqQgB+HuHZmYg/b5gWLRDAZfahKgSOC8s4bQHcReiqpw5
         7dmQjVpjFa6A4ChXgvDol+oohwhhiZDT26Tog8XiCNsObgvmFRYn61ORLfrmCv/sGu0S
         TPrw==
X-Gm-Message-State: AOJu0Yxz4aNFcM+u8lpCUFI/5+D78zJIt0czp8+js8t2fvbJDZ/nOvLj
	Ma6QuW5Jk086yS10l8wsP1OJgtAftpPd4fzNw1zY6j+dT1sYnfTw/2ZBQG+7udJBl9sPU2tS1Q=
	=
X-Google-Smtp-Source: AGHT+IF01xM8sis9k4S+aD/RJv22V9m+Lh7lwmMtVudGWDKhp4L5ijA/Vvg8nqTm+bo1HznyIXwS+g7hFA==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:5684:1eca:607a:2a0c])
 (user=sesse job=sendgmr) by 2002:ac2:5682:0:b0:52c:d951:ba3c with SMTP id
 2adb3069b0e04-52ef07ab082mr5671e87.6.1721401266427; Fri, 19 Jul 2024 08:01:06
 -0700 (PDT)
Date: Fri, 19 Jul 2024 17:00:50 +0200
In-Reply-To: <20240719150051.520317-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719150051.520317-1-sesse@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719150051.520317-2-sesse@google.com>
Subject: [PATCH v9 2/3] perf annotate: split out read_symbol()
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
index e10558b79504..9be2becfe6e8 100644
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
2.45.2

