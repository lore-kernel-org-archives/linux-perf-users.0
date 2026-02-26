Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213261B424F
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 01:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069744; cv=none; b=gpoyNxoFTKh1rLpgayWMxcRviKXVbRkfVq44M7kGZ4X136LlwTClSRCV/NisG8559eyrtR2ZCb+0KedExBK4CAN3DYDHVVXTOgRadWaKRzLwg5r0PB1PB0ckqP97kbh3v0VcAOkaOb3t855uPTdhB5xMk3jZ7IwP7ebjKMUqYrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069744; c=relaxed/simple;
	bh=fFQHaIikBJyovgPGOeGhVTXIPkPFPK5i6n37FVjI1fc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rvXdBnGFMS4nUcDjql8z1WdHZ0yLDOZFtquWgoUaTmRI1NM2zosVKZcVscHDFukyVhvfk8YM2Mt4Puq0B5kpiRmK6q47u3f2SCI0o9k9Yc60hUeVqL/AU1feKC/grRrre1uxuc35155j/myCX3dZNd63v4lx+blz3jmkLVVyD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zhlwBeIF; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zhlwBeIF"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127133794b6so465918c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 17:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772069742; x=1772674542; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGUY7F3cp7tvyDfn/CEjTzbckjduIBZzlL3vEOWkjFQ=;
        b=zhlwBeIFPGYBjABu9OqlcRLe5WxED13vX8QXUZVfORWfZzBrriY2BouzuwaOGQHAdN
         C1FtL77hDYlUhAxMjLqlCXwrDqsD3BFn87CzVrEy1TmT93TBuhEwYIPk7j9qjqElitnH
         5S+fboU2PBM9/5BZGpcBUqNnJ87IbKyw3H9lF31EBh/IeG/72MJqCZN7h8DmG5rgsuNE
         mST+j/DoSB+PAcW4i+AwGwuamxV+V5JrJOzY42vkQi4IPe+RqKqyfbyZ87fpkiQcFXFs
         7RKOXci7T1Ys7+ShNInUPDewO/MphZS7Ydr/CXVvrGqWN17vIb5Qcnn/44Z2iEy+xkmF
         Y1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772069742; x=1772674542;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGUY7F3cp7tvyDfn/CEjTzbckjduIBZzlL3vEOWkjFQ=;
        b=NhOrz4ClBtc0gpQf0adVjMy5RskikdXrAW5oDtPIl02uz/Eyhui0LnZITNXFLVZbut
         R9BtLmFgq5PDWeVvGcIAU7KV7ejp/Q5Dypsu/Ir696aHv7yJ2o3TOLW+qTtHMhEKm++p
         tM9W4ElEA5XdnOrY/gYffHGea46NrBCSmUfFJnU0H84T8gbHLBnlP+uDmFm2oD7iFoT+
         4d9rATEBvquNvMiczaTk/w3aNuEWbq/ane4ic+E2SAPqKme+DaKZuToB+rvZwWwfNSj/
         ruaDlgtDX8z+nS76bmviZraGmK7q0oGpF+2alqgoGPq9L+7o0WbSVxhDyj1ieoIcAmE7
         BpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb7qyIEqeZpclP+lBCRgmoqTuQ8jy2g6Td10AUWQWY9pN5FKm3fzfFEL00LCuFI0CGHTY6mtQnmEnumau6VU4A@vger.kernel.org
X-Gm-Message-State: AOJu0YznmnrzY97fel8c13ynkBQagcgI0FIa16GK1jq5e6cA4W0YMYPl
	ObeXL4L78fITCQ28ydG0T1KeDtltQlmNjNfdc4eM97DN88oBjK9sNKu1G5VrMQPDPmT0hr5hvXL
	VpJR/zs3ChQ==
X-Received: from dlbbz13.prod.google.com ([2002:a05:7022:238d:b0:127:dec:f86])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:68a5:b0:11f:2c69:31
 with SMTP id a92af1059eb24-1276ad6a75fmr7633930c88.46.1772069741988; Wed, 25
 Feb 2026 17:35:41 -0800 (PST)
Date: Wed, 25 Feb 2026 17:35:30 -0800
In-Reply-To: <20260226013534.2028272-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226013534.2028272-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226013534.2028272-2-irogers@google.com>
Subject: [PATCH v1 1/5] perf clockid: Add missing include
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

clockid_t is declared in time.h but the include is missing. Reordering
header files may result in build breakages. Add the include to avoid
this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/clockid.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/clockid.h b/tools/perf/util/clockid.h
index 9b49b4711c76..33dbd8673c1c 100644
--- a/tools/perf/util/clockid.h
+++ b/tools/perf/util/clockid.h
@@ -1,8 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
 #ifndef __PERF_CLOCKID_H
 #define __PERF_CLOCKID_H
 
+#include <time.h>
+
 struct option;
 int parse_clockid(const struct option *opt, const char *str, int unset);
 
-- 
2.53.0.414.gf7e9f6c205-goog

