Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599662;
	b=k+kGiy2lWvQ51jhMTb7biFQxfO4WSK8GZT3OyS9i1JQvK4LbgxnVVvLlRdwc83kwzhUC
	 KEd2GbXdj+V0IUhJlDQxr78kUSzx9sDUAgNSU+GjPnSecgZc20yBw4eoF6FbVK5IoNqgg
	 TYC9opegVf5oT30Ex958OQseW8VSXwrfUUbNgrnsErcP65RVdpbJj9GIyVM5/0IENFYn1
	 vBKlATw8CqwsvWniTTC+0acxRdn6QxsQP5WlzeslquRdeoWcZcN0U5hA8qmHucO9vRR+k
	 Sf9x3fCXgGyMUdGh3qcmDb01mp4hiP9TM2q31UHXcm1N9Uz+/DtWR8afZZadbnef3Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=TyN4/z4OamrGH3Yqwqa3jPs1nyqiW1mfTcLXU8x8Bkg=;
	b=p54xFMthau87sBrYRhG8BB2rw8+haYbYYCY73WCAHFzrOgfFw9SMaXmc/h3QGuzW+TaI
	 mAORip7NNiH0Tr0xEPtWFuGXg821ImGHrFJbHinsrotDD5vTbVjfwbLGufk4JrFrAQTt6
	 MtPuDOZQFuOPAGwh2mjWgosDv7q9CyvJVzuk15g5z+01eiAjV88Le4BWwRrmGHtxCOC25
	 BGvJJPtHYLJmOHTX/gMwtLzFOHqHfNGD6OTqtfYsUCIjsZpIrEd86AX0LumMBBxVzU6Wf
	 04ORyi0r3bC+PyHscBuj+FIXNly5JXEdhQKsV/yzU70W2CLR2v4V6gRHwSQX2sCZpuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cAW+MVEj;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816A60A6F51
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5816A60A6F51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cAW+MVEj
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1997547eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599661; x=1795204461; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyN4/z4OamrGH3Yqwqa3jPs1nyqiW1mfTcLXU8x8Bkg=;
        b=cAW+MVEjMlUgxFDmOaoK1WuVSTWyoQ1mfPr1HmpC/idvuGGzH6IIuODwzUmg+GQOw9
         zLzWH1KvYIltwuCPtyHjiHXjDsT2r+NVxf5AcwoTRUoczsf/vasieZqcrmaRp7RR+inQ
         MJtim8hOBciuYDL/snQLMExuQfEMV+rqljPCplYjhlL95/Yks59fr/jd0YrucWu1yVJ3
         3cNyn/PIEMef0PROUf3hw7oFxpvtbRXXR6KuUfmdCtrgzhLYZTvSxUNoHa0km3qQ2Mgw
         U+N5cB1QmevrLp1vLsAonZfMDt1+SEBfVAdnXmyfB0hueFsey7wVLQ+ANSPWycEhDMsu
         IKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599661; x=1795204461;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TyN4/z4OamrGH3Yqwqa3jPs1nyqiW1mfTcLXU8x8Bkg=;
        b=kInOqwZUalMgEHuxHyeGHBe1DGBASk7+buLVLOA0FgzmBTjvUu4WOp/BTplPhTxyts
         yBR9xD9+dbbJh4ZW4pFhurfSSBFEj2HSOwH7ELNqaqD9vbKozJdT7OYp6NvjHNLAJzpV
         9eR1cW5IxcDVnYvaYxEt0kI4aEVXvzsOvjlC22T7SWTT4zoAcllEiGCrRyBcMEGQaKoh
         KNeymNDNj2CvdrB9SiUXX3Eu72EaDamwYNLI1yaYzyJNW8xGsRsMppnKAMvISfJ4kEIh
         YSiNuj5+eZuNC5q09psOqKfsH09eHzLhCpaVi5GRyMwrS0k0AyAg/DxA4xnJ5jDnzpYZ
         9iiA==
X-Gm-Message-State: APuU4Z9gQrrHxqzheaEhWe24o3MjAZ0Nz012ryRS6U/ukPbehYdn1d/P
	h4ybbawjalNzk76uCXb1Jgdx4pfULNsj7AQjd6oBAXD4Jtsj7TA3rjZepb0hoJORXNFlQ7Q0v5U
	OmVLyEAv+sw==
X-Received: from dycnm14.prod.google.com ([2002:a05:7300:d18e:b0:358:f250:485f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8955:10b0:375:2470:c754
 with SMTP id 5a478bee46e88-379659c5d4dmr2929613eec.12.1794599661116; Fri, 13
 Nov 2026 11:54:21 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:21 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-17-irogers@google.com>
Subject: [PATCH v2 16/30] perf test: Add CPUID matching tests for other architectures
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
 tools/perf/tests/cpuid-match.c | 79 ++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/perf/tests/cpuid-match.c b/tools/perf/tests/cpuid-match.c
index e3d4a349f393..826380241a0f 100644
--- a/tools/perf/tests/cpuid-match.c
+++ b/tools/perf/tests/cpuid-match.c
@@ -36,8 +36,87 @@ static int test__cpuid_match_arm64(struct test_suite *test __maybe_unused,
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
+	/* Three hyphens in a RISC-V CPUID don't imply an x86 stepping. */
+	TEST_ASSERT_VAL("riscv match",
+			!strcmp_cpuid_str(EM_RISCV, "0x489-0x8000000000000007-0x[[:xdigit:]]+",
+					  "0x489-0x8000000000000007-0x0000000000000001"));
+	TEST_ASSERT_VAL("riscv mismatch",
+			strcmp_cpuid_str(EM_RISCV, "0x489-0x8000000000000008-0x[[:xdigit:]]+",
+					 "0x489-0x8000000000000007-0x0000000000000001"));
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
2.56.1.703.gf848ed807c-goog

