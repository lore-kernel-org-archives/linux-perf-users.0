Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F4E388393;
	Mon, 13 Jul 2026 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783986339; cv=none; b=pTClM3jbeJyvyXo730O6r6isktjUdeJZW1BokQO4sZICKzdAHLmFbg0O9EkFk/FSinroRVFp9Mn8u7YST3tiIQd1W/mPTgE5g/ez4A2zYSjsozpvmSAQ2wwvODgWseiql/YAhv2jfare3ZGb8Ym0i9DVq0yb5VbbZvTbYlH4Gzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783986339; c=relaxed/simple;
	bh=7Y3DTKf2fI+ajLwDzseyuEayaIVwLo04yvH3oUwmAiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6kcmjfYLYmDi8N5YHQ9Ry1T0C56QYjMfbFlzjPg+O7uBjcmlz+vobkjRRnWae5yQ7BHOkzItL+HTqiW2LQROdghs6X58s0PaLL4udTRsUJWwUX+Bumt5kZ6Gk33xTe+P3gxrU8w1kP4quxtaOcWbrt4j0Lh53Mpcmk41dGe6Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrR6R6q3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrR6R6q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346FA1F00A3A;
	Mon, 13 Jul 2026 23:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783986338;
	bh=NHlZi45oV++7xZVrBiLIa7if84QvUn2pazP4hHbcUcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FrR6R6q3tZNhQP3e8s8UN3EfOV4zKgk93b9z+tIAIpYOOMb34vYI5oh68QokQ1tBB
	 WBT3dM6b6bdVMnWZnhKxM4sG/RXaMLOuCV5M8VX77uAB2C5s1b7/YSNdOh4z+kej6w
	 BpGU2vq691n8aZP6Ljc/4PcwXbfLOtEePjH+NGusgjxqEceswnvqhpNQyxZzlFlgxv
	 F3D0Ct4NSTUKFyer5upaZiAG65RukyY5pVdbla2IaQR5RaDfIqPN8Z7WvGBJf5HWIU
	 S4G+QEsr4RmcGA7B5JiyRcnqw06NbalzH46Vcjk0rv5aHUjRjkr93gizr90i8aMe5Q
	 s805hFrAeLEnA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH v2 1/3] perf sched: Add missing perf_session__delete()
Date: Mon, 13 Jul 2026 16:45:34 -0700
Message-ID: <20260713234536.2280374-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260713234536.2280374-1-namhyung@kernel.org>
References: <20260713234536.2280374-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf sched stats record missed to release the session and ASAN
reported a leak.

Fixes: c3030995f23b ("perf sched stats: Add record and rawdump support")
Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 6e0d8f4d270e2d88..c5728f3aa46f2630 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4027,8 +4027,8 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
 	else
 		fprintf(stderr, "[ perf sched stats: Failed !! ]\n");
 
+	perf_session__delete(session);
 	evlist__put(evlist);
-	close(fd);
 	return err;
 }
 
-- 
2.55.0.795.g602f6c329a-goog

