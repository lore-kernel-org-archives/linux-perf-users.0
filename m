Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCAB23C4E9;
	Thu,  1 May 2025 02:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066511; cv=none; b=GrTpVwL9zmmPJzFgQqVKoVsqlb+9CcTZrha4GZSfVqtolpaGCYfUURh6bVm304tsEngOjseB6ChypqGKty2hetEg1xneJYLBe+ne2hk6XZbsGQGRhEKgjEklZ4gSU/cBMkGbmvTBQEtc4+duHdsr99nvs9rGbs2RtN6Orh+RT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066511; c=relaxed/simple;
	bh=88Fl2EiHB2cjDAVZPyhgr0clBqVOitL8l2L37ibdLfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KONFvneXBT8mTIdraR6kn3fWZuQ1oaWQvUEKkNxUAigj0G9uak+nXQHE+E+OXFAAl1cDMSfTiiJ8eemTVq7wOX3ghyLAEF/uK8NbQy3ZGgRmPqW+JarVVAGWY8TMr4BYkmWUPEzffN/TCDLhfJiOT+DNSNAlrD7Dkjrf1mTz4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApY/8GuB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApY/8GuB"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74019695377so463075b3a.3;
        Wed, 30 Apr 2025 19:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746066509; x=1746671309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UD84FLOguCUPK491YqR0LpWQbCrSSziD1nV34s4DcTM=;
        b=ApY/8GuBfst77z6SkA6iwijCcDVYoTAbGTV86afGpOUZ2r9x11q7IM0WHMNjm/pGET
         PDY7FZvLX1vKBYQ7ftOd7O7qy6udWKhiWW8uyzAHDSijrRAE06Uyvg+X6l5FZzvBpPEW
         3dSsjFhvtIb1bmizDQpbF9CQtHKqmNt0L2xrd83Iem+CGuBZMWNKIFPdE8B0MM54DSeq
         ZF4HSa7+3lcU8Bhl+Cwwjae1Bn5tzgdwDiorUUTS7211zTtUM5xifHgVJ3BdkoL0hB47
         coWv51L7VVHEQljAIQx4ysvY+C4vYDsMb2uTmhhXnIuWeKfiQPXlFApvXew+xUyBpRtk
         B+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746066509; x=1746671309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UD84FLOguCUPK491YqR0LpWQbCrSSziD1nV34s4DcTM=;
        b=Rxb42zM1tX7XKldQS6cV6wW6xOzqCb8w7lZoGrYgx1xMXHs+MQ8M+kAVO2DxI7aXFb
         2ixREpW6ni20SwIy0KXqo9DczhjQt0CNzv+2yuGrPwGGR9D3yCzPcaGdufUZnnPMMMA6
         ets2WeeDEPRwctrNlhNoKNejjGyTBvw9k72TUpZYSZiOqXHp+ysITnoy3m1OThgKKrWp
         s14AmTIRcEHTmpqzhXbeJCdUIy/dayZ7x6yFOJklBER2UNBtbXO/nM0wFQ6ySwQXMS+u
         3hNPdXrpW6ERj4zSOyoVJcz8A+gmj19QbC9Jiy2Hp3986Iv4t0+nizMJTbUGwSVxQUWc
         rm3g==
X-Forwarded-Encrypted: i=1; AJvYcCUWVQ7qYWDyoT6BOIlryELANjgGNtExUVEadj9SFsRE+Upw5cD/F/5p5bkotPF8SyTF8C5INgW0MI4qipWI9cWb8Q==@vger.kernel.org, AJvYcCWzv4RX5UTxidxU7GLZz0uqekfkgFNlUlbQwDnzd60JthfxQGKtp/EJD8v4uwmQq1WnMwKPOf0j9shsRJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhjJ22YDbtBk1P5J4Rml0fgwLovxIUeylA8Kq1fz4Bz7TQ9+YN
	IWm7FyQDQIdJcAsFslZDrAuOix+n1p1Og1GzdFJ7Eh1j0XbVO5Ob9bDxH83pAcE=
X-Gm-Gg: ASbGnctV8W5z0i0Is4pthg9GCMECmNVMZb2vrJNiYiryKczzoZ2KLXvYb4wYz+gWHUC
	vwWJu4Wt8nVig/P9wHDHR7I9mu8Wa1Hsnq49HVQ5o9GiWi/gjdBPY1BrEmS7S6MNhzLngsjqtHC
	feP77bVmsWeu6x88UsBcpF2qeorAy0sMAJMdNHdhbkwi587U4eVs0DvWTQVnsE4qdlq5ViKacEx
	bn87VTIwXRQLkUiHjuqOydIzgi0CICKZEe7t/6FJyhScFVltVOLgEtupiI2hPBimgR42K3/akWi
	zsBdqe4lMwfvFbjLvCJkjLofaISwA8+j6VkxAxDfrPlAWJ1e4bBSeEvxb2f1T4z4rxnsynMzk4B
	eCtBpcwDvYg==
X-Google-Smtp-Source: AGHT+IHUl/RIG+xtTeDx0MHsPJ86xGEI/v/ocRMn1FSmJ5Z/rhqw/mhisX97wA5jyrbu7YM47GRV2Q==
X-Received: by 2002:a05:6a00:2189:b0:739:56c2:b661 with SMTP id d2e1a72fcca58-740491eb4fdmr1233728b3a.12.1746066509458;
        Wed, 30 Apr 2025 19:28:29 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a8fbe7sm2459599b3a.160.2025.04.30.19.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 19:28:29 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gautam@linux.ibm.com,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v16 10/10] perf test: Add direct off-cpu tests
Date: Wed, 30 Apr 2025 19:28:08 -0700
Message-ID: <20250501022809.449767-11-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250501022809.449767-1-howardchu95@gmail.com>
References: <20250501022809.449767-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we added --off-cpu-thresh, add tests for when a sample's off-cpu
time is above the threshold, and when it's below the threshold.

Note that the basic test performed in test_offcpu_basic() collects a
direct sample now, since sleep 1 has duration of 1000ms, higher than the
default value of --off-cpu-thresh of 500ms, resulting in a direct
sample.

An example:

  $ sudo perf test offcpu
  124: perf record offcpu profiling tests                              : Ok

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/record_offcpu.sh | 71 +++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 678947fe69ee..21a22efe08f5 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -7,6 +7,9 @@ set -e
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 
+ts=$(printf "%u" $((~0 << 32))) # OFF_CPU_TIMESTAMP
+dummy_timestamp=${ts%???} # remove the last 3 digits to match perf script
+
 cleanup() {
   rm -f ${perfdata}
   rm -f ${perfdata}.old
@@ -19,6 +22,9 @@ trap_cleanup() {
 }
 trap trap_cleanup EXIT TERM INT
 
+test_above_thresh="Threshold test (above threshold)"
+test_below_thresh="Threshold test (below threshold)"
+
 test_offcpu_priv() {
   echo "Checking off-cpu privilege"
 
@@ -88,6 +94,63 @@ test_offcpu_child() {
   echo "Child task off-cpu test [Success]"
 }
 
+# task blocks longer than the --off-cpu-thresh, perf should collect a direct sample
+test_offcpu_above_thresh() {
+  echo "${test_above_thresh}"
+
+  # collect direct off-cpu samples for tasks blocked for more than 999ms
+  if ! perf record -e dummy --off-cpu --off-cpu-thresh 999 -o ${perfdata} -- sleep 1 2> /dev/null
+  then
+    echo "${test_above_thresh} [Failed record]"
+    err=1
+    return
+  fi
+  # direct sample's timestamp should be lower than the dummy_timestamp of the at-the-end sample
+  # check if a direct sample exists
+  if ! perf script --time "0, ${dummy_timestamp}" -i ${perfdata} -F event | grep -q "offcpu-time"
+  then
+    echo "${test_above_thresh} [Failed missing direct samples]"
+    err=1
+    return
+  fi
+  # there should only be one direct sample, and its period should be higher than off-cpu-thresh
+  if ! perf script --time "0, ${dummy_timestamp}" -i ${perfdata} -F period | \
+       awk '{ if (int($1) > 999000000) exit 0; else exit 1; }'
+  then
+    echo "${test_above_thresh} [Failed off-cpu time too short]"
+    err=1
+    return
+  fi
+  echo "${test_above_thresh} [Success]"
+}
+
+# task blocks shorter than the --off-cpu-thresh, perf should collect an at-the-end sample
+test_offcpu_below_thresh() {
+  echo "${test_below_thresh}"
+
+  # collect direct off-cpu samples for tasks blocked for more than 1.2s
+  if ! perf record -e dummy --off-cpu --off-cpu-thresh 1200 -o ${perfdata} -- sleep 1 2> /dev/null
+  then
+    echo "${test_below_thresh} [Failed record]"
+    err=1
+    return
+  fi
+  # see if there's an at-the-end sample
+  if ! perf script --time "${dummy_timestamp}," -i ${perfdata} -F event | grep -q 'offcpu-time'
+  then
+    echo "${test_below_thresh} [Failed at-the-end samples cannot be found]"
+    err=1
+    return
+  fi
+  # plus there shouldn't be any direct samples
+  if perf script --time "0, ${dummy_timestamp}" -i ${perfdata} -F event | grep -q 'offcpu-time'
+  then
+    echo "${test_below_thresh} [Failed direct samples are found when they shouldn't be]"
+    err=1
+    return
+  fi
+  echo "${test_below_thresh} [Success]"
+}
 
 test_offcpu_priv
 
@@ -99,5 +162,13 @@ if [ $err = 0 ]; then
   test_offcpu_child
 fi
 
+if [ $err = 0 ]; then
+  test_offcpu_above_thresh
+fi
+
+if [ $err = 0 ]; then
+  test_offcpu_below_thresh
+fi
+
 cleanup
 exit $err
-- 
2.45.2

