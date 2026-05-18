Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277563DF00F;
	Mon, 18 May 2026 06:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779084774; cv=none; b=d9b+ywfaZrR95dSIkJLoL/bytcp5SsRt+m1c5y1rbsLFbLeY6hc7f8oYMEn+zfiHgYIN/oroBZERErFcW7fljWycrvKwDiB0TmWTElpm624dkGQS9TNtYceAnuFkYKzH7LbjxnCuFfu6IE4LXM+x0bKdkWwN03Pf2+tA2womeQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779084774; c=relaxed/simple;
	bh=cmW47h1N3C1ApXsJh8U96zGnZ7wWIBEJGi1VKE6Z9GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAYLYYZnEQPm703OLRbPALz7RMdwkK/iXzPPz0NsuWfZolvHcy3k86HeI6IA8Go09cP6yigU8BpN9aySEUZf0rD7ZISMqxIfgYziFdzQ8oJ4uFbcQaIGjY/nHRia1o+EdtvHf/Q451Bac8xRfdfLEoSeYFh4uvVX5tucCIHvt3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbS+MVdB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbS+MVdB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3908FC2BCB7;
	Mon, 18 May 2026 06:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779084773;
	bh=cmW47h1N3C1ApXsJh8U96zGnZ7wWIBEJGi1VKE6Z9GE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PbS+MVdBc+u+VJjVs19UKn9E3xWONbgT2lQfrjyacXaH0Dq8SJkpY2fDQvftzFRmQ
	 VXVE32LlwR1d+6RYHUYRXUGDVo9EtVLlURf9BRtEVBWTcWNTmmtbaUotDiWt9sDM+v
	 u28OTAe/UMZKcSY15YD4E4gMMDMtf1VR25vC8VM9Ovp5/vPwLsQL4mvAev2FUE2Pb/
	 iw/r0nDo5JqBxcynLm4atAS7oWd2HOIW21kVfSPH7u5DX9ZbMFv5RnR4qRPt7HW+GY
	 0nO3KuZH4FtxIEsaEsnG8XJR4WoMrgimQ4ztts3yJM71LFPX61WXGD+UO9cqU4Al7t
	 dP285yXEYefZA==
Date: Sun, 17 May 2026 23:12:50 -0700
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
Message-ID: <agqt4sGEQxcYg7ko@google.com>
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
 <20260515173852.1378571-12-irogers@google.com>
 <agd2-MgXgs---InR@google.com>
 <CAP-5=fXSLgN6hXtQattTp9gqxBkO1gi97EWRF45_0ZKQcK0Z+A@mail.gmail.com>
 <agpi522tGtMWwvld@z2>
 <CAP-5=fXJhx6enPranMaTsDcbf86bJMx7kvHeRGSFkA_+8mRB6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXJhx6enPranMaTsDcbf86bJMx7kvHeRGSFkA_+8mRB6g@mail.gmail.com>

On Sun, May 17, 2026 at 07:33:32PM -0700, Ian Rogers wrote:
> On Sun, May 17, 2026 at 5:52 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, May 15, 2026 at 04:05:40PM -0700, Ian Rogers wrote:
> > > On Fri, May 15, 2026 at 12:41 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Fri, May 15, 2026 at 10:38:48AM -0700, Ian Rogers wrote:
> > > > > Currently, jevents.py parses hundreds of JSON event and metric files
> > > > > sequentially across all CPU architectures during Kbuild startup, taking
> > > > > ~3.3 seconds of pure single-core execution time.
> > > >
> > > > I'm curious about this.  Does it really need to parse all architectures?
> > > > Oh... is it for perf stat record/report?
> > >
> > > So it is controlled by JEVENTS_ARCH and JEVENTS_MODEL:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/Build?h=perf-tools-next#n24
> > > The default for JEVENTS_ARCH is SRCARCH (e.g. x86) while JEVENTS_MODEL
> > > defaults to "all". We have a build test for JEVENTS_ARCH is "all":
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/make?h=perf-tools-next#n74
> > > So saying "all CPU architectures" is a bit over the top, but not
> > > wholly inaccurate.
> >
> > Ok, so it's all x86 models.  I think it's ok to have "all" for build
> > tests.
> >
> > >
> > > Fwiw, I created a script to convert CPUIDs into models:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/models.py?h=perf-tools-next
> > > which maybe could be used to reduce the perf binary size by building
> > > only the native CPU's JSON. It is a useful script for debugging :-)
> >
> > Sounds like it should be used by default to pick the current model.
> 
> Having a build of perf tied to a particular model like Skylake,
> doesn't seem very good for distributions. I think the default should
> try to match what we hope the distributions will do, so an x86 binary
> should run on all x86 models.

Oh right, distros will need it.

Thanks,
Namhyung

