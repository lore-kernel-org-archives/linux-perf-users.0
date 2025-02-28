Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48581D9A49;
	Fri, 28 Feb 2025 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777481; cv=none; b=FfXhHQEnDk27jaT80gD19452HkUkypt3WjkBfTuoFnYNmEIfJQ/pTVDVCfPf1OyIlezlktZfPDyNNn1YDVWLwURJ2a6G/dPJ1gXzr8Pk9oQvvYxsALkoIhu7kCZjNYb07zzY+fMbXFpke2aSjF91JsonjLUGht5KFiVqvbpKqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777481; c=relaxed/simple;
	bh=HOIWHA0hBCScYVAjbCgc402cQQuBHczuC2JXsLLUbNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPpxFQc8pq2y9gx8MUXy4xd4wEXNCB2K1mhMJlPdDUDwRHLLhqrgXa5EIAnXiP3pWo6XM2ctiZ8Z0f4hqff4L5TYx8Lt8Q/ZxX+XvkASK3BbOSD823/5Nkcpusg0vP5d0m3rCpaqQpjKKUQ7wf4mT7Q5QLiAsCWgNoEH7xrjXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMgIn46B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMgIn46B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9540C4AF0B;
	Fri, 28 Feb 2025 21:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777481;
	bh=HOIWHA0hBCScYVAjbCgc402cQQuBHczuC2JXsLLUbNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMgIn46BPxIOPc1+Y6mdqJyWqZbzHaNkdzlJ7mE4vEPxczjpB5Te0FhE3F+Ub/BQg
	 lea8AWhxAd0QXDvhlFi1SOaxuRKpbcsXdfkm18oC/4FdIwJumTfhAAGLRCBQQIcnlM
	 IcEvLwbIIhCx3yPFctqSSJZ4cxKNY2MvQ/Xgv0vNmHkZpGXIDW4EQ2SkiUZZ35Qifp
	 jo+ApE6qSO4J1G4VMrl4YHTreCFbeWoP/+TvYU1NcV034ByFoUJTioGnOmm8wwT2eC
	 cyE/g1q2KGz+lM4nnBEoSq9GXMZojyYE672FEltnZv8HFBDKeOnol4tDfRTNu62zqR
	 XIXrvH8wxfNLg==
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
Subject: [PATCH 5/6] perf maps: Add missing map__set_kmap_maps() when replacing a kernel map
Date: Fri, 28 Feb 2025 18:17:33 -0300
Message-ID: <20250228211734.33781-6-acme@kernel.org>
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

Since in this case __maps__insert_sorted() is not called and thus
doesn't have the opportunity to do the needed map__set_kmap_maps() calls on
the new map.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lore.kernel.org/lkml/Z7-May5w9VQd5QD0@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/maps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 77df9701d5ad7de3..0b40d901675ed57e 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -948,6 +948,8 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 					maps_by_name[ni] = map__get(new);
 				}
 
+				map__set_kmap_maps(new, maps);
+
 				check_invariants(maps);
 				return err;
 			}
-- 
2.48.1

