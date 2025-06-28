Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A60130A54
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 01:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751074549; cv=none; b=SzD+Meq8geuTyEtqRIMaFvW4O+ONwmC0SsdDxjXy15knRWMx7PHnT+EKOzVN52TySUH75acZN72dLYTnYI2Ncyf9GBkC6fOF5AOjXn0t+5ja0aHpaZmgiYyAuFsNkrPPaj8OR4JRG0uqK4VgSE5klIeBiM75M7AMrazj0k+vxOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751074549; c=relaxed/simple;
	bh=xp6QooYSKJIO1Ri906XmGIWsfQAQKsjdb0xfOXssMf0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Q9HuIBrAbWwnF6BJL99se78NUJ1I5B6EmAph0gspOdoJnl+c3h0AHoJLM8uFzazsupQvn2MNSK1mel+y7Ec/Fb5cFIzRRPn1SVhSZswqEDj2QqOfsgt5H1p+zV6+YqTRtQh2kU0FhUYtaQZ+4Dfx5r0sF7jqFAIy8+q2acfACFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xdVMkFzd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xdVMkFzd"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235e3f93687so2656215ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 18:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751074547; x=1751679347; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R9h8FoTQNuVI8eMmwBP37Z8kyCmEZSw8NGWBhTujA80=;
        b=xdVMkFzdpFqOfJQjtFVgzLGhPxgaCy+UyVNi0kyxvmPLB6ZJjsGkerDbgcN+xryGX1
         UmNbttmKdqNcW1kkzTAqESqhvO9Y7wVe+PzLlJdUftgGsjSd0Fz4KRlPz6PX+YOgLZSY
         ZOhsLhq4Uhioa7mogaBsEjomYfYZjvHVkWUvSUs7cSTyq5ShZzToO3Ctn37bYNpaTTVN
         1eClON703uXnFuyTms2z8oeYeayV9lul6vc/ok1egSGin8RiR72Mt6yMyvp+HQE9plZZ
         EB9g/8xg7lXllhuQw2YIKBrjrK37rVF2L7LR/75SaJAcbpdeCWQttBMwDJTDzoyBmSKz
         WVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751074547; x=1751679347;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9h8FoTQNuVI8eMmwBP37Z8kyCmEZSw8NGWBhTujA80=;
        b=CfOc1pYCnIJozRCo2Yo3pOuIL+lZZo8YVuA0ByDetBSWh+su4kzZ4jtlO1w3xpSAsf
         NJhrwZ/SsqeJDk6jXrpUhaAxT4l3Ka+N9S+jrtzoQLxn84VrDr6V4aqIAkMfLE/4lWtr
         IN63hmXr2KwOYT3W8ljWnDOfxUCSHMex7ul3HT7FP4C9CCaD4lTNwpD6027Y43qsscWR
         uMhZxQ1mc7w0NSCBU4W81ib8AR1ZT+THqXLcAqOmr/HjEg3KTNrjBf/QzcwLckHeKQ4p
         OSdvaRjMp/puOetgPHp5mtJk620NOmhnejXWdM8Dl88OL6A31soddwApu/YAHOZjm4Q0
         mQZA==
X-Forwarded-Encrypted: i=1; AJvYcCWf8cK0ZDZmX8KChIF+24YDWDqN44D+hHFgCtDDEUetEQqGU5xZT7C1K4uuL/gXwa95tWuLHKLfm7tO8MZsDNEM@vger.kernel.org
X-Gm-Message-State: AOJu0YwZoITpan/aA/H3lFHKtgrvxj7FnkJK3Bm10ksVsBaz6bDTiRKd
	T/Ejc6k8YA66Y1j5fpGZUWkxXcrNKgyxnEUNzGzripkojmpTNNXTE89hbmbJo27ux1lfL/fu/H0
	YflF70bBh5Q==
X-Google-Smtp-Source: AGHT+IFd92Gn7WZNkqbN9k4RxtUPFZQe9Qxn220MNduLvj81BEx2Pr2j7bq1bV6C1FyTLi1nNpfqzVoS6gQU
X-Received: from plle5.prod.google.com ([2002:a17:903:1665:b0:237:d76c:a11a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce86:b0:235:15f3:ef16
 with SMTP id d9443c01a7336-23ac3deb433mr84311265ad.13.1751074547429; Fri, 27
 Jun 2025 18:35:47 -0700 (PDT)
Date: Fri, 27 Jun 2025 18:35:43 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628013543.1250435-1-irogers@google.com>
Subject: [PATCH v1] perf test: Add basic callgraph test to record testing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Give some basic perf record callgraph coverage.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Pick up s390's needed "--call-graph dwarf" as spotted by James
    Clark <james.clark@linaro.org>.
---
 tools/perf/tests/shell/record.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 2022a4f739be..b1ad24fb3b33 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -12,8 +12,10 @@ shelldir=$(dirname "$0")
 . "${shelldir}"/lib/perf_has_symbol.sh
 
 testsym="test_loop"
+testsym2="brstack"
 
 skip_test_missing_symbol ${testsym}
+skip_test_missing_symbol ${testsym2}
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
@@ -359,6 +361,33 @@ test_precise_max() {
   fi
 }
 
+test_callgraph() {
+  echo "Callgraph test"
+
+  case $(uname -m)
+  in s390x)
+       cmd_flags="--call-graph dwarf -e cpu-clock";;
+     *)
+       cmd_flags="-g";;
+  esac
+
+  if ! perf record -o "${perfdata}" $cmd_flags perf test -w brstack
+  then
+    echo "Callgraph test [Failed missing output]"
+    err=1
+    return
+  fi
+
+  if ! perf report -i "${perfdata}" 2>&1 | grep "${testsym2}"
+  then
+    echo "Callgraph test [Failed missing symbol]"
+    err=1
+    return
+  fi
+
+  echo "Callgraph test [Success]"
+}
+
 # raise the limit of file descriptors to minimum
 if [[ $default_fd_limit -lt $min_fd_limit ]]; then
        ulimit -Sn $min_fd_limit
@@ -374,6 +403,7 @@ test_uid
 test_leader_sampling
 test_topdown_leader_sampling
 test_precise_max
+test_callgraph
 
 # restore the default value
 ulimit -Sn $default_fd_limit
-- 
2.50.0.727.gbf7dc18ff4-goog

