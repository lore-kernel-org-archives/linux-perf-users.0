Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FDF255F2D;
	Thu,  9 Apr 2026 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698812; cv=none; b=b7sK6R3LqxqcvK+eYU72eb05paNIrCtx2gAC7cTLhJV3Se6bUh3yuafRobdlsOpcSbbv3HLnkgwgIN+gzUfo/UJsjGsD+slbcPQKVkpUflPl7PCg2O674BR+e9EmBoIRAHA37CLq7yywiMRiT06BwO0WymzoT3Don/8LNBlqaxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698812; c=relaxed/simple;
	bh=kRk1tClvEoWCo0S8Wt9II+hhTSZMcgXt/MhWHGKm0qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiTC7sXZyal6qeUks49mCJr/ttUySoA5Fu0B2ihtR7pi/O/v6o1sM8XK4c7WFcCiCAlDPnD5gNpm7aPEEBexJktcdlBS6rGJwNmfqzM2yytQUr9EaAnF8v031qCOAwcU3XSRigaSaZyQRwzYq+o/yDUv+EtsCBoKTuWOJmsK4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRc2zkE4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRc2zkE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CDEC19421;
	Thu,  9 Apr 2026 01:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775698811;
	bh=kRk1tClvEoWCo0S8Wt9II+hhTSZMcgXt/MhWHGKm0qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRc2zkE46N+FSN7HK8OtEWOxZ0dMXKUJHR5lchr16ZCWYUbjJ0WA7anU6ruPxxhDp
	 BJrPGLWu+Ey2qHbA7qKaejJIOz9WsbXfHLpAUsWKXO+5HoQsEf0TavnZyUjf874eOi
	 LlWMBrQH2z9Ldx9Afv/mVZIqFwBOKQ7t7a6VAMZ8TxUfEEglsde0jMPu4mrqT899uE
	 X6tBJ0UUMOS7g86a5ipVs58LQxJohUkCQSfwOwi94JVV65K2QwMpW334IhWf1ljJfz
	 9DbWeUBJiFqcnUaNTxtOPJfehslmAGWNGrwmZqZCVOv+Hrq3gjAPzVxmVuyZDCd6Rx
	 7REQKusf8fYOw==
Date: Wed, 8 Apr 2026 18:40:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v6 00/25] perf tool: Add evsel to perf_sample
Message-ID: <adcDd0eV1KQemet0@google.com>
References: <20260403204017.2919994-1-irogers@google.com>
 <20260404034325.3172592-1-irogers@google.com>
 <adNOd_yaPL3nlXUr@google.com>
 <adPyeCq3rQrTurju@google.com>
 <CAP-5=fVyn+pLUnbMQ_XukhObb=qQiMuvus2g4p4Us+sY06rz7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVyn+pLUnbMQ_XukhObb=qQiMuvus2g4p4Us+sY06rz7g@mail.gmail.com>

On Wed, Apr 08, 2026 at 12:30:05AM -0700, Ian Rogers wrote:
> On Mon, Apr 6, 2026 at 10:50 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Sun, Apr 05, 2026 at 11:11:03PM -0700, Namhyung Kim wrote:
> > > On Fri, Apr 03, 2026 at 08:43:00PM -0700, Ian Rogers wrote:
> > > > Nearly all perf code ends up passing an evsel with the perf_sample,
> > > > which is problematic if you want to rewrite the evsel such as with
> > > > off-CPU processing - all uses of the evsel need fixing up. Previously
> > > > I'd mailed this patch as an RFC with everything combined:
> > > > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
> > > > and there was a request to break it up.
> > > >
> > > > I've started the series by adding documentation to struct
> > > > perf_sample. Next I fixed missing perf_sample__init/exit largely from
> > > > the recent perf inject callchain rewriting work. The 3rd patch adds
> > > > the evsel to struct perf_sample and ensures it is correctly
> > > > initialized. The next 22 patches avoid passing the evsel along with
> > > > sample for different parts of the perf tool, along with some minor
> > > > tweaks like constification and not determining the evsel if it is
> > > > present in the sample.
> > >
> > > I'll test and process the first 3 patches first as I found an issue in
> > > patch 6 and I guess applying patch 4 would break partial imports later.
> >
> > Applied the first 3 patches to perf-tools-next, thanks!
> 
> It looks like you tweaked the documentation of struct perf_sample.
> There is a typo s/PEF_SAMPLE_IDENTIFIER/PERF_SAMPLE_IDENTIFIER/.

Oops, sorry.  Yeah, I think it's in my earlier review and forgotten.  So
I did it myself but made a mistake. :(

Feel free to send a fix.

Thanks,
Namhyung

