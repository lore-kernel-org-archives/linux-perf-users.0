Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7837160
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Oct 2025 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760233627; cv=none; b=bdCYjH6egz5p0Jf+ec4KEJNZGdAl5P+e3x6hwTgzoXXd5C9rN+l8LQoiPwhYSSKOW4UTK90Llq/Om6F6/DILIqeOjqfsMqi2H/Km/IYc5IwKsSt5wvs7nsmoh9iy6unlZAClyOnMzndHlIZeiJTGMd1ZNghCnlGLRWlaS6bo8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760233627; c=relaxed/simple;
	bh=KYbEOZWKrX8qPsvFbYgylfuWLs26ZJ9jrLUaztAw1EI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZwLSKxW20cnmeIvFAkW+trl5U8vRDeIjk+t+IpSzoWXWICuO3BSSVaEvxXTAP7IT6PlN7KSqOphZAOPnKmMgI/4Nu6JsZCBxVGTEjeolossn3hXDsRyUO1Gc9034WXGTWoW7qkprpeumTbfJeqqErIO8MaIs4P6fpLx9MunQkBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7H5XCnB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7H5XCnB"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso2758332a91.3
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Oct 2025 18:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760233624; x=1760838424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYbEOZWKrX8qPsvFbYgylfuWLs26ZJ9jrLUaztAw1EI=;
        b=Z7H5XCnBNDgdAWcqG7fbaIFRVG2lAn4UiuXx558qr3qMc56etoVZm8uhKWKeOgo4XL
         NPpA8pn2eIT73RwGRr7dkwFeJCnbzO4Hz/d3FrOSjNvtzPKYNXMZ3WjUVOxRUsH3rG5L
         C/3p/zb2NlmdqWZM00SyKmNeeISVGvhIxozSg/q0tu5BPAG/fYiuWbh9WMdK6GtTujDA
         Nek1GGJGcqot1jOt1jQWDLjV+DYHl5P/AYV666An6KhNbf8g4n+ZHghN0YP3n0odxyke
         d3KTr/txZzN4ibeOlVY+IvSQRhYOo9wGMOaKKATRws4cK8g3rJEPXuQe2xl2cE1CJntt
         wBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760233624; x=1760838424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYbEOZWKrX8qPsvFbYgylfuWLs26ZJ9jrLUaztAw1EI=;
        b=Yc3CibNOIBbzZXPzyqnv6KYhr12jARtjuqnl+m4Tc7AitZikB7vrBCEkkNK/UqP0Ao
         WNKJCHQfsa2VKdXzuJ5fs01yxGv9qH+aWwgo9e0mBZTKAIufNsmIjUFitduhHrwsEZ6n
         HF7iMju+PJf0VDlWzR1LlKa7jNtd/EpQzeIaEhP3hcVfmXp7fG3lgOKnEsk3aj5kQcRs
         wSMbTks9YFbIztoMWC9ySAsI+AfD8wtqJjZsakX+3WDyS7YAtZIelNmKUM1MA2CgNqG+
         Jlxd28jXpZ5JDWAP8D3btAdN1KJ9nsOnCC8OwLxCuCqwh56jFTH0H6RAgFRFSrZW+PMA
         xvUg==
X-Forwarded-Encrypted: i=1; AJvYcCVSt3NfUmD0mfm81XYi5Z/vKl50tfAUhqsjV4DOIuUVq9FD8tVwFMWdi0QySWDsa+WzB0lDSHYjDOiZXuFNfofr@vger.kernel.org
X-Gm-Message-State: AOJu0YxXFYVFtnW1xZGPnuxstBc4V6XV3OY4/V3QIawrHjrt3iWF38Ce
	vyE8/FRxVYiG1X6CxsgOfVjvU8Asf5JBYxV1QuAWckJQpofC/bCi+MSO
X-Gm-Gg: ASbGncv2n41qw8blwJI0oCMhYECVVU+ItqG4x8lGzV1NhhXVIuca5wv0ztzUVty031p
	/ZQeNmp/EOHor+nd7xKZ+Y2f+YaV5SDNIoaQ5/YzAQuGzL6v7Y8ulSreGuxV/nUaibbE31HOqwI
	AVpb2kragUHV5l3zJ2MPV1g+jEL6clDPz5vJAiDNTuQyJksFOJUsJw22Tx64uM1EtAwqQgUvJtZ
	TUFQLa+4gugkYdvkC8bSK0sNcSyd9Ov4B6Tc6IxJ1UFPbXhJ/tcTWEeDXRV+vyYII9Ld23N4FUD
	MjDSG0tECI8YCmx6fDNHKGCrQFoBIC+HazgKdPrtRR6l6kJ+1WupBrD3wNNqq0pkfCQOFI+bGnc
	SjIX/2UX82BJBMty58io8amDD7m2fISwSBGBY0Y8c9fRr5ecf/vs=
X-Google-Smtp-Source: AGHT+IF7fdQ4DpLL7d5WN2b5Q4XZzmynuin15/teAqQfYmvPl8vAgZO5oduNg4XTy9tWmKlYPreuFA==
X-Received: by 2002:a17:90b:33cc:b0:338:3e6f:2d63 with SMTP id 98e67ed59e1d1-33b51117433mr25555653a91.6.1760233624523;
        Sat, 11 Oct 2025 18:47:04 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33b61aab6eesm7712060a91.15.2025.10.11.18.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 18:47:04 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	Eric Lin <eric.lin@sifive.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Guo Ren <guoren@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] perf vendor events riscv: add T-HEAD C920V2 JSON support
Date: Sun, 12 Oct 2025 09:46:19 +0800
Message-ID: <20251012014620.799046-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

T-HEAD C920 has a V2 iteration, which supports Sscompmf. The v2
iteration supports the same perf events.

Reuse T-HEAD c900-legacy JSON file for T-HEAD.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 tools/perf/pmu-events/arch/riscv/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index 0a7e7dcc81be..d5eea7f9aa9a 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -20,5 +20,6 @@
 0x489-0x8000000000000008-0x[[:xdigit:]]+,v1,sifive/p550,core
 0x489-0x8000000000000[1-6]08-0x[9b][[:xdigit:]]+,v1,sifive/p650,core
 0x5b7-0x0-0x0,v1,thead/c900-legacy,core
+0x5b7-0x80000000090c0d00-0x2047000,v1,thead/c900-legacy,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
 0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
--
2.51.0

