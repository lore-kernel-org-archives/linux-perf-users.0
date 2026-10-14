Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A47566C42
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999260; cv=none; b=IGnv8v2Z0oCsX89IDJL81mSQWChPtThv++XOUS3LwWiEN2aSOh1QzF/hoFgseniPbSrAdGik3bbkp8iSELPPublb4469qKvyHNtSI+sYN2++u8pgg/wkTXhl4nHYrw8eG2+y0DP/uisQ3Yu3qyID3IxD53oCynXyWyih0Bpy81Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999260; c=relaxed/simple;
	bh=HI2niRA90IKDKwvsHpPppiqbbhE7pSgFPWCVraH/PyU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Iv4wAkywn+5wRLdGdCRdFCQ923/Qt9uuWt8Tfxln+WL1sEeRGJ/C7kWZ4OeY6a9ia5Y8kGsHiM8VSGR6PHHI3tzd5n95hzJ3T+W96T/94CxGfv9Z5wf1vmfCEuQopGpOS3QWMbeVf8xIJXbmZrpd8CiIh051BauLFGs9HrrY7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=JEAUsAgi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="JEAUsAgi"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso480165f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1791999255; x=1792604055; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/5P9b6OokIozv5Q4UiMUi/dV9UBgkDoPgxyM+sM9qio=;
        b=JEAUsAgiB7wcJRXcHiA7tQIiA0lpCUi9FmQiEBgaXSpvxwDH5c3xwqXjAjSPYifOsk
         YqD5JMsp+xzvpknEZIZj3yFhyJTeLHPw7beDhDFbv1lJxv7ZJZlHdEOQZvJ/JJS5XrtI
         5h/mKPtJ+hXDLrOpMtqVM6O5HkjR1iBjC+Y5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999255; x=1792604055;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/5P9b6OokIozv5Q4UiMUi/dV9UBgkDoPgxyM+sM9qio=;
        b=i2C0dopvTGY307nncydelZucPQv65koRtRJoVeFq4OoJa6/f39Q3OHIQGOAbuA8K3F
         FbNrZ9HYho0Yqpnt99iwgv2yxc2ct7Trb64pTFDwnnQyaLuI6IUOhNLOEHAxe/7Pd2A1
         QwmstbChOe7jw+tCYyibksjNK8MXSgt7RcG+Hg4k9yYS7Bnb9vP26Pjnqu4BxZJKy4C7
         xoHPSuv0QK98zg1LnZgOJuPkuNe5qblktYXTlbqgXZ6tNCTMjPKx70EsiLJxyfzXkq2i
         hGOCRxIsqmDmvZlytYIPKjHjCzJtp/Q12coYN5ouUvilev1rfn4PsimXeakgMyTzO6Gm
         bODQ==
X-Gm-Message-State: AFq9FYLAoPTnZGxXDkZmy28KWAghSDGUbhzRfxvZMn03zQnzH0zvbyxM
	pjDBqI6ILlsHN+MMXnavbR/4gCfkTJUB/IqWAazufzIWwqt7/cdYa2ddjKtRZtsk6qVnF8fGdVk
	UpFzpMTIaUg==
X-Gm-Gg: AYBFou0v89l7SSX2ECn5lvWqJwnVgCOYefiit+BtBzREelRkWsWkuHSPIn9CyRCvtjt
	WKWu6R1sRV9CpolSf8KJsEB2BdC6IqXmdgLG3QOqVYN6JbEjKAdyW6QStx9vtJh4ltclKG1F9Yv
	B/FzBth0HpAJDuEajXMuha263NPeIJQFzbYHUE+ZOkbB2gD5cZgTMsYLkt6J4QY9tmGi9XFZWzr
	XPYuACCLxbDKVJ0qGBDUQC8Myz84KqnIzHG/6t5nzXf2mbkyjFLRy5vQbjX6f0EW69ZhvthtIcu
	8IIPxGafkYOywJ2enkG91Qd9PsqJIUN9L1skbA5rqkb4bTHXjvvwOBB8bc2y541LpZcHKpgyL+F
	XcMjRDXo6R1teEt5OXJ+kZts8cBPGdCJDToQCl9KSVMfGa5kpbw/ZAhs3mAJBsX5AFz6jQnbrVV
	eaBHHXaWybwkarrh1U67keODb2Y2vaMhSeltYtcFm8LifSvaoX8zoLqvN1
X-Received: by 2002:a05:6000:29ce:b0:488:5852:6ee3 with SMTP id ffacd0b85a97d-48dba9dc7b6mr24650276f8f.34.1791999255646;
        Wed, 14 Oct 2026 10:34:15 -0700 (PDT)
Received: from localhost ([2a00:1358:e0ce:6800::3db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaa9f9sm13417135f8f.19.2026.10.14.10.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:34:15 -0700 (PDT)
From: Ivan Shapovalov <intelfx@intelfx.name>
Subject: [PATCH 0/4] perf: support zstd-compressed kernel modules
Date: Wed, 14 Oct 2026 20:34:06 +0300
Message-Id: <20261014-perf-zstd-v1-0-9652727886fa@intelfx.name>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBBA0V+RWWvSqVf4FbHwGIwF0ikR4t8Vy
 5Pc3AuELJNAEVxgaWfhZfbAMIB2rOeBFHfeYLRJUWOsVrK9OsV1ymS5xgx1Qk0Evl8t9Xx8r7L
 6LVszUeveAdz3A8B5zPdtAAAA
X-Change-ID: 20261014-perf-zstd-279017105eb3
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ivan Shapovalov <intelfx@intelfx.name>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=intelfx@intelfx.name;
 h=from:subject:message-id; bh=HI2niRA90IKDKwvsHpPppiqbbhE7pSgFPWCVraH/PyU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0did012TXdDVVdHM2x2aGVTbFF6Mk1wO
 VdTR0xMTzcrVmZ0V2JmbjRVWnluRk1qcHZNZms1NHRQOUt3NmRICnEvOU0xejZ1Y2U5YzFZbmcx
 UjJsTEF4aVhBeXlZb29zdSs5UEMzczBkNExTSWM4TnVUQnpXSmxBaGpCd2NRckEKUkd4VEdmNW5
 USXF1bHhEYkYzUDVxdUs1a0xaWVZxWEE0K3VtMWs3dlRZMWxGL0c0SWIyU2tXRzZVSEpvVDloaA
 p2eTFTUjljZG02L2FXdlRzR2dPUGpOL084amRabTdwM20zTURBQT09Cj12S2pRCi0tLS0tRU5EI
 FBHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=intelfx@intelfx.name; a=openpgp;
 fpr=04DEA27EEF682F17083D892295D5D5F5A5A5E5E5

This extends in-perf zstd code to add an interface for streaming
decompression of an entire file, and uses that interface in dso.c to
support handling of zstd-compressed DSOs (e.g., zstd-compressed kernel
modules, as shipped by various distros including Arch).

Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
Ivan Shapovalov (4):
      perf: zstd: zstd_decompress_stream -> zstd_decompress_buffer
      perf: zstd: factor out zstd_init_{c,d}stream()
      perf: zstd: add streaming decompression and format probe functions
      perf: support zstd-compressed kernel modules

 tools/perf/Makefile.config |   2 +-
 tools/perf/util/compress.h |  22 +++++-
 tools/perf/util/dso.c      |   5 +-
 tools/perf/util/tool.c     |   2 +-
 tools/perf/util/zstd.c     | 188 +++++++++++++++++++++++++++++++++++++--------
 5 files changed, 183 insertions(+), 36 deletions(-)
---
base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
change-id: 20261014-perf-zstd-279017105eb3

Best regards,
--  
Ivan Shapovalov <intelfx@intelfx.name>

