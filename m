Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1B21CC48;
	Wed, 18 Jun 2025 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750283934; cv=none; b=nf5kcdXG5vR9Otr01CPAmjqg58IpFcs9VSGNMWNCEMmw/dBAJmJD+3E1+7wZrREjSzUNVk4o/c3hOCE8qyUaWov5brqG+Ehd7jt51sP2j93a7qKVvKs7IkKnKqurjltlVSMJBmqPFdbFOsnjUICVfq7p/kMnzDxgQxZ0xhwDEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750283934; c=relaxed/simple;
	bh=emxcW+J3k7PRwUe3FJjTkLwIkxieiTo6Is+dsiB/uDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ey6CXxYS5d+HDNUjQ6Yi/XOtvPXoQ7U5ahEs0T8bTe6cng2hO0cieyvJkhUFrHr7ecRHMTMBZOGSw3qxOs5JnqKQcpz1d3ejZ3PRTRMZd12iBTNM/EJzHePD+1VXwjA5zPTCbsQhNGZb++m55kLrrmufV9Rf4vpTN6tdZO8r6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2El75+2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2El75+2"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4f379662cso143459f8f.0;
        Wed, 18 Jun 2025 14:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750283931; x=1750888731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fzsYxTqs35Shcp//MxplQjWLBOX/EFlETm5Fov2W324=;
        b=K2El75+2MGcwdRHk9Be7BBgcHiDBioV9+PllLpttx0JE+UruA/Z49Ph7NK7gqWJJmy
         bOfDvsLI3eB1VSziCMyB5AMgnBjiRHsle2uy2LN4mmsd8lX7SwRZHeqDONv3hUZpNkZY
         X6U4wLWumKge+9qO+BPdW15KDmaqzOFgnsNtrQnMNLxRdDDw7QmhvERh/Zc1cINE6Ako
         oYMtaIfSdwQQVFLlzoK6HpHtFeKU5fSKt2YK3aEhTWSCnDcs4+JVNKv0O3axImG6Twem
         NcuaaWseWsY6q2Oddba0MNfrBhSQvEfB3iYF7+opJfBXleFPEVuM0cg377q2M4XSjahn
         LM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750283931; x=1750888731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzsYxTqs35Shcp//MxplQjWLBOX/EFlETm5Fov2W324=;
        b=KJVs0hDUg8ElVw9WArSpeBxDn8T/2eDTTjYMjot80odxoUPskgwyPF2XlIlXygQu/9
         nRG5DQtmbvrS4NKTfhNs6aCUdexYO/jfiQqCa1Q++z8tQc4kyBaCgOFOdYDj0sFxd4dM
         ZmzLryTr5+RPRqKbQhsTTu4CMU5wqxnGHI1iYa+5QYqu0LPIl0rc3zyiKT++VSDhSRXf
         oR09xUIiVRjzSUnLPZ9EwKYfnp5bXgQYI6pAn5UXfNPdqSObcDnqhsdJIQfKBT4Ypx9i
         TwiGArzEk/dH2e53hIM3gWyMfmeUbSPKnaEak84oT1HtM1BRgFuJFY0V1Qlm6a9a/zU2
         TqyA==
X-Forwarded-Encrypted: i=1; AJvYcCVn8M0bgx4fJI35KGBG4Zkz+mC0IYfyu1BkdjGj2f2hDVTyaqwXiTcy73Z/U+jH4n4FmugEXC4VSZ+E8/LmkjZTYQ==@vger.kernel.org, AJvYcCW4Fg1Qb4ok9Gzb0ikVevY3f6mIPE9E+XRTeIiSVD6BEwThhImlxw8N2D+Q6xZFkT4fQ3eGZtu8DOrMhDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwoQ4cmtfl9zjm5hXuwx4Vw0I/zHi4WbNzKgzLy+Pay+bw0X9c
	iRHZnQGekPe16TTJsD6TeL4b8X+e8OX9waxmwGbcsdNCw80RHzmBLgL4
X-Gm-Gg: ASbGncsHcQ/9nT2QVXcNCBOGYaeiqhKWqhDJKw1NA8TZDwDWiWfszitPsstDU87vqEK
	yBQTmJRzuBbAKS9bjSka/34GcgiOCGKPMpdZg7ytKJsfh5lT0XEJNq355B5le0pYl+XaFIsOQoQ
	EfwVvAMcFSe6iym4oGLCFh4hv5EhZ7LscbOF/KxioWuWwUtmAGSF8h7wr268VFmdB1Z1HeoX6TS
	2SGi3efn2XKQraz0YYTSjWmubo2YkvAU96eQbl6YAXLKnkliaCsPLMOitFrmOkWw8ZiFPrOppkG
	7YPbR8uaAnwQi8Pv+8p+43xlweEB8ufg0TfF0GMD+Q3H616AQ1oYGsBCrxX8e4wOrDA=
X-Google-Smtp-Source: AGHT+IFh630CQwG00UQgU8iORz2lPAw4P3TWRdrp+AbuHSeVvsA9KtSNfKQv2p2Fpkzdqnc/nk0CvQ==
X-Received: by 2002:a05:6000:310d:b0:3a4:e7b7:3851 with SMTP id ffacd0b85a97d-3a572e69d13mr16541947f8f.58.1750283930755;
        Wed, 18 Jun 2025 14:58:50 -0700 (PDT)
Received: from archlinux ([102.89.69.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97a8f2sm8817765e9.5.2025.06.18.14.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 14:58:50 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] perf/x86: Replace strncpy() with memcpy() for vendor string
Date: Thu, 19 Jun 2025 03:28:43 +0530
Message-ID: <20250618215843.109941-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strncpy() is unsafe for fixed-size binary data as
it may not NUL-terminate and is deprecated for such
usage. Since we're copying raw CPUID register values,
memcpy() is the correct and safe choice.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 tools/perf/arch/x86/util/header.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index 412977f8aa83..43ba55627817 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -16,9 +16,9 @@ void get_cpuid_0(char *vendor, unsigned int *lvl)
 	unsigned int b, c, d;
 
 	cpuid(0, 0, lvl, &b, &c, &d);
-	strncpy(&vendor[0], (char *)(&b), 4);
-	strncpy(&vendor[4], (char *)(&d), 4);
-	strncpy(&vendor[8], (char *)(&c), 4);
+	memcpy(&vendor[0], (char *)(&b), 4);
+	memcpy(&vendor[4], (char *)(&d), 4);
+	memcpy(&vendor[8], (char *)(&c), 4);
 	vendor[12] = '\0';
 }
 
-- 
2.49.0

