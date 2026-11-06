Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948648;
	b=KfJBXQLWfqkdFATmvu/BfsXTYmzqF9FId5UlBeXYJqc/x8QQ9ziQD1ev/D+IXV98ZA9V
	 BaAHMQ9scwVds0VIcX6eMaueGji6qYLYbFydrruFuC8jLa8xf/SEbXP9Ixny111vq/jH8
	 FJpO1liOtyOYJZQ2A5CksmumhVodTV55SpW973V4jqvSrpkYk/FyNMmXZuyoNMLUSZo9c
	 95aMy+4Jno6toXQGX3k+66CVYxkXqKq9cA78+ehp6JwzA+aVG4/mGQsai036sX5iUlz/e
	 1Wh6gWxJR47dSPkxYc6J0JnRQTbkbs5pDnGp1ap7AmU+eM+nfbWjOphjdNzx2N1opBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=t2QoGiIe6qh+xXGRXPEuyCoTeHTjKPAeQiniSi4k+CI=;
	b=sp05vCcLbfuCi47VnZgKerBk3zuOdkOjoAwyWM9tBTwJHLOV4Ou1sDbIrAQHr2pMfLMS
	 cOKa+SvQwzYZcBlAABi2AEWbHZMVc9/TfY1opr0wbaSW/hh9GFTHCkocXXG7RJQJ6i839
	 RwdIyDCUy8EadqECf7/Kq2n/r3PGnCZMG2oy6/BQYSGbs/tl9A0XcIq/c/X1w5fCqKfaY
	 u+y41/Q93jzIDTd6SjFzmcOjOvRrXyDzvGK+hW51zdOP1cyYZF08A/ygxDkKtDd/nWd20
	 wns8pEz0adf2pln4wuAVYknq+KkCPbpf6Z07Ea4SdyrmUFhsg43L3Il9XMiu3qWiElg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="b/186WZj";
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB6606D80D
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80FB6606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b/186WZj
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36cec75d8caso501902eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 23:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793948648; x=1794553448; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t2QoGiIe6qh+xXGRXPEuyCoTeHTjKPAeQiniSi4k+CI=;
        b=b/186WZjdUcEGHi11cfLhTmIWiMRf8+y71myAj15VS82yiPGfy4w8LOyrTbFsahmXN
         hw3pE11QO8nEIU56uAl9G6lj3rqD4F/1TvUEZJe4XRVpfibQwATVESP7YCj/+olrc9ML
         mJSCtd/w1zOpKVjkWiRsbAs3I/ZenZCkFVminypu9X+6EdrDk2mROIIP8/OsWzvmBvuk
         Ta85e8IlCKz/EzTT9qhQczGFvsKzozwFMBTjDTZRguoetneAfWArdHnBcMV/R/XwtCdq
         gGgsbI1AZODsP8jNcWyGDeWCdNePNRwamYIymYFRV8ujIBsEQ8rbsnzYg425q+yctOpi
         1IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793948648; x=1794553448;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t2QoGiIe6qh+xXGRXPEuyCoTeHTjKPAeQiniSi4k+CI=;
        b=FV4qH3HAwT+k0jCnYtxVZIHucCK2kHv9Z8vEVmY08XUnAty1kUE/5/lGuzTGzTV0hg
         CxKpcXyiiXkufFcZ7Co4HCUN6AxcUmM9XqXPZm2fl6p+KpfP3Zywg8Qzl1Eit9jEIuu3
         zlEo2LtN/tKqXJr98UKMGyeCC9TcbGYLYva/7K6YS3X0bJIl7MHkHzKPIV2VSEtJivgV
         7OnLzmJiCwvRTjPsL0p2T/eQZouDgQ81WFmGZkmD+3Knh+gs8U1jcrpkWNbJJEwKeJLY
         a7As1ZtUQ6QylzCH7ZDqxsrxXn8sYV4a22FkfbQoMcOdM+vb0YAFQoMKHHdUQeiCz1R/
         bL0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwqv2b6tfUnAUgFmQYfjo73ZB4i2y1TTrhppRfOghb9gCYtl3ohREh/VrrF79fF+KKn8W6PnvqTeq8XvT4wvhgy@vger.kernel.org
X-Gm-Message-State: APuU4Z9tmuueBswXbH5Fh0vkXESD04ogkiQe/pr5z645Nrp6NTy6HRmU
	lmEAcrxxKwAY31A6lC5WmmTQ3i31M4+FOKzBvIWKwGEBpFruHJ/yLSMyS2hayW7hNmxK/vuyDPo
	1wt5r55oCrw==
X-Received: from dyaa13.prod.google.com ([2002:a05:693c:40cd:b0:36a:209:2e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6188:20b0:359:3991:ce1a
 with SMTP id 5a478bee46e88-36de6b52a0amr6511094eec.16.1793948647424; Thu, 05
 Nov 2026 23:04:07 -0800 (PST)
Date: Thu,  5 Nov 2026 23:03:32 -0800
In-Reply-To: <20261106070344.329897-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106070344.329897-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106070344.329897-9-irogers@google.com>
Subject: [PATCH v10 08/20] perf dsos: Skip BPF and OOL DSOs in dsos__find_kernel_dso()
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
index 076d167380f2..b958c6935a56 100644
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
2.56.0.455.g6c5a503b38-goog

