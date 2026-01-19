Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862033EAEB
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817361; cv=none; b=lajWHFHOvhhzh3uoUFyOEiR/1TomvAntPeaYVPIXZLW2xNWg6FugPE+fykplG6SE+U9//hXL27Hv8wWxJNjkIZ2ibRDhI5LVeLZYNVsUu3OptkUvr7IPLik2hOftW18y2cVG5RgJpP7PsQPXpN1kmQTv4mh99YshrhMadGAlPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817361; c=relaxed/simple;
	bh=ABbYua5BR3/xyb8DnooUzvs5L17xzguh4+jQNRu1w1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GCdLqX9sH9gXXdHN2Od0FxW8hIteUrTyKq9v+OrjZ3wyvxPw7sb95oiAwEdeND95YpuNN4levxSYOrZqapEcqJ1v1ODlmlD5/wFsjGmgfxxWhhDpGZeznAJTqhd9Y9bfcEdgwtlVfbw052DT0dVbyDMCLBRGnj1Jm2rEjBkd7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZTKQwywz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZTKQwywz"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4327555464cso2024852f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 02:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768817358; x=1769422158; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQboqiyM1bMVlCd/3rehrhWCEvcz3KFGOF/fcvtDHSE=;
        b=ZTKQwywz6zxuf1QnuB9xvP/hH/Kk8+zYtRY63AnmEXudZ5N7Gr770ssIZcOM8HsEHB
         Q0s63fqXbkOm8aP2va+2RCGwYbRM5Mx+IMkHTEEmaR4NxY2NbOPPRuor0/NLVqTN3H0Y
         GQTDVQrKvO4nRqTm/BU+CB0xBWdCZ3z2rNOPefoqwVLbr/zFpThjz42kxkTL2tAAvKUI
         3nDUY5Mw0UO3wwwITfmhVy0RfvNYr368zer6SJPy/7LwTuFIkjHd/I7XDrw/47Wrn1Gp
         DvPEEgXpsl+C/D7mPCwTcAs7d43J6BvS3KldoCkCB3QHP3TcW8nllIsDVEVqkGXQaSDr
         9tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817358; x=1769422158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rQboqiyM1bMVlCd/3rehrhWCEvcz3KFGOF/fcvtDHSE=;
        b=vZaKzaaSw8m8CyTWeAHM2/8MKeMwLXbByzZReMy/E7qedVd+UmjAT62AYQ13wlk0os
         dfR/NvIBfhVZuXxwX4sBoXsZXDDNUfukHfh6AFpP1iU9IlIFIzF4N9xYEsYW5ZqqQy1p
         Z79RP2ts37AhKm99wqlx4taT34Gh/p1xG6RalDPNtAi8xTXRq76lSqwaiUWDv1dblbdw
         bmU51GCFvHsmMNZfd8Lkp14IuIim1GRHHwljtM8oj7m8jNR6eawObU/9UeCXvlAVnfzC
         omfMmojf+hC35RyaD/f9nUzlSQbXpPU4mrSLXh5RN4Kox6B8XrCpbo6cPGLBq8eB3YNJ
         yrDA==
X-Forwarded-Encrypted: i=1; AJvYcCWtUI6VDbtJ7rBztZJNSF4w3gDiN1x9IlkzCuSgBBZVecZmcznWQVFjyXJjxmhcCLf4YyZjYc1wzqkHuWCkcB01@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9MiAVVF5AEDjZWoR/7s2aj1umOyRZdHjYAoahABw+T9u4KXln
	j2IGqv7BAeRfp1Gedu98zz7KDTihyuO+O234NoYxd0J1o+wHXat27Cwj9XqgsgLWzyk=
X-Gm-Gg: AY/fxX67DiPnkyPtUsiBA7SIBHulZ1BCwbTEBeeAwq2CILHS3wKchkZpfpxeAJgMIlD
	YskBQXHtR2mmPkkjVF9YnWMoiQuQExV2wMDr/UZQdMnxf5RWc9C8Sg3lqZcnX4/49L/C9om7Vqr
	7lAAgnKS4mPFo5o6hCM0FAg8zhfee/rjIdBRDjnELZyMse2+5zbBKr0M79zIrLf1D9AvrXYah0C
	96+O/ChUwnhN9fs6ylxiHw3AGKtHRtUhIFCy7hJNVOVU7MhsJpcMhEl/zbrm5Av5tc56T3EWd0g
	ikzmJNo5tsVhu6VbBqzEVN5CI52oJ2gxCoiBX2NWUPzYXPULpCWdTZXizPfuWSu5yahilDBD/Y+
	ii0wZyTpxqLGOr1OIX2VPg/rh0POaSYVwmjSH4ARSdvdvP9sFJnFd0C3doDRcm2lXY8ZHkuzIyc
	tW9CphIjURF0wKxRyLI//r
X-Received: by 2002:a05:6000:144b:b0:432:586f:2a9d with SMTP id ffacd0b85a97d-43569bbffa4mr14213616f8f.32.1768817358124;
        Mon, 19 Jan 2026 02:09:18 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6cdsm23234802f8f.31.2026.01.19.02.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:09:17 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 19 Jan 2026 10:08:17 +0000
Subject: [PATCH 2/2] perf cs-etm: Test sparse CPU maps
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-james-perf-coresight-cpu-map-segfault-v1-2-a9cfd67653ae@linaro.org>
References: <20260119-james-perf-coresight-cpu-map-segfault-v1-0-a9cfd67653ae@linaro.org>
In-Reply-To: <20260119-james-perf-coresight-cpu-map-segfault-v1-0-a9cfd67653ae@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Thomas Falcon <thomas.falcon@intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

We only currently test with default (all CPUs) or --per-thread mode.
Different permutations of the "-C" option can affect decoding so add
tests for some of them.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 54 ++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 1c750b67d141..bbf89e944e7b 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -198,6 +198,58 @@ arm_cs_etm_basic_test() {
 	arm_cs_report "CoreSight basic testing with '$*'" $err
 }
 
+arm_cs_etm_test_cpu_list() {
+	echo "Testing sparse CPU list: $1"
+	perf record -o ${perfdata} -e cs_etm//u -C $1 \
+		-- taskset --cpu-list $1 true > /dev/null 2>&1
+	perf_script_branch_samples true
+	err=$?
+	arm_cs_report "CoreSight sparse CPUs with '$*'" $err
+}
+
+arm_cs_etm_sparse_cpus_test() {
+	# Iterate for every ETM device
+	cpus=()
+	for dev in /sys/bus/event_source/devices/cs_etm/cpu*; do
+		# Canonicalize the path
+		dev=`readlink -f $dev`
+
+		# Find the ETM device belonging to which CPU
+		cpus+=("$(cat $dev/cpu)")
+	done
+
+	mapfile -t cpus < <(printf '%s\n' "${cpus[@]}" | sort -n)
+	total=${#cpus[@]}
+
+	# Need more than 1 to test
+	if [ $total -le 1 ]; then
+		return 0
+	fi
+
+	half=$((total / 2))
+
+	# First half
+	first_half=$(IFS=,; echo "${cpus[*]:0:$half}")
+	arm_cs_etm_test_cpu_list $first_half
+
+	# Second half
+	second_half=$(IFS=,; echo "${cpus[*]:$half}")
+	arm_cs_etm_test_cpu_list $second_half
+
+	# Odd list is the same as halves unless >= 4 CPUs
+	if [ $total -lt 4 ]; then
+		return 0
+	fi
+
+	# Odd indices
+	odd_cpus=()
+	for ((i=1; i<total; i+=2)); do
+		odd_cpus+=("${cpus[$i]}")
+	done
+	odd_list=$(IFS=,; echo "${odd_cpus[*]}")
+	arm_cs_etm_test_cpu_list $odd_list
+}
+
 arm_cs_etm_traverse_path_test
 arm_cs_etm_system_wide_test
 arm_cs_etm_snapshot_test
@@ -211,4 +263,6 @@ arm_cs_etm_basic_test -e cs_etm/timestamp=1/ -a
 arm_cs_etm_basic_test -e cs_etm/timestamp=0/
 arm_cs_etm_basic_test -e cs_etm/timestamp=1/
 
+arm_cs_etm_sparse_cpus_test
+
 exit $glb_err

-- 
2.34.1

