Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0E38D3EA;
	Tue, 23 Jun 2026 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242082; cv=none; b=dMmpkapoY5Yy37bgvXaaS0TqHYmWR5dGy2SHNoMU0bvQMdsLY3qQOeAenVj8odizCxGC7RnuW8YPB/nuEg9h76aZTOt7rW5YYSaWT3+kbjdzqYEMYrPIrX5dkax+X/QE6ICCVzfsMY/FQVyi4KV9Y1kTILeSoU38xzKQOjVJy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242082; c=relaxed/simple;
	bh=DgkGWdQ9rtn9nmrmuMKlw3gXRJdO6/WH16+ttISmcgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Buph06fIdzWkUPspbVGMmcfaNU1V0GYdQI61rhjB36KbFoUNOjaSXGUk47NTxwDkBT49LEFgou+tf4r2qeBYLgOU76OLKD+YHX9q4Omjn87oXHCJrgz1J3p51xIjCgxSX1zTZJu5m6Y/m1kBLutGhDOZ2X3fD8A8hWhjzGE3L7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE1dsXkA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE1dsXkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D321F00AC4;
	Tue, 23 Jun 2026 19:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782242081;
	bh=K6aZ2txJGbDkyAXecE2kBAwtzur3aye1sfzT7lzfalo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XE1dsXkA9QSTUV0q7JCCrLZKY3DxRKMR/boKjyIlrPkCf4lVK8gX5YsClcZmVyUSV
	 rqoJyPAkmkzzUw+0m1Jp46hizCgMW70eYFrJHOj9CULZ/MB1M+wT17lE1swJEhKa6F
	 +qhYHC+vZ2c/pJpQAHR372B2gXNLMfc0aVr1LHWwSI3sc45ITPbkGYnCl+9n3Lf3ft
	 61ZVB82n/Ez5Fq5/UW1RPEt6i5eHKL8itnozV4X+i1yn837UF+OI/kG9AtMLsuyjb7
	 gocNOL5Fs+pVev5+AfKHKOX3l5iLxjhw77laS+a9vMgVmLZAXoS2YzhSyE2oJIvRBp
	 L4zTnEoXb4kwg==
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
Subject: [PATCH v2 4/6] perf kvm: Do not copy filename string
Date: Tue, 23 Jun 2026 12:14:37 -0700
Message-ID: <20260623191439.3621593-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260623191439.3621593-1-namhyung@kernel.org>
References: <20260623191439.3621593-1-namhyung@kernel.org>
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
 tools/perf/builtin-kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index eaf9297cc34d32c1..4200bf899b51c2a9 100644
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
-- 
2.55.0.rc0.799.gd6f94ed593-goog

