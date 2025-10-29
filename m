Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F602FF176
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716071; cv=none; b=CsHr/+kwajlrZ2nGhbuvknfW6b8OmEL2qFwDGry4dM/G1f628ZridwpXKGVs/YN/cC/BInAnGqfzvxsP8+jzN/9eQ7NZP+4G6IcgACXcjlZ7B9IUIymnIBBBcIV4Hmsy6p1U5B5o9qdski/JxcSHveiTCNEK3q5jZ/mEVEy+IsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716071; c=relaxed/simple;
	bh=KYZYhoiep3KHKYom3Zxs1sXwmI85jni0UlVUbeI2XEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=R7gRaEHjlwXI+GsifVep+pL5ngtwCIQOxP5VIij3M0uHVoV8Wx7RQ97ekUs1jT684ERTuedDPCjSRT7EIhPjsCXu9BBzjnIz7/AndIhsD3igYHn95KfWpT/yb2SXShqHNeTonPNbvheZFkvpB48sBavfukzD3Yd9Yjrt7chCfak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nbw3OGJo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nbw3OGJo"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28c58e009d1so145453375ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716069; x=1762320869; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pW3iPoPH/G2JC3s4g+WDYgzHzmDlxJjv1jy/9KHXcKA=;
        b=Nbw3OGJo+rnt48QSyZgtHZkbDavdtp9pHR8BGGvWAV/+9xfD9Hp0ZVkMN8P2ltWOaz
         hficBc5jdLiDC3bU1JYwVaYGttw++/B9Sfk2Jur+2t3D+Fcf7MhMYghWAv0dUeaTojWW
         hzsybNWwuK3exBurgQtqjtS2HwyJM0Z48O+VTnTQom3zcWbF1gaur0V9pS8ctRapcK7M
         I+nxrvbkkY1qZIq8oVjvF6G64xdKYdJ7idselo5T0kfGN6KcnoZ7QCWwH3DugrCek2V4
         EDE25r3CXzVr0NUbR0ZAB0UQlYKR03CAI9l6KYqwsOIjDpKApgcy1PzOThs9ZpuCjHEC
         f/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716069; x=1762320869;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pW3iPoPH/G2JC3s4g+WDYgzHzmDlxJjv1jy/9KHXcKA=;
        b=WDFvEDozhqIBunWN8IKBo9y2hM5XzekwLtFoT33/iBJfE2rgiUKOBJ7aF8a6gbaaax
         GGxcEdKuNhW7VSZ2zCUqtNDndrP+KUn3XZi/H+mjj5T10yAYhlv2p823CIboZxndxkS/
         AOhgb/UHaNEH0SkcSsz2+sjLuBx+Kpp3O+TdEKwWZ/BOD1bixeKSdIEklVs92QMuPQ2h
         g0ezSoW32Bl5HByHtqW249LGbkHc7qc2ZPtTDLxeydwV/AOJFmf3wZmmAB84cW5yU/C6
         kKnDTijhsvXM3EfQadsDZ/4P7iMBYRvTcMW3+mx+ELocTIjt58G+kQAhpBLwn4a/fj+L
         93hg==
X-Forwarded-Encrypted: i=1; AJvYcCV/0V4FR5RU/OUkCN65XCd653P1dFaJQCErAcn6ByIHKecA7toTvkNT7HR3YoxTB7nVwp9mqOQpl/I5GARD7vqo@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4GudpQoHrzfe/tJgqmI84IZbawmjqd7fKyuSWaSelVeE92i+
	+NiZ1FPrGlhJh8fbt0+BHezdozZyEDTneFD8lfJ6MVl1mvfvDuLbN1V+mcjWfxiUV0BlhYbCL8l
	PqAwmzG0bOQ==
X-Google-Smtp-Source: AGHT+IHkOM4Uz1plX/1V7B8s2UzjmVdM7pC7uU+GhzKDrWisEtFUM/NjdRl5/HzXEOoYBKFOyAOC0WdbgzoV
X-Received: from pldu20.prod.google.com ([2002:a17:903:1094:b0:290:ab6a:13c3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1585:b0:26f:7db2:3e1e
 with SMTP id d9443c01a7336-294deeed0d9mr22357265ad.47.1761716069136; Tue, 28
 Oct 2025 22:34:29 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:04 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-7-irogers@google.com>
Subject: [RFC PATCH v1 06/15] perf python: Add add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix missing #include of pmus.h found while cleaning the evsel/evlist
header files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index fa5e4270d182..0366142184d8 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -15,6 +15,7 @@
 #include "evsel.h"
 #include "event.h"
 #include "expr.h"
+#include "pmus.h"
 #include "print_binary.h"
 #include "record.h"
 #include "strbuf.h"
-- 
2.51.1.851.g4ebd6896fd-goog

