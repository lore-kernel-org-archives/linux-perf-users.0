Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99D155C97
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687384; cv=none; b=lwctsCSctlEFCLOMnr1NEX22khECrMJ3/nZMo2WvH5kNvaVWuRX1Pt3+F0hE8NcL9kjalSpveJBSTivyzophr6FPFct7QO3SzwBXfSPRiwVmbhxvMV//KHAyD4Y6RhtbeZ1AD70vSHQ6d3a58H/+8TuaEsN2hLLYFzFGgQ2jx2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687384; c=relaxed/simple;
	bh=DoyBadK94IVEd2EyxL+LuuK2g4kFW6i5sGsr9EH83yg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OW/AbMqbE7Ui3DHjAwo5ATwpEjczEZPE7uf+yEf53VcUhapahZogQxnHyyBxyLOlsjSyBKwFGFgCEt5PCB2D5YrUKEr3hVvy24V0uG3DCyh2xkHj6e+mBwJARIj916eYVFhILUtI2ygj+5iw28GzanNRoXmwuOU2JyWTd2wQ/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A5YYNqMe; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5YYNqMe"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cf7b79c6a6so2869299a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 08:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731687381; x=1732292181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NaNxMZvsegnXXio0/4jhhJ1ie7TFQifYHp2u96oS77k=;
        b=A5YYNqMeOzQJ9BJ0b7aoESEGCFjicOYZlekzscM1UgQc0iRK6R5+oCB7FPXSBhKiOB
         BEfkUozr8Q6Wv5tys43t7mnl9GczkjgaxZiDgoozi085CoVf7oPtR4ukqsHSPcjkuZtF
         4u2COXqKDnk3taMpEUNv8X3Sq2EXYHRcsCg2AOiJc02L4iTJDJD9b1zhiS66mrT3T33u
         ozMc3y8SqU57VsXIRe0/L4LSJEaAgm9ndrZGxYWhx3N59Z7rQztC6IGb0s48Yydq3HE5
         BDCbN55Zz/vebnn5jerSaK+7665Xqdvb6ba87KP4UVe6jOT5dZWVVXUOwPZTEyNAgzwV
         MuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731687381; x=1732292181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaNxMZvsegnXXio0/4jhhJ1ie7TFQifYHp2u96oS77k=;
        b=MG/uwatVifLYg/iwlHGeT/hdjaCeSFBbDZqbAKIjL5sl4xQkn2wq5NbkqrD5MN26Jj
         0Fo42AAnqZP0y1N+6ZdsOPwSYhY0ayKHNj2luFNjz2GdzSTbRB7Dmj2aS68++6a9xnTr
         IQ+dtkNF15w2B5wEBWiI909abriRzxS8nzKtYBb22Yam6biBmCcRU54FrfZjgL3vJEaC
         YRvSgdZTRIc+t3cGqMX0cHIu602YCxPdCGFUoOc4RnneXxJ0pE6TQa1hWXKAMROtIXIz
         mgtNPCNOUhZKgbRk6DR1hh8KBiuibJueFP0w4s2DLAQ6l9RT1ptlAbdWxZGo+Alhp7KV
         uxgQ==
X-Gm-Message-State: AOJu0Yzv0p+dwijvkS2Xy29qS4JLsn9iixt0raFqPe4gMOfOIVGJmsC1
	apTtAm7joN6eRb5cuMW7/0/Tdc4OVb/wSFm34nE37r5NxvRfgCsNOq/Quvlmw53HFiwTw3ilSCH
	0VBY=
X-Google-Smtp-Source: AGHT+IEb2MxQ+ESPxXT+VbVeIP/Bp6JeRV85ENyZPvnZtnTC/9zndfunvetaEScWX3xjPKU5h5ORng==
X-Received: by 2002:a17:907:a07:b0:a9a:f19:8c2a with SMTP id a640c23a62f3a-aa20763b09amr749741466b.6.1731687380993;
        Fri, 15 Nov 2024 08:16:20 -0800 (PST)
Received: from pop-os.. ([145.224.90.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e0452a0sm192151066b.148.2024.11.15.08.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:16:20 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf tests: Make leader sampling test work without branch event
Date: Fri, 15 Nov 2024 16:15:59 +0000
Message-Id: <20241115161600.228994-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm a57 only has speculative branch events so this test fails there. The
test doesn't depend on branch instructions so change it to instructions
which is pretty much guaranteed to be everywhere. The
test_branch_counter() test above already tests for the existence of the
branches event and skips if its not present.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/record.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 85d512f5a126..0fc7a909ae9b 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -231,7 +231,8 @@ test_cgroup() {
 
 test_leader_sampling() {
   echo "Basic leader sampling test"
-  if ! perf record -o "${perfdata}" -e "{branches,branches}:Su" perf test -w brstack 2> /dev/null
+  if ! perf record -o "${perfdata}" -e "{instructions,instructions}:Su" -- \
+    perf test -w brstack 2> /dev/null
   then
     echo "Leader sampling [Failed record]"
     err=1
@@ -241,16 +242,16 @@ test_leader_sampling() {
   perf script -i "${perfdata}" > $script_output
   while IFS= read -r line
   do
-    # Check if the two branches counts are equal in each record
-    branches=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="branches:") print $(i-1)}')
-    if [ $(($index%2)) -ne 0 ] && [ ${branches}x != ${prev_branches}x ]
+    # Check if the two instruction counts are equal in each record
+    instructions=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="instructions:") print $(i-1)}')
+    if [ $(($index%2)) -ne 0 ] && [ ${instructions}x != ${prev_instructions}x ]
     then
-      echo "Leader sampling [Failed inconsistent branches count]"
+      echo "Leader sampling [Failed inconsistent instructions count]"
       err=1
       return
     fi
     index=$(($index+1))
-    prev_branches=$branches
+    prev_instructions=$instructions
   done < $script_output
   echo "Basic leader sampling test [Success]"
 }
-- 
2.34.1

