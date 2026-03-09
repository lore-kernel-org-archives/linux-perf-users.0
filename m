Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D4D3F9FB
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773018036; cv=none; b=mnjqFbrtZOuwRVfaYFCcruKfVZEDPD++Nf2zVF21f0WcbNJLcRUKcsxAel42kpf721ZZnC3QnYfsZUNH1yLmvJH9klMXdpPZq2EgdhzBooeI26a9X+oDZN34VRlEehWElh025D0nVP5sZAkqAnJsiqYzueAJ9lZe10Wl1gmRUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773018036; c=relaxed/simple;
	bh=3VIwPvEn9nxnA8AoCor8wMrtyb5xyOpGHXiaEf6OlmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5Br3ZJ2PAjwf3gTM7Q3+KzP3eTd44G8NV3hWRLh69tWgLLUfSRN9vJauAvdVL4DKLo/u6NeIuyS+d73IAK7KSIS4h1mda9FOmKreqXhZOLZCq4Ykt24cqONkPe/5gWwah6U6Zk/HKn+X/9W6hu4Qh0m8lGdXh9Y4zjijhEyluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs5zkEGu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs5zkEGu"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-829865a8471so3839098b3a.3
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Mar 2026 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773018035; x=1773622835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuMq4xsGI5hOeMCXdX2jtMmL9otI4kV08hHjKDYLLy0=;
        b=fs5zkEGuRZab9m/oHLH1p4GRAlSwIV/TuwQlN+aWFcnr46ZdEh1qNDcafgoDN6e9iN
         cI1i2hsM9Bp3z74fjPpUdwbYQB3NBLf0jLK0vGyIuAxVD56UVFanw23f+kSDTSDkwti/
         4XvyGrwg76OB/DcZ2B4EUX9/ypnq9/HVHkFeE3lqFkxJ5VsjfEcr2SIyj8Fw1PwkovnN
         rpZ3WBGddCNU8bBb5F6NpJ36DnHJlT3Jva67Zbkvl4OLHcjTl9p/HwjHAN7IG2+BDEJu
         QhdA1sShc1V+G0wT6JRFlEmbSopfsLyCbXb/kR4kX4WESutRUv5dtgN20mK/V5W8hbjV
         V+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773018035; x=1773622835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OuMq4xsGI5hOeMCXdX2jtMmL9otI4kV08hHjKDYLLy0=;
        b=DaL3FNwJoMeh2oV7RAOTSZjJLbMYrHejIN/i4IDK8X/k1SFXlBw9If0An1pAEnBI5K
         nnF4waFtW55o1HqD3Vlp6JwqYpF/1t9vT+8iFJz8AMoDaUQTrBrxlqZpiAEvrO5OeAFL
         0C+aNmuwWNkQQUI0gfH9bczEPJ0MVwcsk/XKhuGLLSjtVh5/z1iMggJ18fIslpLUVnVz
         +6hMmbluJdhSYf6Zh91+i8XpPdP45l5973bsMmejO7jx4HYHKAYYPncorntG1YV5z1uC
         UupXDxaWmZ4Mr5ehx8pQUsI4Zrp7CtUJNxOYKs3tfjWHItiHIT41mb8GYc5SkifF/1bl
         RYOg==
X-Gm-Message-State: AOJu0YxcsD+m2I+VOVFytknSQMwr6yWJnVPSmb64KSFY14H2GwOKU0tD
	gNnkzEYPJ+uMa3Klx1hu123NOirA/wLaXYjMk3WfV9Ozm4icUGWOcCvy
X-Gm-Gg: ATEYQzz+PBmk6b8KbnJp8zwohL0VaiQIe780YWfhlxTzrLZD2JVpMXER48dO8eiPHJ4
	NWZx5LvebIzqWnHqIUJQrDUQZOVvmFmOWpFHVbq2IBkiTHb3v+OtDt8NAnzIPVtjzQTuid/mViT
	eqvuzRDsxpwv0HlM46I2I37KJjTyrMD9TFZKlTzjnTrq2uM0Ycg0r0pqoljB/PqccYI2pcbYO5z
	aTElC6yRPz0aVvj1ilOZdEXtStSADrkO2Ek3nXIUawrhMDbyZJQsN6piicToM8snpja+aohg333
	4ufqOe7nTUkDSXOr9d6vEqaUb4jhcSmlm87l+4dt8UawLNNFkJCf8bvoFXGDQrwvsqqC9YMdnoV
	RdLY0h8Oq70XcPnW5twh0UBg5Pqas39mj8CMOPQ5ySOTwaP2PIH0cmu+BCkT4C7ren5VAeEOJgn
	c1t7VG5q8Hbz824AFIcKwlkGEOM//SrBfjQJFxjQ==
X-Received: by 2002:a05:6a00:c95:b0:823:edd:20b9 with SMTP id d2e1a72fcca58-829a2fa9676mr8854116b3a.61.1773018034754;
        Sun, 08 Mar 2026 18:00:34 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:35e4:35af:8d0d:ad4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4635d62sm8468794b3a.5.2026.03.08.18.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:00:34 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v2 2/6] mm/damon/core: introduce struct damon_access_report
Date: Mon,  9 Mar 2026 10:00:05 +0900
Message-ID: <20260309010009.11639-3-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309010009.11639-1-akinobu.mita@gmail.com>
References: <20260309010009.11639-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct damon_access_report is borrowed from SeongJae Park's
DAMON extension project [1].

[1] https://lore.kernel.org/linux-mm/20251208062943.68824-6-sj@kernel.org/T/
---
 include/linux/damon.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 49d2983af4a8..5f2870ae02ba 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -110,6 +110,30 @@ struct damon_target {
 	bool obsolete;
 };
 
+/**
+ * struct damon_access_report - Represent single acces report information.
+ * @paddr:		Start physical address of the accessed address range.
+ * @vaddr:		Start virtual address of the accessed address range.
+ * @size:		The size of the accessed address range.
+ * @cpu:		The id of the CPU that made the access.
+ * @tid:		The task id of the task that made the access.
+ * @is_write:		Whether the access is write.
+ *
+ * Any DAMON API callers that notified access events can report the information
+ * to DAMON using damon_report_access().  This struct contains the reporting
+ * infomration.  Refer to damon_report_access() for more details.
+ */
+struct damon_access_report {
+	unsigned long paddr;
+	unsigned long vaddr;
+	unsigned long size;
+	unsigned int cpu;
+	pid_t tid;
+	bool is_write;
+/* private: */
+	unsigned long report_jiffies;	/* when this report is made */
+};
+
 /**
  * enum damos_action - Represents an action of a Data Access Monitoring-based
  * Operation Scheme.
-- 
2.43.0

