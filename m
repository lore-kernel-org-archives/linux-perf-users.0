Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MmthDo4G"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF221A4
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 08:49:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db54e86b2d1so3769602276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Dec 2023 08:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701794969; x=1702399769; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=il/zOOk1ULaSp4c3ZKjwASqI7JmWGklotUwSmWlNxts=;
        b=MmthDo4GyoBmUhvDHGw72G01MDqlIvODa/hQIJaBYO9hgqqG53xzEtqM7gWzDs8U4N
         VdXtcO7F5Bm4sWPPbsXjwi85nRkOqiy4X7W5o4hXuksGEWZvuab5ApIi0lg3dllLzM3y
         /pFJ0yFA6vcJldgWu8d/Er50IQWisih7fMxW04E1+gA6tr9Dz6wRbfX7auCF1L+P5rWL
         ArWdVjJA1EfOlHQ/r8DQ/Zq/QFwvnQFOt9ROehJpW0P9D3dw0kSzhY6b/dwUYb62jQGj
         rLG/dcxCrKSO9vUodXOiOjhR1KdWQIlK5SeNWFSIbLMYlOUChqL3m1z24CEEM8/gI1jQ
         QF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701794969; x=1702399769;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=il/zOOk1ULaSp4c3ZKjwASqI7JmWGklotUwSmWlNxts=;
        b=N+V9GeWf1VMHtOiaqTfGj6Et103xKrqzyGl2XxR7YYpomhqSer8kIZAP5E099Ewgep
         5Ij5oogs3LU1tvGcp6o5/YXKDaLKuXJbV6tFCCIxM042kRQwWE5ohpf0CFbSWJEyZcnK
         VT/bHTUYrR7sT4cz32Ap+QFGor2rgWXqTu6Xj00MDOzQzP+5045vIbFiXNPsk/hwYe64
         MvETskx5K8XcjyF7jSkgKlJGbVViR42AxvkHRzK9Dijnmwp3ZlW3GfWrG1cmemVzuCph
         M4YCRLeZWHKIemG9UoLWgoZOxiEMjWncBWEaI5G+wxuMkSSVZnJ3nbdk2LU9jizCZRLX
         AZIg==
X-Gm-Message-State: AOJu0Yy+urlbeAsYBo4/444WWLlJzb36UUjpXjFint0P01xBpJG3XQQl
	fZB6ogcdZDjMlTYGTREjPgk4qG1TQlEL
X-Google-Smtp-Source: AGHT+IGoDtCBJ0f3p67GriPcyTyEC/v0B8VEJ3bmRMBIBhC7lrA/02mGuUcOOfRJOYzn2EGGrDTf4e+ilDDN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:48b6:2578:1ca7:5287])
 (user=irogers job=sendgmr) by 2002:a05:6902:51:b0:da3:b467:af07 with SMTP id
 m17-20020a056902005100b00da3b467af07mr60835ybh.2.1701794969538; Tue, 05 Dec
 2023 08:49:29 -0800 (PST)
Date: Tue,  5 Dec 2023 08:49:24 -0800
Message-Id: <20231205164924.835682-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1] perf test: Skip diff test if test_loop is missing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The diff test depends on finding the symbol test_loop in perf and will
fail if perf has been stripped and no debug object is available. In
that case, skip the test instead.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/diff.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/tests/shell/diff.sh b/tools/perf/tests/shell/diff.sh
index 213185763688..14b87af88703 100755
--- a/tools/perf/tests/shell/diff.sh
+++ b/tools/perf/tests/shell/diff.sh
@@ -9,8 +9,15 @@ perfdata1=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 perfdata2=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 perfdata3=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 testprog="perf test -w thloop"
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/perf_has_symbol.sh
+. "${shelldir}"/lib/perf_has_symbol.sh
+
 testsym="test_loop"
 
+skip_test_missing_symbol ${testsym}
+
 cleanup() {
   rm -rf "${perfdata1}"
   rm -rf "${perfdata1}".old
-- 
2.43.0.rc2.451.g8631bc7472-goog

