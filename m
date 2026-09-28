Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371E1322A1C
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557361; cv=none; b=FiM1RvlmGNDdpcw2OCfqRGlCDTcFXFMoqi7rxDvmW36KzIVL3tghKtuH8lHhl9Y9eGZm6tDuWQ2PNFXCbutdopobcunQwZap1U8aLBETNjvqRXAzTnCd8lJlasocFljBfTwsLWGS79ZCqSOQuibPbwKC14B3JFp7SvzAT8zZ35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557361; c=relaxed/simple;
	bh=l25+WiU144RGBRMkOv5IbjnpvOBERXMWI8BE5cGW5+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGa5seczxttCe6VYs3cPYUY3nF4FO7MUg0IFpWc+1AO3/Qaouyer8rlKoa25pqJQIeNlDHOWB/uX9QmvrD+6Z+g1xS1RT+GN1RcEYF0SxqKO9RLRxfKNb31TAlgyWNFfzBsfivm7J2BqKmPjxBAFIvRVQvvA4dzZYIQRLTzXkv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fObnAKfa; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fObnAKfa"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so1397844f8f.1
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Sep 2026 18:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557358; x=1791162158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rxbintdRsWyAeaZ3s1DbMkRkjMg6f+veSrku5GObMlo=;
        b=fObnAKfaDSadtvo5f23UNTVriDzgPbmfz8m4p8au+7kicVkR3klsS4snXmSG37NiBY
         9ey9L4RCJVwzrrXTAJK+4jRlyYKaTFSMC3nSXmFos15lRkl8S562o2OMH7sZZK1F9Q1S
         rXnW4Q9cx+uPEkqVhxDLu+RWpCWTW8YcmXChGf+Pvlb4tK3stqokE3yuCWt9MbzFb48E
         VAmNMHiMftyEbHHUIHLQrnQMu+CaurWrDgnHs05UnRRsNx8/OYaiovsrqycwI/UmK7m/
         c+pWJFZPvlSMBZAISEbAFdWPtS5G6xYnlPJJsiD2Yhp8sUUFJ5GqSUDTa/ceCbmhFoAZ
         F7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557358; x=1791162158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rxbintdRsWyAeaZ3s1DbMkRkjMg6f+veSrku5GObMlo=;
        b=vzkqO7tOSo5fVFxm26wUHEQ/06BCzoKzOflY/ZYgr2dHMnY6B8gayY5AD4E0jrFTyj
         MGub5fh/1mmRALMB758jynJwH3N/Nb1PnpmC8rCt2f+jhyJKFCcKmwmTkxZPKXrL+0QZ
         BSdmViNCpXHoAFnEv5C4ApPsfN3smpoUQdUhjgdyngdK5PJP6gqvAXcHLgYThmSu+1vr
         +6VajcQD78wkwsO/SiSMKG1GvKMtbLKJKOHQlF3vjuxw1osL2PCkD45EyLoVe3XP3BIS
         NMssHkjrA14JR4pgu2pEyrnUItMFnZMlAKOeWEGLE8N5EZuQcBHv0GUUdorvDRFM/6iK
         33Qw==
X-Forwarded-Encrypted: i=1; AKwUvByaI+QGItNVqcU68Mo25uT+aakWd1NleKLjLnqHFDlyzLbyMddb8xZy45Xf+HhkzIEuI0To7h82cmyH3HZyYmnH@vger.kernel.org
X-Gm-Message-State: AFuF++nxLjMKtJ1DsGt+l78gqIoAXZc/4NhRP+Z8ec5wMOwc0hIotFWt
	kiQeo8SQ2bFi/ZSokuqWXNFtPgP7t4JKlsu7R8p8flB+0j6O2F+K52Ji
X-Gm-Gg: AYBFou2W99NdpCplNFqTR09/ZeDT/ZkypK2ykDgrj+gCdKEzD4IodkxpXATYvb61aMZ
	6E5yoE34xyU1kvID6fpE7OgjE5OVN0IEGWn8i81zhcecu8qSGRlOfSqlY0Ej8wHqa89wilMnee2
	gcTh8Iklo0wjzqLdGa7k4eDywe2AU8/83H6ZCpicp7soSs65U0fVjvPikPr42jsYNnkur+4wjLp
	aDKgh4z/t+StugjROoQnlz79klAh2lqov+psokkYXGUsKdLKGVDE3Kd92EuE8R7jojgpD21f1UR
	oHb/qU3y+PTXRdhxrwikvD9HKuCdMkvd+xKIF4ihw9wzU+CTZRVMh1gzRWAxE1191fUl+vORzJL
	zRk6JqAk2wf1xC0EbVADaX780T0QajzMSgrgGu+W3roMEheEoEjJioPm/ikGHLcRKwZ84qJI6l6
	Fjg4CRgmb+V40OiHL4mOZgvYQnInP9BAURZgtCEyIRAiEg4nfb/k7qMpoCUYOoHPbRkNgLbhMF6
	uJ1vrLBeE0m7gOcaQWC1ZtEeixnTd3SafnfiiobCL0YeW0suGB0A4bh4KCjWXRuX7pH8Cm6NtWu
	J+mL8KPGd3Zpn1Jd+yQrzv0J+ICR9syNnuBWVdfv5IKwr+wxS9E=
X-Received: by 2002:a05:600c:37cc:b0:49c:fc6c:be03 with SMTP id 5b1f17b1804b1-49ff06ed91fmr126773505e9.26.1790557358335;
        Sun, 27 Sep 2026 18:02:38 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017652d1sm144207825e9.5.2026.09.27.18.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:02:37 -0700 (PDT)
From: Michal Pluta <michalpl2003@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] perf test demangle: Fail when demangling fails
Date: Mon, 28 Sep 2026 02:02:23 +0100
Message-ID: <20260928010227.1903673-2-michalpl2003@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928010227.1903673-1-michalpl2003@gmail.com>
References: <20260928010227.1903673-1-michalpl2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rust and Java demangle tests only log a NULL result from
dso__demangle_sym() and carry on, so a symbol that fails to demangle
doesn't fail the test.  Set TEST_FAIL.

Assisted-by: LLM
Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
---
 tools/perf/tests/demangle-java-test.c    | 1 +
 tools/perf/tests/demangle-rust-v0-test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/tests/demangle-java-test.c b/tools/perf/tests/demangle-java-test.c
index 0fb3e5a4a0ed..a8eb0f4effad 100644
--- a/tools/perf/tests/demangle-java-test.c
+++ b/tools/perf/tests/demangle-java-test.c
@@ -33,6 +33,7 @@ static int test__demangle_java(struct test_suite *test __maybe_unused, int subte
 		if (!buf) {
 			pr_debug("FAILED to demangle: \"%s\"\n \"%s\"\n", test_cases[i].mangled,
 				 test_cases[i].demangled);
+			ret = TEST_FAIL;
 			continue;
 		}
 		if (strcmp(buf, test_cases[i].demangled)) {
diff --git a/tools/perf/tests/demangle-rust-v0-test.c b/tools/perf/tests/demangle-rust-v0-test.c
index 904f966c65d7..ee4ddb61174b 100644
--- a/tools/perf/tests/demangle-rust-v0-test.c
+++ b/tools/perf/tests/demangle-rust-v0-test.c
@@ -58,6 +58,7 @@ static int test__demangle_rust(struct test_suite *test __maybe_unused, int subte
 		if (!buf) {
 			pr_debug("FAILED to demangle: \"%s\"\n \"%s\"\n", test_cases[i].mangled,
 				 test_cases[i].demangled);
+			ret = TEST_FAIL;
 			continue;
 		}
 		if (strcmp(buf, test_cases[i].demangled)) {
-- 
2.43.0

