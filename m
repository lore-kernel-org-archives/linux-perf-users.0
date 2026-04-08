Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812C83537C5;
	Wed,  8 Apr 2026 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669363; cv=none; b=elibtYP4vzupfdaihfqRXT1hNUtdhOiLgMKAk+ZRKrxbJwNg0A24zRCz++HMocHMn6vLK+UaWqmpieQ0MoUAdwUBnkyIwQMsFxvNx+097hQPJFVqkmYIxZfqVd8z4n9lD1dEKjv6CmtSdffXvW8iysiJGtgzV6cEJY37x9MmCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669363; c=relaxed/simple;
	bh=zvPbwivfF6emMlDbSDXfWAyZlG8wtviaYd24n/mYMMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh2/re39WEVsDTFDnFRJjNHlEdAsEsAlsuwjs6OviL0NFaOutz8f5T6Zxk+zLuvDtYCU2cs6jVIhEQ8Fa0lExtQc9U4CN9WsSVrmehlOV+pbeeTeWRwoblZUOpRTbttoX47gJAEqHl+SvRNlRZ2uADUxX8/W2+LJMKQ4gdjsQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLBMqjHj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLBMqjHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC1FC2BCB1;
	Wed,  8 Apr 2026 17:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669363;
	bh=zvPbwivfF6emMlDbSDXfWAyZlG8wtviaYd24n/mYMMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dLBMqjHjHJEN5nI8xXjiAkNLFkrblRML2mHgjeqECZLIKly4vNAJrgl4TGXAePqsD
	 AuhV6OW6ZsVRGTxiM8t31narIbh+uG+e8dFccS1UMx7gEW5ekJe+jloeN3MsVSfaxL
	 DgsX8h4L5+lV5qFTizmA15eHFgBLP+9H53eB4Uj24mVYtQO2mnNawc5JD90qsLUWc8
	 57mnaWKVzJUxDyN4xOaifszsjmEtHqiRGpP/oMJD+0vd7tk3CsWEmm/9x24Wl9UDrX
	 PJQyS3BqUVnz+WoUpftXeCdHyIwSjwCI9O2hh03V6zxLF4/ojzXlaJjSZyARrNQjXG
	 l0oOTlFhrlL4A==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/8] perf header: Use a max number of command line args
Date: Wed,  8 Apr 2026 14:28:43 -0300
Message-ID: <20260408172846.96360-6-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408172846.96360-1-acme@kernel.org>
References: <20260408172846.96360-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko suggests we use some reasonable max number of args to avoid
overflows when reading perf.data files, do it.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a3b7b796639b42c0..a18f216f77c27430 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2795,6 +2795,9 @@ process_event_desc(struct feat_fd *ff, void *data __maybe_unused)
 	return 0;
 }
 
+// Some reasonable arbitrary max for the number of command line arguments
+#define MAX_CMDLINE_NR 32768
+
 static int process_cmdline(struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct perf_env *env = &ff->ph->env;
@@ -2804,6 +2807,9 @@ static int process_cmdline(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &nr))
 		return -1;
 
+	if (nr > MAX_CMDLINE_NR)
+		return -1;
+
 	env->nr_cmdline = nr;
 
 	cmdline = zalloc(ff->size + nr + 1);
-- 
2.53.0

