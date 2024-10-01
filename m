Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361E1C9B7E;
	Tue,  1 Oct 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727809622; cv=none; b=uMoC9EWgKdtOJ+wqiNAGnW1qFV+WAmHCcdxecOL8ZlwDMSYlcSCxuUgF07nXN+kXVf+MTCZ4XeMtxScF4tBOE5JzV4gUIsBe9ATHmEdWH+IxLtswOlb+BEy2udt1mGkvG/nTm8sWgN89o5rBbH+iitMd3jEWgcb6btm7RbiHr+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727809622; c=relaxed/simple;
	bh=yjNLzGHwXYeXGDZK7SOq5iph3nIKqLB/EJ0tT3+l+Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2A0oROe19MTpXoMdkTGrB37UMqpSJ1+XX8KWQIPnP26g328dv05Vn4+gPsieUJcRtKWOY4LLgUE4wcuxAP2voWR8OU6GrdhYbTZKaGJvWY1viBBRgcYaEwY0dFPXkEvrnorj5LVTM/cNmGzWmWS/FNIosr3G98pq2Nn928amJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlvgwP2l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlvgwP2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1095C4CEC6;
	Tue,  1 Oct 2024 19:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727809621;
	bh=yjNLzGHwXYeXGDZK7SOq5iph3nIKqLB/EJ0tT3+l+Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlvgwP2l+hgxora6zSRHNT5G47RptA5HB8MiRHakprax4pIu4aKHJAV/Kp78bwtAV
	 1XE77L+hQcQwG0BNr1xWg4DqMfW7nvibDKCtswedjOWVPsIQTp8arEcYifAlkhtchU
	 v19SoAii0Ktd2eosPbhfFM04YFG2+rSzBsaoGX/Sp8m3AhC9ixBDhH8w3DX7qTqx12
	 V/ptYvVEy/woTZmz838CED8l6uCpCWCX+QmM2HPTfQlwqStf0isY4TqcJK9YVUORxv
	 H4FI0hY0yTnQhnbfSBAJpTxwihmztoZm4UVHUhCjlbHhkrPhEhuJe0drFKg0yYj2ML
	 xRvboiq+PLrgw==
Date: Tue, 1 Oct 2024 16:06:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
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
Message-ID: <ZvxIUSz1O92BGOiP@x1>
References: <20240924233930.5193-1-ilkka@os.amperecomputing.com>
 <5160d57a-3520-4d99-ae10-5cc539fba813@linaro.org>
 <ZvSXFx4N2vXReqZs@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvSXFx4N2vXReqZs@google.com>

On Wed, Sep 25, 2024 at 04:04:55PM -0700, Namhyung Kim wrote:
> On Wed, Sep 25, 2024 at 10:54:31AM +0100, James Clark wrote:
> > 
> > 
> > On 25/09/2024 12:39 am, Ilkka Koskinen wrote:
> > > If one builds perf with DEBUG=1, captures data on multiple CPUs and
> > > finally runs 'perf report -C <cpu>' for only one of the cpus, assert()
> > > aborts the program. This happens because there are empty queues with
> > > format set. This patch changes the condition to abort only if a queue
> > > is not empty and if the format is unset.
> > > 
> > >    $ make -C tools/perf DEBUG=1 CORESIGHT=1 CSLIBS=/usr/lib CSINCLUDES=/usr/include install
> > >    $ perf record -o kcore --kcore -e cs_etm/timestamp/k -s -C 0-1 dd if=/dev/zero of=/dev/null bs=1M count=1
> > >    $ perf report --input kcore/data --vmlinux=/home/ikoskine/projects/linux/vmlinux -C 1
> > >    Aborted (core dumped)
> > > 
> > > Fixes: 57880a7966be ("perf: cs-etm: Allocate queues for all CPUs")
> > > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > > ---
> > >   tools/perf/util/cs-etm.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > index 90f32f327b9b..40f047baef81 100644
> > > --- a/tools/perf/util/cs-etm.c
> > > +++ b/tools/perf/util/cs-etm.c
> > > @@ -3323,7 +3323,7 @@ static int cs_etm__create_decoders(struct cs_etm_auxtrace *etm)
> > >   		 * Don't create decoders for empty queues, mainly because
> > >   		 * etmq->format is unknown for empty queues.
> > >   		 */
> > > -		assert(empty == (etmq->format == UNSET));
> > > +		assert(empty || etmq->format != UNSET);
> > >   		if (empty)
> > >   			continue;
> > 
> > Oops I didn't realize you could filter on CPU in report mode. Thanks for the
> > fix. Adding a test to the end of test_arm_coresight.sh might be quite
> > useful. Either way:
> > 
> > Reviewed-by: James Clark <james.clark@linaro.org>
>  
> Thanks, it should go to the perf-tool.  Arnaldo, please pick up.

Right, picking it now.

Thanks,

- Arnaldo
