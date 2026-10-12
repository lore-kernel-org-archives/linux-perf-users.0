Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E83AE6E4;
	Mon, 12 Oct 2026 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791782770; cv=none; b=RzD10sB4MuCjXck8q0Nq0mU3lP5XfSDc2hSBuEfdvXZpOl2on4sJyg9civeNc9v2QK+hYlU3COjz8Or1w+Be807IkK040prEdf0aWX4+c1zt2a2jUwY+rbubSkfWnCCGk5bbmVHlxE4TGGFLjBFXtJzzDtE8D9nIpPfW/pouGP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791782770; c=relaxed/simple;
	bh=2rM9Oct4uEy2VAa1TaBnNCIRQri7kCV3G1nMYC1bQtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oynuReh2g3w8tBA6VbuTpXjEpwLalNvJJCOQMz59eOsbaKJHIVtBt/xRXkGAeBe2jgULvn8ZBM6WITrICmR+6Oq2RZfwJqYPPMvpVu+OZx1VeOQVI26vmSomQ1je7wGsPjpaiYX+Bm8qkccHq86saR5opwdggARS3tso0BftzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3uTnc2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3uTnc2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575851F0089D;
	Mon, 12 Oct 2026 05:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791782769;
	bh=ypUmWUyUJca9ruczT3XHkCd+A/tPxKIRub2K12oFzHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X3uTnc2prI7BcPq4XRm4RqipOS1rAWHW930w+KrL6dHMVXqTe3DdFvjn+cMdGBzjD
	 VLZ9x5g9FT+dLb9cauv+dmVszpcmW63/lZv2GIiU7Dyonm43+46b2IAhQyu/HVjWnF
	 2Y/AlxVlHh4J9FsXrdRYzMRxqiJUVwDwcfTDZGBbdqNZ1OGm9bdHiv67T0n69B4CgA
	 /AEJNWTIRdNDI/v3FduYALhNMLAvm1y33du0YJ5JtRArLS/75Yh5z3BSXYwc49X0le
	 IeV/Ge/GSjjXPSav9UJkUZwOZ2EsGq1WKSTrsHfidMTa+Q5/UKY5L4DwelvuqVPBW/
	 hUFYRrS+C3CRA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 04/10] perf symbol: Set binary/symtab type for split kallsyms
Date: Sun, 11 Oct 2026 22:25:55 -0700
Message-ID: <20261012052601.13920-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012052601.13920-1-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When it creates new DSOs for split kallsyms, set the binary and symtab
type to KALLSYMS properly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index cf099cbd29f268ec..56b8d75966133f87 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1099,6 +1099,13 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				return -1;
 
 			dso__set_kernel(ndso, dso__kernel(dso));
+			if (dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST) {
+				dso__set_binary_type(ndso, DSO_BINARY_TYPE__GUEST_KALLSYMS);
+				dso__set_symtab_type(ndso, DSO_BINARY_TYPE__GUEST_KALLSYMS);
+			} else {
+				dso__set_binary_type(ndso, DSO_BINARY_TYPE__KALLSYMS);
+				dso__set_symtab_type(ndso, DSO_BINARY_TYPE__KALLSYMS);
+			}
 			dso__set_loaded(ndso);
 
 			curr_map = map__new2(pos->start, ndso);
-- 
2.55.0

