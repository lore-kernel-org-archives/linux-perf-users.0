Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA716A396;
	Fri, 21 Jun 2024 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989531; cv=none; b=lFs/kihTOlRCYU5jxnWD4GkD4x/FJF/ueAu7kSGew1+WmkQ+XAuzNAPjl6ppKOtbXd9YLZRRXleTmoFZ5s6Hzm6gYPa+Hq7rqylDZ7JfgkvtlKDDYck7/bNCHjduCSQjLlqqG5QiV1gRZQrfDlSoTjdlK69KOAhMy5/Rjd66OBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989531; c=relaxed/simple;
	bh=0emI+LOLxaFN5d1DG4aJdzE5Lez+85IG7IvfurAWcCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpxK5Xc5gaxHT4gJ+NrFUb4MI8UubLz8/922esclJTVEZK46vUXErFX1Ie4jq5Edza5vkj/k8a/PT8NqEIdUUlCDSyEYb0mla6u6eu/L3Ry+F43au/QoeCTynb9j0EBKT97saR4ZCV1+0IRWoiN0qh+epByY7apDdN8rX5+NYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPdnMXuI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPdnMXuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A68CC4AF0B;
	Fri, 21 Jun 2024 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718989530;
	bh=0emI+LOLxaFN5d1DG4aJdzE5Lez+85IG7IvfurAWcCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WPdnMXuIuSmp4ASEdY9K3ToUu+Cspc8FAVr4lwRfc46iUnDO0sjj4YULdKvn7B6P7
	 chrKkyF2VrieRbABTqI/Ldmhphh8cD2BRITyRHSf/66Gahk7D7pLwO8x97En83ZLnn
	 S6ntp38hTE2Ie7kjL2sO55KoHRKYxDzekFzpO7s58ARMiFKY5+vJKjr9W6PT1dTiAi
	 pCwUyF5B09Vqmv+LIXbeZaNYvhJlhOK5hC+VgXujQdg5oKUwcE6tJS6mMKViphRi3y
	 oUX9HtAUTKQr9GJdeMxtVsWyaPtKSOaZqOLlmVpUECBXz04ban+9lAekEUEUIviSed
	 61/b43+CIzEAA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 3/4] perf tools: Fix a compiler warning of NULL pointer
Date: Fri, 21 Jun 2024 10:05:27 -0700
Message-ID: <20240621170528.608772-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240621170528.608772-1-namhyung@kernel.org>
References: <20240621170528.608772-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A compiler warning on the second argument of bsearch() should not be
NULL, but there's a case we might pass it.  Let's return early if we
don't have any DSOs to search in __dsos__find_by_longname_id().

  util/dsos.c:184:8: runtime error: null pointer passed as argument 2, which is declared to never be null

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202406180932.84be448c-oliver.sang@intel.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dsos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index ab3d0c01dd63..d5d78bdc56b2 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -164,6 +164,9 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 	};
 	struct dso **res;
 
+	if (dsos->dsos == NULL)
+		return NULL;
+
 	if (!dsos->sorted) {
 		if (!write_locked) {
 			struct dso *dso;
-- 
2.45.2.741.gdbec12cfda-goog

