Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4AE1591E8;
	Wed, 15 May 2024 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802875; cv=none; b=R1vME3H+Dc6jL4FOEpdiggn10XYayEPJxtbu9C+NEXmxugsLcea16S3yzLpjbA6BCBk/10m6UyPQN+BDwOJvbpZCTBi2fEvV0lCyBafVrKO326Vg+t3Q6vq/2mWVQuXLPLgQDO38AL54FywytSINSYJxYQRU2C+Q1Ap3Do0dkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802875; c=relaxed/simple;
	bh=ZxHueuBUvbkaIfOL8cbJariIGa/XEf4IGU635nf5Hv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KiE5zukjr2ajL2bJrZepK63Qr1GOgb+MiRbQcVY4CukvbY+4LtmA+DrvfdgjuD8+8nbM5Yo59+O4S/JhtOf6L1IaYnIlPT1yjfc2qpV6ggHmcuBBNF5IZqtp6zjWPtif3YclqmUsGfuRdO+OTFn7nbG8XXokotXL/SOKPBTimIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqNFkTUR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqNFkTUR"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-620e30d8f37so6056794a12.2;
        Wed, 15 May 2024 12:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715802874; x=1716407674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RfKWWn/JGItqqcA1bmKyuTjmynRG0bM0MWZNOKmaAck=;
        b=YqNFkTUR8hMEfpZs89PajETPz8JL61RGSTF1O/TNQEDUBL6UZo677YhmkSiDdKReO1
         Lox8Xk7SF5QmyrRdS/oM0g8g3Dn9NQaGOkqWu+k/tl5DON/osX1AZGhFzkuK34GufSGt
         JU6riDvJAy+o2aOOiFrg5FwtrqaypdUBMA55Qj7wrWmVmRVXUC6L/tuBZV5j76ci/pr/
         A7xyivW0gKZyygwhilCzEtbvZwO5zWwpySdQw9bqjZAaw3LfPRgdzkU0Ly7dZkn2lvKo
         0bhCHHBK8HlhrpYG+zXy4sIQemVxlBNR9WsfjDnpHuO9fDxKClPbquCsmYYXYsfZlD3I
         AJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715802874; x=1716407674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfKWWn/JGItqqcA1bmKyuTjmynRG0bM0MWZNOKmaAck=;
        b=VChA2ulOh5IXlbVO3ijPDqNJNBpBOCZFRHE9HjFPcBg9FPOdV7oFcRnuv67b4nvwSm
         b38lsLF46tYFsu1mJ+U9DOtTocSdjeEnjdNqSGtudbl+3CRoWi7d/oj8FocJQjE4RoxI
         CECUy1Ew8WdvReMV/oQBZcQgjt33/XdCYI7cDAf7Ha2QifC/xIfp6mILoS/hAs06Qg0D
         rBgB/Uv7J9w+yWUNv70qhW8y/zgAixSO5Mpc424KHeob+ArcZom5B/CD+VbbDBhHfAK9
         O6uHkxPmU+96FqKAFUCo3udy35SblmYAx8/l4OtdLmLrdEziJx39VyW1ptgdn7eOtptW
         KsVg==
X-Forwarded-Encrypted: i=1; AJvYcCXRMlAqyI/FliNHL7HM+S37ivgTz0c8+TYtcEExB/cSCPjkWj3HKMuEM00LP450eKXvZ+u5J1Qoz1XzZ2Gxuc00rt7BvxoNjWyV83BQ0J1l7Z0jo7VGFwea+1TIvAmTM6gB8TqHqN7pXcULosBowA==
X-Gm-Message-State: AOJu0YxYcwEFbsQf8fCt6I47yAOzj26/+FzLuUG5P+q0X8Mc9MEw+7Y2
	hICfSjrNMFBPe1QDp8fPKkzygREOABjSgztc5fN6ElYA8nruCutzxeJyiYxtOA0=
X-Google-Smtp-Source: AGHT+IHczPXNwcNNqQxQpOqxUoxaqdxO050KAOLO0DVUXn4f4P3iBDMHW13N1j48C+/94Xe0hEtJeA==
X-Received: by 2002:a17:90b:1c05:b0:2b6:2068:cce4 with SMTP id 98e67ed59e1d1-2b6ccd8fc8amr14889004a91.46.1715802873721;
        Wed, 15 May 2024 12:54:33 -0700 (PDT)
Received: from paran-QEMU-Virtual-Machine.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67158c30bsm12041998a91.39.2024.05.15.12.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 12:54:33 -0700 (PDT)
From: yskelg@gmail.com
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH] buitin-kvm: Update cmd_kvm() to check perf_host value
Date: Thu, 16 May 2024 04:52:53 +0900
Message-Id: <20240515195252.75909-1-yskelg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

According to perf-kvm.txt, the default operation is --guest, meaning
perf_host should be set to false and perf_guest to true. Currently,
the incorrect usage of --no-host and --no-guest still results in
the default --guest operation.

This patch updates the usage messages to include the --no-guest option
for those who only want host data, as well as the --no-host and
--no-guest case.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 tools/perf/builtin-kvm.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 71165036e4ca..654a07658cdd 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2129,7 +2129,7 @@ int cmd_kvm(int argc, const char **argv)
 		OPT_BOOLEAN(0, "guest", &perf_guest,
 			    "Collect guest os data"),
 		OPT_BOOLEAN(0, "host", &perf_host,
-			    "Collect host os data"),
+			   "Collect host os data. Host only with --host --no-guest"),
 		OPT_STRING(0, "guestmount", &symbol_conf.guestmount, "directory",
 			   "guest mount directory under which every guest os"
 			   " instance has a subdir"),
@@ -2150,16 +2150,23 @@ int cmd_kvm(int argc, const char **argv)
 						"buildid-list", "stat", NULL };
 	const char *kvm_usage[] = { NULL, NULL };
 
-	perf_host  = 0;
-	perf_guest = 1;
+	/*
+	 * tools/perf/Documentation/perf-kvm.txt
+	 *
+	 *    Default('')         ->  perf.data.guest
+	 *    --host              ->  perf.data.kvm
+	 *    --guest             ->  perf.data.guest
+	 *    --host --guest      ->  perf.data.kvm
+	 *    --host --no-guest   ->  perf.data.host
+	 */
+	perf_host = false;
+	perf_guest = true;
 
 	argc = parse_options_subcommand(argc, argv, kvm_options, kvm_subcommands, kvm_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
-	if (!argc)
+	if (!argc || (!perf_host && !perf_guest))
 		usage_with_options(kvm_usage, kvm_options);
 
-	if (!perf_host)
-		perf_guest = 1;
 
 	if (!file_name) {
 		file_name = get_filename_for_perf_kvm();
-- 
2.34.1

