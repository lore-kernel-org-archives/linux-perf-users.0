Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867638;
	b=dB9pm65AtBh8o7nCYU6lHkIItSDsZllA4IJfKn+gvSBoEhmXsnFroWvGZ/lA+3uNpRQd
	 mybs/dLS0At+/LrLxW7cT3aMJxkmI7bivohmUEAQBgTWJdS8vdCOImOPji3ZpX8wmaYUR
	 ap/jc4Rh7WHAH7MkCiEbGT3S01z4t/WPPkI44e2ZtwtZu80l5dFK0vTeMnRIV5e63udDu
	 iArS7ivm8z9xpbzrsnT8fC4iwb5M02H1NDATlM8q1iRYnrSJjaxBUbtmw1aZF3TaPUeym
	 2wKsenw+4pTCDiRvVqy8A6vAkluel2AZiRHswmMeSbZx5mDvK2xSCnlOsNUWv/P+u6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867638;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1y7HJKFcd/hs6WgnJ0FM3A57W6UPrI/Z9e7pumtawKg=;
	b=at5VfOdBU3K69Qt7df5464jTrdg6kx3EFMjtM4cMK6xsNd0uNPwci58jBtkya6uSXRCG
	 PWJ0V5ZycefP2RYa/2IeER28DwtlPjle99xGQEwrKYVG0/n3jV9wxYRIodkcLyZkdYA/C
	 aJUW3PU1sux3j3HMboa714NSznfRiKhtaJMCGQ0rxy+yClgLL89qGChYwvy7P1kx5+ypE
	 RSbklZCZ+y8p/HmH3VGvGSWM9gUI1jKA7YlGekxJnBuHLQC+HlbF7LzhGLu8vvCwTlYXX
	 gI+HR3Y3g5/kOmei5r+jdnJmylCs6e7BbHmAVzA+OtasL5UyuyJty/9MXZl4j42jsng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k82z0/V+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C298606A332
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k82z0/V+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722C51F00919;
	Thu,  5 Nov 2026 08:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793867638;
	bh=1y7HJKFcd/hs6WgnJ0FM3A57W6UPrI/Z9e7pumtawKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k82z0/V+Ehn5co5Tezh46Va89HMPJ2KwGs+D0JzQUUUlT1IlBJc6r5uDp4yBCsLnD
	 Z/nFEHltnELSEmxQVqoc7kX2yTMBo/kqM7S0q5QVnQRk9TKHElpB3ytG5Jt1woHUPv
	 EKWWpEb3xJBN7z4QFtkeCZej2wITYSBSvgHjQkUp1Grx7NwBz/VhNfDveKJl/3GtL2
	 yWcRd4YXgvCSZX2VCvJQcFdVXX0yEIu3uqqN3GuW34TO7zdMUqc57aHRJZyFpD/wMn
	 Sq1hF0otdimPOSAHLOfDQGm1b0i14/cz0lfPFtQ+O/a2e9M2x5W42HhezOnLbwgbme
	 cXxxPsC/b0jdQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: acme@redhat.com
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/3] perf: do not call zfree() on uninitialized pointer
Date: Thu,  5 Nov 2026 09:33:50 +0100
Message-ID: <8b245572903b8c4ed0dc569d7a71a8f4974e2455.1793867553.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793867553.git.jirislaby@kernel.org>
References: <cover.1793867553.git.jirislaby@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In add_drm_pmu(), the check for type > PERF_PMU_TYPE_DRM_END happens
before "drm" is allocated by zalloc(). The error path nevertheless
called zfree(&drm), i.e. free() on an uninitialized pointer, which
can crash. Remove this bogus zfree() -- nothing has been allocated
yet at this point, so there is nothing to free.

Fixes this compiler warning:
In function ‘__zfree’,
    inlined from ‘add_drm_pmu’ at util/drm_pmu.c:110:3,
    inlined from ‘read_drm_pmus_cb’ at util/drm_pmu.c:174:10:
../lib/zalloc.c:13:9: warning: ‘drm’ may be used uninitialized [-Wmaybe-uninitialized]
   13 |         free(*ptr);
      |         ^

Assisted-by: LLM
Fixes: 28917cb17f9d ("perf drm_pmu: Add a tool like PMU to expose DRM information")
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Ian Rogers <irogers@google.com>
---
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
---
 tools/perf/util/drm_pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
index b8badae7015c..5e4bdd8e7fa8 100644
--- a/tools/perf/util/drm_pmu.c
+++ b/tools/perf/util/drm_pmu.c
@@ -107,7 +107,6 @@ static struct drm_pmu *add_drm_pmu(struct list_head *pmus, char *line, size_t li
 		type = PERF_PMU_TYPE_DRM_START;
 
 	if (type > PERF_PMU_TYPE_DRM_END) {
-		zfree(&drm);
 		pr_err("Unable to encode DRM PMU type for %s\n", name);
 		return NULL;
 	}
-- 
2.56.0

