Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE611836EB
	for <linux-perf-users@vger.kernel.org>; Thu,  2 May 2024 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685716; cv=none; b=jU8ruVVxvs7qMnafnZLhB3Ga42IcbCmfoo1pGDcKaCm/saIcXFgdsrpqxMAvfZiR6tps0nXOr/FcM0qGlmWFMf9T/u9M4vc9M+1kj/HRDbaj4L9F2KjIueI5fwt+KPP+9y98PDUHRrySJWE6OGUC+2oVfQv8j/z83g0NdM+96y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685716; c=relaxed/simple;
	bh=+iC8656RV+1z9SNt/rVmkZ8TfblJJXHmOmw6MoV2AOA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=UB5QuwhqByJwFvhS6VCUR5661pXAjv973BTAWVouv+EvYnIK0TiEt3lIV7N+PmZLi6sNYyWHNva0q3BAS4LQ3IxIZ/JA0tok3aoEJLbFtVr+8FAiGpYNYVS5Ur4/1rGL9ygvOdZgJXZoaAGorfy8RCBKwtGW2Jt/mRTdvBwSlZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YKmUWmoh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YKmUWmoh"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bea0c36bbso71566907b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 02 May 2024 14:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714685714; x=1715290514; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zgV4xf5fQxiR7aZHDngtpEH48nFcBFO3YN7qW93R/WY=;
        b=YKmUWmohHCI3nJNqF0x0QwKfeyQLFnr3qoAF3UJwHEcseRz57D1mJvvfgXq86Ob1HM
         q4vP+URgT99hwigCINta0rPI4elFwXbp5HU6Pdbv6qlYxGbH7xA+fzAREWVM9bhJmocC
         iuQ1FKbVzV3P7Dqcy/wt25N4cJHGQ7SNWgUYj7IlKus2uyHWGMbfVfWEn9cDMWgzMKUn
         AGuxGXtrDjT5JTQqTyC0EnhDVqY6Y6FSsF+4nAA2kfl0gFfvTDu+OtMcjGd/7wsM53Yv
         fAPnF1EaXEOZl5RILKLoSn4tkmEV1IWlqw6U0EKz0z6HNwhEtzST1Th4euXyOmURNGcK
         DTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685714; x=1715290514;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgV4xf5fQxiR7aZHDngtpEH48nFcBFO3YN7qW93R/WY=;
        b=cDJpx4gmV1y1te7nFhPAePliN0sRLoD13VMdV3tn67ZwBOeTu/osX8RRaJY7Rbqt4l
         sRktYV1wYZhiqgNvwb8+PQucLQMsxbh/DO1op7b1Zs3HIjrdnyBp6VEdBu+Uisp34F5W
         TEddeKvdjIAoaY6NKNgLULWJ3sn0Kdh0Ievo/xiIpVmzDvSVVgVRkkfMKESfLsSVN5lU
         mXeobTxOPAaz1P0GcaYBkT5OlwKcTuQ+9Rd0B7NNve4ljrZxGH3BlrSZ/eSdtP25cbPM
         ED8nNB1UfyfQBsqta8NkqiGff/tjGfr/0I9Zw1lW4AlW8C6kMvYQcUwdWkUVHyCsPBst
         NfWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuxlj8zge7a96OY/F2piej9bWRkpod50FqoAUCertfEAwLNDCCQj1A4qohIbHm2FNtb36TiFjrL4Xo6x6WOEjhhAJqxgmB0N0cFOXJWEfsRg==
X-Gm-Message-State: AOJu0YwZ/7aY5pnfmytRph5pNhdswxyS3caxqZypjiXm8rqB1re8SV+d
	RTHCqcb8/p7kEoyzlgz0bYLDTOVRFT0rByOtej8S7Nx8J3ifXG/D/u+Q5SBaUehEiJXoxf0dnwI
	Z9MzHDA==
X-Google-Smtp-Source: AGHT+IEXj+L7mG/mFxFwq34rU15M9trIcDqflnvzeDMxWFJfivTAbhdOHNL6yQyts7hcKK3NVMlyQZ6Ci0F9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:deba:378d:2d3a:2641])
 (user=irogers job=sendgmr) by 2002:a05:6902:1007:b0:dc6:d233:ffdd with SMTP
 id w7-20020a056902100700b00dc6d233ffddmr322304ybt.0.1714685714546; Thu, 02
 May 2024 14:35:14 -0700 (PDT)
Date: Thu,  2 May 2024 14:35:03 -0700
In-Reply-To: <20240502213507.2339733-1-irogers@google.com>
Message-Id: <20240502213507.2339733-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502213507.2339733-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v5 2/6] perf Document: Sysfs event names must be lower or
 upper case
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

To avoid directory scans in perf it is going to be assumed that sysfs
event names are either lower or upper case.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 .../ABI/testing/sysfs-bus-event_source-devices-events       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 77de58d03822..e7efeab2ee83 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -37,6 +37,12 @@ Description:	Per-pmu performance monitoring events specific to the running syste
 		performance monitoring event supported by the <pmu>. The name
 		of the file is the name of the event.
 
+		As performance monitoring event names are case
+		insensitive in the perf tool, the perf tool only looks
+		for lower or upper case event names in sysfs to avoid
+		scanning the directory. It is therefore required the
+		name of the event here is either lower or upper case.
+
 		File contents:
 
 			<term>[=<value>][,<term>[=<value>]]...
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

