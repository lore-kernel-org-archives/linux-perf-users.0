Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9781B422535;
	Mon, 27 Jul 2026 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169049; cv=none; b=BeTfcNlHhJq2ipv1bO/HC83jf+OIlR8Kfu8ZJpguNmQaTq9FszZ1tubgY6Oh5h2JxBj9QX6VxhOZfF34MOnqCcbEPkLGP8WDluyJSZXu0+LfqXpzf4DxvzJgZbRZkMALt2JGsdosPB43t1zZnPKyeLcc5yKC5DQ18AqE5enDBJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169049; c=relaxed/simple;
	bh=DuGGITNd5yN5QlqKO550GIPWLvxH/Ra1Fty4Z7nuowQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9w5HnQCS1Io+nq5l4YwuloTyPxNPLQrKZmGoDXO8eDT/pNCTZrJJXE7WNshdwunPMBwA+NrxZNWBcSnBevVVbVssdYf4KufWEAWTJesZmFMRLfT2ZuXdzikUQIGQznS/C0Fw34+1Zn+V4bIJnYZDLeAcEPtWUX9asz+B4b386w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIfFp6Aj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIfFp6Aj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916CA1F000E9;
	Mon, 27 Jul 2026 16:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785169048;
	bh=QIQsSOkz51tD534ULrgQRD5dpLHUcO+T2TMsf3NXxNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OIfFp6Aj/VqxbvWAIm38SRIIikMYt841umQ0eARYBoyyHthXcIZ7Wo2N4yRCnWOso
	 0JILkX6GYRJQ2Cfl6FzYWuSn1V7/bpX/R5jIvjVcZIoqmWUhfa/jf4IU0L7+sERfpg
	 peZH9PTpoJ942f3Z/P3zqpsdMphwrdgCWMUn9z9VoAa9lnGBsfRfrazu5jXuf4fSfQ
	 9ALscyhODbpzpNkQ9z4sx+7jErW01BcfyCCEi2rcKwe4xLS1LiWeg9Tww3w4Ky9apH
	 +48Y8TK4lsOVvnD4TnL1u8nBQva9uU4SgfLLfb2baTZtnLCHbTBzeVjUJWKDtTHH4r
	 Unf/eKsbTKHZw==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 4/5] perf intel-bts: Fix off-by-one in auxtrace_info minimum size check
Date: Mon, 27 Jul 2026 13:17:04 -0300
Message-ID: <20260727161705.64807-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727161705.64807-1-acme@kernel.org>
References: <20260727161705.64807-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Same pattern as the Intel PT fix: min_sz is set to
sizeof(u64) * INTEL_BTS_SNAPSHOT_MODE, but the code accesses
auxtrace_info->priv[INTEL_BTS_SNAPSHOT_MODE], which requires at least
INTEL_BTS_SNAPSHOT_MODE + 1 elements.

Use (INTEL_BTS_SNAPSHOT_MODE + 1) to ensure the highest accessed index
is within bounds.

Fixes: d0170af7004dce9c ("perf tools: Add Intel BTS support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-bts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 0b18ebd13f7c8456..02df3e46048912eb 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -830,7 +830,7 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 				    struct perf_session *session)
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
-	size_t min_sz = sizeof(u64) * INTEL_BTS_SNAPSHOT_MODE;
+	size_t min_sz = sizeof(u64) * (INTEL_BTS_SNAPSHOT_MODE + 1);
 	struct intel_bts *bts;
 	int err;
 
-- 
2.55.0

