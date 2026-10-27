Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120678;
	b=KUDTiTqV6fp5o01+fwVlMepZD1wPo5j/UiNTQYBg2WD2mcIxD96LG0CIX5jomT3PJ+Hm
	 bm+Bqxkco9ejAXLzulP52m5nEawSGfQtgqdFPnG8tvOKxXXjQ74SR2Auk66yKXIURb5Bg
	 Xr7J1G7PZ/9Mnel2SU9HHZX8ADrsMKLvt6N6ykh/4ES01+yWDr8w5Csp1bt5os0OliJAg
	 alhDStg1wu4JKMsCfSE5t9zZ78G4c7cypgFpS0niXGx6SqLA+kylexqtLhzZrJhWDGgsH
	 DQBhSHk6oIn12gUY3Y3CXR6X5agsKwWTB5rcN63xE3MDWRB29rfeeeiRT0AaRocOvpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Content-Type;
	bh=vF3lYjwaP6Vu1eELbN7F7td7N/RNwt4u/bezxSwf+3c=;
	b=LlKyaRLoZ0oEo3I9/hrji6LOFjeeDz8sTKL4SyC9XYROT05HYzoQvyjU1kOM5XfaIZeV
	 0wbWkbsjJs+dJqEz9kkVqEFdwGY5rS0mkZ0g0g9Zic40gnRHjIxPUPcLOzV1nttQSftr1
	 1nta520dDniurInLS7w6r14/YEJhXOxdXVRmMQlP4EC9GkZoEbLaqDuQLr8ooJ70YGiu6
	 axycieBjgFwHLh0WrTZ2omntlbAiqqV8P0UW8FPrRLFLPr/J5CErUVSo30Vaxa5LFvQZC
	 tl7q7wc5U40wiLcq0XQKcItEia+CT/oxdmZqZqW0fZPZSeClYUS2hV0FF+qwGKiAemw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pG81yAw8;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4769606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4769606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pG81yAw8
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3552883bd19so160451eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793120677; x=1793725477; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vF3lYjwaP6Vu1eELbN7F7td7N/RNwt4u/bezxSwf+3c=;
        b=pG81yAw8jX7gIgwuDJVfaxwUm4IiHuxT99V6Q3vbAIY6bO6PBPeCnn+bPdpgYmwkL1
         kWYCT3xbmanK3r79KRwmt8BUo5HJ5P0FbpO4cOM+76kZMNNPdTvRaJUQbMht9P99RvvE
         6bbZGGsNPlYdSI4F46tqzYekEKE19h0n6pncgaZMG8qmwqFjjaejjcKa0TMGgYJ6Oy7+
         ZnjAiyYxg6lyFEC4LTWreHA18inubal7ZD/+H4o+GlzsebRNkb7fkhTELUmS6mDZyPI3
         cDwAt6eYeGBY0WUkLlq3HyrskLQZxI7TOrE8jjHevRNq5NsnJPw4H4/RchsOJlxQbN7T
         c8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120677; x=1793725477;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vF3lYjwaP6Vu1eELbN7F7td7N/RNwt4u/bezxSwf+3c=;
        b=kuVfVCzxetXTkbJm2Ryj8PWU8+fN+PyTGBjKxSFy6bpkfAzrV3bCUIi2SFFYtLcqkC
         G7yGTPEWk+R2g3bXAFtJFaY/YEl8EOjucQDWHdLMTOK15Q4LoPO/kE9rBeg7EUU4Vvvb
         2Jo4KjpItJ5nY0MNrKWZehqNVsKQFCfyNkTj2VNC2WjVe87AWVUK/lKYzxzwpNAt67jd
         1L/DSJGxQ5aFlW7wmjp7sJ8cvUjldRna7V0HO38yABuVzYGDlWeHs5ze9gL3c3GnlvDH
         3eAbG2a/upz8T9uxGRdtK83+x9GAZT5Q+xElO+B7Z2tXbWdhwhMaoYGHc0PY8i61O8gg
         KG3A==
X-Forwarded-Encrypted: i=1; AKwUvBzRaNNgygC2Qrq4jG5feexTIxXmeZiW5O7tAw+H5Nwzk1DjtHlaKHY6vRsSJt3J/SD9vh3AZIel/nZyArdXhva3@vger.kernel.org
X-Gm-Message-State: AFq9FYKs898PgFp3wK1zhC2oIHDwUVshzaW0h1gMnqfScKbjUBJneYWj
	gqDd68FGf1uzW7jMtMphQl0Drh0x2o+WGX3mCFqfIzMBaP8u762UnLgI1cgBJ67PNWlB7PAYOK/
	f426R94dCYg==
X-Received: from dycpq24.prod.google.com ([2002:a05:7301:fd18:b0:36a:eec:f68c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea5c:b0:19b:98bc:326f
 with SMTP id a92af1059eb24-19b98bc32c5mr13845200c88.18.1793120676283; Tue, 27
 Oct 2026 10:04:36 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:04:12 -0700
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027170415.2815859-1-irogers@google.com>
Subject: [PATCH v1 1/4] perf off-cpu: Use the CPU map index for the bpf-output
 file descriptor
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When populating the offcpu_output BPF perf event array, the file
descriptor of the bpf-output event was looked up using the CPU number
rather than the index within the evsel's CPU map. These differ when
CPUs are offline or a subset of CPUs is used, leading to the wrong, or
an out-of-bounds, file descriptor being used. Index the file
descriptor array using the CPU map index.

Fixes: 282c195906c7 ("perf record --off-cpu: Preparation of off-cpu BPF program")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_off_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index c4639f6a5776..ff8935688b43 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -95,7 +95,7 @@ static void off_cpu_start(void *arg)
 		int cpu_nr = pcpu.cpu;
 
 		err = bpf_map__update_elem(skel->maps.offcpu_output, &cpu_nr, sizeof(int),
-					   xyarray__entry(evsel->core.fd, cpu_nr, 0),
+					   xyarray__entry(evsel->core.fd, i, 0),
 					   sizeof(int), BPF_ANY);
 		if (err) {
 			pr_err("Failed to update perf event map for direct off-cpu dumping\n");
-- 
2.56.0.313.g2479322e68-goog

