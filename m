Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700128;
	b=Q6w8CCg8sSRtzDGcO6dnHlnaa7FMqfNox9j8pdeNTc10hWzQj057DDkXGEl/SDS0NKFH
	 VzvUA6q+vXhBQW7fSeeSMb29lkI/3HOvz3X9y0PSHHNXzop6vzxL7p2NQtm1pHRnNzVCT
	 fxPfr/w78Myj1CWfuJ6hSu9KW1zLzCb4DPFli6W0SYR7/3N4CKbcOBWP3jRS0p/aF5JoY
	 XakxpcOeJVPEQeXgvschqek1ejDJR+PBxE/0LfcaBbHy2J8oshcJSw0oc9rlQkab92qcQ
	 xOuUs+wXnKADrdgRW5gw8v2WiUy5OsHqD21ZL1iVr9Fv6B4vF7VLINMi9z34rLD+40g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=izXqkBzLnJqGM5xH5BnRMsFg7CLuWXtR4LH8CWJ8dTE=;
	b=GcQuetT9FeXiBtnQKmMZ5o88NZ+ehAfAOOwTJWav82EQb/+//P32IDyLjg8QDScro8I3
	 F47chK0bMde+VIDarTvCJYoVGibXa91U7WCGrAUOQoX0AMWSTpvFzQLLbHAm2wIsFqLMm
	 iX4OKKvPU0akPA53RbJHpm94kDY6sM6uihK0zQnyzFB/bI7PH27NYEOVMySwJ30IZ+had
	 c/fKVxjvPpbKnllwSGg+tBncZu1icGxrD30UD0fTn0/szuI9EEfn0kQZuel2z2x0n4lvz
	 zSA7OaGbrSnA2H6n1qtUrdEkxzf4ktp4qDy7Y0m+J8aHyxUZaqA07nVbQlaXjEMWSiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ezStEsGc;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D94606A337
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D94606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ezStEsGc
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3510d0baf63so452546eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792700127; x=1793304927; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=izXqkBzLnJqGM5xH5BnRMsFg7CLuWXtR4LH8CWJ8dTE=;
        b=ezStEsGchfAqfdVSXoS+Ufh869dXjxCb7PcDoezFzqvaSRnBi+9ZUxBwMQvwzoNAvq
         4s2fwBb6Tg4FEKCEju8Fud24wR+4+8ydQh1PRhkFkY4Ff3nM2/JMQQn/kbS/L2xMjYMG
         UxkI1CQQJQ+4V6bWCeOQsHS7TiwCDdnzHvajKSfKHUww8ho1Ip+jQ3/DEBZQgTayt9Ez
         Ia+9pH/58/ht0Px2dP1kaiLsQSs4lIkJ+iJZirrPQbv0yhVfoFXQC9LWDZzoOpEXrRnc
         t2/+Ly59KFUCzOcQsw1QnP28jBF8uM1jkpUwDhXmyQpxyBIvsXUcu5MZVwkGizCLe0Yn
         Ta9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700127; x=1793304927;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=izXqkBzLnJqGM5xH5BnRMsFg7CLuWXtR4LH8CWJ8dTE=;
        b=pvTULbQ6kzB1Hyn1JSCYi/rO3cedDns1wQ/cLttnYScyD8GrqQEnOpqs0hp68lYLSd
         QFZqQcNMs3uKdns1THehmSYXuKfmvY3L40RV2xXHEF38KwianOcMzZ2PUQk0zrd/VZN+
         IK6tljec/L49GMySbuvbQ5oHiKteCjzrK9bIxmi5gqCpGr1RcNpm0grXDZyP2Aan0O2A
         /an7U5Et0yJOQpvu0RzNdmSyuUo/G0C3rstwWbUcpAJ0d8mVhGHbA4Zmkvc33sGl54Sh
         gFD0iUS2yoIUicsnhjeiCVrn0xcfwyWdGxKZdkggZ5dZSNf1/HP7BGn7iBhzXUwG8E+b
         fKxw==
X-Forwarded-Encrypted: i=1; AKwUvByv0Y/O3tb3W73cW9mLf9bMOT/mkzsjQpSQPwxZPoEeM2N0JI6xq32yoQUlPiytO2poHRL1HoWY3i2/5fM8K1cD@vger.kernel.org
X-Gm-Message-State: AFq9FYJXw4GBMtqCCNE6Yp63dC0oQe4Ic2Jtv+A1uSGoCrg/BETC+Ffr
	ehBeo/1QTWU5sWJPqxOgLW+xSWJJW1WYqYo2cgjSI3X6SaPAdRJ+fFhqK7fA/Jsl0+4YdEZlZ07
	14Lwxbn5Nkg==
X-Received: from dlbuy12.prod.google.com ([2002:a05:7022:1e0c:b0:18e:11a6:297a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1305:b0:188:88b3:abda
 with SMTP id a92af1059eb24-195c65611a3mr316490c88.30.1792700125994; Thu, 22
 Oct 2026 13:15:25 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:14:41 -0700
In-Reply-To: <20261022201453.1717523-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021223905.715051-1-irogers@google.com> <20261022201453.1717523-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022201453.1717523-9-irogers@google.com>
Subject: [PATCH v8 08/19] perf dsos: Skip BPF and OOL DSOs in dsos__find_kernel_dso()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, elver@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
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
index 40267d3a725d..2df0ce58421e 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -474,6 +474,9 @@ static int dsos__find_kernel_dso_cb(struct dso *dso, void *data)
 	 * is_kernel_module() treats it as a kernel cpumode.
 	 */
 	if (!dso__kernel(dso) ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__OOL ||
 	    is_kernel_module(dso__long_name(dso), PERF_RECORD_MISC_CPUMODE_UNKNOWN))
 		return 0;
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 1d9d3bf57720..cb77e82ed842 100644
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
2.56.0.307.g5fe7bd680c-goog

