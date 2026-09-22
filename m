Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85255292D
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083202; cv=none; b=RaBBbDd2jn3MML55yMuGXIc4UmllyG0uvdfXrs0d2u5730D2APwEY3KsxE/lwwgluH9nMrUlKm7ygDR0skSrXCqbDJ8fCA8raQz6ng2pPN3zvOa98yDlZCC+OEsSZibo2vhxNHjfxxV689FIVVQdAGQGhzdd6ICwE+f60VHaCPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083202; c=relaxed/simple;
	bh=hNqYfoxEta6yayuVGifvUciuQ8J6upVwEpfzs/v+b2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJo5dgf+rCa+KQqvA5EJOiHyy9akeI8FivqHTNkNfkpjaPFb+r0WqWZ/XgagZbdUIU8a/ynii6tXvuOLjIHnCGOEOSjEKQFQdidDv/sNNLI2aCBe4GnvKfe29KSFyMlB1uvm1z2m64g5bfYuok7InkvTshX+gaI20tHizM7RShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSVZW5gw; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSVZW5gw"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso3755338a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790083200; x=1790688000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0HuHouIXMmXXF1mGK08VBIvb7z6Q3KyojyCZuU1PWGs=;
        b=VSVZW5gw8UeGrn1fekDe69hEQNVFjHMriRUM9bQIzO+Oh6/rYYKTSwACduUVyHZmlu
         gZ/IoJyIVvaCIbQ0bsMdUMkjE2RvdbcuyCnqNhnJzg6TzQxUCsm0o3wCW13Zp0Kg94Db
         2pTTLRZezTc1UzxjlwZ3Sf3V6ETuFBDnJmiASKEEUi2mTHVBnm63hvd2nRNEkHBGfmZW
         0NQv5xn0nrPiR8GaHEP4eYoV+Jnwkqku8NvlcIp9jXMpVfwQGaJMU2+iPWnL2fqDbjzR
         Ru75p+0sfLv8zGUqyiVi3sO2YDSk9eJD1/yn4p8PwfasWY5AMOymEE3s+u96tpJT1F22
         meNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790083200; x=1790688000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0HuHouIXMmXXF1mGK08VBIvb7z6Q3KyojyCZuU1PWGs=;
        b=P+JfjCCNMNWboMtOxm0uuqPYy+L9utuNV/PPpDBSpPOHmsS7e+3pB0YmTokgILnsMr
         JV2WpNOOOehWE+aKs4xIHvWVH3jx7asv2RkGuILMWldRFJnkuAb/UgJf1Jfct+KlXZZw
         jCkWx26a+BWFh3ojth32i/f+DUnEfx3QOFEPmvpJjr+cZaMF8+wJFIZVjDskuP4dDUXY
         YOKdDTwLwHEA5WqlF7B1oAAmOvxuE5eCORtj8WwyIL06bAgCb8JSfWxt2o0V2qxrYUAt
         SEKzDhCbNUwz0bKyy42v3sgf4jy8xDgoOda3wqI9XRCJzSmrDnQ4PRQVOtIETyBPGcwS
         6JUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvP5ygW04XMmxv+FiCavYyQGXJcTfL4d4QUHAEAgASbIuLhCa6tvUR7hLAMVMbf+dAdYngQv/D2cxfiuMeZyDd@vger.kernel.org
X-Gm-Message-State: AFuF++kASnR+4uxlpyniIX8eyMjEWNPYKUs7EIImimb3xBPuVAx8X4aC
	kRTc4Wa+oJ1dv86fgajnFqFqdbKR8scBI+GWvM2AdTxdFmjaA91ojGzj
X-Gm-Gg: AYBFou1rWWFxydjc5cePsBa5FLHA0Ryiwa1jpocg+S7vpn24Yyz7ihMA2Jhk+Iu2BZp
	nCdjdsNfJsgFkkuhJotOwwmHqgGWRrSc9Yob5lbiQ2OkWopdsIHm1yg0T1eZRwIzGvx9qV4irVk
	zgGGGcjegNOnpAtDmpZ1p1edD41RhETVXFoOmgCKoWO3Zt/DeveHuowfvAn4dGnRvNwE6kyvwPW
	wx187fFqZiOF49/sJkrxcyD2OhObo5IUA4+HIdsbtUM0t+CxCTZphI9uaLONZm73ab5/pBCtwxW
	vwxjjnU46w2OHG22CjGeCOyi993CaFGZyc1BIPegzhdZWi+4dkLw5GwPrMyPvyHHqqX8DpieZi8
	JeXOMAfhMefGi922KalPtrY8y+12Gfg4spcso+E6Gy67opqj00Ou4PP9u5lZNq3yp6HEvfZR03+
	fFI/JEag1uKca0w4Ac+Ox91eJykX6TWDDMYO9QDvzhzJpQnPoGAkyB7kXggYr3AVVgcAvfjNTib
	tyfujxtxX0=
X-Received: by 2002:a17:90b:4b0a:b0:39e:4c80:44b7 with SMTP id 98e67ed59e1d1-3a0730fa737mr1299033a91.26.1790083199680;
        Tue, 22 Sep 2026 06:19:59 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06741d485sm4946783a91.8.2026.09.22.06.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:19:59 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	changbin.du@huawei.com,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH v3] perf symbols: Apply the symfs flat layout to the composed filename
Date: Tue, 22 Sep 2026 21:19:52 +0800
Message-ID: <20260922131952.2922816-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

--symfs=<dir>,flat documents itself as matching only the base name, so a
debuginfo lookup for /usr/lib/x86_64-linux-gnu/libc.so.6 should land on
<dir>/libc.so.6.debug.  It lands on
<dir>/debug/usr/lib/x86_64-linux-gnu/libc.so.6.debug instead, because the
layout is applied to a fixed prefix and the file name arrives afterwards:

	len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
	snprintf(filename + len, size - len, "%s.debug", dso__long_name(dso));

perf_basename() only ever sees "/usr/lib/debug", so neither layout comes
out of it.

Compose the path as it would appear on the profiled system and join it
once, which puts the layout on the whole name.  That covers
FEDORA_DEBUGINFO, UBUNTU_DEBUGINFO, MIXEDUP_UBUNTU_DEBUGINFO,
OPENEMBEDDED_DEBUGINFO and BUILDID_DEBUGINFO, plus the same composition in
build_id_cache__find_debug().

BUILDID_DEBUGINFO needs one more step: the build id cache splits the first
two characters of the build id off into a directory name, so the basename
of the hierarchy path is only part of the build id.  Name the flat file
after the whole build id.

dso__disassemble_filename() passes a path from perf's own build id cache
rather than one on the profiled system, and every entry there is named
"elf" or "debug".  Use path__join() so the layout does not apply.

With --symfs /s,flat the lookups are now /s/libc.so.6, /s/libc.so.6.debug,
/s/sleep and /s/<build id>.debug.  hierarchy is unchanged.

Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v2->v3: different approach.  v1 and v2 took the four sites out of the
layout; Namhyung asked for the layout to be made to work instead, so v3
composes the filename first and joins once.

v2: https://lore.kernel.org/r/20260819094621.844115-1-zhanxusheng@xiaomi.com

Traced openat()/newfstatat() under --symfs /s,flat and /s,hierarchy with
perf record -- sleep 0.3 before and after: flat goes from 21 paths to 15,
hierarchy is identical at 21.
 tools/perf/util/build-id.c | 12 +++++++----
 tools/perf/util/disasm.c   |  8 ++++++-
 tools/perf/util/dso.c      | 43 +++++++++++++++++++++++++-------------
 3 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index eb95ab90f974..02233ef0eaff 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -586,9 +586,9 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
 	const char *dirname = "/usr/lib/debug/.build-id/";
 	char *realname = NULL;
 	char dirbuf[PATH_MAX];
+	char pathbuf[PATH_MAX];
 	char *debugfile;
 	struct nscookie nsc;
-	size_t len = 0;
 
 	debugfile = calloc(1, PATH_MAX);
 	if (!debugfile)
@@ -599,9 +599,13 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
 		dirname = dirbuf;
 	}
 
-	len = __symbol__join_symfs(debugfile, PATH_MAX, dirname);
-	snprintf(debugfile + len, PATH_MAX - len, "%.2s/%s.debug", sbuild_id,
-		 sbuild_id + 2);
+	/* See the build id note in dso__read_binary_type_filename(). */
+	if (symbol_conf.symfs_layout_flat)
+		scnprintf(pathbuf, PATH_MAX, "/%s.debug", sbuild_id);
+	else
+		scnprintf(pathbuf, PATH_MAX, "%s%.2s/%s.debug", dirname,
+			  sbuild_id, sbuild_id + 2);
+	__symbol__join_symfs(debugfile, PATH_MAX, pathbuf);
 
 	nsinfo__mountns_enter(nsi, &nsc);
 	realname = realpath(debugfile, NULL);
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 6cfdbabbb8c7..1148dde6c975 100644
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
@@ -1173,7 +1174,12 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 
 	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
 	if (build_id_filename) {
-		__symbol__join_symfs(filename, filename_size, build_id_filename);
+		/*
+		 * This is a path in perf's own build id cache, not a path on
+		 * the profiled system, so the symfs layout does not apply.
+		 */
+		path__join(filename, filename_size, symbol_conf.symfs,
+			   build_id_filename);
 		free(build_id_filename);
 	} else {
 		if (dso__has_build_id(dso))
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 42bfe30a3b51..e52de7cc1bc6 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -115,6 +115,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 				   const char *root_dir, char *filename, size_t size)
 {
 	char build_id_hex[SBUILD_ID_SIZE];
+	char relative[PATH_MAX];
 	int ret = 0;
 	size_t len;
 
@@ -167,13 +168,15 @@ int dso__read_binary_type_filename(const struct dso *dso,
 		break;
 
 	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
-		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
-		snprintf(filename + len, size - len, "%s.debug", dso__long_name(dso));
+		snprintf(relative, sizeof(relative), "/usr/lib/debug%s.debug",
+			 dso__long_name(dso));
+		__symbol__join_symfs(filename, size, relative);
 		break;
 
 	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
-		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
-		snprintf(filename + len, size - len, "%s", dso__long_name(dso));
+		snprintf(relative, sizeof(relative), "/usr/lib/debug%s",
+			 dso__long_name(dso));
+		__symbol__join_symfs(filename, size, relative);
 		break;
 
 	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
@@ -187,8 +190,9 @@ int dso__read_binary_type_filename(const struct dso *dso,
 			ret = -1;
 			break;
 		}
-		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
-		snprintf(filename + len, size - len, "%s", dso__long_name(dso) + 4);
+		snprintf(relative, sizeof(relative), "/usr/lib/debug%s",
+			 dso__long_name(dso) + 4);
+		__symbol__join_symfs(filename, size, relative);
 		break;
 
 	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
@@ -200,15 +204,15 @@ int dso__read_binary_type_filename(const struct dso *dso,
 		while (last_slash != dso__long_name(dso) && *last_slash != '/')
 			last_slash--;
 
-		len = __symbol__join_symfs(filename, size, "");
 		dir_size = last_slash - dso__long_name(dso) + 2;
-		if (dir_size > (size - len)) {
+		if (dir_size > sizeof(relative)) {
 			ret = -1;
 			break;
 		}
-		len += scnprintf(filename + len, dir_size, "%s",  dso__long_name(dso));
-		len += scnprintf(filename + len , size - len, ".debug%s",
-								last_slash);
+		len = scnprintf(relative, dir_size, "%s", dso__long_name(dso));
+		scnprintf(relative + len, sizeof(relative) - len, ".debug%s",
+			  last_slash);
+		__symbol__join_symfs(filename, size, relative);
 		break;
 	}
 
@@ -219,9 +223,20 @@ int dso__read_binary_type_filename(const struct dso *dso,
 		}
 
 		build_id__snprintf(dso__bid(dso), build_id_hex, sizeof(build_id_hex));
-		len = __symbol__join_symfs(filename, size, "/usr/lib/debug/.build-id/");
-		snprintf(filename + len, size - len, "%.2s/%s.debug",
-			 build_id_hex, build_id_hex + 2);
+		/*
+		 * The build id cache layout splits the first two characters off
+		 * into a directory name, so the basename of the hierarchy path
+		 * is only part of the build id. Name the flat file after the
+		 * whole build id instead.
+		 */
+		if (symbol_conf.symfs_layout_flat)
+			snprintf(relative, sizeof(relative), "/%s.debug",
+				 build_id_hex);
+		else
+			snprintf(relative, sizeof(relative),
+				 "/usr/lib/debug/.build-id/%.2s/%s.debug",
+				 build_id_hex, build_id_hex + 2);
+		__symbol__join_symfs(filename, size, relative);
 		break;
 
 	case DSO_BINARY_TYPE__VMLINUX:

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.43.0

