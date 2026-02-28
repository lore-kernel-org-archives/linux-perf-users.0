Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1994347BA7
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Feb 2026 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262012; cv=none; b=khVQV9DLI1Ir6IMzorUuYZzDHN5X4GHL8IGfZbbx+thINikw9dH+/KnsfffGiCf42pR/hrf7FPVdUhvzbs35lnvTrXuRaE4HNNuRyW0CnNNUmMXKhsZsgIfKki5xwErzTQqwSdptkWqwZ//RvPVpg0juPgSzXSXqWvjYqNyzroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262012; c=relaxed/simple;
	bh=eU/gTxR9aSiFByEc70zxEk30SpfND7ax0/+8yquZ05U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aX5pAgW3onlcqtfofvo4w4XyghcGFp9AJy+eABz4G2M3vkw7sE4HeS2vKB4f89jth+iG/WpijFOhEIqEOXXnxOeYkZfB1pxYHeFiRcHeAqw+HbqXFCHtDJZtIBw5czDbhG60gmkVQQG9K+FLl3TtWx/+8omZ9cexuDJ6iqcxQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hygOgsNh; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hygOgsNh"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bddd304622so2146092eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2026 23:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772262011; x=1772866811; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGBdrZFEQdY6Z2dr6uO7x199Kzk4HiW1yI8iaR5EMOw=;
        b=hygOgsNhY7F0c0HoB70vB+yeBLROR2ClJAh8/BSwoWEwJc+9liTweCtve7bvJd3jVw
         VGc7pHVlqYNf6jy7svC3YwL85FYYzdV7KX4KtzxahUljuEQVhM4uJbVgPkb/q5vFeLGl
         XF+55+/U4xWZOUJ7spyvncKHnDtxq9DsH3A7G0U6Es/Q52wUQWDdaQTWeC3KUyFLDeze
         8366X2UwhDD6dtNWwLP9TeJVWlrdQAHezxmzrCD4SpbbZdubyRcoRI5Kw5vu3dkuzsZH
         o4tk4E5aWpoKE459ctoJlJb35S9BFTUkJBJ4EzXd3KP8z4LwT8THGAitiROVAo6+LJ88
         cfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772262011; x=1772866811;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGBdrZFEQdY6Z2dr6uO7x199Kzk4HiW1yI8iaR5EMOw=;
        b=NlUjUDTnxrXsbzFV7xgr5ZMKdSGe9Wkr1sqME5LMmtTFXPAhbjxCwepyb5BnM1HEtF
         Mw3YkyKLbNO5y1YwOLifCp0ulT8hXpCR0PXA/ir4zooOWnF395A2Jo/hu2uLkg2r3loU
         QNg5ZbVic6SbkraKAclswoY/RKgW6ebFCI00s9NRd6Yf4+GuOINfiE6stoU4Q2wVfHy9
         bVTkRwxHweBPfp57YSSeC9AaFyigkn1bs1g07QheVviwMgeDTeH+HoHuUjrahsSzZ9Tr
         qVypphU28R3TVE1HRgvDROYlcCmbSyc+tIyBb4P2lcpl3vkEbIf1nhUsfCvec3GRC9oy
         CBhw==
X-Forwarded-Encrypted: i=1; AJvYcCWOWBj+BvPFRvTcYBmRBk0Ou81QLDmfdQMRPjxXkDQGC+SzZZXtCATyKAiq+hh5a0jd5dJdC14m95F02zumCq0R@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQyRa/VoQSY/WhiD/VrPdDLRO3RbFwaAUzriQgEiz5KQVBbNV
	rFKtqzP6t3z6WJG2w9birx8HYRvg23UGE6yECOtQ/73x2oKpkmCPcA5oMYpBdEa4gVCqqdUQ9X+
	N04IGviIAyw==
X-Received: from dybox14.prod.google.com ([2002:a05:7300:ec8e:b0:2ba:acf0:ab76])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:169a:b0:2ba:14a6:c96f
 with SMTP id 5a478bee46e88-2bde1e6622emr1984573eec.36.1772262010453; Fri, 27
 Feb 2026 23:00:10 -0800 (PST)
Date: Fri, 27 Feb 2026 22:59:48 -0800
In-Reply-To: <20260228065953.3226283-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228065953.3226283-3-irogers@google.com>
Subject: [PATCH v2 2/7] perf header: Add utility to convert feature number to
 a string
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Chun-Tse Shao <ctshao@google.com>, Hrishikesh Suresh <hrishikesh123s@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For logging and debug messages it can be convenient to convert a
feature number to a name. Add header_feat__name for this and reuse the
data already within the feat_ops struct.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 7 +++++++
 tools/perf/util/header.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9142a8ba4019..fe5d21dde04f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3770,6 +3770,13 @@ struct header_print_data {
 	bool full; /* extended list of headers */
 };
 
+const char *header_feat__name(unsigned int id)
+{
+	if (id < HEADER_LAST_FEATURE)
+		return feat_ops[id].name;
+	return "INVALID";
+}
+
 static int perf_file_section__fprintf_info(struct perf_file_section *section,
 					   struct perf_header *ph,
 					   int feat, int fd, void *data)
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index cc40ac796f52..ca22030a1434 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -132,6 +132,8 @@ struct perf_header_feature_ops {
 
 extern const char perf_version_string[];
 
+const char *header_feat__name(unsigned int id);
+
 int perf_session__read_header(struct perf_session *session);
 int perf_session__write_header(struct perf_session *session,
 			       struct evlist *evlist,
-- 
2.53.0.473.g4a7958ca14-goog

