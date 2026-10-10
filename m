Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC62321F2D;
	Sat, 10 Oct 2026 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791656689; cv=none; b=e/+MvDz/2ZD5d30jL/FRMVCaTdOSZhaIJQ+p5FlsNYL7kQCjZ+k91IaLs8VM+nCmYoc+v/8bfYJML63HVySxZxpfSFIZA5VxRW1XiCaSgy53LhiP4lUpNvvJUAjjCSe098LvudES6v6ex9MxIAGI0bmBNKW1Q47hPG5tfvAohZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791656689; c=relaxed/simple;
	bh=SYUmBL3RmJdzSTMC894Y9LfhaxgW4dk1nsSwFQ+UTxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uza2JEsTtu1/sr2nUVyKvGmYUU6IBAzyX0/qSOk+0Gsc4916Dfii/S8qNBsvrPdNnyyR1YH9hW4v+ZX4dWjOreioSg98epVPy6DblItxJFUF/u5xAAbgPbo28vd50EGCP0J0rzDxQ9Tqsf2EVklOYMO6hjy9kZuorTf30DTrhDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5yIsYeb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5yIsYeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FFD1F0089B;
	Sat, 10 Oct 2026 18:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791656688;
	bh=g89t7BWUfrWzAx8CnLcTb6UfA9H7Ma+ln7pusXR6lJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H5yIsYeb1jA3nB7rjoAAvTVoEGFC/usY4qbwBgRgq/pPkcugoROrmNnnzCSYo1fhV
	 ocbJWk7933BufEFHg1wJkeLWV2GWzM6YO3N7HM6XwbO9LbSaCGe4m40vQjIUx3qS8d
	 JQ9Hr/eGA0PO9ZaFlRZgscg9x9kNzAvBQN4bElgLlyRPjPr0ehCmlDYmYqnLiwZ4if
	 SImdnkQ+yiU02dTKNn+71xVCsqks7Nu0HyFWeExi7gOUcSWKU/PRx7uf8waa0bm62p
	 engUzr3zvMZty5VOruCkSgxdnxFtkLxYCwl56Ui9shnL9NGLJQc44cfxqUBr6TBVLb
	 M9Z0wm8A1ojkA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 2/3] perf symbol: Add missing symsrc__destroy() for libbfd
Date: Sat, 10 Oct 2026 11:24:38 -0700
Message-ID: <20261010182439.9732-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010182439.9732-1-namhyung@kernel.org>
References: <20261010182439.9732-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When libbfd loaded symbols and there's a pending syms_ss, it'd be lost
or overwrite existing symbols.  Let's destroy it before breaking the
loop so that it can safely return from the function.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table with libbfd")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a394e742f9b18812..93045123cbbefdbd 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1931,6 +1931,10 @@ int dso__load(struct dso *dso, struct map *map)
 			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 
 		if (bfdrc > 0) {
+			if (syms_ss) {
+				symsrc__destroy(syms_ss);
+				syms_ss = NULL;
+			}
 			ret = 1;
 			break;
 		}
-- 
2.55.0

