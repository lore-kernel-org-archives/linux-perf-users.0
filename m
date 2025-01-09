Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1084521517B
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409090; cv=none; b=dAdp7mf3DFt22sAsVOCCan68+yG+yZ4pCPeIXdgVAYNm9DjhHYsUOUgJ0spyLmj4aQkd2bJ6Qb0JqiVcHsMefugpqwsBEBgBTyW/eS2wy3RBY8m4GA7arshzqa5mUYxN2Ze+E8ZgTR57Ix9j9mzGKrHnhvyd11eQUnJlJRdbDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409090; c=relaxed/simple;
	bh=hiXdohrvZfBQQVlWlScp48GUnTP6f+2pkpwNTAqWek4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=W1ZgwS7zJVBOpFdRA60SMEWZMjaB4zKKCZb2NN4x/OXs9HzfCc3vNfVpgBzyZY+9KrWDZNr86ZiFO0hwaZ53wu4yvLYGSIBiU4+oeCKB2puuzHxsiTTLryNWWlbw5TVDDLeQwFq4nqY1iCbc4N4WgMq6YwzR/1AyC5p53K3VKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOiMBxdc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOiMBxdc"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e4a8b40dd40so1487407276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 23:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736409088; x=1737013888; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2aDXsm3uEdQo2ZnXfxbpUagdP14qYtfS3MpVBq60tU0=;
        b=rOiMBxdcauwuA3SY1v4LHIv1nKpnSRVk0sTKuThT2KtrJF/AGwt2P4MWHtE7OKCgKf
         VaGIwxFxnBPZ5pa5GME+n95xVEY0TZCDSWd3Jz/ri3UpyNLOKqSbKC9UcpGGYT5HHP1C
         ccxSYJ/EOX6brUVFN2rielmGELRep0MJIoGxRuEEpIzNDRMwd5U9GLJj/6EsBk+jOBKG
         SBb4aLV2ukfnd80iTVs5HEK7IKvnY7Ipct92sVvmyurf3mLPmM5mJEPkPKPuwk34I2wb
         vxBwEVl/h2l4Qg08Tv9JK4BqlD+ov7zQkhFjS6wFEXbg6HsPKHuBI+eqMWhswm2undDd
         oVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409088; x=1737013888;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aDXsm3uEdQo2ZnXfxbpUagdP14qYtfS3MpVBq60tU0=;
        b=CdDcc0TDvGkWt/j9vtOBpPan7K2qioER4O8femadPmdM9bDT0D8r+VFvvZbrmtx8Om
         UgCIH8EGbMETjbEp+STgSn/g/W3+7g279mxXrQCwSVGs+Ai/A4uaPgjp+gR2XjXYMO1m
         I/m2Mm4pEie/RhnkmC0QM5sgvH1Ce6E4QW+t0WcCqYyN/WAd0e2ttwr9Z7Gabcsarwek
         /oc4Cy89l8KVQ0GriO17a+jOh7+ttq2ZVN9URneIuk/fvZ35Py/1UXpbQVQvgmeiI1at
         VWpyWlkn2ArVGQ+LMUkIPJx4/ZjLDNQbWf3Uo0urmMtp+tFFBWp9UtmG+H9bMYrf72lP
         vyQw==
X-Forwarded-Encrypted: i=1; AJvYcCWp188kEj2oBD5VcHocBORnnyS5ovw5/x9qPG6x4RUy9pnbAKi/L7aXYpPggst0IgpBShr+RMl9svyarxRA37/G@vger.kernel.org
X-Gm-Message-State: AOJu0YxtVkLX82WktzfJ124CazT3jZ7VZB5HzWKbKRYwNvXQRRHDGO/o
	2XKlHPvQy1lshoXiVKSz+EDuzIj0gECM4olD0Eys47yy0O07ysq13XvXfZmF28zDEAIDlrmVpNw
	YB34itQ==
X-Google-Smtp-Source: AGHT+IHkS55KUzgcoevzHuMN1Ir9gOuIfNU/o0DtzV6iVcbvEacKNS6E+1S/Q/beXkgJxe1UXVhLr+ri7zYq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f801:f788:c7e5:c181])
 (user=irogers job=sendgmr) by 2002:a25:a144:0:b0:e39:87ba:3582 with SMTP id
 3f1490d57ef6-e54f01a8895mr11372276.5.1736409088033; Wed, 08 Jan 2025 23:51:28
 -0800 (PST)
Date: Wed,  8 Jan 2025 23:51:02 -0800
In-Reply-To: <20250109075108.7651-1-irogers@google.com>
Message-Id: <20250109075108.7651-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 05/11] perf python: Add member access to a number of evsel variables
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Most variables are part of the perf_event_attr, so that they may be
queried and modified.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 8f68320130c4..6a7042fd2569 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -802,6 +802,28 @@ static PyMethodDef pyrf_evsel__methods[] = {
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
@@ -811,6 +833,7 @@ static PyTypeObject pyrf_evsel__type = {
 	.tp_dealloc	= (destructor)pyrf_evsel__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_evsel__doc,
+	.tp_members	= pyrf_evsel__members,
 	.tp_methods	= pyrf_evsel__methods,
 	.tp_init	= (initproc)pyrf_evsel__init,
 	.tp_str         = pyrf_evsel__str,
-- 
2.47.1.613.gc27f4b7a9f-goog

