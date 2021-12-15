Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5031C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Dec 2021 16:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbhLOQW6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Dec 2021 11:22:58 -0500
Received: from foss.arm.com ([217.140.110.172]:56832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244501AbhLOQW6 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Dec 2021 11:22:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC5C46D
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Dec 2021 08:22:57 -0800 (PST)
Received: from e126387.extremechicken.org (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75F033F5A1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Dec 2021 08:22:57 -0800 (PST)
From:   carsten.haitzler@foss.arm.com
To:     linux-perf-users@vger.kernel.org
Subject: [PATCH 01/12] perf test: Shell - Limit to only run executable scripts in tests
Date:   Wed, 15 Dec 2021 16:22:39 +0000
Message-Id: <20211215162250.70322-1-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

Perf test's shell runner will just run everything in the tests
directory (as long as it's not another directory or does not begin
with a dot), but sometimes you find files in there that are not shell
scripts - perf.data output for example if you do some testing and then
the next time you run perf test it tries to run these. Check the files
are executable so they are actually intended to be test scripts and
not just some "random junk" files there.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 tools/perf/tests/builtin-test.c |  4 +++-
 tools/perf/util/path.c          | 12 ++++++++++++
 tools/perf/util/path.h          |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 8cb5a1c3489e..ece272b55587 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -295,7 +295,9 @@ static const char *shell_test__description(char *description, size_t size,
 
 #define for_each_shell_test(entlist, nr, base, ent)	                \
 	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
-		if (!is_directory(base, ent) && ent->d_name[0] != '.')
+		if (!is_directory(base, ent) && \
+			is_executable_file(base, ent) && \
+			ent->d_name[0] != '.')
 
 static const char *shell_tests__dir(char *path, size_t size)
 {
diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
index caed0336429f..7dde8c230ae8 100644
--- a/tools/perf/util/path.c
+++ b/tools/perf/util/path.c
@@ -92,3 +92,15 @@ bool is_directory(const char *base_path, const struct dirent *dent)
 
 	return S_ISDIR(st.st_mode);
 }
+
+bool is_executable_file(const char *base_path, const struct dirent *dent)
+{
+	char path[PATH_MAX];
+	struct stat st;
+
+	sprintf(path, "%s/%s", base_path, dent->d_name);
+	if (stat(path, &st))
+		return false;
+
+	return !S_ISDIR(st.st_mode) && (st.st_mode & S_IXUSR);
+}
diff --git a/tools/perf/util/path.h b/tools/perf/util/path.h
index 083429b7efa3..d94902c22222 100644
--- a/tools/perf/util/path.h
+++ b/tools/perf/util/path.h
@@ -12,5 +12,6 @@ int path__join3(char *bf, size_t size, const char *path1, const char *path2, con
 
 bool is_regular_file(const char *file);
 bool is_directory(const char *base_path, const struct dirent *dent);
+bool is_executable_file(const char *base_path, const struct dirent *dent);
 
 #endif /* _PERF_PATH_H */
-- 
2.32.0

