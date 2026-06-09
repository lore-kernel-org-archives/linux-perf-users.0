Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB33546C1
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016032; cv=none; b=W2q61xrxLhK5p/ieSDMcfzgVfkvY+CWkMTo7DiQqEOhFPmvp+HRM0ZUiJq5Jfl1RWaV1TvobZFell/J3IycnupcqfAlVBfV9vjn5tVtUAEK/Z9LfQ4U4zmd1EH33XZz5uOR2HocQHywR6d/1Fe31kX4zJQeclJ7EtkUy50+RfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016032; c=relaxed/simple;
	bh=dIdyAuGP/OaUVcAMmgROZGX4ROjDm0H45x/4DXdzJEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGkp3b9Zp4I6CUIQdkUs2U+fH+lUvJmWLW4/tCLEvqiE2aJWcm5nntIOnAV1BpfliIe1znDBIggnxfB/Hfkj7YLLk8tb11RZ7GhYB7B/CtNg8Q/WGu26zVrtPJLYJr4L02GZecwpghSryf1kQoeMSrKEaGNUNDvn89WWeWy8RoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ukba1lLx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ukba1lLx"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490af320e2aso61459615e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016029; x=1781620829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmgPHjWVH3cXsk2qRjnjPXugJJfk4bPfhv1qYZzCEfk=;
        b=ukba1lLxCvaQGy7Am1z2ze4BSX32hKePsH1WBv7K8XkHyX5RCClVKoZUoL30Icuhw9
         iE1n0Uu5z7vpRJ8oyNSBEK/uS3xx1UoWIIZS+ntr7cnk5nyUsmFCeKXKAxxAkd18grNN
         5pmOEyxyaw3lrWfgnCg1wn+qHLwxuXbd7eCH2vzbwe+VHwQ/50zbuzbXpM9IvZ/EvF01
         AHmhBOHsTApJV1B7385N7XYEKKomaIoq0qwPUEblkEExrRF/4TAPG+wul8WNdoti+nJ4
         BhjjydJ8YrjH3fmB7+eZM2XeX6aC0FrN8Lb7/KmMcHCow3sCV9naKuCulK9Tr5c9R4Rw
         T6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016029; x=1781620829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PmgPHjWVH3cXsk2qRjnjPXugJJfk4bPfhv1qYZzCEfk=;
        b=CQM4Uvz9u1ouE89pfO5q90e0BhLUzhKQwdyBUMcE9wTzvvUKwUvjFkvPLAzCm6KVkz
         I+70sAu6Dqn9lWnIYcNWGn3+yCZKM41Vyn+asiIBvy+F7Ex40SFAyjCoIR6okxrwbTmS
         ay8UEZxTlND12DwnpTqAFLM1vPa+rtpC+lmZFCy6emtShs4TKJPhUK9ovv/I7lktY9H1
         L6FLvhemdQHrCFZwODfQ/sOnJgYiV2YywAvxSNSGe4f1KQJQACPrbrnPFAZtf+bxlVqM
         cnOFn3iP1u/dWMf5keRWfNp8wZuWkjxrRUwHg6msK81wriW3YdFQouwOpLEnOk/NPtT1
         mNwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PgbO7aRzC8S093c3n5nIVw3DtZJkfBwNdUZzNXugYwG347nm2YDl/OxJW5ZIDx7yo7cEupgJTCl6qumTbg6fO@vger.kernel.org
X-Gm-Message-State: AOJu0YwTN5D4xXpPTTpSbDe0tpmxNmcXe0NCJx0JPGjCACjMgBOGjcN+
	lKDnIz5i7hbz382jF975F6zQOfm3owd8SCyh9u7VYQekWERJivPlV7ZEHHJ7SNN+56E=
X-Gm-Gg: Acq92OEqDhajnwrXzlrJ+tEXKQyfWxqyweDNsIFkDyNvPp0MiwVqEguVOpmfqY4Hb+i
	YD9A1ZN9PejvsYhVtmvECEJhVj/FGu/59qNqI5nSf/OZeSa2x+5KLExByAY8YklrVhtp6q6GrE9
	Pu5y5tPHKdAmWCciNqDgoasU/UNsbJNmdGSEV+2IzTaKWDj02OAY0r/vwlSmxK+sz8GLjXi3YOB
	xgQA9VMm3BFzPkHwIs9lsh0uBkVsy/9sOqJ8pCYr2sxon8H7h38hYnc6EIK3Pyd7TcuSaYBsxNJ
	fF9onOFmAmCsEbwsgwWfKYgDLk+3DUs5zUxZJEDXuaN2ysb8Xtd1HwhWqXHH8TlKVXR7VxdUMxS
	RTr05M64gSe6TdwHcA58y0Z4fLg1bML8Lk+NC/cs727LmBTf7au27bLO7K2Pnhm9Pw6epcSvw1m
	3qzpT3KiINK61L49BmRkjqdjHn2OKkOv411aw6/Ti5Z8Q=
X-Received: by 2002:a05:600c:5248:b0:490:cb90:3e00 with SMTP id 5b1f17b1804b1-490cb903f1emr190466575e9.14.1781016029071;
        Tue, 09 Jun 2026 07:40:29 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:28 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:40:09 +0100
Subject: [PATCH v5 04/19] perf test cs-etm: Test process attribution
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v5-4-d53a7d096a19@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Run the context switch workload on one CPU and trace it to test that
symbols are attributed to the correct process and that the attribution
changes at the exact point that the context switch happened.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../tests/shell/coresight/context_switch_thread.sh | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/context_switch_thread.sh b/tools/perf/tests/shell/coresight/context_switch_thread.sh
new file mode 100755
index 000000000000..2b9c44b86c59
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/context_switch_thread.sh
@@ -0,0 +1,69 @@
+#!/bin/bash -e
+# CoreSight context switch thread attribution (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+# If CoreSight is not available, skip the test
+perf list pmu | grep -q cs_etm || exit 2
+
+if [ "$(id -u)" != 0 ]; then
+	# Requires root for "-C 0" in record command
+	echo "[Skip] No root permission"
+	exit 2
+fi
+
+tmpdir=$(mktemp -d /tmp/__perf_test.coresight_context_switch.XXXXX)
+
+cleanup() {
+	rm -rf "${tmpdir}"
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+check_samples() {
+	owner_samples=$(grep -c "proc1.*context_switch_loop_proc1" "$tmpdir/script" || true)
+	next_samples=$(grep -c "proc2.*context_switch_loop_proc2" "$tmpdir/script" || true)
+
+	if [ "$owner_samples" -eq 0 ] || [ "$next_samples" -eq 0 ]; then
+		echo "No samples found"
+		cleanup
+		exit 1
+	fi
+
+	if grep "proc2.*context_switch_loop_proc1" "$tmpdir/script"; then
+		echo "Thread1 symbol was attributed to proc2"
+		cleanup
+		exit 1
+	fi
+
+	if grep "proc1.*context_switch_loop_proc2" "$tmpdir/script"; then
+		echo "Thread2 symbol was attributed to proc1"
+		cleanup
+		exit 1
+	fi
+}
+
+cf="$tmpdir/ctl"
+af="$tmpdir/ack"
+mkfifo "$cf" "$af"
+
+# Pin to one CPU so the two threads alternate running but record into the same
+# trace buffer. Start disabled and use the control FIFO to only record the
+# workload and not startup.
+perf record -o "$tmpdir/data" -e cs_etm/timestamp=0/u -C 0 -D -1 --control fifo:"$cf","$af" -- \
+	taskset --cpu-list 0 perf test --record-ctl fifo:"$cf","$af" \
+	-w context_switch_loop > /dev/null 2>&1
+
+# Test both instruction and branch sample generation modes.
+perf script -i "$tmpdir/data" --itrace=i4 -F comm,pid,tid,ip,sym > "$tmpdir/script" 2>/dev/null
+check_samples
+perf script -i "$tmpdir/data" --itrace=b -F comm,pid,tid,ip,sym > "$tmpdir/script" 2>/dev/null
+check_samples
+
+cleanup
+exit 0

-- 
2.34.1

