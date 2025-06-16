Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B01DB15F
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 05:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050948; cv=none; b=jB+jFRcDN90Igj/LRcbn7w6nbh9l+MXUU7k1G/edKw7GRU2eSML4N5Kh63PRRR5mX3j2JwTQC997fNKkVz9vOQBGIH/brKeGMjtNxquFH+ji9q4ucNaYlUlbGm0W7QR2CvxMbkfcLNKEYTOFTEUbGhlUvNhVcOGDvpucz4Glrag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050948; c=relaxed/simple;
	bh=oHlVYZzRVwAe+UXK9uHdGLjOLnxQvDDCV87amYBN0F0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sl4GkFMAIxupJUkbeAyOZ5q6CvFWdiYpF6ge3LxY1IflC4t99zR2ATyw5VpDlE6K8w3narCiT6SkySJATKYk+WiX+PuQwvNCUzrNjy3ewTP6/RjaJZ5Jnt15iJsIgLuZWsLqG3HYH+poT19i8coNLC8l9tyq2PmpfDe81ZbOhp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bq/mFvDB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bq/mFvDB"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235eefe6a8fso27855735ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jun 2025 22:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750050947; x=1750655747; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wsyda4WtQQy5+ceUs120ZRx1vnKpP9F70AgtsBQ2bGg=;
        b=Bq/mFvDBp5MuA5B5f01iaFZ8r7lO+CttGxvLfyxJY77sONscn+CUCEEhZFtgmW3PT4
         UDtNV+G5v522zdaJsJ0w73i4Rr5z8iAgbBcqjI3SMqfIfelVAMB2lgOI4GFVq504PGhL
         JF8xnVSYKyV/jHMTZPpvMHn6pyXs7CbROvxvMN85eeEu8BzE9OnCSF8Wips3xtun5aOM
         +j2KoEc4fzsAGjJSTu+0lM3ZLtz05flogTohqYwcUt2uiFBrUHHT6ixeeeYi5R/1n2Ev
         LFl/zJUsFTMhakkzvvLvFmTRwvOGXRFF8m7umPwuRh4HKtLPJy+6+KQaAwIv1EKTgPXL
         Nsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750050947; x=1750655747;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wsyda4WtQQy5+ceUs120ZRx1vnKpP9F70AgtsBQ2bGg=;
        b=KGq+QRSoYQjpCC7mSVXyXDD7zAzmcUUgxbmX4FmnDU8DDVEv73aLAr8l8+gzjr/OzM
         aa411ru93DbRs/ERCygjF66+UkwoShAjSxrTzDPR/r4cY1CRNGCMO2zKRcjvtgDWem7k
         x4o6bVphhVOYgqaepy9p8PAQlqZ7raHRoCP3f2eJeWqGLJEX1/yBFxSVqoaqRV1Mid5N
         I6BmoW0FjjLt80NGs1ibkb9o5Am3ylkc2R/tn2kM/HU7j/+EBbRKDVwxQ3EruAEXxVGN
         +q26rZdfhUpdun1eumFYsScsrtKxlNR4pOpVbt6enkjUp0DNpIwLctLjGlBqwSmv0vJu
         AXHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEbVO6LcsV/93Ptdim2VQ/mOiQ+zll2Az2tPlfAc7aICfufbOLEgGBFXkNmjJfoUnijvg+jRbP04Bz1z/LObBl@vger.kernel.org
X-Gm-Message-State: AOJu0YxSekEBVh3DIV8xsjy8Um7+EF5uHkyk9+BDge4EHHM5ITPPknq3
	2WlIPBgJfHR7is/M4xLIIhSUr8Ldg++egEWGeo64TrK4xQ11wcpPOb29ybY0fFKCE8hXB1aa0u/
	IQ9woK8D1KA==
X-Google-Smtp-Source: AGHT+IGwfWpc//cUVY4b4gWE7CLvuCzE1A8Mm52F41Dmu8y2Xdr19DhW2SlYDWwzD5GvgD+CV+Qi1YzCmNCn
X-Received: from plpn20.prod.google.com ([2002:a17:902:9694:b0:235:e1d6:6dd9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc87:b0:234:d1f2:da31
 with SMTP id d9443c01a7336-2366b001621mr134870535ad.2.1750050946836; Sun, 15
 Jun 2025 22:15:46 -0700 (PDT)
Date: Sun, 15 Jun 2025 22:14:55 -0700
In-Reply-To: <20250616051500.1047173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250616051500.1047173-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250616051500.1047173-11-irogers@google.com>
Subject: [PATCH v3 10/15] perf pmu: Tolerate failure to read the type for
 wellknown PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If sysfs isn't mounted then we may fail to read a PMU's type. In this
situation resort to lookup of wellknown types. Only applies to
software, tracepoint and breakpoint PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 76b7ded7fbf4..c0c12880146a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1180,6 +1180,32 @@ int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name)
 	return 0;
 }
 
+static __u32 wellknown_pmu_type(const char *pmu_name)
+{
+	struct {
+		const char *pmu_name;
+		__u32 type;
+	} wellknown_pmus[] = {
+		{
+			"software",
+			PERF_TYPE_SOFTWARE
+		},
+		{
+			"tracepoint",
+			PERF_TYPE_TRACEPOINT
+		},
+		{
+			"breakpoint",
+			PERF_TYPE_BREAKPOINT
+		},
+	};
+	for (size_t i = 0; i < ARRAY_SIZE(wellknown_pmus); i++) {
+		if (!strcmp(wellknown_pmus[i].pmu_name, pmu_name))
+			return wellknown_pmus[i].type;
+	}
+	return PERF_TYPE_MAX;
+}
+
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name,
 				  bool eager_load)
 {
@@ -1199,8 +1225,12 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	 * that type value is successfully assigned (return 1).
 	 */
 	if (perf_pmu__scan_file_at(pmu, dirfd, "type", "%u", &pmu->type) != 1) {
-		perf_pmu__delete(pmu);
-		return NULL;
+		/* Double check the PMU's name isn't wellknown. */
+		pmu->type = wellknown_pmu_type(name);
+		if (pmu->type == PERF_TYPE_MAX) {
+			perf_pmu__delete(pmu);
+			return NULL;
+		}
 	}
 
 	/*
-- 
2.50.0.rc2.696.g1fc2a0284f-goog

