Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599778;
	b=vvmRT6F747SXajajZcEZH7gyUBivC8qJYqYE38JoW+AfHHHs4vPFpUT20DPGWvK+zoCT
	 U4XKHOT4FzckPGxinbZAZrGFi6Vxv2G+szwV4LWwXYJ2mSzz9NaPMFnHIoabR5wPWrcw5
	 SR4JUDwP9JraX0v7mUqPkm/QmHubaQGfZ7Zo7hSpbe99mXHhsKKrr91+qwpbyAzt840C9
	 byRe9r3fFWSnW+NjvxpaF9KppjjccKOBYIcrAaME2ntejze/PFRofPSXSCp30UH7KnPUK
	 cr7K4SBZhHtkAjz1ESQFMPROJtufbmY0k6/fgXbpC85DtCEjeFmQ2hnc6IyWR0FtRfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=XMmzbunlJH192qX/W/79gqtuC2lEBdkCTnbknIAFCWo=;
	b=lk/HkN/JZeWlGnsxKV3GezWQ+A0ldEO7lC3eQULRyxXUPJarc/ccmsuk9WLM57Cmk1Mp
	 RHYl6z3LKF7zU8b7Hwo+EW/tcKCBRMVKubuyJCcD/pJl+gOrW9NKxXh/UXuOIyGo39bvE
	 ubdaMZtW4DMqdOsXhImu070RhUhDJ/4LL1/D6u3OOWjKoqNmlxP+ggudtC6a6qM3bLM5B
	 +7IQ1Q6ZIdvDKTHKsjLpo1M9I8lDDPMmErLhbUMDnmqSD65vN8MPOgx/2SA7s0jzNn2aV
	 9dxMQrIK9j7OShkjmAjM6mObIjc5UIXeMknlHagpyNt0LvVzEqRwFqbPVsqtrbVTP8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pbkkONk1;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3BE606F368
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C3BE606F368
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pbkkONk1
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36a3451ea93so1369301eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599777; x=1795204577; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XMmzbunlJH192qX/W/79gqtuC2lEBdkCTnbknIAFCWo=;
        b=pbkkONk12KAMf9mup0dhipMoiQnk3CQSZlnUMbKm7a7zLG6DWX0NKcjjKHOLoJLUH+
         Q2crmDQ7+ZZLqmr+um8SbUb36NzEoWswXITeg+IfGujvYoizOj6cLDzhK1daVnu33OKY
         sVGOyTEJ8SxJ4XcsZ+H5pQK/QKPCafJgHmez8G/7eCNQrQCh6yEVfmjw89+SZU4esWGJ
         Zc2PhLbcWYkNMZ7IPgh6yjLjFJwiOlxIGnxlq90qmLJ5R9lGzFOLhHoBfXzjavr/uJS0
         ZXyIZloYl/aVWo/YxI31hhdZJoga6cWQC5yzvKlGZSnPTfnIbF9Kl2XaeqB3oqONCbIH
         dX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599777; x=1795204577;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XMmzbunlJH192qX/W/79gqtuC2lEBdkCTnbknIAFCWo=;
        b=0UzIpNHLujyfJz1uJvTpgV3VkzbOtcCqKa7+fOCQaj3yeEzBf4J3kLbS+6CuEhxcPw
         8LxNYpyuMXqthWgrS+tQLppEIEx0Ek9WlKio17CpkSmW1oebNJR3+SsHx8jNDSX4qpt5
         +KutfnFoa6bWIzYXqvXqcqal+uGfAT0Qyg84U4TLvljXXm986NBMRRWbf5EE/Bu7jcRs
         Wn6UNHHKD2c9V43FgkYXc80xhrmWHX2KNx0FuC3JgpabG6kfewJUq6rI3btnbsRg/oO4
         JQzeax/HEoRLaNVnB/acgIr9TK5ccPXTNAKhUP3ZK+Oz8gjv23Vag5ZVoM/WxHLOFZvk
         VZwg==
X-Gm-Message-State: APuU4Z8G8/lGypGQWfw88B6+40X6up/u3eEAswn2P6SOQRtYyl719wxL
	31eYrlPEVVdWKRBxWSi1eUhyMBNc2PkosNTz912H2YMZPvxo/wBDoHrgPEGFpGEiJ+8r/nAiKnG
	N4ITl8VEk7g==
X-Received: from dlbec12.prod.google.com ([2002:a05:7022:d8c:b0:19d:e7f1:171c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4354:b0:143:26cf:8615
 with SMTP id a92af1059eb24-1b5031111afmr3091648c88.25.1794599776816; Fri, 13
 Nov 2026 11:56:16 -0800 (PST)
Date: Fri, 13 Nov 2026 11:55:50 -0800
In-Reply-To: <20261113195601.2872738-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195601.2872738-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195601.2872738-6-irogers@google.com>
Subject: [PATCH v2 05/16] perf pmu: Probe precise_ip levels
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend perf_pmu__probe() to probe supported precise_ip levels (1..3) and
populate probed.precise_mask and probed.max_precise.

Some PMUs that do not implement hardware precise sampling (such as
software, breakpoint, or AUX trace PMUs) silently ignore attr.precise_ip
even on non-sampling events (sample_period == 0), whereas PMUs that
genuinely validate precise_ip either reject precise_ip > 0 on counting
events or are sampling-only PMUs. Check for this before probing levels
1..3 so non-precise PMUs are not misreported as supporting precise_ip,
while still detecting higher precision levels when core events are
forwarded to hardware sampling units (such as AMD IBS).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  4 +++
 2 files changed, 64 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d8bcf0e91f6f..322d90695c4b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3475,6 +3475,66 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 	if (pmu->probed.can_sample)
 		probe_sample_types(pmu, &base_attr, pid, cpu, flags);
 
+	/*
+	 * 3. Precise sampling support (:p, :pp, :ppp).
+	 * PMUs that do not validate attr.precise_ip (such as software,
+	 * breakpoint, or intel_pt) silently accept precise_ip > 0 even when
+	 * sample_period == 0. A PMU that genuinely implements precise_ip
+	 * either rejects precise_ip > 0 on non-sampling events or is a
+	 * sampling-only PMU (such as AMD ibs_op).
+	 * Note: On AMD, core events like cycles:P are forwarded to IBS and
+	 * support higher precision than advertised in sysfs caps/max_precise.
+	 */
+	if (pmu->probed.can_sample && !pmu->auxtrace) {
+		bool ignores_precise_ip = false;
+
+		if (pmu->probed.can_count) {
+			struct perf_event_attr c_attr = base_attr;
+			int fd;
+
+			c_attr.sample_period = 0;
+			c_attr.freq = 0;
+			c_attr.sample_type = 0;
+			c_attr.precise_ip = 1;
+			fd = sys_perf_event_open(&c_attr, pid, cpu, -1, flags);
+			if (fd >= 0) {
+				close(fd);
+				ignores_precise_ip = true;
+			}
+		}
+
+		if (!ignores_precise_ip) {
+			for (int level = 1; level <= 3; level++) {
+				struct perf_event_attr p_attr = base_attr;
+				int fd;
+
+				p_attr.sample_period = 10000;
+				p_attr.sample_type = PERF_SAMPLE_IP;
+				p_attr.precise_ip = level;
+				fd = sys_perf_event_open(&p_attr, pid, cpu, -1, flags);
+				if (fd < 0 && p_attr.exclude_kernel && p_attr.config2 == 0) {
+					p_attr.config2 = 1;
+					fd = sys_perf_event_open(&p_attr, pid, cpu, -1, flags);
+				}
+				if (fd >= 0) {
+					close(fd);
+					pmu->probed.precise_mask |= (1u << level);
+					pmu->probed.max_precise = level;
+				}
+			}
+			/*
+			 * Sampling-only PMUs, like AMD ibs_op, can't be checked
+			 * with a counting event. If every level, including 3
+			 * that few PMUs support, opened then assume precise_ip
+			 * is ignored.
+			 */
+			if (!pmu->probed.can_count && pmu->probed.precise_mask == 0xe) {
+				pmu->probed.precise_mask = 0;
+				pmu->probed.max_precise = 0;
+			}
+		}
+	}
+
 	if (keepalive_fd >= 0)
 		close(keepalive_fd);
 	pmu->probed.checked = true;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 658485faa05d..fea65e314547 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -238,6 +238,10 @@ struct perf_pmu {
 		char *probe_event;
 		/** @probed.open_err: errno if open_supported is false. */
 		int open_err;
+		/** @probed.max_precise: Maximum precise_ip level (0..3) supported. */
+		int max_precise;
+		/** @probed.precise_mask: Bitmask of supported precise_ip levels (1..3). */
+		unsigned int precise_mask;
 		/**
 		 * @probed.sample_types: Bitmask of supported
 		 * enum perf_event_sample_format flags.
-- 
2.56.1.703.gf848ed807c-goog

