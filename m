Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899892BEC41
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817940; cv=none; b=Bd+oA/zzBJkmAxrzDKRHz5nCN7FrCaBisysWxT+f8rTcYa1I7bFv+UNOqOCnMjOHP1TYxay1tuopArTk4RcmzD+Bs3l4C4CItUGVPaH42o/Gezljs023mXAgfgBO6rTXkGHvUb5JamuKPZ8f4XMkTN0NcmrR/DSFUz+KSf9RHk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817940; c=relaxed/simple;
	bh=ABbYua5BR3/xyb8DnooUzvs5L17xzguh4+jQNRu1w1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A/CFRr2FO0TRfAmFQdfFce9L1VhTQ/I6NBGhhz/C2xqfCM+pvSR0Lvan9e7JRmAgqAP6s+DUHA/8R0GttrXhLV9Q2mUOpGCschLwo8GvKRWExElevMuVbjTgukNOmw6wajpBiexo01K6baGMU+jwMb8DceiRiakVo/vC2mfHZbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fJvOaTnl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJvOaTnl"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so2048756f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 02:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768817933; x=1769422733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQboqiyM1bMVlCd/3rehrhWCEvcz3KFGOF/fcvtDHSE=;
        b=fJvOaTnlTa8fYLDTjpS3h6X/dOTo0rq/UvMdc25d4DE2uMEBFfZkXKDHTQhZtekoDJ
         1d4hi7C6XUCmjP6FJLbQY0aU5S7/5Yybra6ehZojFeAFQyX3J8ODKGhArhVihlr+o+33
         KWMZd/lYFuRvX3A5Re/pThNo19sVuuWkml8NzXHVUApgUUkblwzSKsTST9DVu3xK53k1
         bxSI34LGBRsHH4nGZOOBKPvMilTqrSqtkYNl5l43sps0ky45X3+YAcCHNiIgbwlx9wEH
         bVN60+f/SUBun+7mm+zJ7pBddHC9XElXO/1NKjljyyi8vso0zOutHD+L0YQv10GwhJVV
         C+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817933; x=1769422733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rQboqiyM1bMVlCd/3rehrhWCEvcz3KFGOF/fcvtDHSE=;
        b=shLHR6kc3dCFhsNyfb7k4K7inlJNrwYRAiF2miXBPqIeftqISxM0VwtOVHbQ9sOgIM
         XM6s/wJM0YwT7ZeX5vJhWsBXIfE3gq8Bxw+ENeBjH4Enia4Lv61yykh/etQ1ZRgVf7N7
         OlNUtsQeU+gWVK8I8xy8JTaWUnRP7oLq2XaWw/nv3C4DbuhNjvZ7VbziTRA76M2XHjyZ
         yHab+HXaldGWiax2rS7VBy6PmX3P/6EOUu1V+ynORF49oK75kkCjoNjkhVQUGE0bK7tP
         R2r24cG1/L3cJ0VhcTJ8ulN0dYEaki/JUmW1qB/VfCDHP1m2fDRA8Y5ONNWK93pCYpnL
         5iiA==
X-Forwarded-Encrypted: i=1; AJvYcCXVKjjvOM7WCHJmlzVY9m9MKDtqf3aMxbnYFaaY2/zXDQdirV+ejMEx0re8ug/+HLBUgYpKelUkGyM0yzFXGby+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9v0rrNJYVSn5kHN6wzck30wdYh+hvUctQYLEdX5ve+2cdc2Lp
	YZPUuNoKurO+cU2a3e92Od/8jPrj0IdCtGdSUo24DwAR/GpIQMay4CPtXp26iuLmZJY=
X-Gm-Gg: AY/fxX5RJ0dLPZVYFtIiJ9DKrkwq2JgxU5+gfM8l9k0yaRyGJsO+f7Z0/jkv8gb1oI2
	MBRbU+kvZo3vD2Kf1J4GA1MTc3q/Ks3cEjnKffogRMSADdN+oDH4GEUGTTS64jB/TppYinFd7uc
	fWqkCZGr4T7iDW/fWloLUCn10rJjdJ227aBQW6htBnEIEpBfpDiM4ydqcxnwk32mzAYxPZRQkaO
	12DI2aveedEzDE1DxLky40kLAt+kOT6wvo7u0xICFx0TsmxwjACbxetgl29OEWHR5u0YU11SDBN
	Tl4myfkjjxebH1DVWRUSu1b/kuNuVA3Is1/NqCQPvtILUAjBqFP49ZhQ2qukgssctjkokL09YtD
	1M7yvyVYm9tMkk/GNMEA6R2yIzcG0sxGjKhN5AVHiOAXcCcCLVaj3ROG4b7YLve0c+uYAhUiSkY
	AAMzHDAIIh6VSpnBtvsFd7vcAbBPFAO9w=
X-Received: by 2002:a05:6000:288c:b0:431:2b2:9629 with SMTP id ffacd0b85a97d-43569bc7d95mr13515115f8f.51.1768817932877;
        Mon, 19 Jan 2026 02:18:52 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6cdsm23286150f8f.31.2026.01.19.02.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:18:52 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 19 Jan 2026 10:18:36 +0000
Subject: [PATCH v2 2/2] perf cs-etm: Test sparse CPU maps
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-james-perf-coresight-cpu-map-segfault-v2-2-56b956a629ee@linaro.org>
References: <20260119-james-perf-coresight-cpu-map-segfault-v2-0-56b956a629ee@linaro.org>
In-Reply-To: <20260119-james-perf-coresight-cpu-map-segfault-v2-0-56b956a629ee@linaro.org>
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

