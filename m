Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A521B6CE4
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744240363; cv=none; b=Vfqu1GxWnnnr5KypkyAk2B19UnfG9kBF0gKQ+JmhUHh/hf5vJy62qcAxK1oNq0oO+IszQ5dKcguD24sjfAPf8w9NI1j6rBAC4nnET1349o9PlyMVWd8ga1/2+OrmZw7R0m96Ls6sW7cUvduFew0RdBh2CFqt7CFbHQCkzyU+dz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744240363; c=relaxed/simple;
	bh=WIA49+TKtPo0Cw/Pzw0xYETN11R/ZSK/Jj6AtKvIyJc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YcPMPKsZnEeFTXlC5JBkoAxhRfDVANo0VLDNTePmd8n+rVvs0G7fyeRuIGgZWfVH9RRVbka9jnkIew4KMsDx/z6Pbr6GYok7O3+p2op2VTIIBvH2MQnmPBpysAxjD8ODL4B1fuk6Q8CqaYGsZGpYob5qOZXfgxh7cMCBmQUVeS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uuHwXCRC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuHwXCRC"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736b431ee0dso107955b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Apr 2025 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744240360; x=1744845160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hQy2Z6G5chmLGArkdaIBDoxGpfcNVyaQUKkExyNr838=;
        b=uuHwXCRCOpyc2+PR66raRyHhMm4LNcAvdPifIKvrGUkVIP30s4ftl6DGjvAvb/hd4x
         +bQw6eo9hYCRLcu7run0kKwQnANjUIUmkZLPZoDqY5MkB0JNTZYXLeCIYUkVq8ehYHNG
         kU/5Y4zDrKGLEJZ2geLj/zX93fTbNQbGzPGmZaq8OZiU5wb7L14tCu2roz4vzGkJY9yB
         SNcFFDyFFsfANafHJB017aJg64nGmnhNkdJE+mAM3WkDlm6etzBlEMXEHG0HndAezEHj
         F7fgIWTpwy277hIsNeedEv5Yk5NUB9fWnpIapfkcoqmsRUpk1qjoEs3veVWLMFOeX1Z4
         5dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744240360; x=1744845160;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQy2Z6G5chmLGArkdaIBDoxGpfcNVyaQUKkExyNr838=;
        b=Zm7OXFpJR/b9Tf4Hkk9WUCTLv7AvVEblRUBvsyvTXgGAkNnfwRYrvoHdZq/bv5XeUC
         98eAUIKpxVdInSFNe4Hih9MImjvjQtmFA5AyY6mVfZ0e1wF/G+PPaGaQDk9bAdksDAzA
         PZceYQzTL+EP14QzdG7kQB2y3FgvEcoeE1qQpm3AA0uyj5Ppy9xCyiO6mV2YixX2+VP/
         sw5ojQoGDv3omW/cl5AlistVbHwIjmas4Vu9BjqgRx6dqskLZtCccA+rqie70ikbBoTo
         dXkw7URj1IOuLiMK+WSuSSswNr3blIVwaRoj44B05i4PyOgbPCS2WzD+lKnGwU1UqNAM
         gdrA==
X-Forwarded-Encrypted: i=1; AJvYcCW/MKB1FLOlVQRUMG619ZOy5DGIdexY6wFLBAZvJ3OfjCd6cUmcP+nSE6W37ypC3iGEf+ojcaw6u14zaAoWAd5Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtxg1aEZ52VuFtzA5pdYi2IsOBlkVXy52dHLYfpL4PfZNXYO0
	YCUYrVoYGSf48WilJ7dey3lTbADjISWUDD9PRTCBDOoI158LxcOwNiGQ0Rz4wZUITc2xIcVdlp4
	YIA==
X-Google-Smtp-Source: AGHT+IEMiE4nRjncWxQA1pYrSlI10L6gQJX9h+opY9uU6dmtwNxQEFInA5eHScgXeegRJyJ6ePIaiikHJGM=
X-Received: from pge9.prod.google.com ([2002:a05:6a02:2d09:b0:af2:7f61:e1d4])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:ce4a:b0:1fd:f8dc:833e
 with SMTP id adf61e73a8af0-201695c31c3mr1457564637.30.1744240360348; Wed, 09
 Apr 2025 16:12:40 -0700 (PDT)
Date: Wed,  9 Apr 2025 16:12:08 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409231230.1678358-1-ctshao@google.com>
Subject: [PATCH v2] perf test: Allow tolerance for leader sampling test
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, dapeng1.mi@linux.intel.com, 
	vmolnaro@redhat.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There is a known issue that the leader sampling is inconsistent, since
throttle only affect leader, not the slave. The detail is in [1]. To
maintain test coverage, this patch sets a tolerance rate of 80% to
accommodate the throttled samples and prevent test failures due to
throttling.

[1] lore.kernel.org/20250328182752.769662-1-ctshao@google.com

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Suggested-by: Ian Rogers <irogers@google.com>
Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record.sh | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index ba8d873d3ca7..06a718e80121 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -240,19 +240,39 @@ test_leader_sampling() {
   fi
   index=0
   perf script -i "${perfdata}" > $script_output
+  # Check if the two instruction counts are equal in each record.
+  # However, the throttling code doesn't consider event grouping. During throttling, only the
+  # leader is stopped, causing the slave's counts significantly higher. To temporarily solve this,
+  # let's set the tolerance rate to 80%.
+  # TODO: Revert the code for tolerance once the throttling mechanism is fixed.
+  valid_counts=0
+  invalid_counts=0
+  tolerance_rate=0.8
   while IFS= read -r line
   do
-    # Check if the two instruction counts are equal in each record
     cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
     if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
     then
-      echo "Leader sampling [Failed inconsistent cycles count]"
-      err=1
-      return
+      invalid_counts=$(($invalid_counts+1))
+    else
+      valid_counts=$(($valid_counts+1))
     fi
     index=$(($index+1))
     prev_cycles=$cycles
   done < $script_output
+  total_counts=$(bc <<< "$invalid_counts+$valid_counts")
+  if (( $(bc <<< "$total_counts <= 0") ))
+  then
+      echo "Leader sampling [No sample generated]"
+      err=1
+      return
+  fi
+  if (( $(bc <<< "scale=3; $invalid_counts/$total_counts > 1-$tolerance_rate") ))
+  then
+      echo "Leader sampling [Failed inconsistent cycles count]"
+      err=1
+      return
+  fi
   echo "Basic leader sampling test [Success]"
 }

--
2.49.0.504.g3bcea36a83-goog

