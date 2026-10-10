Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A434041B;
	Sat, 10 Oct 2026 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791656689; cv=none; b=K2NXvQoYdKW6RKtJihYpllczP3Yo9zMu1gZu9nBfDGNU+rt0l+lM1w87F7qwIhWX7kwWuaEPTgXcaAxDMr84WHdTFgqQXaUxjXS71GDBEsB9HIo9XBuc1SCh55QkRwpMG/5S/HO822e3cXftHd5s2yS0KUYksy+8cxiBVQ+w+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791656689; c=relaxed/simple;
	bh=taM3C7lMrmxfXbcHUEyijKuL/TFuOfvDeQIV3EYLIac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6UcEGW52MhrJYhUtSn0hzudhf5OpdCKeLzwGRTbFcwDPj2jPe3lZA2F0QUb1iwxt60gXg0sgpQFIm4cAWGfMkfNaEzThXEJqVLCgkfixytbtUNteef4ypXXioY6VLECGiLDzoWkxjhzDF1Ms47aOMmMMcB06KoFU86uVd3u2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iokSywi4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iokSywi4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F34C1F00899;
	Sat, 10 Oct 2026 18:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791656688;
	bh=n/JyHwSyyHl1jiyR3ZOWyuEmY3n+5kJuoFXLeWOATHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iokSywi4FKds88VS2twnUWdeS1uS33ecPg9hCV2X7WK8lN52DSTagHTyj6N9gYVoO
	 qDHsY8V6HCSDm1Ju/We1awmNy6mGxMsmVrPbVCpAFmd8/443m+m4mwj/mmnkrsgNrU
	 rK3BzBMZrMdIPzUjb8y9iQzmC5rOEGBu3r2b9Jpv+Vomw9rgcVBRB5PA0izEz7drnE
	 aTSNbE08pUa1jgjCQs2/bROBQr3ol5M5vcL9yJuQXM8lSNOWvB/K8g0ArCsgljgTxN
	 s9QCVfZ1M96QkNo7E0d6xIl39200d+2/WHnIjGJ/LjDnNOp7Ydn/ZVgNUyvrsrqxD6
	 3j56/RXQu4Uaw==
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
Subject: [PATCH v2 3/3] perf symbol: Set dso symtab type for libbfd
Date: Sat, 10 Oct 2026 11:24:39 -0700
Message-ID: <20261010182439.9732-3-namhyung@kernel.org>
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

It missed to set the dso symtab type when the symbols are loaded by
libbfd.  When it happens both syms_ss and runtime_ss may not be set
and won't call dso__load_sym().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 93045123cbbefdbd..5c2ba61ff8d9de51 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1935,6 +1935,7 @@ int dso__load(struct dso *dso, struct map *map)
 				symsrc__destroy(syms_ss);
 				syms_ss = NULL;
 			}
+			dso__set_symtab_type(dso, symtab_type);
 			ret = 1;
 			break;
 		}
-- 
2.55.0

