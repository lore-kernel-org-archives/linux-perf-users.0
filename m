Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF4B18BBBF;
	Mon, 26 Aug 2024 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683353; cv=none; b=C7YyvVcwFKxSzlPuFb4xLHUugi6DaISEm1gR8arGBcxJFgcBRmXPej0gDDEOjaWnqJ/O2/NdIT5DMBc12+/SS4SscY2hQ5KX0EPLXsAkL8T9W1BgUNMWQhea8C57Jb9pl+ItGO8MmXyLBR/H+z2nRzeW2LIZ7iEIqrhf8I1ruwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683353; c=relaxed/simple;
	bh=mLRqEiz2Ra552ccXEQ0FWVth+irOONPE1lR0vUZjlFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTjZ+7Oe2hh74Xw4v2G21AwoxKrueYb9RwA1OIrS4mXhz5wSihe7DRAtDzGWbOW5IfigGqbRulyoK2isBToebiH/jlHihciS21v2rHW3lnONijQz8mG+s9nOG1/YP6J51fgIyKQ+3pDqAStGm5CnS4vQ19uDoD978DHBxidZj1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjTRiORj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjTRiORj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9576FC52FC1;
	Mon, 26 Aug 2024 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724683352;
	bh=mLRqEiz2Ra552ccXEQ0FWVth+irOONPE1lR0vUZjlFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XjTRiORjc/FFvnAm1NxyNxqpf1yn3CyHJ/jYPbH7OvmZsl6MyI6vp+A6VNFkjqJhF
	 0p0UHxkR+GBKXcUYfuCc/rG1yMRSrWsCbPYj9l4fcvxiT9uKoZJympEtGEq/LnBxyd
	 /Axh7GxRdUSgQRzuamfhj8HhcgeqMD7n1m6Ry+zwHgrew4/tC+h3nGRi3aX32YNBgr
	 oM0KLbYq1IRv8Ib2cXKUUbZM1ZrTNLFRV0Bhl7r6uVenZKBQmw34V8VEk1x2V39j8i
	 gck6QFYLBnEf02i33JLs5sOnd5Ze+HeyD0UvlW7a7rU9faG4YXZh6xlHmu7+hEATeG
	 QguaV+2tQRavg==
Date: Mon, 26 Aug 2024 11:42:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"james.clark@linaro.org" <james.clark@linaro.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf test: Use -Wp,-U_FORTIFY_SOURCE for tests built
 with -O0
Message-ID: <ZsyUVWXtzBmm-U_q@x1>
References: <20240806061749.143072-1-eiichi.tsukata@nutanix.com>
 <4D19AE26-E1B4-44B6-A8C7-639EF2B69317@nutanix.com>
 <C00F1D39-9A12-4D1C-85BD-48A6D7C0290B@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C00F1D39-9A12-4D1C-85BD-48A6D7C0290B@nutanix.com>

On Mon, Aug 26, 2024 at 03:04:12AM +0000, Eiichi Tsukata wrote:
> Ping

Tried, didn't work, can you please check on the tmp.perf-tools-next?

⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 20240806061749.143072-1-eiichi.tsukata@nutanix.com
Grabbing thread from lore.kernel.org/all/20240806061749.143072-1-eiichi.tsukata@nutanix.com/t.mbox.gz
Analyzing 3 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH] perf test: Use -Wp,-U_FORTIFY_SOURCE for tests built with -O0
    + Link: https://lore.kernel.org/r/20240806061749.143072-1-eiichi.tsukata@nutanix.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ---
  ✓ Signed: DKIM/nutanix.com
---
Total patches: 1
---
 Link: https://lore.kernel.org/r/20240806061749.143072-1-eiichi.tsukata@nutanix.com
 Base: not specified
       git am ./20240806_eiichi_tsukata_perf_test_use_wp_u_fortify_source_for_tests_built_with_o0.mbx
⬢[acme@toolbox perf-tools-next]$        git am ./20240806_eiichi_tsukata_perf_test_use_wp_u_fortify_source_for_tests_built_with_o0.mbx
Applying: perf test: Use -Wp,-U_FORTIFY_SOURCE for tests built with -O0
error: patch failed: tools/perf/tests/workloads/Build:7
error: tools/perf/tests/workloads/Build: patch does not apply
Patch failed at 0001 perf test: Use -Wp,-U_FORTIFY_SOURCE for tests built with -O0
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"
⬢[acme@toolbox perf-tools-next]$ git am --abort
⬢[acme@toolbox perf-tools-next]$
 
> > On Aug 6, 2024, at 15:27, Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> > 
> > Hi,
> > 
> > FYI: Fedora uses “RPM_OPT_FLAGS”  as “EXTRA_CFLAGS” to build perf.
> > https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/kernel.spec#_2908
> > 
> > And on Fedora40,  it has “-Wp,-D_FORTIFY_SOURCE=3”.
> > 
> > [eiichi@t495 ~]$ rpm --showrc | grep RPM_OPT | head -n 1
> >  RPM_OPT_FLAGS="%{optflags}"
> > [eiichi@t495 ~]$ rpm --eval '%{optflags}'
> > -O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mon-omit-leaf-frame-pointer
> > 
> > Best,
> > Eiichi
> > 
> >> On Aug 6, 2024, at 15:17, Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> >> 
> >> If EXTRA_CFLAGS has "-Wp,-D_FORTIFY_SOURCE=2", the build fails with:
> >> 
> >> error: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Werror=cpp]
> >> 
> >> Use "-Wp,-U_FORTIFY_SOURCE" instead of "-U_FORTIFY_SOURCE" for tests
> >> built with -O0.
> >> 
> >> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> >> ---
> >> tools/perf/tests/workloads/Build | 8 ++++----
> >> 1 file changed, 4 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
> >> index 48bf0d3b0f3d..ec36c21e375e 100644
> >> --- a/tools/perf/tests/workloads/Build
> >> +++ b/tools/perf/tests/workloads/Build
> >> @@ -7,7 +7,7 @@ perf-test-y += sqrtloop.o
> >> perf-test-y += brstack.o
> >> perf-test-y += datasym.o
> >> 
> >> -CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> >> -CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
> >> -CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> >> -CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> >> +CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -Wp,-U_FORTIFY_SOURCE
> >> +CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -Wp,-U_FORTIFY_SOURCE
> >> +CFLAGS_brstack.o          = -g -O0 -fno-inline -Wp,-U_FORTIFY_SOURCE
> >> +CFLAGS_datasym.o          = -g -O0 -fno-inline -Wp,-U_FORTIFY_SOURCE
> >> -- 
> >> 2.45.2
> >> 
> > 
> 
