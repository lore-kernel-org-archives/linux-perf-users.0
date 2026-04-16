Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C41C695;
	Thu, 16 Apr 2026 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298488; cv=none; b=PEro8UcLaaPzXgrjEeawXX2SQK67RclomlRCSsK3KtTpMHscWbI0QAvr22jL/OtWZY7In89BMtWDdkMp/OrtWiAM2UcPbGzzTK1QYotM2y//ipI++l2O5E9JW4kzvioSbREePrqg3JjxeeIoA+MSrgYk6RYqGQYOp7Kr40yivKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298488; c=relaxed/simple;
	bh=bm3oJ/JS6e4E9s6WCF4O1PS1zkEWdUb9lIYo23abs3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ml2P/zx89bXdDMFAHPrJK6wLwyIosI2uyjMrjoqKCC3QOChyhUZiqwP6xMHbMTveFETwt2YU4uIPTdN/t1akEyEL9rH8TZCtriMzxbrBdEjlc86wkQ2pePp09fA11xMoTt49fijZuVWLhmOqtdmCB/BEC/cvwVst/PGdvL8c4xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc7Ueqcy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc7Ueqcy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77296C2BCB8;
	Thu, 16 Apr 2026 00:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776298487;
	bh=bm3oJ/JS6e4E9s6WCF4O1PS1zkEWdUb9lIYo23abs3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jc7UeqcycnGEHHO+/wicSfxCaOpWOpDojTi0MaIl7zylXnE5v823z4EPexBzE+NDl
	 SwIByA6BaYslYARvYTYjvzx6uNDlAVGLxzjyYkaYo/oF+Q2qbK0w1lQBlcCiGs/I3/
	 5euuVdM4To4Hg0X4eCKsvNfme6bEf7UdKZwdxrWGWC5N4mlDz0ZO3klWB2D/Evp+WU
	 nfw4a8kgprm9pWeLI6P0wxJNOoTyZf+k3cwqZOvLOY8mNcz7TWVH4NeYOFUdrkhQg0
	 Yrl2ANJyt/EnZIr5+I8s8QK6yLZUpu0hkBlDajwtgc8puLPF0Jmhi29FkGkVQslfZm
	 cstqk0mX7hgWA==
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
Subject: [PATCH 3/5] perf header: Sanity check HEADER_EVENT_DESC
Date: Wed, 15 Apr 2026 21:14:22 -0300
Message-ID: <20260416001424.362797-4-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416001424.362797-1-acme@kernel.org>
References: <20260416001424.362797-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

read_event_desc() reads nre (event count), sz (attr size), and nr
(IDs per event) from the file and uses them to control allocations
and loops without validating them against the section size.

A crafted perf.data could trigger large allocations or many loop
iterations before __do_read() eventually rejects the reads.

Add bounds checks:
- Reject sz == 0 or sz exceeding the section size.
- Check that nre events fit in the remaining section, using the
  minimum per-event footprint of sz + sizeof(u32).
- Check that nr IDs fit in the remaining section before allocating.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c27ed90727ea6629..3302748bac786fdf 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2141,6 +2141,13 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 	if (do_read_u32(ff, &sz))
 		goto error;
 
+	/*
+	 * The minimum section footprint per event is sz bytes for the attr
+	 * plus a u32 for the id count, check that nre events fit.
+	 */
+	if (sz == 0 || sz > ff->size || nre > (ff->size - ff->offset) / (sz + sizeof(u32)))
+		goto error;
+
 	/* buffer to hold on file attr struct */
 	buf = malloc(sz);
 	if (!buf)
@@ -2186,6 +2193,9 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 		if (!nr)
 			continue;
 
+		if (nr > (ff->size - ff->offset) / sizeof(*id))
+			goto error;
+
 		id = calloc(nr, sizeof(*id));
 		if (!id)
 			goto error;
-- 
2.53.0

