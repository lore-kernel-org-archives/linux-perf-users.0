Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D71D7E41;
	Sun, 20 Jul 2025 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753001959; cv=none; b=D+zUUcCHMtCKtG3wUk2WWiMTq6Vz+aUMPwu/690PFZO79h8VNrLJQ5ojopzOH0XtaR6NYZWYB1BeRRgFS6Llfe5cTx90u5nLNgeFzF8biIIX6gJrp4nFV3aUb1DHLlxjQJj0LA3/mI3LcW+ErNRrEpKf1mhCwDSn36bMPhPB27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753001959; c=relaxed/simple;
	bh=M0bOc/j6BpQq1mxDARi3426daG4a2ThIlUeEdFrkC8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WqtuE3/nSIm8qtyo2V0IZPyKQaBQiCa0QS9CzylYDBZca3c1btOJVgJNax36WSL4U6OCieTRORWzcaGj0JRDdOKXuafbd+v85Sr/YCe/alEpWfWSpRRB7MUTjGAd2vQwyjSNP0JPVlaLN9j7o/iafLy9cWqezFYo1SivtXANS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci2lDV9A; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci2lDV9A"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2353a2bc210so30132915ad.2;
        Sun, 20 Jul 2025 01:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753001957; x=1753606757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sA2xO3FkcLO8DaNf6KbVUYpnZ2ST2OFsE3flTGRsM5U=;
        b=Ci2lDV9AFsWC9CVpMI7DG7TZeUEGhN1LA/jDZg5I3LMINDAaP7QCMDStZnEIL2Qf5D
         2PchmzxOPThM3ET5+rjheytW0k1vK0TuvEKSVkCyWIpf4VuxEmPO/Ww2Rra0f+6PMSP8
         K968LlPWSYTMyNoZPaIHkwJeddpop94DElMmIM+C80NuC3P83ciTGaYWxafqEVrrEB1/
         vRPHJExac11t+aF8JCaBGWFWV0NCTsgkVuiA6AwKOVAdYj+Matiioci2cfVxW++Snflp
         DWu2hjWm/L3glmM7DqT9Rcx1pnW28vIys94Ueqj5VgXSsv6JXfthRaBnzHlTT/5mcalh
         CE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753001957; x=1753606757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sA2xO3FkcLO8DaNf6KbVUYpnZ2ST2OFsE3flTGRsM5U=;
        b=WPvPEsECL6bYfRUNFnOn04597O27m1+FpxGmbkbYO4u7vHFyo6hqhUmhhjKOcolqTa
         pIpnB6ccJPJC3EOxDICQxJ7Tp73qHN8lV8vwHcw9aCAyNP/xTY2RZQckBTuAA2sOA/B1
         s2/iIxYgw0re5Q7u9/CNRK9EutabV+SClgq0liR4PH/U3Xj4HCpsVH/bRzebARHSDTKg
         LLnaVoeI3ZqbTRag64JNNL6Nq9ACQWqoMXGubIsFwNgYFnQ/6HCDywGQJz+CQcB464ug
         RR8a/SOqATdIOw09n7SUB9D9D2JlLLH7UEa4o92h2IL3c4DqfV/l+n3ILFSER82e4+RV
         3LCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZPp4oWAPWOn/mvS6gGG/zyYn5Pcpegul1ahRNS7azO92Jn71yyPwjLPlQJGGCsh6VN4vi+1dC80EDUIc=@vger.kernel.org, AJvYcCWnfHeKTUnRa2vgHHYN9l8zYQUAyuaTXGfgR6OgDdq4NC1ELm4c2x10XoB0w41kHPgSkdgcZ5jhATs3b8crv6wQIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAUlTUrrJXxcsH0Xk5EscUnH1sFNn0OTi4toHFlYaYs50XHbW
	6D/Mlqyn9e1R/27fTmo/CttA13QIpknTQY2x+debVbCX0bsUu8G9fXhl
X-Gm-Gg: ASbGncvux/jpD/F+ZuVKdWzUydr8ucdjvQ54nJsweuDKpuZOyw7GTJoV8/LliP4h+z/
	DTx6xvqHrAZnxpIP+awLIRbjvcEQObK40WFeJ8BDQx2TfDdQcdrBRf/swlVIYaK1Tp0v2TJzy/S
	WBZvie/0cGDJddmTNgCrJ8MwcWA5FU15k+q0sRkkdygwLAEnAmLmKrys64XLSv0lYZJrIuqiwel
	reLSCurRIq1SlEToDuHlhZnK6BHbe7EymN6A0AGJ2OsC1MRlulT++/ku81WZGkFORIKieh8OI21
	Q14YaFhRbwqdWjv8UJbm/JL4sfEvOyTtVyebN5w4bPmv1HN5/Qx1tWvpO17iwQO5TwATV1R0QpY
	Xfj/JjT2p5pHQbFoNEtUwtLNlVXwy
X-Google-Smtp-Source: AGHT+IGQHzsV8pz3bryJ251pP0Aj07yt9omnf6sYGxLQAsHu/WuzEoDKSfTb4TUE2i34Lg2ek1yOHg==
X-Received: by 2002:a17:902:d490:b0:234:c2e7:a0e4 with SMTP id d9443c01a7336-23e25684a67mr227746295ad.3.1753001956941;
        Sun, 20 Jul 2025 01:59:16 -0700 (PDT)
Received: from archlinux ([205.254.163.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6f003esm39063405ad.221.2025.07.20.01.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 01:59:16 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
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
	linux-perf-users@vger.kernel.org
Cc: sesse@google.com,
	charlie@rivosinc.com,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] perf tests: Fix lib path detection for non-x86 architectures
Date: Sun, 20 Jul 2025 14:29:05 +0530
Message-ID: <20250720085905.192652-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing Makefile logic for determining library paths was
hardcoded for x86 architectures, causing incorrect behavior
on other platforms. This patch implements a portable solution
using system bit detection.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/perf/tests/make | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 0ee94caf9ec1..565522408f99 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -53,9 +53,12 @@ endif
 
 include $(srctree)/tools/scripts/Makefile.arch
 
-# FIXME looks like x86 is the only arch running tests ;-)
-# we need some IS_(32/64) flag to make this generic
-ifeq ($(ARCH)$(IS_64_BIT), x861)
+BITS := $(shell getconf LONG_BIT)
+IS_64_BIT ?= 1
+ifeq ($(BITS), 32)
+IS_64_BIT = 0
+endif
+ifeq ($(IS_64_BIT), 1)
 lib = lib64
 else
 lib = lib
-- 
2.50.1

