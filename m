Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686BC46426;
	Wed, 19 Jun 2024 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829762; cv=none; b=qxJF//0RQuoHD5Dn5uNp+I+FKclWHaup1XrIrIHamZP3cQX+FS/i85P0FTMJEQOF543ucv1u04TL/V0s/raO4Mh0IWyiRnrTI/TT0QztIRAwPGHopDQPQUyRy/wJ0iyxNH/z/NUQ5Iuhv2DW65AecnnO52LoE8Xh41fLknJdPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829762; c=relaxed/simple;
	bh=D9CKnHm8Mga/iQVySnp3DBkc8z1KAq2U2xMIajbreb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NFx6ofKXB5nUXKmzWyLpSkuyvDuvvcUPLMV50WqvyxqLVjtLdMKnGok3zjhaQzrxcXgCbYk7CuAYRLuB8oCyBGz54FPQGue3W48x1eD2XsOufYKO+JbQ8kRiw9kbLWuLT4w70ahyBE1vSHgCTjA6aUfQXiTr62szmloBotoo2FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moXwfYrW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moXwfYrW"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f6da06ba24so1271945ad.2;
        Wed, 19 Jun 2024 13:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718829760; x=1719434560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxz4VqLQLmREYFYF+b7YOv+fmdIW8c4422sFxBtw+fU=;
        b=moXwfYrW56xNAJ8K7IWXkVKwfS27jeJACa3Su/1tvWRSUNMM9ocpqppwzWYoS29CUw
         o+LM01MVydhDyzMW6SNuLtW7fpiSZaUWATrFpjn/C5a0CdrNkrnkwRccNlQCjTwlCJTL
         aNKIzVJtfADPafg4TnasQr2jTFeNVDjhCCzPrhR8iL0EMBpvjQgWhryEH0gdZdI3C0zP
         qg6vvgZLc8B5hIeU0m96f6HbRkpO+AIpVW1R+MrCOKDd3WPgt0rl1pb67dQrKLchMWxx
         qOzitBwsC7WibgBCLqpIYtFF6qDu6mjYFFw66AaiXEkv7JlyeLT2/59+zAaeHEDaNIwd
         iDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718829760; x=1719434560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uxz4VqLQLmREYFYF+b7YOv+fmdIW8c4422sFxBtw+fU=;
        b=l7plZvT3/mpmW7bCwMMBk0SZ0o0kZZJA5HBW8fJdeyAUOqooO4Nl6VgDFvIZIlLs7F
         HgCc79Ztyjx/aPbSApJ/DXUg8enkiQbvbRGEk9cBNG/p1Ae6kcI9It4mw2xDtZD8omGs
         cLDcUzNV9SzFAPHYu6b/QrzCXHU2xmJbxcTkNdHzmj9cF3HpjEV+lf4W48V0DLvoSOjj
         s2HAqjswx+y7p6L1R2/1ZU5wceDq97wjihE13ZJzyo15GQbojk/aCtjN17QVa5vEya1n
         o9LG3IHFLg1Fhm0DMQ6CW9+y5Rw1vqcPxXJy7tgL7n28mV/vPesF6fgn0S6I6rIzoM/L
         sTrg==
X-Forwarded-Encrypted: i=1; AJvYcCUTP5RdbR1SkrGRYl0zNwb3WDiUAZ4fycKpWJ1z2mnqfVQhBXQvm/ZkeW4VccubumuyDeDhMkMajVCDn+bGw2PUdTGUfKbcJWy4FVeX03T0XaCI3ofPMS6R994jlW+iVOUiGDZ6OAi3H/N6zloHdQ==
X-Gm-Message-State: AOJu0YwSKQUbP/xCXrZsA7VR+tWJvZfq/nKzRUT6hHNUn5Q/t+NuDxm1
	ObAXPOc7KFcOH8oB5IG8Y8n9NKMVIlfrTbrUXgzBgsORxcQpFvBd
X-Google-Smtp-Source: AGHT+IFMCYWnUzQ20k9uHazgNQHQLq2exNGlYO6Xg7klSyxBlwOQ+GWc+KL+7u1jhI6ix7gkhzEtow==
X-Received: by 2002:a17:903:41d0:b0:1f7:4021:5092 with SMTP id d9443c01a7336-1f9aa413407mr41236675ad.41.1718829760502;
        Wed, 19 Jun 2024 13:42:40 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55d7dsm121992165ad.14.2024.06.19.13.42.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Jun 2024 13:42:40 -0700 (PDT)
From: yskelg@gmail.com
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: kan.liang@linux.intel.com,
	Yang Jihong <yangjihong1@huawei.com>,
	Ze Gao <zegao2021@gmail.com>,
	Leo Yan <leo.yan@linux.dev>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH] perf unwind-libunwind: Add malloc() failure handling
Date: Thu, 20 Jun 2024 05:42:12 +0900
Message-ID: <20240619204211.6438-2-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

Add malloc() failure handling in unread_unwind_spec_debug_frame().
This make caller find_proc_info() works well when the allocation failure.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 tools/perf/util/unwind-libunwind-local.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index cde267ea3e99..a424eae6d308 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -390,6 +390,11 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 			char *debuglink = malloc(PATH_MAX);
 			int ret = 0;
 
+			if (debuglink == NULL) {
+				pr_err("unwind: Can't read unwind spec debug frame.\n");
+				return -ENOMEM;
+			}
+
 			ret = dso__read_binary_type_filename(
 				dso, DSO_BINARY_TYPE__DEBUGLINK,
 				machine->root_dir, debuglink, PATH_MAX);
-- 
2.45.2

