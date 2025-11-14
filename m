Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2A26E16E
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129305; cv=none; b=r6G0LflyF+8Vk9CcpHZMVgYOX5GIZvYuNA+k46lBw4WEhGkoZKJySM8P0VqecLUC7+3f5yB+jTJj7uix2K9/VmzBth9A0152kq3SvrUvU+WGZtQZEz98y4M2pE1FL7ZhgZBxdQDz2whrK0B23fwMb5Us8AwwpVx1AslkPjtJ4Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129305; c=relaxed/simple;
	bh=DsHRb3aBVsPsTfxFZTltQl8Cgb+5+kZTKJRtgUHVP0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=blaYLUI6PpmMpy5D2p6z1TEQ06DPikySZ8JgTIKXBU+i6YNiQ7EGQzkn4Isjvt8dVqMLNfrLQlAIb09IpvJxggCI7lj5gYFMfUBYbhpqsuYSkT94VMqUoaKpzin9ZXigHkyzi2BLuOyhSOxI+n6O8FeI1JnEx+OxE5dC2UHPIzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SLTDzmfD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLTDzmfD"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so1095619f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 06:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763129293; x=1763734093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt52bq5jaqJDguhB1sVQNID6rpmfKSxM12PWX69j5Wg=;
        b=SLTDzmfDUGadOD9zcpYX7my6gVSAv+Cb4k9rTq/H+nuYnDkMVg8ug7D+el5iAcT3yD
         Cj4/DZi9ik9U+W//BXXcDTosYQtWPjztQ6NtNMs2iY0F/0fn12PM+K/dp5pqh0Xp/VN/
         83klub7ArV79/p45q70L8+aCGYPG0psvqt9/SK/AmO4UYgYg23gVy449dQ8ZaRGWexZz
         Oag/JtglntPcS8XhdPZXOuc/RlClaoeCpRaEZ5UuRjXVZaL6qNCVy23cgRA4+Be7T+qi
         mKLu8QaueT5ATb1yONRKLfYrxjV/X+VAlB/M1/gwa+bhF/lKce6RfaiUHNjpGrxPOqc7
         mxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763129293; x=1763734093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wt52bq5jaqJDguhB1sVQNID6rpmfKSxM12PWX69j5Wg=;
        b=kHJOYb0c0Y4QI37uX/tVl9VUH+JaI5BH26Ocq6SXvLDRXUSIAQRdTXKeboNRZngoSu
         HZuLdb1lfc7BvpBS7NdZdFV1T/FgxjGAcU1OA4FzPt/ki23mcUDsVxmYjVXvmKSFYx1T
         4wl0G93x/FMtvPUmlJOaPyrRtt5uOlhWBmAkM1MChhFw0YZo0KoBtwsM1QF3WBvEu8QD
         W3mhtHdYnWQU6jtlOB4AZzH6HJ0aTwUJt2TRk3nkJfHJ6XfrZTb+1QsaEkIPqAA/Q4lA
         pzaf+dKbXLUJJaEWWi8NBope/C04qWhvk6Jh/yX8qva76QVNi1d3KKQAr2TU8zf1JYfo
         UCZQ==
X-Gm-Message-State: AOJu0YyCo8+q+NQRaJ16uUVtBXRhMWdINxvG9jmKKBJWeS0NJrKb6hfL
	mHu04vO9yccQnHvzsTfSz29/FbM+rCTzWlbTi+fROA7qlchCM8T4HH/cvIC1Q4qOIDkJPx/7RAQ
	W+Pfnlig=
X-Gm-Gg: ASbGnctwxkpRlwdmCCSzWYgal2J8+EwTEpHsAbFWXjbANk3SaPOn7dRQEwPjfnmP+mo
	pDRvZCVQ+/yEWp4zW/dSg7RtHyediy4bi7iYqGrRhERtWfPQ9rWM0pzquZb2vlpKi/8lGRKPaYg
	0bIo+h0KQtPdAtg476px7YpMxeDBu27dYqLQ23mIdNrc8BDYTwdn3ps3lgHxUE8XIthw7n5hvlT
	lA5Qq5sFL7o33kc3qGy9qBQQpGf5lBX383hAsTrV+PDocfF7SvA2jkxGlg6xvc/jYA7WMa0kT/C
	MXwOH3ZcFOVqqgR5SqqUgQfVte4ckCI2VUOzmpThzB/lEewoA1to6OoIAHbbOk55I/mvrjOxUiY
	Oq80dDMQgTn916Hhgbjdh13tjWqLQAWQ1AzySjRdxtLdPmEEuR86cUYkFuN5NmUe23MJoZcDNo+
	xAP3oNDCmy92GqSNtKI+r9wDwBapSqROnjkqi/TA==
X-Google-Smtp-Source: AGHT+IEzGIG2tfSFNxrE/D4oQHp2bwRFhYPdDmFq4nLFvLUDg6G092MzyyCwFrJtkHVF1wL5m17IEg==
X-Received: by 2002:a05:6000:310b:b0:42b:41d3:dafa with SMTP id ffacd0b85a97d-42b59389c39mr3120792f8f.46.1763129293155;
        Fri, 14 Nov 2025 06:08:13 -0800 (PST)
Received: from localhost.localdomain ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b8a0sm10180854f8f.25.2025.11.14.06.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 06:08:12 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	acme@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf script: Fix build by removing unused evsel_script()
Date: Fri, 14 Nov 2025 14:06:18 +0000
Message-Id: <20251114140618.229205-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The evsel_script() function is unused since the linked commit. Fix the
build by removing it.

Fixes the following compilation error:

  builtin-script.c:347:36: error: unused function 'evsel_script' [-Werror,-Wunused-function]
  static inline struct evsel_script *evsel_script(struct evsel *evsel)
                                     ^
Fixes: 3622990efaab ("perf script: Change metric format to use json metrics")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-script.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index cf0040bbaba9..581fb101e8be 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -344,11 +344,6 @@ struct evsel_script {
        u64  samples;
 };
 
-static inline struct evsel_script *evsel_script(struct evsel *evsel)
-{
-	return (struct evsel_script *)evsel->priv;
-}
-
 static struct evsel_script *evsel_script__new(struct evsel *evsel, struct perf_data *data)
 {
 	struct evsel_script *es = zalloc(sizeof(*es));
-- 
2.34.1

