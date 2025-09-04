Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE827E107
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960335; cv=none; b=tCFxvpRsOc9jbKq/owC/aPu5iU4iRtUCJjNgcMlEnE37AjIJn1+n5Y/um8/UULVJxg5hOeKhzcrMygvQ6j5tg+QkxWv3DJt7PzXawx6vvhL9jlTAyHkhjXHyKzXhFCthL32I/YUW89K0gkQW3ltsyPyVvdIXd2f36meq3w3aB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960335; c=relaxed/simple;
	bh=B9mHzIhfhAcdWo7nQHHvHZn4fthTHV8+8EhrmlUHhAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bvh1h9DZkAcl2Nib1Nu3KOER8FP6GBM3159VemMmbkFk2ETogkNMVNuM57TXfr1IKuEUfwbCwHCh4OSJWgn1eJPRMjwlxacMo4K3NVrGmJMLtkb4vSWN6VPqXOdRGBdWq9OJnwPIe9gQDcxNI1/ToPGopBQP/GpiZo0Tmwsr74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3A041FuN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3A041FuN"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24b4aa90c20so8346585ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960334; x=1757565134; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+GNxDn1hJSLin2tsB/qhtwhct2wgEUy65xdgFGp/uQE=;
        b=3A041FuNjaROZ8V+JEbjoHulBfVcbaiJdgDVGRB0O0V2goHYE8Z+TbhQsjZEx/IOaU
         R5i/xDt9a47Yni+T1YCVDUVfX9SpSXVrancc/Ku5t09522wIIFRd0IZy/g0gJmwQ4l5t
         KGXoxuR2gbuRYVDAG1dNLuqW8ffCDW0q29RojGROi+vzQOjfFdFmVbNtv7SFoeGBthN9
         KzH/hp2efTZMNMux10VEUpy0Kq3nApzI7/3YpazhgTLmQeeVHJKEbcq0BwiObaJES14N
         EAC8i1CGMJH7cmtAO6o0XJg0rZyriDLK7IJoSHTws7D+rY0la82zqooWaC/BnxygxnkK
         Ec4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960334; x=1757565134;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GNxDn1hJSLin2tsB/qhtwhct2wgEUy65xdgFGp/uQE=;
        b=upTOJpMkhPD6IlWOosxMKp48b2AlKQoCQnKQnkVO3exM0prIuezy/eR7luee/P8dao
         P3iddwnRCqX9CYf+lsSMpa6fqCuApsHWrAXHXFvdu87hrxd8mEhEZ4z3phoWRDVbfJ2N
         FPSSzvGQZ4piU0y60LkqU92uyd9w1xGeMzohuueheN+UJwmGR/13QVLbm97l+JqyJQnE
         rMworBE7jCTF55oLkHmxd6t8ji2Ihhfn1wpY/5nBQHWj1Otu5SHIY6vopQw5aFeiy6xQ
         gZbrL3S0sFseW40NSE1gAE/3k/H/DFphDgNkiAi73mInzNKmJ8/FPZDriKZWpWbcVQzx
         RSoA==
X-Forwarded-Encrypted: i=1; AJvYcCXze8dAjx6QjCv0m+4gik5H+KLW+dtIdsP74wXQDqpuL7hwuwaeg8vgNx6MV5dk/UPAbN/83/D9qrpSJMZM+bQu@vger.kernel.org
X-Gm-Message-State: AOJu0YxMf9F2EbxeA9ouH2pfYxbo2QOfw0tSPHQ7vBf2DX7CKKewaVit
	xprAkL6IYriTBwI4dISQRtSpKxASB56okDWLSiqPd07bVrNQWww7siBYMcjNtNRaQ7ZKl8xjUP0
	vaDOhOW+qPw==
X-Google-Smtp-Source: AGHT+IEcUJQmMLlPKbWysCmhZb7EhIQjj5QYlH7tlUVAI0ZtsMpLePIj+gdD+aXuIDG2RNxhKtgWcKpKIDQ0
X-Received: from plhz7.prod.google.com ([2002:a17:902:d9c7:b0:24c:af07:f077])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8c:b0:249:3eec:15bb
 with SMTP id d9443c01a7336-249448e1ce7mr208010235ad.14.1756960333846; Wed, 03
 Sep 2025 21:32:13 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:31:56 -0700
In-Reply-To: <20250904043208.995243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904043208.995243-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-2-irogers@google.com>
Subject: [PATCH v6 01/12] perf jevents: Allow multiple metricgroups.json files
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Allow multiple metricgroups.json files by handling any file ending
with metricgroups.json as a metricgroups file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index c896108ee4cf..69aec4661a13 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -637,7 +637,7 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if not item.is_file() or not item.name.endswith('.json'):
     return
 
-  if item.name == 'metricgroups.json':
+  if item.name.endswith('metricgroups.json'):
     metricgroup_descriptions = json.load(open(item.path))
     for mgroup in metricgroup_descriptions:
       assert len(mgroup) > 1, parents
@@ -690,7 +690,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
   # Ignore other directories. If the file name does not have a .json
   # extension, ignore it. It could be a readme.txt for instance.
-  if not item.is_file() or not item.name.endswith('.json') or item.name == 'metricgroups.json':
+  if not item.is_file() or not item.name.endswith('.json') or item.name.endswith('metricgroups.json'):
     return
 
   add_events_table_entries(item, get_topic(item.name))
-- 
2.51.0.338.gd7d06c2dae-goog

