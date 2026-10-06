Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEC49EC7F;
	Tue,  6 Oct 2026 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303215; cv=none; b=d7qaJLU8ySbquKL3WSAJHmnyU5zGBPL4Ny54Ir5n69nJreFwguzfrh3DW9WuhIxGfVTdH+VN9sdTlaXVuufDp6qNSpBMgXDGzPLCvfY4DLmY1O0w0DCmmCbCei+Ku9eL5GQniW4Pllw4kLeG+qSOdjM6MwZIsjup/I5I6TLRZgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303215; c=relaxed/simple;
	bh=TTnNl9JqLU87c/7cVyFgsQKC+lffghoISyatQVUHlhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPga5HORCmYUQAgT8mwRBkOcISchnxWD1/uKDZWJq2KorZa3zF3qFT6tdG/DS60+dBr1Mb6JQZ+D0JRdnH3a/iXeuThrWaObgjM1RO8g7wetXUxQjSjK0QiPlZ2y+5Wso1ShrAUFmabY0NARuqdBmEz+w8o3nE2spgSf2mlvSuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R772vWIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R772vWIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979181F0089B;
	Tue,  6 Oct 2026 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303214;
	bh=g4XB4iqrtWd+IKyx7sfJIrOGRGSn3h2tBdJvmPHRUHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R772vWIt0rE27u4X7xBRqzOWdt9nCLV8A5m0vscGLX4p8yoxAnEq/Sx6S4ZtyFuhZ
	 r0yoOZLWnHJl5wM4kyLgYvCEhG+j0E0dRxN6IvuRrPDLX0uAqhrTEMuxefEBzTUoNA
	 2Iksn8MdN+kkIIi8uzpwNXKZIWCCxMUZ25wovyb3e8/3K4Fa+ZHwRDRzUtbGlOJUqW
	 z5JzcNRbCB74si2xvo9QIe9a1mYhtF/E3CdjaOSxNkpAJiyDkQCE1K1B5BEJyfUHmR
	 npGOt3KvmsI6TTmLc2SjR+N5RHTUH3SJmqNdhks/N0NLv8wJ6lj0s/nadXK+xpSCqW
	 7EzRWiSZNj4KQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Michael Petlan <mpetlan@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/6] perf test attr: Fix wrong size expectation for events
Date: Tue,  6 Oct 2026 18:13:05 +0200
Message-ID: <20261006161309.3078488-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006161309.3078488-1-acme@kernel.org>
References: <20261006161309.3078488-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Petlan <mpetlan@redhat.com>

Although config4 has been added into struct perf_event_attr, the size
expectation for the struct hasn't been adjusted. This hasn't been
noticed, since the testcase's return value has been ignored after
rewriting the testcase to python until previous commit.

Fix that.

Fixes: eb89aef367e47010 ("perf headers: Sync perf_event.h/perf_regs.h with the kernel headers")
Fixes: 80cdf208117a36de ("tools headers UAPI: Sync linux/perf_event.h with the kernel sources")
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/attr/base-record          | 2 +-
 tools/perf/tests/shell/attr/base-stat            | 2 +-
 tools/perf/tests/shell/attr/system-wide-dummy    | 2 +-
 tools/perf/tests/shell/attr/test-record-dummy-C0 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/attr/base-record b/tools/perf/tests/shell/attr/base-record
index b44e4e6e444386af..a4597d4c0cd12550 100644
--- a/tools/perf/tests/shell/attr/base-record
+++ b/tools/perf/tests/shell/attr/base-record
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0|1
-size=136
+size=176
 config=0|1
 sample_period=*
 sample_type=263
diff --git a/tools/perf/tests/shell/attr/base-stat b/tools/perf/tests/shell/attr/base-stat
index fccd8ec4d1b0225c..67d6eea8947034e1 100644
--- a/tools/perf/tests/shell/attr/base-stat
+++ b/tools/perf/tests/shell/attr/base-stat
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0
-size=136
+size=176
 config=0
 sample_period=0
 sample_type=65536
diff --git a/tools/perf/tests/shell/attr/system-wide-dummy b/tools/perf/tests/shell/attr/system-wide-dummy
index a1e1d6a263bf14e7..b062ad7f3c1c61dc 100644
--- a/tools/perf/tests/shell/attr/system-wide-dummy
+++ b/tools/perf/tests/shell/attr/system-wide-dummy
@@ -7,7 +7,7 @@ cpu=*
 pid=-1
 flags=8
 type=1
-size=136
+size=176
 config=9
 sample_period=1
 # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
diff --git a/tools/perf/tests/shell/attr/test-record-dummy-C0 b/tools/perf/tests/shell/attr/test-record-dummy-C0
index 91499405fff4d32b..54adb835d203f2b1 100644
--- a/tools/perf/tests/shell/attr/test-record-dummy-C0
+++ b/tools/perf/tests/shell/attr/test-record-dummy-C0
@@ -10,7 +10,7 @@ cpu=0
 pid=-1
 flags=8
 type=1
-size=136
+size=176
 config=9
 sample_period=4000
 # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
-- 
2.55.0

