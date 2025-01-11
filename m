Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796BB1B87E4
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622129; cv=none; b=QaGluUCMi1VJx8Th1d36i2oFaNRvEq7KkO1aINqO7twV+ljpweAgBdgXl1xNAAru9GhzRI/ZZkane3zAwgHWS3AxVev9b2MAI6WF8+yrpBzpW6N9X18O2NkjMMxoL27V+YrlfIlHrOdUO7egJnolW2aIX3d180N48/ylX3jLKxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622129; c=relaxed/simple;
	bh=V/R9m5oeza16OV4MwxW9jEeeBnT3xu9jYZh7b8scwFg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=a1ptvz8tNGcE1vBQj0ZDY0NlWKf95boSguIuaitS4QaKyku+Fn/mW0jCmT603LLfpauVeVQXaXsIvhkv9kSxMoyJu8CwEjzlHc+XYXv94Oofa+FexJvNHwctkUolytO/HHsF/aetE05d7/b+dbZOgLqhibUbT+hExzWgBsgDI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=upkc4Hyl; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upkc4Hyl"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e54da6701d2so7790272276.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 11:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736622126; x=1737226926; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sGNdjgdlACaaqJ1r0efJtgBm6/9zdBvw5eIx+KXPDwQ=;
        b=upkc4HylkHMlxp9trkbbB/e/hzJRXA0nlR/anAy8k/BBq8ct5F9Ppq+firQNQXqyfg
         Pt0VTl5Y67A+uIVbOXivxPwz4bRw25rJllpt91YcXQHonKJ0lNCoisJgvc1ubf60wGJy
         qwXU91wSZHTJDwkq8BqbS+eBI6hV/a+mmQlQn1Dv52bqKh8L7AJP/1nnvbcnSN9kcYf8
         4nn+PcQ9KpZct64qTU82VBRn5rC8PxKCnLXNexm3eOYZXlPHqRJprkM7+BIIwjAganBy
         C+9trr/6GFjr3U/OUx7aCIV83yjIFEadxblGjmICVZdBmFxtS0vyLs1oAAEBv/dr3PfW
         qzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622126; x=1737226926;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGNdjgdlACaaqJ1r0efJtgBm6/9zdBvw5eIx+KXPDwQ=;
        b=DnS9MK8jAxeiMVOR/PWCjl2YF0dXEpqnan9yFsrOto+7B6FYb0grJGorjit3gtNQw4
         XN2UlQ7Ay/4+olqn6vZDcYS4cwhHYHpiL/AK/NnDFMX+ufR7soLwtR1wNDkB16zyDJ2p
         xNj9e6qV58BnXl1MZHoJoDb+se32Nw0Kx+5Xyia321ZQQBqZ7xb98m7HoeA2fy8KaI8r
         1lVXP+3QElIQhVkcIzQEa5OcyjsqgVIHSl+4wYpr2nErq+DOSYWyuXOmdThFzTaQX4lg
         Upb2UZX0ydaAIhMRv9bRsU5ueFVb2o9rxqO5exL4mRQJcPor+t+ruXwBO01frmJPETcj
         AJiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6XdH0IYObkwtuqUaEKZHKhzP16Z+kXtDK0ZarEwf+CFqdaopf3p9BxdK2x1xQ2k1Rw/q73MKAjiuMruo7Qnw/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv+S8q/FjmBdh+MFCj/MJWusQOe7tKZ4qF9E4oVanPD5Z3yU+d
	gZp/nZ63nIW+IsmNHWf1gRyteCtFMjnRX1hnN++VH4Zij2qx8FVr3TVIwlhE2qnzOoVwPn0cNbT
	Uaw0+TQ==
X-Google-Smtp-Source: AGHT+IEMLWApUR3OqGvGqJHqxtR0OkxCJGKIEq3GZMsF7ZDkbyN+lDnx2QQyWukhHlY/UCM227OIlvtuw8sL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8807:d7c5:bb27:35fc])
 (user=irogers job=sendgmr) by 2002:a25:a167:0:b0:e57:452e:42bf with SMTP id
 3f1490d57ef6-e57452e4998mr2441276.6.1736622126441; Sat, 11 Jan 2025 11:02:06
 -0800 (PST)
Date: Sat, 11 Jan 2025 11:01:36 -0800
In-Reply-To: <20250111190143.1029906-1-irogers@google.com>
Message-Id: <20250111190143.1029906-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 03/10] perf target: Separate parse_uid into its own function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
2.47.1.613.gc27f4b7a9f-goog

