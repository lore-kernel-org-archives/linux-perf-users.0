Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E938E375F7B
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132793; cv=none; b=b2yv085ZsH6hG8c7hC6XXQKVC7aneDN3cfMYpYzUY7qwZdgQBzNanJCU/vtv5exOQKFvYQN0k+NlCxZBgWU4OKrl8r7fP10FukysZYaK/a3Hqm+Xe+XPLCPOt/kcQmXmDn2emlzMkqywXvgcwEHNN/sDooMcJYQJY7U1zcGlKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132793; c=relaxed/simple;
	bh=W7aykjoyBbylMpYRDhNpVy4JaXYOTxDSysjIdWEphu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W2tQqLHrAdhIiWZxuxCJBXttBjO2Uglo8XVPWSMn1txb65zTubafGSjU6W9N93uPqUutWEoWTsNvLOkyHVWqTSdvPGJNssxQwEe+SjV9cFSfBfkil3fv/1wuWDHKU6EBHrWbPdbxWeTN1faxpMzUECvFutZoyUogoNA42nsUWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csjrr8Nu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csjrr8Nu"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38101f85591so1730918a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787132790; x=1787737590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LTPJgMacEEKmZpqtZ6rnhlmPI98eKwXOy18WSdJ9udI=;
        b=csjrr8Nuk3RLul/xKLLpIX0mzriZdU+UfdX2qqy6v8erBx7ASq6Auws/BdiSoqtsuj
         lbHwXYhnwAbejVJui9/syExr4+PIHDgzmYcEEa4a6i0PipcL4Zw/3j/y5q28pg6JCpBG
         3hCOMVD5vb0wsv8ABk1zx9bMX+LcX9Mm0meanKqn/QnwthNYeG+c2+d3M3oHlCy0hKhk
         AXKw76IjfXvNzHrimWx62UtmcgxCyH1pKVsJign1+6s6P/JsTKu9wfjCaUQJXkjC2o0U
         wy+dhNjkeRNvgpnHQo1QEsWx7IxhHaxeiunzC4DQvSNuc/JI5f+NMNuZ8GhQClVV0r2p
         LinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787132790; x=1787737590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LTPJgMacEEKmZpqtZ6rnhlmPI98eKwXOy18WSdJ9udI=;
        b=rAk5LgqmA7gMPpBI2Lg3cppqJutH/FNOWrdV7AEixMsfF6AKeJJMbziJllqzsUHnl6
         BQJmx/Xqv0OOg+rno4kta+Try1kObu2Pzk9qLcXA3+x/+zuL5sVrAK/2BzFr9X95IV3c
         4yejWLy1fVPNfudIDeLIiUfSxku6EJ1czgN+GJvRL3MVeiRzx4IsN9SAwpoahRGgzir1
         HinVlfmpXUuXSraDr2I8i123Rfk2TiZeIKaK/dvuGQw0iXx5xVRrZxmvekm8iXbbx3SF
         0v26HIJKaOVdKwU2XXBV9RAh4qVTOb679O9si0JKWLRTxvOn28atHWXFOSR9mVihvAxk
         0awA==
X-Forwarded-Encrypted: i=1; AHgh+Rrt14j6T+bMp39LE+yJ/xYB5vz7y6NL09oCPAyFqS/ZBTa8MCUdwT+aBnpJZcEBFc4Xo+q5EGBXjquWFwrWk8lD@vger.kernel.org
X-Gm-Message-State: AFuF++nfxcIaOW7GdLmVzes+JuAExTXYYN6jCxAMmCpKVYNN4wMSuYsW
	tUYZNSIY76DW8A3NGa6/lQSl3RMSyEntPpMV816vYCwtJcUxazlnuUrZ
X-Gm-Gg: AR+sD10USEznX0tAErSf4pswRNpTyKNitbeHyIuwEWxpJUarnEj3RvxaXZSfI7f+igw
	IYN5vlc1Mcm0+SVo3lF5cW9bD0Gh1fDxTMcQs0mG+0gTL1FBiL5vEWkkBd8MmjAnj0GHgf40yjr
	XXz3fFJv2N01h7cpYHD0mZpH2pwz5Kb4do55fANjZ3OVgfLumWGgowpSbh1BmcUklenWPCTw/mp
	UDLRZClxIeYyjCZA/44jpCCKeWW2sDtE67+oV9vHVdyTufm+NoqM3xHQAhrdPF8rqMo91w/1CMA
	9DRanLzsRYzh6t43WZe0jzBbC/yaogR323Ju1Wbysg4e6SxYYMT4uauZfG7mdntxIuFDliTEg5e
	5DpxBssC7qUGlqanSNi863arKPv6+SRi8XUBwSBMP8L+gTeerXF2ofwPfjBI67g586cMPsFpQ6F
	Hp37EGJA+CZpAFbs1D6GyDpMpdQHWy9sdEmJjp5WFj2l3gBcIfRINboMyimo024EdfsHuIjCDU
X-Received: by 2002:a17:90b:1d0d:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-3957f8f8c35mr3586642a91.5.1787132790157;
        Wed, 19 Aug 2026 02:46:30 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb17eb5sm2460684a91.3.2026.08.19.02.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 02:46:29 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Changbin Du <changbin.du@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	zhanxusheng@xiaomi.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng1024@gmail.com>
Subject: [PATCH v2] perf symbols: Don't apply the symfs layout to synthesised paths
Date: Wed, 19 Aug 2026 17:46:21 +0800
Message-ID: <20260819094621.844115-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

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

perf_basename() yields "" for a path ending in '/'.

Tracing the lookups against an empty symfs,

  perf record -o pd.data -- sleep 0.3
  strace -f -e trace=openat,newfstatat \
      perf report -i pd.data --symfs <symfs>,flat --stdio

15 paths get tried.  Four of them differ, in every case only in the
prefix, which the patch restores:

  FEDORA, UBUNTU, MIXEDUP_UBUNTU
    <symfs>/debug/  ->  <symfs>//usr/lib/debug/
  BUILDID_DEBUGINFO
    <symfs>/        ->  <symfs>//usr/lib/debug/.build-id/

The tail is dso__long_name() for the first three and the build-id file for
the fourth, the same either way, so the build-id file was being looked for
in the symfs root and the distro debuginfo under <symfs>/debug/.  Those
prefixes follow neither layout: perf's own prefix is flattened while
dso__long_name() is still appended whole.

Among the 11 paths that do not change are the basename lookups the option
is for, <symfs>/sleep and <symfs>/vmlinux.  The same trace with
,hierarchy is identical between the two builds.

Use path__join() at those sites, which is what the helper did for them
before.  A hierarchy layout is unaffected, being that same call.  The
OPENEMBEDDED site passes "", where perf_basename() is already a no-op;
it is converted for uniformity.  Every remaining __symbol__join_symfs()
caller passes a path from the profiled system.

Fixes: f182573e06ab ("perf tools: Add layout support for --symfs option")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v1->v2:
- Added the traced before/after to the changelog, as asked by Ian Rogers.
  No code change.

v1: https://lore.kernel.org/r/20260811050046.4019578-1-zhanxusheng@xiaomi.com

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

