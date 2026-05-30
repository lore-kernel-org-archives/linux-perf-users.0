Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E224503B;
	Sat, 30 May 2026 00:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100501; cv=none; b=psCiifwCpGwZ9V6/5Tqtwhgz7R6Ahxh4pGrOBK+98bvgcyUEC1qe7ZEXAYAs0ocGYC077M362mXlmofghRqtKFW19pNVPo6JEGuAfpOZuNJOQPGE2tae925yEJ939aelkHqt2m4Ib8IC2SvUNUuWfFiDVsEJOt6WATgev7l8T18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100501; c=relaxed/simple;
	bh=mDyBeowrzO6CT1JbxNNDEqF9/MuQ4Qc6sXN4nx0enGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpvcSiclvpu7PV7IG5B2uW50+gaiPApixhZGw8MNFB8UiGE8eRRYwHDHbinMgJwOqn8VripQfJhGl49HRjGffYECFkSMbM6twgB7wrXUVfjm8yM9vH0AInAxI6I3MRpRWzm274QLfxzNyYLh8qzdpnZJp6VwqzJPNeKrFVRM2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOxKEwtI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOxKEwtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B751F00893;
	Sat, 30 May 2026 00:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780100500;
	bh=V5GNFJ4Xqacwf/59lf9njOjdAKWktAcI2QuStYFAieU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KOxKEwtItJt0405ODMLJj0gHp2T/A+9TdbRq2I9v7UcBiMdDiB6DcjXrBC85JHd93
	 T8KvGwboAr9pMfZEkesCTDSsV0Hp4Meb/N92DoELiib1ZIrMdCj5UG+D/DNEvEa/nk
	 SEPzG2wua4by6SgXl6lyVIobHsrZ8ZUMCWMrAQE24gZQkL3775egqUK3yxj8gzMEo7
	 S39z/+V4fQsE5iG5UYkOJyQjfvuH0kc53PZJojTcNHh0XwqwdTglQ5VC+j5nYoiRGw
	 PIxbM62tXnC6SYJsyCrvvvE/OojdZ4YL3Bg4xNShJHFH1ormV103e7hVcWFRhrBIPb
	 jfyzCX98/KpzQ==
Date: Fri, 29 May 2026 21:21:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH] perf arm-spe: Don't warn about the discard bit if it
 doesn't exist
Message-ID: <ahotkEL09FARMsRB@x1>
References: <20260410-james-spe-discard-warning-v1-1-985c02756ee4@linaro.org>
 <20260513102024.GE34802@e132581.arm.com>
 <CAP-5=fUoebOVhWvTbgkyY6erZJjbLRbRVk6oauVKjtHGGgMyaQ@mail.gmail.com>
 <bf58d60f-1483-4832-9424-5e85e0e5f943@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf58d60f-1483-4832-9424-5e85e0e5f943@linaro.org>

On Fri, May 29, 2026 at 10:42:34AM +0100, James Clark wrote:
> On 13/05/2026 1:55 pm, Ian Rogers wrote:
> > On Wed, May 13, 2026 at 3:20 AM Leo Yan <leo.yan@arm.com> wrote:
> > > On Fri, Apr 10, 2026 at 12:05:12PM +0100, James Clark wrote:
> > > > Opening an SPE event shows a warning that doesn't concern the user:

> > > >    $ perf record -e arm_spe
> > > >    Unknown/empty format name: discard

> > > > Perf only wants to know if the discard bit is set for configuring the
> > > > event, not in response to anything the user has done. Fix it by adding
> > > > another helper that returns if a config bit exists without warning.

> > > > We should probably keep the warning in evsel__get_config_val() to avoid
> > > > having every caller having to do it, and most format bits should never
> > > > be missing.

> > > > Add a test for the new helper. Rename the parent test function to be
> > > > more generic rather than adding a new one as it requires a lot of
> > > > boilerplate.

> > > > Signed-off-by: James Clark <james.clark@linaro.org>

> > > Reviewed-by: Leo Yan <leo.yan@arm.com>

> > Reviewed-by: Ian Rogers <irogers@google.com>

> Ping, thanks

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
