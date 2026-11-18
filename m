Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019426;
	b=s6ZfjOfb2MV4e03GVQnWKTD071iqnbJTennpVl2mM2fxUCtduK3NZGQWA1vwlwFl+ugE
	 Vqr8AojBtVJpTbxIs0VowjbW5MWoubVqSOS/aISJNaa2NMvUKBnPEoMZDU8BJ8hD2HL7a
	 PtgFDzvr5Uc0yYdQ9SiRNb3WVCIur7ONACorh1dSKkJds4ep//poweJyx5u1y53ZK4GDs
	 nTKfk22hnaf5Pw3ij4Lt8NSssStqdHUmv9INQcixJLjs9QYG5e//rtaPy1G+JdyIyi7F8
	 NFFQU3NhfGCXkPzLB8ru+bQINj6wka1wVOKwTKIK5hOn8oBlHWLdi1l5HFQtA4LnC8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=rTvXpEQ89nznZPWxi0xSOEtJetC4t1T0N57WoEYU+Xo=;
	b=LWMb8gzRRL+CZiC4zdIQqtLESKqVDnuUxm3USsXWhZ6x2IbOlPvwHBwHZbffgMXKwSts
	 vliZfhTGSYW4SnIEndgZGtWB6SbtJelQBgqvHS346Bep7qtm8bB2RYx+z8VSamMvbPUr5
	 Og16n+62pG18u54xUrLrvuFMQqXumR4igjap2laTP5EpIU6YOoMeifVM62OljkVhdGeRZ
	 MY8WovOlV1CzmUW3TQQ61LgNcTMyjuWn2u5Irqzk7ROVnth7lWuAVQxo8DCKpyQKrYCAR
	 d/xSrB8iFe0UjkjTkp7ccISWfZdXyJZweNHoQPRNj1eE/YEiNsfQN3f8A9aqoiIj8RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="Yeh+jj/D";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28F606C3F6
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB28F606C3F6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yeh+jj/D
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso18094935e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019423; x=1795624223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rTvXpEQ89nznZPWxi0xSOEtJetC4t1T0N57WoEYU+Xo=;
        b=Yeh+jj/DWeDX0BS/4Oc9RoegdgtuIJ9ndtbjZMAX6yPzVp9zM8JXFnXOt0XgYDz7a0
         +KeYphCNBupAdUxj7GV+R+HaxarC5DWXvWwJIYNyOOoCiVRs9wJmoTtKf3tlxuzNPV+C
         AUUQTZtrkdaWBvuQCwr69SGDk39XGIKHd+YFqfbofHRnSTCumOk38itvQdBRueVgXEGz
         Hn+t1Q95Qfyr3DztGmESGYtZ5NBZ+m55qMMYezG4tOMgjI6eoZBTH5CXI7lii43CFZG6
         WYgmoLAg6PrbCPSRwRhHVsctExoKg+mtShbYgdH1Hbs6oY+9hGbsC12F06aYtNKXtnKm
         pdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019423; x=1795624223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTvXpEQ89nznZPWxi0xSOEtJetC4t1T0N57WoEYU+Xo=;
        b=Lst9edsbusBOkONtnoyuiwdtpWsjOysH9/zKfDbf/vdTBT920aiB3ksgl0FGlIge6h
         9Kpzbdx23BmT8WY7xS8Aeiz9GPPq0LM5oJE23jSSJ5/sTDRxb1CCh55kxJJ0dWP4RivZ
         dWpFq/yu++AaYPGtRcRiXeny+rVzkrfKdJoBgn35A6K8CUrCapGvC6QF7SHVJ2c3WqWn
         OtM+3vxz1pBmlGBlWAXkHHUvarEghaAt2eB4hRCpde/mLnG+EuZNbS1WIrb10bBmdqKM
         7RSM4eLsOVirmysNhzD4mOczmq1/K+yRADNMSZ4i8zqauOBlRWJaVP3NDUvqqITwcS4S
         unzA==
X-Gm-Message-State: APuU4Z8T4p9YkvR9LevoB7WiP5QQj4Q13rwFppqe+yrTPaOaB+omyuUB
	2yVK2p3seSAlLPFbX7zwdDGUPv0Yje4F+W+Zxj78lweyUGf0V5q2En0Phid9wsrsMsE=
X-Gm-Gg: AYBFou1M8YKmlVA0BSU1t1KDArociT3iY70MxbRlqWBKEVhYlp7Iuh3TT7WB6WT52oW
	wcnAnf6lhXHoaYkFUyKdHsEv148VhSOwVgorwrX7yS01POfSEw6VS8Ows0gmY7peFQ1DOQx3+rh
	ZClcR7jXlaDkxKlCze6GNBW08kPk+vbyrQZ0r/oetr8knNyEdOULUXBTqxxusethz7Sq1hc8TNN
	jMxbZoC3bORpytTiXoHuzOugAVPmj4Ms1t8kEVlK+kmD4G9eDYk5a8EHKd4DQpcV1GszRCpDK2N
	CEJecEB1iRadsmMWRNhPJ9FdzbO4+iE7zRdYWGScQBFyGwFwVaSlMnKcCbxUTP82l7DXTnyHl1+
	YjXc+f/B1Y/yn1cj3wob2/1jq7iLQgAqOGTk6qfFcH/viO9pMURudPFgD1bsUlbBQ6sS67Jed8k
	4q44nhpxv/qTLkS23ctxW1KUptive5v7WpTCIDvk0/rl6tN3+HbHCE4jhr3PQ8hvk4tPoJSboZt
	GBLGREAvWk0P5PNX8WlksNj3UmbBpJhykLUU1YFa6+9tW4PLJVq8S4wAcrURmc/UX/GYt5zsynA
	eqQcM877XkGoPM3aKAk1NFI6zaTmGQIzd5Jq8AuM0Y2mj52N92weZw==
X-Received: by 2002:a05:600c:4e02:b0:4bb:6994:abf0 with SMTP id 5b1f17b1804b1-4bb7da4b889mr64509715e9.23.1795019423221;
        Wed, 18 Nov 2026 08:30:23 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:22 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:54 +0000
Subject: [PATCH 32/34] perf test cs-etm: Test trace is ordered with context
 switch records
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
Message-Id: <20261118-james-coresight-jit-v1-32-dad4d90747f6@linaro.org>
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

Enable timestamps in the context switch attribution test and add an
additional check that decoded samples are output in order with context
switch events.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../tests/shell/coresight/context_switch_thread.sh   | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/coresight/context_switch_thread.sh b/tools/perf/tests/shell/coresight/context_switch_thread.sh
index 2b9c44b86c59..584661cf47b0 100755
--- a/tools/perf/tests/shell/coresight/context_switch_thread.sh
+++ b/tools/perf/tests/shell/coresight/context_switch_thread.sh
@@ -55,7 +55,7 @@ mkfifo "$cf" "$af"
 # Pin to one CPU so the two threads alternate running but record into the same
 # trace buffer. Start disabled and use the control FIFO to only record the
 # workload and not startup.
-perf record -o "$tmpdir/data" -e cs_etm/timestamp=0/u -C 0 -D -1 --control fifo:"$cf","$af" -- \
+perf record -o "$tmpdir/data" -e cs_etm//u -C 0 -D -1 --control fifo:"$cf","$af" -- \
 	taskset --cpu-list 0 perf test --record-ctl fifo:"$cf","$af" \
 	-w context_switch_loop > /dev/null 2>&1
 
@@ -65,5 +65,23 @@ check_samples
 perf script -i "$tmpdir/data" --itrace=b -F comm,pid,tid,ip,sym > "$tmpdir/script" 2>/dev/null
 check_samples
 
+# Decoded trace should be output in time order with the context switch records.
+# Allow 1ms for estimated trace timestamps.
+perf script -i "$tmpdir/data" --itrace=b --show-switch-events -F time,event > \
+	"$tmpdir/script" 2>/dev/null
+if ! awk 'match($0, /[0-9]+\.[0-9]+:/) {
+		t = substr($0, RSTART, RLENGTH - 1) + 0
+		if (t < last - 0.001) {
+			printf "Time went back %.6fs: %s\n", last - t, $0
+			exit 1
+		}
+		if (t > last)
+			last = t
+	}' "$tmpdir/script"; then
+	echo "Trace was output out of order with context switches"
+	cleanup
+	exit 1
+fi
+
 cleanup
 exit 0

-- 
2.43.0

