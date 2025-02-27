Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472AC272914;
	Thu, 27 Feb 2025 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693312; cv=none; b=mlZe0L0JZE5ezd6B8rweaSAQN9xIxeFwC7zPc2BT4asJWIZ7JIiwfuz2rkwuuoEkL/JT76svWuKMgseY4o43pDgWxwwdBC4TGKb4P3wkVXYLPaJpHf+KBH3cryYG7eQqV3wC/7yqRrz0P13110qqLWWaHinXrcxOQdGrmEKK1Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693312; c=relaxed/simple;
	bh=WoTiUX407mXfbtufK5LL7Tb0E3rMG/9ekMipJlBPJJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFG8hISeGaMQPkeerDB5lhplY7WfqjOOu+vfXRLtWKaD3NXg+MD1ba0ZIavgfAhd4P6hhrcX2/mrh4wa/Xa9M9FiO4FJOLt+d0q6AsCpGITARXbW9rdvw+WQMt6GZgwziZ61joJZ4KP25H9UOCEasD+HfbpTjm7Hh/mRTmxG1fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8FZgglB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8FZgglB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71033C4CEDD;
	Thu, 27 Feb 2025 21:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740693311;
	bh=WoTiUX407mXfbtufK5LL7Tb0E3rMG/9ekMipJlBPJJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8FZgglB4MnsHJQtoBI1+zVu+oarKwpKVrVtQViGvNLLFax7Tcspv7wUHSmDLbkoN
	 qtgqvVaLzrWE7yJlepAPGearSGuizTxjYJfrJ131yDUWVLZm5O9Gux1S+V+407ovSl
	 RGn+wC4uENRwx+syL46ebKOZ2LmjF4fJrMLexZj9B9bnsZCZcDkzkuv8USOxYF/Q2N
	 sZHM2srTf+9JzCMcMltFmJVKAE9mzZIVKSEFIJhsmWWi1PqrhwPBxd8rx5AUoPiOxJ
	 E/ru4L6V9ypMdNVceifr2ZdqsofwYgJlAfR1gic9RhG68C7oNDPpbHv06fYkPrYeGr
	 gtiA+V2PNjDHw==
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
Date: Thu, 27 Feb 2025 18:54:51 -0300
Message-ID: <20250227215455.30514-3-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227215455.30514-1-acme@kernel.org>
References: <20250227215455.30514-1-acme@kernel.org>
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
index e21d29f5df01c6f7..dec2e04696c9097e 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -798,6 +798,9 @@ static int __maps__insert_sorted(struct maps *maps, unsigned int first_after_ind
 	}
 	RC_CHK_ACCESS(maps)->nr_maps = nr_maps + to_add;
 	maps__set_maps_by_name_sorted(maps, false);
+	map__set_kmap(new1, maps);
+	map__set_kmap(new2, maps);
+
 	check_invariants(maps);
 	return 0;
 }
-- 
2.47.0

