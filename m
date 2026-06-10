Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44B37C910;
	Wed, 10 Jun 2026 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121223; cv=none; b=h72C744HYmkMVS6hGaC72PhsJ9Xw5rnSro0RgSExMTAz8e9UwCtwmb92oYXwJsLUDv0cyILn7n+nyJbAW2RH53yy/RMly19wWrOQfBB7KZGnBYi0hVgs85/F0TfKb7+C31DKZCTPKCFPEtHuX0n8BmWy//HNnfeM2cKn3Iz2gOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121223; c=relaxed/simple;
	bh=iJbyh4Ni1UA9y8PnA1kKdlz4Qc/nuM2OHO7F/W4Zd44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1UmD81gmdVFefqMvIX2Epg8FTm6DtiTwyF+Yvc2HgsJzuZjYggHn/3SNRiwPbiBHBKE6s8S0JQ3ymGyUBveol7QRUX9eaJSbFp6qvJVnd8qx+8MRuzQMEbl7tQ9AFiCr8d7qEncyfXUF9cbgJhuZMi791U1IoseqW7yJU39Zws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Abor6Lvz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Abor6Lvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3BE1F00893;
	Wed, 10 Jun 2026 19:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121222;
	bh=2VcqUci4jBvDtPzcxYD8emw1QAzwrTIYsYeOWZhcdBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Abor6LvzzvYJCIbscHYcYxKnofpWPN0O7B7uh4lAfruSqON3t0v0ow1vDLSsS0XZt
	 rSaTcv/Wd0+mOS5VaoGV5q+Q8uR7uzQm77SSsJs1JKRRFhPQBS8wt+zh+tRNPk0EFD
	 /2KqVqYSE3XP53tu/S0MNnrQjTf9MeifLOxzI1VtldqytfEHh5nxDcoPzsbkH4TvBP
	 2DLsqYH7S0Wh1RhmA2AGjywMXjUpj9lljmIT+GAYlzXbnkgJaIx1uDLVp35+gYtd20
	 nGR1+eS9DfzpYjLQNBmD9gUbrRyL4eiTc6I6EFX/LE09gFX991a3ylzCent4ofDF8X
	 RFRHDCWKDFR/g==
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
	sashiko-bot <sashiko-bot@kernel.org>,
	Song Liu <songliubraving@fb.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 19/23] perf bpf: Add NULL check for btf__type_by_id() in synthesize_bpf_prog_name()
Date: Wed, 10 Jun 2026 16:51:52 -0300
Message-ID: <20260610195157.2091137-20-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

synthesize_bpf_prog_name() calls btf__type_by_id() and immediately
dereferences the result via t->name_off without checking for NULL.
btf__type_by_id() returns NULL when the type_id is invalid or out
of range.  When processing perf.data files, finfo->type_id comes from
untrusted input, so an invalid ID causes a NULL pointer dereference.

Fix by checking t for NULL before dereferencing.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: fc462ac75b36daaa ("perf bpf: Extract logic to create program names from perf_event__synthesize_one_bpf_prog()")
Cc: Song Liu <songliubraving@fb.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 2c09842469f1f28c..fe01551dc3e6cc29 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -146,7 +146,8 @@ static int synthesize_bpf_prog_name(char *buf, int size,
 	if (btf) {
 		finfo = func_infos + sub_id * info->func_info_rec_size;
 		t = btf__type_by_id(btf, finfo->type_id);
-		short_name = btf__name_by_offset(btf, t->name_off);
+		if (t)
+			short_name = btf__name_by_offset(btf, t->name_off);
 	} else if (sub_id == 0 && sub_prog_cnt == 1) {
 		/* no subprog */
 		if (info->name[0])
-- 
2.54.0

