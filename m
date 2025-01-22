Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A87215F53
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567821; cv=none; b=d6aW9wUwQAEDps0OCiFchFur4dqmRYIUw/mA84licytR3EhlKt9kswJtccWjxkYrrV5HnCE/XBAr7FH287fB+Okkyml+eu9OXEOCliqVSfw7RGItZzAd5wvUydfP6YzY15ZqwAZfWHIxHG3sv4b4oLXPnyUG59lMHoHVkOyORfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567821; c=relaxed/simple;
	bh=qDGVbxupBPhehpggHu43Ttvfz1Jydc4UfVpiUQ9BNUw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SSPK5mLEnwGpGgEQBvCypdM+PWyGXUS+mcowbXRP3ro2iTwrEUqz1WpR6yqzy/yV3pO4ByzPR2hXubP6ejwwBdxkCl8A8gcBywn0YTPWHB9D6/Rg4xc9I1nMHTAHswul2RX5DAl8eeRZjkdpvtoRG7E17jl7hSEsQxiq4PXVKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dlq/2Gyn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dlq/2Gyn"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e572f6dee18so15979276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 09:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567819; x=1738172619; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8iKYF3csT963Oh0FXrUrlrS8IS249puoLm4/xmteLU=;
        b=Dlq/2GynidgaXxIKElqlIRz5xJcHp5p/4+YBd/d+ZI2pU0u0kDMLkPQQkfx1WYpKn4
         THfhprr7hckpY+wqj2KqRq5V2niH5hrwg3p+8f2DYf9eg7FEyItEk5gXhSgv7RJy+Ke9
         y04QnIctg6SwAJnodM/1AeDSlIgCWHnIIJbUbzkrDNydvZgETHnMeVpXXebC8Hm3pvlY
         zRqs5fYgX7cwOUp94rEqJ3FWlKRT6uvw7uFGSLUiO/Zmc6tbRtQ/2TgnLEIbE+ripjJm
         sdgWh6ospjum0oCeB6StkCSRbAljU0d1XO9J6SPo5vNojczLdZk4QJJme2/nchfDmsBG
         0jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567819; x=1738172619;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8iKYF3csT963Oh0FXrUrlrS8IS249puoLm4/xmteLU=;
        b=sXbtuO7uvtK/L5JSnBNa69/plwW2Ug6sJgv2MaL6mdFQokMKZ6V9rgOeN22etOzmAT
         Dq27OXMmJKDCiDDCuKHcPPPm7uy+6XD5ARgrDaUx5ckgMhJXqhguI+m6WK4YaxHOmjbX
         1KZXNz7CSMNPRJe25XnIr13ftVW5YGj4MP6ZUiqv6bHKnp1X64tddchNgpZLMsafNBFl
         VDS3lP5Qyo8Qo019EPif6lymrH86Gd3zJoIH4fHW84lX7Ik2LpMHTfWsrfJ9F2gM/GTz
         lFgM8Ui6EruUxWFqttXJmw3vag+xAnE13FXr5BlOio73PUcnPT2m3FGr1JQLsYeILQRT
         Gbbg==
X-Forwarded-Encrypted: i=1; AJvYcCVIs+fGTB/hCWAt4xIDY2t+pGL7MxVIna0yo+OecvDn3q47ovaeXi0z2oQu1Yvfz0krkxJW5L0J5T8sCcEJ30ek@vger.kernel.org
X-Gm-Message-State: AOJu0Yxse6GE0fn+NOpAuij4cQfiw04eJXmqv3GoVLMOeNrEpROULmQi
	ZOF6p7NBayR9xzz0nTgGDM+P5/B2ufScoGw9GttCutagxVMdyo8d66ccqMNTixRqkkdW9MocLHU
	c9ToLNg==
X-Google-Smtp-Source: AGHT+IEtRfnG1IrLEczd4lBlgALNrOa6BIlr7CTXw96GqaqmTOdAqOOF5wM1aeXH+2lC6ztXYgWsTiZsp3cM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a25:b291:0:b0:e3d:da4c:7981 with SMTP id
 3f1490d57ef6-e57b138d74bmr40604276.7.1737567819204; Wed, 22 Jan 2025 09:43:39
 -0800 (PST)
Date: Wed, 22 Jan 2025 09:43:02 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 12/18] perf dso: Clean up read_symbol error handling
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

Ensure errno is set and return to caller for error handling. Unusually
for perf the value isn't negated as expected by
symbol__strerror_disassemble.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c |  3 ++-
 tools/perf/util/dso.c      | 14 ++++++++++++--
 tools/perf/util/llvm.c     |  3 ++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index f103988184c8..032548828925 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -12,6 +12,7 @@
 #include "symbol.h"
 #include "thread.h"
 #include <dlfcn.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
 #include <string.h>
@@ -463,7 +464,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	buf = dso__read_symbol(dso, filename, map, sym,
 			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
-		return -1;
+		return errno;
 
 	/* add the function address and name */
 	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index a90799bed230..247e59605f26 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1697,6 +1697,7 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 
 	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
 		pr_debug("No BPF image disassembly support\n");
+		errno = EOPNOTSUPP;
 		return NULL;
 	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
 #ifdef HAVE_LIBBPF_SUPPORT
@@ -1715,6 +1716,7 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 		assert(len <= info_linear->info.jited_prog_len);
 #else
 		pr_debug("No BPF program disassembly support\n");
+		errno = EOPNOTSUPP;
 		return NULL;
 #endif
 	} else {
@@ -1725,26 +1727,34 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 			.ip = start,
 		};
 		u8 *code_buf = NULL;
+		int saved_errno;
 
 		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 		fd = open(symfs_filename, O_RDONLY);
+		saved_errno = errno;
 		nsinfo__mountns_exit(&nsc);
-		if (fd < 0)
+		if (fd < 0) {
+			errno = saved_errno;
 			return NULL;
+		}
 
-		if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0) {
+		if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) <= 0) {
 			close(fd);
+			errno = ENOENT;
 			return NULL;
 		}
 		buf = code_buf = malloc(len);
 		if (buf == NULL) {
 			close(fd);
+			errno = ENOMEM;
 			return NULL;
 		}
 		count = pread(fd, code_buf, len, data.offset);
+		saved_errno = errno;
 		close(fd);
 		if ((u64)count != len) {
 			free(code_buf);
+			errno = saved_errno;
 			return NULL;
 		}
 		*out_buf = code_buf;
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index a28f130c8951..1607364ee736 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -9,6 +9,7 @@
 #include "srcline.h"
 #include "symbol.h"
 #include <dlfcn.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
 #include <unistd.h>
@@ -365,7 +366,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	buf = dso__read_symbol(dso, filename, map, sym,
 			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
-		return -1;
+		return errno;
 
 	init_llvm();
 	if (arch__is(args->arch, "x86")) {
-- 
2.48.1.262.g85cc9f2d1e-goog

