Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4809397E83;
	Tue,  7 Apr 2026 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549006; cv=none; b=O7cHu2k7ru6WrCJhFyTrKRzU+dtVUn1y7VDUP3eREk9yoivflF6ve0IIi1z9a7sY+nl98UguMnxnD43KDQePJrxiVI/W2oqG3MXUwZuNfO/1J3PaTbC7tNOvuUfu9v/8ulI/sf0j0Q1NVBu7XYmRvtK+zBQ0UlHXKj/Jh8h62qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549006; c=relaxed/simple;
	bh=peezpJlwACO6M2Jd9uEhn5iyL/7YhAnljtsbklhvzG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qUr1rYH+0PlPzrv+0j8yMautI94PL1flW/xF9lq/W2F6DBtwKUY0cPIHdShny0rdX7AOs2PmuwANoGsu4mRxSQ10thdZ4s+iWyHBJe1jfj+c1H7NROExZ/17Dq6PojpKNHXcobsKHB+tG6ze8hoga/7EifuC9eBmbltVprYs/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8pblOGo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8pblOGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF4FC116C6;
	Tue,  7 Apr 2026 08:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775549006;
	bh=peezpJlwACO6M2Jd9uEhn5iyL/7YhAnljtsbklhvzG0=;
	h=From:To:Cc:Subject:Date:From;
	b=n8pblOGo7wIsluchbg4d48h+nlk1DYklSpCfUASOguDcD2CN/zzqrwn0ldMTjwxvt
	 1bebPzwkT0mlcG1aV2pmnvuLzAtRxk8IJDIUae7mHdNtOpsCTTUcrFgWvd9gKmgLed
	 lylWiw9x0C5azTu0JRV6kvYbY+zch2mc/ApzB3srqfbLJiqC7ARDwmkWr2nZD/qCoa
	 zsoOgWZFwOiLbxqumqReyhdRhWRJjt27XSSFB2UOIrmRaY5VuIcQ3gbCdixMpCg5LL
	 YAI0nrRjo2vgzQApbCI3Fm0gz1toAus6/aFDa4SZVqP25Y50LMSDlTbCiYpAnE2fRP
	 PPqipMeQZHXeg==
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
Subject: [PATCH] perf build: Fix detection of latest openjdk
Date: Tue,  7 Apr 2026 01:03:20 -0700
Message-ID: <20260407080320.45372-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My fedora system fails to find openjdk even if I installed the
'java-latest-openjdk-devel' package as in the warning message.
It turns out that the directory path is different than what's in the
output of alternatives.

  Makefile.config:1122: No openjdk development package found, please install JDK package,
                        e.g. openjdk-8-jdk, java-latest-openjdk-devel

The Makefile.config has the rule like below to detect the installed
directory with a version number.

  $ alternatives --display java | tail -1 | cut -d ' ' -f 5 | sed -e 's%/jre/bin/java.%%g' -e 's%/bin/java.%%g'
  /usr/lib/jvm/java-21-openjdk

This is to find a directory where the header file (jvmti.h) is like
/usr/lib/jvm/java-21-openjdk/include/jvmti.h.  However the header file
was in a different directory.

  $ rpm -ql java-latest-openjdk-devel | grep jvmti.h
  /usr/lib/jvm/java-latest-openjdk/include/jvmti.h

It seems the directory name is fixed to provide the latest version.
Let's check the directory name before using the parsed name.  With this
change, the warning is gone on my system.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile.config | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 333ddd0e4bd814e9..e6686641761fd0bf 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1096,8 +1096,12 @@ ifndef NO_JVMTI
   ifneq (,$(wildcard /usr/sbin/update-java-alternatives))
     JDIR=$(shell /usr/sbin/update-java-alternatives -l | head -1 | awk '{print $$3}')
   else
-    ifneq (,$(wildcard /usr/sbin/alternatives))
-      JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed -e 's%/jre/bin/java.%%g' -e 's%/bin/java.%%g')
+    ifneq (,$(wildcard /usr/lib/jvm/java-latest-openjdk/include))
+      JDIR=/usr/lib/jvm/java-latest-openjdk
+    else
+      ifneq (,$(wildcard /usr/sbin/alternatives))
+        JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed -e 's%/jre/bin/java.%%g' -e 's%/bin/java.%%g')
+      endif
     endif
   endif
   ifndef JDIR
-- 
2.53.0

