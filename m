Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2128688E
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Nov 2025 04:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763612193; cv=none; b=iwE+Ro51izg12Z0A6b87uGLm5g2kkozhQWy0Bg3OHRvBPUeM/IMRao+yypzGzTC6uGroBIE3CUnQnqqRmVBjanVFex7VaTfeMR/RCCVNZXCJ93agvf9iMroZdvYkKgGj1qlbso1aD+jUzjyKH/VAb0NKyChF2nrm2EiUVcZLWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763612193; c=relaxed/simple;
	bh=pkOpsCdmeW3ExT8MjqMMgG9gs9dCzYhTub4Hn8jfayA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CBezKEyw16FL4CKrQ43jtXRzRIDbir8bVq7x3qksgRXc5ejbVL9H1lRVod6+R/O8k7O5mvT5t30M5X6ogNRmryrIvscWHbzqoNvnR8Pb7e5C9zfB6LAAXIH2GoNfPMzB9JCzrA8lPs684lfwXNMuWxlT/Uzx7w2kEc3kOJWGaA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNgEqiAS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNgEqiAS"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b472842981fso57594466b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 20:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763612189; x=1764216989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ke0jCxxr1nY0cEvcerSphkfz/Tc2+RuiCKy89HRuYRM=;
        b=CNgEqiASyNp37ez2s3IWU4Zqn/w7NIGzAs4B25myBPM6TaGMneAZNTZt73THAWYKmi
         n6CW4TtZW3yGchpTHSlrr38TQLPvNUtt9YKkfa6YwYdP6zIYHjGL1OV/AzrqRJPdPpqz
         62wLNUZ00vsy9ILGOiaNOt+XzdiPx2qCJZmPAg0ykHFB+KN/2fUjzO9UoDnUw0UTFNnZ
         M/eOFqnmuIb2JJWpRSAZekVRJ1wcv4d8ZOGasj11rdC26yVOtwmnHyAQLmzdWooZiMtU
         vc50KoBQlPAHz5lA6hRsydI7iIuMQFiyWKBvW8gnaG5L/AMOqTRk53zVrkkpUxwhlV3F
         Mtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763612189; x=1764216989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ke0jCxxr1nY0cEvcerSphkfz/Tc2+RuiCKy89HRuYRM=;
        b=Bb3ICpLidNBiBwCGF2msqNxfBjq6Q/kZg3mc8SVd1c0HdmJR4ZougpNZtup1MkCUwy
         Ztmvd7M3xzByqNA62ViNBrMmjlES5QtvXQ2fHlhVI1YiD6+lKxDP76p4Jl17mLIVVLFx
         jgyOkyEGyzprShq0+PfbxM88o/PrRnO9ngk9mG3ygyyB6EqpUY4HZNXFhuHBKrjkWLMW
         OidfizLw7EkEG2X/dGe/c2UZ5VM90nLcVNbhqLWwKq3C7aHeYNSGUU21YOXPG2jyNeQn
         /Jyn7hewZnABD44navFoH4dE1yShdz+XEOk/Rtz7mYTBfKHiela6awde4hhP7cW3ZtCo
         hWJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIbsKK+IciOp56yDIC5gGE5C/W1dD7tESujpiiBxpGZHJPY6fg7sKdIToel9jyvUCNKBQNvPuigV+IOPJ1TK9b@vger.kernel.org
X-Gm-Message-State: AOJu0YyquA4vxEgt5Q2hVbP8SoxgP85lJ6Nvxp/Yp8UTrnmjuxiVyEtV
	3bOf1VfThhlk45j8AiDqUqZ+ROxve9XA9scqqAUmxUtcpS9k88K3npnl
X-Gm-Gg: ASbGncvr7tUjK0ObWiS4JjAWMW4W0sVCB9JXd8RrF+XFXXSF2+/UAT6s+IRlRj34M6W
	jdD0WLb0R6ND3PYHUO3y+bv7Bxr66NoLrUzkSXPdSrwhpr2pGc8HsTW4qtVLU/TRh404JeLu6Bt
	/LpAFEZdC+5VEYWuf+85MlSYUakRA+/20V1X/8pM2kUd7HTKwEEL6xhiblEC5NwLB/Oqy1Okleg
	EEKPUaCvGBBYY6CzWkl+nbu21/dR8W86jLjvmirAPtLzpCiMEKy5iKGXltoXavDEbMto9xT5or/
	noQADTjYRQUQktdOpC3QUgsNmA251XssnNx9d4pegDjny7bZNqB++4Y0Ay2UQbEckktmfnaM6nL
	TWfi1diok9yH/YAU96dAo7ujVUSaby7xCI4QHp9VVo5FUbTMrmNMwUt7HxvUg6O9UsihUx1x5s7
	xzci/0tzoKn79LxxpjwVc6TftrXx7qlzSvI25sdI0N7RIBMZUEhaZ7jWYWvsY1xLZkR/abbMUI1
	+CRdA==
X-Google-Smtp-Source: AGHT+IGqn5oXr/h3c2O6rTOyQf01J2AYNnPmwNsh9JRVrcfyj3qioQ6SqB2JsYWuuxozcP7S9Ahx+w==
X-Received: by 2002:a17:907:96a7:b0:b6d:6d66:e8e9 with SMTP id a640c23a62f3a-b7654fcfd37mr150210766b.61.1763612189064;
        Wed, 19 Nov 2025 20:16:29 -0800 (PST)
Received: from ubuntu-2204.speedport.ip (p5de55abc.dip0.t-ipconnect.de. [93.229.90.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654ce15e7sm111441966b.8.2025.11.19.20.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 20:16:27 -0800 (PST)
From: Hrishikesh Suresh <hrishikesh123s@gmail.com>
To: acme@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hrishikesh Suresh <hrishikesh123s@gmail.com>
Subject: [PATCH] perf: replace strcpy() with strncpy() in util/jitdump.c
Date: Wed, 19 Nov 2025 23:16:10 -0500
Message-Id: <20251120041610.299972-1-hrishikesh123s@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of strcpy() can lead to buffer overflows. Therefore, it has been
replaced with strncpy(). The output file path is provided as a parameter
and might be restricted by command-line by default. But this defensive
patch will prevent any potential overflow, making the code more robust
against future changes in input handling.

Testing:
- ran perf test from tools/perf and did not observe any regression with
  the earlier code

Signed-off-by: Hrishikesh Suresh <hrishikesh123s@gmail.com>
---
 tools/perf/util/jitdump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index b062b1f234b6..496ca2d2bfdb 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -233,7 +233,8 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 	/*
 	 * keep dirname for generating files and mmap records
 	 */
-	strcpy(jd->dir, name);
+	strncpy(jd->dir, name, PATH_MAX);
+	jd->dir[PATH_MAX - 1] = '\0';
 	dirname(jd->dir);
 	free(buf);
 
-- 
2.34.1

