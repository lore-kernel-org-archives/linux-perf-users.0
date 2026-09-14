Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B679443AA5;
	Mon, 14 Sep 2026 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388360; cv=none; b=UaFHeFCQwonZb5Aw3qMSMBKV8CDe1ve1wkEAl9o6GQXn2ARUkYRV5iMJ0P1TU58OGJMabvYPq10BRNSC7rWe3XwlyBatbQUab1SWiUup3DT7GNhWHTwbbRtZGEV8jixGSLnwmtJ4kLuhgoo6TAaJN/ow2ejIH7fpIX0lLFkjDoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388360; c=relaxed/simple;
	bh=44Y4mudPiaR0gUwieUXm1qUZOoXMcv2dEb90rKs6ptc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQoJPu4ZBeyT3AVQ9JLnWJsWQFf2oSuv3CbI7gFiGMdMheb9ntHGkVXVio/lg3jmoQ8LlewANG4lbW2J84Y49yyd9N1GbyROY/7B/T2NLwCFTm2cKiAswg+yNl72SRtUUDvLHVPwkJFXNy0uZIE0ThwWVrNXO+8tZteIhM7mloA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Gw/nakdd; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Gw/nakdd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789388349; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wbA4A44AQIVhmbRAMLUtO9C6G7AT1PTFjms0gASvDFQ=;
	b=Gw/nakddmE0uYf0PVhAjM2FP0GrqMUxrpfacDfU+Ono8v2ewY4HxgmjiyH0eOIVhCk7a4nHIcQPpuuwk1CnH6q9jx33uGR++fKWZmDGgeNTgeUPpSf4/nNRE53TK6SGDCAguEz2ORVdC3LReRvJ0q4MnDrgfccW5IMx1yuqUM6M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0XAwT2Pv_1789388343;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XAwT2Pv_1789388343 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 20:19:08 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: irogers@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	john.g.garry@oracle.com,
	will@kernel.org,
	mike.leach@arm.com,
	leo.yan@linux.dev
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf test: Fix a leaked map reference in the arch dwarf unwind tests
Date: Mon, 14 Sep 2026 20:19:03 +0800
Message-ID: <20260914121903.1212-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maps__find() has returned a reference to the map it finds since
commit 42fd623b58db ("perf maps: Get map before returning in
maps__find"), which updated arch/x86/tests/dwarf-unwind.c but missed
the arm, arm64 and powerpc copies. Release the map after reading its
end, as x86 does. All other callers of maps__find() already release
what they get.

Fixes: 42fd623b58db ("perf maps: Get map before returning in maps__find")
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tools/perf/arch/arm/tests/dwarf-unwind.c     | 1 +
 tools/perf/arch/arm64/tests/dwarf-unwind.c   | 1 +
 tools/perf/arch/powerpc/tests/dwarf-unwind.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index f421910e0709..d4707e9ffd2a 100644
--- a/tools/perf/arch/arm/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
@@ -34,6 +34,7 @@ static int sample_ustack(struct perf_sample *sample,
 	}
 
 	stack_size = map__end(map) - sp;
+	map__put(map);
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
index 440d00f0de14..fbc161a49369 100644
--- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
@@ -34,6 +34,7 @@ static int sample_ustack(struct perf_sample *sample,
 	}
 
 	stack_size = map__end(map) - sp;
+	map__put(map);
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
index 66af884baa66..b4bade5d59e2 100644
--- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -34,6 +34,7 @@ static int sample_ustack(struct perf_sample *sample,
 	}
 
 	stack_size = map__end(map) - sp;
+	map__put(map);
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
-- 
2.50.1

