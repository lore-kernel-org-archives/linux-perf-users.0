Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557961A2390
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736318196; cv=none; b=YVLn/lNlcL9S6c83mldN+5+M6pqpyfDIFol04+LgBS0YGGMGNH6GTofNyVhjTYHcwKEpUzK4UsDvSsSu/y/I2eX9DRLAfuu57+bz1OTZ3yIhov9h1rYgA05jrT8E+1A5HxCF8a2wh3XCTo+p+MRxVhFTdIDz5pasl/rftPmSkMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736318196; c=relaxed/simple;
	bh=joR2bfCkiFkIR/cQ3pkhDlcOI5PKPk0dukww3i43dvM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LMvDdZBslAecGNKbQzRb6mqe43IbEVs0dq0PxaJiXS6BbL5EmRIOqqba8QAYMEEJq5FPt+cQKsWQzIO/xdiKJyQDh+oSxqhPg2tsKikwKXHjmPHQak6V7ePWj5ozoXbLKaCMCSw4vyby7iG0wCBOeEPhmGmsw6w+eiRohrBDdvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZMS0qvp; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZMS0qvp"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa67fcbb549so811830666b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 22:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736318193; x=1736922993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FCJ2UMjBJDouTDQGxmyKJvRG0RSKjsidIHUiDgSX0gw=;
        b=eZMS0qvpVzUWsqfYkI7OCMIE8++Os7CFlaMyTJXO2QaFmuOEArvOBjAxlIWCSJGTLV
         TRdhCgsx5m9VCvlixJMYSsuQDnVMJ/jiUZ7e754zOvkx6RYLm6anOQAIZ3SMCvDerO5D
         /D0QxjPrEvA5UHDvV3pu1wjtzqbskI240omkI1A455bTZ+4XBPDw5IKI5wmxtHIbUnz+
         zcsjFxBO5237Ggg4Ulf1CAVPDSEHqcEjMt1a7BbdmU3THX4qiX4/2PCd/OsC8aFGRd5G
         UNxMylgmIjZtByHiq0qlLTBUCK+t1JKfefMBrxLLo2odwwlHZu3vjL+h5dzks5Ua0NUj
         Co4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736318193; x=1736922993;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCJ2UMjBJDouTDQGxmyKJvRG0RSKjsidIHUiDgSX0gw=;
        b=kgIwYjQa6X32xqcL5bNTPuyYJ87h/lkViuJwvUhM9/rI4xgFD+jXcw4B49cl3hQQnr
         th8DC1DHUwxBgqaTpRhZLdRzJUWssg3BHJ14gbHwEJ5ezUZ4Wp/Up72FzqJQx5gggeeX
         4DbuvlUeAMcs1ugKIpfelc3G/0dMTea6GKeufoKvfWGwZej6Z74WXoHiEH2wzWHrPZB0
         7mLInNFnpfDmIuhYa7wXqeYcLqS4FYPxwejqgAIL/zMXw5qc55oV/5ZOlxcM/Or23vPl
         Orh2NErWPD+D1MDO3B+VtJ2N9p4wNM8C7uTTV6JCm/rfVfygI/WU6h+dftHM7//1sXyC
         GKJw==
X-Forwarded-Encrypted: i=1; AJvYcCWDiNDUcseYCkS1wbQQllYkQICDtbCAX/qy98yRJnv7mch7Q03hPXBpyxywOCHjVvCS/tUzBJXPlOs/0K7R9LpH@vger.kernel.org
X-Gm-Message-State: AOJu0YzBp1rjFllBNFZOE8zyHMV19boJXbPtldxa1lWOWakaz8GiSA0k
	5jdq8/zCtnWDLQpTQQNzQCvtIWyDRuyH11mlF+kSoitebOj6FVgFV5rPL/n8pju4D6n6bBUMlys
	5z/s4cg==
X-Google-Smtp-Source: AGHT+IHRwT7vWAR92zilxKJgVwsV/pdHibuzlyvajEZ8eXKrrZwzVdST1OFEj7QWovZrgADh1g06bC36o107
X-Received: from ejcvx5.prod.google.com ([2002:a17:907:a785:b0:aa6:5be3:c0cf])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:d87:b0:aa6:519c:ef9a
 with SMTP id a640c23a62f3a-ab2ab70ac8bmr146023066b.53.1736318192899; Tue, 07
 Jan 2025 22:36:32 -0800 (PST)
Date: Wed,  8 Jan 2025 07:36:23 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108063628.215577-1-dvyukov@google.com>
Subject: [PATCH] perf report: Fix input reload/switch functionality
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently the code checks that there is no "ipc" in the sort order
and add an ipc string. This will always error out on the second pass
after input reload/switch, since the sort order already contains "ipc".
Do the ipc check/fixup only on the first pass.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Fixes: ec6ae74fe8f0 ("perf report: Display average IPC and IPC coverage per symbol")
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/builtin-report.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 048c91960ba91..42d7dfdf07d9b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1721,22 +1721,24 @@ int cmd_report(int argc, const char **argv)
 		symbol_conf.annotate_data_sample = true;
 	}
 
-	if (sort_order && strstr(sort_order, "ipc")) {
-		parse_options_usage(report_usage, options, "s", 1);
-		goto error;
-	}
-
-	if (sort_order && strstr(sort_order, "symbol")) {
-		if (sort__mode == SORT_MODE__BRANCH) {
-			snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
-				 sort_order, "ipc_lbr");
-			report.symbol_ipc = true;
-		} else {
-			snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
-				 sort_order, "ipc_null");
+	if (last_key != K_SWITCH_INPUT_DATA) {
+		if (sort_order && strstr(sort_order, "ipc")) {
+			parse_options_usage(report_usage, options, "s", 1);
+			goto error;
 		}
 
-		sort_order = sort_tmp;
+		if (sort_order && strstr(sort_order, "symbol")) {
+			if (sort__mode == SORT_MODE__BRANCH) {
+				snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
+					 sort_order, "ipc_lbr");
+				report.symbol_ipc = true;
+			} else {
+				snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
+					 sort_order, "ipc_null");
+			}
+
+			sort_order = sort_tmp;
+		}
 	}
 
 	if ((last_key != K_SWITCH_INPUT_DATA && last_key != K_RELOAD) &&

base-commit: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780
-- 
2.47.1.613.gc27f4b7a9f-goog

