Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF1227E83
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617228; cv=none; b=QgCsDLKjOcWoXaeNP8PmZ9CJseTgCcPQ/P1zrF68cIhgGvTtzVkJBRd2185zNz0NkRZslbzjdv2XV2fnf3bnNR4JtBW2o53151VMTF/N2dPNvSP0Tm+zGZ+iAXO14cIaDZIVGT1mTOHoUWyTHMsNevB6uM+HGI8hO/zVqX8DkBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617228; c=relaxed/simple;
	bh=NW04OdUCBUXB0XwIkvNApQLAwj8ekPQOiMfdRIxQWTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Pn+23usexM1sqjxLHZiKhPtc9drdvjM32XCWhRH6tjIpJx96i4xLSlWCnnXmA/8XrCBwdlvbI/BnvTh2XOO2YV49QaebBe9iozAvqCIiEdQhfFHTn6ea6JoAFyguzl6rnjvNszpQP/cPmX+bKjyaeD7LtHWmD6+Jie7C34PmaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rT+VduVM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rT+VduVM"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so2139194a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617226; x=1746222026; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBRzvY9/oqGcvbYk2oQ/5pWM3xndZw3DROLAFfIr7HU=;
        b=rT+VduVMIASn2Mtjy8X+n8ZMTqllJQjpATimXQDfB/2Wb9SAgPUUglsncOp9P3yGWz
         f40Rzv4CzbE0NGXzgepuXt8Efb0oebzbmtgtSdR5aTOIusuFsfd6NYxBzoDq1/dwucBC
         AO6c/xDdXKEQ3aXXpmZffBEp/I3m6yPAQ2pVK2atwh52Orj3caTe5x0gWRjz9geahNEw
         UslxmGtoClL0vK6G6H/Ae71Ci1mmGAq398betV3yc0o2BCAFsTCaypXa06DSLTCDyQm/
         +f454oe6+eGQMH/heHqY6wROMidhMhhHwnHK97m/di+JnlAVdw3RFX8QSkL8s4C0UbzH
         Xmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617226; x=1746222026;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBRzvY9/oqGcvbYk2oQ/5pWM3xndZw3DROLAFfIr7HU=;
        b=CowyCFJF7cMIc0QDOqChar+6j1gGU5D3iz8SQDdQ7iOx+xWa/zUOZPJ6O5fD2FtXCT
         6F/aPb88lLv4VqMYUAjc2uLP/yFE2B1P148JkWoGR7gUGmiRqcnOkki2EKK30B7/2kmz
         t8GEuyZmuywBQ0Q43tdPXELWOG7s4T+7jO9z5XKoiqHdeC1OgevG+00YQlGVErDE4rEW
         A6J6Hnbn0+Ey17NJgNQ5efNbHXLISVGqmHLm80yUBSdsi6dW9VdtmnpX2GfYBjLF4Reh
         PkZXUS7xQsig1zeNklehEy+t2XFMINI6MMYWg9aUaUqwkYWfTYTi6GTrgKuzHpKYDemq
         NdDg==
X-Forwarded-Encrypted: i=1; AJvYcCWEtKwzq37HutXH56jR/eX1Ed6abGkTfV3m94S58Zlr7ZHrKv3LXIHtYBSmfreClorQNgrQx5XruXxnKuECcc2+@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZkgVkui7KpWJL1hHF1T/CLjw9BcvMkTlYOXuW0tJv+maIHzt
	g2NX0sUElLyrbi/xjoxDnneVZv6HraqNrU1MPS1sv0lqsN/UE37NrK7QaUc5LeXwvhx+aAudN3X
	2BXZN/w==
X-Google-Smtp-Source: AGHT+IGGlxlrXc4zeoAxvuCibveLAo4hf2bW6wySquqYWmKShkqKk+8FF4aoVv7ok9S5AQIRvxzmpRZUU6A2
X-Received: from pjbpa14.prod.google.com ([2002:a17:90b:264e:b0:2ef:95f4:4619])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5104:b0:2ff:53d6:2b82
 with SMTP id 98e67ed59e1d1-309ee3f9ac3mr11267255a91.11.1745617226120; Fri, 25
 Apr 2025 14:40:26 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:40:00 -0700
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425214008.176100-3-irogers@google.com>
Subject: [PATCH v3 02/10] perf target: Separate parse_uid into its own function
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
2.49.0.850.g28803427d3-goog

