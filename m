Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5019A21C190;
	Tue, 22 Jul 2025 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224636; cv=none; b=WxlTanxxA3QzjjiwNBCgDCU7EN51qPdxpdVJA/gf3C8t4u23uBFYj71VnjgQjRbO3ZNTMoCWpeySdLuRvaDWW+9zf961nCOah6N0r+kn042qakWYMRqGAXVkK9wxSVU5R5zKeMaufnXs6q5pOH4/39zPgY4ycxq5q6e5ZL3PAHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224636; c=relaxed/simple;
	bh=/QBVWJ0kj7458ZMk1ote9UnlBV1cQZ5CKBVmiln3XUc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TSdGrJVLIUXosMGRvl+fr82iC3w7pSkp/vR3nNSl77b/8/CmRS0mAbI8MsLqPR/yDQiq1NKP2gjUO/hI1IP121xwB0oXHK3NvNz3iwB5YGm/7qtnbtn4gs5v6vde/RmQUEgl7WccbIf96vwxONbyEJXYoNUvg0XH4FHHWwyHUf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh89VRaI; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh89VRaI"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e2e3108841so714329385a.3;
        Tue, 22 Jul 2025 15:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753224634; x=1753829434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QBVWJ0kj7458ZMk1ote9UnlBV1cQZ5CKBVmiln3XUc=;
        b=Fh89VRaIo2XRPBGlPKAnvowjBE8GeR8PmbxzgP8dknCL2BP9S+03aW4S4qUTU+zU9r
         qhuDVfLawgIKeZFuznbND/NcJb2tZApvQYmaV1Uesy9AB6pCABc8p6Fp7ImUlDjS4Jxs
         1RB3RsYvZgAeFb5gt7BRj00FpIb7iJ9ccJb4xI+sPxVav9XqGTSONrwjvIIh4y6+IuJj
         8puamkCmBw1DANU2SIuU3ptRNqAc3nADrFNMGOGWVrKho6KSeamFFDLCkZFJB1yAZf+3
         anUvCwZfi3EmcOKirBFDv7FHbS7P9HrEYBRsWldUSRz82sZWPTSYpiVaflDiEfBl1A2A
         x99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753224634; x=1753829434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QBVWJ0kj7458ZMk1ote9UnlBV1cQZ5CKBVmiln3XUc=;
        b=pkqpzwz5WzE/bEYCOsWpe1SaP/LBpzEyeq81N+LtOKnV+b6uqwERM8g+Mavl8HckaL
         hUCcnCKkQj9WjWBf+Z6UAn4bINIqFqY10pwbUVM/xXqQTp3zYQUIcZTFi297l7/Uyf6+
         jQXSgsFf6m3WhKKHu8PmL9BeZtMHTl11ZGcBh7bupeKW8yt3seTPL202lOvQZYYtDN6J
         vLSfY2lC7TpQ/YbXmx0Ut/buptO2U2u8wQCHDHDGypi8+cu/kksw6j4sdtofq7OPyyFg
         aX9Cg/yuMzHQghgFvk5rzt5HBKJ8H47lAuJC34gpFBnV9MlnynZkJpFhMn2R8b8EFJ1S
         u0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbbpkZhpMTBfoW/5x92VmE/5MDA6Z8sgoCHbFH2PUsCBM2/ePLucnwSpd1mx+5yshRJxZ/2GlN3asHhy4=@vger.kernel.org, AJvYcCXn/gHBVXk1s7nZIp8+PBxL10hNK1Y2BNdAjHKAJhvdqHm43iDr0F0zb8NC8IUgT6eB3+OyDP7siyN11o3TLjvVsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YygZ3rtJQXiSflpmmkSgLGz+Bj7po48yMBq5ZRlNFZQqLxkKBos
	FX0rY1Wl8VxJ9IFmKSLPckdKXLZqhWJfFwtVQPoDiTW6GLolm+sZRkBw
X-Gm-Gg: ASbGnctLO6+Wr1u/E98Wm3WFWzNGkaXKAqHUypVG//rUK0dox91IoQLc49vVZQPeDpQ
	wuTN4xPJrMiBIby0VOMEW9Ow8+xvsPgllpOgyZjfmHmrJsrlNZwPOL1mO+dgIC1dpBQfR+8pZ53
	UFM60zIh4ruXcbTOcYE3LHU4WOfUi6PYecU2HFV1NiAiwgKxQcy/cY5qO/8ql5mqA/FX9isJ0Dn
	EKNiecSUi6Qimri3Dke69jXutyp0HJm63/7+cvWeQcq5xT6MQ0VHFB6iowA3L+gFhBrcaEwErty
	2Qr+J7HlqKCztcEJD465h5xd1TKcNe/Tbbk5LsskYAamnrpr9dUySkxaFLMljx0RbIGHKJ2QpNz
	/zqsHDZ4KuEyWe/EqSilv50MqZ6jBIZ/06xzr/vAnww==
X-Google-Smtp-Source: AGHT+IHVxqOeAZ5vJebxapDm+JIQblEv2y1cOjkdFHVkA2ZjKIXq2d5/qbibRMBMr5Fo/HoHy7NzYA==
X-Received: by 2002:a05:620a:110f:b0:7e2:769a:c858 with SMTP id af79cd13be357-7e62a132d9bmr113633885a.3.1753224634142;
        Tue, 22 Jul 2025 15:50:34 -0700 (PDT)
Received: from Gentoo.localdomain ([37.19.198.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c44cdesm571413585a.61.2025.07.22.15.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:50:33 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	unixbhaskar@gmail.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools:perf:tests:shell:common This file was missing the shebang line, so added it
Date: Wed, 23 Jul 2025 04:17:15 +0530
Message-ID: <20250722224810.30252-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file was missing a shebang line, so added it.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/perf/tests/shell/common/patterns.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/common/patterns.sh b/tools/perf/tests/shell/common/patterns.sh
index 21dab25c7b7f..807c1bc7bb52 100644
--- a/tools/perf/tests/shell/common/patterns.sh
+++ b/tools/perf/tests/shell/common/patterns.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # SPDX-License-Identifier: GPL-2.0

 export RE_NUMBER="[0-9\.]+"
--
2.49.1

