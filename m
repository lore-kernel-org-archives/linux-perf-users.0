Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96863218D9F
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996454; cv=none; b=MIVwZ6YKpFK92XnyoI0hVMRCu6FNksfSp2u+y7w1sNi5hczx/YUZZb5k16mJ+UIsiDiTtuQR7PVcP9JeXRAmswmeB16nsvSA5l5YzII20QYUxT7NfYik9Tmy7LYsfESuBkNj26yalpuyOgpz5W/JXcUuXl6xKcdxBMs6XStdEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996454; c=relaxed/simple;
	bh=Y+vKqYUCxSTt4LSzTKZWPT5tUEvVlBLoT2ItWD2c1T0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HkIx4cgnSI5fVWXs2Cmy6gs/+dz+2vmJ+NHTXKUyBXlqdMUi9dJBMIYU+7gVqX1eNxH6nwKNgBjfn+17bm2TYUaaK2d0IcvnS0fAVIMgIpIfrvME86Zs+k5rrJKJU0WAPM1j3eAkIJ6mgmwrQuyys/qf7CKHcZYaCrA+e4VXvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TigUJTlb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TigUJTlb"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea258fe4b6so21406867b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 08:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730996451; x=1731601251; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0JtSX1ivElzP67Gy896L9Ack6oYznxDX7izzc96bZIU=;
        b=TigUJTlbcdzBY865SF6TLU6X/36VeQI3ZTNC4uTDQZFQJYYJkBAxuRx+K+f53SMgfy
         t7Qi+YTKICuy5pqQAVs/c3FSG7HXbGWHzf/AdzQARPhEs4QoLJPryQ7lBT7AKdDL8T7F
         genJS5hKBtSIeDfiNcdBeAK/STK80P2STSnZ/xdMPILTQeufTAOJeh77yW6jXaHBS5PA
         AlWsBIXijR346CfOlXArkF71uVPe+utcp/QneDZ0Q/GJF2kAsmHD4GOT4i3yUzXLAAbu
         QrY2Slc7YSTTH+iiJ4U+bA7g2lEVEuhjscL8heV+o4BpqC9Pu5hiXKiPHG+w3VhQBUq5
         LQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996451; x=1731601251;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JtSX1ivElzP67Gy896L9Ack6oYznxDX7izzc96bZIU=;
        b=B9eaLkIYsqbF+64AWHeKGxiH8n/gkjJTUIGiYLXm123jlYHzJiulPe4XVQm2XtIJbF
         TJ55XWYrOipa8MnlNJASDYSQ5BwLSWa5ran930ZQteLntHqYzaovvM0vFOX65CCZUGBH
         Z5Hl2utQzEd2Wx1MmCMOvTO9czeO+NOiBpKbC5xJqbUnDPkpI18DnvuGshBgIMBAk/50
         m5NS7w2kuILaIeW0fJO82liYYFrqUsntjFrUo6CrYEkPxUHhvIipQPQP1SoIFY/IfF+2
         6QH0IQ7tTyOCI010++M3a7EpVACOO28hknaIEDQEcc6Sel8OJCxKyf1E+LMqmLcydf1k
         XDFg==
X-Forwarded-Encrypted: i=1; AJvYcCXtArF6h73xCnMDidknXhO1LohFEQBbOSQCn2xHSRMo2zrdpfAJ4Qu3YyATBGNTTp8bN1ORSehb9tR8eS9w3QuD@vger.kernel.org
X-Gm-Message-State: AOJu0YzcLr1qUcUJoRID+3DW3QGRi8SuN6y0VqETgiAvoiMKerfSSCZB
	fIwTv9DHlTfTk+yqzTrcPFIOUm01jAiK09T+KVFyoFVjBJMovD/V/rQ9f7Afw6htNXfMVe7YXTk
	SBuikEg==
X-Google-Smtp-Source: AGHT+IE0rx0KSxGHx6soYbCIVed3oUzDZtt0AEkgb4Fc4ntlPFe4VEdCSprC19W+Uf9rSJ3fRj2/Oar0I4CM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a81:a788:0:b0:6e3:14c3:379a with SMTP id
 00721157ae682-6eadbe8b9c4mr2657b3.0.1730996451467; Thu, 07 Nov 2024 08:20:51
 -0800 (PST)
Date: Thu,  7 Nov 2024 08:20:32 -0800
In-Reply-To: <20241107162035.52206-1-irogers@google.com>
Message-Id: <20241107162035.52206-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107162035.52206-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 5/8] perf header: Avoid transitive PMU includes
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ben Zong-You Xie <ben717@andestech.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Currently satisfied via header.h. Note, pmu.h includes parse-events.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       | 2 ++
 tools/perf/util/env.c         | 1 +
 tools/perf/util/probe-event.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index e3aa9d4fcf3a..d60f1ac1d720 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -4,6 +4,8 @@
 #include "util/expr.h"
 #include "util/hashmap.h"
 #include "util/header.h"
+#include "util/pmu.h"
+#include "util/pmus.h"
 #include "util/smt.h"
 #include "tests.h"
 #include <math.h>
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 93cabdd7ff43..e2843ca2edd9 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -12,6 +12,7 @@
 #include <sys/utsname.h>
 #include <stdlib.h>
 #include <string.h>
+#include "pmu.h"
 #include "pmus.h"
 #include "strbuf.h"
 #include "trace/beauty/beauty.h"
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a580aa2cd512..d399c7e03341 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -40,6 +40,7 @@
 #include "session.h"
 #include "string2.h"
 #include "strbuf.h"
+#include "parse-events.h"
 
 #include <subcmd/pager.h>
 #include <linux/ctype.h>
-- 
2.47.0.199.ga7371fff76-goog

