Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45A1D90D9;
	Fri, 28 Feb 2025 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777470; cv=none; b=sMIlbRQe8SS0shl26RNQOVvu4KHONnPZ+EKWJ6Oz5y1IWW207Nu63EEp82xv1ftWL80CnAWzaHsUA6a/K73GUDKCD3bHMXEJlzNGMuNwsYLzE5CfbJMmbZi2l18hW67mPWLkSQRZAQsnM3YeklOc6YqfkFeX0tPf9Y3E/A+o0hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777470; c=relaxed/simple;
	bh=nYvMSWvore7t4zds8hMyNDRRuPH29EvqkcyYPeWwVNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAzSKKQZnamftCmkSbr8oThpi6Eon5YP3Z3fzG9yfjSqQhWhpfjjF2DSokCEb+BGBF0dQnxk0Y24i5LMbgLxcZrNGIH6tkWu55dMgC9BI9BQk96AEjAbx3/isVf4zT1j3t7kki2wUkUXaVAOqjvelTUAxeK2d+YLcmyAXjLHFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5p4w/6I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5p4w/6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A29CC4CEE5;
	Fri, 28 Feb 2025 21:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777469;
	bh=nYvMSWvore7t4zds8hMyNDRRuPH29EvqkcyYPeWwVNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5p4w/6ITSxnYqVf3ySi7ph1aqF2rraZEy7egLfi6xPwxnje9uxo6bnJ/xbRtI8pP
	 3nWLQUD2GE4zswiLDx4EdCyqUmRoUnbhWwxr8XEpTF8DcMZDm4cYOCjPepSSCOn7CT
	 KufsoUzezG4INIogD6Ws0SxHJ6aIQst4i6t/QiTSyWLM7YhGBDstP6ejPi71ryBSR9
	 jI8u66yDdz3lrRpX4cLIiKkChHXK6jrYHRxhguew55f5Rt0uLlXSmZn8W3xjeWFx5l
	 1a/zjVxTAh+jmzdH/+jMfpOuSyQGHA2XTqjwSyRYuo/O2d/TJ3DpmTPYuDuOOxujzJ
	 bQkUKk91/9PEA==
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
	Peter Zijlstra <peterz@infradead.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 2/6] perf maps: Set the kmaps for newly created/added kernel maps
Date: Fri, 28 Feb 2025 18:17:30 -0300
Message-ID: <20250228211734.33781-3-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228211734.33781-1-acme@kernel.org>
References: <20250228211734.33781-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When using __maps__insert_sorted() the map kmaps field needs to be
initialized, as we need kernel maps to work with map__kmap().

Fix it by using the newly introduced map__set_kmap() method.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lore.kernel.org/lkml/Z74V0hZXrTLM6VIJ@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/maps.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 51b507233269d8b4..8c5f5d79cd24a6bc 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -798,6 +798,9 @@ static int __maps__insert_sorted(struct maps *maps, unsigned int first_after_ind
 	}
 	RC_CHK_ACCESS(maps)->nr_maps = nr_maps + to_add;
 	maps__set_maps_by_name_sorted(maps, false);
+	map__set_kmap_maps(new1, maps);
+	map__set_kmap_maps(new2, maps);
+
 	check_invariants(maps);
 	return 0;
 }
-- 
2.48.1

