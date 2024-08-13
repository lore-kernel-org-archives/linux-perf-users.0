Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA001CAB9
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 04:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723521986; cv=none; b=Sa5miFbfhjVB8RiydDfqr05fr0D3djfpnnTaOgMx4YAtUG9AcooEvvmHr57CJKetcEz1bTKM3CQd+esfRii+lnGq0pzHZEuEil8WHpe95aBBPYuP8QtABtti3xVhXhnoF6a42kyjD6Buwr0T5niQQBeAg0venbDBROQdL6jiFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723521986; c=relaxed/simple;
	bh=neaj+BZFnlcZdgqAbPmFYuTkXjlGXCUDtmdBZZPPDbA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=t2Rc/gTgYt5NKS3cb/Pu/+GddtxIm7M6WomZMODP4eUGrv9+1lnAOxk76qxQpSPoQtJBh4JaHeZbmP/Sz/EyquVB2+PY7mfm+F/rNf4nY+5BG5qdzTXK0S9przvWTdl8bjWRsN4H6dJEMNy7ysxVt2i5M+YSIOogLd0zNEkjI+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p9okfl7U; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p9okfl7U"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-699c81a261eso123563637b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 21:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723521984; x=1724126784; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKwxKcZkqeeMfXaZWBRGgFNrCXTfi2cZUnlO1Xgga80=;
        b=p9okfl7UANK49ivsoHI2XczU3oZxc1ancZ/B+AAKXMTmw9a1R/ZltwgRErKSYL4iwt
         dlzH0ir4OiV7Bj41MrByBKXqW9Q440It3lHZQSqNWoXzRSiULHiYZmGO1jLFGdLiE4CZ
         Y+tbHhIunyDgRwmsP416yeVQhXTpH+KOjht7Mxv8mlqNM+Q1kcZc9xiqz9t7WSkSs9Mb
         1XuiP/SKvagN5mBqIf9S1QJJLAJvd9zpueGFQ5Wk8182w6m4xRFdCu+QS08bTSltz3hO
         cXqlJb3PqU3rDqHcyU/0P7K+m59NILRpiRJzUAuCtZfCTcnNioiq15+cJGeP6nT4f+4t
         lqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723521984; x=1724126784;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKwxKcZkqeeMfXaZWBRGgFNrCXTfi2cZUnlO1Xgga80=;
        b=Jk6mWfWCWdNntep7dwNAozMRFr6DKl74A886yFVgQ7+y1ezD6BWBrA+vrfJr5tfYNT
         5LWU/w9+U+iM1coPZh4hWBXFW4jI3ZSYWIGUCfeVssD5iGxTdh04l5rtRp7uOum+PJrK
         CXlJ3J72emVU/YvdTXsFZ4BNLjgJTCF3yquff/jp4Le/I1eNG8M8L4rDZlp4Sr2pSf9w
         RQmisR+MbSm83KDILWwBv+WDDh5tBIfAfFkba9DculuCkB1ZFtzeIAf7ZvdkkrXUEzt5
         8XetWVkPSDwgBGtQ70S6HRg+HqKIyiSaoOQFzE47D7fftUycRSd4EgXn/bZ2PoR+/92I
         1UBg==
X-Forwarded-Encrypted: i=1; AJvYcCXzl+WSvd+inYZb3KCu2cjGa89A+OtS/oYSqPZpvG3gsDTe/1aN5NNuI5PX9Q2DJ2sxK6AMK5Gn+RLs2EA7PsBV8oepi2dxZ1+jyrA2MIdTIw==
X-Gm-Message-State: AOJu0YwpkCJuh+3h04webaqRr8coG96iJNQySlCfMs/EsnJEMaEZ7XT6
	RbdLf94M+LAChKoYLOQZpwVeiaGaHHke13Q9Lp6zsXbJNxNXlREUGmF9T9ND8mYcAOPAF+sSlXU
	l7w6lWQ==
X-Google-Smtp-Source: AGHT+IFIcXhCmfpggkMHHGEM3FMuNfVtr00W1dlSBczuTDLPO4/z6gG/iTxgIFLSnngjcay0smyRRbwRKsHK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ae34:31b6:7154:c399])
 (user=irogers job=sendgmr) by 2002:a05:690c:2846:b0:680:cd2b:90ed with SMTP
 id 00721157ae682-6a9722978b8mr571897b3.3.1723521983800; Mon, 12 Aug 2024
 21:06:23 -0700 (PDT)
Date: Mon, 12 Aug 2024 21:06:13 -0700
In-Reply-To: <20240813040613.882075-1-irogers@google.com>
Message-Id: <20240813040613.882075-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813040613.882075-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v1 2/2] perf test annotate: Dump trapping test in trap handler
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Help to better identify the location of test failures but dumping the
failing test in the trap handler.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/annotate.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index b072d9b97387..2ccf4f1d46b6 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf annotate basic tests
 # SPDX-License-Identifier: GPL-2.0
 
@@ -28,6 +28,7 @@ cleanup() {
 }
 
 trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
   cleanup
   exit 1
 }
-- 
2.46.0.76.ge559c4bf1a-goog

