Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6D1C1AA5
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153992; cv=none; b=ufJhHGgP7SEUKyNqhzg1VFDMsvCMKUlu2hvPXFwkRGRtGEtAMxADqxkuuJV45S3HmJZET96fFZKK+ZIK14VpCQh1QlLfERo/Q7959c8ZaS0FK3M3BITsviG9PwbKhWtUMGfOKcR/VfGMDYqASOkrWqNkz+CJkcgWODGNENWrSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153992; c=relaxed/simple;
	bh=x8bv8lif16GzTLpb0Qa7Ebuoe1yqdxh/JFp2faINf78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bph2bZkeOWC8cG8k12osc86GhJLEK7J1nk74KOm+0Z0CVsYnhYuGoar4RCvN8z71F2OL5mm3tcXrJuzC24AVswZpsCJpfpgXH0FOkC4iUjTsydE/mblYcgemP5DgBtJ02YyS9J5pSNXkajNJuCWwWUhxBuF/YCVpTXDnDiGpg+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=psNuG9lt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psNuG9lt"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cc8782869so10258755e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153988; x=1726758788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnGEReYZbV5wa8QJ65oYyeLT0QeGyCwvGtl5g2ahPgo=;
        b=psNuG9lt/LcjzWW5r2j927onbXcIwEdTT8gYoPR3YpUPkc5z6MxWpR0hXNkJwgka1z
         Zhg3ZeEAXyUgnWZjax/vr2Ufz4UdUcv+T8fROmCj7VwIPrqKu5WD2q16wF0Cst2mB2kd
         3V0LXBRnhsmVr4uvfl37UCbggZVRRXSm8nWgGJ648VNfV89RupaH1OOhhPZQ4beOVYBH
         N+wuuqt6r8AQLZW3e4gk7GGE07DEWI/OPifxdBRKPORCRPNS/+NOsP367BsNbH+i0KMy
         t1JwJw7aT3wYBIKqT95GzZ2C7IJ06s/5CVzOM/3T+YKgkxwjNce7yB1xHrBpnTGXkE4d
         0n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153988; x=1726758788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnGEReYZbV5wa8QJ65oYyeLT0QeGyCwvGtl5g2ahPgo=;
        b=UYar8uRjM1pq04xPRa0R515xC/erXAYxoksIZtVJALRkNCaDA6pDvGIDzt6offEWj9
         AJu/gBW0y4B0ipkup1oHS0A/cIXD5a9nFYJiAESAnUSpHxcp/CBKNTz+SZbvQY3Ll/lI
         S0igJNo1Hm6hQrTomWNoyFxz8PBAg620Fs4u4nutpNHQ4X57RehInTBarh8THij9F9OA
         fM0IjtwPixiKtFA3+qxTNnfbgXpi/cO15jGaGWmrIsDCIaYlk9hGSya2nuW6jWxv6HlC
         I9O6h5+0qREDyt18IKtrxzQLrfB27cFIo3P7Sax87QRUdSf1g+iAyJWEWRcfPB17JZV+
         WOWA==
X-Gm-Message-State: AOJu0YwwlAsnb80C0kHEpgLpLCyS3zLeBsG4sCks1rTo8wNUWQylk+Zp
	whnaBs8OQ1HfdzVSosxhweVrAWGujFN5z6rRCvHd7T/1OB2c27iSRiBZvBUSZ96sWrFl6dmAz0/
	NHv3tLA==
X-Google-Smtp-Source: AGHT+IGEre2u3si5izHKSVRnSaDHslzroiOmPSj+IMte3J2/T8vsKx8fqveYcxg7jVPpnaPL6vVMvQ==
X-Received: by 2002:a05:600c:19c8:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-42cdb579f3cmr26940435e9.30.1726153987871;
        Thu, 12 Sep 2024 08:13:07 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb0dbcb6bsm171928845e9.30.2024.09.12.08.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:13:07 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	coresight@lists.linaro.org,
	leo.yan@arm.com,
	scclevenger@os.amperecomputing.com
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
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Ben Gainey <ben.gainey@arm.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 7/7] perf test: cs-etm: Test Coresight disassembly script
Date: Thu, 12 Sep 2024 16:11:38 +0100
Message-Id: <20240912151143.1264483-8-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912151143.1264483-1-james.clark@linaro.org>
References: <20240912151143.1264483-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run a few samples through the disassembly script and check to see that
at least one branch instruction is printed.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../tests/shell/test_arm_coresight_disasm.sh  | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_arm_coresight_disasm.sh

diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
new file mode 100755
index 000000000000..6d004bf29f80
--- /dev/null
+++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+# Check Arm CoreSight disassembly script completes without errors
+# SPDX-License-Identifier: GPL-2.0
+
+# The disassembly script reconstructs ranges of instructions and gives these to objdump to
+# decode. objdump doesn't like ranges that go backwards, but these are a good indication
+# that decoding has gone wrong either in OpenCSD, Perf or in the range reconstruction in
+# the script. Test all 3 parts are working correctly by running the script.
+
+skip_if_no_cs_etm_event() {
+	perf list | grep -q 'cs_etm//' && return 0
+
+	# cs_etm event doesn't exist
+	return 2
+}
+
+skip_if_no_cs_etm_event || exit 2
+
+# Assume an error unless we reach the very end
+set -e
+glb_err=1
+
+perfdata_dir=$(mktemp -d /tmp/__perf_test.perf.data.XXXXX)
+perfdata=${perfdata_dir}/perf.data
+file=$(mktemp /tmp/temporary_file.XXXXX)
+
+cleanup_files()
+{
+	set +e
+	rm -rf ${perfdata_dir}
+	rm -f ${file}
+	trap - EXIT TERM INT
+	exit $glb_err
+}
+
+trap cleanup_files EXIT TERM INT
+
+# Ranges start and end on branches, so check for some likely branch instructions
+sep="\s\|\s"
+branch_search="\sbl${sep}b${sep}b.ne${sep}b.eq${sep}cbz\s"
+
+## Test kernel ##
+if [ -e /proc/kcore ]; then
+	echo "Testing kernel disassembly"
+	perf record -o ${perfdata} -e cs_etm//k --kcore -- touch $file > /dev/null 2>&1
+	perf script -i ${perfdata} -s python:tools/perf/scripts/python/arm-cs-trace-disasm.py -- \
+		-d --stop-sample=30 2> /dev/null > ${file}
+	grep -q -e ${branch_search} ${file}
+	echo "Found kernel branches"
+else
+	# kcore is required for correct kernel decode due to runtime code patching
+	echo "No kcore, skipping kernel test"
+fi
+
+## Test user ##
+echo "Testing userspace disassembly"
+perf record -o ${perfdata} -e cs_etm//u -- touch $file > /dev/null 2>&1
+perf script -i ${perfdata} -s python:tools/perf/scripts/python/arm-cs-trace-disasm.py -- \
+	-d --stop-sample=30 2> /dev/null > ${file}
+grep -q -e ${branch_search} ${file}
+echo "Found userspace branches"
+
+glb_err=0
-- 
2.34.1

