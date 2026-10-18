Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD9237A836;
	Sun, 18 Oct 2026 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341477; cv=none; b=MXhlN1dgZRTY2IsH16hKUm3v0ET04tSwt/InUqKEErQ1qMjW9K7RugLRsQ2O8yXPOcEwYO9axgpjLOHX7EUJqwDRbga4UKb4POl5ppzRaaeSebBE5LDQjRJrvjDkNuYTYlTm47qjGUuD2FOQVz3bxVYoAWSWAfaHhEndUXjw+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341477; c=relaxed/simple;
	bh=WXTvV7rtvitdmFdQYM8qBVau54lx+3W88ZM1dFAyEN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDSVkJ+aMga0e1XdI5ZKMR0/lwZwTNU7QQ68tmUWI9RUNsktePJukh28yeHaiPvxtgqAe1QHkayNWeOpyeb57cA/Dr76XSvRSd4aX4uD2Jhz86V+9c8+EKyF9IC8PyUfG95Ev9jNxM2owsVUYl6bVbMRfX/dH1T+8DnDNpim+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gtj1kCS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gtj1kCS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFF61F000CA;
	Sun, 18 Oct 2026 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341466;
	bh=id7H27gAG6NLIv4PzMVHCvi+cAcd+4AflCH/SR3WRbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gtj1kCS3RKrkUWd7cYUU4oZtEGvG8Yt7Iv+FCunVenOme4JTJ/3VKnQmie71037TH
	 cd/veCpREZ+2rnbrbnStSLwYpOABw8Yyu6b9FzFVRAbnoUTQXrnCFbCjvjyB/o/pn2
	 pj8VmhJZANY3IHRB+a8S+CU8mnQnr+Y4Zwr5xb/jG1MzGovcoObfUfOj1NzWGswF9+
	 TbDvsLBHXeXP6RcR8gT6sQ4frU5Q29049aYke6yd9uG7Z8Mxdn0C0tifwZVUsmr8Ig
	 wqrxgNXH/2An8oZG6rZM0ybiugFqZcBDEcTEzdt89GiaMOjv/Z6NpItrYzopcIj7xN
	 wcoBUUOaoxOgw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v1 5/5] perf symbol: Ensure dso__set_is_64_bit() for libbfd
Date: Sun, 18 Oct 2026 09:37:41 -0700
Message-ID: <20261018163741.850434-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261018163741.850434-1-namhyung@kernel.org>
References: <20261018163741.850434-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise it can confuse cross-platform analysis.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-168776@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/libbfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index a4dcb406c79e9cee..9cc6216ce3adbcd0 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -462,6 +462,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 	symbols__fixup_end(dso__symbols(dso), false);
 	symbols__fixup_duplicate(dso__symbols(dso));
 	dso__set_adjust_symbols(dso, true);
+	dso__set_is_64_bit(dso, bfd_get_arch_size(abfd) == 64);
 
 	err = dso__has_symbols(dso);
 out_free:
-- 
2.56.0.176.g3575e65682-goog

