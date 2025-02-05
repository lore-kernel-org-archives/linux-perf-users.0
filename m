Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F0422E3F4;
	Wed,  5 Feb 2025 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757791; cv=none; b=dNa4iUJYjHPF3rb+gaY5lW7mK9VFu3AMrT0kn12j7XzXhHXpSOZrozDQGTBNxKolTkE7vN1KVrbDWKPu9Qorgq2fT04Kx2YXGDulpP/uuv+QQaWgCvV9T4dUPqo3HV7eU5Drz2dLW0n43UWKc7d0+HNEwlpQgWybjE2/C++YD3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757791; c=relaxed/simple;
	bh=JVSKr79dLiZrLj2IbGdlKr6uW2ZB8lkkDpIM49Mo3g8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ocGqgHrXetICpwsF2lEo5JXGoaLiqigvE6Ph/Hti+1vG1zUuMhr8F6WAowxg1dtxnVSOBjrsfs1izbhd3/31CMV1on87Nk84F6dP7i104V7IUSd14ugwre9Mk8vdp/xtWpxxkLUBjKB/cVc7iMaluVm8pWTN6ZpkH6cQP/f5zcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A61D811FB;
	Wed,  5 Feb 2025 04:16:52 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E3DC3F63F;
	Wed,  5 Feb 2025 04:16:26 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Graham Woodward <graham.woodward@arm.com>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 07/11] perf arm-spe: Decode transactional event
Date: Wed,  5 Feb 2025 12:15:51 +0000
Message-Id: <20250205121555.180606-8-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205121555.180606-1-leo.yan@arm.com>
References: <20250205121555.180606-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bit[16] in an event payload indicates an operation is in
transactional state.  Decode the bit.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 2 ++
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 625834da7e20..13cadb2f1cea 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -308,6 +308,8 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " REMOTE-ACCESS");
 	if (payload & BIT(EV_ALIGNMENT))
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " ALIGNMENT");
+	if (payload & BIT(EV_TRANSACTIONAL))
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " TXN");
 	if (payload & BIT(EV_PARTIAL_PREDICATE))
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-PARTIAL-PRED");
 	if (payload & BIT(EV_EMPTY_PREDICATE))
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 32d760ede701..2cdf9f6da268 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -105,6 +105,7 @@ enum arm_spe_events {
 	EV_LLC_MISS		= 9,
 	EV_REMOTE_ACCESS	= 10,
 	EV_ALIGNMENT		= 11,
+	EV_TRANSACTIONAL	= 16,
 	EV_PARTIAL_PREDICATE	= 17,
 	EV_EMPTY_PREDICATE	= 18,
 };
-- 
2.34.1

