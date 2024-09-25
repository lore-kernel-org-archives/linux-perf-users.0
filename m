Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7629914A4F7;
	Wed, 25 Sep 2024 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727305500; cv=none; b=lwbB2UCedUW6v5OdjpiwgjNUppMWOrlw7cKIBu0aL4f/qwx90veavy+yYjSCwKlVRV2qk9Jxlhv2MrW8CnSbkut/9b6kmTlchkXczX3lVsZoFT7z9qyMCdNJzJpNfPaLpYJrgdWTnAtLPiBsKazuzP66TtqwrqWaam2HMvayQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727305500; c=relaxed/simple;
	bh=SF1z1QG7yhYVWGAKH47605vTjCu1mCPy5sgus+qM8u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujBP8h9wP/BCzzPQnWrolw4cpuFJLRqSXJ7jp/vQUqYxU+ayfykMNsCm3MXbWN93U/FYkiuymKHLq47FLFuODMkzueHTY9dOaTJDlziQeDT1G9/6dE3Zj0Ch0WubrfRWVYv5s62bzZhMCcjHvBVHWEwMryGlKyQ+ewwxbhaXYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CW7s/e9n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CW7s/e9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD7FC4CEC3;
	Wed, 25 Sep 2024 23:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727305498;
	bh=SF1z1QG7yhYVWGAKH47605vTjCu1mCPy5sgus+qM8u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CW7s/e9nOckWBsyaGj64St2rDz1kGsbMf8PevyvOypasSNFg7o8Ht0C/pj/iyAO3N
	 jCuZoE4Jnafg1yt406w6mkdojnbqjPYhN9003zCzWPYspUPSY+9YLYugb4OqYu8tr7
	 +EvObU14sfqLrZLSAozedq3YiCS6Aekx4t5EzXvv67pjRFZJji8ZiBQolvgxOpzIbV
	 rXPXzypznDavrNJ5vFRe9hBN3db8ZB6BaKDlZgLz/9fqnGeKRfrRHQXTWKRgs99RmQ
	 ifS5OFqI7/EwxMk7h4Ezj4HiBbx7IN1Eevt2It11zP+aRFcDariEVQqiZFXMQ8wqe9
	 YBfufRTEZPBLw==
Date: Wed, 25 Sep 2024 16:04:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf: cs-etm: Fix the assert() to handle captured and
 unprocessed cpu trace
Message-ID: <ZvSXFx4N2vXReqZs@google.com>
References: <20240924233930.5193-1-ilkka@os.amperecomputing.com>
 <5160d57a-3520-4d99-ae10-5cc539fba813@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5160d57a-3520-4d99-ae10-5cc539fba813@linaro.org>

On Wed, Sep 25, 2024 at 10:54:31AM +0100, James Clark wrote:
> 
> 
> On 25/09/2024 12:39 am, Ilkka Koskinen wrote:
> > If one builds perf with DEBUG=1, captures data on multiple CPUs and
> > finally runs 'perf report -C <cpu>' for only one of the cpus, assert()
> > aborts the program. This happens because there are empty queues with
> > format set. This patch changes the condition to abort only if a queue
> > is not empty and if the format is unset.
> > 
> >    $ make -C tools/perf DEBUG=1 CORESIGHT=1 CSLIBS=/usr/lib CSINCLUDES=/usr/include install
> >    $ perf record -o kcore --kcore -e cs_etm/timestamp/k -s -C 0-1 dd if=/dev/zero of=/dev/null bs=1M count=1
> >    $ perf report --input kcore/data --vmlinux=/home/ikoskine/projects/linux/vmlinux -C 1
> >    Aborted (core dumped)
> > 
> > Fixes: 57880a7966be ("perf: cs-etm: Allocate queues for all CPUs")
> > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > ---
> >   tools/perf/util/cs-etm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 90f32f327b9b..40f047baef81 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -3323,7 +3323,7 @@ static int cs_etm__create_decoders(struct cs_etm_auxtrace *etm)
> >   		 * Don't create decoders for empty queues, mainly because
> >   		 * etmq->format is unknown for empty queues.
> >   		 */
> > -		assert(empty == (etmq->format == UNSET));
> > +		assert(empty || etmq->format != UNSET);
> >   		if (empty)
> >   			continue;
> 
> Oops I didn't realize you could filter on CPU in report mode. Thanks for the
> fix. Adding a test to the end of test_arm_coresight.sh might be quite
> useful. Either way:
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
 
Thanks, it should go to the perf-tool.  Arnaldo, please pick up.
Namhyung
