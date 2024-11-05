Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD41D2716;
	Tue,  5 Nov 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816818; cv=none; b=rYI5Lhx4o7fjn07d5e9TY+YzzutARW8aC/dk5IyzSQ9z5uEyg0IbQ82wy7kHvnG/ve6RBH937zKkD2RKbKgEuG/DSuCSOGXV0pKPHc/4jnVHRX0tjo2psXIl76IszjuF750iCZYRg8cUsiGwhXnEuqcCPflfkBdPFJb1tVHNEug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816818; c=relaxed/simple;
	bh=yHQaz97JADPxJTedTrQRaGlex8yfX/PiBJY+uGEeX6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roGpSIzN/QUMOeoDAALW5WHHl18YvgMbs/fseetpv7J0jF9ULeowKjyDbs70YPj3c8orO++N20nSJEMwz6qFi8uSRmS3vqVOVhiebzc0bzK6tcG2putNkttzBQg0vtftSgtcmiNFJaI7mSdnxT51ShzWNQsG2TAO4EXrR2c/u+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5Bfbdzm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5Bfbdzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC572C4CED3;
	Tue,  5 Nov 2024 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730816818;
	bh=yHQaz97JADPxJTedTrQRaGlex8yfX/PiBJY+uGEeX6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5BfbdzmvwYmwRtSR2ZASX5lLt+yQXWta33tCNL22UCiWKxP1DKJoxUy8GiqHcHbI
	 R4/jHNO6MQiACaKXTiax19b7QYDfbcmYi4GsVfLYxtay1x/1ArYcqAOPXnfsaCLSQi
	 Xq5RSjdPdA2xFHu925ShsCNEsxvL/TUCkPvHVhQ2LRcA8LA692pQVm0Kojsx/uXjma
	 pSQWIj/d9qC/0FKb7mMqKHjFuO+H6xY59f9U65aDUGZjSxLlS7HIReU85s1I9BcNSO
	 gPwD/D4IgTV44n+oAeC4pxDnh3wO9pNoThkbS/KSEhVntIRDLQTS6noNdODMfHgJVg
	 18RliGXHa+PBQ==
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
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>
Subject: [PATCH v2 4/4] perf build: Emit a warning when libtraceevent is explicitely disabled
Date: Tue,  5 Nov 2024 11:26:16 -0300
Message-ID: <20241105142616.761042-5-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105142616.761042-1-acme@kernel.org>
References: <20241105142616.761042-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since not having the libtraceevent devel package installed prevents the
build from proceeding unless NO_LIBTRACEEVENT=1 is passed:

  $ make O=/tmp/build/perf-tools-next/ -C tools/perf install-bin
  Makefile.config:1195: *** ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel and/or set LIBTRACEEVENT_DIR or build with NO_LIBTRACEEVENT=1.  Stop.
  make[1]: *** [Makefile.perf:292: sub-make] Error 2
  make: *** [Makefile:119: install-bin] Error 2
  make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
  $

Behave just like with the NO_LIBPYTHON case:

  $ make NO_LIBPYTHON=1 NO_LIBTRACEEVENT=1 O=/tmp/build/perf-tools-next/ -C tools/perf install-bin
  Makefile.config:874: Python support disabled by user
  Makefile.config:1180: libtraceevent support disabled by user

  Auto-detecting system features:
<SNIP>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linux.dev>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 80bf06e828f0ebc8..3ae3449ccf684b42 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1180,7 +1180,9 @@ ifndef NO_LIBPFM4
 endif
 
 # libtraceevent is a recommended dependency picked up from the system.
-ifneq ($(NO_LIBTRACEEVENT),1)
+ifeq ($(NO_LIBTRACEEVENT),1)
+  msg := $(warning libtraceevent support disabled by user);
+else
   $(call feature_check,libtraceevent)
   ifeq ($(feature-libtraceevent), 1)
     CFLAGS += -DHAVE_LIBTRACEEVENT $(shell $(PKG_CONFIG) --cflags libtraceevent)
-- 
2.47.0

