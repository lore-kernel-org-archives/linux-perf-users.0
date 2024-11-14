Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B905B6F307;
	Thu, 14 Nov 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604279; cv=none; b=m7J36oBulRPz3QlIS8yU+ix07N3KtLclSSYbShs5d1Yoj+7Lj3FP/vnRLLcCknpLltTif4Q7lJW4Depg6YIItIGAxiqgY7qTz1MtXFJqQgaDQI3JrwZwPd+RwsVrxouiGAgFO5utne3tWJDBz4uLlrRZPitwNjetLUbXzVUq48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604279; c=relaxed/simple;
	bh=CeDDin3Oyaoqz6NCTA0YQmQXis0jvldAADGnlBUP2So=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xt5ap/q0H47vd/Mxf4cF7/NE71cXRdRewIewhljTSb+Z5Yg3Ldo1wQTnAoJ3L5S7K8QnLuFJs94waVr1uf87htytCl8hp/8HRgot4a1MpGaI6oY/6b/x5UNubsq+7mPa8j5P6b/0JDquO0fxQl0Xi1LGlqLjDDbGnaBwWbiU2pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 902831474;
	Thu, 14 Nov 2024 09:11:45 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0DA043F6A8;
	Thu, 14 Nov 2024 09:11:13 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] perf: buildid: Print error for creating folder failure
Date: Thu, 14 Nov 2024 17:10:52 +0000
Message-Id: <20241114171053.3112521-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mkdir_p() function will fail to create a buildid cache folder if the
folder name is not an absolute path.  As a result, the cache folder is
empty after recording.

Print an error to remind users to use an absolute path name or check
permissions.  Update the documentation to reflect the requirement of
using an absolute path name.

After:

  # perf --buildid-dir debug_dir record -- test_program
    ...
    Failed to create build_id cache folder: debug_dir/[kernel.kallsyms]/5c81911cab18f69bab96f8a1fae64a9f1d83b104.
      Use an absolute path name or check permissions.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/perf-config.txt | 2 ++
 tools/perf/Documentation/perf.txt        | 4 ++--
 tools/perf/util/build-id.c               | 6 +++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 379f9d7a8ab1..26d9b1dd2e8c 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -236,6 +236,8 @@ buildid.*::
 		cache location, or to disable it altogether. If you want to disable it,
 		set buildid.dir to /dev/null. The default is $HOME/.debug
 
+		This option must be an absolute path name.
+
 buildid-cache.*::
 	buildid-cache.debuginfod=URLs
 		Specify debuginfod URLs to be used when retrieving perf.data binaries,
diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index cbcc2e4d557e..14c79bd7820a 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -37,8 +37,8 @@ OPTIONS
         Do not set pager.
 
 --buildid-dir::
-        Setup buildid cache directory. It has higher priority
-        than buildid.dir config file option.
+        Setup buildid cache directory with an absolute path name.
+        It has higher priority than buildid.dir config file option.
 
 --list-cmds::
         List the most commonly used perf commands.
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 8982f68e7230..a05d45ac1c87 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -637,8 +637,12 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
 		if (unlink(dir_name))
 			goto out_free;
 
-	if (mkdir_p(dir_name, 0755))
+	if (mkdir_p(dir_name, 0755)) {
+		pr_err("Failed to create build_id cache folder: %s.\n"
+		       "  Use an absolute path name or check permissions.\n",
+		       dir_name);
 		goto out_free;
+	}
 
 	/* Save the allocated buildid dirname */
 	if (asprintf(&filename, "%s/%s", dir_name,
-- 
2.25.1

