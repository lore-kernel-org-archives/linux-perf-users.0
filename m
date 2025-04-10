Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4128EA7C
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306615; cv=none; b=PQ2Y/bYOt/sep9kHHAYYcG9GW7M67aMyA3726ksHq7AeqJ/jbf2r9szG9FPC96eo/teJMLvKyKWzJ/YV150C0SWN5L2FvSH9YzdM4oQwtXBMIQZaMpmbGwg+rqOdr3KeVupSSPBMRdo5tq9k5BX8z2PO58mWmKpbA65D+0mnXUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306615; c=relaxed/simple;
	bh=gTyDhZCTno1IXSRzvLwzt6dqW5aQfNugAfWRkxe3950=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=L4TuHEYDU+woZy1Q2n0dZWB4S4V5p+LDn2A4Hb1HVTG3s9bX+TzJVyyipv0Yj4/eDSzlnPceROv9OcCje/yCrxzhC94vxRe0MZ9JDYDVPL/+YpCpmtA9SUOMRNa0P9npFMjZlVjXcdbeLxhwm/GZN5Xg1edyb39K226HQQ9Wpdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wrfCGtSk; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wrfCGtSk"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-722a1343db9so1403674a34.2
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306611; x=1744911411; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mcWxwltoH9XL7Cxrn6JcmLq/7/2rEiSHhwmo34ZV4XA=;
        b=wrfCGtSkpVXOCy9LNU5qJnoqOFo76dEsZoCYSSsgBpC1dpfneeR5z4pE7K+KPhh3ll
         MHZ8J7nyVjYBBeMiWxDRuufnzYag4msPZ7RYrFzXL+90eJl+LO0ZBwKlwilcBbCoY9eh
         GzXcdZ4ALVxMXjaMrOv9zgFb7l9ZUMyqcshqG310188/fXC/CVQpJBntZUm7+fFLpE3c
         FMoSlICKFsPUfBlxqlTmfRCfQ6FLBfbDJliw42YwMFWABRU7VrQTivAJKoFmYBw/0pk3
         dYxi5BdFk9KjKhteBmsErcxyRYt4Vw9tprgcJhIldvtLjalWtNB5Ba/DpnAfKej5E9lu
         eWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306611; x=1744911411;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcWxwltoH9XL7Cxrn6JcmLq/7/2rEiSHhwmo34ZV4XA=;
        b=orQ21yni0oSb4KS8joc01839swiVzJkTWN9CdH0QHipgttmKvGyTZQhuj07TeRy1v2
         I3OGUIuFpQXBdXWF8yCsDT0LD+y9KeuMRMCouoOz0ZbcrMVEwHjpx6Ahl7lZmVQAH/Xb
         /+dn0JGqZH1BWanMlIOVGKl/wLlfRPz+A+ss3xWtva1v9xPeGa35LJ6d2rGQAHhs47DH
         gbXth8pSyjSNL9HXoyMqvtZetFFsZaB3zhDNuK4tAipX7gaJkVhXgDxO0LwR7O5zr9ZP
         KCxZwQtsZofFE3aZHUi458EMsa8Jocc7skDyS3NfnECz9xF1mEGXCIt5I/JTcn6c1Sgm
         mEcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbkXKejB8V4znnLnT83YZlOkHCL/yqD6HU8iKFN52o2SZmcBfYTw9JsJfskDuCI66ykwvCW/EVvNg+sG/toioz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3dQUPq2fuftOsoRhO6GC9VSyhcWcjyZVwfZeudvwLQFS1e9UZ
	Ba3qyyIDPxbzrT9UBzSqqTTmunTN/PtXMUvfZCd+RcoovviEq1ymcLxAn+TlfTVdzAftQeDQpwG
	xfzgOVA==
X-Google-Smtp-Source: AGHT+IHulExf+Mv/Q1ZS+sBiHCCJIKDXZ9ldVCWeUBFQHANG4wq6xirGW1Tq6sYLc1Mhwf3q7i7XpglcaFSp
X-Received: from oabfl6.prod.google.com ([2002:a05:6870:4946:b0:2bc:6ad3:5671])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:25c3:b0:727:3e60:b44b
 with SMTP id 46e09a7af769-72e7bae6f1bmr2044467a34.14.1744306611665; Thu, 10
 Apr 2025 10:36:51 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:23 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-5-irogers@google.com>
Subject: [PATCH v2 04/12] perf target: Separate parse_uid into its own function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
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
2.49.0.604.gff1f9ca942-goog

