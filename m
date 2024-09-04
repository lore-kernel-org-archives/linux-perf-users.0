Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD761E00B6;
	Wed,  4 Sep 2024 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473756; cv=none; b=WiUO9DiIat7H4+eDgncnOcvm2W8T0biVvWWivaLv/ffjbj2OUMvB2UgWY2Ro84pM7B218fTqQVqctVUymjlM3z/tgkNIQaIrV2I7neCY75ZDuiwSeRVhNNMF/rM5gboFqVpp8R3X23Y7lYqYFdOXyXK93W/bRAKP48YubKhotyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473756; c=relaxed/simple;
	bh=yti34NQLp3z26/2GmTL1llnQu5VorhQFs8/RIojmn5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMvwhvNrW53KGOQCcUMV+7laHMuKiE2fEPh6D/s1eWHa624F8b0YaHp6CnzzZv8pDT6I4AbdL3+k3Me0p6lu2RfSl4d5y0bob3ewA63AhjX+IQyTVf7vnO9Nougk8K/PkSEIwEUqc1bMiNzhWGMA+WnYHGSguf4tTBom+bDWLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTn8Qs6t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTn8Qs6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB046C4CEC2;
	Wed,  4 Sep 2024 18:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725473756;
	bh=yti34NQLp3z26/2GmTL1llnQu5VorhQFs8/RIojmn5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTn8Qs6t83kgEnt8WxIiz+sR0BjVfd0t0v+2+cO9JDYgEGJ+i+6YCXj13tNM7KfjK
	 brAE4kJMaihidAcTe73L59tn6hd9bdy1ZgupVZqbbIg73flCNM9YNpls+3vGC6xUyK
	 bbZmkThbQVLKFdUqksKhckHj6G3tXvVhDRbJJ2Ss7MnvpQimIW0sAPC94AVPkcd4Ue
	 zUQoruEJBHW/xcRkw3Fjk09wKygVNMo2RUPAPBRQwHcA5R6AqiM+RIXm+FGIMQ7toe
	 aEH8kwLzW6liYHsYbkv1LxijVc19iYiitpAlqQTHG40LKNj/LcnpesFoaDgPqP73SX
	 f5TVS+ULx14aQ==
Date: Wed, 4 Sep 2024 11:15:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 8/8] perf tools: Check fallback error and order
Message-ID: <Ztij2o6O9jbAdMiJ@google.com>
References: <20240904064131.2377873-1-namhyung@kernel.org>
 <20240904064131.2377873-9-namhyung@kernel.org>
 <CAP-5=fWnAwVumJgypta=RJV4JBN7A82bn4aUuNJX4G3Xi0zfhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWnAwVumJgypta=RJV4JBN7A82bn4aUuNJX4G3Xi0zfhg@mail.gmail.com>

On Wed, Sep 04, 2024 at 09:19:25AM -0700, Ian Rogers wrote:
> On Tue, Sep 3, 2024 at 11:41 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The perf_event_open might fail due to various reasons, so blindly
> > reducing precise_ip level might not be the best way to deal with it.
> >
> > It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
> > given precise level.  Let's try again with the correct error code.
> 
> We also have pmu's max_precise:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.h?h=perf-tools-next#n91
> The reducing the precision approach was iirc taken for AMD who will
> forward some precise events to IBS, but the max_precise on the cpu PMU
> is 0. I think because of this, reducing the precision below
> evsel->pmu->max_precise shouldn't be necessary and another fallback
> may help better.

Internally IBS has max_precise of 2 and I think it should have that in
the sysfs.

But I found a problem with this code.  Now cycles:P would stop at 2
because after that it won't return EOPNOTSUPP.  Instead, it returns
EINVAL because of exclude_kernel and PERF_PMU_CAP_NO_EXCLUDE.

Maybe we need something like this.. :(

Thanks,
Namhyung


diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0133c9ad3ce07a24..6157dc68044eb389 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2587,6 +2587,13 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
        if (err == -EINVAL && evsel__detect_missing_features(evsel))
                goto fallback_missing_features;
 
+       /* HACK: AMD IBS doesn't accept exclude_*, forwarding it back to core PMU */
+       if (err == -EINVAL && evsel->precise_max && evsel->core.attr.precise_ip &&
+                       evsel->core.attr.exclude_kernel) {
+               evsel->core.attr.precise_ip = 0;
+               goto fallback_missing_features;
+       }
+
 out_close:
        if (err)
                threads->err_thread = thread;
