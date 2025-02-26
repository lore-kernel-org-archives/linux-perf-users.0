Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678CA24E010
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566508; cv=none; b=Crj3a4XhB4iC8iwQSBs87Ryy2RmvjSGe4fOxPtiN/UoDnWOUWVx3np+0h24Iw7PTfkCLAmkRtNTy28DrxMuzszeKe7WMbt1Ab2jMAD0OIutSVU4Ql1uvgI2OS+INESigt+LGP2Y2+6jQbtUpqH8zqhhK4S08p0vkz1kpbMR8D1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566508; c=relaxed/simple;
	bh=6Op+BGD9aOfefERcS9K+XAfwBdR01EIgoovWunnt9yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cj9WHTXWgpBKCYPeKO9fSbwprNWTo5ZAf4eDqwY6wnqmumo4bQrOgE2RiSeVOavpl61Mfw0/a+SefJP2KWFu7/7hbrIEywONAzYdr4l6vykMHexJ8gozcaddnNURcJTnYL9YXzfAWZ5XBtXjaixfawAW1Lxns34GZ8a8l7KTu90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fr1V95L2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fr1V95L2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390df0138beso49348f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 02:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740566504; x=1741171304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYvbQsYkIwtcSeYbqklzOTvT4hGi9DJFoZoz1Lt+cRk=;
        b=fr1V95L2nrUQbL8RnpGF8ZaqSFwegMLEJfTwiGhiouM1ewBcNhTbSXyY5nmdRpxMww
         Er80xLJr/1yB7iNOaNuQZ7wZKt4Da5PPwA1MCorn6SHK2p1tXkgyKDbrdHDdXBetPfse
         VxhnQh6sEuUOgZh1DHCtugP0UrRGiuJj219hK6G68jXPuLyUeLd+H3gJVBz3NZO0JM4Y
         I44EL2Ivz/kmXR27ff8yp6Oxjhyo438bjF7j9NZMUztij0ocsNLpmFuEJAaamRt+rhWa
         6DDZfd2Hkl5988IvjNYTRUTq29KqTjpMGsz0HzP3nVr1OHqi6Fe4wD8S8Qt9IaLL+ExC
         yMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740566504; x=1741171304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYvbQsYkIwtcSeYbqklzOTvT4hGi9DJFoZoz1Lt+cRk=;
        b=uERW6iY3H0DhcBBHsaPjC0u9EJ+Z0BCcZTDnVSJUx9Y8m/waLKFSfDkgZj7LnoyZ6p
         DJBclHNBysrUKXHagUXdrHSjEpewlfL5Z0TQ1gdvvAzGIUNDpMrjweA5B85M6l3wHE+p
         UIJxVJZumedFsNXcLe9+n9uk4VAz7QWajVl1+oFl7v2naAtGN8VB2j1LzJ5wCyW/YAHr
         s/alfyzabSy9/ti+fmJzese7qpnzlbtBRm/VHOuPqxV51JnnVWsv+Lxr+a61IEQI0Gti
         h783wu7uM59lX20OTLBzRde2p9g1IurLooZKDbmT828fB4MlGMzcC5H72ePASsPcc8V1
         w8bQ==
X-Gm-Message-State: AOJu0Yxm40qluQgPiUGZcDeASw4dH+tKwbaE12Otjrmmj+jw+SYJTiZ+
	7rlKH2iuWqm4X57V52JW3BPCnLQ+XTkIsaRr63Y2A9LbUD9yPrRPAe/Az/nEEDEa0KlYLu4zEVR
	VjNo=
X-Gm-Gg: ASbGncuQqZR94DcgvCx2zN/duRFlRUejdNosvlQlKdsw0qzefBSu7laHJlTBFTczFoN
	ag8dqCniPalWlgdoacJpe8uDgjFyjP12Niyd4vgpfWReBPOF1tR2R9GzNeEIYWWgeAhIsuN3mpN
	BOf7ZOqhWfe42HUFAO2cDlUUWy+pSHHcENuzTUXk5iqhWaWzXuqesGY2epWRA7WROR/O0ISiI2j
	6ZF279zSRH+zWZHV9hloO/pZa9j4FhG3EQ6K/EVfGf7DmkXt3EvD1snbvgrQOjjJf7cyJLie3xB
	UWcX0pfEMOxkpUGqGTgh/PETQ1o=
X-Google-Smtp-Source: AGHT+IFDcakSn5G3iB9NgJ4EoNZmOL4DHdejQpENpIsDv3JU46wxijY6j/aQynYAolsN0hiLeroFZg==
X-Received: by 2002:a5d:47ac:0:b0:38f:516b:5429 with SMTP id ffacd0b85a97d-38f6e96738amr21666765f8f.25.1740566503778;
        Wed, 26 Feb 2025 02:41:43 -0800 (PST)
Received: from pop-os.lan ([145.224.66.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86c93bsm5080832f8f.26.2025.02.26.02.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:41:43 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	cyy@cyyself.name
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] perf pmu: Don't double count common sysfs and json events
Date: Wed, 26 Feb 2025 10:41:01 +0000
Message-Id: <20250226104111.564443-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226104111.564443-1-james.clark@linaro.org>
References: <20250226104111.564443-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After pmu_add_cpu_aliases() is called, perf_pmu__num_events() returns an
incorrect value that double counts common events and doesn't match the
actual count of events in the alias list. This is because after
'cpu_aliases_added == true', the number of events returned is
'sysfs_aliases + cpu_json_aliases'. But when adding 'case
EVENT_SRC_SYSFS' events, 'sysfs_aliases' and 'cpu_json_aliases' are both
incremented together, failing to account that these ones overlap and
only add a single item to the list. Fix it by adding another counter for
overlapping events which doesn't influence 'cpu_json_aliases'.

There doesn't seem to be a current issue because it's used in perf list
before pmu_add_cpu_aliases() so the correct value is returned. Other
uses in tests may also miss it for other reasons like only looking at
uncore events. However it's marked as a fixes commit in case any new fix
with new uses of perf_pmu__num_events() is backported.

Fixes: d9c5f5f94c2d ("perf pmu: Count sys and cpuid JSON events separately")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/pmu.c | 7 ++++---
 tools/perf/util/pmu.h | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ec3878c890a9..72aa6167c090 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -596,7 +596,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 			};
 			if (pmu_events_table__find_event(pmu->events_table, pmu, name,
 							 update_alias, &data) == 0)
-				pmu->cpu_json_aliases++;
+				pmu->cpu_common_json_aliases++;
 		}
 		pmu->sysfs_aliases++;
 		break;
@@ -1884,9 +1884,10 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 	if (pmu->cpu_aliases_added)
 		 nr += pmu->cpu_json_aliases;
 	else if (pmu->events_table)
-		nr += pmu_events_table__num_events(pmu->events_table, pmu) - pmu->cpu_json_aliases;
+		nr += pmu_events_table__num_events(pmu->events_table, pmu) -
+			pmu->cpu_common_json_aliases;
 	else
-		assert(pmu->cpu_json_aliases == 0);
+		assert(pmu->cpu_json_aliases == 0 && pmu->cpu_common_json_aliases == 0);
 
 	if (perf_pmu__is_tool(pmu))
 		nr -= tool_pmu__num_skip_events();
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index f5306428c03f..b93014cc3670 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -136,6 +136,11 @@ struct perf_pmu {
 	uint32_t cpu_json_aliases;
 	/** @sys_json_aliases: Number of json event aliases loaded matching the PMU's identifier. */
 	uint32_t sys_json_aliases;
+	/**
+	 * @cpu_common_json_aliases: Number of json events that overlapped with sysfs when
+	 * loading all sysfs events.
+	 */
+	uint32_t cpu_common_json_aliases;
 	/** @sysfs_aliases_loaded: Are sysfs aliases loaded from disk? */
 	bool sysfs_aliases_loaded;
 	/**
-- 
2.34.1

