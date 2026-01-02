Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36BAD5A
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Jan 2026 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356168; cv=none; b=ZmZsPHiAK/DTAow2+ySM3H/u1tR4V3xQGdGznEtVo2QmfNbI+bC3TN5xHDJDPmFNXfopg8x03wBwpTh4a9HAQpsJRp2TROdP3Xe8/4XW7qTZm4IRQeRhuPG3mS7AV4tWRAVmUrWMkMMTlcCpL+otd2diWBix20SnhRatvSyUCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356168; c=relaxed/simple;
	bh=0h4bvlcriYcYDdPBgUEXLSB3Q4dPyowQqq6WvxU4ErM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bW4L/qm6XU9/VZ7iQXa7QNZsLVbT8rQpSoQWeDHhvWmFaeHImFUyPsMdfBqxK5g/no+4Qu/7cv0OkIP5Zt4Y/vX6th0P76kTePmDzf0tA3bzKblJGY5hUEWen0cBWKCqRkYzgd0xofuumGApYteD+ZT5RcXBSmrsoOxjCHXB/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KEzogq4E; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEzogq4E"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fbc3056afso6537493f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Jan 2026 04:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767356161; x=1767960961; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PnuZnIVx4b1neSl/o2K9YIvPPckcbR6Rn1nw0Re38eo=;
        b=KEzogq4EifTDthtBncG7e26HjbgxakVJk38o5Bk1ND16h9zK5jFZ+sK71KeiUoqp9B
         IxBuioIYB19YodsFx66lLy2+9i1kScTztORBm6fuHTBdckjGV+JC7Oe8H1IWXy6rxs1y
         ogA5v75CE8XB5YO7sA6a+rr7tVTUYrPQTja/ZlWm2lLlNXAROh0YHUtKc74Zf3Qf17JX
         w3fRL/wf6VxNXaDkFvPhsqP5tb6m93MYb0YSKBgmWPNHFIBMf5RrQBJ8gOwqdzLcP9n8
         R35sjCzKoY56IlrI74OqZLyOYhw5TwczbSR+luNn+XEu90XNB/SlWJoiLGxsS9PVGbw3
         foog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767356161; x=1767960961;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnuZnIVx4b1neSl/o2K9YIvPPckcbR6Rn1nw0Re38eo=;
        b=al4R4LVJV5+xTYAAz0MaBPrmJfm/x78TGjOb3p5Ea9OCYq8azJDUyd7HV3hAXPXwsH
         IQihTTvg6Qh52vPHU3zvRX2y3tHjsQ88PiyPMa3GLZOZdrQYITy+/kf8ssqEfmb416mU
         J9Ipmj1S/fnukr12ai3SUEFDLw+dzzxRgCuxjOEZvkiOnjFMihrvTM07Rj3a/LTOIcnW
         Ifmb86MqQHmxLPu9xtdIrPMu/jPygB6/hiHr6Q1QpaTZe0OAVRBFE+ocUSCQrU31lGJ8
         zlckhD/FHiJBWl7xoQvPpc4e1iy6erp7QWLkKFV2HF6OLHBfwfkJ9ztc7QpZ1yo/+OTN
         oesA==
X-Gm-Message-State: AOJu0Yx6Nq0xe6mLNns4aTReOi7HcHxeK0uCi2pCYnu7Il77yiL1zl0S
	FTfgGY0BoRuJV/TmLZqqXbH5pwD5i1Aviy2kJZH7xKaMGYNHOOOKMaD7t+eRl/Yw9t8=
X-Gm-Gg: AY/fxX6AHBXV5A+JyRT5D3892U/+yvfQU8dasjsmrOoL2w5uyIqCRUErqguJ/FGnmLM
	pZjA8+5laBVVjJpW2syvLkAWarIPvuGXaa3kaup0OjpH1tYDHe720tKzgFrDQ9lAwg3XcbcMrZw
	ZvF2mngB9hrxBAMu0t9KyTUNNaeaMz6sitPHzie6aYoSTY9BsORzo9vW0Xai+kkwqS59y+s1rbE
	QWAaKVrZKpgxWy9fXnmVO5yq+t36HwkzJtBz/FVslL/t7YIm9BsjJyZVQeM7UtDM1a7kXhA59oh
	e0ffSh5CxXasrkCq/NemJrlRfotQBsh/HLTDyPcX8BTyEt5oPpFC4m/I7YZAqLE+OLbVQl+h9/M
	5DsfBWjVaGkhu2PhjA3zFIo2gYZMdXm+Mk9Cw2VGAkOvKnnOjaSRITij1NnGCPhV/cmCOLAbyz9
	d07njpC3ZEHhS25xfvbTG+
X-Google-Smtp-Source: AGHT+IGGcNCPoHFXD55OQrLaXZVY3xrYePNcTRUu7jEQh1v3MdvLBBWq7AsdN4nnaYSCy0ghFMGauw==
X-Received: by 2002:a05:6000:2dc7:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-4324e50b88emr50714448f8f.46.1767356161106;
        Fri, 02 Jan 2026 04:16:01 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43264613923sm69528886f8f.26.2026.01.02.04.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:16:00 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 02 Jan 2026 12:15:43 +0000
Subject: [PATCH] perf tools: Dump callchain context marker names
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-james-perf-dump-callchain-markers-v1-1-3a9bdec20c58@linaro.org>
X-B4-Tracking: v=1; b=H4sIAO62V2kC/x2NQQqDMBAAvyJ7diEJrRW/UjykydpuNWnYRSlI/
 t7Q48Awc4KSMClM3QlCByt/cgPbdxBePj8JOTYGZ9xgrHH49okUC8mCcU8Fg9+2ZnLG5GUlURw
 u0d6uD2vGMELrFKGFv//Hfa71BzsOtbdzAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

These are hard to interpret in the raw output because they are printed
as hex but are defined in perf_event.h as decimal. Make it much easier
to read the raw callchains by just printing their names.

For example:

  $ perf report -D

  1798195372321 0x4638 [0xb0]: PERF_RECORD_SAMPLE(IP, 0x4002): 44922/44922: 0x7c8046dd3400 period: 120218 addr: 0
  ... FP chain: nr:12
  .....  0: fffffffffffffe00 (PERF_CONTEXT_USER)
  .....  1: 00007c8046dd3400
  .....  2: 00007c8046db86d3

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/session.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4236503c8f6c..e812f8954075 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -841,6 +841,26 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
 	}
 }
 
+static const char *callchain_context_str(u64 ip)
+{
+	switch (ip) {
+	case PERF_CONTEXT_HV:
+		return " (PERF_CONTEXT_HV)";
+	case PERF_CONTEXT_KERNEL:
+		return " (PERF_CONTEXT_KERNEL)";
+	case PERF_CONTEXT_USER:
+		return " (PERF_CONTEXT_USER)";
+	case PERF_CONTEXT_GUEST:
+		return " (PERF_CONTEXT_GUEST)";
+	case PERF_CONTEXT_GUEST_KERNEL:
+		return " (PERF_CONTEXT_GUEST_KERNEL)";
+	case PERF_CONTEXT_GUEST_USER:
+		return " (PERF_CONTEXT_GUEST_USER)";
+	default:
+		return "";
+	}
+}
+
 static void callchain__printf(struct evsel *evsel,
 			      struct perf_sample *sample)
 {
@@ -853,8 +873,9 @@ static void callchain__printf(struct evsel *evsel,
 	printf("... FP chain: nr:%" PRIu64 "\n", callchain->nr);
 
 	for (i = 0; i < callchain->nr; i++)
-		printf("..... %2d: %016" PRIx64 "\n",
-		       i, callchain->ips[i]);
+		printf("..... %2d: %016" PRIx64 "%s\n",
+		       i, callchain->ips[i],
+		       callchain_context_str(callchain->ips[i]));
 
 	if (sample->deferred_callchain)
 		printf("...... (deferred)\n");

---
base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
change-id: 20260102-james-perf-dump-callchain-markers-64d175b108c8

Best regards,
-- 
James Clark <james.clark@linaro.org>

