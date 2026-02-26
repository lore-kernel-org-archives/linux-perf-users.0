Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D29372B4D
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069746; cv=none; b=oog/MQkxO2qZ31zOcSxUwiLpY+VR56QTc8HBreZQM7t03r4DjPTNUgo7sG8GJ1PryOWJYcf+b+OA8QgYYUA5LAtzUMWSyPnI2+UsBtjlw4GI9rXbnwelICWlpR5/hpUl1T39cGADGD1SKKCVsfB6ehIxijIoeoSVo1BqAslAs84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069746; c=relaxed/simple;
	bh=eeNwYpEzpgEXFZ0Jhoxog60AAtz/Jn9ONeyPQyjQ79c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hT1fme9MfLhPDVbHifwwiLLGcBfFLR0jAbJiNFyL1BgRO8nEKPP+y457HdUYJAHzoxd2WjTAz0OJ45gMrpTHACo4jpzAbWvc8+wI7/4nH2pCdEAvPAhY7tMcO4+gUQlpgq2yGZJmOubQnG6Zd5jubiz0XZSbPRlZc4CPx+8ZVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KC6ullVG; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KC6ullVG"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1270dcd11c1so456025c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 17:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772069744; x=1772674544; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Gmm98xZ4+RrHvD1WFWJ4a3sf0CYZy8dqlD7KsFsh0w=;
        b=KC6ullVG6/b+EvmbJIGD8XpihMrSDAFnly4fNIOo0bJaTIEV5wydhzYKJLjMY8AB6b
         P0iQ/8MGrWwg45lDx+KHSooEmzn+jFXTyaANpMFpOtKFMR9rZjCRpNH03+o5o5+zHPrp
         wdSuSMDutmOA82flV2Evy3Pnv6TQYHxVvONV7ttqd7a84inEs9sDSf6y8oqZLm7fIo4c
         B07W/WFVUFmgyXGZEHvs7y8KznD8CXof6nWWKNxiGIWfZ1aXAzwbD2InDOksRoSKqN1a
         OVLFjfLs2aK7R9y9OC+nkDAZMxBOqFEQog30rQiL7GIUle6G7mpIA5MSW99+dwl9QwJf
         fXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772069744; x=1772674544;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Gmm98xZ4+RrHvD1WFWJ4a3sf0CYZy8dqlD7KsFsh0w=;
        b=K7eCZV1og8q+6ixqjmeGyWrX+BW2Lscjzj5++uw1b/D759E18YbYR8FYkIcZh7b55e
         IztKbYzBVHEPGgmMiujjZ7tiacJT7MwJm63MGhLNSn5+2U2xdWzoIHLbgVG4sTcCaPBv
         7Y44qRkWwSbxjctE9VZCwo5zefMf53UnarwVjovYjZ4xIfW99zHs1saohsuVcIk/nLiV
         LK9/c4k4pDIUlKoROv96Znayy3XQxYF8LEk1ddGBXAD4jiWCTWMxvT4fP5R2H0+W6hC2
         DpDMbrU7/Zh/ko8Hjy4z728lBVx0ZEvuEdArSO3oPjvL2Hy9RGLM1DQc4HmMrBMAnpdY
         CVgw==
X-Forwarded-Encrypted: i=1; AJvYcCWlLRpoYRCTK/yJRfqRxaI7LbEmiO2rhFxucQh9KkPTlM5Cj9hKfBVCe5uRi+20o01huBZs1TWYSnfUwsd4U+1o@vger.kernel.org
X-Gm-Message-State: AOJu0YzleWt2QAsGwG3U+3jSn0Gsf0WgTXFenfeAMLl98fxi5rJ3BwHd
	DG4FaW6vnWlyv/9uOuEbkXKhnmB3XXkIb1RCiSxx21lW2XurdtFK7HOUEfUyK3/5BlV/MzaQ8OI
	70Fn7GpR0jw==
X-Received: from dlam6-n1.prod.google.com ([2002:a05:701b:2086:10b0:11b:bcda:45a9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:660e:b0:127:148b:3fcc
 with SMTP id a92af1059eb24-12789c55ba8mr281096c88.8.1772069743977; Wed, 25
 Feb 2026 17:35:43 -0800 (PST)
Date: Wed, 25 Feb 2026 17:35:31 -0800
In-Reply-To: <20260226013534.2028272-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226013534.2028272-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226013534.2028272-3-irogers@google.com>
Subject: [PATCH v1 2/5] perf header: Add utility to convert feature number to
 a string
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
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
2.53.0.414.gf7e9f6c205-goog

