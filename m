Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3DE2F3C37
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775022743; cv=none; b=nestpKPcYD6itz3znwn3ncuUpXydBd5IszMzqq47x/TwkuUSSLBYNhDozdf+m/wJSxXCb+8jxw4DIQjFNuk60xUOKHeMgl4gEE2MZi9Uu8/eHCyGtdN2frJfpdXR1yBFwh9ku5xA2DCdeOCe5F6UlrjK191TYopEGXEVTsFs3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775022743; c=relaxed/simple;
	bh=2QgdWtOwiicHTrOVF/Jcws17gyi+KjBBFGJMxarXEYs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ub+kxvQn/RbrNhLpuk+OqMXKyC3NU6O6lB5v2OV6DzxsLxMww2pM7+WPWJ4jw248nAiu2MfOGEUw4hhcT6cFY/UTukoNUAYyb3c8JFRyNeYlHa/pRQ2THhCQuUDFwN/HZxj54pXuS91JG8Gx71fAgdOfZMrhI8FoYiD5GF8VwQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+jPUska; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+jPUska"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c8ac8e422dso1943791eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775022742; x=1775627542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRxz8qX/L98abrO4JrOFfQ6S3vBDaDKNSQSE+uWfj4I=;
        b=S+jPUskawk9zhpxlYTCAXwWxaFXade1EB5UsZszLS5spif0l+vJ+0bu28dzMp9/9b0
         WopXN2uMTOaiOnKPz7tw4VfjDhJ36Fsewf8FDQk/mVb97VZ0hnYRKPJPq1fQMpsBkR7S
         rgGc8PXobsOtOg4DBk/wLqYDA4vhC8p2sGsJgxNFQQ+1fujYvJiRAzu4gMLpcQxOU9m7
         Z2doHGzs6zCBgpGgU5A8i+kWzY4brzNt9XpfvQ5Dl/gpYJJhp/wY3P4aBLh6YMUUKCwR
         gYfXmrCkujg6dAlAvCrTf4UoZ9lPd7Cwn8lkNCYCIKP9WVfViO+HLHFNiDvXRjnaAmX6
         AEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775022742; x=1775627542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRxz8qX/L98abrO4JrOFfQ6S3vBDaDKNSQSE+uWfj4I=;
        b=pvjXVNdY9KNGCxV4l3FFPO7eC2ocfHkxfQgPc9K/p4qqZqBwKzsfl7bxAZyfdhKESg
         IAYwv6nYuUP0y+8ByHW3hp/vSbjjNJRmyeCTmr7Ap8yFDERGbgnAQpXsur2IW/BUKo+T
         Th9b+LSMNGlfbzeeQ7U2lubIcjSRuMypfGtZtuUqDOU68dtF8OyIrQMFYuvs4BvhnCSX
         zHKNLFW6EOehOYZQu/xKcgVx2IJppRY+oDLqS2KoPTYLRBjC1wRveVo5qFGS0u65hHs9
         JSlSpUoiEfNlcAf978iUUrZG5KlegDvwnGTuMLIRHjEST5ESRKxTbj5bed8A8L2sPY2k
         Efmg==
X-Forwarded-Encrypted: i=1; AJvYcCVkBN76JqhS49Eya330D4HpHjOL7QuVVD7y4K1Yf6agvXT+xNTSH9PpGhxQR9Ta4dkM9Azw/z4fzpEX7ahtGKzI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/FkUIkDu6wP/+befj1Qds0o9roHPm2YJcKCDAVW0wpBLdtwO2
	Slsua4lWB1NS96ihP0NiHX75Y+cDRxv/eQN29XVoJGstFibCaLgCNfL57LMq7Y35C4X2N4gAHs9
	P6n25kDYywA==
X-Received: from dybqo8.prod.google.com ([2002:a05:7301:6788:b0:2c5:2b09:16ef])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6087:b0:2c1:74ad:2cd7
 with SMTP id 5a478bee46e88-2c932eba0damr1197650eec.27.1775022741334; Tue, 31
 Mar 2026 22:52:21 -0700 (PDT)
Date: Tue, 31 Mar 2026 22:52:05 -0700
In-Reply-To: <20260401055206.43187-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com> <20260401055206.43187-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401055206.43187-7-irogers@google.com>
Subject: [PATCH v3 6/7] perf evsel: Make unknown event names more unique
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ashelat@redhat.com, ctshao@google.com, 
	derek.foreman@collabora.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	swapnil.sapkal@amd.com, thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

In situations like the perf data converter the evsel__name will be
used to create babeltrace events. If the events have the same name
then creation can fail. Avoid these failures by including more
information into the unknown event names.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5a294595a677..51c871e7fbac 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -926,7 +926,8 @@ const char *evsel__name(struct evsel *evsel)
 		break;
 
 	case PERF_TYPE_TRACEPOINT:
-		scnprintf(bf, sizeof(bf), "%s", "unknown tracepoint");
+		scnprintf(bf, sizeof(bf), "unknown tracepoint id=%#"PRId64,
+			  evsel->core.attr.config);
 		break;
 
 	case PERF_TYPE_BREAKPOINT:
@@ -938,8 +939,8 @@ const char *evsel__name(struct evsel *evsel)
 		break;
 
 	default:
-		scnprintf(bf, sizeof(bf), "unknown attr type: %d",
-			  evsel->core.attr.type);
+		scnprintf(bf, sizeof(bf), "unknown event PMU=%d config=%#"PRIx64,
+			  evsel->core.attr.type, evsel->core.attr.config);
 		break;
 	}
 
-- 
2.53.0.1118.gaef5881109-goog

