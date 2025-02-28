Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12941DF99B
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781445; cv=none; b=cm5Q5eEyqQoVm4L/JZ6NG8/ZS2k1JNKiEIGmr0xvh/kLhGjHQHCtM6QicaeLtV3Pz0oNkL+FH8HxISLpST/Kz6Px3w5qTK28zfMJHdg+QGtsrMglOITy2qkhXQIBLuyWcVsYhGXLf/sXy9paojrpK2dc0yrZrVGs5/QNUoOgNBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781445; c=relaxed/simple;
	bh=tODv7690hqlZb2xriWhDrFPwKVoBHpGvviDIDK71V8M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=kDP4F25CnZnOn0qGVn2op6JB/xSGrmLmIyZBxbyHJec4KwbYgzZlIuIUswO4QYwCFxBh8h93r9jApKWHuHGBLP+PtgJNrgHNqdgLzPvk6cLwNESaDP5FfFQgtWDqUBpKGWIDhthH0u5bTllLgqg9M7i8qpBUIc869Ju0H/CxjtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+AdoSmw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+AdoSmw"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e5798866415so5116105276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 14:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781443; x=1741386243; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Di4fYvOp7GLM6eylwf5YJrXliWR6y7W6n5lGa1rECA=;
        b=F+AdoSmwn0g9MBvq/q2zVSXxElar8BladO98PgPlF2c4+rVlvM+D6TXVKvKClSBk+J
         aLygZmIHtIi+hK0TZKStdBMo6dhJmk8tbsYbVq4L9ZXwcJP6dptHfX63G8rQ9eF8tXnM
         bA8FcASCBQCPOTjUuFJ4Sr2qeq3Dh50r13bqhXT2yme846mmhQrHn6sXnR9hKTBnk699
         RMrUZszM6a4bjMm7fqKOJtkKYx2eP9Tu2Uh3nWEuhojltHzZz6WU5C8z0r4pg59MC8Q8
         bUhR8UZDzR0OKYZNndIhGKJI+mEiVaBiHv8YO5ocSFswl1srhJpfT4Kmx77Z4/VKFMV7
         Dmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781443; x=1741386243;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Di4fYvOp7GLM6eylwf5YJrXliWR6y7W6n5lGa1rECA=;
        b=kRbWsuYXeh1ygzisGMqCe3yzAlnU30xuBcv3+D+8PmGHiWKYbxv07FXE0uq6vuHkar
         DoJG7osnyd0XTXlNbXPpQIUkR94l02rqHZ/WEED4yI0lEfTcBv7/zVFw6NHHA5nKeoiy
         3HUbqHG5iKMNcLaWyeFZNHaSf+MwhEzyftzZL/cWdLIRthTd9BgzOxQJ4wd3cF2mDyXg
         3Nb/yuigLu8p7GTVCM+jX9nttzeQNBy8kFpQapgkHn/YThcP0j38RJL6srqyLl/GQLV9
         nibhT93P5XGKDUXEnVtNPvDvIfMlkAMA+WXkgu0SqhOQHtibzwki5vFZtk9TY70oLfzZ
         fklw==
X-Forwarded-Encrypted: i=1; AJvYcCUnztHoYbBBx3qxJSyvB1JfQfxXci7IkHpLVD6V0SJaZWNC5OnQUJPBeQ1vyS/Itn/kmpuz0sYcmlPFCn/3S3Xq@vger.kernel.org
X-Gm-Message-State: AOJu0YxcgG9qRc+oVr46ho6+lO859odmT2EGRxVmw2TZ49LNiYNW6RRJ
	/OgjG6R3O1kz0WHZRBiYMhrexfNWC9RoQbVJnavBX1mJkI0Wyjbs/H64sqlJykja2PHO7YRaILY
	R/iTFSQ==
X-Google-Smtp-Source: AGHT+IHb+kaR2q+Vsn7L10Sd0q8KHqsewLN7g4KXEvWyOLV1BrwdPWHrXjjjKQ4YL5gZahx3JWH5VBpZXYlu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a25:aae3:0:b0:e60:9fda:1ba4 with SMTP id
 3f1490d57ef6-e60b2f7d2b0mr31270276.9.1740781442950; Fri, 28 Feb 2025 14:24:02
 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:02 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 05/11] perf python: Add member access to a number of evsel variables
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Most variables are part of the perf_event_attr, so that they may be
queried and modified.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0cf81cfcfafb..b600b6379b4e 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -811,6 +811,28 @@ static PyMethodDef pyrf_evsel__methods[] = {
 	{ .ml_name = NULL, }
 };
 
+#define evsel_member_def(member, ptype, help) \
+	{ #member, ptype, \
+	  offsetof(struct pyrf_evsel, evsel.member), \
+	  0, help }
+
+#define evsel_attr_member_def(member, ptype, help) \
+	{ #member, ptype, \
+	  offsetof(struct pyrf_evsel, evsel.core.attr.member), \
+	  0, help }
+
+static PyMemberDef pyrf_evsel__members[] = {
+	evsel_member_def(tracking, T_BOOL, "tracking event."),
+	evsel_attr_member_def(type, T_UINT, "attribute type."),
+	evsel_attr_member_def(size, T_UINT, "attribute size."),
+	evsel_attr_member_def(config, T_ULONGLONG, "attribute config."),
+	evsel_attr_member_def(sample_period, T_ULONGLONG, "attribute sample_period."),
+	evsel_attr_member_def(sample_type, T_ULONGLONG, "attribute sample_type."),
+	evsel_attr_member_def(read_format, T_ULONGLONG, "attribute read_format."),
+	evsel_attr_member_def(wakeup_events, T_UINT, "attribute wakeup_events."),
+	{ .name = NULL, },
+};
+
 static const char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
 
 static PyTypeObject pyrf_evsel__type = {
@@ -820,6 +842,7 @@ static PyTypeObject pyrf_evsel__type = {
 	.tp_dealloc	= (destructor)pyrf_evsel__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_evsel__doc,
+	.tp_members	= pyrf_evsel__members,
 	.tp_methods	= pyrf_evsel__methods,
 	.tp_init	= (initproc)pyrf_evsel__init,
 	.tp_str         = pyrf_evsel__str,
-- 
2.48.1.711.g2feabab25a-goog

