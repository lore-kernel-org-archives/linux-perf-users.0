Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E713DBBC;
	Wed,  7 Aug 2024 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045177; cv=none; b=dV9qBf5GvssqRK2q+6vimtD1xUqrxaojMI+DDPVX9NXw7j7CzXDlMXvxUX9+iheXAK/p1lyuhQ5UjyWXpPyePFB9bnfzdQvnSj9/ZZ2LgAR+C8Lxf8O3UWcjKFcTtNRitP5QXqMrzC6jlF6X+HMMXwBh2NHDaI+t/SeBqAde3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045177; c=relaxed/simple;
	bh=v/lW54jVExiECPHOK5dymKyF8qjzPdktdFdL9OyTjGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7KysMQzkikt/YxkxkMvYFfXfjOy3DtIosW1x4ZADvbe9PI9kRfVH0o7BhByQemHhUciMLngtqOoR/IkhbgJA3Su/Hov8z/6HPjxdl7ZmBesWAsFH5EUVJ4wMpQcGP+1yohqGoR+oh7SpKAbbTz3lE4S80s7kKUjYFgDk1UKyuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVgt/sGW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVgt/sGW"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd66cddd07so491325ad.2;
        Wed, 07 Aug 2024 08:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723045175; x=1723649975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soyrr8oKFRhnn8yi4F2C3vzDC9dotJSg6I+qdK/nTSw=;
        b=AVgt/sGWmBcaRz9kERRWNhsSbxcN5xv7vI7JT6CTZX1FAXgh8GNaYZvDfvxwMVUZC6
         AE+I37rO4mSFJhd1Cz0xr6FpC8/P0zDWFXUuy1gQQ74SgSvUSZu//pSJdokaBcRB8WEJ
         muN8FyM0SyWDKxekvEb02EKoR4CxKssIXOWRbzLEWn1VoqD/0VmM2d/0nO3ex7aXo7lt
         MZJJEdaGdsst0J42UMEpiqrFIPb03XQu/IYYZGQ8TQ2QjqeEPZ5JmlvViD/u87NWfkP0
         MdMZBJP1kEDErRNyjhWbDvNbMovVVddYv3i3KJIhMCMLp66KGtU+wSJfQJLN24AH9m5+
         Fd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045175; x=1723649975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soyrr8oKFRhnn8yi4F2C3vzDC9dotJSg6I+qdK/nTSw=;
        b=jh1J14c5X3w5lRnEa6uerb89XsuDINYiGILDEvzHGkAd2eAfNQbwOHR1m97LRuYRsm
         ohW4oSKZe0xlvjYoKZo8QJ2YkJy1siZhvm5y+rbZrueFKzqVpuLeVFcJ5QuC5y1i2nYj
         IIs+smc7n4skGLy6kminfZ35sI5RBgejnkkvkMYG3krZRhDiy866Wc8szZ5gvgLy4QIz
         s4MxzexulP4Zaqa1mgUnqttvvjPiPSgmz/lWZIt0pQVJoFpkvhpPtouxrPJ2s3cVzxSE
         bbtO++80OYS7bpQTFxPMeiEx+7ZLJQhTHREnHfoxlmJZ7cUjaifutddLZ23hIutItYAh
         dG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUt+Ojam2fH7vWiPMc3TwBY4e4Cct9yCjrvUqyyYKK6kl5yzpUEAb4Ha1LDIYKlQHEyiUQ3T6zhi/PdLwrNzL7PNg==@vger.kernel.org, AJvYcCVmCuVphXAORG/Ni8m5fH/+xnhq7gXCbiSxSkOVqCxL1+4unCKyRbV1GXjfNDFukEd/zHg6o/y/XhuGLnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrf2kUTigUgaFMQgb+dNY5HR8YCACvT1k4/1cKdKFdfORTS5KR
	l0AHIeiXJU/+SXEhwXWCtmBcRua11HYgVJXMbGzvOWFGiLpd3Pg7
X-Google-Smtp-Source: AGHT+IEx4uXbTNouB5jgch/yIjkA+bVZUvAy0eKlMM3V8hQFzx2NaFGhwvvDMQFE3cWwXEC6Nz7MTg==
X-Received: by 2002:a17:903:11ce:b0:1fb:4f7f:3b59 with SMTP id d9443c01a7336-1ff5723e593mr201091205ad.3.1723045175227;
        Wed, 07 Aug 2024 08:39:35 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59297329sm108097375ad.247.2024.08.07.08.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:39:34 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 9/9] perf test: Add direct off-cpu dumping test
Date: Wed,  7 Aug 2024 23:38:43 +0800
Message-ID: <20240807153843.3231451-10-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807153843.3231451-1-howardchu95@gmail.com>
References: <20240807153843.3231451-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple workload(offcpu.c) to create the scenario for direct
off-cpu dumping.

Please run this test with 'perf test offcpu'

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/builtin-test.c         |  1 +
 tools/perf/tests/shell/record_offcpu.sh | 27 +++++++++++++++++++++++++
 tools/perf/tests/tests.h                |  1 +
 tools/perf/tests/workloads/Build        |  1 +
 tools/perf/tests/workloads/offcpu.c     | 16 +++++++++++++++
 5 files changed, 46 insertions(+)
 create mode 100644 tools/perf/tests/workloads/offcpu.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 470a9709427d..aa33beaf58c8 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -153,6 +153,7 @@ static struct test_workload *workloads[] = {
 	&workload__brstack,
 	&workload__datasym,
 	&workload__landlock,
+	&workload__offcpu,
 };
 
 static int num_subtests(const struct test_suite *t)
diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 67c925f3a15a..6c26f541a09a 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -6,6 +6,8 @@ set -e
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+TEST_PROGRAM="perf test -w offcpu"
+dummy_timestamp=18446744069414584
 
 cleanup() {
   rm -f ${perfdata}
@@ -88,6 +90,27 @@ test_offcpu_child() {
   echo "Child task off-cpu test [Success]"
 }
 
+test_offcpu_direct() {
+  echo "Direct off-cpu test"
+
+  # dump off-cpu samples for task blocked for more than 1.999999s
+  # -D for initial delay, to enable evlist
+  if ! perf record -e dummy -D 500 --off-cpu --off-cpu-thresh 1999999 -o ${perfdata} ${TEST_PROGRAM} 2> /dev/null
+  then
+    echo "Direct off-cpu test [Failed record]"
+    err=1
+    return
+  fi
+  # Direct sample's timestamp should be lower than the dummy_timestamp of the at-the-end sample.
+  if ! perf script -i ${perfdata} -F time,period | sed "s/[\.:]//g" | \
+       awk "{ if (\$1 < ${dummy_timestamp} && \$2 > 1999999999) exit 0; else exit 1; }"
+  then
+    echo "Direct off-cpu test [Failed missing direct sample]"
+    err=1
+    return
+  fi
+  echo "Direct off-cpu test [Success]"
+}
 
 test_offcpu_priv
 
@@ -99,5 +122,9 @@ if [ $err = 0 ]; then
   test_offcpu_child
 fi
 
+if [ $err = 0 ]; then
+  test_offcpu_direct
+fi
+
 cleanup
 exit $err
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 6ea2be86b7bf..c7a5e27c4567 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -206,6 +206,7 @@ DECLARE_WORKLOAD(sqrtloop);
 DECLARE_WORKLOAD(brstack);
 DECLARE_WORKLOAD(datasym);
 DECLARE_WORKLOAD(landlock);
+DECLARE_WORKLOAD(offcpu);
 
 extern const char *dso_to_test;
 extern const char *test_objdump_path;
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 5af17206f04d..0e78fd01eaf1 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -7,6 +7,7 @@ perf-test-y += sqrtloop.o
 perf-test-y += brstack.o
 perf-test-y += datasym.o
 perf-test-y += landlock.o
+perf-test-y += offcpu.o
 
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/offcpu.c b/tools/perf/tests/workloads/offcpu.c
new file mode 100644
index 000000000000..57cee201a4c3
--- /dev/null
+++ b/tools/perf/tests/workloads/offcpu.c
@@ -0,0 +1,16 @@
+#include <linux/compiler.h>
+#include <unistd.h>
+#include "../tests.h"
+
+static int offcpu(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	/* get past the initial delay */
+	sleep(1);
+
+	/* what we want to collect as a direct sample */
+	sleep(2);
+
+	return 0;
+}
+
+DEFINE_WORKLOAD(offcpu);
-- 
2.45.2

