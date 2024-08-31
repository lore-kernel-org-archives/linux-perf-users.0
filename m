Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F0B170A16
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087875; cv=none; b=LxYRHMe3zXbobDwzQ3Op/8Yo91+oJnQB3B3NxXSdmeTMdc1bd7FxhFd1lcNnqZYb4nLRWMu7KznZTRUH6A6jn1188mK1eDyhixPbGLXVnU25NjciHZGO/NwJAhSn+R7frvcxn20dVRH7vUeiuUGcZM9cUNk1GGC+BqT1O/LJYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087875; c=relaxed/simple;
	bh=5gbFoYoAAv+z9iYcQzJxmKjtjoR9rkjq5SseKmfmyZc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZB3SEjEHI7TkCOPA9r2Jxw1e8rD6P5x2JZ54EOrFiN2nZ7EMHq/wBQZ//gy5jNjWXQSg7XUs/7nNUUQ3p7009LBp4UlVpWxvAB99Lz07mUxE8QeBHVrGjK5pLVaQllrFgO75EmLp7GoDuLZ9DNNuWDhJKf9aeDJeGeCP/PsOfv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piMKGFgF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piMKGFgF"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b8f13f2965so54310057b3.1
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 00:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725087873; x=1725692673; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHNCvvAGAccTwrROKiH6oXmaoTXEGMqssDdptckzxqE=;
        b=piMKGFgFqa9wQ1E5K2F437ur+RkQq/2mcjFbrElaAr9+UTZChhqSBkxRH+bYcm9d8v
         29F7EQQqoahoIsnt13NTdeaBP/zJAUuvjYnJ/uwJXcQOb91+UiBHAs+vP4ssnRq/4lec
         bh+b4jJBSa0n0gT55xnqWWZ2xtYKI97OuDGgKluKa13d3jUwfOsYE23b4VcaJgqXsRUU
         otB40M3VXHoM3eNXEDe5me8hKdh+LQ+sFoYYNBaP8J3Llr7t/5iP5kvSe/9CS6NggNRU
         cxzncTdTltmFDTgJHniTxibEX0ye4NofJSja4onT5av6kI4dKvh8ojS24ev+HebPDse0
         eifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725087873; x=1725692673;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHNCvvAGAccTwrROKiH6oXmaoTXEGMqssDdptckzxqE=;
        b=N4B8gKoXWtT8o+daVs+5mD8J/6Guv9UKhG+mSAxmt6w1uXqiiF6C/Q3h0kdtwowb07
         vsBtMwDZG7ZOxhcJnv9DQVydwD+uHL8mw4MBbr+hYHg4Yiokx7wD/uD9CzscIV4CaNbc
         BjKogefIvueWrmY3at+t1FaFkf6An45OzAZwxrUzT6k4secRkayBNZIPX7nQ7bspEXkb
         JqAsV0EsPlvZrDpi7Y4hMKQjP20M/sX6yiwRli/CXtSIUbyY5SN8wNVw7dnXp1ciXfnD
         OzIrYtJWlWGan4RZQPoZHejiY3N8vOecjuTEAh7qu1EPvqbvYpzTax8Wt70SNZ7mW6Rp
         tyuQ==
X-Forwarded-Encrypted: i=1; AJvYcCURpdrP5BpPzx6kDSzSRp2EVgZBI9btpxu9KyIq+0PiTDjaQ7hr5pU6vK9YGvd2kuSZsfs3wjuXI7Ye11uy/NuB@vger.kernel.org
X-Gm-Message-State: AOJu0YxwQhenvSJsrO1yfKdUJVwboARfn7k0+kvPwgFL6QBQni/Wm5ZI
	xTJ5U3OTRtumSrR6IhhozloE6IlImC5J5f+2ykcnJujD1MBLqzYQ8wiHIB56cPH3+0DlBJl6QCk
	p8nRFfw==
X-Google-Smtp-Source: AGHT+IHP+Q4nMc9YeG5NMkEAMx87MhHBoryoHgfbR7qMaWbgos9SQIWlIWLQeYrfoOeLCo+Z/SO7M3dGHGl5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4974:82ff:2f9:edb6])
 (user=irogers job=sendgmr) by 2002:a05:690c:3386:b0:68e:8de6:618b with SMTP
 id 00721157ae682-6d40d88f6a3mr1853387b3.2.1725087872962; Sat, 31 Aug 2024
 00:04:32 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:04:12 -0700
In-Reply-To: <20240831070415.506194-1-irogers@google.com>
Message-Id: <20240831070415.506194-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831070415.506194-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 3/6] perf test: Skip uprobe test if probe command isn't present
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	David Ahern <dsa@cumulusnetworks.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The probe command is dependent on libelf. Skip the test if the
required probe command isn't present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
index 82bc774a078a..33387c329f92 100755
--- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -4,6 +4,13 @@
 
 set -e
 
+# Skip if there's no probe command.
+if ! perf | grep probe
+then
+        echo "Skip: probe command isn't present"
+        exit 2
+fi
+
 # skip if there's no gcc
 if ! [ -x "$(command -v gcc)" ]; then
         echo "failed: no gcc compiler"
-- 
2.46.0.469.g59c65b2a67-goog

