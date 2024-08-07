Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5B12E1EE;
	Wed,  7 Aug 2024 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045144; cv=none; b=HFpOfvwP+GTpGRe6vYCgrkEF5N9+KFXLLwvOGi4g4ZQLTKg+ZXgpa6qY72WT+Fm4nyRIpFvNsKAzradsjwN0stYRv6BJGVd5EoHiJRkDBqSEo3DgBAAybcxCIuvO1lADe1z8+Em64MaUruC7G37qC8SkAtS4TS1VuiOqbbs++ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045144; c=relaxed/simple;
	bh=Wkz42sdxI/Avx1F0A+cttY5SSLGUofHxTrgXxVRGSD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izVYUnCpMT31qtw7BBwVWfHxeT1nbG6QVMzqzJhcTR97SWZxBScfS+ywiEBlZpoETZa3qo/m8vNfRTzcAHiLBt2MlIVgXOCr5olggQPENE82PemN1rVxdH1XnOmKYmOIB0B68g+ywl2l1WdUUPUFqD3J6/+WstbbOohyWAsrC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKzkdsdI; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKzkdsdI"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so1524994a12.3;
        Wed, 07 Aug 2024 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723045142; x=1723649942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6T4Ucops/gCfHJjCk9BfPYNLoz2EpIJyrtmSqai960=;
        b=LKzkdsdIJbro/EeoE+BaBUBSmSzGrJedvfv4vjYuKiOiupY5cDY6Lzz2Y/tNKABsxY
         iaJ4/Ysfx9jYAA1QdqL4fqiCnlOgbZxqq58UIDAKsExohsJIrK1MdDD6MaUTEcPScajI
         /hpocI/01WeintbHbvTwChRtdXBQ2P+ZgXb3CMKFmLNFTrG1KGBjZdDKlMsLfVHiW65m
         WGJ85FxdCf+pJRW77u3qVoNZWQ5FqDAs7IF2Tba2xzzu0e9pg1Ycs20siNQauRzdoG8j
         kzq3r2zw1keM072WRxOdbr5yQyBGdsgTbWxaV8rXYlrzqmIh1gOTl1rEwjW8R3dhTUTc
         ItFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045142; x=1723649942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6T4Ucops/gCfHJjCk9BfPYNLoz2EpIJyrtmSqai960=;
        b=Enr31Stb4OQH9K6cCyFFGiSkTVSw3MDhhV7FOYZ8eItAJ/1xF4HIolJdeJkWhNDv2T
         WT11QfgIWyUDyGDqiWkZNw2If0m6cmvsBeI4LOGguS+JnjmPI+xt0gwtLb/PqePwAUxj
         +p6ndDBcw6A8LF5eatjZpcBp9P+DlDwShLZMtDnntF/guOT8URL8Fsh2FWIVOgFJ+OxP
         kXsgOXy9zyO6J3pe24UfEnwFpvOLB19nuI/GyblDa3sYHM2j9T2WEOKozcEhlIfRmtQZ
         g9LR4PdkCS60eM+5+XAv9339sSlLLoxocfXyl38VwlhYdJhD0stA99BqgFPcT9lT+rm1
         WYQg==
X-Forwarded-Encrypted: i=1; AJvYcCVnGH/uFzivjRFaZunRm8DFsTNV7uA55Auc4jnjytIVU2Oz8EwHMnQn4lDu2hez6b6cZqrH1VDtDLjIAsO+8YwH4AAbv2vJlzyCNWQZwF10AG9NOauxDoCEsgU3ccuUoV93qPCnzuEVQ8J8yz57fA==
X-Gm-Message-State: AOJu0YxAhqzS/tRy9txNKhgXiiYqC/ECYPoWLrrpyShFC7up4/QCrBY3
	EfxDDPCLrirzbqf9uwUE7agCPYbKiAbJije0vC5tS+FOFUhA16Sz
X-Google-Smtp-Source: AGHT+IGmAayc1r5VOLfqJ0tm2v7PNHU4D1mnrLOlMkzDjp4EmUClsXfj/xugr8d9XTnFhmOmcdAmBg==
X-Received: by 2002:a05:6a21:3406:b0:1c4:afec:a7a7 with SMTP id adf61e73a8af0-1c69957a8e2mr18153974637.12.1723045138409;
        Wed, 07 Aug 2024 08:38:58 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59297329sm108097375ad.247.2024.08.07.08.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:38:58 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/9] perf evsel: Set BPF output to system-wide
Date: Wed,  7 Aug 2024 23:38:35 +0800
Message-ID: <20240807153843.3231451-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807153843.3231451-1-howardchu95@gmail.com>
References: <20240807153843.3231451-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pid = -1 for bpf-output event.

This makes perf record -p <PID> --off-cpu work. Otherwise bpf-output
cannot be collected.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/evsel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bc603193c477..b961467133cf 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2282,6 +2282,10 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			test_attr__ready();
 
+			/* BPF output event can only be system-wide */
+			if (evsel__is_bpf_output(evsel))
+				pid = -1;
+
 			/* Debug message used by test scripts */
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
 				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
-- 
2.45.2

