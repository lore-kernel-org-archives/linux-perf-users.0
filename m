Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34B329E48
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765300101; cv=none; b=ntvr+1XfllNER4JVn99avRQZz/2ov2I28Dd3j+cOrIQ1IeQVWuZUByT8OdcnWpNsH79QKsw0wqXT4LW0FjIC+/yzWRkO5//Slb9OeHfFqDfapE79DUqgmuveB0CODHbJrQpuMIL6OE1moxEZHgiHCb4yMb5GtgpqyMWqk/L23RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765300101; c=relaxed/simple;
	bh=SrSQINHsZi5xCD99oEpcw455kSMvg+7scyD1FdsGFUg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=hn9NHfOKK9YmgvcGb2I21dwo8JDeeVN+ScrMSlUUBO1oTVVIhwc5H6s4HMl8E2W8j4OZxRVHzmZjo64Qs8lKROpL4e05JyatX9RXu2LxvT38krLpS78OZVj9NnL6v8au7atyhE/qgkHIaMb1wPorolU2lWQC7JAr7EbTvxTQNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2FyvGtG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2FyvGtG"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7c240728e2aso10667645b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 09:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765300099; x=1765904899; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kSNKIJFZ+LEnI//dDB9nn4CQuFiHZyaloDyEr4z5v5c=;
        b=V2FyvGtGap+DQFmUyjQQ01IfIWSGyAdOICNS8geVjaCRbjx0IT7gTD2UEYS0MCWFqy
         vFskBXPdrJPsfc1HsU8wS5dnwsq6v4Agu0AIUJXOlIw84nyZOsrGgPME1Xxm1zM/UiHJ
         SRFRMoib1wJSx50UNAsk+0Dr9dIESDkqqrtRl1XccgOzs+9TVYb5NHM1pzs0juTpi0Fu
         WrJnbjJpAofhwUoaEm0xkyRun7UrmG6NKSgW9TPUgMvoPngLwCqi8kRqeUie8Qv9ktSu
         WiGmD4Aum6X34XK7lffgr/BKzYnEpnQE2YHKfK0DNIZjS4CP0N10+Rf0/Qci5AxYsAKz
         3KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765300099; x=1765904899;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSNKIJFZ+LEnI//dDB9nn4CQuFiHZyaloDyEr4z5v5c=;
        b=E5hn6XUuSfIs0dwqEKLGoZEvPpYvJpd1v2YRGGo8WVGHN5/TDQRV1uSthr3mGlP+5C
         ZWfLZdyyWPtfoqZ6Pkp1BAwruA9Puq/EDlankW578NAYDXKjz1nhb/CfW3lbjKdda9Sq
         Htd4GP24Pal3B26Ipl18brU1c2m3w2HBFkQLODygirIAVZx4qiRd2L6cLbfMWikFaW2W
         Q6dT6ti1KMYfi5qMOKntlvLkcSOJVKPoJ0/geGOpMffvP8DwILh4lEVBP5c+1hI1Czu1
         5wcHNFV+idC+uBIY47CsW3rP05BN6icob9RzvOqLid/PLZmUFT0PhDl/0Tm/2fUN683P
         Uumw==
X-Forwarded-Encrypted: i=1; AJvYcCVhlVC5pvCRcVVpi4ywdjaXOOR42TgMKBGgI5L+oRoTNDK3hHxvt1CGnvVDIfJZvkalTifAU7plCrZ4RvKCRBaU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wkm76M8Pxr4NK3KZIv6h+CL8xSPHo3LJZ8B7sqEU6fGdinaR
	KoYOitVDJZP3yH30MVXjTX/88uFXD4lQm0RTTVKhrBbEk91v1UCIvexCSyNrnNl5OJOHncHXJp1
	6gV7u18boeQ==
X-Google-Smtp-Source: AGHT+IGqjPHUYsuiUAOaApZalPyWsBbmQb9shlzz6ePcj6eT+3u+fmmkb/CRRr+IquuEWZlepCL9JLho1wDJ
X-Received: from dlbur10.prod.google.com ([2002:a05:7022:ea4a:b0:119:78ff:fe0f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:441e:b0:11b:9386:8260
 with SMTP id a92af1059eb24-11e032d455dmr7967381c88.45.1765300098798; Tue, 09
 Dec 2025 09:08:18 -0800 (PST)
Date: Tue,  9 Dec 2025 09:08:11 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251209170814.2009253-1-irogers@google.com>
Subject: [PATCH v1] perf tests kwork: Add basic kwork coverage tests
From: Ian Rogers <irogers@google.com>
To: Feng Yang <yangfeng@kylinos.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add basic kwork coverage tests for record, report, latency, timehist
and top.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/kwork.sh | 79 +++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100755 tools/perf/tests/shell/kwork.sh

diff --git a/tools/perf/tests/shell/kwork.sh b/tools/perf/tests/shell/kwork.sh
new file mode 100755
index 000000000000..42bfd9382816
--- /dev/null
+++ b/tools/perf/tests/shell/kwork.sh
@@ -0,0 +1,79 @@
+#!/bin/bash
+# perf kwork tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# Root permissions required for tracing events.
+if [ "$(id -u)" != 0 ]; then
+	echo "[Skip] No root permission"
+	exit 2
+fi
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test_kwork.perf.data.XXXXX)
+
+cleanup() {
+	rm -f "${perfdata}"
+	rm -f "${perfdata}".old
+
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
+test_kwork_record() {
+	echo "Kwork record"
+	perf kwork record -o "${perfdata}" -- sleep 1
+	echo "Kwork record [Success]"
+}
+
+test_kwork_report() {
+	echo "Kwork report"
+	if ! perf kwork report -i "${perfdata}" | grep -q "Kwork Name"; then
+		echo "Kwork report [Failed missing output]"
+		err=1
+	fi
+	echo "Kwork report [Success]"
+}
+
+test_kwork_latency() {
+	echo "Kwork latency"
+	if ! perf kwork latency -i "${perfdata}" | grep -q "Avg delay"; then
+		echo "Kwork latency [Failed missing output]"
+		err=1
+	fi
+	echo "Kwork latency [Success]"
+}
+
+test_kwork_timehist() {
+	echo "Kwork timehist"
+	if ! perf kwork timehist -i "${perfdata}" | grep -q "Kwork name"; then
+		echo "Kwork timehist [Failed missing output]"
+		err=1
+	fi
+	echo "Kwork timehist [Success]"
+}
+
+test_kwork_top() {
+	echo "Kwork top"
+	if ! perf kwork top -i "${perfdata}" | grep -q "COMMAND"; then
+		echo "Kwork top [Failed missing output]"
+		err=1
+	fi
+	echo "Kwork top [Success]"
+}
+
+test_kwork_record
+test_kwork_report
+test_kwork_latency
+test_kwork_timehist
+test_kwork_top
+
+cleanup
+exit $err
-- 
2.52.0.223.gf5cc29aaa4-goog

