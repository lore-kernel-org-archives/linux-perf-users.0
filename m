Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6DF1586DB
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018515; cv=none; b=bRcqSvkc8UPyksH7OcacpHw77b0hbMlV4YmjYGdPJnQbGTzERekjVMWXcdcjLevXG2qPKnooGvKyBExcraSGD5NnJo9kcKgACY8WhruTuPLYeaLmajWvu76PnyOoACJTbTi7ZsqVeUP0j6j3orlus32DV4vm4twl+tb28FtGAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018515; c=relaxed/simple;
	bh=70y0Uq70fTi9vP6E1n3v/21p95xUIVe00JfnSvODJ4M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WJzdAxPcvj/vvTThUKJUn7K3DQMn2kqojQYP5wRX8S2FE8bFnVknkBqbK4POmEVsQD5c356m/dXT1ai4epN3Gc1e63XYvHkjHz9as1JX+q6jB6IDnX6dW5Voa0xwboFQBI50C/i73lHD0gENOGm8GdyR5L73JH+XPh7RxB/a224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a3Do7Wgg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a3Do7Wgg"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de604ccb373so3833912276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 06 May 2024 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715018513; x=1715623313; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0nd3szNl+OFQsnbvKRBpAQwbxRmYTuaSHyM0OpbQt04=;
        b=a3Do7WggtAq/5DHafmiQOhbax/yaC4GHim3qOAatI1BlC3x5AZT5wX/uybqHQJDNE7
         qAtmCSEVk1tRrFVmld/ZOyBQh8B+VSDW0vDZ79lRYOLqeJNXYJoO/UQJHA4vloaqCFlS
         zMU5+F+jdESru34V8MJIphlIw7a9oHsbfDaqEMMBoAbHOGnTBP8W9g6q+4XW/xt82EUE
         Gk8gopvwIPqMiJ4X6EFC+jNp+RTgcgneFewqDfDi+o3ZJTm31Id28g4golaHQ7glpuoQ
         Vk3EvqFAPK8a/sLHg7v4ZmMQIjj69FfByHCGV1gdmsRN4NNTN2ohlPDRi05g+NUBIWV1
         o1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715018513; x=1715623313;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nd3szNl+OFQsnbvKRBpAQwbxRmYTuaSHyM0OpbQt04=;
        b=dwMd7NLTUxnEnd1I3paL+AZ5AZ4bOkOsSCzeIe42nPQKS+uZwykZ6z0s/auMdkEMEP
         3hQ/GDmqQEvakHrw78MQgfPc2AtK+JZfwy8bUzH0DVN641Rna9LVbWGpvGVikg+eK17X
         eRGf1srgH70MwF9nGR0KBMaSZ9Z85l1ul+S/KiPpMznQXpqc569MF6x3/f8FpQRCQp9B
         LrhV73v35qcup7dG81SNfcB4WWKrEJx4qbUcvctLEK/4BQmsX94Q7rQ236gARQdzEhcb
         GsGo/1hwVUtJsiej8vnFjNx2Q7NstfwrziSxKzCs/gsD3qldtf+ypONVxRV1Hra1odOZ
         Y4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGfTN5WAOqn2OsT+IH+o67MFobq8WxbZdFLJ/upgyebcZXasVuP0Z7Xef2vHr1bzGagMZcESVk4hjWugHICOYcQtP/DvlJ9YR89gL8B/PlUw==
X-Gm-Message-State: AOJu0YzadHGYUZ5zLgEDrWle2qgsiFv6k0XQUNPR/pWt03zZVuB7pzMH
	uOh9PsS3IpYBSpDmCnZVKqnnvx8CUly/kK5Qxz+8NVeREgLMnuM5DhEC+j+ZDX6jeFMIejTz9Qm
	UjEBMAg==
X-Google-Smtp-Source: AGHT+IFIF+mKPfdZA5z89/oE5y8/Z4uzaRdxsq56RtVsVl63c4Yu6VzU7+jSmmjQuDKupcDjwG02lEt15AT1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91df:9b7f:c8d8:409a])
 (user=irogers job=sendgmr) by 2002:a05:6902:726:b0:de5:5693:4e8e with SMTP id
 l6-20020a056902072600b00de556934e8emr1533970ybt.11.1715018513213; Mon, 06 May
 2024 11:01:53 -0700 (PDT)
Date: Mon,  6 May 2024 11:01:01 -0700
In-Reply-To: <20240506180104.485674-1-irogers@google.com>
Message-Id: <20240506180104.485674-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506180104.485674-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v7 1/4] perf map: Add missing dso__put in map__new
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Changbin Du <changbin.du@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A dso__put is needed for the dsos__find when the map is created and a
buildid is sought.

Fixes: f649ed80f3ca ("perf dsos: Tidy reference counting and locking")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 117c4bb78b35..e1d14936a60d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -200,6 +200,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 				dso__set_build_id(dso, dso__bid(header_bid_dso));
 				dso__set_header_build_id(dso, 1);
 			}
+			dso__put(header_bid_dso);
 		}
 		dso__put(dso);
 	}
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

