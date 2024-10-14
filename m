Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7729A0
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728927523; cv=none; b=uFEpjkyG6Ugvksv0+Mgi1727+pKwB6bCdDWIK5qESWAp+XPmxQABjIrKe8w+Qkwlu8yqj0fi7MJdplL6j60Avf6/tXgmmZb8Bst/BjqSxeyaGjtVz7vYwf1rStOdzA2cmQj/BZLX5+jr8dL+JhYrNlLUC8plmekmgpG5tUoE47A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728927523; c=relaxed/simple;
	bh=h3AfZDau91v/BeVAnuirS8TjaRO6qVmsdirabWbcECg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNCxcssCETP+iR1XHDvCTlkx3CV13Tyb/oMGQqfu2f12aTRklig1gETtrMQGBmwdM1SS2shdGvPYXFgxUmgbogpy/WwnCpSsfHTytfc2OfEMdshkKKDWFEDQo9ub0fNdv6DnRy8l8GW2lEJMwKRBLWZcAs7zQEPzp2/f/1EqWk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuKrQw1j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuKrQw1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF80C4CEC3;
	Mon, 14 Oct 2024 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728927522;
	bh=h3AfZDau91v/BeVAnuirS8TjaRO6qVmsdirabWbcECg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuKrQw1j2XgaIHbLmWq9Ozp6w8vi7gRxJN51BkRIoG4dekTDoeEgXvnatxizpvL2Y
	 RpcxPiyvPzBQocZQceBwV10qff6gWEsIAmiUWmkYSscBBSBIGc8wBnUkfedHfjwz+S
	 2VQPd7Lef2Vzi/owZZL/IHaIij6oGRG79icyS2YgUn3TAkYIKcdbC4qvr1qDzTFq8p
	 Sl2VjFBnX8zeqZ7hP0HnXvoCVHojBeJVPjH/IlIUiOxI8jb2LtakNrqp/GWrS0/C6Z
	 AsyhGbtMnv3SEYUVc0ZwHTsnKqnKONOCg+uE6IoU97+h/SBhSJ+cHb8pjyrqDXSUge
	 jWMoVQoGD7Lxw==
Date: Mon, 14 Oct 2024 10:38:40 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
	maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Subject: Re: [PATCH] tools/perf/tests: Fix compilation error with strncpy in
 tests/tool_pmu
Message-ID: <Zw1XIGML32VaxE0t@google.com>
References: <20241013173742.71882-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241013173742.71882-1-atrajeev@linux.vnet.ibm.com>

On Sun, Oct 13, 2024 at 11:07:42PM +0530, Athira Rajeev wrote:
> perf fails to compile on systems with GCC version11
> as below:

I have one more build failure on 32 bit systems.  I'll carry this as
well.

Thanks,
Namhyung

---8<---
From 2e2c7ca3691d223d94ea383a6b688e35579d14d5 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 14 Oct 2024 10:34:17 -0700
Subject: [PATCH] perf tools: Fix compiler error in util/tool_pmu.c

  util/tool_pmu.c: In function 'evsel__tool_pmu_read':
  util/tool_pmu.c:419:55: error: passing argument 2 of 'tool_pmu__read_event' from incompatible pointer type [-Werror=incompatible-pointer-types]
    419 |                         if (!tool_pmu__read_event(ev, &val)) {
        |                                                       ^~~~
        |                                                       |
        |                                                       long unsigned int *
  util/tool_pmu.c:335:56: note: expected 'u64 *' {aka 'long long unsigned int *'} but argument is of type 'long unsigned int *'
    335 | bool tool_pmu__read_event(enum tool_pmu_event ev, u64 *result)
        |                                                   ~~~~~^~~~~~

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/tool_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index ea9d50f0252023dc..bd1cee643eb506df 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -394,7 +394,7 @@ bool tool_pmu__read_event(enum tool_pmu_event ev, u64 *result)
 int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	__u64 *start_time, cur_time, delta_start;
-	unsigned long val;
+	u64 val;
 	int fd, err = 0;
 	struct perf_counts_values *count, *old_count = NULL;
 	bool adjust = false;
-- 
2.47.0.rc1.288.g06298d1525-goog

