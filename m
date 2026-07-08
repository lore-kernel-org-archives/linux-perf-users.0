Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761A336895
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517088; cv=none; b=MciP0pCY2B9wMRI+kDqUZezkb8U7smFOYgo2MUKTdm37Skqmw0LjK/oPXZ8a0o2MnW8ZrOzqZO6AyP8vn3C0jjcOEUDd4/ssWvw6LT520Kb9RPVOyzdvbyq2g0qJgjyn+e4K6hMY5l/LDu2YbDG8aa0kkZSmu8yarauR6LBGHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517088; c=relaxed/simple;
	bh=WxdX7svUg2gkOqzTpDt4185TUIlnru5NbH74kr11l0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhMKEyxj5AgNpGVwbzkJYGDspCe0rBVUqXEL2CVBqAf6Bs3sN0O/HsDpIZSuHeCGIMiaAXxvSCwdCrIuThQ82dHuDBu3zTOuhqlb4n/HwKBA28EZsYqM3xmAOUw39j6Xho9FrVsaIHXTRWWQOHCGtle8u07uoSmw/LiKOruRwCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lv9p8AsE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv9p8AsE"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15b1da6b82so75166566b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jul 2026 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783517085; x=1784121885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dApGtoG3JAk6FGLOrmtAVZLsTd1Kxm0aHm6ovqcX76c=;
        b=lv9p8AsEBl2B/AqQHXGHExZy+5V71E76UTSCN6nCPIc96qelWGjXbIuofWn2bZFbKn
         o+JJ09f6cSc9vFRiLfF4NgKmIdwPDj2xhfPsx4UI7jH9NMFDn8kdwg36cedqatpHcvcA
         AaoPCQEMR2zg9Moj9ZVeP78ehxiYmLLnDtXEqY4c94tU5KPcpDM6z5LBSMLPeB75WJdH
         yfssxlQA7+VOgeSKn/D85Rk/f4TMfYjABKYypBTXBdVrHssvistbWo7PAgmD6QkNVvKR
         MlREv93XYOdkCJATyieGuWby0tds207OO8ICxXirkI21ArLVVALjJvpdYnKk4yyLVEqf
         BXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517085; x=1784121885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dApGtoG3JAk6FGLOrmtAVZLsTd1Kxm0aHm6ovqcX76c=;
        b=gWlgUU8uu0fPCsiMWcFK46oGEH1GB7s+Reibv2N/AlPe2oQ/jWUjj+ev7etHUrZuQB
         Q5LBpgJU4nvTqZO4bTc0CSldrACyYdVxJHdT9snbSVk1omPUk69TyV2XX9FhbzS7uEzd
         3YISgVgF7uczkHoXH9jMDmbknCYs7aC/ItyXZwpYszVFecrqWR+EvO9X01aC9jAAW5J/
         dgoyWAozb+HuR89jaNy0UeYfLDiWuBl6WBbn68AM8Kczl9OrFQ8fdlCFiUlibMW9ywed
         TeA9q7KOcxb6NFSOm06Rka86kMZNg2aH39QQ1cpSR552JKqSK2YQI/SPHzADkh1e/r4z
         Ns5g==
X-Gm-Message-State: AOJu0Yxb9Gzt1O6SOqOq52eVQOXFcSmgwJLH1D126ROjLz8YgR4tAwCh
	A8mmSZIuR0FOrgjRLlkO4uFeKIGia076EYdlqqL4Rzy0NAEUlxX2z8thH/zFmhCn
X-Gm-Gg: AfdE7cmDJOdIoEWutG/Q7PZo35u7ewFNHrHVdETkRAfTgyMfwbbFiwzaxPtAkfeeEn6
	SabdaM8322JYeSaUmKdA/GHkr38xKt1ehq9PM7wEhRwSNxhOXZp/1U4OM959jR1DR3pqfL1pnrG
	eBAWOC9K2ISuu1+gh7W8lwpf/iLlgyu5cwLwnAn/4k12umh9pHjVZKVdtzWqBZZPrpbknv3DcA9
	bT6f2YTjKHDjNtKnAnfmxOW6YHOA9fbEayYU3AhyOcJpH1GzyIN1vRZEjJZuyFODeC9TomNZ7l1
	znXyXIEgRnOV0FKG3IpPD15GOT+v9R8I8hL0YF/tEIJSEWDZ8K+gRjXPdmOGEfi2UwudeRsxC+8
	usSZ8k3kBUCLu2PlA1L3TqUDf1Qt9G/222Pcjq1rXyCmJewz94nYF1uLhyjSqL3RPP5zpxqfrNz
	UM7l5uyVC2uOmAzQu6Weepdfi6932YfoRE3jz6JTYVELt2HaIDbrBzWEdzkU9ofydv5WEmXkqBQ
	3AyqN2KPDCsK9wE7MQIkyJ7xhy0/NCZHDZBChKlCyf/EZjcSWXAVunu6UQscBS368iEbaGt45kA
	yvgbinspcH+Az250DaGb1stfe1e/TGfW6iCzqZdwz48oYE5s/lHRsq7FZlCvJjDcHtQ8sPI=
X-Received: by 2002:a17:907:3e02:b0:bee:f541:1dca with SMTP id a640c23a62f3a-c15ce045ddemr129767366b.28.1783517085221;
        Wed, 08 Jul 2026 06:24:45 -0700 (PDT)
Received: from ilazaric-gram.arnhem.chello.nl (2001-1c00-4c85-8400-142c-7b34-318e-a245.cable.dynamic.v6.ziggo.nl. [2001:1c00:4c85:8400:142c:7b34:318e:a245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ae0bb618sm320845566b.20.2026.07.08.06.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:24:44 -0700 (PDT)
From: Ivan Lazaric <ivan.lazaric1@gmail.com>
To: namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	Ivan Lazaric <ivan.lazaric1@gmail.com>
Subject: [PATCH v2] perf stat: reject --field-separator and --json-output combination
Date: Wed,  8 Jul 2026 15:14:01 +0200
Message-ID: <20260708131359.71732-3-ivan.lazaric1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ak3scJT4MfbAg0G4@google.com>
References: <ak3scJT4MfbAg0G4@google.com>
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
Changes since v1
 - Rebase on top of perf-tools-next

I was working off of master base branch mistakenly.

Applying the patch `perf build: Fix compiler errors with old capstone` to fix the build
(link: https://lore.kernel.org/linux-perf-users/20260706234836.815254-1-namhyung@kernel.org/ ),
this builds and passes the test shell/stat.sh (currently number 121). I have not tested other tests.

 tools/perf/builtin-stat.c      |  7 +++++++
 tools/perf/tests/shell/stat.sh | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 92cdb2df7285..3f685beba384 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2655,6 +2655,13 @@ int cmd_stat(int argc, const char **argv)
 
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
index 1e17bee026bd..649de1166fed 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -535,6 +535,17 @@ test_stat_delay() {
   echo "stat -D test [Success]"
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
@@ -551,6 +562,7 @@ test_stat_detailed
 test_stat_repeat
 test_stat_pid
 test_stat_delay
+test_csv_json_fail
 
 cleanup
 exit $err
-- 
2.43.0

