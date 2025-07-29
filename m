Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A677720D4F9
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756013; cv=none; b=NVPEgnxmu1+jBOMeSHLQhCeCqXVkzi47Lek97oqom4tn+7BUs/MXEWSOz7uK0EtgLWz0p44BrxzwknwM0DBXT7Y6aNWnAuS4YB8ReKN/WE2LghP50yqKBKyb5VnGwvoGDYhlomM9bvkmp4EShnNEtqAimHNfl5O7UBPn0ACb7zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756013; c=relaxed/simple;
	bh=bpPKQzVvF2Y3jUpkSIAzRUU7htVMnv8MWQb3f1guygM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CUJQg5pTNZG604XT/YiJJaLhgtvTzH7hdsw2h0A8lOy9ooAX4215OjYGuO2kdmmIjfdSwJj2DJPezmohogkAE0MUhmx3KINuHj3PAn1bIGu7eLoXiandFSZedpcrOV0IJgGip1guoGqYISOybIOGNZorvrnpdRrPmWBAQrtuGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sNxNF3r+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNxNF3r+"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23638e1605dso39151555ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Jul 2025 19:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753756010; x=1754360810; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NPDuevloimGKVsWil7Slcd/Yj9vleIb69P9iimghSK4=;
        b=sNxNF3r+5VVjyrbiG1R8TKESohNemm/A6syHOxVpFiwYedSwnM1lIeV4GjuvB07F3v
         j4x3nmF3YQSfP98uJT/cQBi37gIc4J30k1Mv0GZGJaIqvmi1xQk0YiTpeVW05fteCMyz
         S6P/JUyVu5bkqHs6gfGhdgIxPCQPPa9J4qEpa0cj8CgFb0Kz9YJhJJImkXTlnOelslb3
         OU99M/O3epFnAjMqAvClXaXPvS2FbGS7JiU5iYGmJaM9VTlzuBK3O8FiYU33tzMQfZ0T
         DEQqeV38AiF2dUa7vkd4S31D390cA9pqdATadBP76pxmPLiuYW75vKhUHjAIq8XqUYsB
         5SeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756010; x=1754360810;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPDuevloimGKVsWil7Slcd/Yj9vleIb69P9iimghSK4=;
        b=jnEcfBBW9Df2J4xdFJ6DhqSploWuYewA3xivBuGJtd+yynAsOcIOLMWX61XTA8KD1k
         m76GMFpTwl6pz+mdV5lAgXVjaPx5gz1bFzjL58QSV/KB1R1T63e/HIBlBLYsrXDocsP0
         69z61J2cnIJIveBkwZ2kBECy2z+BrxoODQHX44wYs6pJ4n/g0Fma3S44qxo1j0eeWKXT
         aVKVAuGDb358RTKjRErRgmiZXbDZHArChVuziR/h5nZY9mnDEfrj+RgWQ7A+iLT41Rdp
         I8yRgYR3QWfNepS9r7FFQe0ihdkK8uEKc1oNkDMRIl6YI8NQMMgkJKqJWmA/ApwvClvB
         saJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN6kxBkKM6Tc2s/8L3Y5L5tLZuGp5rRZWSBevwpYwVAsp4/EJUR1Qz7Tcp0FATTOSBC2ho6dpO2EU8Q4T24fFr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9YAe9tNNsZXG1+GSwP2V0x4enDHDVnoNZeqUkHLH5cmRwcwgA
	Zqmv20xS/n8Ubhbf5AZI/2vcU3dP0q8ZT66EAd/ai1dFpNYeRjioyjNuFfRefSTvfocVqwhfse/
	Fy/WFdQ==
X-Google-Smtp-Source: AGHT+IGyyM3fDnm9QBVau2QFKbJOjQeX2Y82KWdawzVLWv6ahiPgYmXl8LvmKTgkRHyMXJzIeDPEu2d5dAI=
X-Received: from pjbsn7.prod.google.com ([2002:a17:90b:2e87:b0:313:2d44:397b])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:228e:b0:240:1f19:d35c
 with SMTP id d9443c01a7336-2401f19d5acmr92061085ad.39.1753756009846; Mon, 28
 Jul 2025 19:26:49 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:26:36 -0700
In-Reply-To: <20250729022640.3134066-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729022640.3134066-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729022640.3134066-4-yuzhuo@google.com>
Subject: [PATCH v1 3/7] tools: Partial import of prefetch.h
From: Yuzhuo Jing <yuzhuo@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>, 
	Yuzhuo Jing <yuzhuo@google.com>, Andrea Parri <parri.andrea@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Barret Rhoden <brho@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Import only prefetch and prefetchw but not page and range related
methods.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/include/linux/prefetch.h | 41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 tools/include/linux/prefetch.h

diff --git a/tools/include/linux/prefetch.h b/tools/include/linux/prefetch.h
new file mode 100644
index 000000000000..1ed8678f4824
--- /dev/null
+++ b/tools/include/linux/prefetch.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Generic cache management functions. Everything is arch-specific,  
+ *  but this header exists to make sure the defines/functions can be
+ *  used in a generic way.
+ *
+ *  2000-11-13  Arjan van de Ven   <arjan@fenrus.demon.nl>
+ *
+ */
+
+#ifndef _LINUX_PREFETCH_H
+#define _LINUX_PREFETCH_H
+
+/*
+	prefetch(x) attempts to pre-emptively get the memory pointed to
+	by address "x" into the CPU L1 cache. 
+	prefetch(x) should not cause any kind of exception, prefetch(0) is
+	specifically ok.
+
+	prefetch() should be defined by the architecture, if not, the 
+	#define below provides a no-op define.	
+	
+	There are 2 prefetch() macros:
+	
+	prefetch(x)  	- prefetches the cacheline at "x" for read
+	prefetchw(x)	- prefetches the cacheline at "x" for write
+	
+	there is also PREFETCH_STRIDE which is the architecure-preferred 
+	"lookahead" size for prefetching streamed operations.
+	
+*/
+
+#ifndef ARCH_HAS_PREFETCH
+#define prefetch(x) __builtin_prefetch(x)
+#endif
+
+#ifndef ARCH_HAS_PREFETCHW
+#define prefetchw(x) __builtin_prefetch(x,1)
+#endif
+
+#endif
-- 
2.50.1.487.gc89ff58d15-goog

