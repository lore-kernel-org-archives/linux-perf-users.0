Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9891F749C
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 00:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950528; cv=none; b=Gnaxmd5CHJaahKX/f0LHznSJtgNUrUBjrbAYzozdriADZ8pV1husVpAp6YaqafOiR7TZ34HO3NEODAA4QG9gkVvaD2PB05qf6FWo/h3B+G6PsDjDTQuZCXyE3/qG2UERW549V5JKjH0/X+lsiuTD3dtabt6ZMgxizyY9HZ8M6JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950528; c=relaxed/simple;
	bh=8NLROw6KKSFllbopuuSL8swQth3r2BSa+1UDDDHl3pw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PwBKvEmGhuleN03DmMe0J8DgdMXsRRVGOKuNQgAecU8asyMoUdHioK+eJuqRwJ1Ed3g4N7x7mzN9ja7Uo0WE05U7BJUTQHzdyXJiHZEamiPnVauT9PNTWDUe5u3dh8Nt9nZQWR5AT5+l3Ir4VlMX3chlbtDKLOPMcYxIoW7g3kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wpkql1C3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wpkql1C3"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-690404fd230so89948357b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 17:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728950525; x=1729555325; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sWId1MW2gWjJ8B3DXmeL36O281P7L5ABFWtGa9JPb4=;
        b=Wpkql1C34d0y9PYrSB1ojwgAqGXDO4pmw6Rq6sV3bt+jSmHbamsFUh8gx+NWH3LVCf
         MKke7QuLUwHvMg0/0H8Y0+oSJePgbHKuiRej3r3DxtrvCwdcyAqGuofRKsplooa0HxJb
         SWjffvOWx/IBwrhjunC3bDJTsEU+qeH5pBAlHsM7Ena9Nxd/XfV/43UeOcsyEhABOwuK
         efSbjBIdVchWrAbruPDWHFgPOtbQqfoGHWc4C1d5yQ/BX2T59NhdSzsf/oJqa6cEBnwf
         UvhaKQHoetX//OW7VxpF5nb5s/b5f4KGFTqjrr1ckSs2g5x/Vxe24c6hUleXnQj5/BZY
         BKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728950525; x=1729555325;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sWId1MW2gWjJ8B3DXmeL36O281P7L5ABFWtGa9JPb4=;
        b=AD73YE3OeNYHTEXgmz3nAFRhAxymL/oyJE9/Gcs5oDOAtQ9Adf9ibLBFbe0OKGGJGH
         oJhvp4NRdUXSX/KzhfMX3WShbhz1bhAWy9kzpOnFswiCYd1OerOQgm9K3j8Z/4fuygOX
         hR0KV6N+o/09fDfkRy1jyI7FU1q/xWn2hJCaaY1/1jMqN81AM1U0H8uyobqgdFlXbcOi
         /DIZD0H0KjrvmLFaMCyKgh47gcA45t6H6KX/QUpxYezzjFot+Eu1bdsPNmDMJjeUAiBY
         NXThOnvYffHV1ND87LeKN4LfoMAtHuTUK1aqdGoq576+3YQWDKqInQemw0XoIKpqWbH5
         2++g==
X-Forwarded-Encrypted: i=1; AJvYcCXC3uHCqRCJFXHGVM4VzReW4u6HYdLmVULA8KgHxYwMJxithlAxDzV3us/FUb4TPf5S1bnVWR8rUROE4V/mWk2B@vger.kernel.org
X-Gm-Message-State: AOJu0YxrE954a65PYo4JXxfmGs6eAIGc4+fAl3y4evZmCBZeyr8niGc/
	9LfmqOsCNcdR7vVW34/z7GxgIgAhd8ugj8ZdiKtBh3t1StsmXfLYNzM4mAcaV5Obg6/t7KeziVE
	IxSImbQ==
X-Google-Smtp-Source: AGHT+IHFyTiWxaw8Ek0l8rj6yZD1R6f2jnu5vF6MOt2oGc8LyxuLsasPkZ2Bh7M2Yo+gJ2nm1BVEIFgcatJj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f1f9:f6b6:68bc:5a14])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e12:b0:6e2:371f:4aef with SMTP
 id 00721157ae682-6e347b2fe3bmr320727b3.3.1728950525613; Mon, 14 Oct 2024
 17:02:05 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:01:56 -0700
In-Reply-To: <20241015000158.871828-1-irogers@google.com>
Message-Id: <20241015000158.871828-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015000158.871828-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 1/3] perf test: Add a shell wrapper for "Setup struct perf_event_attr"
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Leo Yan <leo.yan@linux.dev>, 
	Howard Chu <howardchu95@gmail.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"

The "Setup struct perf_event_attr" test in attr.c does a bunch of
directory finding to set up running a python test that in general is
more brittle than similar logic we have in shell tests. Add a shell
test that invokes and runs the tests in the python attr.py script.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/attr.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 tools/perf/tests/shell/attr.sh

diff --git a/tools/perf/tests/shell/attr.sh b/tools/perf/tests/shell/attr.sh
new file mode 100755
index 000000000000..e094f3baffb7
--- /dev/null
+++ b/tools/perf/tests/shell/attr.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# Perf attribute expectations test
+# SPDX-License-Identifier: GPL-2.0
+
+err=0
+
+cleanup() {
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
+shelldir=$(dirname "$0")
+perf_path=$(which perf)
+python "${shelldir}"/../attr.py -d "${shelldir}"/../attr -v -p "$perf_path"
+cleanup
+exit $err
-- 
2.47.0.rc1.288.g06298d1525-goog

