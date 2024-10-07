Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1AF1D270D;
	Mon,  7 Oct 2024 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303358; cv=none; b=dUoPHPvonn/qCCjfb7gAyGq6v6GwQDZxYpheRuK0Gq9bUt3ZUCc3X2iV9VIUUUw4Fh0IBbPrVvb8EC9mAkIiqHkMZXhImc/4/79XEKBCgH1VFoDYf0pLYPZEu4SVdgc4IG4XA/UCdiPMO2PetQ1QHUo2lDveYS6syijTIfffbtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303358; c=relaxed/simple;
	bh=ASUc6kAtsCg9dI+405nE9mEZBTw6r/3DLRVRbDRQgjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OE/ZtLgHguVQybWdVmTdI3tMOGGGzLTocFivWTVH1SEavXDa7xsm9fLQkb2oXRBqw6bYL5nAJvQDlF+e2AUTIHdGaVF5A4xHT66bLCxNKMBRNZUrcG30JBcPK376BoMqQywGp3d4/FB9MQt78Wj71sxTD2RmBFkJ+ISNllKgB6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb806623eso39502625e9.2;
        Mon, 07 Oct 2024 05:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728303355; x=1728908155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpptbFsg69xhYDgcSHfBOry9SODnnTXajnxT5eM9R9c=;
        b=fwYcWzgSzZiGpz5qqp1HU92l4YR9MJDhg5NYYAbIXQvKwfzGI7juSENQa/TW/92Qlb
         8JvTXmjJnLq0qQj/8UVJHGuIX0iEug/RU/sISXCE5Bg+zGhKnQ/DcVf0EqB8JI/HkeT1
         fgM7sKP7NYVg+My1Qq1nwV3x65/NwbMRofCR/oQb3ZZguAFjtiGmygkLc++3Zmu/h2GV
         kG9K8Gk/iyhHj0B7At3ufVk5C9EPfWMRDE/4QxzLZse7cl9673qNk92vEqAlunfa1BWo
         dGEBhQnLrNtX4wsJFwvjvz0wpp+6ZpS7rReIvZkPkEdP0mPYaVXhuwur6HkiqQveZrE0
         EpqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlUluVeUaqzUtEFmIOA+Q4SHMgbxW/EVois7iC/guxm4KZtsf1K9SxMvfsVS87HuZUm2/ohGU38/rhCMI=@vger.kernel.org, AJvYcCWS4RAPdyFCyPzCSAwLJDu44CDPM0Is57OGexPj7ut2P5hr5O2caIOLdrp+/sBnrL9lC4xGE3y6YVTaA2Q8vE1dvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzeC3Ri1uuy+k3YsH/fyD5ZMbUOIWr/LHUgrhh0OiUtCYmkctj
	7XearzxPsBCwf7gVWRDCEnz70t7qvQZneYFvOCp5C8vKGAc9ZYb2
X-Google-Smtp-Source: AGHT+IHgMe1llP9Xb8kJcw+9iUo5sn330gj6pEoD9q+UUC26oIGsfgdvgkMG/97FFq48XbKgUx05Yw==
X-Received: by 2002:a05:600c:6c11:b0:42c:b037:5f9d with SMTP id 5b1f17b1804b1-42f85b64da7mr86009775e9.3.1728303354441;
        Mon, 07 Oct 2024 05:15:54 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a20537sm90724405e9.15.2024.10.07.05.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:15:53 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.lei@redhat.com,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] perf: Use cpumask_intersects()
Date: Mon,  7 Oct 2024 15:15:24 +0300
Message-ID: <20241007121525.1905562-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `cpumask_any_and(a, b) >= nr_cpu_ids`
with the more readable `!cpumask_intersects(a, b)`.

Comparison between cpumask_any_and() and cpumask_intersects()

The cpumask_any_and() function expands using FIND_FIRST_BIT(),
resulting in a loop that iterates through each bit of the bitmask:

for (idx = 0; idx * BITS_PER_LONG < sz; idx++) {
	val = (FETCH);
	if (val) {
		sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(val)), sz);
		break;
	}
}

The cpumask_intersects() function expands using __bitmap_intersects(),
resulting in that the first loop iterates through each long word
of the bitmask, and the second through each bit within a long word:

unsigned int k, lim = bits/BITS_PER_LONG;
for (k = 0; k < lim; ++k)
	if (bitmap1[k] & bitmap2[k])
		return true;

if (bits % BITS_PER_LONG)
	if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
		return true;

Conclusion: cpumask_intersects() is at least as efficient
as cpumask_any_and(), if not more so, as it typically performs
fewer loops and comparisons.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 kernel/events/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e3589c4287cb..da106d0ee909 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11905,11 +11905,9 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		if (pmu->scope != PERF_PMU_SCOPE_NONE && event->cpu >= 0) {
 			const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(pmu->scope, event->cpu);
 			struct cpumask *pmu_cpumask = perf_scope_cpumask(pmu->scope);
-			int cpu;
 
 			if (pmu_cpumask && cpumask) {
-				cpu = cpumask_any_and(pmu_cpumask, cpumask);
-				if (cpu >= nr_cpu_ids)
+				if (!cpumask_intersects(pmu_cpumask, cpumask))
 					ret = -ENODEV;
 				else
 					event->event_caps |= PERF_EV_CAP_READ_SCOPE;
@@ -14025,7 +14023,7 @@ static void perf_event_setup_cpumask(unsigned int cpu)
 			continue;
 
 		if (!cpumask_empty(cpumask) &&
-		    cpumask_any_and(pmu_cpumask, cpumask) >= nr_cpu_ids)
+		    !cpumask_intersects(pmu_cpumask, cpumask))
 			cpumask_set_cpu(cpu, pmu_cpumask);
 	}
 end:
-- 
2.45.0

