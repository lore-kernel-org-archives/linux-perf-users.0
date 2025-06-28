Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A09321E08D
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086238; cv=none; b=GmCazAShtoZMGV7ihxSc78KbuXHiIFTdbySHifAwC6BcYnMyCbZebKJg3BXl/6D6Bt8Db8x619g487SVNp3v8xeuqLTbzgsKlPVLKAaAD2EbDwtsONRoVWIiAQMSdY9YXcyBx50yQc7lngCtBw7ECd9cWUHRp7FoqVukjcoFH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086238; c=relaxed/simple;
	bh=6Kaw3YeDSjFMbgSGwOQqcOiX76bLmOxHdfk84Y2TCRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ATMalwyQXRaput7mVS1fVut5mAnO6uy/Op9ErLjJxJVwLPHXSpsAfpAWX/gJagvOHEfEAjb3cNiI7b3QQYr/9SWzOnn4XW1Hnp8LJExrIq3QNGSLJx93OnYHpvuRq35xkFYuxPNyzL985mgrtd8qrgSM7DEquOBqGuDOq3AcYoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJ9QizWo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJ9QizWo"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b34ca003f1cso443480a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 21:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751086237; x=1751691037; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gpJDjPIAX11d0UZM38x2TXJLxVO8GJl81BGUasQciyA=;
        b=PJ9QizWoHEea7/SLX01bTZEjA5opFbGf1aPXoKFtYdxpvyjG4NrVM2r8jOUJTyeU7/
         XAKRb3k29NBgOdP6bHDO/RYyK0JY27xAIpbqL6QY7q7QpNipmElW72qQOXqrR9W3eMVU
         uTQ7nTpEyMMZtlb8ecRMFaKhSZwF0IoE4eRMpI4nuDYZvgYhrpmvtCQI+rmL+AheoAF7
         UzQtQk1KPMqfvtpVrUU5mM6O9Y8GqRySfG8VzPH348n3ZcnVVv0CGgrFsKuwvkqKG0dN
         2bL2Ew/yk+u/mechpMPMJ2uM1fLUBhqD2kZNXtftTM54wwDbBVjVSwIqXwJHihxkTt6z
         /dQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086237; x=1751691037;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpJDjPIAX11d0UZM38x2TXJLxVO8GJl81BGUasQciyA=;
        b=Z5s0UWaQty4UatcGszYmGGHX2fyKSu/FLfg7sqJzqy67qKPc5zwDuYT6L4yA2ifPke
         sNZ9qfJbH49EIvLk6MJjuEF2UXrF6ehgWcVLZBQzklSeZ0ZCwDB5NCJYbozu9Yn3q+46
         A81D+1H9JRpKH4HxDxlg9k0wQlY3XbBhvujVb1uapMcadfy0r4QZaIO95bI2tt6INnl2
         gkJ6t2hAT2HP1eWYelcOm0049Ec76+xWVmPjO9Zn6z6dLuAp7WJFui3HbZXaLaXguwWy
         71QucE4DGRuMHO/jBOKbkdzo5kBc64LAaGFkMdFnwtapAuhy6oeZuhzpVvuuOKZWEHbz
         ZgBA==
X-Forwarded-Encrypted: i=1; AJvYcCXUcGP19aDYPVh5HwpFmlDaX7DqUPDlr4YM5KGgylH1X+vihoTCcoZ6KvGqNvZ5GEdm1Ojpsje6EhxyiNnLEqR1@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZkhICwCYaIwl2T//pH3nngd+zYsoRonKIsCP5qgFTASOkHqO
	GjG/8vB22S28L7cMH5GeTALCT0A5kN0QTEb56Q70Ng+DODnmx6DIr5rVOX6RKWXdQBZ+cIChK1n
	NTifWNEElgA==
X-Google-Smtp-Source: AGHT+IGWtvZQ+GufKNFStPxwXpoFd5BmjC4KaSWX/cbvB1fYzET22HcvfVJhQ9LyAFveIqQN1HBBPDZ8vvQd
X-Received: from pge19.prod.google.com ([2002:a05:6a02:2d13:b0:b31:c9e0:b48])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3387:b0:21f:5c9d:498b
 with SMTP id adf61e73a8af0-220a16e3a86mr8856736637.28.1751086234602; Fri, 27
 Jun 2025 21:50:34 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:49:56 -0700
In-Reply-To: <20250628045017.1361563-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628045017.1361563-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628045017.1361563-3-irogers@google.com>
Subject: [PATCH v5 02/23] perf build-id: Truncate to avoid overflowing the
 build_id data
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
2.50.0.727.gbf7dc18ff4-goog

