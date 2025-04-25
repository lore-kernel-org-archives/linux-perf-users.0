Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F612F2A
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745603206; cv=none; b=LtrSU//hvFeB3tCOVqXPrn3r8R6zmBbJYLZP6DPKA3HHh6lXEwJxKHDbueiriZOhLIhoZh+gxue/R9VmEML49i/eTSih7cFm/1cxKMFpaFpVBAWKE6nggVTcJzQEXvEePp79iapGPEbAvLJzXJZoEIU5maw7M25c/dM03XY6pdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745603206; c=relaxed/simple;
	bh=Sgmu/3BDx6uV+GllAWEYIgsqkuxFB3Bo3lMKzsQbZ2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4e4YYBhIrqNXHRu2spUvcs4Bb4SJDIFVZ4RIp3I6YvbnR+dYy/0DvP8IxWGe6Hgna9z+ViR8VXdLAHu9xW89GvjdpFrxKnmxnMRS0a90cIifOt7Rtj63heoiWR8kvTkFMHisUpWigjoIaS86uWg7Sc2/jCfUzwONTjSnztMISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXqFv3PY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXqFv3PY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE012C4CEE9;
	Fri, 25 Apr 2025 17:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745603206;
	bh=Sgmu/3BDx6uV+GllAWEYIgsqkuxFB3Bo3lMKzsQbZ2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXqFv3PYfpmBTMDXt0YQcvIa+c7cBzZLXfX0aRTW5hwIi7Cr/z9nrkp2qpx2QmmDs
	 2oQEfJpTjjK+eQIbvUIXDO5FMl5QTwd/OlzGK4JnEP4xpXVD1W+mTnBDo9kJ5sfAwV
	 b1qtwUhWkcS6yuSCR4sHhfZziZ8X8JKdksebA7zhaUQr4u1taFD7DKf5s161xIOktL
	 UPONCIojyn8avf9dADvif+atuQGvGvqWfkqtK7ZTEodm1acIEBcUGpTGLDhTYzC0az
	 uvDc5JFvWwEad8nFuy3XsZgsEz2/wfddc00VP0zPELSn85GCJIfnPTRk4jD2TFMTOe
	 lqb0Jz0o7PAlw==
Date: Fri, 25 Apr 2025 14:46:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	Likhitha Korrapati <likhitha@linux.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH] tools/lib/perf: Fix -Werror=alloc-size-larger-than in
 cpumap.c
Message-ID: <aAvKg8K2fyrZ6zy4@x1>
References: <20250406163412.897313-1-likhitha@linux.ibm.com>
 <E58C5DCA-5F52-4B61-A816-DE932BA40FDA@linux.ibm.com>
 <baad9d65-07b1-4a19-aea6-5ba5d60da98e@linux.ibm.com>
 <1b1450a8-f091-4091-981d-76b27f61be24@linux.ibm.com>
 <D1C1E5D6-085A-41D1-85AB-52809C956BFB@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D1C1E5D6-085A-41D1-85AB-52809C956BFB@linux.ibm.com>

On Fri, Apr 25, 2025 at 08:19:02PM +0530, Athira Rajeev wrote:
> > On 14 Apr 2025, at 7:08 AM, Madhavan Srinivasan <maddy@linux.ibm.com> wrote:
> > On 4/7/25 5:38 PM, Venkat Rao Bagalkote wrote:
> >> On 07/04/25 12:10 am, Athira Rajeev wrote:
> >>>> On 6 Apr 2025, at 10:04 PM, Likhitha Korrapati <likhitha@linux.ibm.com> wrote:

> >>>> perf build break observed when using gcc 13-3 (FC39 ppc64le)
> >>>> with the following error.

> >>>> cpumap.c: In function 'perf_cpu_map__merge':
> >>>> cpumap.c:414:20: error: argument 1 range [18446744069414584320, 18446744073709551614] exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
> >>>>   414 |         tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> >>>>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>> In file included from cpumap.c:4:
> >>>> /usr/include/stdlib.h:672:14: note: in a call to allocation function 'malloc' declared here
> >>>>   672 | extern void *malloc (size_t __size) __THROW __attribute_malloc__
> >>>>       |              ^~~~~~
> >>>> cc1: all warnings being treated as errors

> >>>> Error happens to be only in gcc13-3 and not in latest gcc 14.
> >>>> Even though git-bisect pointed bad commit as:
> >>>> 'commit f5b07010c13c ("libperf: Don't remove -g when EXTRA_CFLAGS are used")',
> >>>> issue is with tmp_len being "int". It holds number of cpus and making
> >>>> it "unsigned int" fixes the issues.

> >>>> After the fix:

> >>>>   CC      util/pmu-flex.o
> >>>>   CC      util/expr-flex.o
> >>>>   LD      util/perf-util-in.o
> >>>>   LD      perf-util-in.o
> >>>>   AR      libperf-util.a
> >>>>   LINK    perf
> >>>>   GEN     python/perf.cpython-312-powerpc64le-linux-gnu.so

> >>>> Signed-off-by: Likhitha Korrapati <likhitha@linux.ibm.com>
> >>> Looks good to me

> >>> Reviewed-by: Athira Rajeev <atrajeev@linux.ibm.com>

> >> Tested this patch on perf-tools-next repo, and this patch fixes the issue.

> >> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

> > Arnaldo, Namhyung,

> > can you consider pulling this fix? since it is breaking the build in gcc13-3 or
> > if you have any comments do let us know.

This isn't the only place in that file where this pattern exists:

⬢ [acme@toolbx perf-tools-next]$ grep malloc tools/lib/perf/cpumap.c 
	cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
⬢ [acme@toolbx perf-tools-next]$


struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
{
        RC_STRUCT(perf_cpu_map) *cpus;
        struct perf_cpu_map *result;

        if (nr_cpus == 0)
                return NULL;

        cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);


int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
{
        struct perf_cpu *tmp_cpus;
        int tmp_len;
        int i, j, k;
        struct perf_cpu_map *merged;

        if (perf_cpu_map__is_subset(*orig, other))
                return 0;
        if (perf_cpu_map__is_subset(other, *orig)) {
                perf_cpu_map__put(*orig);
                *orig = perf_cpu_map__get(other);
                return 0;
        }

        tmp_len = __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(other);
        tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));


struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
                                             struct perf_cpu_map *other)
{
        struct perf_cpu *tmp_cpus;
        int tmp_len;
        int i, j, k;
        struct perf_cpu_map *merged = NULL;

        if (perf_cpu_map__is_subset(other, orig))
                return perf_cpu_map__get(orig);
        if (perf_cpu_map__is_subset(orig, other))
                return perf_cpu_map__get(other);

        tmp_len = max(__perf_cpu_map__nr(orig), __perf_cpu_map__nr(other));
        tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));

I'm trying to figure out why its only in perf_cpu_map__merge() that this
triggers :-\

Maybe that max() call in perf_cpu_map__intersect() somehow makes the
compiler happy.

And in perf_cpu_map__alloc() all calls seems to validate it.

But wouldn't turning this into a calloc() be better?

Like:

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 4454a5987570cfbc..99d21618a252ac0e 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -411,7 +411,7 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
        }
 
        tmp_len = __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(other);
-       tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
+       tmp_cpus = calloc(tmp_len, sizeof(struct perf_cpu));
        if (!tmp_cpus)
                return -ENOMEM;
 
⬢ [acme@toolbx perf-tools-next]$


And better, do the max size that the compiler is trying to help us
catch?

- Arnaldo
