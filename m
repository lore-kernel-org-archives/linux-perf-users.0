Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5849B1FC7D9
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Jun 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059163; cv=none; b=iy9v7vYy2EtATserynVjzuPqGK1QMWfZLo9bh0E/wb5qkor7Qs+vhMpP/o6XjK4mZ94CKSW3CdGRHCd/iCu/Wjou+NpWZ3uyqWMiJPsyn6cyy8hH3u2Ft9+QZMkHHNivyEdlg5fRBM7x0Ifmgk9Mvm3xih2MKC2tlKh3bLx/cE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059163; c=relaxed/simple;
	bh=l/r16VO14AuoTPhHYx1IhtNWRI73iyFImyAUkeVPBI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SBr7aYgq3jwDRPVigc42LeAPZ4s6D35B6cOz7R4r9wWE0dOlkD5IKjPAqcMsBkaaU1NaZKtpezh2ZLzpDFxM6P0nCI1nrbbT99Za2aH0BkqIvXAOs2DYTI9q4pP28M+B6kor2aOl8A6wEeKcQWY3r5U0fjgjod8PoLoUUdvEK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wuxJs9Oo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wuxJs9Oo"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2356ce55d33so1113475ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Jun 2025 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749059161; x=1749663961; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8tuEWlyOsSZ3VWtxSAzfgMOdxNTH4pB9RszdQHfYhc=;
        b=wuxJs9OohDW4lQF0jMy3TAyejzjvXLOIqdVkebSsCXnIOTe7cu72rmSOrLpbui46vU
         oLV6yincNi7rAuHOet3780XE1yNAF3BYFuzqPUOsA6m1i/1grN+y94GyJfsdXjmw2wA/
         /Qwt1Y0eRJeBDwR0jZLELFxUqNpuKJB1EU+GnBADPk2XSJojYY0guZYkLO0nXvOZlqzi
         tv+KTBCMRj41b/ywtd4mw6O3JhVGWD+1KKSTXWs9HxLub2OKo9X+oIxpExcuZ21F5sSF
         kGA3rEV0QLKSbJ1SsR6b/TOvGBeNgFWcxWgdfJa0TcEKtM2hIhT7CeziZ/YpJllhEe1b
         l6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059161; x=1749663961;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8tuEWlyOsSZ3VWtxSAzfgMOdxNTH4pB9RszdQHfYhc=;
        b=NJxWWiHuIeNkTV/YDjPuibbXviPTp+kvxqSW2m8jGbNT8ZOoeNJs7JVN/7eLy64IfJ
         eYl5kquu5AcJOCyL3Ohgtm8pd5HkN+XSQFtNiw7IwY1agZa0RKAipPmsS1JuLpqKku7W
         oL+nseijV1WW5GgZ2DjrEHMBPPnjs+sunoYOpSO8K7RU8tpym4mW4JMEhnhXfdTVS5JH
         dA19Nn90uoq3OOqLV0pSF8/MrtEguKxaXWN4vU7dEnV2f6co+d40Ii6HQ8jVtwujypk2
         edTKFIFNtt2L5dLXKQxrLWM3gDwsCDaDvWDnoA6P/TILypJZEpk2kxXBplayRlfhGxl0
         PONA==
X-Forwarded-Encrypted: i=1; AJvYcCWAhtlifAPrN8fS6y/+Mxc0WcEd3oLuiteNUIqPNvj3QP4b7X30HcFBtlphEQMebXyfV9/2cjD/GK+liwtyCaZp@vger.kernel.org
X-Gm-Message-State: AOJu0YxUtP7cj2TLPsWmoSjv2IVBsI5SQSrxQMAKJQgVGUW9Ub/dhSmP
	33Aks/dFbpCig/4NX1DRvcODC33dVzYgBugAC+DeyfcLSzk4Knlt/l1X23tLNvIBCYXTJp7VJpr
	W5Z76jqQFyQ==
X-Google-Smtp-Source: AGHT+IFUdQJpYyNZoW3LNov2nnp6DBt7iCUI1cgeGKklZf5D9ju5lKohUdpptZ+KpaNA/8E19pxOS5sBSnwz
X-Received: from pjbpa10.prod.google.com ([2002:a17:90b:264a:b0:312:dbc:f731])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:298f:b0:233:ab04:27a
 with SMTP id d9443c01a7336-235e128b23amr51021535ad.53.1749059161671; Wed, 04
 Jun 2025 10:46:01 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:45:36 -0700
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604174545.2853620-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604174545.2853620-3-irogers@google.com>
Subject: [PATCH v4 02/10] perf target: Separate parse_uid into its own function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>, 
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Gautam Menghani <gautam@linux.ibm.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow parse_uid to be called without a struct target. Rather than have
two errors, remove TARGET_ERRNO__USER_NOT_FOUND and use
TARGET_ERRNO__INVALID_UID as the handling is identical.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/target.c | 22 ++++++++++++----------
 tools/perf/util/target.h |  3 ++-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index 0f383418e3df..f3ad59ccfa99 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -94,15 +94,13 @@ enum target_errno target__validate(struct target *target)
 	return ret;
 }
 
-enum target_errno target__parse_uid(struct target *target)
+uid_t parse_uid(const char *str)
 {
 	struct passwd pwd, *result;
 	char buf[1024];
-	const char *str = target->uid_str;
 
-	target->uid = UINT_MAX;
 	if (str == NULL)
-		return TARGET_ERRNO__SUCCESS;
+		return UINT_MAX;
 
 	/* Try user name first */
 	getpwnam_r(str, &pwd, buf, sizeof(buf), &result);
@@ -115,16 +113,22 @@ enum target_errno target__parse_uid(struct target *target)
 		int uid = strtol(str, &endptr, 10);
 
 		if (*endptr != '\0')
-			return TARGET_ERRNO__INVALID_UID;
+			return UINT_MAX;
 
 		getpwuid_r(uid, &pwd, buf, sizeof(buf), &result);
 
 		if (result == NULL)
-			return TARGET_ERRNO__USER_NOT_FOUND;
+			return UINT_MAX;
 	}
 
-	target->uid = result->pw_uid;
-	return TARGET_ERRNO__SUCCESS;
+	return result->pw_uid;
+}
+
+enum target_errno target__parse_uid(struct target *target)
+{
+	target->uid = parse_uid(target->uid_str);
+
+	return target->uid != UINT_MAX ? TARGET_ERRNO__SUCCESS : TARGET_ERRNO__INVALID_UID;
 }
 
 /*
@@ -142,7 +146,6 @@ static const char *target__error_str[] = {
 	"BPF switch overriding UID",
 	"BPF switch overriding THREAD",
 	"Invalid User: %s",
-	"Problems obtaining information for user %s",
 };
 
 int target__strerror(struct target *target, int errnum,
@@ -171,7 +174,6 @@ int target__strerror(struct target *target, int errnum,
 		break;
 
 	case TARGET_ERRNO__INVALID_UID:
-	case TARGET_ERRNO__USER_NOT_FOUND:
 		snprintf(buf, buflen, msg, target->uid_str);
 		break;
 
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 2ee2cc30340f..e082bda990fb 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -48,12 +48,13 @@ enum target_errno {
 
 	/* for target__parse_uid() */
 	TARGET_ERRNO__INVALID_UID,
-	TARGET_ERRNO__USER_NOT_FOUND,
 
 	__TARGET_ERRNO__END,
 };
 
 enum target_errno target__validate(struct target *target);
+
+uid_t parse_uid(const char *str);
 enum target_errno target__parse_uid(struct target *target);
 
 int target__strerror(struct target *target, int errnum, char *buf, size_t buflen);
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog

