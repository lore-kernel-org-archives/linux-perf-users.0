Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D5338F255
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620019; cv=none; b=eBeaIDgEmQygpV5ultXZkmuiY5guxk8JZ6e/qF8TGOLkc7a3Wb6XKs8sTThYzO1xEJxAuBD5x8cjFDJiLKUN0x12sJ1rIS0vk6zBTQv8Caagnuzvq/jkNEXqYhrwD7JR7pBrolwTnsZ/gDUPBElm+BJUhZnDln/j8nk+rFj7ppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620019; c=relaxed/simple;
	bh=QBJ1TXfroVLT43aUlu0VYJShdQ/5P4Nw9+kV1JnrH+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Csl84m4anb+ku3X7bYbBNsMq4v/RxLlgm/IaUkPST+8HuMLnBfTeDRJqu21oUD/hF5So9YaWDzt9Pp9Hse6a8AUnNbHfReGLecg320jN3nCyKldMRWnta6DXl/c6+9IY89c40SBN0hu2oolnoks6ExxYdREdPLJQ5hkD3d1WoAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U8qJuNdn; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U8qJuNdn"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34afa104860so80225eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790620017; x=1791224817; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qetGO+kJtSrkzooD0K52/h3hxl/7qmQXLVxIGMd1obU=;
        b=U8qJuNdnWkRFrRnmDbV65SEQ7tTWR6wG5Vsr4jIEOeUnv6qOK5+h/c1Dbd39W1qOmh
         7In6AxKkmWc1wIGPZTwZNOyYb46oPjQVaj6caHP9SUA9tqgkVNogJkOHNuVAfmAnf7FU
         9RH8+niqRagwUZD9394U/gRoUxdqzb68VR8TPDgpaXmEyItBxKDr79D2QmmiWxubftMk
         Sr/dJkGIFGNLDklNI4WRiJA57bx/gCBJ75reVPAKav3qEvDNIhBwxXZ/7f4TKFfOxCBc
         4o7nmPWDzcsoY8/oFxaeFFP+BXYsftr0ZHDYQleIteNKXFiYxIl8M8vbLkLWy386SvCb
         DGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620017; x=1791224817;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qetGO+kJtSrkzooD0K52/h3hxl/7qmQXLVxIGMd1obU=;
        b=MnD79YWFHsCEiVkX1d2YeuVYn20gtifZ2lwlU9rpZ1IxDUA0St7TmG29beOX3stfNj
         xS4qqub1EgZJBlgRJtv+ElBQ1pYq68fPcBtG+qca8zF2fvqv1VWQWwq7XpAcMtBXE6Jl
         ze3Ssua26eYflE4qPbiegH8F6p/CVb/UFHPTNXXbSfISljf0UYTd9gR2G0yURhB60fgJ
         xQux1GqZ0n8vxkkjGoLxGLyeOVDFWHQp+ouyf+w3MsMKfxAas8//By4ohj/oX1GbgImd
         gHVvTf3GUnoSsFIh9PqYdPDKSGPxmwVDnJZ2UVMLbLtjAhA5KxjTxAgapn725Q9pbJXp
         /FCg==
X-Forwarded-Encrypted: i=1; AKwUvBzqYs4TpAR/t51YIiqMg1fqAze1jQcgYdp38KliirWfE7GR6IBmAkVpu1iG5UNzMIH1TH60KeB6UI45NlOZU7KH@vger.kernel.org
X-Gm-Message-State: AFuF++mXk2OsaUSycRxA3YR931XjZbbmY2VVKT9ICcxfYPOJUDqd0tUa
	H74T95mQxlfksCHDd9Cdoj0Kna/YucXwsIuXtY4D5xn64vnNJY5YSKY6x0BbdaW+L2OOFcwz12B
	5Tzq5HE3Rjw==
X-Received: from dlbsw8.prod.google.com ([2002:a05:7022:3a88:b0:146:40d5:dd6b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:428b:20b0:148:80d4:84ac
 with SMTP id a92af1059eb24-14880d485e6mr6837425c88.29.1790620016274; Mon, 28
 Sep 2026 11:26:56 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:59 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-21-irogers@google.com>
Subject: [PATCH v6 20/26] perf test common: Only disable probes in clear_all_probes
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Writing 0 to events/enable disables every tracepoint, breaking perf
sessions running in parallel. Disable just the kprobes and uprobes, an
enabled one would make clearing kprobe_events or uprobe_events fail with
EBUSY.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/common/init.sh | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
index cbfc78bec974..db89a5be95dc 100644
--- a/tools/perf/tests/shell/common/init.sh
+++ b/tools/perf/tests/shell/common/init.sh
@@ -130,9 +130,28 @@ check_uprobes_available()
 	test -e /sys/kernel/debug/tracing/uprobe_events
 }
 
+# Disable every kprobe and uprobe, listed as "TYPE:GROUP/EVENT ARGS...".
+disable_all_probes()
+{
+	PROBE_SPECS=`cat /sys/kernel/debug/tracing/kprobe_events \
+		/sys/kernel/debug/tracing/uprobe_events 2> /dev/null |
+		cut -d ' ' -f 1`
+	for PROBE_SPEC in $PROBE_SPECS
+	do
+		case "$PROBE_SPEC" in
+			*:*/*) ;;
+			*) continue ;;
+		esac
+		PROBE_ENABLE="/sys/kernel/debug/tracing/events/${PROBE_SPEC#*:}/enable"
+		test -e "$PROBE_ENABLE" && echo 0 > "$PROBE_ENABLE"
+	done
+}
+
 clear_all_probes()
 {
-	echo 0 > /sys/kernel/debug/tracing/events/enable
+	# Any enabled probe makes the clearing below fail with EBUSY. Unlike
+	# events/enable, this leaves other sessions' tracepoints alone.
+	disable_all_probes
 	check_kprobes_available && echo > /sys/kernel/debug/tracing/kprobe_events
 	check_uprobes_available && echo > /sys/kernel/debug/tracing/uprobe_events
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

