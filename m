Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971472D0292
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697917; cv=none; b=e95KjKKuqBxroNXx3jCLeSL3BdnSBpakPblkit/XmXDKmjaak8PMYCoeU8cXYmTaf6HkPiAag9mUJJGBXsv6M/XaCsoApxYzNCf7DdSM4tCHpoAL4cY0UGG+rKnYYv7MUdA+LFj/lUMittAjQ3MrjoorELKor2lfKY0YV8llCc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697917; c=relaxed/simple;
	bh=9rsT8ncoWqyJyQ7nwr+E7hBrtYBywRQ32oouuk6dvU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TWijLkMwIZLyhqgtZIAmR/GTwqFQz3g7GkybEMySnYz39h1elpm/H1dxKAbrlR00Uf/FIUaME2AvxfUOtvri+1+0KzLE8rxm1wO9kbDQCkJIAEztqgU6+stzDvgFtBvmdaCm0h5gvrtimc8JHqXcn4K6LClb5qrhCUzigSOCtds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wy+qeRmU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wy+qeRmU"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b609c0f6522so8942114a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697916; x=1765302716; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=chffPpIGVoN2jtkWf66gf8jxJ2q6txF/MGepK7+1bz4=;
        b=Wy+qeRmUNdVLHWMVRKP89QMjbL26ASN4KUpdpGP9fu3J+yAnS3EtTOuNpxYcuq/9kR
         aXDu0+7eve27yy1tPqrFSbCidcjL6kIzl1jVCSx9INMEztmkpEXKRphsHjeowqjKV1bo
         M2N0HHX0WLWhXpErnmTpB8Jj8i9mwbjafTZNcsLhikBpcvtsNS22jHgVNPpYT5QimSHj
         nd0dqXydJ99BzJNc+BENxFCYw6oI6jzRQDeL7kKSUvOlTbcHt6bxUAKqE+fWhfyX+tpD
         ZUPMCebzeD2ALk+5LunJ3w75cM6p5dVXgyMnlb2N+BxtPMIDWI2ZKhOWdpSEu+XCDHkL
         fYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697916; x=1765302716;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chffPpIGVoN2jtkWf66gf8jxJ2q6txF/MGepK7+1bz4=;
        b=vEL6PvKSGm52dY3dPdtaz+zQJdRwClBBsuxFU1ga+/x+LWwmKKhrwXfiMOqoRjkSGO
         cA4NVEjbvpNw7FEvbRxA7l1q51SP4Fdzsl5lKlxmQ5x9MPpt0taKA6hU+fJoSGb7kyOT
         Jq/aNyYS9W0+Qx0UBNNS0NfrfpIdbPnkgJiajOO2DYsanrv9rm1mGZhUwtUo93g27I+G
         kirAiS8gtxt7+TpOWm11BTfVAPR/fLpQUi3P34gYExMKh7vni+XQhiVTUoburTqh+v/n
         ZjK9HFfjO5W6etDkHIRSmZpH7GXmbOgCQweZtzde+CpR1HMSBq1O+4eJ3zUICFzUMlyi
         vfcA==
X-Forwarded-Encrypted: i=1; AJvYcCU9zLJsHGoeN+b/1PGwdkNP0tQDmWdIuAJYgNTlHkk1OkSKavxstv0bPD7lKw1bdHNsqljioX2iu/W9VPhzYgO2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw960HJb5UkqfdIemrHiQxbLiVq8b0p/LeZwiYg9ramRlsPmROq
	gdNR7iFWjhSvfTyhVfJ2Po6RroPgmHwc6YeT5kjfc5W+QSCyCcv7zbesHCoJSlCBp6VnX83VQyO
	ZYYp3YGjqeA==
X-Google-Smtp-Source: AGHT+IGZbE0tHHNZ5KQzidjw1HssP4aJnIt2qxPmCEqD/zPS9eZSJWVQh8N5FRoj7mRUatF92kp8yZGviBzn
X-Received: from dlbdm15.prod.google.com ([2002:a05:7022:6b8f:b0:119:49ca:6ba8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b96:b0:119:e569:f611
 with SMTP id a92af1059eb24-11defc9e5fdmr183254c88.10.1764697915672; Tue, 02
 Dec 2025 09:51:55 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:06 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-12-irogers@google.com>
Subject: [PATCH v9 11/48] perf jevents: Drop duplicate pending metrics
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drop adding a pending metric if there is an existing one. Ensure the
PMUs differ for hybrid systems.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/jevents.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 03f5ad262eb5..3a1bcdcdc685 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -501,7 +501,8 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   for e in read_json_events(item.path, topic):
     if e.name:
       _pending_events.append(e)
-    if e.metric_name:
+    if e.metric_name and not any(e.metric_name == x.metric_name and
+                                 e.pmu == x.pmu for x in _pending_metrics):
       _pending_metrics.append(e)
 
 
-- 
2.52.0.158.g65b55ccf14-goog

