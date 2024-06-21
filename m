Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52597168494;
	Fri, 21 Jun 2024 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989530; cv=none; b=sDrvczbPab+cw8a1o4+csiWxo4QirmhAq018OlgM4D0mdT1Ds+yOjR0v4LijYJliw8PADc01ccbMlNf0wAAmQG+xlpqkbSJA7fiJkDfH+tkgXi1ltaXyGceCRcoN5LZu4pyB1bSlIcab1aeEvtssf/yztAH3t7KWJwIuCJuhxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989530; c=relaxed/simple;
	bh=g6aPZ50JX5Sd5rVkOHN+CrZUoDyYQBCQxeejaCtTyEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9DmlDNuY2qzQSAD400Y8EEgNOhccaCl2vx7ITVov33IVX7GoC+BQje+7LH0glg1nes72URDXUkDh42hml3Ft73TtgwCX2pTD45DuRmnP4WEpA0r4jsL7l/ell+dhad92obC9pOnjcg0DfC582s6K3KTaC8yeQjnmXmjMkvqidA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcKEuwOL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcKEuwOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80B3C4AF07;
	Fri, 21 Jun 2024 17:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718989530;
	bh=g6aPZ50JX5Sd5rVkOHN+CrZUoDyYQBCQxeejaCtTyEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lcKEuwOL1p0XtVmHvI81ylA8aHLprZ8RCqBp5n4ihpaGzU1uBnKzE3qGWcbAg4aRw
	 lb61XQQ0KKIQzjh20PNwurQSyywaj3quEP7sdiZOilfcFWanQURAF+dbKVhlcYPy5T
	 tNlOVBU4czg8wrQPlRgxqeEh7MPoHwfwvKNz3aUSq5w2doxXIqy/KdtvuCmWe7qWwP
	 uM9tggW3uOFb6qBgydjf9XLCUIUmMhNGoqRK7mwJ0hnVtUzWWEgf48Hz0+z6UYUzKw
	 ObM2t9KM47+DWK2qBNetvtImFe1xoTPDi59MPKvGP1yEpECMipuLm3NVUWGPT6lALI
	 0t1fVux+LK+OQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/4] perf symbol: Simplify kernel module checking
Date: Fri, 21 Jun 2024 10:05:26 -0700
Message-ID: <20240621170528.608772-3-namhyung@kernel.org>
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

In dso__load(), it checks if the dso is a kernel module by looking the
symtab type.  Actually dso has 'is_kmod' field to check that easily and
dso__set_module_info() set the symtab type and the is_kmod bit.  So it
should have the same result to check the is_kmod bit.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8e2da48eeaf0..25dfad79b5d7 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1816,10 +1816,7 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
-	kmod = dso__symtab_type(dso) == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
-		dso__symtab_type(dso) == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
-		dso__symtab_type(dso) == DSO_BINARY_TYPE__GUEST_KMODULE ||
-		dso__symtab_type(dso) == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
+	kmod = dso__is_kmod(dso);
 
 	if (dso__kernel(dso) && !kmod) {
 		if (dso__kernel(dso) == DSO_SPACE__KERNEL)
-- 
2.45.2.741.gdbec12cfda-goog

