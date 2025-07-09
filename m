Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F4248F52
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097243; cv=none; b=UoSsP32m92bTaDUW6FK8tmOnk80fKjqMYfbSDZyZZLl2kX44Ij7iFdgrdFblZeaSDZyO5DkQfDjHNjpdFYpbokt4W7RbjVjbVgqSusaNWMm5hI75oYkx7EJzYIb+1QlmcJy2kBK0octPQCyOv7VfWPVf2EgIXVPmPPiU7J2zwRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097243; c=relaxed/simple;
	bh=8+fzwKbYyh0HgEc4+oNZYk8ZhmbZCi8quzaYQRyDMRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KYpDEaL5qo5mNRPeJDxs3OUeLGHuLssDZgRXk8jyQeJ2r8zYnKEcex+/e4ArkDc2zV6S+Ld0XE6eHqi08chMDWdfUjYVFgt3YFJd+Rk8Xev0e7pPpAU6YJ99iy1LEy/TrhAzJete8o348DBO+yCkV9zdHulsNqYYRblsV/+TdgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rcZzNcEr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rcZzNcEr"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74913385dd8so413451b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097242; x=1752702042; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jB43BWOgr1OVnJk/vG7v3SNwpLjEdqHnInxVydle4NQ=;
        b=rcZzNcErVyUuTI4nsH102cf2L0gjFgkGyi/lkxRnA6lyu0g5JYxVWkdTUKCiNsDB+b
         oUR/bYiFVEeWlCFFSH1FATj7QVs2+ryEDDtknIDMQil7DOFSJhDG15e3X3s+IVzegF6s
         OF/SYE+tSvZhQm4/xxY+nxuvBJqsknwr4K9A5SrdOgm62HYfXl3EaoH/Bd36Idr4X2OA
         kUZB1wDkjMYWiNgmTln85kE+/IH/kTyn+2m/felf7HY6f/U2A5JT4WYWw5QdQIeC8vKY
         fRke8VBXAA7DEEucWqh3oTNwYFyI2jsOLhPsjIqj+c1jgvkKn4KUlypZ5uL73n1zN40r
         ntgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097242; x=1752702042;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jB43BWOgr1OVnJk/vG7v3SNwpLjEdqHnInxVydle4NQ=;
        b=NXEphENg0TlxbMMeZuM8SRgur6NtaWSA/jNuK2aTo3EmcFvSaNQDpeH3dppjuRDc+u
         IEFP9FwT5xwwxc0Q6thvqfaMCWPHRkK4RH23XlcarYqvfu94KFdcvv5UlnRwaAhsBGLi
         janLS5wuR/Dc3xhO09uMA2oo1x4HLQ5CyONipDRsKjQD+i0cQ861XmsdluawDQnmLDVw
         wACbMarD4k8Qp2n7hPpfhwt5FB1gzWQeQZD6IlGMAzd4tL7j+ZZ7HVf/EvDZtQalsf5a
         iWFfZ20QUvOyK1XP8KSyG2QZFooey8yP6uN5Jj6oDkJUCAcSsfXNbfaxQI3JsTuB//iV
         57Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWFZuNbMlv3WxQoOEs9BPeW4FNbyeBRcn0ixWGV3eswgkE96EqVVAwgNk8qxBqxBsSYBIywkuCaoE4r6/x6aPrn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0+lO3vpZKEaX6/UHdMGUBN8nxiO/cd+BkEa53ZXtAE7zlqdkJ
	syOQFbZtSxK6EnMCUCrRVe9ywfwAv8GYJXgeVw/t7zWn8cNrjhdg5NTruVnVYbsz/3WJXHmmflz
	/IoXe81/1jQ==
X-Google-Smtp-Source: AGHT+IEBtciJsh8xRDvIq+Sgsncs0zNYJD3rc0jF/WOqfdg3f+RccueHuYWIQOWwgAEZQpSuy2QQRcospvlu
X-Received: from pgdk7.prod.google.com ([2002:a05:6a02:5467:b0:b31:c7e5:6664])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7489:b0:220:9c00:6879
 with SMTP id adf61e73a8af0-230045c6577mr308556637.17.1752097241840; Wed, 09
 Jul 2025 14:40:41 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:21 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-5-irogers@google.com>
Subject: [PATCH v1 04/12] perf pmu: Tolerate failure to read the type for
 wellknown PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If sysfs isn't mounted then we may fail to read a PMU's type. In this
situation resort to lookup of wellknown types. Only applies to
software, tracepoint and breakpoint PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f795883c233f..23666883049d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1182,6 +1182,32 @@ int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name)
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
@@ -1201,8 +1227,12 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
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
2.50.0.727.gbf7dc18ff4-goog

