Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84C2E6CB8;
	Fri, 10 Apr 2026 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781681; cv=none; b=j9iFrBKCTOLuOZzQ/7ww3Itc7XdtMO05yg4zE+oJCgQZjLm+WXrsr6EsgfIy0cwLCsC5UX4AgI04TNpWImJd3ek1SrhUeTJ/rXglaClSJHagLdY8kfpaGv1TYzAHIYOkZiUy3VJv1uPFmN2kr9LJObuAUB6Xte3QXMgFVWfHPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781681; c=relaxed/simple;
	bh=23b3ktY195gom8zEVfi/bEPp4pW7LBt2UeMxag3zm/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9kZd6odqRRw23C7Vu/pWJxic8LqFUZXNuxVgQfVzdAQBlB2T6BXjv4as70AIlScSqyswmEeChZBIQToWj6ptSr80vUAwrXPJ5YlOuR4iw4bLemxLy0Iaa5ypO/wzCr5bB5hssk2wHP0Bqjh6XYa6yMYz170evqrCZ6BMP1wOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOaxeGlK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOaxeGlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6124BC4CEF7;
	Fri, 10 Apr 2026 00:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781681;
	bh=23b3ktY195gom8zEVfi/bEPp4pW7LBt2UeMxag3zm/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOaxeGlKYAlYqPjs/aYA9NAoRnAPnMTIZWaavJ6ItVwzWMqEJINwXu/J1OZ49q4pC
	 dBu3Ys/wJUqda2wzNXIDM2R/J0pXhseUoD3XAuWd0tBeNliMVbJKhYt9O8Y+/4n0+Y
	 P/2nSDXbhFBql8bpEalXiZerumcIfppy1rDr6G4becfO5dK6kSiNJUyAl/i4Mg0LUS
	 Il+HHcozXicUpLWh8aB/29NaOhqiMld4z1p7IFp47vVvCWoo12OYeGrv3DHoS0lq/t
	 TL+G9DhflZ0AsTRaHdUvAAb9DX5buROS2qGgBOIIfdEoPARTG564WQ0tzwlKfDCLk9
	 u4abgKJLT5OrA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH 11/13] perf header: Sanity check HEADER_PMU_CAPS
Date: Thu,  9 Apr 2026 21:39:58 -0300
Message-ID: <20260410004000.148138-12-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410004000.148138-1-acme@kernel.org>
References: <20260410004000.148138-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add upper bound checks in PMU capabilities processing to harden against
malformed perf.data files:

- nr_pmu bounded to MAX_PMU_MAPPINGS (4096) in process_pmu_caps()
- nr_pmu_caps bounded to MAX_PMU_CAPS (512) in __process_pmu_caps()

Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a1f19c1954774e9d..03426132e58dc933 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3675,6 +3675,13 @@ static int __process_pmu_caps(struct feat_fd *ff, int *nr_caps,
 	if (!nr_pmu_caps)
 		return 0;
 
+#define MAX_PMU_CAPS 512
+	if (nr_pmu_caps > MAX_PMU_CAPS) {
+		pr_err("Invalid pmu caps: nr_pmu_caps (%u) > %u\n",
+		       nr_pmu_caps, MAX_PMU_CAPS);
+		return -1;
+	}
+
 	*caps = calloc(nr_pmu_caps, sizeof(char *));
 	if (!*caps)
 		return -1;
@@ -3752,6 +3759,18 @@ static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
 		return 0;
 	}
 
+	if (nr_pmu > MAX_PMU_MAPPINGS) {
+		pr_err("Invalid HEADER_PMU_CAPS: nr_pmu (%u) > %u\n",
+		       nr_pmu, MAX_PMU_MAPPINGS);
+		return -1;
+	}
+
+	if (ff->size < sizeof(u32) + nr_pmu * sizeof(u32)) {
+		pr_err("Invalid HEADER_PMU_CAPS: section too small (%zu) for %u PMUs\n",
+		       ff->size, nr_pmu);
+		return -1;
+	}
+
 	pmu_caps = calloc(nr_pmu, sizeof(*pmu_caps));
 	if (!pmu_caps)
 		return -ENOMEM;
-- 
2.53.0

