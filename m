Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493CB215F5C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Feb 2026 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770553382; cv=none; b=d4zwMuDgMLB5rAa2Nyu+4BknY1F8CmTWhop8UsDlWLc8VWpLfGLr6aymGF5OgQlx+kyQCOIhCPXMbfPxfQsM5rVS+Ed6AyfpzqMgiEtTSQ/sb/H5CkdhEtI9fVtaGS8irSeRsM0YYYi607RwxYND+ZjAhQk1aLRYkcoGLr+8XeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770553382; c=relaxed/simple;
	bh=XbfA9v8x+fmW0VeEyiPagNq82ih3Kwc/s7HFCPnEks8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSPBKI/ZK2M0p2+w7sd+Bl1LRcfSG21egUpzGozVkjd8etr8bsh/Qp5ODKRNIPft814fHfpojdneFqUtiOLIlY3gAEXbUQdEr7lhZl+8sN8eqSbrg4mOlQKP9QVf/kwKiwPspWgk0zb6ODixVf3C295/lY+tHnrHHwzuopq/OXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KK6I80dF; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK6I80dF"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so3594792a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Feb 2026 04:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770553381; x=1771158181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdJ+LFs6iV5BA1BoybHwUVJs5lWTeD7cA/e5397Msnk=;
        b=KK6I80dFeljccfZULQX/1BKpRQjV7sQ+KOg5E+acE1Le1OpUU4acY8zIe3eLOL/W4k
         8haB9F/US+MSUmTk/oZaTWrBvSUjhRyiee92c+JZ3XbIQxEkQuWdIBNUdb30gcfd1rwT
         +v+qiP6wJAQyIl4O19kl4wQ8MhgrSO7eOWgukmUTYtOuDkxHNPFQymCrZE4KadG3l9Eo
         Cy0oIY7huib0e9wpTXhpt1yH/X4CMNmKmB0fhC1bf/WRDOJ+yuTP5wXbpiy5FmiLQWX1
         uKVhIkbr5hdDv4WPU7hhjCeGzFCT9IjJ1/E2gwvDPrYRbDKR6VxY/rlNEqaw1Dz6ORrV
         MxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770553381; x=1771158181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vdJ+LFs6iV5BA1BoybHwUVJs5lWTeD7cA/e5397Msnk=;
        b=GLvKRv+7t4+rEn70n3Mxd1DAVGspYm0NEo73ki8PZbE0xRFxv1LNqr4dCeE1E78GFd
         7jWZIgTdF9VeZ8aRtwdb5j5b0Xhxi2H23rUwmX8UrEC5kQoZRC5US9p5wR+v0Lno4v4n
         J0g3HbVqOZ+LW3nu/zQqVm927MNr/yJp8fsVKQ30LjahSRTAvVuIaVxiHSYmUXwRpyRR
         vCyp5DlP2iG4Hq3n9hCIJsUAj1pFejfFXKEFi69WNAGHMZOhFrplG5eMkkk08ScM8H35
         mRexA3Z3fx1T9o7I7Y94v+0ZhjQ/2AVnSju+HsuOi6OwSCP583IC47/MUl7SRQe0MxBP
         aASg==
X-Gm-Message-State: AOJu0YySXxP3OY2bu/SOL7zj41mvYaodgHFv4qrsU1Fn9i3z8YEUDHW6
	iOgellk2GHbpuxLys5K7gEOMgE2xnXmL42SRzFmbOc5tYmGNhfsOlMfiJHWuQA==
X-Gm-Gg: AZuq6aLeyizl6pYovfp4WvJxLcdOqogUppdi+03/pVqq8LrkletUmfUbQmf/P+0PtuH
	nFGfrFmOe5Eti+5BJR9JkempyKQIixQ4xDqADmEhy9thFmplEH/U7qAf3oZYd6A5X2fCBQJeD/r
	s8tK5u3gInKSRfXGqG6FeZARuwq9rQ8swyuddWsK4JCxRrZDS4by++0mzrA3OTZffkrfw6T94wT
	UQCYn4B+EQq2YAFcK47YA2lTcLC1H4hCrpGiGoNO4bUvxaurMbrTGe4sd0CHOckyVmt/zLDlfFW
	63OZgjN7Hj6DYK70IZfF/sJT39kT5hynabaSa4y8wK8FjEu1NOE6QdDe2yIb4R9kz64jf7KKaZk
	S4m2rfirMMc1rq/DX+Zet0eq4eQmYMWqY44fzYNWqMSqn3JBSr9GC2QIh1IaZBX3KxxukIOFtaL
	hEcu5g0Otrnf+4XBeG/bxu6CMfrjmgKOjI+XUT+a9ApuLACtguWobCF6Timv+6HKvjQnf9c0WZ8
	sdo11gWh0K2qByjVJk=
X-Received: by 2002:a05:6402:2790:b0:659:3d80:356c with SMTP id 4fb4d7f45d1cf-659841647a6mr4047003a12.22.1770553380348;
        Sun, 08 Feb 2026 04:23:00 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.local (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65984024e11sm2011658a12.32.2026.02.08.04.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 04:22:58 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH v2 3/4] perf tests: Test annotate with data type profiling and rust
Date: Sun,  8 Feb 2026 13:22:25 +0100
Message-ID: <20260208122227.3524-4-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260208122227.3524-1-9erthalion6@gmail.com>
References: <20260208122227.3524-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise the annotate command with data type profiling feature on the
rust runtime. For that add a new shell test, which will profile the
code_with_type workload, then annotate the result expecting to see some
data structures from the rust code.

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/perf/tests/shell/data_type_profiling.sh | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 tools/perf/tests/shell/data_type_profiling.sh

diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
new file mode 100755
index 00000000000..cdc9adb7d70
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_profiling.sh
@@ -0,0 +1,69 @@
+#!/bin/bash
+# perf data type profiling tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# The logic below follows the same line as the annotate test, but looks for a
+# data type profiling manifestation
+testtype="# data-type: struct Buf"
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
+testprog="perf test -w code_with_type"
+
+cleanup() {
+  rm -rf "${perfdata}" "${perfout}"
+  rm -rf "${perfdata}".old
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+test_basic_annotate() {
+  mode=$1
+  echo "${mode} perf annotate test"
+  if [ "x${mode}" == "xBasic" ]
+  then
+    perf mem record -o "${perfdata}" ${testprog} 2> /dev/null
+  else
+    perf mem record -o - ${testprog} 2> /dev/null > "${perfdata}"
+  fi
+  if [ "x$?" != "x0" ]
+  then
+    echo "${mode} annotate [Failed: perf record]"
+    err=1
+    return
+  fi
+
+  # Generate the annotated output file
+  if [ "x${mode}" == "xBasic" ]
+  then
+    perf annotate --code-with-type -i "${perfdata}" --stdio --percent-limit 1 2> /dev/null > "${perfout}"
+  else
+    perf annotate --code-with-type -i - --stdio 2> /dev/null --percent-limit 1 < "${perfdata}" > "${perfout}"
+  fi
+
+  # check if it has the target data type
+  if ! grep -q "${testtype}" "${perfout}"
+  then
+    echo "${mode} annotate [Failed: missing target data type]"
+    cat "${perfout}"
+    err=1
+    return
+  fi
+  echo "${mode} annotate test [Success]"
+}
+
+test_basic_annotate Basic
+test_basic_annotate Pipe
+
+cleanup
+exit $err
-- 
2.52.0

