Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EA53A1B5;
	Mon, 18 May 2026 00:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779065578; cv=none; b=Mi60bc2w/7ty/nJ9wlHri+zb8JR6bbi3Q226zVMCrr7K6/I7msfte4eLnKtTBkKlYRLe+LoM1UhYno4b37g0kYfFz2jbyBOLfFWILRLN7TwM2ClLefx2JX27ytRTPEetHXQYQfLWedvwJPOoqNhd+jhVOiYAnZKhZWae/JGFBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779065578; c=relaxed/simple;
	bh=BzzgyqiaawFUyLR6TD77S8sAPXAGNJOFO7uGwNcPFpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sd0rIpuVqbH2ErllYIpumzJ5h4YV/6It2VLQF+iAHvmBgh4JSU0PcZ0CM6Z90jXyIDHgv5C1FSkWB7oxHK9Yo3xPsEAEexhoEhKHCNR5ceG+TSpFqZeGHqi3R4TyQg3jR6vw4Nc6fofAkZd/fHmfKsk0Bu2sv8QdFIL4xv8kK1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL8SAZdf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL8SAZdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D1AC2BCB3;
	Mon, 18 May 2026 00:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779065578;
	bh=BzzgyqiaawFUyLR6TD77S8sAPXAGNJOFO7uGwNcPFpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hL8SAZdfhUg1An6pQ6Ouv5tqjisDJ3fH1XNezNNbUa5za/geR7S3xnoJg/c1N2Azl
	 6dda/1Oz+vxVu2pOAGQyvPxG4ixT3nxBDZKu0VA1yNitMXpHQp3qgwOMl6zkC4ap90
	 CO1p7NAJtOJhlojS0jjLWEatZ/1/67hMIUWOUbPHt2nJnQaY9Oh5OFFGXuYl1LwWFb
	 lJii/lmNmCdd9jknw9f9h8NWrisJ6Rcu0e5zxJslVF2wTLI6HnaYq2lkrBVC6Fseeh
	 3QJNxot5kqlfx4ylD5qPI2XHLbrTE+Z2CnTo8lqZLNJOsjI64H6s4jJEdYUpz34Xg9
	 qRRHtKvogyI2Q==
Date: Sun, 17 May 2026 17:52:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, james.clark@linaro.org, 9erthalion6@gmail.com,
	adrian.hunter@intel.com, alex@ghiti.fr,
	alexandre.chartre@oracle.com, andrii@kernel.org,
	ankur.a.arora@oracle.com, aou@eecs.berkeley.edu,
	bpf@vger.kernel.org, collin.funk1@gmail.com, costa.shul@redhat.com,
	daniel@iogearbox.net, dapeng1.mi@linux.intel.com, dsterba@suse.com,
	eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org,
	leo.yan@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev,
	memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com,
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org,
	pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me,
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com,
	tglozar@redhat.com, thomas.falcon@intel.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v4 11/14] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
Message-ID: <agpi522tGtMWwvld@z2>
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
 <20260515173852.1378571-12-irogers@google.com>
 <agd2-MgXgs---InR@google.com>
 <CAP-5=fXSLgN6hXtQattTp9gqxBkO1gi97EWRF45_0ZKQcK0Z+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXSLgN6hXtQattTp9gqxBkO1gi97EWRF45_0ZKQcK0Z+A@mail.gmail.com>

On Fri, May 15, 2026 at 04:05:40PM -0700, Ian Rogers wrote:
> On Fri, May 15, 2026 at 12:41 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, May 15, 2026 at 10:38:48AM -0700, Ian Rogers wrote:
> > > Currently, jevents.py parses hundreds of JSON event and metric files
> > > sequentially across all CPU architectures during Kbuild startup, taking
> > > ~3.3 seconds of pure single-core execution time.
> >
> > I'm curious about this.  Does it really need to parse all architectures?
> > Oh... is it for perf stat record/report?
> 
> So it is controlled by JEVENTS_ARCH and JEVENTS_MODEL:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/Build?h=perf-tools-next#n24
> The default for JEVENTS_ARCH is SRCARCH (e.g. x86) while JEVENTS_MODEL
> defaults to "all". We have a build test for JEVENTS_ARCH is "all":
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/make?h=perf-tools-next#n74
> So saying "all CPU architectures" is a bit over the top, but not
> wholly inaccurate.

Ok, so it's all x86 models.  I think it's ok to have "all" for build
tests.

> 
> Fwiw, I created a script to convert CPUIDs into models:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/models.py?h=perf-tools-next
> which maybe could be used to reduce the perf binary size by building
> only the native CPU's JSON. It is a useful script for debugging :-)

Sounds like it should be used by default to pick the current model.

Thanks,
Namhyung

