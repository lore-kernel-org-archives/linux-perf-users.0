Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70031DF24E
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475594; cv=none; b=t26gzbcoJfhJuP1LcSktCzClSutMM9h66QR5QY2R5jrWn4DVvkL0X46HB2ATgDT0hTO+l5n4uETSKLRgWrRXkkfSv94VBRLXrxr7yBseByACTQPcwb/yC3lVKFEuEPc3tec53aSM3XeJurSKUw+MA5ot5HGfyeEQTPmX/QLowms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475594; c=relaxed/simple;
	bh=Lb/YeGLXncWYBNdkhGT20s0Yot4+J+u/9UYr8SPdloQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IqgCbetql95JnPGGiZACE4iIExqksgJChSZ6VATl1AG/F9t2Qp2MaFYXhcbnv2cjfQedZjwdTOZKPFgxJcEZip1UWCk10BCQhsLB1N1KR5zrSWVfUf5P2QPd6Mxbr++iQVzO1yj+gE1O+l2OTWMOUMIRlmYdKqs61/jiOPSIK0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yjaH60Ua; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yjaH60Ua"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736b5f9279cso560175b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Apr 2025 23:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745475592; x=1746080392; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BuK6SffuhbPTlhkbILGQsvEsS+vrJa/bVOZ+xV94WkI=;
        b=yjaH60Ua8zsWJ47Fyox4kPrjZILnyASygLgJbTc0aiqXSoMqgmTcghI88Xg+J9a+wJ
         LdnvF2y7BTTCaXmp6rHzXd78TOgC4Xy91jDETluyPAh21rxmvKUuvhLMYYzJ8qL7XfYb
         a2uQiP94J28HF+MuZ2IRe5+XHQU+rvwHsdZ08PSz8BiXRqLR/IhZ0/19XbcXffH54ozD
         PpB06N9JlaPRDCE7Nx3gPx1uburrC9U70YQQ0JYlr3EIrHmHSiqEm611uvOqEs1pYKjb
         8Xn6kJoe/6Sg8LVe+1NzTLfi5XIw+CeCf9tKqWqvCDuQ561asvGPVlWB1SFIpSsZRawT
         gpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745475592; x=1746080392;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuK6SffuhbPTlhkbILGQsvEsS+vrJa/bVOZ+xV94WkI=;
        b=jDjCw6ebTlna8mW3Q7sliKOMGyxcX1PkDxdgx/60scSxVM/tdQ5aflfUN7gtBj1xR4
         9i9LG6CJQ0hth6q9cp+4ebxabGOjqmheBeiFOiWSsM4V/nofs9bWxDaLg0oGmyaE0dHm
         UCn9EwJXTEEZQJXmyUXP0aeOA6nE9/+8p8/CeZ+yXJq+B8A0v1Hh5LbwILHCXbF9FMM+
         OKax3pXOCkm1x8m+R4OtjEdfPT4mRX5SxZxT2uwnogGdOj7eQF4+vJsv75G7gF44GGM0
         iqI0YT3FPbT2kTx+PQoVh/c1HuVPbu7emVhutfCOwv9sjNrCJMV+WUf+qBurJ/zI+ROt
         3OoA==
X-Forwarded-Encrypted: i=1; AJvYcCUnCALZB4RVWQpvHUjoteaL/+1kQA1LwQYNX71jsxdl6mLs/MPpxtfwkdAB+XrZpjZzgKUm7jWx5UXv2OQB4sD9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy1yME9wwsEL3+ZR62KeUuYdzxRY1MspynQ6xM3nYT8F9ROPXK
	HEkvSJ6aH/2z+sZ7hPTgRomXAH3taqMm3aMOzK31IrjpCwmsDnv3DTLY3/3M+OH1gyfjNFYSV3V
	qNU8zqg==
X-Google-Smtp-Source: AGHT+IG2GWeJwdL101iS7oxbv6AKvJuCKccU9bVWijePyQLiL/hUhmFnZRrtdWaS/plLdDtxY0SMICJFHpLu
X-Received: from pfbfw9.prod.google.com ([2002:a05:6a00:61c9:b0:736:415f:3d45])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:179d:b0:736:4bd3:ffab
 with SMTP id d2e1a72fcca58-73e24abe8c1mr1761157b3a.17.1745475591884; Wed, 23
 Apr 2025 23:19:51 -0700 (PDT)
Date: Wed, 23 Apr 2025 23:19:40 -0700
In-Reply-To: <20250424061943.1321025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424061943.1321025-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250424061943.1321025-3-irogers@google.com>
Subject: [PATCH v1 2/5] perf build-id: Truncate to avoid overflowing the
 build_id data
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Michael Petlan <mpetlan@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Leo Yan <leo.yan@arm.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Warning when the build_id data would be overflowed would lead to
memory corruption, switch to truncation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index e763e8d99a43..5bc2040bdd0d 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -951,7 +951,10 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
 
 void build_id__init(struct build_id *bid, const u8 *data, size_t size)
 {
-	WARN_ON(size > BUILD_ID_SIZE);
+	if (size > BUILD_ID_SIZE) {
+		pr_debug("Truncating build_id size from %zd\n", size);
+		size = BUILD_ID_SIZE;
+	}
 	memcpy(bid->data, data, size);
 	bid->size = size;
 }
-- 
2.49.0.805.g082f7c87e0-goog

