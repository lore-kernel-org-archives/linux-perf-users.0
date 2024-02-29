Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16314643B
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 06:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188399; cv=none; b=ZCuKD8SANk9pbH748glN1f44L8h/F2o2IVdnCRo3kvO0lZY70i7ASn/7cSoJ40a/6ZwGWM8N52TRWoeR3b+kBFZKUGtQHQqSzN/DXpCnUUB079ooH81SCSrJ93han8zHhZTzbFwwzVENw9cmOWoNR7dRnzVxuqQKC0gMM7uJpyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188399; c=relaxed/simple;
	bh=GIegngHqtLjHARUsBjYE1nUvvYzurvCdwBU55T25Zws=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mCLt+WujZvI6pqg/VQtzzLVaTGHB7Eu4ugPFMV654YGc2ccgLpiewQGxv7BVrTO8Rweq1FgMDT3fh8firQOQYDxDc2BeUBphO/spWNVmOrkicRp0HujIKjUC1U/HjSrcwCX5oDmFGsXYxoggxRwLBG1Bmf34iUPArhhhYT2Lo+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YKbaYtCx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YKbaYtCx"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso1053300276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 22:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709188397; x=1709793197; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3EeOnj2LJFuh4Gzgf1odB7yRFHxb61zXSqdlmTf/sY=;
        b=YKbaYtCx+lHpwSTy4H1SVfzQA5K2rjaMGXeA/TxUBTq1htoEcqrrpgSqp+fAB89tIT
         sdUQQ7d4XFL7McpnXfYUIGJCUobTTlIk+gjU4W2fd7MKXpplEq3S9U84oWDaOlaRB04f
         CNh2DvhmC1PhzMghrFAe6BiDnh66URMhK5bquNuUhfFvipHm1Z6Pf7VHEYqa/EQHq7Kp
         UqS9iUlPcL5LJf0SndhQdg1WWWGZ4uZed5oOHSVrN6AiEPywH5uEC1DN05uqwWbV7s4W
         Ysda8asjM9a4AunDitegMEgWKXwrvtuGYezoRW6+qOckXeRE+5B1g92RIe7Zq4HbLXO9
         Ulpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709188397; x=1709793197;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3EeOnj2LJFuh4Gzgf1odB7yRFHxb61zXSqdlmTf/sY=;
        b=W/c+p9vMbrxqkNKspva1PiXWjNXxk+ZGoMKaZ2SWOeh3OZrAN4C10On77r3/DHXaO+
         gRu9Hy+mY8IQ0IoFXRK8g6cWDU1hw1XR95MaWqOY1uuGUK78fNj1DzXxvxp0uBG4LIHW
         gIPhssVedMVcd5ab7wwWOTimXan/S8f11pxE0PdQ6vogkfjVAFmhxPJ6WcQCtFGGkU79
         Q2T/KPyOgRxFQKdJer3D3azQo1xWGvvKNNbhiQhHsYUJa97oCMJUAilTRfDX/CwQHBhL
         YDRTq99M1HglsskdTQ+RarNGOnl80QNzupPlCUCq8/V8F+W4FR6K88hz/piOL7uOApBi
         IA9g==
X-Forwarded-Encrypted: i=1; AJvYcCX8DREsNvqqiIwxXHCrgPxAnzuIKXtLNcf2z6+q0rqRsG379TlVHj30fkAMYQlGOgJh8OzbHEqvMjprTkvRHiT+nm0NjsWOQV/w5U1njIHGIg==
X-Gm-Message-State: AOJu0Ywcb0OOaOOjtEfIEjIT/zmYgwHCCiBubAz1LCQdoo0JtRRPmRD5
	VWtGE+th3b6IFaTBbTekdkblMg1z1PTo8IIG6lD9GQ+L4hMNyrEl5MW9n80Raq9kuXKQPeSTWC8
	UYvAzWQ==
X-Google-Smtp-Source: AGHT+IF1kuz73GlgS3MiChLOB/xw2yrSO/PfkIU+An5t2EXD/vbXFmUQaqlQkviDAcTiq0LYyCZJ3K+8ILZs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:150d:b0:dc6:d890:1a97 with SMTP
 id q13-20020a056902150d00b00dc6d8901a97mr59458ybu.9.1709188396983; Wed, 28
 Feb 2024 22:33:16 -0800 (PST)
Date: Wed, 28 Feb 2024 22:32:53 -0800
In-Reply-To: <20240229063253.561838-1-irogers@google.com>
Message-Id: <20240229063253.561838-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229063253.561838-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 7/7] perf threads: Reduce table size from 256 to 8
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The threads data structure is an array of hashmaps, previously
rbtrees. The two levels allows for a fixed outer array where access is
guarded by rw_semaphores. Commit 91e467bc568f ("perf machine: Use
hashtable for machine threads") sized the outer table at 256 entries
to avoid future scalability problems, however, this means the threads
struct is sized at 30,720 bytes. As the hashmaps allow O(1) access for
the common find/insert/remove operations, lower the number of entries
to 8. This reduces the size overhead to 960 bytes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index d03bd91a7769..da68d2223f18 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -7,7 +7,7 @@
 
 struct thread;
 
-#define THREADS__TABLE_BITS	8
+#define THREADS__TABLE_BITS	3
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-- 
2.44.0.278.ge034bb2e1d-goog

