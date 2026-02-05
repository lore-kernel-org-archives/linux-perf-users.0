Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3E82FE592
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770316567; cv=none; b=gbvlA4haCNxsHxDaYv8YvpJavGPHy5xG/1z9p7pvDMpG37uPElcFJFz87D1GQsi8nHo994u9KV4ckt6kcvE3YIgPL9PbGUoR84vaeJ++nkqegX+xi3TWpZUteyhD09f3V/DqJ5a0tb8f/HUt+Vf87XnE6TRHBi/mhW8h1galiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770316567; c=relaxed/simple;
	bh=k/Ji7iDV2K2qtQ0jTvQ1OLnkzFvMzkXLkUEmLrFPYfc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hpujWDCvpOLnEekmJUFCRXQrA3ShFqMOCMcBOL0Nloz2W/3lgTcuN7qqR787J2/spH+3WbEX0og6z+Cyw2qaTr1HwuHbDX7tzeh3p/lJPeuNX27ffUIb/wgQZ3XRngy5dKyFQEd+TTiKhVSHEV6EcRDqpGwc16FEJe/mvDHx19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mqFDshMc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mqFDshMc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a7d7b87977so13027005ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 10:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770316567; x=1770921367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JQYRJMR8SQooFgqnJubk86Rh0kXQsWJQAgKMTMqX+vI=;
        b=mqFDshMcMrTFTTljUpr7io2O0q4rxnXiQQ8L03knCgXsDpGhyB+hFZewBNYDf8iqLi
         VkEJj5Cy5YC9kuerGun5d03Fb1deoJteOH3MHYzrSAvxBz//Wm8BCEtpDkyvdOd1NGBh
         mphsbRQVDW/0RyB6ZGRpFYT3XE2FYo2SsKE5Cznki9BbQ99d4DEcSj6OuAP15HD1fNuo
         ExScZAoG614igON8cqQlXXPYDRqGK8++D4TevM9PPcEpS/r3uFdeVZnqgGArL8b7jH1i
         DKS6IWPcb21/2cMH4m9ZcgjZ3gEWhDq9ZfzCwFLfGR1kMUxdDVDqqQ3RVjC8PHoro6Kn
         GNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770316567; x=1770921367;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQYRJMR8SQooFgqnJubk86Rh0kXQsWJQAgKMTMqX+vI=;
        b=hDpy9AptIZ11e12DYgvOY+MKJykor8Rin0UFgqvaOtEC4gsj0dprr8YIGyU7ToZ14Y
         Lxzl5A4mikZAOWHrUEFaNkYeFyYa85L3Ixw/pVnDTqHbKRI40yIiq72566y+2xqV5XF0
         CIN0GI9ujL9LO5mdjkclBikZea30CrXUKwxFse0gm4SAMxY2mdoUnpQHhSYeJhH5HxzU
         DKx4l+4cDHAysQQby4arFIhtNHIFHIGxYEchqy+/o5hVvMp/pYaGH6zK/XYTNlh0zSAG
         ZJHMbFPwhAE8vvUVE6SQWNGQyKBA8Pw11DFUjuZgvTi/hJLGhBr0IEPEdbJTTCZ+9kFf
         NfVg==
X-Forwarded-Encrypted: i=1; AJvYcCX0qW8BKgfFlG3ZeYP9C6fiL8U2VbNnZiKXHsJScEoQLUlRYjtZRZVKKvhMFsjxVsHl8OoLb7Ngyo7ZCvrqetuN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo1+aHyu0mNSIvrmuC3IUtqxuN/K/q5jQImfhfAuKd2aq5UqfK
	PPg80EIeoZGyFbukmd6kicbcqidgSOC0nHgd5HfPOU43FqzgmS+3hOx/ZB9/4nJLYaCy9xAhf8n
	H47r5Ir2sFA==
X-Received: from plgw2.prod.google.com ([2002:a17:902:e882:b0:2a9:1508:533a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f605:b0:299:e031:173
 with SMTP id d9443c01a7336-2a9516fb34fmr1996815ad.35.1770316566742; Thu, 05
 Feb 2026 10:36:06 -0800 (PST)
Date: Thu,  5 Feb 2026 10:36:02 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260205183603.459363-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf tests: build-test coverage for NO_JEVENTS=1
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Leo reported the NO_JEVENTS=1 build being broken and this highlighted
it being missing from the build-test, add it.

Reported-by: Leo Yan <leo.yan@arm.com>
Closes: https://lore.kernel.org/linux-perf-users/20260205175250.GC3529712@e132581.arm.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/make | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index eb41516c0562..6587dc326d1b 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -70,6 +70,7 @@ make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
 make_nondistro      := BUILD_NONDISTRO=1
 make_extra_tests    := EXTRA_TESTS=1
+make_no_jevents     := NO_JEVENTS=1
 make_jevents_all    := JEVENTS_ARCH=all
 make_no_bpf_skel    := BUILD_BPF_SKEL=0
 make_gen_vmlinux_h  := GEN_VMLINUX_H=1
@@ -144,6 +145,7 @@ ifneq ($(new_libbfd),)
 run += make_nondistro
 endif
 run += make_extra_tests
+run += make_no_jevents
 run += make_jevents_all
 run += make_no_bpf_skel
 run += make_gen_vmlinux_h
-- 
2.53.0.rc2.204.g2597b5adb4-goog

