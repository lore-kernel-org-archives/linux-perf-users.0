Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5123EEAD6
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015497; cv=none; b=nRHKPJUbVn9TiIrmtN1HODc/HPCIjnKe2mCSWaGDZCuM9h0fbapvYlMWwjX7CCUrCnWBWrzCcW2INufFT4f4+H3NHxE+txT1Pabqa5knXY2E4kT/iWVJDcmWyqD/G6/kDPyEuD0zXkS6N+OelwxE2NwLKLWduyyD45/LQLug34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015497; c=relaxed/simple;
	bh=mQidedvPEcBiOBRv8PmX5mxZNEPoVdc1Pz6VHmtCWcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EOiIQ+htM8BMzDiWmY72GS5BHc2fNYMqsnzL/0VUZz6gYuhl7Loax45kZcVMh6ggZmW/LCmdNKwBNXTUFQxwaCXPPPxPEkq5Ik3PW+Ovyft/lov+0IxlVcvia/X480cqUzI4jIdwF816z8H0ZdCAHr2+oeM4kMJQjsJ1NJGSg+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vLY+HYmJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLY+HYmJ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45fe59255beso2924209f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015494; x=1781620294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0r3qOldyDbGy8/U7IZ1oQnEHZB4wfLaYDHPrqBV1zp0=;
        b=vLY+HYmJlcGnm87H0fuCBJ3ha8WgkZ8pBkz9AyXsNyZr0qDUVtEmEyFhvG57VcKDAD
         VUt8GaZ/o1X8RAD63SW3DUIjBoq3l8+UxbJgw/q+unQPv401OLbs2LnOu98FlYlDCMyP
         VXLwgRAfTnxEev9dOyKSLGeZcfq3rX2EWbPAemtbMzMcQ1Yp/SArrreTlOKlDOjP2a9R
         gADW7w+nHCFQ/egUlPMMtpYTPHFWXPquAeC87ljaQtEuEQxtpwjrG/phvn25ci9kkehV
         U0VRUgctF3dqWAJls3Jz1pTVg6t5X07DZS5OcyVtH7XKh+f1GitroTH5fP2NX2ajT2Tt
         lhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015494; x=1781620294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0r3qOldyDbGy8/U7IZ1oQnEHZB4wfLaYDHPrqBV1zp0=;
        b=ppEgSs6vrSZifd9UNaYz/bk5jzRGKBoW6avTpbPR3lGKpqrvU6cL1RZFPEOfcRkp2G
         Nm6xyGK85vvLM17QfREzz+ee6k6VBfAyGV1mmBP83ZELorfYrJ+JUitODoI2GX0QAMK2
         6iAYoUKQ3loaOvd448RKx3PO7q6igziYilAXvlbl8qAzRryR/nXUyVhvJZomgyhVYlRd
         xN0jGBH6gFJC+nJZ09vQ981oJS1kIJL/mqLLS6uxxvG8rhMIEK/NJrkOdS8a69hCMjTd
         hQMnJot/R5AHHv0WM8+92eBCA5dIyrOHQJbPy2UgWXd28RQHwJEjj01c6SHNe/AVfqDT
         C4tA==
X-Forwarded-Encrypted: i=1; AFNElJ9cay5ZiT6X65ON4rEZC6hn6nVUvyix72R1Bnc+UMF0Xvdh0jvvq/b1kdepvnirmXz+HwjpsnebmML3vNnVUL2y@vger.kernel.org
X-Gm-Message-State: AOJu0YwqwC7q/TMZYtNktuTqU1w4PBwCe7k/3ZmbINmGZ9WUUdUMx6ob
	JNYbMzN9HPy1hmS3DKYVFrDdZglfkz6sfI/86K4uyJXqPhbi26uckPeky1TAbEd9Jhk=
X-Gm-Gg: Acq92OEjsnYIRFPOUx/38gRzmIfpmips2B2dnVrjSgOKSqhb4T67qGvsVksNepzZ8dF
	+txtu9b/rRIeYhqSPFUyHV7+lPL0jAewdW5yu0V0ZDYSAui3Ww7sTA5igZT3N5NOFwGslPq2tPf
	bPR160AD9SoOl4RZMfj713puujlGzP68Ouit9iv8WI5P4ofY45+Y665sXSSOoeGXCHyb0MPNiHg
	ulEBk0WOq/texjm/kYnmGesRuIT3UVVlb8R/3Cd9QUL+seuD4uOIMhK6Mq/FhnKU1rTPHbvfTv7
	6uz0eQH6lF8P853NRiH/I/lWQ6a1NmrS+Zr2BtyLSMwQYB4gwtSdNuEtG9ijCO4B7jSpvKeGhgL
	R0eH2qnft9aOqjyIcZv6PHhIBeyMmKOjg62aqY3b/OQBtZ59ibY8PDJpMDptE79dOP+IuylRDOM
	nU6epHmB+ud++BoZwlbJmphnIiCNVkxZQY8COGVhndG8s=
X-Received: by 2002:a05:6000:1284:b0:460:2d45:fe8c with SMTP id ffacd0b85a97d-4603063e7c4mr23189554f8f.38.1781015494464;
        Tue, 09 Jun 2026 07:31:34 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:33 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:31:05 +0100
Subject: [PATCH v4 12/19] perf test cs-etm: Skip if not root
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-12-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
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

