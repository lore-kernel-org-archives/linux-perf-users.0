Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9513B7AC;
	Sun, 22 Sep 2024 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727004213; cv=none; b=gbhuxDamy4f0xIRFsRv9RBaqEAnTM2W1a1KgeJglCWcXVD3vT7B6MkV+V8YapVwcGTHlFNGslLAF6+PNM9XoNQc73Gilr1UsCGLvMJ/bIc/bubMXfi6zvBP9Gaqh/i6WU3URijQA2B1fGgRk8bw9WAqc61YYfC6IqdGGXX2JZ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727004213; c=relaxed/simple;
	bh=60A3xtkTT/KvaXL3VOHB0ChVGkhP0gPJfEPwVoyFjI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZJ1fdWNo1C8ZP3Hth5XSEPdNMbZ/ZM7oFX1o86h2j6GOIGzVHKvFiJ+ZW9PklLDWyn9O2A/gw7iPNnNAbCEUUCz8XV04dExe6o2cfKk2DdRHN2bvMZxqZtjJPAwKSNpVU2MaivWDeEY8kt7qKEK4V4uV1Rgbqfhw0Wa32r/W+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA5oJnt2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA5oJnt2"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so3155878b3a.1;
        Sun, 22 Sep 2024 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727004211; x=1727609011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4XvrkkHqY+npY99j8P05tKxMHoVnzvwXiNTajRAyns=;
        b=BA5oJnt2TpZkXTS1KSCJulV2/+lxW9mx1phvBTeN15h3I/VWHG5l1XXvSxCxaalykH
         bWKmzJQRunKKY/z22kFIcKA68syIsZcT+6T9q9KuEOwDG1Mw9fI82/8XP8ho7iB0MZjE
         okf/Y3iqfgT4NIfKGMfGqMhl0smlkOBXYA49F/8tqEGTMa2QgpePl2U8/lgtRu1b4SsA
         aYbohWOQ6K6WiOoMEc7enc6mwY0uTOzoR7FcKFX8DxA5kaJwRIcIA1GdaQ9FQIxPFrU7
         G0yOMfi2YL/NqLBa2H9plGM1vNoBgaPQ6K6iP52MFNfIbjomV8qnTJli60Zl0x3bNoau
         /9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727004211; x=1727609011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4XvrkkHqY+npY99j8P05tKxMHoVnzvwXiNTajRAyns=;
        b=Qn5GmFRaHDaiT3qFRW9KNq3DiFt5Nq49YKawgfDB3Qyw2GW0d2fHOnQCxkcWy1P/7y
         Erzcr2K0HuHIpaDQfqjU9dWgHLnTTZpd87z+Qz7RyU9xSlZfzIoc2kkGlSlxHfHVh+Jc
         3RhNm/cgXrXszOznaeItNdCDC9ZaOD34SzfJtI/3kMcXh7yNomjgQpfCs+TeLyWZFBce
         HYOmVzQchkfuCnxvYDUam83POQwetGpR8AJQjINBBQjEF5JTKh/tnfI/+IUijusaziZc
         AvUE47C4lAmeoK/qPMc4K7/gCw8PbxEflfoaFrGk1M1S+yHn9Fz2K4ozKlG/Dz1kMYz+
         2Caw==
X-Forwarded-Encrypted: i=1; AJvYcCV4/JdhF1LTllD0fPQlws7AxlCVqOCUIJxVVMV+LMC1Kec+5G8XaivMly110DRyRw6AU8fuRY3QMucyDUFCCdpERQ==@vger.kernel.org, AJvYcCXDcYA0iHRiwnfbYN/aSj/BnmTdJDuH8m3bU0VSa6WOZxgXCnw857FEJlReY0U0rdTDnuHBn/lBb9o6iNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiogcHaR3n8e+8/ZavIEZidEl714byTEamb+VWFOB/K96qL4rR
	r/+j8YwyMBkZSKcoWDFmjrCTCZInEQqhAiflGklkZqMKyK+MCYV9
X-Google-Smtp-Source: AGHT+IGe/D4+othuBwijX06o3xD3WHBhm/yUnZsI3Rg66EvBVbXR6EQQXOXJALO4mX6xIZ5hwW9KWA==
X-Received: by 2002:a05:6a20:c888:b0:1d2:e793:cc0 with SMTP id adf61e73a8af0-1d30a8f2e43mr12712524637.7.1727004210710;
        Sun, 22 Sep 2024 04:23:30 -0700 (PDT)
Received: from localhost.localdomain ([103.175.62.244])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b97e51sm12353079b3a.162.2024.09.22.04.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 04:23:30 -0700 (PDT)
From: Masum Reza <masumrezarock100@gmail.com>
To: 
Cc: masumrezarock100@gmail.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	John Titor <50095635+JohnRTitor@users.noreply.github.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf evsel: display dmesg command of showing a hardcoded path
Date: Sun, 22 Sep 2024 16:52:23 +0530
Message-ID: <20240922112226.141756-1-masumrezarock100@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In non-FHS compliant distros like NixOS, nothing resides in `/bin`
and `/usr/bin`. Instead dynamically symlinked into
`/run/current-system/sw/bin/`, the executable resides in `/nix/store`.

With this patch,`/bin` prefix from the dmesg command in the error
message is stripped.

Link: https://github.com/NixOS/nixpkgs/pull/258027
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bc603193c477..7a06b7cfdc7e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3342,7 +3342,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 
 	return scnprintf(msg, size,
 	"The sys_perf_event_open() syscall returned with %d (%s) for event (%s).\n"
-	"/bin/dmesg | grep -i perf may provide additional information.\n",
+	"\"dmesg | grep -i perf\" may provide additional information.\n",
 			 err, str_error_r(err, sbuf, sizeof(sbuf)), evsel__name(evsel));
 }
 
-- 
2.46.0

