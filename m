Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96208221FBA
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436856; cv=none; b=om1/b6GOlBQMeLPVjcjmlgZHFX+ozkrn1OF7Q75G6N4jDSzX6Sf8SLoxHBvEWIlRRat4d3Bk8qVwRYdWLmk5o+oCRhDrqp+wdUdGJCCgsFdJjGIp8v+tJ6BE+pn+C+dkUo1hB0CFvLfY7auCffWKOG+UAJxC31vf+HoSNtBVJZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436856; c=relaxed/simple;
	bh=t5xyoj8wIHdlPAnXsxGru1L/7ouPIq9H4n+12YXzBfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XGPc434hTnJBF7A3dl8e6TbGkEBbKKiKPhYfBIPUKFLbefAhkJnIbbt4Vx5b9n9WaBOl2betUbqcyIGjnThcIBwTOqYFFAaaZj/yXM5tP1E0wQ9JCFwHNc1qzulGT1dTKVxaHiLr6sepfzFjGyOEmtrXkOI1RNjj4xbTKNm8Cok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbr9SVSP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbr9SVSP"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4c409a09a8so2245255a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436854; x=1757041654; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20U3jn/8wAJzOpL1hveSchRqqYuGX3fi3dVG3vYVRqs=;
        b=cbr9SVSPM71mZrYr+PJm5ncTC5NKQr53jBnNbmz415jNvHDT8+VwlQs31x88EYCd+h
         LHSAC5ql5AcFeVyqvfq+aqbofxQ4EhHqoa5EmG2+SWz8XzAyyXZlSqwzFkC4hwJff6uf
         PjHuS+YY05i08GBSPsrpSRJRAgfOy8zmgX4rvQjsYRj+XUIT7l/+CHpT39zTkvlNytet
         JKFIwPboOfVOXXvCnn9BUeCbFM9JEHGjgIfTJmD4yBPy6B+OVGraJ/du+Y4aORUdlr2U
         YeNLkyR5aAz6Z9vAPdoLux4Bjkz5H3E/e3S1Yz5FCdEPvIUDV/aF6CtKq+LQPEJYi0BY
         3xcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436854; x=1757041654;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20U3jn/8wAJzOpL1hveSchRqqYuGX3fi3dVG3vYVRqs=;
        b=vyo+immnd7TXzN4V8+C9vBtL5TlPm8+0a/fw0dzA0c5Oe0/HC63gtqwZ+EYX/E2McP
         86ggAjqExuLZNMcGPeNJWGTh33urub3XWTlL2s0RZToxzCiax82UcFgHACo5BJAwQwQf
         3Ffk49+ScFUJVdZK7IX4BKNxTJkAumjrt6lIktk17X5Dv/oqtZEUn0jp2JLu3RwihMjt
         dGtiedf2SVculZENheckCnnt0t6g841gxF15DiW3G++5kjYZizNr2CfZZnOHgXtDB6Ys
         Be+xZ5MOltdNTB08yotb/RRWeznD5tPIAeFyx9pwsDNXNrdTwoC3kEd4GqLTmGWeKmtS
         qgQw==
X-Forwarded-Encrypted: i=1; AJvYcCUXmJGhvtKfCr7BnkG42rMnVu1PFbfxGWH0UOVuzmZMLBkroQzGGbWYe910YXiVN4mZzbdZvRxvVTS1SertaPxS@vger.kernel.org
X-Gm-Message-State: AOJu0YxaIydI/m9wQzA5MdK0BB6OfQvYVCKE8jYatPjul0uYo0p77qxb
	eV4C2uh8a3pb2TTR6FgJkUIqaFVJNfFTZoJQ4bRtTXhdFvwBw+Ad0/lLVnJrb9d9anocGZeKmi1
	hFTlELAXpBQ==
X-Google-Smtp-Source: AGHT+IFjxqk31hpFMspKZJBhWcvU3koR0zXOFKwFgSTPECY2WmzRaTFOTjIKkldnRUAUvOddJHXUhArN7+TH
X-Received: from pjbdb15.prod.google.com ([2002:a17:90a:d64f:b0:31f:335d:342d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a128:b0:243:bb99:a100
 with SMTP id adf61e73a8af0-243bb99a3d2mr4303651637.46.1756436853865; Thu, 28
 Aug 2025 20:07:33 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:15 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-2-irogers@google.com>
Subject: [PATCH v5 01/12] perf jevents: Allow multiple metricgroups.json files
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
2.51.0.318.gd7df087d1a-goog

