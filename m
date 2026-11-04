Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786887;
	b=t6+zww0sabURAPVMIz+GKhLmyOJdRBMiQKenZmzTaTMGTyOPhixAnFP6yHuueJ0NrSYI
	 uOGAeZtRGNJbnXTMK6E3uBXGdyjkKIe2p0My7mafxm5Y0w6GYMWV6qaqwvtSxCAgpwVUE
	 yNcF/Db6ltmi0Vu6TDadaVmz7+4RizgJzTEQpJUX4HfltAMTO8v9CynC9QWCXeaQ3Pciz
	 GJowmiIznwGVLLomc3z2iftoRlmQGM1tf3TFgE0vABDVK6aOxFiqrBGi4U5aMmQhXhq7v
	 kKaj645n2mPNJOTYfsYG6Yju+usq+++xSNwmKlDZp7UrmTzEdIj6cMp8pQGCzseYjSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786887;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1y7HJKFcd/hs6WgnJ0FM3A57W6UPrI/Z9e7pumtawKg=;
	b=b8T0r2MlLGZlLQJaaKnipMoBY4jP9a8W2Ks6PZf1HDkxUHFVrDGMpWZtgmN/61/WzMjO
	 XeU/NBSiVO2MfBDtv4iuq/tAwNygrbfxVXokSVrqypM9QXkfdrWWK7rfdlnAc3Ux6szNP
	 TkMQTlcSvi1C5m42SIqFyMG5Pdvi+9+L7QRvlkNMXZU98wBGOapNi4zOmY55O4ACqKGbg
	 9rM49xf74a2Jncbdb2eXBi0HK1qAollaeY9+1jFHyKrcRsGeevbKDme8Th8PdIeyyR0yZ
	 7hxPQTkzVoB1BPIq4UBO6isz3weBVsydHuKYNxuRlNtYdELctqMoDv7VAAzXXjtpCeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8eaEwGb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5B606A335
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8eaEwGb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70C31F000C1;
	Wed,  4 Nov 2026 10:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793786887;
	bh=1y7HJKFcd/hs6WgnJ0FM3A57W6UPrI/Z9e7pumtawKg=;
	h=From:To:Cc:Subject:Date;
	b=C8eaEwGbgHABooZHsFznyg31El6Yy2QTkTf8y3E6V016fcP+c/ruSkyxodVCBMtj/
	 p+9OIl1nmwDW61HHwCBwsVdSdvwXFxXp2gm/s/aQXemAfLBe0euCKNzYqHG5aNBLnn
	 ApJISSj7TwX+HLHQihn0Psv2GC8mJKygeG1ckloVMeN4O4z3K76V/7Ki1pyBoaeDas
	 OugxzubbIrZSBt6LKSX9OgBEAPcIFlLxgGMvJDJN+bqliA0Mnq76mcVMxGV9gJl92r
	 WFVmil5P0p8h7E4DbQIZj3ysMYgHCtiVWF74Mdg0QImLFoRvdae710MId4JmvdVW1E
	 yc8v4OLg6tMNA==
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
Subject: [PATCH 1/2] perf: do not call zfree() on uninitialized pointer
Date: Wed,  4 Nov 2026 11:08:01 +0100
Message-ID: <20261104100802.539266-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
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

