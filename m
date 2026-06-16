Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6006030F52B;
	Tue, 16 Jun 2026 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572134; cv=none; b=lH4nE5ei79OJJIzb8iOuL0Q4FkbvM2qOMR6fuoF+qWWf0+Tg4rfurfVnsR0Vlc2decdizVWr/EJSlu8EZE/hr9u5NiRxr/svQnGmrS34RJ8oDKFzOlAsboCFzwAR7/s4ZgtGZwnODWjj/DHh9LV77l6XXAKPlDR5MBc3wIHFJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572134; c=relaxed/simple;
	bh=qJr1/NG9cTBYMASr4fVzIqKY43KoGkxI2WexRuxmORM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az0/kuKhY5NHfG78K7nPrB1CkY9RXL3UfL2OUuehmft/dTTLMRuygmCmKWRwm4S13b3zaujLiZ5u0nYnnnpD01y5K633skIN8UsCNonvVIW36HRjf6QJ7zDm699RYdO/nSepJjPgYazHHRogcgKTKyHSFmy5zQG/0VUDfSyFYYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDZvhYuR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDZvhYuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556731F00A3A;
	Tue, 16 Jun 2026 01:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781572133;
	bh=wUHEbHiIOFcesf5bKC+5299t6lhCsUWWWGLvnb5OUj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZDZvhYuR1s5CCoMS3nZvF9mr6PjCyJB+IMgqgDwKNPPNJDBxLM5rFRV2e6Zm04f8I
	 hb47q0AF/YTkvn3XRntO6PNLQi+pKO+yLQf9kSUCn4tBEIft2MUaKIQmlM28r8ptZQ
	 +p/kFq8bpxcZoXMaVbTpkwGuvV0YBsvnWdpjHaKdj2L2xK2uZx65gSIePM5jZNSQfy
	 3hVCF9leQLKm5KWeAFwwIC4efFTa8uDEpXRDLspKuKylgn8qwAJXypLgTa9U+bYO1E
	 xmNE3ZoJt2Jdwoptrl0dvlrcH0da4Rb/Nbo1JvKHe6F2sTFTGdWT5wzTpEW++JXSyc
	 JCpr5BdX5UC2Q==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@linaro.org>,
	Tor Jeremiassen <tor@ti.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 3/9] perf cs-etm: Validate num_cpu before metadata allocation
Date: Mon, 15 Jun 2026 22:08:28 -0300
Message-ID: <20260616010834.37618-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616010834.37618-1-acme@kernel.org>
References: <20260616010834.37618-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

cs_etm__process_auxtrace_info_full() reads num_cpu from untrusted
perf.data and uses it to allocate the metadata pointer array:

  metadata = zalloc(sizeof(*metadata) * num_cpu);

On 32-bit, sizeof(*metadata) is 4, so num_cpu = 0x40000000 overflows
the multiplication to 0, causing zalloc(0) to return a valid zero-sized
allocation followed by out-of-bounds writes in the population loop.

Fix by computing priv_size early and using it to bound num_cpu: each
CPU needs at least one u64 metadata entry, so num_cpu cannot exceed
the total number of u64 entries in the event's private data area.

Fixes: cd8bfd8c973eaff8 ("perf tools: Add processing of coresight metadata")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Tor Jeremiassen <tor@ti.com>
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0927b0b9c06b1504..d121c8f22028d5ba 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3431,6 +3431,18 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	/* First the global part */
 	ptr = (u64 *) auxtrace_info->priv;
 	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
+
+	/*
+	 * Bound num_cpu by the event size: the global header consumes
+	 * CS_ETM_HEADER_SIZE bytes, and each CPU needs at least one u64
+	 * metadata entry after that.
+	 */
+	priv_size = total_size - event_header_size - INFO_HEADER_SIZE -
+		    CS_ETM_HEADER_SIZE;
+	if (num_cpu <= 0 || priv_size <= 0 ||
+	    num_cpu > priv_size / (int)sizeof(u64))
+		return -EINVAL;
+
 	metadata = zalloc(sizeof(*metadata) * num_cpu);
 	if (!metadata)
 		return -ENOMEM;
-- 
2.54.0

