Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879122;
	b=CdOZERE0oilJwXjniSTGEo0F8fu+go5alLcITpOfl8OHabdaxA4HK1w/Hgq1gXl0+OgS
	 Oqindrr8QCM0agsry/fakcwS5YgdAMvuh1s9naTvB3ae3+No7KOhpAG/bG2bzUXS26YOQ
	 OO9dAaX8GchEEVXw2d6YkVU9Qo6falf/x9d90SpehC/SD+6gjhyoZ/cyqSeFTGuMqjsA8
	 6C6Mc6cTFf3WO7lLjCDjvuEAV3xABMqWyM7LrqOuvSo/kmt2ZOIJJunKnl2lvvRWcFui9
	 aRZmbR4Ogs+yFdMbqqBZK/yREQhJTqRZQncCy3Amien4H2PK2s94d0LJK/jtBcD7F+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=1gLOJ+oRdJvB9ReiowSqgza8wK9JZkQFSd1XMDzuKt4=;
	b=3BsPOTZp7tP8nvLeBfuaWw7BSNe+cD3gdJFn2o5Jo4/9028FjIpEIfrN95LeyJhMuKxa
	 Y99hFE71WS/kcewy9MukszFdUJF3JB52BSRhtNmdyg9NCxE6OgZLbAmGvNAKc4Cp77i47
	 TGBtM6nx+YvNeXMnLCe3UmYn8Xu0FTe0HwjHCImLK0I19fQLQWx82ZErgFalh282XWRZU
	 8K4qbzAYcU66hH1p8YfwT2BpL/XUZVqGBtrX2X6vhv9k6Lekh/BH66aP6uY7ZAlS01m1D
	 mC1uNdznp2ULBcMKXsp1DQRHZgr6rlX5r288mx+wnnfNoocpnd9aHDCP70zWVwTctoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=joVS0CAM;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E6B6083604
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41E6B6083604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=joVS0CAM
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a210470b49so13101725e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793879120; x=1794483920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1gLOJ+oRdJvB9ReiowSqgza8wK9JZkQFSd1XMDzuKt4=;
        b=joVS0CAMa0SKohZWjb9chbHV4kMNIV8ItfYW8FBNXclEU06PwtyBYzEIFPP6LXw9TW
         5lD22uhuUR8Tm8yrTgdDLz052e1bF/TML0Fqs0NoQGA8hL7FA4fTqPBn3ypN8woraL0/
         FZ+Y4kFRz8Dkosn9ZQvPC6HQ5yaoCE6i/vfes+kZ+/qBLHrgPf0R9Og5YrjbzkrlOuGY
         meYvqAhLR/Wg7mEeMbVhJS7O3GpPrg5b++HuouvCVr3ai2QYTCovQXTZ1DWMTR6Hi2l1
         hbq1so9suDy7G4zHXu/uhRd0b1U8JPXXcdkPGmOysQyhusmBU7VfmHqENQemHUTWyzk0
         rguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879120; x=1794483920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1gLOJ+oRdJvB9ReiowSqgza8wK9JZkQFSd1XMDzuKt4=;
        b=FPz/sdCwRtvWiUSH4BiMen9NJeK/DUtX1Qmtg5+hcjuV4QvEAtsMiF/w8ciXOWLH2Y
         NCL+bpf+iolD/2RmtZTVEGWb1LrB0VAOS51PzYLC7lD7A2TFnAASjxEOitYiwpu3d9iB
         20tdmy+8e5HMOEvo1QNuPuVDILhWVq+Hdf6mMSlDbt9E/1wuzlQYh+8IHdhtGn1D4l4F
         Yg8rrhoGLpvMWRmkpr+1RZSankh96Ou5hF02r2zYqnyObLI9zoJ2QfNlQPsLk8wGD/Hs
         WsdD8CptAw1zRdapyfboSxmAOyjY2XGpQASAESgiWcOxJxS6Dbw8GxCaaO9kEfa4YSTU
         q62w==
X-Forwarded-Encrypted: i=1; AKwUvBxEphVcAK778v+7sElL7YzGQYpE2H0KBnN4zQHKbDj7ea/59KwJo7N0GePKpVv4DDmS3tnCyHARR4FT/bvpIi1X@vger.kernel.org
X-Gm-Message-State: APuU4Z+7gOQJ84/qt4zlEP+v38Ao+BEFeNrSFSiYNTpqzjXPPJsvK7SL
	DMgKql2kYbU5I/JtCaxE/h8OCcRPdsq19xvLRyG1lsu6DwyrGjCEW1ZLVTlnZS6S9+M=
X-Gm-Gg: AYBFou1gf8kExPdoG+/7yVSwX/VXhx9MCyVF2L+GzCvUtNRsjxSFWHc7blvG6+NuFde
	ZYoph+bSqhpoCu9vJ5AmKLPGjlwQQKMCFv1jOn015u84VN6KVvQf+7DMO9bwxz4BAa+UbWHnLzG
	vt4OQjzKc6L9Cx4y0/ue1ddYr7rKsBSlHBzmTO19Hvo1gXwgKWYmYchTzBXiwwu0savvf50lbag
	KISTHsfLfAm2IsAanpMNxZ419AyCY6aY6uSiKP47P0/hPspUPYakVPMi5CcdvD8PTXslQI3ZHq5
	D0DDcRlcNfUlVlkVqaXwqQTNzbF5uykhrK43TPmMzbe53OBkxzEH8SN+y1SHnqMgim5qXZWcIbb
	cyyjUOKdIL3a/qdW2DgNMGa4AnQmKIcLXiuyalJsuCZvXLNIeEHIPZDZgMEQ61rCrV+W9QAsNsy
	K3lQHPlewikuLKVv16E4cpRnPUETRekmhYDGt3EA6w0sv8Kr83exv5spoUVDf++2xeH05pqblMv
	ZOQa2D8hhOImZ9vl1RepLrozFdpihJN/dqvu1ATCDW/FytME9qoRMY3edW3xsm2+zv5n6pv9oXT
	TkMhhF8dPincv2EHFCwHE5otrNteIIan
X-Received: by 2002:a05:600c:4fd4:b0:4a1:e250:b191 with SMTP id 5b1f17b1804b1-4ac180f2ff3mr412219575e9.17.1793879120601;
        Thu, 05 Nov 2026 03:45:20 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm56679525e9.5.2026.11.05.03.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:19 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 11:44:49 +0000
Subject: [PATCH v4 01/19] perf cs-etm: Fix nVHE per-thread decoding
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
Message-Id: <20261105-james-cs-unformatted-per-thread-fix-v4-1-7759e0ce2449@linaro.org>
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

pid_fmt is unset in per-thread mode because we don't need PIDs, so we
can't use it as a hint to determine which EL the host is running at.
That results in falling though to the next part where EL1 is treated as
guest, which is wrong for nVHE.

Fix it by only returning a guest machine when run from perf kvm where a
guest image would be provided, which matches existing behavior in other
parts of Perf. The exception is when pid_fmt shows that the host is
running at EL2 (VHE). Then EL1 is always a guest, so keep using the guest
machine rather than decoding guest trace with the host kernel maps.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3e01b401ca6f..5abdd726c6d2 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1102,6 +1102,20 @@ static struct machine *cs_etm__get_machine(struct cs_etm_queue *etmq,
 	if (pid_fmt == CS_ETM_PIDFMT_CTXTID)
 		return &etmq->etm->session->machines.host;
 
+	/*
+	 * If guest processing hasn't been enabled, also assume everything is
+	 * the host, unless the host is known to be running at EL2 (VHE).
+	 *
+	 * This matches Perf's guest handling in machines__find_for_cpumode()
+	 * etc where guest machines are only created and used when perf_guest is
+	 * set. This also guards against accidentally using guest machines when
+	 * pid_fmt can't be used as a hint (per-thread mode). With VHE, EL1 is
+	 * always a guest so keep using the guest machine to avoid decoding guest
+	 * trace with the host kernel maps.
+	 */
+	if (!perf_guest && pid_fmt != CS_ETM_PIDFMT_CTXTID2)
+		return &etmq->etm->session->machines.host;
+
 	/*
 	 * Not perfect, but otherwise assume anything in EL1 is the default
 	 * guest, and everything else is the host. Distinguishing between guest

-- 
2.43.0

