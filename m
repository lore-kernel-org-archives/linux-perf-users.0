Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244392;
	b=1QPOcRsUQuRd2zCGUmbUeKHJO5XfJerPKBWqposcPrkzwa09BqOIqveqI5+RiFTSZsJz
	 jOP3zg/KEDulmEjg9TjFw35MSZTaA9vPJq9WJIe+ruQ3tcN0jm2zNEF6kdklz1bfVBUUO
	 DjudTZTygHJBBUk43K0xzwim6sEz54ZXO2Lde6pVKVUgl8/ClxdU2UBZDkLGQpghcfgqq
	 yGwSDqmL519o1/1InPracwLFu2vMK7tq8kXz4RxDz6Aeh1ZWDkg8HCmfoGf2H9fU+ASbg
	 ekVrpoUytZTrQ+F8i/6hnW+RaiV0hvL0e3tg8nY0lggjiOUXEnlleVIxyFSIsiJgdPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=fGAdvKbnnDNvC7VTESnuJjeTLcD1XbFE2xtDIUZCto4=;
	b=zhCTtxf5EWtIX9rj4eDCZMkxFvU3CmdHEocXzwWyEHMF8XeafUUiwsEHPMbLiofXxIxj
	 tzwSzllvWW0r/SNfXTttslPYbFtl+m26Ed287sEH0lnoqNV7mj60UL+QbVh+GyVycEYKa
	 oGge74zxLw/MUOd077Q/Og5ekjatEjA1Dvv0JnQw8k5SOY9oiGmRUNeCf4TnYpNvg3ete
	 yapaueYwrBLolB+A969PAtfIWDXSpOsbpS94TTNuv9Xm3qUprzrWl5hqOvvvmexYCDsHg
	 7gCz0DqmnMipTL5sveG9GUfzdcVaJIM18HpVQFBJYE8ROJpYws5XwZPy7HGnuAM8h+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=INpYishy;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42F606A682
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 06:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD42F606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=INpYishy
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1a5005fd0f8so3134634c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244391; x=1795849191; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGAdvKbnnDNvC7VTESnuJjeTLcD1XbFE2xtDIUZCto4=;
        b=INpYishyBjqzCHtPkLUzALLHXaqZglbxaIt1wiWcwva416LFtcMHBPD2+cGMjFnwo5
         tlhv7jPuRv22yW66JdlmNOITf5OD2JCpqy1Yfz+dOkJSUBiEVaknErML0ozRZnojN9BD
         YAbCoPAOCh4MQ47VZKnT+f6uJxo7wgXDfoceg11V3QX52PYw1uNuyvbcfRYgUjL4a1n6
         AxmjgAeAZr6J4/gg3wc8pbud+J1ULoTNT+Cdo69+3xpe1nlsmJrWxZ6UAzZMPcDRFMqV
         Yiq35+1wY9gL7VKZnda839ti7EbYrTd6CZQP0rBH5NQH3DHUAohPdTSHd15uoQX7vEjG
         PoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244391; x=1795849191;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fGAdvKbnnDNvC7VTESnuJjeTLcD1XbFE2xtDIUZCto4=;
        b=FUGtVR+49ArmbL0yJvgIRvhUx9VtQZ9OelWWUbXHtYpDdMM9V+5+C8BegOerzG8uC2
         ImGgK6Np8VOs221nb9AFOktLdh5lF8QBAJ+wkhulAeX5iWDIA54BgIfTJyNFG0npo8Ck
         7hrIOjee7kmlY3526SN06ZGttdIu6q9J4r0W8BgA8KzX3GkOPQJyYV4FL6P7ckjOVbOW
         yYbZORxAlbr6s33UdaN4OC/s/gc73sMIlrhHOxVOTeF6OQ8L+iDAqikJIq2mSC6QT2sv
         P2iH2mlT2ggm7cEXAqXia5/XGt0mw6/i69KLsaYPUGKN03AVXeCiqTNE9wMNiB0PpMUK
         qbNg==
X-Forwarded-Encrypted: i=1; AL+hErGdCGVqwNrIdc7BsPYoDHBhpYEvV9gEO4FRUZyxfPCrP4wahT3cn8teUzZDeTN220XgL/IeXiXMypsQ9w/vY6x4@vger.kernel.org
X-Gm-Message-State: APuU4Z8UqIDzaCAT9yjL+AT7IyqnQrPFdh2FeXZAG8UYxjnokAXLLJsV
	v99JJ7vjJbD7NG087Bn0UFirs7EKbfnCJpJ+3K4+fP/i2+5YdnHci5nfKgzsN5RP+DamKJ/Do9S
	hEbAZ74Idhg==
X-Received: from dloo27-n1.prod.google.com ([2002:a05:7023:a5b:10b0:1b2:48fb:f4d0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2608:b0:1b5:342a:e4f0
 with SMTP id a92af1059eb24-1b5568b678fmr7282977c88.6.1795244390557; Fri, 20
 Nov 2026 22:59:50 -0800 (PST)
Date: Fri, 20 Nov 2026 22:58:12 -0800
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121065813.4143649-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-24-irogers@google.com>
Subject: [PATCH v15 23/23] perf machine: Add __guarded_by annotation to machines->guests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Annotate guests in struct machines with __guarded_by(&lock) and mark
machines__init() with __context_unsafe().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 1 +
 tools/perf/util/machine.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0cc593d5372a..70870baa157e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -234,6 +234,7 @@ void machine__delete(struct machine *machine)
 }
 
 int machines__init(struct machines *machines, struct perf_session *session)
+	__context_unsafe(/* initialization */)
 {
 	int err = machine__init(&machines->host, "", HOST_KERNEL_ID);
 
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 80191545ee8a..67d517742fb6 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -3,6 +3,7 @@
 #define __PERF_MACHINE_H
 
 #include <sys/types.h>
+#include <linux/compiler-context-analysis.h>
 #include <linux/rbtree.h>
 #include "maps.h"
 #include "dsos.h"
@@ -153,7 +154,7 @@ struct machines {
 	struct perf_session *session;
 	struct rw_semaphore lock;
 	struct machine host;
-	struct rb_root_cached guests;
+	struct rb_root_cached guests __guarded_by(&lock);
 };
 
 int machines__init(struct machines *machines, struct perf_session *session);
-- 
2.56.1.750.gf70dc682cf-goog

