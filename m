Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566DD7DA66;
	Tue,  9 Jun 2026 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967157; cv=none; b=XONeIX1yy1RGqdICnpE487FaqpascJu646uM3E778h7h6+g4ilhzS98C5RtrbNlZCXotbElOTb819pclfAeETiiTyIBBIy3WJtFmx/dn40lDwmR+sE6mkIpiSAUJrQnMZkimKYbbrabHyuCeQKb3NfjOzh3/BNK0bisrXWig3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967157; c=relaxed/simple;
	bh=FnumF4v6KH/LovI6jupY+ON5IvGcx3lwnWp8nh6cNeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ur4CjvBwMIsHHNYdZB0CLgywwddjhshG+3Bin9AD6nr1aFsmEl0XmFcmT9vEqk2NszjEbLnmm07jf4YN+lVUkaW8H2g31gXOmFtWIGMHOx+yYyu1de8glV5Sn3pwYw9yVh+ZunLSZSf+8leIAe8OAzjmd98ONAOJpp5js+3ZhbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5MDUzMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5MDUzMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4491F00893;
	Tue,  9 Jun 2026 01:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967152;
	bh=ZYWxCGDPEbOjKFAvyazf7TQklMJhkD1Q/nWODM5lprM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c5MDUzMvqECk6c8PKL0TTCeFFZ+M1OwpJ7rMTkmU5MI1tiougSwylT9pqpps8M7sU
	 29RD3JjfmrRQGS3LhDVYKVYZ6D76+n/y7AqRubcOHU0WpN0GL7ck0g97SxeC5+sU37
	 Dx34An025RWqIratxcH7D8EG/Jm7r7Zv5vLgqrVKy22oFGV3kJ95CWfMRmL4f1uVt9
	 ZfuYCm7uhZm+43jgLBfDc/FR5fVqf3JUwU/EGqShj9PufZ0uo0SFU42Qbdy/ZUFTeK
	 WcRK+RWRwEdFcf44YX4L3aJ3/IEEOoGINOEsMd3h4gPt1377azRcJDEgm/fkTGP25U
	 Gxti6xjRdVUlQ==
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
	Yang Jihong <yangjihong@bytedance.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 05/11] perf sched: Bounds-check prio before test_bit() in timehist
Date: Mon,  8 Jun 2026 22:05:19 -0300
Message-ID: <20260609010526.1998472-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609010526.1998472-1-acme@kernel.org>
References: <20260609010526.1998472-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

timehist_skip_sample() reads prio from untrusted tracepoint data via
perf_sample__intval(sample, "prev_prio") without bounds validation.
A crafted perf.data with prev_prio >= MAX_PRIO (140) causes test_bit()
to read past the end of the prio_bitmap, which is only MAX_PRIO bits.

Add a prio >= 0 && prio < MAX_PRIO check before the test_bit() call.
This also makes the != -1 sentinel check explicit as >= 0.

Fixes: 9b3a48bbe20d9692 ("perf sched timehist: Add --prio option")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Yang Jihong <yangjihong@bytedance.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 1ff01f03d2ad1ad3..ded511d8518803a0 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2645,7 +2645,9 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 		else if (evsel__name_is(sample->evsel, "sched:sched_switch"))
 			prio = perf_sample__intval(sample, "prev_prio");
 
-		if (prio != -1 && !test_bit(prio, sched->prio_bitmap)) {
+		/* prio comes from untrusted tracepoint data — bounds-check before test_bit */
+		if (prio >= 0 &&
+		    (prio >= MAX_PRIO || !test_bit(prio, sched->prio_bitmap))) {
 			rc = true;
 			sched->skipped_samples++;
 		}
-- 
2.54.0

