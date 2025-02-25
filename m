Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1C1A08DF
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502045; cv=none; b=c1odihWu2UO2v8qt5HOASdPpppdlGcPn9702eB3U1X+tpS6jCleyHxHw3ZgSYEqdDqzc5T9oIFUmtQf/Qf78lGLwcWT13EA7ZxlepR/40v6qF9XqkcnzHbU8IgqxpEoCvUScsgavOWfu4kDeGh8oUq7ZQf3fflfXBGhNb28q/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502045; c=relaxed/simple;
	bh=wrHzNVnId8j0qsMaPAMXfUrcKGMkQwXnH6urFQaWqoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ISmKRSQQ2AnKXmGu2KOmlY5/7m9lawC5e//nwrLMVZT5MJWQlwPfAcYRSvnwSBhCmEbHPVD2VJ+HRBRapGwCLjKj2XmC8aZ6SDcfL4WDzH1LkweXqvZAZpaWLzCRMnTBtQ/zGnC4bJwk1407OYnM2w0sV9p+pm+ZWqF0ZZzpSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oFn/OcM8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oFn/OcM8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439a4dec9d5so57099975e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 08:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740502042; x=1741106842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6UJaQQmZ+Nba7bOv2fyokA++hlexbBX/filKGo9hKY=;
        b=oFn/OcM8FSb+FS6Ue+3+IaXtzTj/EjDq1Ylfue4wQfppqTuZedC/Ich3daEnKdUs7+
         dbDNVZHrXQ1bcKnIlVPc45O74U520iDJHL7AwmpPRPPEpAIfpOouQi+Tk+SY/fGizt8T
         8fyUtMbCIc/iaYyaGvO2mEH/okGJLAfKRsrcmX3pyTgmjTGlg+GNDUVMebz3rAVNYm/s
         Z5d68FWr9zDgPs4T8GSgFa/RLXUIgW2qCWxG/75cWYV4n6DYtzhb9cE56X4lCmfhALd/
         YbT5dQy1pld7JcNWQqKVQs+nU3u1AhG729WjO6reojog6AuFMNyxUA4thUxsMHDiZU1T
         652w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502042; x=1741106842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6UJaQQmZ+Nba7bOv2fyokA++hlexbBX/filKGo9hKY=;
        b=noof4hL3D6IiutYO1l4ZrgJrbpBxU+t5ggml/+MR57aChSjakqM3Os92ifCgDt+dp4
         jX1xGOlEIYIm//11ZhHrk2jGrvlWpBIndm0I9DyKgFpz1y23XIO+tl/kPugwRzdRjBVQ
         Fz4HIhoxD5h5kG2U843u/WGf08qpEETpB6BXRsX8TRI5Vh2sG5PCQcxD8jZSdkNme5wp
         r2j7R6NQ2X4LSnsIeEF+K2L0vDHbeVjrynTwxF4vxAlVZ8nvd2QWJuMGN+62qnB1VJBc
         uZPopOflXznb0eaZGIpO7zhHqxkrsmx6Ge4eFEIJiRJpNf14tLnXxOzJNoZnp/JSrx1o
         kBKA==
X-Gm-Message-State: AOJu0YwQ9eDv6NX0DQ8JlK8AT+rPnqyp8d0Q0xvoascXqDz5Iz+iNBE8
	jDEQx5cNcTA4V4mNcPgbGluUftnMogCk66pVXsXzgRB8JLgePhgqD3WQlH/WuKGhD36fi34V8sw
	FqsA=
X-Gm-Gg: ASbGncvVtt6BnGet93wA9TFWBb/ABHJcgrSJkWlzcbV2u8m5rSlqsFgl9nBAg+iDUxG
	wvCnOadiJ3ur0Ms97OMxxAQ9peJuS2LJGE9HopaeeadpHD2HOb3DUo+sOwzEZSNQLcxCdwl1Pdv
	FDaoXkjFCrraHa+uKaqtd+rXaL5WRdXp2h33lTiDIzAhEaDkUvSOP6/Rb7jf09TjPwc6yRkghFV
	e1gdJ6Sbo6Kb4/SpEsNynXtvW6EqWC3VZxkbJfJdky9C949F6dZsj5uBWPtj25RKU3PRdXGwArK
	59koUYeiOdpDCiCZw7WHc6t2wA==
X-Google-Smtp-Source: AGHT+IF/oE/rQ1PppVOBOg8I0Vrf8wEOV9x9RbiBK34mWqlWgLOTXGDyIkC+P3rKPQxR+xXeJ89KKg==
X-Received: by 2002:a05:600c:3516:b0:439:88bb:d023 with SMTP id 5b1f17b1804b1-43ab0f2dd01mr49558465e9.11.1740502042272;
        Tue, 25 Feb 2025 08:47:22 -0800 (PST)
Received: from pop-os.lan ([145.224.90.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab154754esm32072415e9.21.2025.02.25.08.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:47:21 -0800 (PST)
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
	Weilin Wang <weilin.wang@intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Junhao He <hejunhao3@huawei.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf pmu: Don't double count common sysfs and json events
Date: Tue, 25 Feb 2025 16:46:29 +0000
Message-Id: <20250225164639.522741-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225164639.522741-1-james.clark@linaro.org>
References: <20250225164639.522741-1-james.clark@linaro.org>
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

