Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212899;
	b=ENA6QPlGxMorVVx3WauEwUT/O58x70NzLvF2NrezSbalvxvhYFk/vvyfaYgUEAhE8CjA
	 OIcjPGCH9o7U5USHksiQ/wYhw7D3sjIkD0eqn8vsm5YfACMAM5BCqm4poDQk9sUUhSbN9
	 7klowOOzii8/NEZm4XqcSHSak/OTvXVJrF4O+RvDZQ1IEsOjJjOfJmgwO/ojPajPSvGBE
	 B7p2a5SeEOkTkunpcsg5Cw2/OXnc8q5IOCAWemIeRNhdRv6vldsGcwwPJvouU4yTnFc7O
	 CSC2GgLx9aV//f0XF/HIUD6Yx320FSZCY9twWEHXc57kebyGDta832Wc7VdLLOhmtCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=onQwmUARv02AR/J2lTtspXZDSvOwK37l22aUUc3GeZQ=;
	b=ku9A3EJ97VBKMu28CLU6188Wlb4iyo7scUxFuM+p3Rg+Xhn/yXEUP0YdxO0db77izwU+
	 El9pA7ubUhQyJSOhMYqBjlcHWkZJD8liwL87IIrIrUBNGL99mWaITIKx37KTlObmK/FGw
	 /+7Ewje7c7i/QXFCgpHj+EgRjdYW36Ck0DwT1eyqXj2zmfvLnHkRe544IqifvBjbxa1PN
	 UYanGwnQsBIIqakzJPbcYHpwFes24Nsu2yoXLRGBRQRcquUy0InVrD+NM1TWTw/7M6p7G
	 AvlvM+PrjZV9KQksAY++RB5F4400xvuhoGNKyoDGrICBOBrycdYd1XWCorM49A2c46w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CXIw89G5;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378F606A6A5
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B378F606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CXIw89G5
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1769803eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212895; x=1795817695; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=onQwmUARv02AR/J2lTtspXZDSvOwK37l22aUUc3GeZQ=;
        b=CXIw89G50moESDbUUboShdOMONskBGnIFJ9w0uoM30vUwj6G0Lha6A7xO2tp31Be95
         68WzdDFp9U5xUuon9ptKOUunbnOhNsRjKN5sQ3NfUKvK24wSf4XsTCgfhyKQD9LP2LqL
         I+gvTyMdj276662yj3rZkMnEFu0oYXqOjfflG+7BlP7sleFxq34DRkft+srCVO4lvGjK
         k5aA9E6YHyxteXigSlDr1SD0Vl+4gv132FnzBCelyhRUBB7jNJgkp7oQ75tX8+TXGrrW
         +yP4wkAUmDhCGCq/Yyj0yKt+9ZZ+HhWs+bsxYuZk+yquo3+XjounAwRYTRURH6jJUINi
         rjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212895; x=1795817695;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=onQwmUARv02AR/J2lTtspXZDSvOwK37l22aUUc3GeZQ=;
        b=ecqyP8Mfo0ok0VEKcvJEXUP1YkfbCQUfBfUZrwEYU9MaPOQxqIx/0tleBit+AhMfqw
         qQEuO0ydQ1Nc2pujc+kcPGL+rm3p+W5AWPlFwSDI2d2MicM1/lTuToIgON7Le847Fy7N
         LUVUjv3l4iH/BcxCuprmLlWIhAN9YRiP5rwMN4YQL3178m85FI1Hewj8DmiXdwl5N5UY
         Sn6npHRg39PWXTJO0gSS/e2tKPcoAno+LskF10ERTwFd3IoDqINQaJE521963zo40UTC
         czsKVpLAHGb/bJoZ2UsYJkg3+h8OKYLH8l9lPCGXs0eeBu5HenEf3Y7bzP9NC7q9cpa+
         DbSQ==
X-Gm-Message-State: APuU4Z+aTpHKfmXpP7ajvA7CAG8nEaR+Vt0CmxP5vGWWNcIyv+MNFrDH
	47Rx/Id8/xnQ9LM9Ph4afg6ZFho5dAQKtglKkR+1Scz5efIMHoGv6pF/dhDZvAvjCq1dkx5p281
	qpPLDhhe7xg==
X-Received: from dycw22.prod.google.com ([2002:a05:7300:2156:b0:342:c2e6:20f7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e9ce:10b0:385:2564:c509
 with SMTP id 5a478bee46e88-385700541a6mr4874375eec.24.1795212894507; Fri, 20
 Nov 2026 14:14:54 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:17 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-17-irogers@google.com>
Subject: [PATCH v3 16/30] perf test: Add CPUID matching tests for other architectures
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Test strcmp_cpuid_str() for the ELF machines other than arm64: exact
matching of the test and common tables, x86 stepping specific and
stepping optional matching, PowerPC PVR matching, conversion of x86
and PowerPC HEADER_CPUID strings, and regular expression matching for
RISC-V and s390 CPUIDs, where RISC-V's hyphens don't imply an x86
stepping.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/cpuid-match.c | 81 ++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tools/perf/tests/cpuid-match.c b/tools/perf/tests/cpuid-match.c
index e3d4a349f393..0231be861ebe 100644
--- a/tools/perf/tests/cpuid-match.c
+++ b/tools/perf/tests/cpuid-match.c
@@ -36,8 +36,89 @@ static int test__cpuid_match_arm64(struct test_suite *test __maybe_unused,
 	return 0;
 }
 
+static int test__cpuid_match_exact(struct test_suite *test __maybe_unused,
+				   int subtest __maybe_unused)
+{
+	/* The test and common tables are compared exactly. */
+	TEST_ASSERT_VAL("same", !strcmp_cpuid_str(EM_NONE, "testcpu", "testcpu"));
+	TEST_ASSERT_VAL("different", strcmp_cpuid_str(EM_NONE, "common", "testcpu"));
+	TEST_ASSERT_VAL("no regex", strcmp_cpuid_str(EM_NONE, "test.*", "testcpu"));
+	return 0;
+}
+
+static int test__cpuid_match_x86(struct test_suite *test __maybe_unused,
+				 int subtest __maybe_unused)
+{
+	const char *zen3 = "AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]])";
+
+	/* Stepping specific entries. */
+	TEST_ASSERT_VAL("stepping match",
+			!strcmp_cpuid_str(EM_X86_64, "GenuineIntel-6-55-[01234]",
+					  "GenuineIntel-6-55-4"));
+	TEST_ASSERT_VAL("stepping mismatch",
+			strcmp_cpuid_str(EM_X86_64, "GenuineIntel-6-55-[56789ABCDEF]",
+					 "GenuineIntel-6-55-4"));
+	/* The stepping is ignored when the entry isn't stepping specific. */
+	TEST_ASSERT_VAL("ignore stepping",
+			!strcmp_cpuid_str(EM_X86_64, "GenuineIntel-6-(97|9A|B7|BA|BF)",
+					  "GenuineIntel-6-B7-1"));
+	TEST_ASSERT_VAL("model mismatch",
+			strcmp_cpuid_str(EM_X86_64, "GenuineIntel-6-(97|9A|B7|BA|BF)",
+					 "GenuineIntel-6-55-4"));
+	/* HEADER_CPUID is "vendor,family,model,step" in decimal, model 85 is 0x55. */
+	TEST_ASSERT_VAL("header stepping match",
+			!strcmp_cpuid_str(EM_X86_64, "GenuineIntel-6-55-[01234]",
+					  "GenuineIntel,6,85,4"));
+	TEST_ASSERT_VAL("header ignore stepping",
+			!strcmp_cpuid_str(EM_X86_64, zen3, "AuthenticAMD,25,33,2"));
+	/* 32-bit x86 uses the same comparison. */
+	TEST_ASSERT_VAL("i386", !strcmp_cpuid_str(EM_386, "GenuineIntel-6-55-[01234]",
+						  "GenuineIntel-6-55-4"));
+	return 0;
+}
+
+static int test__cpuid_match_powerpc(struct test_suite *test __maybe_unused,
+				     int subtest __maybe_unused)
+{
+	TEST_ASSERT_VAL("pvr match",
+			!strcmp_cpuid_str(EM_PPC64, "0x004e[[:xdigit:]]{4}", "0x004e0200"));
+	TEST_ASSERT_VAL("pvr mismatch",
+			strcmp_cpuid_str(EM_PPC64, "0x0080[[:xdigit:]]{4}", "0x004e0200"));
+	/* HEADER_CPUID is "pvr_ver,pvr_rev" in decimal. */
+	TEST_ASSERT_VAL("header pvr match",
+			!strcmp_cpuid_str(EM_PPC64, "0x004e[[:xdigit:]]{4}", "78,512"));
+	TEST_ASSERT_VAL("header pvr mismatch",
+			strcmp_cpuid_str(EM_PPC64, "0x0080[[:xdigit:]]{4}", "78,512"));
+	return 0;
+}
+
+static int test__cpuid_match_regex(struct test_suite *test __maybe_unused,
+				   int subtest __maybe_unused)
+{
+	/* Three hyphens in a RISC-V CPUID regex don't imply an x86 stepping. */
+	TEST_ASSERT_VAL("riscv match",
+			!strcmp_cpuid_str(EM_RISCV,
+					  "0x489-0x8000000000000[1-6]08-0x[9b][[:xdigit:]]+",
+					  "0x489-0x8000000000000108-0x91"));
+	TEST_ASSERT_VAL("riscv mismatch",
+			strcmp_cpuid_str(EM_RISCV,
+					 "0x489-0x8000000000000[1-6]08-0x[9b][[:xdigit:]]+",
+					 "0x489-0x8000000000000708-0x91"));
+	TEST_ASSERT_VAL("s390 match",
+			!strcmp_cpuid_str(EM_S390, "^IBM.209[78].*[13]\\.[1-5].[[:xdigit:]]+$",
+					  "IBM,2097,705,T01,1.3,002f"));
+	/* The whole CPUID must match. */
+	TEST_ASSERT_VAL("partial match",
+			strcmp_cpuid_str(EM_S390, "IBM,2097", "IBM,2097,705,T01,1.3,002f"));
+	return 0;
+}
+
 static struct test_case tests__cpuid_match[] = {
 	TEST_CASE("arm64 MIDR", cpuid_match_arm64),
+	TEST_CASE("Exact test and common tables", cpuid_match_exact),
+	TEST_CASE("x86", cpuid_match_x86),
+	TEST_CASE("PowerPC", cpuid_match_powerpc),
+	TEST_CASE("Regular expression", cpuid_match_regex),
 	{ .name = NULL, }
 };
 
-- 
2.56.1.750.gf70dc682cf-goog

