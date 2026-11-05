Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879139;
	b=kgCgHyk3e6+sa5bv4q+7QCtT7MjEae0S6FITgpopwggUtpALihxnRCuZmCblscnhGs48
	 baUbkERE7aW4RUzUzoKbnRI8WDAS8fooZueEFIP2opwPgaP9gBtTg0Pv7lR/nGDiUAgeH
	 UmS4JFqCdHYYkEtdwNtugyagQxShwQvnd+Ny/x+O6mHwUkpaoWuTQD14WAf0APPubWm/S
	 RPIobpYYU6nyGPS4USdHX3XuW40zj0dPqARRblV4aZj06VpbA6BDqKozu3LIUji84ue9t
	 yi3R4KprZV4qOvigTsDK55G7uUOq/l+u2IQirdvNAOUkgwZ44aRAreYekaLRb2PVi5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879139;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=o1EbclO0CpwqePVCV1L0T+e9zUmbTQ8j93ZAYJlyj8s=;
	b=JyZDHY8P5xg7TYbiiEE96WeFytADFqRQ+2yEyFH9Q1Xm8KHYnWObAF0nN6478MFgeHjv
	 CJzPnbCdJtfo9F/8GWECGea0WhSXe4YwzpwdQ5KL/xgUZ4+Nipvfa6bYSdfJ8FwQ5pWBI
	 5o8wNahxjHbUYosV3ADAYOmVZkv5h3MFC6d1T/hAqzLB/uL65wjrLWJ7RvV9jCdqpHLLp
	 sc80Vp4gK6cq1HeZ9gIYK5vgpEdNPWTGN3ktXiMA7AmJ1u4vNxbKDee1e9JuX83cAbySg
	 P9msPJNJWM2rl8sjTe38kEi6gXP0r2h2yzw2lyUQNqMS5woaihSXKArufoSNkO/jUYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OigcssTz;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806366073ABD
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 806366073ABD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OigcssTz
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so15901415e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793879138; x=1794483938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1EbclO0CpwqePVCV1L0T+e9zUmbTQ8j93ZAYJlyj8s=;
        b=OigcssTz7nlgnoizVRlOpjIfNlQMYxJysGX/ivmf+5x9hf+CVPMsH9KryAZiQw7QH0
         /vqu41gvJKAP/y1qSAFLKkKZOw8CEuFH/f+bZ4FqYdVMwuLuJKIApP4ttly+ygvR0Tyg
         XC/5SMIxNvfOlglFtzrfvTgpgUZp/4LjjySPCBlr186qqpYzCXWzsqYjqNkHp+4qLRCe
         kOn+eNXThLa5ZF+ZVM+Wz4/S8AughtTgPCkslwnvK+IpZaAbxpr1lvvmH0xA14UNn6Al
         Nu3ZwsuxJdZFCE1Ud7yeN56/04ZPKvVO7rzJ1ddbg9ixSFu/7V1SqdvOijX27wuuNGoW
         iE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879138; x=1794483938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o1EbclO0CpwqePVCV1L0T+e9zUmbTQ8j93ZAYJlyj8s=;
        b=UQ/7LD+og77cuzquIaXl9Ieq/JQcR53VWU/zUQC/iz9zAzDSc5PpVvSnUXthLUDOtk
         GnzAXqLYAaAtdbV8nVGmQBnUY7Qga+tbTasZ66wSLFzrEaUBHnXqmQA1gM0vPAbB5aW4
         BMvuiy9nIV6Xd0uk+BgsJ5CuvXl0R1ZQ91awP9poHeZYvgGSDRpP37ZMhugDcqSsHm6Q
         PeNbga1dxZpy3mAvwvqtEXeB3qa5J1UGdzjMrs0OMD6W3v1EMqTCB2TNti+9pVn3euyr
         hdBWlX/69Hg1/HeAExFVP/S+7qV5Z31Y3O0Y3aBshKFxYSL/KDaT3gGv32q0y1a/tBZZ
         qLeQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1nsk0iENbiyATIEOZD4p2SLI/Vv0M+Eu5/MvRvO5niur99RpPdEo/SFZoVzx6dvQcTDNKJQ1cV5iEm8uB8zs/@vger.kernel.org
X-Gm-Message-State: APuU4Z9x2WF+NoJqQ3O1eCh1XifNFRHm8i0kxXw57PnwRkaxA1h/bdsE
	L45xM3A6dKNVS3nzw2/G8hSOGVY9ap3KM9DpKGHvXYtAXk8mazlO1Yy3iCGlfvZaPVI=
X-Gm-Gg: AYBFou08mNvMVoj7d6QDVheMPj/hvVlzBrYBPg2JBKeLt+vlqJ1uF2FjBkpDfPOL02/
	cuCkp7w0se3e9V41pcal/Z1sXd2teYcWNXvL7VnOwYcoSB8TxVmlIOMpzBrdvPXxbcnz6NZVucU
	VxguCKKKRwRLaovU10yfL7teB2/T5PSGtcZ/OgVNzs7jcJL1Of0dp83yWGJ8aRvxT8VtmEY9IZY
	+7faflClqA2zQkKfYyLntZUsnshqQh9k8jX2+jAPCtev8hlKj8rC8FQl+rKb7PTPfN/4h0AySrl
	kyzMiUwUwbAlrACTGI2hmfvr/x/4V0qxVmBmwjHbjRF7nXlMYS+GYmKktismhwieqiO1FFFVJZC
	uWgsbCj9c3Vvg7qV17B+Cc28GFrgLHkuZZdkb/+CXx214yxoZzs/8j2ZBz/QiWiNHx7D+/9sPSx
	WUgUKkMjUQpcjhJzLuQEfiefTVm1OEP+YU4aVUW4EZwvVVMTZCLfkoFtxWU9r45Vb/xNua6o/YW
	d1tWA/dtihEX7FQ1trSpsEM4FWtpf6Xx36vd/uHYtylQTImTvo7u3uhVoDpnyT8karFZjBk1DJi
	/eiYRuuZFb3HDA17tRTwyk5EuuoPjYFD
X-Received: by 2002:a05:600c:5295:b0:4a1:e92b:ae4a with SMTP id 5b1f17b1804b1-4b3c3545146mr113538265e9.21.1793879138032;
        Thu, 05 Nov 2026 03:45:38 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm56679525e9.5.2026.11.05.03.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:37 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 11:45:02 +0000
Subject: [PATCH v4 14/19] perf cs-etm: Don't print missing buffers in
 snapshot mode
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
Message-Id: <20261105-james-cs-unformatted-per-thread-fix-v4-14-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

The driver produces lots of AUX records for trace data that was never
captured in snapshot mode. Downgrade this to a pr_debug3 message as it's
only an error in normal mode.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 320164645f61..51431a4d5db7 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3361,6 +3361,9 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 	struct perf_sample sample;
 	int ret;
 	struct auxtrace_index_entry *ent;
+	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
 	struct auxtrace_index *auxtrace_index;
 	struct evsel *evsel;
 	size_t i;
@@ -3414,8 +3417,10 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 	 * don't exit with an error because it will still be possible to decode other aux records.
 	 */
 	if (!found) {
-		pr_err("CS ETM: Couldn't find auxtrace buffer for aux_offset: %#"PRI_lx64
-		       " tid: %d cpu: %d\n", event->aux.aux_offset, sample.tid, sample.cpu);
+		int level = etm->snapshot_mode ? 3 : 0;
+
+		pr_debugN(level, "CS ETM: Couldn't find auxtrace buffer for aux_offset: %#"PRI_lx64
+			  " tid: %d cpu: %d\n", event->aux.aux_offset, sample.tid, sample.cpu);
 	}
 	ret = 0;
 out:

-- 
2.43.0

