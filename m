Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026484;
	b=ytVlCNs7edRtqvIs9E6MW6TD0uONrQ8a89QGK3vui7MgVsv1wCU+c+L20N+NsJ/CXU8F
	 jDPVINvrLaA2Njq1RnAacv61wEJmm7ul4Fd6/IBkpmpsI2ct4kR8PdnXuZGsJ85/Y5Wwo
	 688VP7OecAntOuj05bSSRBxK5JzO084MBPgp3BvD0i/YLz4YFbPBSDRL7vKUOv9uyWkd5
	 Cp94DtEtZZzXpg3YG4Vp6mly9vqqrZm6Rrf94bWgRyk0BM2BdyKd14t23Jnn4TV69fg/h
	 747majJD0g2CK+kRid4UQz++HYhkgfaDPgiIPtcJlCcczGdpVy1HtygHWRpqEtQc9LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=t2QoGiIe6qh+xXGRXPEuyCoTeHTjKPAeQiniSi4k+CI=;
	b=rGfNbikFGwHjvtdx5HFqPdzX3ZB52LJKyloxE8nLOAY43YXXsYBR+kuWmKG3jPTevQVi
	 wtcindtciqjKl4enYOOcc6zfQdFl8dcDhrCeEhGW6/YtWJvUrNkRiMCE/NsxtyYhD5+Rv
	 wAnPXqTljIvXEPfElQsgGtl56PMqj3XbxaAS0lx8J1YhBPnmZnFHTVTtNatcaxU9lINxu
	 QDHjofabgtwElb6+mh5nsXZCjQQJHJtYWYYxvSJ3zI9x2c9Gs20fH/pcPyUsLw7qdm4xO
	 LgRy5mjJ/vKRuw0kGkgeLoCoE23wa+jvb9h2wKxAXVp+gUeiPQsFB7yzWAOsYS5QWyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BCjZplEl;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6D606A33B
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 04:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92D6D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BCjZplEl
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36d1353fdcdso2423131eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 20:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794026484; x=1794631284; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t2QoGiIe6qh+xXGRXPEuyCoTeHTjKPAeQiniSi4k+CI=;
        b=BCjZplElqqSWtaFxAjFUeGqdp9Gav6nTfkCMGBeM4NxtVHBzecqISlPmQJVal7qYUX
         HV+bIE9gBe70Dg58WFu3Tui4XkzXuQ2gN3YW1EYRRrAuZfLLFeL6/Li2QGp6GF0zaXMN
         Efz71a2l6CuBntw3IDd+nJbeFLj7a2HseMCtHaVQzwyXu7LYbDRZjSyhHJCx4yqg1wr6
         xlNsJmI/znkf5iCXvrmd4g8csk4hqZhNDcoPTadYqAX3IoA87+6Loezcv+jGECEaX1Cf
         A0dsMdTtVjaxobSxnqInlTVtZzOjuxQXgxj/5RzYt9ytiT3uOy4nIxSFyc6eEovT/WQr
         CG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794026484; x=1794631284;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t2QoGiIe6qh+xXGRXPEuyCoTeHTjKPAeQiniSi4k+CI=;
        b=A6aU4RZqreBODppaKxWO4A7y6PBZ/MDvnXQoyhADDUAPm5o6ZFBFpUPhtR5TMxlbZO
         NLeFU1IRDnG59zsHUp3y2mYdsaDiPhXF6XWkFb7AVH51iIoRdkZBDkFoQP+3kKYKiIfc
         3DJPj1R0YhC649GjmHjN9dlGLipfm2JioUTdajgg9Fumv+RvKmg2lUIxKEwyb2zP+ikr
         l0QAbzvW3q4EeiKoRsDq2y1rTuVm6KptLE5oSxZKlpIfbgKRs0D+wODkoirG1IsPhIbz
         aLRK6zTFB1Lzv99mDkSTPZ7FpbVqv35vN1cbQdJl42WU7vpPG+iBqRWd4XVgDwTksekN
         HycA==
X-Forwarded-Encrypted: i=1; AL+hErG8EvKjGGX1B1qHFBN2RLejMHajlHBCIooRjUiJ0XTqFgzS8OI2uCbgOaJzQ1AtQ4w5PsC1ziZope197lCKvjYs@vger.kernel.org
X-Gm-Message-State: APuU4Z9zL8uz7ajbP437ebO6ssWSJ3cFPg914YuosY4rQaFFMgXs14bA
	UbKT06ACLTIqhtaoWDqON3rpnNiR/TEjUvWdZ9w9I2/BsT4fh4RSZjUT637qpf4uTzNxsCRIK7O
	px/gx13VOMA==
X-Received: from dyctb4.prod.google.com ([2002:a05:693c:39c4:b0:369:45ee:40a0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:78c3:b0:36a:1904:60a3
 with SMTP id 5a478bee46e88-36f75a2ae65mr5587829eec.15.1794026483275; Fri, 06
 Nov 2026 20:41:23 -0800 (PST)
Date: Fri,  6 Nov 2026 20:40:49 -0800
In-Reply-To: <20261107044102.1506626-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107044102.1506626-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261107044102.1506626-9-irogers@google.com>
Subject: [PATCH v11 08/20] perf dsos: Skip BPF and OOL DSOs in dsos__find_kernel_dso()
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

