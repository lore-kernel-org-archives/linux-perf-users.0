Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC61FE45D
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346637; cv=none; b=feoOM4gaGZ7ZLwQ1YJN5qzZedw9mltIzcSyHiIkctsCZtgab1nw5ffBeE08A6TkyS1CLW27sJsCI3XJiMlhmrlS0PW0RvuXVJNU2mycLnEroSn7pSscG4s/EMv4kRI4CpIwSPqYZZIhwA/+lGZvlrfsH346pD1WGPHtb/kST49M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346637; c=relaxed/simple;
	bh=HJMe93LWOIndT8K0R5G7ezfVXY9GgrzNRpECoxcqcxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqfuFRS8QMkPhAeC8v1fmKCukzgezlzQZpfiy3pSUCZcQaPj3gSfG+mSzvwsV9EV1PUdSAJak8e5vKk++bEqhUvQ0hVdNQwvAp92BwojkkLKBPjXWDb2d9fnffMs2khW5UuOfFogZ5NTYd5jrRboB8/pODF77FCitlX1gfDp/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sjGj4xth; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjGj4xth"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43621d27adeso117031425e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736346634; x=1736951434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1j+BIbB70BfH6p+H3D0C/f2KwCH22I9fsAuqIEouAI=;
        b=sjGj4xthcnusiWMlxR/w5ooLBd6P+p2EOt6slHOKl8sr4r9wKcZAS2HSFE2LhQLb9s
         44vqhRMcOm2iuw7wl4u/mUjrw2zP579mP7+ExMYHcS8ZNhFo86QQpXcKuSeOtHH0rQoe
         QseyF1dlvPLMZCneXBkcNwgHUCUFHCPmtfYC7nX69Jz9hA57jDHZPCOwT9xLt3uhzctL
         Xm7MRXGmgkBU0IDgRx6+45k4Ab9M5NCzqMgJIqHrjTNzvaXhmnoIMiUm09nwraBOl5o/
         zDCoEuHG9w078mmoyQ/poLrt9V+5UwrdY/alyhpxr0RgF4g6+zN2IvHxhrNbasF5WpZh
         BhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346634; x=1736951434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1j+BIbB70BfH6p+H3D0C/f2KwCH22I9fsAuqIEouAI=;
        b=gR+9lRtnp5VnN9cXHvwCMF8Y6B5wIoOsxbilJhXuOn7VlfZGXl+6PUDbsU6F3tQJwC
         jum/z5PjZuTEL07m0q1DbOR4p+gCj3LbNJX+N1Bq1J56GoYOAy8e7NIfow1bc9l5i40V
         qRxft1doNIqxVMJ1xjqMdR88BSw6paz1mWXP/KCNNAIjqmxdv1eZisl3Y9VfZAGikFsG
         VeoInDr15dueYfqPTMw6FLMt9J08gtPj/lpieUQigQYbPnT7YhzDFOGDdi2T1Kb2/pCd
         4oYWG9JbA352GO2XAyONS2TKKarsAWrWk0utl250lQy0d7+yHzu3OKQmZP7fYmMQc5XX
         djsw==
X-Forwarded-Encrypted: i=1; AJvYcCXK8dmQbPlVzQhaYTU2k2NlV9w6n7vhK1yuoTAjN0Ieg1dfK1CnbrnllZ3r5fP3knIhcGB1/vrj+N4v94D2nIZq@vger.kernel.org
X-Gm-Message-State: AOJu0YyulRT0jX7thG1YLjOFwylVcq1VF/EqBE68RsfdFOfAQHhAZVXn
	HFe94zK7IO1IHqHKLxGOLwzaTyQ9LRXfm4S+vz/AytMjjpcSXi442l/vuj/CdcU=
X-Gm-Gg: ASbGnctv3cmvJ3D2jyhXgeWDQBc1y3J4J6QygAV42WjUM2kZdtSjW4Tb0E/WtSIriZq
	BA9YAuHfmMN3uUpWd/X+sp+D1Y37SuzOXgKn/0ALnQnCSaly7APbUWQz3cT2TYdTcO0xDp4lNWv
	ODgu0cw5J2Q2d/DQfeXGRwBgTa6dlMcNlaxtA8sPbEunJdzV+b1AgoJMZfs87pNt9UoYmekbhEK
	j62OMVM7LepqzVp3VOqwQ/J2ZdTNRfWOCbG3HQSN1UlWw7ClGdyKec1
X-Google-Smtp-Source: AGHT+IGPG2fbcdAWI2kWNuJul9oexF8hk5Ad1KOrWrlN7IkVYSCPH+BLbdTguMj87I9RIg+5zb7CeQ==
X-Received: by 2002:a5d:47a3:0:b0:38a:4184:2510 with SMTP id ffacd0b85a97d-38a872db629mr2716682f8f.23.1736346634083;
        Wed, 08 Jan 2025 06:30:34 -0800 (PST)
Received: from pop-os.. ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddccf4sm22836965e9.19.2025.01.08.06.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:30:33 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	namhyung@kernel.org,
	acme@kernel.org
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 5/5] perf test: arm_spe: Add test for discard mode
Date: Wed,  8 Jan 2025 14:29:00 +0000
Message-Id: <20250108142904.401139-6-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108142904.401139-1-james.clark@linaro.org>
References: <20250108142904.401139-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that checks that there were no AUX or AUXTRACE events
recorded when discard mode is used.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_spe.sh | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
index 3258368634f7..a69aab70dd8a 100755
--- a/tools/perf/tests/shell/test_arm_spe.sh
+++ b/tools/perf/tests/shell/test_arm_spe.sh
@@ -107,7 +107,37 @@ arm_spe_system_wide_test() {
 	arm_spe_report "SPE system-wide testing" $err
 }
 
+arm_spe_discard_test() {
+	echo "SPE discard mode"
+
+	for f in /sys/bus/event_source/devices/arm_spe_*; do
+		if [ -e "$f/format/discard" ]; then
+			cpu=$(cut -c -1 "$f/cpumask")
+			break
+		fi
+	done
+
+	if [ -z $cpu ]; then
+		arm_spe_report "SPE discard mode not present" 2
+		return
+	fi
+
+	# Test can use wildcard SPE instance and Perf will only open the event
+	# on instances that have that format flag. But make sure the target
+	# runs on an instance with discard mode otherwise we're not testing
+	# anything.
+	perf record -o ${perfdata} -e arm_spe/discard/ -N -B --no-bpf-event \
+		-- taskset --cpu-list $cpu true
+
+	if perf report -i ${perfdata} --stats | grep 'AUX events\|AUXTRACE events'; then
+		arm_spe_report "SPE discard mode found unexpected data" 1
+	else
+		arm_spe_report "SPE discard mode" 0
+	fi
+}
+
 arm_spe_snapshot_test
 arm_spe_system_wide_test
+arm_spe_discard_test
 
 exit $glb_err
-- 
2.34.1

