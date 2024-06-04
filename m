Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5B6C13B;
	Tue,  4 Jun 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511488; cv=none; b=sBgNfNiQKd1oOIOxS4yctVZneLmjLKJ6GvC1PoJmweyYTckwubbHX1mzr16Kabfp6tsvTWqE/agGxd2M2mVU3Dvq8QZwm0lxjCtHuKIf7MjeHu0v3iovYLKxN4o6QVrOBTwGXxP2yTBpyoAXqKScGK4yGz6E830kqbPQeeTJ28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511488; c=relaxed/simple;
	bh=NZYQS9DoJX1Ne9ARwerYzJ7WRfVLN4BYuXhHYJnCE2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B7Ftq7FOLB9cXHmnjnaRTsrneGBnHC3UVCa3wuicsv7Z/vD+OqJPkPHLxZWf5qO68tFx2G3CD8BR2Yd3RVzBydA0IktnbcqR79OWXTR8Bq0ZSrz6NDQj1GRxF0vwO4btnoir1lAv2L+AXwocRS9sNlYL//hTL0i3T85x6e0ewmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59C9B1042;
	Tue,  4 Jun 2024 07:31:50 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EBBB03F64C;
	Tue,  4 Jun 2024 07:31:22 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 01/16] perf cs-etm: Print error for new PERF_RECORD_AUX_OUTPUT_HW_ID versions
Date: Tue,  4 Jun 2024 15:30:10 +0100
Message-Id: <20240604143030.519906-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604143030.519906-1-james.clark@arm.com>
References: <20240604143030.519906-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The likely fix for this is to update Perf so print a helpful message.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d65d7485886c..32818bd7cd17 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -335,8 +335,11 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 	trace_chan_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
 
 	/* check that we can handle this version */
-	if (version > CS_AUX_HW_ID_CURR_VERSION)
+	if (version > CS_AUX_HW_ID_CURR_VERSION) {
+		pr_err("CS ETM Trace: PERF_RECORD_AUX_OUTPUT_HW_ID version %d not supported. Please update Perf.\n",
+		       version);
 		return -EINVAL;
+	}
 
 	/* get access to the etm metadata */
 	etm = container_of(session->auxtrace, struct cs_etm_auxtrace, auxtrace);
-- 
2.34.1

