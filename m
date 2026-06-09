Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF43FF8BE
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016043; cv=none; b=KMnDKoa/rbt7zLkIbMzfjMALpLtRGPrhp9j7ZVL+8GxYde3HGhbpXilcZR822vSjqQRja1bFe8HcfDGFcQ7a5s0c/oahGtGsE7jWBKQ6De0NCCsEagBlapIPOsrcA668MVyRVyBcf/2AILLLCrimXdgR6/gpD17M5zLeWjY6we4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016043; c=relaxed/simple;
	bh=mQidedvPEcBiOBRv8PmX5mxZNEPoVdc1Pz6VHmtCWcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NDpMMwFIkCIC01ScdFDulXg/EU98F9LE/SD0FYsnNcLWrJZrGG10chVw6j4UmDhIb2ALMxA8VEoZ+rsm1CPiFs3oyC9pTLSqVhqOh8NokD7eqkgTStscc5F5F08wVEf3p5fGdp5impX2Pn/Ak9cO/Jrjki4JoJB4gWQ8A286HNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n3ClWf57; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n3ClWf57"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490abf12f0fso29634885e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016040; x=1781620840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0r3qOldyDbGy8/U7IZ1oQnEHZB4wfLaYDHPrqBV1zp0=;
        b=n3ClWf57sd5PkLtEZktzo7G7Ha3uasTL9ORuakvy7SlhxFphoGFmEHhVdkT6F3/NFk
         9HWTCh+Lb6AqfYU6OlNvQEYRrNl53croXyykBfwjldoXRp3zXbJr2Tmi+wKdamqUgiFz
         1FPyzgDPcKqJMmIaXpL4BgkZbmhZPYSpCrpp9oqhrwLtcNdnPAg5JDLgdDI4hcJMszUB
         OnX5LyDD0+HPlyWC/A+cRYhJpfvlWet99GGL6vOqxQnmRd8xRyJK4MQrIVYov9N22vVS
         EITnEBdlH5hxiDZ1QvW0eBhSLQoItoALlR1ZVkXe3DCcMIYzpV9NgSrHxoN8DTwmk6gT
         8Skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016040; x=1781620840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0r3qOldyDbGy8/U7IZ1oQnEHZB4wfLaYDHPrqBV1zp0=;
        b=DbaFo7mDdW2VUxOQxc6u8rLHuLQiCM9McZoIV4OgulIKbRxzPDVWMRMUZISvv/Ekor
         D54msgcpsDADtkwpI5S/rfhvWFpQpsQ0tPJw1SnMLj8Hv86GPtSR9+Tp9dmwd6YKaaA0
         h0nVkitgL2ZedIwnPMasr8/mUHPbcbsDFqKa+FWO7FN1fQNA7C2/8+4Mx9rV0fw5EKy9
         QFl2ZfotpN3SUQ6DttA6tx0WPcEFEVIMh6tEw6jFvrFr3xGTd/V+dy0jQuh4i32E21WF
         Z69t6Az8y+L4ieBk6Mv5OdpQVXdxFw7Wimz4Ap4u6/iM4D1XDLwbTwRsfGAA2f6WE2UX
         TVgw==
X-Forwarded-Encrypted: i=1; AFNElJ9+sLGVt8LG4J6X9hdVr7vFIyJ0X9rbD2wS/YY0glWdSyNA+rZJCkUP6WAbeGmhDWhBjMMTts40oB0d5MfFXs66@vger.kernel.org
X-Gm-Message-State: AOJu0YxT0xvlNSyT/q4PblHvWvM06WYQgaVvHvdOeMWBKmrfF6T1ubwZ
	wYPXf1Bl9lgQcsI+j0yE8CmKN+N0wYpoKMFrUtxCbMARlYFYmu7F02G24D6SrtOag3g=
X-Gm-Gg: Acq92OF3WjhldBHmf24GCPdxX/AWQOWMEWNEeLDRr2HFC1RX65t4ZtLYI3eo/L1m6IE
	9NEZkfNWY5nJobTHjy/fxt76IDhVhpXV3S+Tm51+4SjgxVjDDZXiujd77GzZo/9GDWlWXwW23xf
	Ww/tsZ9v0s/F02eslYtpm7d+ij8ZzMO9NsGboYKqXRxXbpGZwT4CGUQMjYcDBVFqtUAJXAST4JV
	a/SoZzbQR/VISvxOADixC+CoxtDm1nh2vZHqOG/sa5P58Sd3FhAF2qS3uiDD2iVliTK20X4v5NN
	y1C4MGEi3UtDHlDhvzTqRL/Ax2sIwP99WeTkwWVIl1fgjqsLYiQ7CTg57vt1fMSojBSZXKzjoIj
	j96hPS18m0eUWTxTP/SQdTv8VphFnzkWRchopFF9+h7Xq2nFq7r6rPo2D0PyMDwyWMVIAJ9jBn3
	Q4w3Dr7RgLhx72YzDXdZKHG7DQ/uXbRCDgTGh3Umye65k=
X-Received: by 2002:a05:600c:8519:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-490c2d0e9a2mr256116745e9.13.1781016040481;
        Tue, 09 Jun 2026 07:40:40 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:39 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:40:17 +0100
Subject: [PATCH v5 12/19] perf test cs-etm: Skip if not root
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v5-12-d53a7d096a19@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Use the common idiom for skipping tests if not running as root, which is
required for these tests.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh        | 6 ++++++
 tools/perf/tests/shell/test_arm_coresight_disasm.sh | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 39553702c1f3..8ed2c934c87d 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -20,6 +20,12 @@ skip_if_no_cs_etm_event() {
 
 skip_if_no_cs_etm_event || exit 2
 
+if [ "$(id -u)" != 0 ]; then
+	# Requires root for -C and system wide tests
+	echo "[Skip] No root permission"
+	exit 2
+fi
+
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 file=$(mktemp /tmp/temporary_file.XXXXX)
 
diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
index 0dfb4fadf531..339ae4831868 100755
--- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
@@ -42,7 +42,7 @@ sep="\s\|\s"
 branch_search="\sbl${sep}b${sep}b.ne${sep}b.eq${sep}cbz\s"
 
 ## Test kernel ##
-if [ -e /proc/kcore ]; then
+if [ "$(id -u)" == 0 ] && [ -e /proc/kcore ]; then
 	echo "Testing kernel disassembly"
 	perf record -o ${perfdata} -e cs_etm//k --kcore -- touch $file > /dev/null 2>&1
 	perf script -i ${perfdata} -s python:${script_path} -- \
@@ -50,8 +50,8 @@ if [ -e /proc/kcore ]; then
 	grep -q -e ${branch_search} ${file}
 	echo "Found kernel branches"
 else
-	# kcore is required for correct kernel decode due to runtime code patching
-	echo "No kcore, skipping kernel test"
+	# Root and kcore are required for correct kernel decode due to runtime code patching
+	echo "No root or kcore, skipping kernel test"
 fi
 
 ## Test user ##

-- 
2.34.1

