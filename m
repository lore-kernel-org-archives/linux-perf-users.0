Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB831B80D
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786424456; cv=none; b=FPBBSOShd5wteXC36iOU42j4bcNMk1PohRdkdJetkltQ/8wOVBUSypWOjon2K5vIhMLt85Ovi9C9yBHf6jOMQD7uTCw86uvonO93+DBWAPIIQZ6P2ZpzOFvDMpsoD7TqtF8KwL4Hn65tzIcqUlm7guJOM7UPf59M8DtxNX7Ouc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786424456; c=relaxed/simple;
	bh=yuyBDXtIkxCZCrvgPb35PsZlLUmaE55ZmbM1gHuukS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vu/aGBfkjumKaT6ZNbZ8O/jNGfko3QLBkmkf2UuLEacvvcUkz8BzAEJf7bbUjSvmAFFht642+DawiG+kyfHzP+M6WAcncNdKAXJDYsIg1A4zpjXPn1sR4/WyhT3lp+9kF1/2AgdvmYQPoAhKUGldJ/hgEW4793tuIDCeaacCfn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzvJKUaF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzvJKUaF"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so1354528a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 22:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786424454; x=1787029254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DmyneajZ/FvgDHMSIizhnr+cBuZtaX9gxd+v2rQ+Hv0=;
        b=bzvJKUaFJ2/x/FGa6k1j78KDPhWrFlRXuFxTe6yK0piO+JmNrHcAq+oh0Vf40OcJkw
         3x1nPmkn6qG2Xo4zZZotOaOn46R/eCG7qacW7f0p62TuZwG/nfm4nxn1PzjUGPlCgL75
         1PzdfA20x+XmHP09ttQEbU4pJNdXuOZZEFk62DoYWXHVBaXsAD3KTLz6Cb5nZw11JP8b
         ieKKhM+fVDHX0W5Ehk3r9ZrAZoa9idX2n6ZLYrOHv6rEW6PpjhjuZ/YVflXEWLzQwt9P
         kONpLtSVV4yaoexAo5+ybqTlrSzhwKy9prCrhJDRhWTBUz54DPidQkAp2e3Lflp/zzMB
         AHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786424454; x=1787029254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DmyneajZ/FvgDHMSIizhnr+cBuZtaX9gxd+v2rQ+Hv0=;
        b=WVDJBHz8A19KR6cYXet2xmfQGSLZa3H8GjS1uak5P7ONrTHNmzowsq5QUvWsKaanAq
         rMn2+ELinajC1R8GKmE2DU8acUlbwz8tXyfGcoYU6Td0PWyIt3IS8kY6N6TZ31Qucovy
         SyZ80AHEOqP74LlVIDFvSmSj40FY5Vimen7ZxhpBn9dr8G1+7rlJAIuVXIB95WBi1IkS
         NICbBmuJMo39BJXNMszBzqMPung2ZFPmzU/5NhKK6AWt3fZ6lZZPY2WyJ2/YvrVeGdO+
         XebxlyCfifSYv9jQ1GIIs2vEPAah08aX2PgYUlHld7o1KztsCNEZwOkeBcyD8XftkRvW
         MT+w==
X-Forwarded-Encrypted: i=1; AHgh+Rr99xZVWt2rcnn87cFfiSZWxoYt2Ttuz6Yl6gbuaVkJN4/yeCisYY1bZ+I+eldSydK6aH2gOkQ4spfVmyU7VJAd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+BIJ6ZsLHLFsEZWfRRPecLSXyCKf+ZhDgB0zzLE5YH4hPocwy
	nm6ViWIdjPI5NammEiF+YWGmQb5w4ZZc6at7y6hS9mRnzT3q9B56AwIN
X-Gm-Gg: AR+sD112vOMjQQWkXa4y6ah4SgIEvhFxr4lmU8QvI4aZFfTEPCKuV/0nU3VYiAknCdH
	S+cOZRCZrtttKmm5rdhXiEz3ygh94wZz+OYgJRlUYmHXacO6f4b6puXOGuzXaNJrwUCA4UvOLrT
	YV3u2aOtLolLMOdVgEGmFBWdxmjGce3qTiuh6Se3N+DvQrEHmrgoWGIY52ZQlz81xFBArKW4nEH
	pH3BuKN18Z0DrwhO+Lmji/echDladVGGmSesv2n321R6TOXXO7c9CK2cVYNR5xb9Mj/esSqrlmz
	KG4mrrUtBa5tcSAIk27ia5ucJzyoodlE4TtpqaDzVaXkQChmX7kRWiZ58uqvScLjTnnYbmCBYlg
	R9PekH+CJGosdMVO3/sG1UPjgi+SuezIWfiYHbIbRF1m9KKIY1Ojb4YJatVouUTQbNNyjlnfzIC
	ZcxZ0p2CEF5tPcsdMZI3qntgbuxwtd9Ws1lWTZo48oN/eOszOlljFQZS3d7/vkvoO6YDNGeDMV
X-Received: by 2002:a17:90b:2689:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-392ec37c01cmr741842a91.6.1786424454506;
        Mon, 10 Aug 2026 22:00:54 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392ee3eab1esm147563a91.9.2026.08.10.22.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 22:00:54 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Changbin Du <changbin.du@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH] perf symbols: Don't apply the symfs layout to synthesised paths
Date: Tue, 11 Aug 2026 13:00:46 +0800
Message-ID: <20260811050046.4019578-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flat symfs layout was implemented inside __symbol__join_symfs() alone,
which went from

	return path__join(bf, size, symbol_conf.symfs, path);

to taking perf_basename(path) first.  No caller was changed, so all of them
got it.  Most pass dso__long_name(), which is what the option is about, but
some pass a path perf built itself:

  dso.c        "/usr/lib/debug"             -> "debug"
  dso.c        "/usr/lib/debug/.build-id/"  -> ""
  build-id.c   "/usr/lib/debug/.build-id/"  -> ""
  disasm.c     <file under buildid_dir>     -> last component

perf_basename() yields "" for a path ending in '/'.  So with --symfs
DIR,flat the FEDORA, UBUNTU and MIXEDUP_UBUNTU debuginfo lookups land in
<symfs>/debug/, the two build-id ones in <symfs> itself, and disasm.c
flattens a path under perf's own build-id cache.

Use path__join() at those sites, which is what the helper did for them
before.  A hierarchy layout is unaffected, being that same call.  The
OPENEMBEDDED site passes "", where perf_basename() is already a no-op;
it is converted for uniformity.  Every remaining __symbol__join_symfs()
caller passes a path from the profiled system.

Fixes: f182573e06ab ("perf tools: Add layout support for --symfs option")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 tools/perf/util/build-id.c |  2 +-
 tools/perf/util/disasm.c   |  4 +++-
 tools/perf/util/dso.c      | 11 ++++++-----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index eb95ab90f974..0c89fe75a650 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -599,7 +599,7 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
 		dirname = dirbuf;
 	}
 
-	len = __symbol__join_symfs(debugfile, PATH_MAX, dirname);
+	len = path__join(debugfile, PATH_MAX, symbol_conf.symfs, dirname);
 	snprintf(debugfile + len, PATH_MAX - len, "%.2s/%s.debug", sbuild_id,
 		 sbuild_id + 2);
 
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 0a1a7e9cf3ef..decf9348d735 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -31,6 +31,7 @@
 #include "map.h"
 #include "maps.h"
 #include "namespaces.h"
+#include "path.h"
 #include "srcline.h"
 #include "symbol.h"
 #include "thread.h"
@@ -1173,7 +1174,8 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 
 	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
 	if (build_id_filename) {
-		__symbol__join_symfs(filename, filename_size, build_id_filename);
+		path__join(filename, filename_size, symbol_conf.symfs,
+			   build_id_filename);
 		free(build_id_filename);
 	} else {
 		if (dso__has_build_id(dso))
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 2309196d8df3..314c9a0edf28 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -167,12 +167,12 @@ int dso__read_binary_type_filename(const struct dso *dso,
 		break;
 
 	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
-		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
+		len = path__join(filename, size, symbol_conf.symfs, "/usr/lib/debug");
 		snprintf(filename + len, size - len, "%s.debug", dso__long_name(dso));
 		break;
 
 	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
-		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
+		len = path__join(filename, size, symbol_conf.symfs, "/usr/lib/debug");
 		snprintf(filename + len, size - len, "%s", dso__long_name(dso));
 		break;
 
@@ -187,7 +187,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 			ret = -1;
 			break;
 		}
-		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
+		len = path__join(filename, size, symbol_conf.symfs, "/usr/lib/debug");
 		snprintf(filename + len, size - len, "%s", dso__long_name(dso) + 4);
 		break;
 
@@ -200,7 +200,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 		while (last_slash != dso__long_name(dso) && *last_slash != '/')
 			last_slash--;
 
-		len = __symbol__join_symfs(filename, size, "");
+		len = path__join(filename, size, symbol_conf.symfs, "");
 		dir_size = last_slash - dso__long_name(dso) + 2;
 		if (dir_size > (size - len)) {
 			ret = -1;
@@ -219,7 +219,8 @@ int dso__read_binary_type_filename(const struct dso *dso,
 		}
 
 		build_id__snprintf(dso__bid(dso), build_id_hex, sizeof(build_id_hex));
-		len = __symbol__join_symfs(filename, size, "/usr/lib/debug/.build-id/");
+		len = path__join(filename, size, symbol_conf.symfs,
+				 "/usr/lib/debug/.build-id/");
 		snprintf(filename + len, size - len, "%.2s/%s.debug",
 			 build_id_hex, build_id_hex + 2);
 		break;
-- 
2.43.0

