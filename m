Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965885;
	b=0ucB+uSs+V0fYSSdusgoOwflHg/1WCB8rbKXDX/NuGQYV1LbsOR0O0VC332SHFd/m7sk
	 CsLxNhIx9+3dGCBa4vkN7tKO0PlLQppSHvwaj2CWUAOiZK+aLCDqpKTU472GQpvw0RUhO
	 YDA0if6Y4oW3T9EITWSAeynbfsIrpBoyu6KgbYbudjEKNRKKDH1SPBPGFMswJzFDsvZbP
	 zIjm87w/EJce3r8wpWuJmGnBMN1b8z9YmJrnQx1Ttu+LdV/M1o2hurctvCPsKONZsfQed
	 /su35fllAPKZe1c1Xgz8J6ubQlc2AZOWev3f2vsmzEIfSPsUoAwxbLAjTIdgIQ+/YMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Content-Type;
	bh=hKZUnu5wtT1E98Kxc/nSegz23tYHL1tF4broOYTq818=;
	b=DUtrujOYVhL0Nczyevrx4jRMpEVOLUA8gssACrcwsW8P1NSPaFuW3QLRpEYUliDK+gpQ
	 3VUJTGdrmdWpvEka8QJlB7i1pGzrVNMTNmAZ58yLHsD9WqTXrcrKbTrgVBhTErywi/lfm
	 cJbMqghDGJ8iUlCJIPGOyP19zJO8+9RlgCKwll+9MZjUvKX2ypjLhCsHw9RDMD+8PLp+z
	 OSL8KO0mUdG5FwR9rvcNwdryXbeHZsTv6Y/A3vKw5PxbgPJZ2x8zECCoNOn+pZgsey+u2
	 qzGIE0+RlhDMytU6icbR6FupteR4Mjr+dTuCoge6eVGeBkeou8h6brFF/lYid/YN+0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=buY9zqVX;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D48606A31D
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71D48606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=buY9zqVX
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso4386147eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 15:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792965884; x=1793570684; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hKZUnu5wtT1E98Kxc/nSegz23tYHL1tF4broOYTq818=;
        b=buY9zqVXRM1q5QK50WwSLnEuEGKHr+cUp9LzKFuM2XrfTdydh5hdQKXSrSegg8vLRU
         SUg9ZGfgdxP/wjPm53P+/YXTgIr4v5KNwCNI2uwgLS9xn5oq6rHmdbeco/w4S5/t1uCX
         xVzjwj3MgsRXZuDW8+kvfnnqPNQ6vamWSZmBSel62cub8uvsBchuAZNN7HB6pD2McI57
         fQKrO28jYA7PNRGAyNybmPODNgOGrJMJIYFttcCg+4AYnQwNiRYRa+E7AAZU9n14NEOa
         pu3oPDHdAObPTFauIleaVOr1oFR57Wl/Pw5l8P0O5dv5DsOWtU8tA6QvT8vAUVB4S1jV
         YVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792965884; x=1793570684;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKZUnu5wtT1E98Kxc/nSegz23tYHL1tF4broOYTq818=;
        b=x12Ssd2bO8nB/mTWQj7H14o0UbFoCy52vw1ry9XDEdA6lrOGbnqMdR7Ixr9/GH0zOm
         1lcTIhlhkE092gsekzUnGbqJW2j4qrzvYdMNMbVchDYxK1+RntfTMIX+MA2gYup7yoXp
         W04tDykCOXyqcg2Hro0xqqrZcDAgasOPJcOXXRafub5iIlaI6yZO99443FGzHGGOafFD
         OmQMDp1agUqSSu71Xzds7TYVUbtTWA7olIilrK+8uvpmjPg8mdtutL+PIFEZYCrdnU7j
         SglQELhpaVuJNGuEnRf2zhdwNUEB6amShfrzpQTxmy7BYhTrlKNAQatyWlfytZO7Hr7i
         wyug==
X-Forwarded-Encrypted: i=1; AKwUvByCEYY2HZR3G6BWE6N02u53DMQ8AIOEkQte75T8YFHL5qP/UTfU7HnS+exwcVN1zwem3gaT16MIqLI6aRFE2ZyM@vger.kernel.org
X-Gm-Message-State: AFq9FYKMgoFY096LSPnSCBpNMR64ulK8FmKe6oKH1CHu8ZWStXxaAFH6
	WZ8pPTZG26tm8UYvBIAuOplC74WqTW5Sl0TaaZjHvfmj8LcZtJwXdT8d5NAzM2B8mvo6ZJ7yIlC
	E4oyPMpvHfA==
X-Received: from dlbsj2-n1.prod.google.com ([2002:a05:7022:f902:10b0:158:5d29:90be])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3c04:b0:151:2e62:fe6e
 with SMTP id a92af1059eb24-199363a337fmr5791484c88.19.1792965884027; Sun, 25
 Oct 2026 15:04:44 -0700 (PDT)
Date: Sun, 25 Oct 2026 15:03:43 -0700
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025220349.1244499-1-irogers@google.com>
Subject: [PATCH v1 1/7] perf session: Fix minimum event size for PERF_RECORD_CALLCHAIN_DEFERRED
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct perf_record_callchain_deferred contains header, cookie, and nr
(24 bytes), but perf_event__min_size[PERF_RECORD_CALLCHAIN_DEFERRED]
only checked for header + one u64 (16 bytes). Use
sizeof(struct perf_record_callchain_deferred).

Fixes: c69993ecdd4d ("perf: Support deferred user unwind")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 56a5e57ec512..d9d06337933f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2773,7 +2773,7 @@ static const u32 perf_event__min_size[PERF_RECORD_HEADER_MAX] = {
 	[PERF_RECORD_HEADER_FEATURE]	  = sizeof(struct perf_record_header_feature),
 	[PERF_RECORD_COMPRESSED2]	  = sizeof(struct perf_record_compressed2),
 	[PERF_RECORD_BPF_METADATA]	  = sizeof(struct perf_record_bpf_metadata),
-	[PERF_RECORD_CALLCHAIN_DEFERRED]  = sizeof(struct perf_event_header) + sizeof(__u64),
+	[PERF_RECORD_CALLCHAIN_DEFERRED]  = sizeof(struct perf_record_callchain_deferred),
 	/*
 	 * SCHEDSTAT events have a version-dependent union after the
 	 * fixed header fields; the minimum is the base (pre-union)
-- 
2.56.0.307.g5fe7bd680c-goog

