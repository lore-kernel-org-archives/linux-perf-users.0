Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E21A94D;
	Wed, 13 Nov 2024 00:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457294; cv=none; b=O5Ip/GqKld+GbQLzwPO+9D9gB+onDgYx/m3mNSuPbhcgGCOEFiVj4kKVAPpw3ds/qT4D6EVdUal2+3N8868IowF9TnodIeRJv1AgMdtc9lCQ2imFpfYorqDnnYOGInof9GpfmYQBdIQGktEO16RMjcrgkOCPNyRZv0QSzLKw1Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457294; c=relaxed/simple;
	bh=NXm9VIGnXBuPX2uXqBcTsu0hycgZmYlibNvd8eucasE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2PFD46HM5nXO6LPVryZ0h8Q6NMeXPVRkdAGo5e/PbOwBVcQJj5q2CwLxhznvBgLbnujyJDlieLM4TRH0WHsc+7RsEFPHcNmg/yLjoQJTUaI+aovo+DEJJ2u8d+WsXfxQ644md7Trti7PexuK1NN2v1miy+pE32G/VyuZ3tukNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNUbHycM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNUbHycM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0412BC4CECD;
	Wed, 13 Nov 2024 00:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731457293;
	bh=NXm9VIGnXBuPX2uXqBcTsu0hycgZmYlibNvd8eucasE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNUbHycMzLurQKbmt3Ai2krIRcX0fXulIpm62gfN7iaPdau/q1kc2GLNyCFM4ti1S
	 t1xwCAeP050+pnYD3hGwPB6LbgXmeJu5r+fby6yJwGWgdS2LuxM2qTMbtzj3BxpLLO
	 pEt03ZfC/aseJfivf9o15zTriMfNRtjIBVyQUyWQ4F/ZsJoXPouI/OoeCMhcVTLgQP
	 5x2S7xNfj7xew4ypgORNd9PC9myA7WcSjplQjK7d54qnwow+3Mq2YDX5PUdImnqiNj
	 DFL7RuO3geBHBGumTK7U9TaglWwFR/+UYnnCffHqUYC6wf2qsF8LyQ9SQ2CgPN19/v
	 h+BSgSc6CzZyg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] perf disasm: Fix compilation error with stubs
Date: Wed, 13 Nov 2024 09:21:30 +0900
Message-ID:  <173145729034.2747044.453926054000880254.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
In-Reply-To:  <173145727287.2747044.14103970580490941023.stgit@mhiramat.roam.corp.google.com>
References:  <173145727287.2747044.14103970580490941023.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Commit 333ea1451083 ("perf disasm: Define stubs for the LLVM and capstone
 disassemblers") introduces stubs but that causes compilation errors when
LIBCAPSTONE=n or LIBLLVM=n. This fixes those errors.

Fixes: 333ea1451083 ("perf disasm: Define stubs for the LLVM and capstone disassemblers")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/perf/util/disasm.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index df6c172c9c7f..88f71f6e5e70 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1422,14 +1422,14 @@ read_symbol(const char *filename, struct map *map, struct symbol *sym,
 	free(buf);
 	return NULL;
 }
-#else // defined(HAVE_LIBCAPSTONE_SUPPORT) || defined(HAVE_LIBLLVM_SUPPORT)
+#endif // defined(HAVE_LIBCAPSTONE_SUPPORT) || defined(HAVE_LIBLLVM_SUPPORT)
+
 static void symbol__disassembler_missing(const char *disassembler, const char *filename,
 					 struct symbol *sym)
 {
 	pr_debug("The %s disassembler isn't linked in for %s in %s\n",
 		 disassembler, sym->name, filename);
 }
-#endif
 
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
@@ -1724,7 +1724,8 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 }
 #else // HAVE_LIBCAPSTONE_SUPPORT
 static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
-					struct annotate_args *args)
+					struct annotate_args *args __maybe_unused)
+{
 	symbol__disassembler_missing("capstone", filename, sym);
 	return -1;
 }

