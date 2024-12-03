Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B41EF081
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Dec 2024 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251368; cv=none; b=gB3SZ1arMl9WpkUW8EJWPW4uJGyRLYI0lZR/Nxc2xj+9oshbrG2eiBt8srxyZ8BgrD3Rvom+8eqNPm2OLGpnVdyYPEVXhVhPTv18EheDhm+JCXiS9fZOzdlB+gdOfbKnzrjj4wA377/LwI/zlgc/lXTE46Lf5leVCql41e55M1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251368; c=relaxed/simple;
	bh=IE/QB8ecP1kkb8KyuAoQXlcTO6A7S0zskyQTSpqhqXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DY8L4fvxoJWkTdHs3kflPgK7jMHTIUn1Gsli86UMiJcDk8cu8KA5IT6StFZgWmBH+lpZqfMAsp4pv2gH5n3+d2H7hyFEjBFvXVsf3SpsDhAaK8jtUbPZ8TKsviyeID8Q7YenEa6B/ybMsnjDg69OswJJwpC6VTrI+PM+ca6I3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzJJqEqb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzJJqEqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2ADC4CECF;
	Tue,  3 Dec 2024 18:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733251367;
	bh=IE/QB8ecP1kkb8KyuAoQXlcTO6A7S0zskyQTSpqhqXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mzJJqEqbKT6h0rEo44OZpG6soedWaZUYOqxRXJDOb5C/kTUBWIpJAbKpEUxE6/JhD
	 OEEasR9x7Rl/PMncXsa2i9ZK04bRex7jpp1sFEIYhLMLZFecofT5IZqc1kLM3KJETP
	 Ci+04CkRrp/XSMGEcH3/cC2e9V5MYDu8/i41BXDqcSqr0SCx/VSrY5T1Qbo7q5zjim
	 JHPokyf5xd1MriPF1Ur+DgRohouo1ESNBghOpEuplpo149hJDPr4wOnWAcq9H/zt6K
	 AbMtr8gKlU9MHfifYjYAkRfrz6mFp6Ezid0ZDU98TwiXA1EX3DQbdrKUzQxJxq3QZF
	 Z3XsF451iOkzQ==
Date: Tue, 3 Dec 2024 10:42:45 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, tmricht@linux.ibm.com,
	acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] tools/perf/tests/expr: Make the system_tsc_freq test
 only for intel
Message-ID: <Z09RJbpmHzc4b1D6@google.com>
References: <20241022140156.98854-1-atrajeev@linux.vnet.ibm.com>
 <ZyF2-XNUh38p_5Gg@google.com>
 <B72F330F-2A56-41B0-ABED-FCA7DC9EE711@linux.vnet.ibm.com>
 <CAP-5=fXCYURva6Q8ktRVmnf2QCcsr-E3fPn327k0JRCw_9fn3A@mail.gmail.com>
 <BBF1A4DC-3BD9-4377-BE2F-CBEFE55F0497@linux.vnet.ibm.com>
 <20241107135606.GA47850@e132581.arm.com>
 <0F805B2F-35CC-4E0C-BD2F-84552C4C528E@linux.vnet.ibm.com>
 <Z09K5orKhWbeOGLV@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z09K5orKhWbeOGLV@google.com>

On Tue, Dec 03, 2024 at 10:16:06AM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Nov 08, 2024 at 10:50:10AM +0530, Athira Rajeev wrote:
> > 
> > 
> > > On 7 Nov 2024, at 7:26 PM, Leo Yan <leo.yan@arm.com> wrote:
> > > 
> > > Hi Athira,
> > > 
> > > On Wed, Nov 06, 2024 at 03:04:57PM +0530, Athira Rajeev wrote:
> > > 
> > > [...]
> > > 
> > >>> Hi Athira,
> > >>> 
> > >>> sorry for the breakage and thank you for the detailed explanation. As
> > >>> the code will run on AMD I think your change will break that - . It is
> > >>> probably safest to keep the ".. else { .." for this case but guard it
> > >>> in the ifdef.
> > >>> 
> > >> 
> > >> Hi Ian
> > >> 
> > >> Thanks for your comments. Does the below change looks good ?
> > >> 
> > >> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > >> index e3aa9d4fcf3a..f5b2d96bb59b 100644
> > >> --- a/tools/perf/tests/expr.c
> > >> +++ b/tools/perf/tests/expr.c
> > >> @@ -74,14 +74,12 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
> > >>    double val, num_cpus_online, num_cpus, num_cores, num_dies, num_packages;
> > >>    int ret;
> > >>    struct expr_parse_ctx *ctx;
> > >> -    bool is_intel = false;
> > >>    char strcmp_cpuid_buf[256];
> > >>    struct perf_pmu *pmu = perf_pmus__find_core_pmu();
> > >>    char *cpuid = perf_pmu__getcpuid(pmu);
> > >>    char *escaped_cpuid1, *escaped_cpuid2;
> > >> 
> > >>    TEST_ASSERT_VAL("get_cpuid", cpuid);
> > >> -    is_intel = strstr(cpuid, "Intel") != NULL;
> > >> 
> > >>    TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
> > >> 
> > >> @@ -244,11 +242,13 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
> > >>    if (num_dies) // Some platforms do not have CPU die support, for example s390
> > >>        TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
> > >> 
> > >> +#if defined(__i386__) && defined(__x86_64__)
> > >>    TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#system_tsc_freq") == 0);
> > >> -    if (is_intel)
> > >> +    if (strstr(cpuid, "Intel") != NULL)
> > >>        TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
> > >>    else
> > >>        TEST_ASSERT_VAL("#system_tsc_freq == 0", fpclassify(val) == FP_ZERO);
> > >> +#endif
> > >> 
> > >>    /*
> > >>     * Source count returns the number of events aggregating in a leader
> > > 
> > > I confirmed the change above fixes the failure on Arm64.
> > > 
> > > Tested-by: Leo Yan <leo.yan@arm.com>
> > Thanks Leo Yan for testing.
> > 
> > Hi Ian,
> > 
> > If the change above looks good, I will post a V2 . Please share your review comments
> 
> Sorry for the delay, it looks good to me.  Can you please send the v2?

After looking at another report, I think we need to check the value of
TSC freq, not just the vendor.  Can you please test this?

Thanks,
Namhyung


---8<---
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 41ff1affdfcdf31c..45151696e7b76308 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -5,6 +5,7 @@
 #include "util/hashmap.h"
 #include "util/header.h"
 #include "util/smt.h"
+#include "util/tsc.h"
 #include "tests.h"
 #include <perf/cpumap.h>
 #include <math.h>
@@ -75,14 +76,12 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	double val, num_cpus_online, num_cpus, num_cores, num_dies, num_packages;
 	int ret;
 	struct expr_parse_ctx *ctx;
-	bool is_intel = false;
 	char strcmp_cpuid_buf[256];
 	struct perf_cpu cpu = {-1};
 	char *cpuid = get_cpuid_allow_env_override(cpu);
 	char *escaped_cpuid1, *escaped_cpuid2;
 
 	TEST_ASSERT_VAL("get_cpuid", cpuid);
-	is_intel = strstr(cpuid, "Intel") != NULL;
 
 	TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
 
@@ -246,10 +245,10 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 		TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
 
 	TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#system_tsc_freq") == 0);
-	if (is_intel)
-		TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
-	else
-		TEST_ASSERT_VAL("#system_tsc_freq == 0", fpclassify(val) == FP_ZERO);
+	if (val > 0) {
+		TEST_ASSERT_VAL("#system_tsc_freq == arch_get_tsc_freq()",
+				val == arch_get_tsc_freq());
+	}
 
 	/*
 	 * Source count returns the number of events aggregating in a leader
