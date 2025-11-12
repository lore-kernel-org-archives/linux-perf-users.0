Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEE92C08AF
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977201; cv=none; b=sHf/E3g5nCaTx5ZKvrtIlALvesazJrmaJDCJ/ujC+iTiblv7ajiKJ6F+maLJxKWYZMrE4YNWU2j+42K3Is3xqHjB15WjR/p/BGyfdQ3XAQ548GjY7vxqBRNayaj3Z8VLvr5p0lIn7sCnGbKpCv+qFxRpKhcR1sgYu7KMWAj3JW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977201; c=relaxed/simple;
	bh=w4mXTwIUioCEf3aLDXcvRdVOG3IPPERu6LaKLIbBAuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YsV/e3FmnXFdDJU5xitKC7/oWwFzVevbfZXK8YYTMzrSqKVmKimsPRLj95LUSwYVSk7bCeZWa3ntHOq/P1Vqa4a00cHn8AOLEBKjMWQpyNiVyN/bo1W1efUNrPTJWT8dKpGt1Y4qCzpy0hv4C4FI0FL2+nQ7EKCJcmOty/g53zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vzAxCyBP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzAxCyBP"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34188ba5990so105441a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 11:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762977200; x=1763582000; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOuSUBzWe69YA4hvkhtZgT3oWHyjTIb2wmtwYv6DBRI=;
        b=vzAxCyBPzRnyIRaauU/fx86vo4gYt+70bb+iB9XG1wi1zlMKTNbupZ/JciE4LSVL+i
         p12SgE2IkNlEyOYWKjBoLKg1A662vf359UJ8HGWH5+1szvFuNcThuo4HZ34FJSWgF4CJ
         YND+pcpzjBiHldyV0gywxg5qV+bcox2eeB4ufIhazzf01r5/+xBC2T1pJobhfaYtEjv8
         9vhlaVeZkcGZwWHmgPkscSk5EEa/Sxvvhkr+hxwq7lGutC7JUvUx1Bu1TuVgLLJPPOYU
         iuih4kzjpYVdExWqW9G/7SQ/0CLlldS5JdnP+OKZx1LnhIeUrp4qxRUuo/R4y9NTFdJM
         ZSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762977200; x=1763582000;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOuSUBzWe69YA4hvkhtZgT3oWHyjTIb2wmtwYv6DBRI=;
        b=Ny0bJ0a6nk2ZG15bZfRWhlwn/eAJ2vfs5++YNWpKUuLMMEYOyLRlJRosJIIY1pGJh8
         w8eWDNWPCt5C7HqiTr3eVtpxwVa90ugRL0xwW0EzWNgiQzhX/7lvS+uFbMafcIzKyYXc
         SqZWKZgOocioQe9WSqazESv2J6EOGHAzaF+eM3F8soqeJ9KASnPrsJnmFQeVW1uNHftK
         lUT8UMJXq3IdIXP6RJCW0/AsrXd0kA4oORu3aL4ypA47g9TtduQO76wxtvDgEcZ2Kytp
         nSmzukzzzQ1q3e5+OnwkfuAbd5DscX3JBAJFHqRpDhuwWbsWWutJUgJUoZyIfUYMUWQ9
         fkWw==
X-Forwarded-Encrypted: i=1; AJvYcCWVU1Zwh1c/thvyEH0AvxpHx1K9S8NcBp4hv6ed0KyBqh7cFvbi4NmEM+HnoVFIE4VdAE5F43nzZ9E+zOqf/h0l@vger.kernel.org
X-Gm-Message-State: AOJu0YzDRQIgheSwdF3mCPI8cvjfdWkAhepL8fIYQyzSCE02vCzP2F4t
	sYTvY8hXVN5OMfFZVgd166LePkRSabIVe0gqXPodcl7jPgFvJYadSI9KIxhgqaU5i6naBRPQ2o6
	O8+2hE9paOQ==
X-Google-Smtp-Source: AGHT+IEtfQ4Sqv4rc5xvV8ORzN3/URZ7AozB19pmumlIecktr+wJTuUJm0/zwgHJS4tdicZktfBpuuvUUUKu
X-Received: from dlbqd14.prod.google.com ([2002:a05:7023:b0e:b0:119:78ff:fe0e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dace:b0:297:d777:a2d4
 with SMTP id d9443c01a7336-2984ede0342mr58377285ad.46.1762977199650; Wed, 12
 Nov 2025 11:53:19 -0800 (PST)
Date: Wed, 12 Nov 2025 11:53:08 -0800
In-Reply-To: <20251112195311.1673981-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112195311.1673981-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112195311.1673981-2-irogers@google.com>
Subject: [PATCH v2 1/4] perf test: Be tolerant of missing json metric none value
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

print_metric_only_json and print_metric_end in stat-display.c may
create a metric value of "none" which fails validation as isfloat. Add
a helper to properly validate metric numeric values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/perf_json_output_lint.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index 1369baaa0361..dafbde56cc76 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -43,6 +43,9 @@ def isint(num):
 def is_counter_value(num):
   return isfloat(num) or num == '<not counted>' or num == '<not supported>'
 
+def is_metric_value(num):
+  return isfloat(num) or num == 'none'
+
 def check_json_output(expected_items):
   checks = {
       'counters': lambda x: isfloat(x),
@@ -57,7 +60,7 @@ def check_json_output(expected_items):
       'event-runtime': lambda x: isfloat(x),
       'interval': lambda x: isfloat(x),
       'metric-unit': lambda x: True,
-      'metric-value': lambda x: isfloat(x),
+      'metric-value': lambda x: is_metric_value(x),
       'metric-threshold': lambda x: x in ['unknown', 'good', 'less good', 'nearly bad', 'bad'],
       'metricgroup': lambda x: True,
       'node': lambda x: True,
-- 
2.51.2.1041.gc1ab5b90ca-goog

