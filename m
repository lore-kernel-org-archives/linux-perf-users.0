Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF43A6EE6;
	Mon, 12 Oct 2026 23:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849581; cv=none; b=ANzI1FHdq3BwbRtA3V5/Te/GtuVDvNJnqLjTCb4Si2a94fKhV4sYjNffRSbzTib1kRY1ojH/39LVWUsZD7YvUui4tof3FeRd4Ni1qpXBv1MlBgBA/1oyqd0g0dgn32sNTyn2xCJW9tLrr0ffdCaGZ8u0nVru5EaRQhRdp5c4g6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849581; c=relaxed/simple;
	bh=TVG14odBn7uZNiygo54IVe/dn+urU4tguusKcZTp6H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNElrbK+nwfJdzU1fY+6pWQuEMC7Rcb9TK0oDp8zsI778mh34sEjua6bKpVuJyLLFksapAeRnVFw8gjD/aUYhWiW4nj99qfDiaw0mhFut9LehnuW2qzKojTiyPEyV+ffwl5sdprQHUPPV1NOiuuDA4V561Oc+wgQB0Rr6TMQLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRg4d2Z2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRg4d2Z2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A5E1F008A3;
	Mon, 12 Oct 2026 23:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849580;
	bh=gqalZ+LzYcQFYRF0RJrs01kG40iNf5QCm7bmXmOvCwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KRg4d2Z2IC6Nt0SIlypyTYeM4kqcVRy4KusleX+3OMikXURmDn3fmRObK/ErTQs6r
	 3DnM9t1QmBy7CvDXOW8rkyStJnAR0ZkrXnxN9jubM2i9T/uqX+KCE3fAK4Qx3PqEIW
	 7owsYjenwTZ+0AuvxKgaNlNhc7QTkTPJnT6GD1G2O6P78gHcJAsT301BNhb+IphdFk
	 o8bF7Ms7d6uC/4NTkl6AFrFaSkz1gWrO99e0psLxbGwltVtkbputvXyTUMuNJ+cTf8
	 J+cp7Snsz3nQnjvFkHFDtY0VgykI3ufH79drAzGOV5fypB+d27WXCCTQG6KPCoyJ/U
	 xxZdSvnHgbSIA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 3/4] perf symbol: Set dso symtab type for libbfd
Date: Mon, 12 Oct 2026 16:59:36 -0700
Message-ID: <20261012235938.87912-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012235938.87912-1-namhyung@kernel.org>
References: <20261012235938.87912-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It missed to set the dso symtab type when the symbols are loaded by
libbfd.  When it happens both syms_ss and runtime_ss may not be set
and won't call dso__load_sym().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 02845b69ae6b5fcf..b61a574ce9a30721 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1922,6 +1922,7 @@ int dso__load(struct dso *dso, struct map *map)
 			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 
 		if (bfdrc > 0) {
+			dso__set_symtab_type(dso, symtab_type);
 			ret = 1;
 			goto out_destroy;
 		}
-- 
2.56.0.385.gd3acb90ef8-goog

