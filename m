Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C847523CE
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 01:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727832169; cv=none; b=RWnnJNcCEonHeN7dsIPirBntBbJ06Q/G56g1wm2pS3a4041nMCWkSMiL+S6rJyNDeuQTdIVPHpDu4aYDgvmqnWrrzEs+7On3weyB/5RsJWatR+wy4xURRNSALeSPQoEZ1gPlaT6DsWtQYBs0pRkWLDuSP7xHAilAxeqvuffB2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727832169; c=relaxed/simple;
	bh=xjJWDCxuCokH0pycmUsWwExA9/0GSxQfw52DjfwNprM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYpHwUXNUv/np+PatE7gnL9U4TwtMzMmOeFU5udYm80Fx2nxfCUOHHJvipD/op/Y+ui/5mjM9LHQ3JTcDlf/6vRlCLPihVkRjtcPasrqXMrA06KdDf2pBEi1T6eNsGrm1JCJHW/Kjq+3GYcgXg40tCCY4LWaqVoUz16Jd59MWY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsQClJjB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsQClJjB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF46C4CEC6;
	Wed,  2 Oct 2024 01:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727832169;
	bh=xjJWDCxuCokH0pycmUsWwExA9/0GSxQfw52DjfwNprM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WsQClJjBmLEKi8fux4FZIrNEdZ38I65mw5n3k+J5f4XWUmfqqJ2rzEKzkm4zvMZc6
	 ++MFqbcsJcFiKGP7S/GJLv0/6Th4rIdcPnyA/SqhXhUzEF9LsPQ0Lo4ELycEF1csAQ
	 30BkhgY/QnqPoGgYji8jnnkJyEaz/JGYtBiH2yF0cPDgwdd/WFH83/KFeA+FHJwLDk
	 mk3uOmJcbV9H7oGWghEczHYykt6BQtaSNPACfG2OLqwgLvVOamApUTUWiiOcujrubh
	 Lw2ADe0p0Tqjv8v+p61TPHfkDAOglrkbhAb1uqsMvnil/bg8eRBRsMUC+rBHcc67ap
	 YIr563v+B3Phw==
Date: Tue, 1 Oct 2024 18:22:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
	kjain@linux.ibm.com, mpetlan@redhat.com, rstoyano@redhat.com,
	mark.rutland@arm.com, jolsa@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: Re: [PATCH v4] perf test stat_all_pmu.sh: Parse return value of perf
 stat
Message-ID: <ZvygZ4GQIusndmOu@google.com>
References: <20240814170146.20678-1-vmolnaro@redhat.com>
 <dd62147b-e9b5-4281-b547-fef46082e4f2@redhat.com>
 <ZvyTE4x9-BxCVx5J@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvyTE4x9-BxCVx5J@google.com>

On Tue, Oct 01, 2024 at 05:25:55PM -0700, Namhyung Kim wrote:
> On Tue, Oct 01, 2024 at 10:35:33AM +0200, Veronika Molnarova wrote:
> > 
> > 
> > On 8/14/24 19:01, vmolnaro@redhat.com wrote:
> > > From: Veronika Molnarova <vmolnaro@redhat.com>
> > > 
> > > With the upstream MR !3916 of commit ad86d7ee43b22aa2 ('powerpc/hv-gpci:
> > > Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
> > > stat for hv_gpci events without required permission set returns an
> > > error value of -1 to differentiate the output from the unsupported
> > > events. The stat_all_pmu test was designed in a way, that if any
> > > command exits with a non-zero value the test exits with an error
> > > value without any information provided due to the 'set -e' option.
> > > 
> > > The issue propagated upstream as the list of the files that affected perf
> > > did not cover the changed files and was updated after the issue was
> > > discovered. It was caught by CKI testing where it was triaged to stop
> > > blocking further MRs, as most of the powerpc machines have some of
> > > the hv_gpci events without the required permissions.
> > > 
> > > Remove the 'set -e' option from the test and rework the test case to log
> > > the status of the event for better maintainability. Instead of exiting
> > > immediately after 'perf stat' ends with a non-zero value, check the
> > > return value and output of the 'perf stat' command with the appropriate action.
> > > 
> > > Link to the MR !3916 of commit ad86d7ee43b22aa2:
> > > https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
> > > 
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Michael Petlan <mpetlan@redhat.com>
> > > Cc: Radostin Stoyanov <rstoyano@redhat.com>
> > > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>

Also, please collect reviewers' tags in the previous versions like
Reviewed-by and Tested-by from Kajol Jain.

Thanks,
Namhyung
