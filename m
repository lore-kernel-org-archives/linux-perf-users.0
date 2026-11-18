Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019429;
	b=F9KTVDLtkQ2ifDQkoLprP7AFdBsgAmEYV58G2hTEmEo/Z9Me/rCfrvoUY4UPcblgnrKO
	 tfEl3xomXDUcfRNwsLgLPuePwdW54Ts9K+FXBWeqSVPg+1Q/ZB4eVyAfVbu3hTzryAvIO
	 rQ/uCORnJbEkrSkWFVkzf6OSTUqxj23q5oOce242trVgUIdzO5upJDm7K7uNzKziBBG6M
	 PWwq1v4G4RH/XHz6zajSkY4335UXSkUaV+kekOMfjEyplIzt5fpXHq9mx+6HAzMWbdZk7
	 VZg3W8i9tWTte76c65QsFydVBo//xbmhMlU09aBUqlhQ3dslmGXwweMJBDopmWf9lXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=+JJCbgH72G6vONzb178wZztv+bSL7c5y2vdkikA5TlY=;
	b=35YL080wql2LqQDexNX0gmM+aJC8ekQscwDfS6zPaDznSytATfVtMNEtMDgnBNQAIwxD
	 dooV7gqj1vFN9r+IqynBiLSb3mCOaaA8uvQXWUnqREfi11Tz93CB575erAXjlK1CldGMH
	 u1+i0zW+OXSp0ci9CZwV0KY0GMyze26Cw0gsTIBY2XExcon8fWhxVixXWmVO/J2XOVjdZ
	 Wvppni0sHZYFPuC/0fIVOJ7R1EDs78VXh7yEXlMonWBMyUjfqJddJSPkaHpfe1zazG3Kh
	 5yZRpqDzO6KaGntg0myAjtaOpYf9Lc6z4niP9Gk7IxNfp+ZnH1WSA3gVNQxpV0+/+MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jKemAnG2;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB01E60A262D
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB01E60A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jKemAnG2
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-491971ac844so1206956f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019424; x=1795624224; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+JJCbgH72G6vONzb178wZztv+bSL7c5y2vdkikA5TlY=;
        b=jKemAnG2EqLYglHgoJKZAbbrz4+JlIp79Siaq9epllLSNIRGtIA6Mp+DvWtNbkLDiR
         bIx++PY5GdrevibKfaNyk41biICDHcyvFymBNvd8YK/6jZyWESuv9X/1WfaCY6YAJvVu
         hOSlPIafmWyk208IZ/VAoKPq3w4PAMGEfvL9OcubioKg54uEqhAQcHXvKYIjYXRh/cO5
         ZJPjEEboIsHZyBReMIS1sr9ZmSXs9diTplB9BhDPkokHuZsxi7l63//FxSbT7iQWR4xa
         kQ8MCXudaP94YvLVFam+D/NOwVppDFHOXOkiVXrOxtxAacVP9YcUfLfOvX0wQZw1Pbgy
         YObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019424; x=1795624224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+JJCbgH72G6vONzb178wZztv+bSL7c5y2vdkikA5TlY=;
        b=IUsQwLYPIOnkOX+R6V/5G9bQCfbn9ZrRaF4CTmgMN9bQfIwBYBadmFLGR1A2reZ3cS
         8Xb3MRwxd+aRZMKIU/Xjo4sBIQa5w2rY96MeVH8Y0RQXJeJs/dfYKdxtSn5MuxWJn/mM
         pzUsZRFxCsw7Z0Poe2avCdZAQKGtTc6jH6K/E0KCj5+Iva80KalWF530ZQgkIDYhI7wJ
         WH7Zo/PHcjvZ2WpuVlUI9Hbo4Gcxl8YrizNoh3P5USArD8LkaCW0azBgW9BvHFXrXcfw
         G4dj82No9uw7tQ062bHETpntOM214PVqH/XKxm1QJciwZ1gQCn1M/4yYvzGB8wAmYwRH
         FAzw==
X-Gm-Message-State: APuU4Z/iD2Hzxhpp9aULiwKULaibRp9DS6YvBDCDz5EdhAhAQyoEr+ed
	LHbU9UK7P8xp1vllR3snhZPye24ZjJ8UeI1FXPqSEYKrIWnPPojVoStCilmF2tkMqt4=
X-Gm-Gg: AZFdTZeSXMj7UlGNX2PRF++XpC+wbMExRcHhjHVvwArfrJnsN5yaNdI86XkAKgf1Nyg
	fawuWDXGXQmMnYOMnI0SSlR1J5o4r9PeUDImWKr4xseXPLjRbOVole2ylEPbt23qFcLfVG/+HEf
	yZATUD1MMS9T0gLbKREyvY+uweW/GbPsitmZneD2mUZjhZ5Ff8l4ApJSDdH5DeZBofrQscy27Gx
	f+KMoXaYrRLmnjwRxrL0dyyVCQkiTqMLzI/N620FnZtN8W9hpvg51GNcS1WZKH84TSWYJoJwqkz
	ND9fqZKqNlbGkIB1ei74ksnJvlt5SSgz+jfaP3rMi2GVkGsvCvu9ADIf0a/el6IzvVahQJrawEb
	aJn3Hgsi++WUZCWftZg+VgcHGaPdY6JckxunRXndrsmZrtGJchfYVVnDr1utS/wCHKkTA3e9Qnt
	/dxPSo5lQyzuX4UAdukScm0YhcMUy9ezdCyTjhxiSQEPp8ed5EdJZUBChl4fWzOJuj9DG8MbjRj
	J2qQ/7sKhzGExXhJ6Nq5vyYS43k+Tnwjfkgknsu1iaNfjC8WYQ2L/WgkowxHCZTbEki4MoXIi0Y
	CFrX/P1WLsNyApbCTqHcGTa74+KVJoUPBg==
X-Received: by 2002:a05:6000:4b19:b0:4a7:7bec:e16d with SMTP id ffacd0b85a97d-4a77bece3f4mr3727104f8f.20.1795019424204;
        Wed, 18 Nov 2026 08:30:24 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:23 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:55 +0000
Subject: [PATCH 33/34] perf test cs-etm: Test decoding of kernel modules
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-james-coresight-jit-v1-33-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
In-Reply-To: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Suyash Mahar <smahar@meta.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

If kernel symbols are available, test that recording the kernel results
in etm4_enable* and etm4_disable* symbols. Use these symbols because
they will always be present when using trace.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/coresight/kernel_module.sh | 54 +++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/kernel_module.sh b/tools/perf/tests/shell/coresight/kernel_module.sh
new file mode 100755
index 000000000000..96bacb02b1fb
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/kernel_module.sh
@@ -0,0 +1,54 @@
+#!/bin/bash -e
+# CoreSight kernel module decode (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+# If CoreSight is not available, skip the test
+perf list pmu | grep -q cs_etm || exit 2
+
+if [ "$(id -u)" != 0 ]; then
+	# Requires root for kernel trace and symbols
+	echo "[Skip] No root permission"
+	exit 2
+fi
+
+if ! perf probe --dry-run --module coresight_etm4x \
+	--add etm4_enable_trace_unit > /dev/null 2>&1 &&
+   ! perf probe --dry-run --add etm4_enable_trace_unit > /dev/null 2>&1; then
+	echo "[Skip] Kernel debug symbols for Coresight aren't available"
+	exit 2
+fi
+
+tmpdir=$(mktemp -d /tmp/__perf_test.coresight_kernel_module.XXXXX)
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
+if ! perf record -o "$tmpdir/data" -e cs_etm//k -- true > /dev/null 2>&1; then
+	echo "[Fail] Failed to record kernel ETM trace"
+	cleanup
+	exit 1
+fi
+
+perf script -i "$tmpdir/data" --itrace=b -F ip,sym \
+	> "$tmpdir/script" 2>/dev/null
+
+# enable_* and disable_* functions always run so check they were decoded
+for symbol in etm4_enable etm4_disable; do
+	if ! grep -q "$symbol" "$tmpdir/script"; then
+		echo "No branches decoded in $symbol"
+		cleanup
+		exit 1
+	fi
+done
+
+cleanup
+exit 0

-- 
2.43.0

