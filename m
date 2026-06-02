Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620053ED3A9
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410448; cv=none; b=KpysqcmL3ssIWSdPOIwlm96fmMmzFFMBI+DV+Fa0sfHOgiar2VlDnkV4RRVe/XI4a2LWBQtqNM2VHHHXv+fIqOPbYMi2FdnMw/wnyazIElbxo2B0AmzJ45yIsE84qIpFYq5jildh0LktcgJmEJgXl7D/BfwYFfphTASdIUTCp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410448; c=relaxed/simple;
	bh=iQVBxA25lW6A4uA0ACC2OMef9MHB9JOIgp6xmgt6rqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EPH/qrPTnIGCTZc1XA+Nuy4kaP5Kpizyn5HY8H5XTiuFgZJeVx6TgC+AUhQv1EiqvK8XGS295ke3DrcvFGcB52wcZhTC1Vps3h9/alLpdhs3veQ0+fhpT1fAfENB6fi38KbQdBOg29+mYoZKPoxby7GV/HBJcK8lvMofG8eoOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RsODVOfK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RsODVOfK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so6018325e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780410445; x=1781015245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EO8/K9YxgiEJpvhD7v23MJuqc72Imxv7cQ7m/8nhtl0=;
        b=RsODVOfK7+urt0xrwfplJ6JRMaAK5fT2cft5LMm5P5iBYv3lBdzHp+hbwoet+/sBFk
         IgBMiKpc6/Eh6BlL/HPjoYIBMsd9WbomeqyNiYPFGaiEFEQHKwEtg7R0QENCjHJV4t4c
         0zqa45vYMZBPz5rTZAxcQBGIzaJOM/9AEuyVfD1q/Zk2qt1ZzgH3EwR8ONe+yfDLk/87
         HlqD//9XBhVqXV9df4UBYLKil4ujWanLPxPkgRfepylLCiZr3qBeyZIO4viuH7L3pAlg
         mj6EM0anjbmENuZ5QtH9BHLCxbgwK/yCNMOjWTGpU5VQ6g14f50akZd9izEiGpkGRaZH
         GGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410445; x=1781015245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EO8/K9YxgiEJpvhD7v23MJuqc72Imxv7cQ7m/8nhtl0=;
        b=jaNvdrQwn4xtmu4V7/BHSl6VzoDVfIfaFO5e9lvSfzM/V+nAf59BrQdF1ADxzsC7QN
         VBQoZzIBOi/z0Hl1IkXE2emZK877Wysh7sXAHm5EEOR0c9CyX6gWUEDrclsFTsmrMXWm
         SqmLT4Yhs8Ois5vkYS4/HGK9LRL4/E7NUQFnTN3lqPyzGcl3/GigkFEdaj1V5ZLNlX5/
         ayMzau4Ed6gSnZwXPce69ZF8DIVBXUSLoobSB84VKtpg5YK61yNa+Kb6iDifbXor1+nt
         si2s81pZZOgaaxLWmmO8Jbg5eib1qArzrqieyVmWBBOy6j+qEHc8N9fLS8dCMBmCtKN1
         t+CQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Emis+sphq7DeRBmnIdcsMb4bIGtTWRmRVPRiO+1Zru9VB6R1J4P1WjAE2gXKR0BVbQkidX2x/gTZ3mTKxZTMp@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf0GX7F5b+hXoLVTKRm7WvtWh4xKOf6kavkyD+mcvKaQQWYWh4
	7HAVdrr3AdhZEIAnBTs0lqJGXZtryiC90w8xp6PaMjLk1dj2Q767O/oiowmqDnEh7kE=
X-Gm-Gg: Acq92OEO8kXb8mh42PloZfBF56s+PeqlrEkYPbw13x8FoUYGBeB0Xq3L0nmkGTKD1tg
	JeWRCMs3EEa/V4SSF6f3yhcUrIWQEuxKafn5XGDl40wErnlJWr6fj/24qZ6iB5g3ZVxMoU+MUsV
	bnXGpBXBDcekkdnzuwlY+GqFSwKpqkjmJbru30LqckIdYm+Dc4ReCuAczuox93/UwkJpqVL+qdn
	ItmBdsTWjsPn3Uk5Z2NN8LQ82GF+GZ6KhQZRlRjN7TneJzF+/iffLBE0n9nIXvB0pFsJXl6amzE
	WM0OHby4EpAtP47eHh8/zRZ38/G7KeUKbkfolKyE3lBbaHM1ZtdH25BgY6jEe2F3Xui5nJAQ32G
	4ygjb3EWK6CoRXyG+16CVssZJv5O5IFFKLnnX12puQ91yf/BT/+oJ2kEC4Y1jUPUHiHHpk6gGgk
	bV/6AD3/OMlv01CZXVX/8e86WY0zxazX7r5kng1X1nCn0=
X-Received: by 2002:a05:600c:4755:b0:490:3cb4:f1b3 with SMTP id 5b1f17b1804b1-490a293322dmr279955285e9.16.1780410444873;
        Tue, 02 Jun 2026 07:27:24 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66771965e9.4.2026.06.02.07.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:24 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Jun 2026 15:26:46 +0100
Subject: [PATCH v2 04/18] perf test cs-etm: Test process attribution
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-james-cs-context-tracking-fix-v2-4-85b5ce6f55c6@linaro.org>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
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

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../tests/shell/coresight/context_switch_thread.sh | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/context_switch_thread.sh b/tools/perf/tests/shell/coresight/context_switch_thread.sh
new file mode 100755
index 000000000000..0992c35a329d
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/context_switch_thread.sh
@@ -0,0 +1,69 @@
+#!/bin/bash -e
+# Coresight context switch thread attribution (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+# If Coresight is not available, skip the test
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
+	taskset --cpu-list 0 perf test --workload-ctl fifo:"$cf","$af" \
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

