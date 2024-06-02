Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ECF78C69
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Jun 2024 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717360939; cv=none; b=dzlrfW38wxF7U7GEWTDBkdwYKHtIKPc8ecexMmLNhTvhkpXANLMHlerLvTSifE58xmccbK+Gq3LXeY5rcz6gIcoFdF2V1nssufSn00IaryQRFozapBZFpOrMZB+sjvkc3SdgonXoH1QjbgFGC4fIlkNiDquq6yNscC6I7MV9/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717360939; c=relaxed/simple;
	bh=2lqPOceltLwRczEmThPV0eUtcRU8lZHDrOgk/+NdHEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xi4FI6CYyS4jam+AnTffN919hqeC8NmJFhBAtVfxcJY+VrpDWRKecVFkNU/uupKxxCMTwhrUGuphuh0gFTK0TnhFnitLFpMoA+vmLht+vadAAbsuBEI/9HdtXGF/lW1TQuZk3kclY8txcfCwT33ugcN3UErkDhYpOtZrxT2Mj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d0abT/Tz; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d0abT/Tz"
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2ea9abf67d2so8812131fa.0
        for <linux-perf-users@vger.kernel.org>; Sun, 02 Jun 2024 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717360936; x=1717965736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x33LW9A7dVK5EVTAPgwg05LtwyjW2o2CH4TqOgwA89I=;
        b=d0abT/TzL1TJQ6V+1hDDJ8LpjLbl0vjEMN5i/2l83ugQLXu10cN4o72KpMsyMFzqb9
         8uewB9fJ9++qa8rmJbb0e8nsvftLLZxqqUva/8/R6c9kkHGTINqbMtNX5OR4ULrdvzLU
         ESTxpoABa/bpvhtHTHQ7yY2egTT9iFQYtyCMNib/5pmd5P1xnXZRLi23fHk/WGZkKOw/
         U0UQPeS+FhxjlIWl5njDoIV0+4H8C/pxj33Ru2AlsPwLBQwb/3wh7HsjfSilJ4Rv4K5R
         j5L57f5hVmgWLQOOTLeeMg7/whPhwNA6/pZoBPt+NjEGB2E3m4MPnjxCT8d9ckn/zEhx
         8wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717360936; x=1717965736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x33LW9A7dVK5EVTAPgwg05LtwyjW2o2CH4TqOgwA89I=;
        b=NkH4z9aEBbD44r+eJdPU9olz5kBGCcugxpvP+j9h5bTxTJKngVC7RG/bSgjmXC2wdP
         NJTqX9TGJqiSYnK+yN6vSdwrz15Gi7ikNOE3solnKXaB2rSf7J7ixSAL747HTlfRhkN5
         QmhBLHgjCZJsMXg2MjURS+Q5QtRN5biUJLouccilSGp7LG7R9OGan2dYl7Ikl4SgjxjW
         PQN3Tp8HIR7Gb56k7paOPfgpCbly7o0ZMnyjk9xlTU/C84ZaLqYIT/AcCCM9skRmwcYU
         JNhNlcxNQxzDtoEeoCXtZTSXdxF5PTA+fJZntHYF8fDnDbKmyrX+/rxPbjKhQ2AjPAE3
         mTrw==
X-Gm-Message-State: AOJu0YxPSvH5G1VYVURruBiSm2qsWLnmY5jm9IZxzrL4lC804oh2jYRz
	WpAM51OlMqxCzOASzivlbQH7fdYTgXjxAbQq5ON+W55Jl7KkVkfzP4dMWCAt+BkVDtts50dkDQ=
	=
X-Google-Smtp-Source: AGHT+IGdyPoPeQMD4GrlnPMGe2Xbk3wMMNeLLud8vfLUFYVfkeJiiNNeyoKXeqzTkSpaDvGL3tLqRHl0qQ==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:138e:9906:1038:1841])
 (user=sesse job=sendgmr) by 2002:a2e:be05:0:b0:2ea:aca0:277c with SMTP id
 38308e7fff4ca-2eaaca02afemr15531fa.4.1717360935627; Sun, 02 Jun 2024 13:42:15
 -0700 (PDT)
Date: Sun,  2 Jun 2024 22:42:07 +0200
In-Reply-To: <20240602204208.735793-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240602204208.735793-1-sesse@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240602204208.735793-2-sesse@google.com>
Subject: [PATCH v8 2/3] perf annotate: split out read_symbol()
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

