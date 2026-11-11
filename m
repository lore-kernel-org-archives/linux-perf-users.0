Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418957;
	b=3C8BReH6HgY+DjHfZpVQZSO0ugdtXJ3A46C2s6JzvOGH/o4FZU5ELuqVRqvnSuFc0qUe
	 r0ihs8lhmsuB1yit0tFF1qENrprMEDZzFx1w42rUZ/cgh4v3H7TIoDp83RzzFCBR3ephN
	 d0aGNP2MvuCXFy23BqYupKRXfdyvVNe6i8MoQBai1b6TazqoNtZ/9f5FyFNz2RHvODAQ2
	 vSqBJXI9A4AFQNh+u8snCYREG4+4yqGfWxIVcAUNQ6JazkOXwA8E+RiQhMpogNaghFeuc
	 1SOqG5/USk0qTiduXhgIRiPkNz1TvaRDBYGhR6wDWgBDih7mjC8lGdk8/xOWHLhfb7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=JM6mTw4jRrqiuh/s1U1sHCrr7wMWr7Ysl4rPlzO02vM=;
	b=p4cpsJey5BNqD3jtDCi34Xu/XGRGCYu4xSn0fITPxmRKQzxIni4c3i/bso2cp0CqUONQ
	 yfom/nNJtsqegEajUSH6iRkZyJTjz0z47DZKaR8C+dpMoPhqExgT5DI+QLpg0doSKhatW
	 r/JLvJs8zgf48UikqrxjMl5i2epJrwk4+AlvubI+Mjr4MZW8Qi9CUnL7NxKt3hSD+iAQn
	 5gU0eBWeW/dx8LrdUsCXP81HAM2az1vOfahul9he3PSE2UqZko+5yxIVkbf1zewlWonAy
	 gqRs2j+p5c8B05tQVQmRnH1MKrzw2CgATzzCBhtfta3AB2J23pfoHUVVDXZ59vRfgPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kuMa90M1;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561F60A262F
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E561F60A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kuMa90M1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b167bc8e16so1983429a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 09:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794418956; x=1795023756; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JM6mTw4jRrqiuh/s1U1sHCrr7wMWr7Ysl4rPlzO02vM=;
        b=kuMa90M1jMA1ZtIuKIUZRi1GoiFClA4DUrKgBFmY++r9wbMRzGuWI93qlQsmZiZZO0
         Dpx1zCJ4NuWi82NxKNfaA/+b3SmkUAsDF3crT+91SnLo8zs98SxjsIfFwOAyB4nsCnu/
         2zTTObrIzPB4TmQ3IuEth3MHfWx9YCGN6EPZxSNskmQ9SqLOahvBVybNH7JnDq0yPKn3
         pvooBiesFNzO5GPkEWgFnnKz8heDMhaaDWTvlUeEk//i85Ygw2ZWak7dtRj8z2i55MnL
         vKXtwrnO7hyfirUKzwL4nIWzAdbolszTCpeF3OkaNLNJ9h7vzQVVlaFksq2fOa4FqSDq
         WBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418956; x=1795023756;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JM6mTw4jRrqiuh/s1U1sHCrr7wMWr7Ysl4rPlzO02vM=;
        b=c3BzCtAj569xsBXsvf6F9ZUqqa5lFN/uJ+TuiOqMxoxNX+tidaGFB+uh9AsLj7qS78
         dr5kgK8Axff4RGXzvS+EpCieYFTjVjtYjJjm7JF+XaPtljFlEtlBNaa9rBS+Xrf80sfL
         PQtF52aBZcrgEDw/Yxuq5B+L6zR4Q+G4/Jubsi9yPKorUQ/EjyQ7moYMc4rjWzXxTPat
         nxyMN+ID4+gGuFkiilLavQB0afJEszi9WwM3JPkFwYX21K8HBV82YMBt3w03ncNzFgmT
         8L9XJ2CvHE/aM+7W8ynv5SszbgGfGAZjHX+rCYTorX7NzIK1qSJIUtoymjAS1v26jIxa
         twLg==
X-Forwarded-Encrypted: i=1; AL+hErH8lcXB9aOaALZ98sNH2x4T+Den/MBADktBtxC6NT8tLcvwpR4KraK2+ILd/W6DC/WruUgzgmxyjWcOhaaqE92y@vger.kernel.org
X-Gm-Message-State: APuU4Z/MHuXwCLbvz7FpSX4ELDfIuqw4TOEb/OVWkt6NXBdRrHJMqIX/
	rQt/hbEguInYZQ4aWphH34CqJiSvEZFjK2V98/7qg/a64+iRC4bETIZX0TEVWcA+wga+smQJ1Kp
	ZMAXvUwizhw==
X-Received: from pjzp24.prod.google.com ([2002:a17:90b:118:b0:3b1:15d2:6bd3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a51:b0:3ac:a5ff:2cc3
 with SMTP id 98e67ed59e1d1-3b182e13d70mr3125273a91.8.1794418956044; Wed, 11
 Nov 2026 09:42:36 -0800 (PST)
Date: Wed, 11 Nov 2026 09:42:00 -0800
In-Reply-To: <20261111174213.3526604-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111174213.3526604-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111174213.3526604-9-irogers@google.com>
Subject: [PATCH v12 08/20] perf dsos: Skip BPF and OOL DSOs in dsos__find_kernel_dso()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

In machine__process_ksymbol_register(), set the binary type of non-OOL
ksymbol DSOs to DSO_BINARY_TYPE__BPF_IMAGE (which
machine__process_bpf_event_load() upgrades to
DSO_BINARY_TYPE__BPF_PROG_INFO on PERF_BPF_EVENT_PROG_LOAD), and update
dsos__find_kernel_dso_cb() to skip DSO_BINARY_TYPE__BPF_PROG_INFO,
DSO_BINARY_TYPE__BPF_IMAGE, and DSO_BINARY_TYPE__OOL so that
dsos__find_kernel_dso() does not match ksymbol DSOs in machine->dsos.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c    | 3 +++
 tools/perf/util/machine.c | 9 ++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 1574c8885d78..fbbf98c4ccae 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -475,6 +475,9 @@ static int dsos__find_kernel_dso_cb(struct dso *dso, void *data)
 	 * is_kernel_module() treats it as a kernel cpumode.
 	 */
 	if (!dso__kernel(dso) ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__OOL ||
 	    is_kernel_module(dso__long_name(dso), PERF_RECORD_MISC_CPUMODE_UNKNOWN))
 		return 0;
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5eb5efa4eb90..0334cb01349a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -769,6 +769,10 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			dso__set_binary_type(dso, DSO_BINARY_TYPE__OOL);
 			dso__data(dso)->file_size = event->ksymbol.len;
 			dso__set_loaded(dso);
+		} else {
+			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
+			if (is_bpf_image(event->ksymbol.name))
+				dso__set_long_name(dso, "", false);
 		}
 
 		map__set_start(map, event->ksymbol.addr);
@@ -780,11 +784,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		}
 
 		dso__set_loaded(dso);
-
-		if (is_bpf_image(event->ksymbol.name)) {
-			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
-			dso__set_long_name(dso, "", false);
-		}
 	} else {
 		dso = dso__get(map__dso(map));
 	}
-- 
2.56.0.542.g3ef89b7020-goog

