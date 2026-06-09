Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F4347538
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015486; cv=none; b=IQ5RoHWplYs/USSvlJ7ho8OwIiLiB1CIGpN8UpSB1PqoV5iJ9KvIeWNjjkxsyQQ7S2zLC/FdWy6KurbjpAdYPGDpYDRhKqT1PGm2TfLWAVOpHtA4l0HsVva+SBbCT9XRodF5U/OgjU5i6QkKWkRolMw9rq2S1k3+bIWXP1FJXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015486; c=relaxed/simple;
	bh=dIdyAuGP/OaUVcAMmgROZGX4ROjDm0H45x/4DXdzJEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/PGJV+f6hIxjh7nedWwZrkTr8ufEwPSELw7rZepvrM2y1+C06XxPz+27R5VRKOKxIrPu7o5RApsImCQJILPc3n8N3d8UGL05UIz0MKUhI9FXBYgqJRyRj7rVKeLF1nd1m/3MTzgbPdmOImEcyTmhWE/+aydWTmRXgTAqr2ESBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zwB+tKCj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zwB+tKCj"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso4009283f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015482; x=1781620282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmgPHjWVH3cXsk2qRjnjPXugJJfk4bPfhv1qYZzCEfk=;
        b=zwB+tKCjtb6vrcWul3IeuS7Gp9THPeNTraC2D72/bXhhMkCdcOZPJahhNEbEdSwfWu
         YoyWCD2DTn6cROEP2Te6vTdYHqZJ3mNdvkskZU7IeKMCPrX6GBVZSXfBZ8vv4M+cD2su
         dM5SBoUu7/eu8faW+/nScpvy0NDxwJa+lqOQECFbW82Lj52FBEMQ7RAjuMenDqdpDWNG
         dT2qxDlNdLtPNukuxXvWLX6nSbRJ7y+sq/bPLx12LJCPbbmOAN5bt7DReWvQHghu0Bax
         sap5HRolkG4VVcm5WsH59osRPGQ0AyWvUROHTCiZ3SI76WAiJdD1n0tPnLgw6k8tCB3l
         aRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015482; x=1781620282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PmgPHjWVH3cXsk2qRjnjPXugJJfk4bPfhv1qYZzCEfk=;
        b=cBRQRrrAf10nzUeMgdvkHNnY6PZLSuMtOkd41kIMJQVWWthl6HcD7MkI4kjgu7wzKo
         9TZ8Q8p3dZdepplhfBKkBbE8c4/nGcrbgE/evVM3+x8RRQ811rEQoSOOJIAC4FctR/nx
         OVV5XEtjfEeUHxORSQtrHf4yYhnEGFX3fBnyNNTbvU/Ah3fEMAlF7zzBDit0O5h9fpAi
         LN0mfOwI7QcR1A8gULoE2OpmSMdrFn4HVA/P2bFay5LtZaNHtH3bj8tmHzGBybMUWK6j
         8nbrS/HPUt+tSTwK+vImOTdVF3z0ilm3GeXigIbuMY5LluQaye3F0pA7Jg/190hXzJy/
         eQwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8pt1aRFBBSTD5d6eHakFnuV4Wy6cDNYcB/aYl24H/wLB05ghlEzi4PUCxfDntFcrXtdUdDH5W3gvAhWxsoRhbx@vger.kernel.org
X-Gm-Message-State: AOJu0YxZbfLu98pLhO/BhNiSGZOAOEtBcEg5uxM4+XQazK0dPNopDHMB
	roaA08tgXDobAJ7eoWVsIVPFvPTegsV3UpgVxBzpfN4WdZLxOJaAXxRDh4kbyfctCZg=
X-Gm-Gg: Acq92OEDeecYzq7ADhUejbAG+6n9qpE94mTaXy/+RSjg5YJdDFgCmuUVfqsaIHXe5yH
	YLGMLqF7roXKpoALBfT/Z5nZ3rD8aVcM//xS+zEMYMgUqVndEnWKCRXzOeFS6brucIxsdIuWeG0
	a+AdPityjpi4ykyNbmeBb+ClFsMfwe0iZkiikgaHSpBdJVZ5/6y/nFLV7fiOlW6bwFTIxlp+ZmI
	VY8S/GwovoWIZlaCKec0E+4nn03+yEQnBlcwmtxKgHgUFJ0zbXszIAzlW3upM4KAbr7BW9VAALE
	SMTZVQM1bBsANMbAsgzq+u7nENe5Ot0Y+ayhGGAW/FY0pT3tvIo2qbqWkOgrgC8qZ/zVw3/tOhX
	0Xd+sCJzXUM9jHH2/85eeVqEvm+CPPIh3986Iv+Tu0dWiCc0PacEybUihIQqTQ+U9l+FBoYLzXD
	u1TdeBch6Q34byyvXyxzR/zagb6axSFYnhxYl6BJWdLE/KcX9yYxdoNA==
X-Received: by 2002:adf:fe48:0:b0:460:30bd:4dca with SMTP id ffacd0b85a97d-46030bd4e65mr23193297f8f.30.1781015481780;
        Tue, 09 Jun 2026 07:31:21 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:21 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:30:57 +0100
Subject: [PATCH v4 04/19] perf test cs-etm: Test process attribution
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-4-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
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

