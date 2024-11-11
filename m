Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8101A254E;
	Mon, 11 Nov 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338283; cv=none; b=lCStw3ttWN8OWwuZPKlVTuobXQlWpSlPDeKGtfBjS7a0trgUMgHtSA0I35R58kIBVUpOtTc5t0Ta1V6gfG3XuLrAs1x52qVKPMoTrD1KwO0OOYQkQDCqdZPfZfiLlgBB16EaGZ4FIem8+LD1Q3lCnKGVddfG0RdGCoGjjJg7Fso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338283; c=relaxed/simple;
	bh=j/Cv6gy4XfZef1hgbCcWDH10UFHhy5vRK/6BCYY/VdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ls1SMszliniRDN8QjlPPwDNaztskt9W5OGlexxAdKW6hhO5WKmMK/rkCPOLJQplzpQkPgRIpzromKcDxJfiV9PRQvKgABsz3PIhNYMJYuugwkDZvpu+nuB3KvZ2H9+nBSygyv1yeThZ4ID7aspg6NMtkjdUIbVuOErpziwLsmX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9ESR5xv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9ESR5xv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C67CC4CED7;
	Mon, 11 Nov 2024 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731338283;
	bh=j/Cv6gy4XfZef1hgbCcWDH10UFHhy5vRK/6BCYY/VdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9ESR5xvS3j05PXYeDvnfMJca8TckRfABFEQVplaxrOUaZtm54ZBbWr07lHolBubM
	 nSZk/DpLO8+fivMRJ3xv7I3ITz64aiOtCIMzcYZsE0EE+IzkSJxtK633Sp88JmXG/D
	 GTkHNiEBfNYvp0uGxGnP/SPsyf0xlJKouUl/X2ZVqXkabhVEUb+fbWAT0npTdmQmra
	 sg6ja1hANBC1xAfghUdCpTUANx52mCnHXVk7NdhyaE49SVDqHrA7+AWieegZkhdPZl
	 bKHIuSFEkeAa6cmtINuaSVUbJUc5h/7duW5UlA/b4wvcHgATTtb3fGMBD95hdjrw1K
	 u+Mj/UAvHttnQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>
Subject: [PATCH 2/3] perf disasm: Define stubs for the LLVM and capstone disassemblers
Date: Mon, 11 Nov 2024 12:17:33 -0300
Message-ID: <20241111151734.1018476-3-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111151734.1018476-1-acme@kernel.org>
References: <20241111151734.1018476-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This reduces the number of ifdefs in the main symbol__disassemble()
method and paves the way for allowing the user to configure the
disassemblers of preference.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steinar H. Gunderson <sesse@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/disasm.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 36cf61602c17fe69..83df1da20a7b16cd 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1422,6 +1422,13 @@ read_symbol(const char *filename, struct map *map, struct symbol *sym,
 	free(buf);
 	return NULL;
 }
+#else // defined(HAVE_LIBCAPSTONE_SUPPORT) || defined(HAVE_LIBLLVM_SUPPORT)
+static void symbol__disassembler_missing(const char *disassembler, const char *filename,
+					 struct symbol *sym)
+{
+	pr_debug("The %s disassembler isn't linked in for %s in %s\n",
+		 disassembler, sym->name, filename);
+}
 #endif
 
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
@@ -1715,7 +1722,20 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	count = -1;
 	goto out;
 }
-#endif
+#else // HAVE_LIBCAPSTONE_SUPPORT
+static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
+					struct annotate_args *args)
+	symbol__disassembler_missing("capstone", filename, sym);
+	return -1;
+}
+
+static int symbol__disassemble_capstone_powerpc(char *filename, struct symbol *sym,
+						struct annotate_args *args __maybe_unused)
+{
+	symbol__disassembler_missing("capstone powerpc", filename, sym);
+	return -1;
+}
+#endif // HAVE_LIBCAPSTONE_SUPPORT
 
 static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 					struct annotate_args *args)
@@ -1983,7 +2003,14 @@ static int symbol__disassemble_llvm(char *filename, struct symbol *sym,
 	free(line_storage);
 	return ret;
 }
-#endif
+#else // HAVE_LIBLLVM_SUPPORT
+static int symbol__disassemble_llvm(char *filename, struct symbol *sym,
+				    struct annotate_args *args __maybe_unused)
+{
+	symbol__disassembler_missing("LLVM", filename, sym);
+	return -1;
+}
+#endif // HAVE_LIBLLVM_SUPPORT
 
 /*
  * Possibly create a new version of line with tabs expanded. Returns the
@@ -2242,24 +2269,21 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 			err = symbol__disassemble_raw(symfs_filename, sym, args);
 			if (err == 0)
 				goto out_remove_tmp;
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
+
 			err = symbol__disassemble_capstone_powerpc(symfs_filename, sym, args);
 			if (err == 0)
 				goto out_remove_tmp;
-#endif
 		}
 	}
 
-#ifdef HAVE_LIBLLVM_SUPPORT
 	err = symbol__disassemble_llvm(symfs_filename, sym, args);
 	if (err == 0)
 		goto out_remove_tmp;
-#endif
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
+
 	err = symbol__disassemble_capstone(symfs_filename, sym, args);
 	if (err == 0)
 		goto out_remove_tmp;
-#endif
+
 	err = symbol__disassemble_objdump(symfs_filename, sym, args);
 
 out_remove_tmp:
-- 
2.47.0

