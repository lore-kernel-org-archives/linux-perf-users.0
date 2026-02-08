Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED19215F5C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Feb 2026 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770553387; cv=none; b=D53BOWrynG9xS4mZaR9FBEm1T+QCDnAO1QcFJuNrEGCfGHqOYdCb4GpilQkP6+5Ita4ARKHqaAQ9tzGLdsYRsxJ3L1IbCc7A5q2mdwY3odFbmPDJqtLUi4Pt+AXLJlkqDZcIgGg15SnWLHn6PONMIf1UP33uGzvTYmTsrMt50jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770553387; c=relaxed/simple;
	bh=uwL0BsIUNu1cm6lDLJZctWBNyYt/bgE6xmTjB3T64h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQkNTScnO8T7+JWBKwvolqB3nRhWE3oI3js4/Ry1u+Nv2Kqurp23vlUcx3UAvoOnohv/2L2x8t9BV2vxRo528MV5HIMzdLEqGy/jRe70RAigoxyFnsxDbH0JGC5dD1HDILtJWWVY4bmm1SkXbdKP99EszLn5XbV6CIkwOmO/L+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQBKLSsc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQBKLSsc"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6597a7bd7d6so3296884a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Feb 2026 04:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770553385; x=1771158185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF+XWDH5n+bfHia564ybxW50UYfw4r2efHJ5rGsGOlw=;
        b=IQBKLSscbAQvB+kGg3ypewJ5/ppM0Z4LrFF/D9EHjwMeayUT+lo6SOmrRyepAwQAXk
         BrlB8Fmx7WKEqUPnv6MuHOyTREKqC2Mckix6ZKrUGG0jZ7bLqV2mL5dmPKgpf1Vre8vM
         KqVp3FAy1xRyMKbiG8NB6dHD30e3/p5S17R0u3BN07EYyhcaY52OwOKHX20gmqQO+1jl
         cYer6RFH1ooF8lF3MHI8ukdzqeMKPTcT4lk/TpTkQNXIQElxmMGRPwqwimI3+/moVF/l
         +J237ijgVC8iGb84TgWKrC4abOkXMgQftD3z1YjgGyjBDCKdYR6JvVtoIlTl1hmmsTpl
         EKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770553385; x=1771158185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bF+XWDH5n+bfHia564ybxW50UYfw4r2efHJ5rGsGOlw=;
        b=EO7XI254PAziZdQiZL96BRhiefyP39r1AonmOKGwU2byIO599dvEkQy/sVAWVyjx14
         71AMOWfpRuu0u7dBpFMUBkMLy/kvlRTC3AVAxF/qTn7jVGKJhd9hs3wODXK/7ICjOeC+
         lmS62ts0YalNKibx62uDDExunS2+WwyW7QzUTbL7sOMS8T9993BY/8/t221xch6dbUt9
         axnF6dq4IOx0yDdbjbeHtgvR9kgq1f0YIFXr0yweXOuGrfVUIYDA5YjBFBL5VJinxDZX
         U1pfhYO4VwA9AislL1lf8rhSolt8H+S/SBSG/75YcUkGP1rUGWQedszaAXL8dp48VjyR
         POLA==
X-Gm-Message-State: AOJu0YwNPzVoGoPt3q8o8sqKwKdfL4jCZeua/hCPWhKDwujifNjWIXP/
	82YHlesKK6iDaaHBaorZDD7py8R0RQurROaDcgg++BIRNuebEaN43dxUArAMLw==
X-Gm-Gg: AZuq6aJ0UPIvpHcCff0mxvMVCkJ7fNfKF+IwQ+lvoVt1JJuC1y02NOG+1TgguvYOSYE
	c4nzkVAsFB4y9DaW9qICAOtVV7Rj4Ozg9U3Z5N1l/+NwmFZJYd0WjxWF1bDdnSSPZMv9oAwgXPw
	R/XVMh19moiM6E+JQFDNSN18yjiJNtAVx8Yk6WC9HZYjJyQuDdT2wliF6WD16ND//BSDyBSAG5Z
	mIL41OIs+sKLPglRz2AXOrEh/S5bdsZre5sfqu/Evdb6UjcSqi4goBHu644KF9Ov5vD7CaxMyoV
	6o3zXVQd3LPoMxdjTEAL11sV171VLeavnARPNPuqRR90wATlzhcQbAVIdFD/Z/ezA+aZwz3Zsgt
	Kutooai3Bga6dLH3CpiqjCVRyzi5JrBl4XaMU59lcJiTQoxNMEQ2aL+9cC5N3BZe9V5Jn/y8jws
	xBZI0NBfaNVQUtapmKeKeWD12eIT3VaEcju3ed2jniVexRjvJEqDTwaMf551FOE0DU07maOch1Y
	JhrfOzMibuB6PwaKLA=
X-Received: by 2002:a05:6402:4306:b0:659:454b:7167 with SMTP id 4fb4d7f45d1cf-6598419575cmr4599283a12.23.1770553385264;
        Sun, 08 Feb 2026 04:23:05 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.local (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65984024e11sm2011658a12.32.2026.02.08.04.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 04:23:03 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH v2 4/4] perf tests: Test annotate with data type profiling and C
Date: Sun,  8 Feb 2026 13:22:26 +0100
Message-ID: <20260208122227.3524-5-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260208122227.3524-1-9erthalion6@gmail.com>
References: <20260208122227.3524-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise the annotate command with data type profiling feature with C. For that
extend the existing data type profiling shell test to profile the datasym
workload, then annotate the result expecting to see some data structures from
the C code.

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/perf/tests/shell/data_type_profiling.sh | 31 ++++++++++++++-----
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
index cdc9adb7d70..a230f5d4c42 100755
--- a/tools/perf/tests/shell/data_type_profiling.sh
+++ b/tools/perf/tests/shell/data_type_profiling.sh
@@ -6,12 +6,14 @@ set -e
 
 # The logic below follows the same line as the annotate test, but looks for a
 # data type profiling manifestation
-testtype="# data-type: struct Buf"
+
+# Values in testtypes and testprogs should match
+testtypes=("# data-type: struct Buf" "# data-type: struct _buf")
+testprogs=("perf test -w code_with_type" "perf test -w datasym")
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
-testprog="perf test -w code_with_type"
 
 cleanup() {
   rm -rf "${perfdata}" "${perfout}"
@@ -29,12 +31,23 @@ trap trap_cleanup EXIT TERM INT
 
 test_basic_annotate() {
   mode=$1
-  echo "${mode} perf annotate test"
+  runtime=$2
+
+  echo "${mode} ${runtime} perf annotate test"
+
+  case "x${runtime}" in
+    "xRust")
+    index=0 ;;
+
+    "xC")
+    index=1 ;;
+  esac
+
   if [ "x${mode}" == "xBasic" ]
   then
-    perf mem record -o "${perfdata}" ${testprog} 2> /dev/null
+    perf mem record -o "${perfdata}" ${testprogs[$index]} 2> /dev/null
   else
-    perf mem record -o - ${testprog} 2> /dev/null > "${perfdata}"
+    perf mem record -o - ${testprogs[$index]} 2> /dev/null > "${perfdata}"
   fi
   if [ "x$?" != "x0" ]
   then
@@ -52,7 +65,7 @@ test_basic_annotate() {
   fi
 
   # check if it has the target data type
-  if ! grep -q "${testtype}" "${perfout}"
+  if ! grep -q "${testtypes[$index]}" "${perfout}"
   then
     echo "${mode} annotate [Failed: missing target data type]"
     cat "${perfout}"
@@ -62,8 +75,10 @@ test_basic_annotate() {
   echo "${mode} annotate test [Success]"
 }
 
-test_basic_annotate Basic
-test_basic_annotate Pipe
+test_basic_annotate Basic Rust
+test_basic_annotate Pipe Rust
+test_basic_annotate Basic C
+test_basic_annotate Pipe C
 
 cleanup
 exit $err
-- 
2.52.0

