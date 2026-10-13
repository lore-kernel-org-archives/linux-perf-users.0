Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E3524B14;
	Tue, 13 Oct 2026 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912122; cv=none; b=sTOWC7vbJrOMwPRX6ew9jrDg4wNnvZJJ0nIlI6vhuKa49Gw5UIe9PcBeUI1nTtkyuJoUJwA21Ff57NCe4xN6mgDzKjX2+yCGhN9doIhb1z3mcENbkeJ8oy5EEy9wl/xyn4QIhGivSec9GnA3ldxACFlmsGwo5mZ89Iv/1mMyu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912122; c=relaxed/simple;
	bh=ud4WWh8RUuNJmjMxj9NMd03ppEn0qDJz9Tqkf06RD0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWAO8TMrJFu2uk/RwO9GKQo0SN86DUPh/O+MWyWZAdnFgT3B89pKduvH28PB3ZABzNv/4vmuYN66BAcl9+sjcSUra27ih3/n8yig59ERU+uEe6XVzm1iURxLWL+rKLUml1ryFrSgvXkEUQIXKYTKnYmiemTF8B9xeVz3iprFJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+yaTVuY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+yaTVuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F8E1F00899;
	Tue, 13 Oct 2026 17:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912120;
	bh=nlNWeB+9FkyeYzISPfZxDiG41XzV77zEy8rHeT2l9uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A+yaTVuYykZng+OzeMwt9xMzXxTsrqreq93T3OaBUPEk9fNKlEzo7ii1dVpr4FXtG
	 U7Mf42dS78p2NM0p+7S/Es9OiaoYEeQE09oVsFSaXWYJzEuxxr0UAOvwX1CBNvNZyP
	 0x7uZ9oMQ60Wx7MskXI54o9aXNlzi3fK2OBQXySE6SfQHbaJXogSfMV+5pc8lEjW7u
	 L3nL/ab1hugT2fbzB+sBpQLDK76jKyLoEyU5LRh/JCtC+E5eRQHpuRsHY6zV5J1HXC
	 mGWOAgLdMyBdNwkb80DWwM8AsLTXQ+g2Pm3BxBuNPRsdoW/7l/4hgZUQNxLztsJWlu
	 qfRG/gDSJXomg==
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
Subject: [PATCH v5 08/11] perf symbol: Set binary type for JIT map DSOs
Date: Tue, 13 Oct 2026 10:21:52 -0700
Message-ID: <20261013172155.160869-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013172155.160869-1-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf-<pid>.map files contain symbol name of JIT functions.
As they don't have the binary data (instructions) no need to try
for dso_data.  Let's set the binary type regardless of the result
of symbol loading so that it can be ignored.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a7afecb5816c25f8..4a8c298039447cec 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1847,6 +1847,7 @@ int dso__load(struct dso *dso, struct map *map)
 
 	if (perfmap) {
 		ret = dso__load_perf_map(map_path, dso);
+		dso__set_binary_type(dso, DSO_BINARY_TYPE__JAVA_JIT);
 		dso__set_symtab_type(dso, ret > 0
 				? DSO_BINARY_TYPE__JAVA_JIT
 				: DSO_BINARY_TYPE__NOT_FOUND);
-- 
2.56.0.385.gd3acb90ef8-goog

