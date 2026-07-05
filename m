Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746D7081F
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Jul 2026 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783213161; cv=none; b=DdIhWzgV5otHQqGM87uwtyRydYxRA1NgsdIMApuLM+NvTYDdGatlRqYa5qqKJOU8r/2EKgl7wV3Qo78VilbZMyCPiTOWfiP4doWgQjewcySg0GmPihVy/2r7VXUPNgwYhl4Y6hvXZnYfoYLEj0BfjN98JLIql5cwVSWU5Sol0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783213161; c=relaxed/simple;
	bh=cO7KeLajt88zWj6/I8j6srjza3AyBwZkqVAlBytQiXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlc9rv04RWPdx+KL0y2lADhrkKh/baKgCd2s0R/cUGIhpR4uIM+EM2pDijGobXqgprB7+LPHVpftx+YR5oicbcmSXn6F6YzWYJ5YA/YYTCyKSRgyC8+iF6Us0XWSVRW7EdmrHqz4wTU53BqoTkbYG6LOnMDVHAV5qOLG6buRaFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPd3Axkr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPd3Axkr"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so2968963a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 04 Jul 2026 17:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783213158; x=1783817958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryMBcxUXggyzl/qW7f/DH7Mf3hmnzZUv0RCLZTa8uB4=;
        b=rPd3AxkrC3jidVOZbM05yaXU7yGja4758fVFX05/EdDz0tZe0A6ieVvf/dQY8ilab3
         fVrWforAU5g1mLW2OpgCuJJG6tjx9bY1dS8hUmsI4yfpH3e/v9/dfDWvMWa9upnXDW7c
         mi1MCBZ6doe66gM8t4W1VXrQc9iR9Wlpz9OQ3fTdbqud1+msO6L66X0uvfCP5PdhkbXJ
         ZEUg2l3EooKkkhgQIfw4o6RvkAaN3BunkMiLLtSHTg6gd6PXZil+AYmEDR2xSxNqeQmA
         uex411KuzBBZ7UuhHfmzK9St2DLAJ8FnEO/TQXYAtCOXO31C697WwREloC6hB4sQFDOn
         KkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783213158; x=1783817958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryMBcxUXggyzl/qW7f/DH7Mf3hmnzZUv0RCLZTa8uB4=;
        b=i+/30Wc3DOA9I1kp9/XwhiK+gKm0APofdfawNdTMN7tYqtJoKLCO0ZcIED98TL59IY
         Ek79yV7CgF64KhdqUll4wLBYpfXWyYapKLalVM860GyNcN+rq5mNPi9XUPpi5e7qQwdP
         5oe2hxqbQs54gVmQZpNwPDx5u3UvoEWc9VUBIO5CoRrWiTMKyJn+Z70k/Khm8j9mfLo9
         FwKDek3XVXjx+nVUyFR6vI3WNndn8j9yTVc1rUzkvUi35yybg9juU2mphj136u+SYNU/
         nFmvwRqtnEwqp08fmGb0gvVDwt9OTO8Me2S2Y6vAGlysOrlIdUcKXMFPtaw1uBOmqqGq
         WatQ==
X-Gm-Message-State: AOJu0YwPRxymEs8T8p7ZYJo3JJGu8mA1gV/6sS3HoVLnqLHJ63DxSvxQ
	Bc4VCP1R3yhi/wEseu2QS54BMBah+eK/UEflm5F1ic5SptZ1LrNBBcsls0sAUw==
X-Gm-Gg: AfdE7cm3PMCvSEdPDWcdGdmugNV6GkzadXg1r79Gwi36vOz7tYPab7uYUBi7BrSMJDC
	PUoKDeaCM1FuFDQArEz0MIMAliaJ5obEVyZTvLeKoeza8eG3+xSXRdYzfxzYfLla0jDZS9Y/E4h
	tKooNRGGGEV442ceutixE1TJgNIbusjxI/IHcbWHO+OmaWhfSMmaCb+GzQOjO94jWD7H9ai0ni/
	eG+RJcq8q7gc5OB+R9yLXhE4xJ3ice9uLYDB8bPaJXudnTgsLceoVGyZgy9Ztm4NbvY6p/T+fe7
	mfUpuvm2hRsLpmuANDgjYC98YURPVtdWzefwmLBNtEnH+BuO8ZzI1JAIBRpRPnIdKMjmX+iS1bo
	pcjgbuMMUzwGAijsBKjgR1TNGzKlZMIdF+eP6fx1V7ll1rzpqNjH/y0nl0GG/sXeuapUFg2Wi0x
	hHJFF+Gofhdwqqs4z9nWXQrFDXfOjVqyUuANBkdJ2vqHlO8RH5rz7EHnmPGQjU2TS5BiS3rgUU+
	E41rxhxzvgzVNM5PzaZqGH1e5EfouQ9wJhmXZFYtaRkxWdmwReqmnD8RFozuN+B7tcHFq6OLVUS
	9x9xvOMrIiN3ha/F5FHuG8Oumc5c1VUPqlZZaTuumOEnSvwdgqSIFbRiMLnmdJMiQOAb9ng=
X-Received: by 2002:a17:907:1b17:b0:c12:5660:8bb3 with SMTP id a640c23a62f3a-c12e6ae1c1cmr156529666b.21.1783213157729;
        Sat, 04 Jul 2026 17:59:17 -0700 (PDT)
Received: from ilazaric-gram.arnhem.chello.nl (2001-1c00-4c85-8400-b177-2347-3868-c305.cable.dynamic.v6.ziggo.nl. [2001:1c00:4c85:8400:b177:2347:3868:c305])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62f6e3dsm478126966b.62.2026.07.04.17.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 17:59:15 -0700 (PDT)
From: Ivan Lazaric <ivan.lazaric1@gmail.com>
To: linux-perf-users@vger.kernel.org
Cc: irogers@google.com,
	Ivan Lazaric <ivan.lazaric1@gmail.com>
Subject: [PATCH] perf stat: reject --field-separator and --json-output combination
Date: Sun,  5 Jul 2026 02:58:40 +0200
Message-ID: <20260705005840.1252666-1-ivan.lazaric1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specifying --field-separator option is stating you want CSV output.
Passing both --field-separator and --json-output is then stating
you want output to be in CSV and JSON format at same time.

Currently this combination is not rejected, and the outcome
is a malformed combination of CSV and JSON output.
This is because of inconsistencies in various printing functions,
some of them have if-else chains that start with
"Should I print JSON?", and some start with "Should I print CSV?".

Example of current output:
$ tools/perf/perf stat -x , -j -e cpu-migrations true
{"counter-value" : "0.000000", "unit" : "", "event" : "cpu-migrations", "event-runtime" : 474817, "pcnt-running" : 100.00,,

Instead reject the option combination,
with a helpful error message and non-zero exit code.

Example of new output:
$ tools/perf/perf stat -x , -j true
cannot use both --field-separator and --json-output

 Usage: perf stat [<options>] [<command>]

    -x, --field-separator <separator>
                          print counts with custom separator
    -j, --json-output     print counts in JSON format

Signed-off-by: Ivan Lazaric <ivan.lazaric1@gmail.com>
---
 tools/perf/builtin-stat.c      |  7 +++++++
 tools/perf/tests/shell/stat.sh | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 99d7db372b48..5565351db756 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2637,6 +2637,13 @@ int cmd_stat(int argc, const char **argv)
 
 	stat_config.aggr_mode = opt_aggr_mode_to_aggr_mode(&opt_mode);
 
+	if (stat_config.csv_sep && stat_config.json_output) {
+		fprintf(stderr, "cannot use both --field-separator and --json-output\n");
+		parse_options_usage(stat_usage, stat_options, "x", 1);
+		parse_options_usage(NULL, stat_options, "j", 1);
+		goto out;
+	}
+
 	if (stat_config.csv_sep) {
 		stat_config.csv_output = true;
 		if (!strcmp(stat_config.csv_sep, "\\t"))
diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 4edb04039036..c4cd249d8e6a 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -483,6 +483,17 @@ test_stat_pid() {
   wait $pid 2>/dev/null || true
 }
 
+test_csv_json_fail() {
+  echo "stat -x <sep> -j test"
+  if perf stat -x , -j true > /dev/null 2>&1
+  then
+    echo "stat -x <sep> -j test [Failed - command should have errored]"
+    err=1
+  else
+    echo "stat -x <sep> -j test [Success]"
+  fi
+}
+
 test_default_stat
 test_null_stat
 test_offline_cpu_stat
@@ -498,6 +509,7 @@ test_stat_no_aggr
 test_stat_detailed
 test_stat_repeat
 test_stat_pid
+test_csv_json_fail
 
 cleanup
 exit $err
-- 
2.43.0

