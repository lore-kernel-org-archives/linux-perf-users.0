Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0992C25484D
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493614; cv=none; b=MSPsnk9xCIPxX40B1crN4y27QOrPrXME65UuXwsOkKEnpC1fu9OHbdZGZsULxrDFQncCz788L1VsVv1Jd0GhXa/nDCGvt8oy7JIRc1MUTb+hH3WYl4gf3OiIchacQ4/vCPCOez0tL5VhxiogL97ALTqEsqk4cH1EjgnRwk09Q5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493614; c=relaxed/simple;
	bh=cjf2fdD0rE5LRjT1VfJDou3dEpA6ok2BqEt1s5yCE/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EeSH3uWsU+x06neKUEo2yY2OGL3pPtystKW70HM5LH1CzW/575uTWI37R+4FUf0PzyEzC7/ip2FvSjXFPXKHNdBgEKIJdEcUdD4eKLsp9M0G90Y8oxTzd5bPZLMSMcnEwzCPBMAv+xjNi7xjG3AFa8XtqNEyYw4Dsel1aCSmjI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wogGTUHN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wogGTUHN"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74292762324so410497b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 21:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493612; x=1749098412; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9aS71aJOPEt1sm6kO8E07x1jFtf8Q1JUjXvJGHfQ3qA=;
        b=wogGTUHNrDIU+iVL94US5lFwyK4mGKJPQYMB+HQC8ui+QVv+9LpvzqnK7ksHnvWhz7
         gxRXD3rRXmaI2vh6XVhk7m9im0103Yzvv5Z6rb+acnChjBi+vd6cCPZ4mqMBOyyb28dL
         jeZRdX/FirD2KqGtk2fzrcQaCbfwPGEYkn3dA5Bk141uytbQq8VEaeHNDSrtWCxBjFoo
         k+uS72788HUwV7IFEfgp9qHURLivTxgmXQMExO0aPsFNUzyzXaJ7paYODlqgxJ2T86Ci
         UGCs2Vgbxc2vFiNMiXgBZcCTABqQEuxr5Phn9SgGlHZT+Zuy1yh5BxY6nTSYzGyfq9S2
         PlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493612; x=1749098412;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aS71aJOPEt1sm6kO8E07x1jFtf8Q1JUjXvJGHfQ3qA=;
        b=OaZMr0qAEB42JjiJRf4nT1v0zpSk7YnDnZCqIpbhtLTW7E7T//ozwtVbO+earKjaPT
         oBJOow/w1N+qoOpnbf3hfJY9jKTzB4jrke4ApGalP+GmBmsGbQDf34KbkvWDrAI5tKvm
         3cvB9AzUcaQwHS2TagqNdpODopMD9Q6aXHwiVoHgVQN8SmMPynTE5S+AciDNfGtlI7D0
         gqOJtj7dvakqHJfvpcu/RolSJ55OmkPnt+czezol+6E3vmiNs3BIadDEBTWgu17e4v6K
         MlH3gsmHCuMT6TgDGLha1LDUpEVgewztke6IrlKKvq1JYGDLhqmhBDT7Ecxe+Bv0qfo8
         7t2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUs5lg87jRzMCBl/TIlMM+xRe4LaQL9OFS6H+8mUPMDllyP7tC9o3h82UqYKxHUCPwLhs2v42B7sGu9R1hHPPV7@vger.kernel.org
X-Gm-Message-State: AOJu0YwUnDhW7ldPvyPQ7FuSHJfPqzz+2ey5EnaUcgXuSSAZ44hm2ziL
	yx5yEM8Da0+XNPblWBtikVcPITWqSV1TH/IQ4SCDrhjA/yQbwPU5MKmYzWj5YxmU5IwFNOn//Pm
	bM0EKaWvBWQ==
X-Google-Smtp-Source: AGHT+IFlKCkEqX1XRqJjw3YEn4vn41KmuiPbLqe3e6dAoMnichsXHqoCMaXHDL0e/0IqWUt2otPig48NXi89
X-Received: from pfbik10.prod.google.com ([2002:a05:6a00:8d0a:b0:746:fd4c:1fcf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4654:b0:736:4e67:d631
 with SMTP id d2e1a72fcca58-747b0e79bacmr1311000b3a.23.1748493612073; Wed, 28
 May 2025 21:40:12 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:39 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-4-irogers@google.com>
Subject: [PATCH v4 03/24] perf build-id: Truncate to avoid overflowing the
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
2.49.0.1204.g71687c7c1d-goog

