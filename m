Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C5C420E66;
	Wed,  1 Jul 2026 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934916; cv=none; b=FXDYWxlwr00KA2AsK+3y0gXKxBJoFflCCskw8A2qmINR73ueQucc2o737XPSUVC0l+HWIlvB9s5G7hYWVoWm/nsuxZkc/eufLvCqIzRP1/vsZjiHgxOdVj3f8IjEUuW8l5rx7/KFBKr862gMieiqTSabRRMSHT9HtxlqXJUcxUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934916; c=relaxed/simple;
	bh=uhx8OfGoJXk7rKJhafVaSHjrSsy9XGL0QtZ5w/nPs5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujUeif+ohhg2ROzlmChkPMZR7pLgCUlE3FpNF324jhFaSzryq3Ryy/OoGFgnoZPnCOJu0ykoMs1tawxiVOidmEF/mWPI0tX4gRBYtCb/9PEkpYWMmqlf5IYEDAACoYjr0fFdLZaLvtFDHU0Um5N6jPj4OrBQ6BnOeTqLuFSujck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld1PRa2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld1PRa2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCF41F00ACF;
	Wed,  1 Jul 2026 19:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934915;
	bh=hohJL3EHSkMbFevuTkZhGLitlE6xHWGKJZnCm6Zs2YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ld1PRa2ShRv3EA1SYgoEpGKLma85oOZbkR8meLKuUUqjxUuF139+w7UVYcU0S0wxM
	 ug9hSWbVDW6a9+B3obiKI0mdgIfH41ngQJ2CBt/zSctrxp/H2MUmh3TipQ0zZHVG/Q
	 i8lFhRuGKpwO7WjO5pfbbzv/2NLUjvTvdwk0o8NRMZgCETv5yYR2e2phcsmf0GJem4
	 XRSexDvNhpLCy+wUWL1FaO/l476pVrGWZIOqNN1ImfJ1iqiK6XhUgiCnCRmZPJGdYk
	 2LoMem5u9LzvBI3WtodVRXcqk5XlWE0xmd45CBbOWGJt8JezKqGu5+4Z+bNwL2beo7
	 WmcVDHKs34VvA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 4/6] perf kvm: Do not copy filename string
Date: Wed,  1 Jul 2026 12:41:51 -0700
Message-ID: <20260701194153.401218-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260701194153.401218-1-namhyung@kernel.org>
References: <20260701194153.401218-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As it removed STRDUP_FAIL_EXIT(), it no longer calls free() for elements
in the copied argv.  Thus, the filename should not be allocated as well.
In fact, it's a pointer to string literals and should be fine to pass
the pointer.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-kvm.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index eaf9297cc34d32c1..20ea59e59a4b65ba 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -607,11 +607,11 @@ static const char *get_filename_for_perf_kvm(void)
 	const char *filename;
 
 	if (perf_host && !perf_guest)
-		filename = strdup("perf.data.host");
+		filename = "perf.data.host";
 	else if (!perf_host && perf_guest)
-		filename = strdup("perf.data.guest");
+		filename = "perf.data.guest";
 	else
-		filename = strdup("perf.data.kvm");
+		filename = "perf.data.kvm";
 
 	return filename;
 }
@@ -2148,15 +2148,9 @@ int cmd_kvm(int argc, const char **argv)
 	if (!perf_host)
 		perf_guest = 1;
 
-	if (!file_name) {
+	if (!file_name)
 		file_name = get_filename_for_perf_kvm();
 
-		if (!file_name) {
-			pr_err("Failed to allocate memory for filename\n");
-			return -ENOMEM;
-		}
-	}
-
 	if (strlen(argv[0]) > 2 && strstarts("record", argv[0]))
 		return __cmd_record(file_name, argc, argv);
 	else if (strlen(argv[0]) > 2 && strstarts("report", argv[0]))
-- 
2.55.0.rc0.799.gd6f94ed593-goog

