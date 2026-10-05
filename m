Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4435F180;
	Mon,  5 Oct 2026 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182062; cv=none; b=nbvHQsgRJJGoBGzca/O7Ct7Vy1Ox8QtADwTi6lpAsL5lwrDGFq60f7pKxUTc3QS7WXws0Dzz1Y0twlGOUy+nyPpOkTeKHVuoolWTCn3CtD0cGla4TYf104C/neG2KVnaNQ7uTSGoh4UmPTSarNz5MBPpWyRrAdKoZilerGN+oz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182062; c=relaxed/simple;
	bh=GC2iVKLQvIpqh0qgJkJnq8niGFeiE3LhejPEtARgHpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoMyAaDozGH+P5pX834B6J51Dsq/aPRAqKXlmn0sRrFxbszfGDF0pF6+CAmtjveWXhTRgkLqgpgC2IwIhb0GDe9RNCjaRVRoFRFh3/rT1HnaQW0pJN1cr5kYy1necANj8RYyf0zmycbNLebvLRwk9OIMgIKpS3KunHsxGjGNFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeV0dv+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeV0dv+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4971F0089C;
	Mon,  5 Oct 2026 06:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182060;
	bh=M410mQvor5O7vl/IhPfvdl3FqRI2WEHOBHIImQ+/MQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QeV0dv+AMKpavfNZz4VGENFfXbJY+73vdaeLaf+PGiB5+iTSEu6NApLGfVYi3PDhP
	 D1OxFMNS8LghshluDI0Ee8JIA3rC0x2N0XwIi6zTrHRQcKrrCa+b62I8jwC16vbn8d
	 PoMz1e8qW8D1lehe4SIPXpRJ4ydH7xsZliiRQm6tRv78GplPtoN4xtXiX2g8aPD4jH
	 Ffqjs4HMAjuPFdCVmvCtFalNG2AfQsfmWWvly9iiuYlvXTAooVM3yXez0m+yWNUzHO
	 fQgLcGNh7n+uwJetHp6kISwvf/6QpiXl+49TUem3SJ1iB9DGobZ6uTtVWjE/mcRP0b
	 JIlovT6aCW1gQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v1 7/7] perf symbol: Do not set binary type from symtab type
Date: Sun,  4 Oct 2026 23:34:11 -0700
Message-ID: <20261005063411.114244-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005063411.114244-1-namhyung@kernel.org>
References: <20261005063411.114244-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DSO binary type is to access the binary (e.g. instruction) data
while symtab type is for the symbol table.  They may or may not be in
the same file.  We should track them separately and correctly.

As special binaries already set their type before loading symbols, leave
the binary type info and only update it when actually opening the DSO.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 389dbd7e5192f4f2..1175cb60f8206757 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1956,19 +1956,6 @@ int dso__load(struct dso *dso, struct map *map)
 
 		if (next_slot) {
 			ss_pos++;
-
-			/*
-			 * The binary type is used to find the file containing
-			 * the executed instructions, so prefer the types that
-			 * refer to the actual object over debug-only files such
-			 * as DSO_BINARY_TYPE__DEBUGLINK.
-			 */
-			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND ||
-			    symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE ||
-			    (symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_DSO &&
-			     dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE))
-				dso__set_binary_type(dso, symtab_type);
-
 			if (syms_ss && runtime_ss)
 				break;
 		} else {
-- 
2.55.0

