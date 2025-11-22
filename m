Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876552DF134
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799596; cv=none; b=qkk1zGZaCO8k1PCJL85c/9bZU21OjUMBwOE9iFzYqCmpx8/eoPkSdpnsZb5C6DVUSPlysn0jDU+xv5IBAUZ4R5tMMUfrcORRSkSmvaUz8w/TLPe0bj+c0V1ilODFAPCqSbPseCog70nXx82cxVahlUtNZ1JP9HKTtvnxG0lv1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799596; c=relaxed/simple;
	bh=NXklLjTXEI509or4UVobymvmC5qBq3+kL+fp7XxCaPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VteakVZRP3EmO1QYigpN0W4hdHioLqpYukp00QPEiQLG3nQo15veZF+dzwgiBcxrntIO5k7Sp7RIUy2yFfwnhr8F54KGrtkCop6EVvILJVyZLyQGiIrt3mdF3Yum4U3X0UQtk6xPDN4csr/Z5wd/i3rPVOKulTnHX671b1kKiSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHyEshvt; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHyEshvt"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297e66542afso98221725ad.3
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799595; x=1764404395; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEy0JIyorfG9miNyUuHx8ttwB5wA6SqJTKfXTXr6auo=;
        b=rHyEshvtvo1IRRcm1pdHYa+ox1oHfJYaZgjgnpQHAXnI8du1xUnMzlzxOyMJlQBRYQ
         d0OEbek9KZ7LjO0h55KNxG23shbyCuaAt1yqLVGxp0RlldFLtyBYGwhfrjSz6VDuReFa
         /dn2G0/FZc6QRW5i1OjPBPXimWZbEQ+WcdzZ4SDC2ExBQMVlOQlOXCL30AgB/zQ1W0oZ
         PLIVNxSqxim6iKjbv3uK1bGNdu6Q0BX0DWhWjsIw5MNlzDgbZxXSaw84in2j5Xn8q32r
         jW3BRxvtVk3dshPv65HoEzlDd1Y7jvObHPBtg5W2CQ3XQhniqyVgi8aaTVx6hxl1voDn
         189g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799595; x=1764404395;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEy0JIyorfG9miNyUuHx8ttwB5wA6SqJTKfXTXr6auo=;
        b=SYpek9cthera+9XiZXYJ3pyIElRv6wKcrMjQLhQtcUHvy+x0raOq2MOQq49T8jnvHo
         ozaSq1Ox75MIJBvZ5dSQe/wTQa0IC6t6C7hsFWRrHnnfSlSXH42BorP0YpNBH4N/Jv89
         X4txx1qRvCYd/nDEREzNtUJamOLusCx8D5M6f3VHTG8IR5SffY5IDWq4vWiVXIfpXHzd
         mwe7tKuxgkNfjvD4gGqWyhhJZPjuUs1prBzlE7HHRQMTD+SjPp6/uMhnM3eie6ygn6jF
         JmiqJZ5QlvBT7KCMpYSh0oDQfOttL3FWQ3pa0+Z78XeztcRAl5Pi1IjZmYNc79Cd1Clb
         JBjA==
X-Forwarded-Encrypted: i=1; AJvYcCU1UJkNaIjbjX71DnT28dRCAlozv4a32DEQgSM1kqLYMdwX1ckpFN3pSX3UZj2wGaFBFWsFuoqDPFrWPjqoDbqk@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtVfSJIZGOk99EyI9CUdjRNK23nm9zXPALMleVvv6sVlz6rum
	S8qzktcv7UwFO4SMkUiQ7vp/oUT2XTDk5DieXlVTmAVPdxXz8A9yRkEU38CNpz/6iep+Nd3OAF8
	8TstDMdVqRg==
X-Google-Smtp-Source: AGHT+IG/iVOBwJcUhYY5gewvM0FkraVbyCe1YZERZFS8zE13uEGJCuQzjdeULg/ddoRJfS5HER8y8zI4+hgf
X-Received: from dlbcq24.prod.google.com ([2002:a05:7022:2498:b0:119:49ca:6ba6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2214:b0:119:e56b:c751
 with SMTP id a92af1059eb24-11c9d84e082mr2733031c88.22.1763799594840; Sat, 22
 Nov 2025 00:19:54 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:22 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-11-irogers@google.com>
Subject: [PATCH v1 10/17] perf tests c2c: Add a basic c2c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add basic c2c record and report testing to gain some coverage.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/c2c.sh | 62 +++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100755 tools/perf/tests/shell/c2c.sh

diff --git a/tools/perf/tests/shell/c2c.sh b/tools/perf/tests/shell/c2c.sh
new file mode 100755
index 000000000000..2471d44595c3
--- /dev/null
+++ b/tools/perf/tests/shell/c2c.sh
@@ -0,0 +1,62 @@
+#!/bin/bash
+# perf c2c tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+perfdata=$(mktemp /tmp/__perf_c2c_test.perf.data.XXXXX)
+
+cleanup() {
+	rm -f "${perfdata}"
+	rm -f "${perfdata}".old
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+check_c2c_support() {
+	# Check if perf c2c record works.
+	if ! perf c2c record -o "${perfdata}" -- true > /dev/null 2>&1 ; then
+		return 1
+	fi
+	return 0
+}
+
+test_c2c_record_report() {
+	echo "c2c record and report test"
+	if ! check_c2c_support ; then
+		echo "c2c record and report test [Skipped: perf c2c record failed (possibly missing hardware support)]"
+		err=2
+		return
+	fi
+
+	# Run a workload that does some memory operations.
+	if ! perf c2c record -o "${perfdata}" -- perf test -w datasym 1 > /dev/null 2>&1 ; then
+		echo "c2c record and report test [Skipped: perf c2c record failed during workload]"
+		return
+	fi
+
+	if ! perf c2c report -i "${perfdata}" --stdio > /dev/null 2>&1 ; then
+		echo "c2c record and report test [Failed: report failed]"
+		err=1
+		return
+	fi
+
+	if ! perf c2c report -i "${perfdata}" -N > /dev/null 2>&1 ; then
+		echo "c2c record and report test [Failed: report -N failed]"
+		err=1
+		return
+	fi
+
+	echo "c2c record and report test [Success]"
+}
+
+test_c2c_record_report
+cleanup
+exit $err
-- 
2.52.0.rc2.455.g230fcf2819-goog

