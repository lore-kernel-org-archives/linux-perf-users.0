Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2DD1E517
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555489; cv=none; b=QvczBmgE5IcqgTVewhsrwZ5PcyXM1hNnqCG54fi0CDer6nAhAEk4hXAPaQ2or0E7v4U89qlbL4RNLewtK3/j6eHw/BhUzyQUSMidNTYqHKrPNVmezOC3drI+LdTYbwD543nyPLRoh1+NtJTB/cWlqv7+yAmRE6Yf48KBjw7ZIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555489; c=relaxed/simple;
	bh=vbJDszVbFZo5V6bkkKmF3OewIJREyf0evahZxMqFmW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ea/WsTl0KBxj7D11iLP9FXTfaQMti6HO+vSS8+PlQr0TPWh1k3Nj1sq6S4WEgEY8H2xD5PT1U1sPv0NqIyd9Y4FMj0xNefgbSZfoSUq8/ALvmizeYykQ1hPixDdhFQxt9o8rN7cBlH8AvnIeuCnlnAktE93JT/ytXrkQpTjm+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J8wGZRmn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8wGZRmn"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-429d2d7be1eso10271965e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723555486; x=1724160286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuKn3zCZ70JZQp+93StFA2ZNN01UscP73ZJf7VHOy5k=;
        b=J8wGZRmn7M1xvO8I3laNY+JTkJsi7O5dpEwiyqqLgFYGyRwETOBgxqg3nv4zai5R+L
         cPhmSPF2Hv32K+oSRd3FHFQY+pW6Fsqvc85TnCZQmlsYquhmA7oUMnW4ZrlLEIko8Ouy
         1r0J7QBIBPEIt8+G9IVjpLwnhhojz2NB54jXMlIkvW0Ad69GjgDxtdfoGSI3lI/2YLEX
         BdwRaiV+rsx4Swioj/KcRXKwxtfGNRnY09vM38S2dONNyetiY+8FKODbV74nCKhRH5r/
         4BZ8r6qpALNZniukc8WcUL0BL5JWLrenrCIGAoXRSb1EY9qfkTu9hAxOqBad/ZaXKRne
         91HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555486; x=1724160286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuKn3zCZ70JZQp+93StFA2ZNN01UscP73ZJf7VHOy5k=;
        b=PaJb7/BiKxhL8t/p4oXJoRF9/TV6YbP4OkUyIfWaaU0zeNA79nFXN2trlJdLh9KgtB
         PP07vCrqOfjSk2+w82TXkMLn2pRJwlPZsy/ZGB4VPTKFySer5sepIx0naTe3jpI5pqej
         NsUSZ5MUMhIbGZvMhIT2VWLCZ28uc5s5vdp2KtKKs2vCw5p4z/L08XGs12y4fcL2xBZv
         BujCLx6c/cO/T21k3wUZgc6SQw55GJdKFmWZSIaCGqo6i/YF2SZDj4Bs14KgKh80DDs/
         uz/t2h9+Ud0bti+5omUID88iPmnhbfJ4n0I7SJbp2e4s1oT4dxWiqr9BPWV6TFaYOef2
         rtpg==
X-Forwarded-Encrypted: i=1; AJvYcCX/FaYq4rcpLkUV2FbshXfmkY6ItjxW0l84QbgL8mwvBhodqyT7HjhCEsRn3guIBXIVNnvzznaisNkiR7UHJ4p/2UOShpCJe3AZJL5PCEsyWA==
X-Gm-Message-State: AOJu0YwWOpE7ChpwIpY+oqlrH5HHWfYd1WV5UqHyDkebp+Ja3LMO8EqK
	ntsIN2WWsMJcCXaVSESBJa4XEbPuBMu8VIVYugtrWawsIiRwZjGwmCI7qGPJTRM=
X-Google-Smtp-Source: AGHT+IE5Wty2PhcPyeB3adoas1B2d+fRB+FpKrHGaJmkMiJ3JOcxRs+Gg6UES+MUF4AfDgXHAeTrVw==
X-Received: by 2002:a05:600c:4689:b0:426:5b19:d2b3 with SMTP id 5b1f17b1804b1-429d62f6d77mr23808865e9.14.1723555486482;
        Tue, 13 Aug 2024 06:24:46 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738d21sm223186625e9.12.2024.08.13.06.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:24:46 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ze Gao <zegao2021@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/7] perf stat: Make default perf stat command work on Arm big.LITTLE
Date: Tue, 13 Aug 2024 14:23:08 +0100
Message-Id: <20240813132323.98728-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The important patches are 3 and 5, the rest are tidyups and tests.

I don't think there is any interaction with the other open issues
about the uncore DSU cycles event or JSON/legacy hw event priorities
because only hw events on core PMUs are used for the default
stat command. And also just sharing the existing x86 code works so
no big changes are required.

For patch 3 the weak arch specific symbol has to continue to be used
rather than picking the implementation based on 
perf_pmus__supports_extended_type() like in patch 5. This is because
that function ends up calling evsel__hw_name() itself which results
in recursion. But at least one weak arch_* construct has been removed,
so it's better than nothing.


James Clark (7):
  perf stat: Initialize instead of overwriting clock event
  perf stat: Remove unused default_null_attrs
  perf evsel: Use the same arch_evsel__hw_name() on arm64 as x86
  perf evsel: Remove duplicated __evsel__hw_name() code
  perf evlist: Use hybrid default attrs whenever extended type is
    supported
  perf test: Make stat test work on DT devices
  perf test: Add a test for default perf stat command

 tools/perf/arch/arm64/util/Build   |  1 +
 tools/perf/arch/arm64/util/evsel.c |  7 ++++
 tools/perf/arch/x86/util/evlist.c  | 65 ------------------------------
 tools/perf/arch/x86/util/evsel.c   | 17 +-------
 tools/perf/builtin-stat.c          | 12 ++----
 tools/perf/tests/shell/stat.sh     | 33 ++++++++++++---
 tools/perf/util/evlist.c           | 65 ++++++++++++++++++++++++++----
 tools/perf/util/evlist.h           |  6 +--
 tools/perf/util/evsel.c            | 19 +++++++++
 tools/perf/util/evsel.h            |  2 +-
 10 files changed, 119 insertions(+), 108 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/evsel.c

-- 
2.34.1

