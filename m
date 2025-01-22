Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC65218EA0
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567817; cv=none; b=BY6L9OlUbPW3Oj+IjKOPFJc5jWAWaQ+hzd7seXyXsOUp2PqUieQ81bev56xZ7qWmDvuMAw6V7qQ9ljYlHtxhC7HZhWXtODiD40C6xUCNhueqPh2IIRrJEPxaj8Q/iX4Pm7afHngEGU4H/WHn9ToanNOs4fAxFQDMQeLXOCL4aU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567817; c=relaxed/simple;
	bh=+03tdY5KGNvyvNiOCMV0afub6gFxbdx5jud2IWZ1j9k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cl7OzpjRsbfceWwUu7OsC/oKnw/mUiGNtfmq7yPAwV/0hJWAExU9+8ezA3Kb1gqlKCgaxC/3OY3qQme1OHQ+gXXRhB4qAf63SD18AmmipQ+hRanXc0Ceuo9sAZbqj6j5kqqwlNa4hDSrJviEV9X/f831gCpwReWZXqgNlehE3/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gLDMiIxy; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gLDMiIxy"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e578b0d2afdso18712828276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 09:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567815; x=1738172615; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRFZdVOFEB5jpOd1Cxa6TlzHLl8llv6uLnpkZ8MYu/c=;
        b=gLDMiIxyR/QOL5FZNvD/D1F+EhOPSf59VrzBoH81qTYGu88nLf1qQf/W/cojFqU9L+
         ijmkhBP5ASk6+Y/VO5Wv78nwBfcfqM9CkwqCg7yUKFMFMxxl0xzKVVL4F9iof5qnbZ1B
         xONg8yRZXu5OdIwJw0O4NgOHLYqN6p7zFB3S6Ifa1p0kIrxZ95dillQbumYRZ4MT5VYU
         inx1NokQOqaEj2IAr+YA1W2ETskxu2C0c4M0qLUYt5/VfIp++WdkHgadxuBKd2VgGNds
         QTleknSRD5CMvn+JrAuvavD7mTCHwwjqf+EyR3HS9/oGE2Wj3Eep0aVQ1hp9KPmAwlze
         SsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567815; x=1738172615;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRFZdVOFEB5jpOd1Cxa6TlzHLl8llv6uLnpkZ8MYu/c=;
        b=Q8zLCR7mj+vcfkRNB7c4ZHiygQ3ffPMIMx7jrKKbeZqxPcWFqqABOtiXEnUPxu5fWP
         LX2oo5FjNK4iHWbobfbeqnwMWGCqANKavYCAFmQkcC7Vbca/dO7ST56GD6MKS2Zw3sKY
         eo9P9QoxK+7OLe9uT4TGDs98NN2A+ODoYr72IX3BHF4Vbi3omrt4PUdfvpGaWwDyG5+I
         lzdz7biMyw1rfUBrdTewguaXBUPdWB3CAxo7TRkMrJCC7qERmrwIHalq6Oan8UCLtuq+
         0/STM5IagnekW2OdU85qjmapu2Ks5EJihAgckCsgx9Jagfx+q1nsEJ3mnJ1fSKr5Im2U
         XzFA==
X-Forwarded-Encrypted: i=1; AJvYcCUwl49jOJn5iIXi9WCdezckVvS71Mb6Rgs6VF1t60FNSd4vyPQiPyLb/YxmAGibBQyNLSfoO4L+L5a3iUjLUVet@vger.kernel.org
X-Gm-Message-State: AOJu0YwDaY6avlWZ6iDEcrOrhe4ELquu0C8WljvBJF/Nehax0Wio3u0V
	XrQtnZRI4eFV6L2kgJeF3Mdk185Evp87IrXfvQsZLByLpnvd9SoG9y2trFJowLxYKj2paUjvx1e
	j23iDxw==
X-Google-Smtp-Source: AGHT+IEj/XBSnaP/UpkFzpPLq4MoOjXCK6Fr7L3oe55x9qJdgxkD9WGInbg5+oF+g2rRNwEY0Tv3myAROalM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a25:a301:0:b0:e39:7284:4f8d with SMTP id
 3f1490d57ef6-e57b12fe645mr44001276.5.1737567814531; Wed, 22 Jan 2025 09:43:34
 -0800 (PST)
Date: Wed, 22 Jan 2025 09:43:00 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 10/18] perf dso: Support BPF programs in dso__read_symbol
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Set the buffer to the code in the BPF linear info. This enables BPF
JIT code disassembly by LLVM and capstone. Move the disassmble_bpf
calls to disassemble_objdump so that they are only called after
falling back to the objdump option.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 12 +++---
 tools/perf/util/dso.c    | 85 +++++++++++++++++++++++++---------------
 2 files changed, 60 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index a9cc588a3006..99b9c21e02b0 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1500,6 +1500,12 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 	struct child_process objdump_process;
 	int err;
 
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return symbol__disassemble_bpf(sym, args);
+
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE)
+		return symbol__disassemble_bpf_image(sym, args);
+
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
@@ -1681,11 +1687,7 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 	pr_debug("annotating [%p] %30s : [%p] %30s\n", dso, dso__long_name(dso), sym, sym->name);
 
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
-		return symbol__disassemble_bpf(sym, args);
-	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
-		return symbol__disassemble_bpf_image(sym, args);
-	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
 		return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
 	} else if (dso__is_kcore(dso)) {
 		kce.addr = map__rip_2objdump(map, sym->start);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 0285904ed26d..a90799bed230 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1686,48 +1686,69 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 			   const struct map *map, const struct symbol *sym,
 			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
 {
-	struct nscookie nsc;
 	u64 start = map__rip_2objdump(map, sym->start);
 	u64 end = map__rip_2objdump(map, sym->end);
-	int fd, count;
-	u8 *buf = NULL;
-	size_t len;
-	struct find_file_offset_data data = {
-		.ip = start,
-	};
+	const u8 *buf;
+	size_t len = end - start;
 
 	*out_buf = NULL;
 	*out_buf_len = 0;
 	*is_64bit = false;
 
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(symfs_filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
-	if (fd < 0)
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
+		pr_debug("No BPF image disassembly support\n");
 		return NULL;
+	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
+#ifdef HAVE_LIBBPF_SUPPORT
+		struct bpf_prog_info_node *info_node;
+		struct perf_bpil *info_linear;
+
+		*is_64bit = sizeof(void *) == sizeof(u64);
+		info_node = perf_env__find_bpf_prog_info(dso__bpf_prog(dso)->env,
+							 dso__bpf_prog(dso)->id);
+		if (!info_node) {
+			errno = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+			return NULL;
+		}
+		info_linear = info_node->info_linear;
+		buf = (const u8 *)(uintptr_t)(info_linear->info.jited_prog_insns);
+		assert(len <= info_linear->info.jited_prog_len);
+#else
+		pr_debug("No BPF program disassembly support\n");
+		return NULL;
+#endif
+	} else {
+		struct nscookie nsc;
+		int fd;
+		ssize_t count;
+		struct find_file_offset_data data = {
+			.ip = start,
+		};
+		u8 *code_buf = NULL;
 
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0)
-		goto err;
-
-	len = end - start;
-	buf = malloc(len);
-	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, len, data.offset);
-	close(fd);
-	fd = -1;
-
-	if ((u64)count != len)
-		goto err;
+		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+		fd = open(symfs_filename, O_RDONLY);
+		nsinfo__mountns_exit(&nsc);
+		if (fd < 0)
+			return NULL;
 
-	*out_buf = buf;
+		if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0) {
+			close(fd);
+			return NULL;
+		}
+		buf = code_buf = malloc(len);
+		if (buf == NULL) {
+			close(fd);
+			return NULL;
+		}
+		count = pread(fd, code_buf, len, data.offset);
+		close(fd);
+		if ((u64)count != len) {
+			free(code_buf);
+			return NULL;
+		}
+		*out_buf = code_buf;
+	}
 	*out_buf_len = len;
 	return buf;
-
-err:
-	if (fd >= 0)
-		close(fd);
-	free(buf);
-	return NULL;
 }
-- 
2.48.1.262.g85cc9f2d1e-goog

