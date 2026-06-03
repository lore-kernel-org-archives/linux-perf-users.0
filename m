Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE239C637
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481849; cv=none; b=TnXqq/zIV7s1OB3mK3Z3G+OlmV4Qpv+eHV6HZk9FqQh3cMqc+7EDJ9J7sc7aFPYFZS5z1OEN7m+o1VkBm5yvJkurZ6CmTmttwmGPcjaYm4j308acHiTmSdWt6xgY3LYbpA7NPdqH56Z3JsrWGTGg6oD1JzF21n1UIpvHLALYqpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481849; c=relaxed/simple;
	bh=iQVBxA25lW6A4uA0ACC2OMef9MHB9JOIgp6xmgt6rqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZMFsEdoxxXPPf+baRIHatF4q/jiA/dMn1qxpbp0HHf24+B7ovjBjKSHiZOCmmt8/rZzJZHfaA9KXV2gRBDSURD06XM2Z3SL3QeXxds8MGqmd6JNrwveLAcefQ7E/UMqHFFYO85HIhF6+JVPPDnoTaKl9E5pZ3uktSnba4MiRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YcIi0puf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcIi0puf"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso2030071f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481846; x=1781086646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EO8/K9YxgiEJpvhD7v23MJuqc72Imxv7cQ7m/8nhtl0=;
        b=YcIi0puf/rr0LOsttgmuR9cl0YySyBjDmDO4eRwzLbZMiFhyMD1lnjCQC1DA1GCpKZ
         PgQ2fcQMt8iR+CFbhigAcSvvOMjlImHjJZUGhkGBIkLhKk0xd/u7gm6fK24e9spUNMuN
         NRZgqSVVB3Lf97xPhlI1G6koP+jZy4NLdSP2yqoyYRn5M6/6Kbuboc3CmEPoD9bwGjZh
         iLiOaaE4TD1n6JUJH7dtGTgmEnRspON4bbxK6VK9kmT1VLUtF2rWdkAeobOEv7nndYup
         mOHmwY8mW1MrVzC14Ca80mN7JDiFDmCVF1akGKzz2NZY7YY5oPBAKlFnIuVPtq/X/dIZ
         9QVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481846; x=1781086646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EO8/K9YxgiEJpvhD7v23MJuqc72Imxv7cQ7m/8nhtl0=;
        b=O85e0D4R+b5T7eynX9KTS2uRSBNVrfqBB8EAZUDPRGllFtEjDpPa01Ht4t+652TGX9
         dPgg7zetZvfHQv+6hZ0fyeMRt0kDHLJP/xe9GoXTs6ZuwkICoHgmBeJra51z+00gGG8A
         ZfbDac/X8KGWMi1PI/O3VEIyXpDKbRb3yDywkco5cChGrX3FJOmxqKGw70Eb9mO/JRbB
         pUVixE4hcBvjgSkcy5gO04wgiCKyJQqxe5Z7jleXCzdWOeTWehJlXASz3jXhAwNpGHfr
         fE/TRvC7DdcyBTZMyu2KsmAYUDNiWSsAEMGxDMkV/IdRbawqCFNP/xjnkDjry4gnDwZd
         PoAw==
X-Forwarded-Encrypted: i=1; AFNElJ9rp8BNjyVFpEr9UHGsgHHvyrXmW3+2ABgabvS5J5y9maOPlqkZB2A5OzDYwU8SIfvWznt7izZARXie39Z93H69@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1iC0Rikz3ajMdg/m0xG5JtAwRTjRtOUh8u1m17Iu0ocokB2EP
	0OP0hVKm94Ew0ivrx8WlJl/POJop7UW2z7KDngW2wyWMfx1SB9LpxaLQDnznA0JayDY=
X-Gm-Gg: Acq92OFf+WiJLzmX1ACIEY1oFVGjO/UZNoYZ9CPv3KdMBMD1h54alr+bA/W86Tqth9P
	dwTdQP5wo96zNnBI7D7a3hrATfBAbM8SLJvcE8o9DEeRdL6VxEuIMxMBuL9VGE6/0WTvAaf5stP
	TQhQBLL7KTIqNCj/qIMxa1+GaVSei6Mo6Qca4y4iOH2N9064b2kORtxkVsPe5mjov1bk5n3EKms
	tWtjEvGtoBQ4/qrm38bs51MWkPOXJQpktFsGr8A5lqvjF+ZvbKf2bACP5+96jAMN6V32aKaQqAd
	GbDu5obKDjoznI2jWic9ihhRlERdOJxf5jGtJVt2tVShVQtqrcGfOKiauk7EmEmzB1EZFyqcS5D
	BUDbwy1FGJv17Op3v9pjGPFztf91eQ4l1zRtSf6qjgmEq+5Xh+zDMyc9EtIiMGyRf0mVFNhmdeC
	44dIp53sNLMm7TZsandz5g3PbcNQEMKL2299K5jShIErA=
X-Received: by 2002:a05:600c:458b:b0:490:6e12:542d with SMTP id 5b1f17b1804b1-490b5fe0af4mr45931785e9.19.1780481846203;
        Wed, 03 Jun 2026 03:17:26 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:25 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:08 +0100
Subject: [PATCH v3 04/19] perf test cs-etm: Test process attribution
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-4-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
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

