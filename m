Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8DF1A7250;
	Thu, 19 Sep 2024 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739605; cv=none; b=WcOIe3ufpxqQ5WWnC25DeB5mDibNp9xX+hm7l+26TJT+wFRAcEBw14CtLm6t0Bq88FEoyq/6vfBYNVF1FLIhTZSbeddYVQkuIwNh2qxUg45P3RlQ5ZYXIOrashgishgsll62FqsD2UySvqHctfxQOM1DcPICoiGFUFAooiDoNdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739605; c=relaxed/simple;
	bh=4CmeJowxKLZLKcR4giaMSaP0GKjiObmkswPpirFduK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbFHAWGEm1GCFxEqLhAbLXoiySjCTbIpFMJynEWnb7n7S1pV+waSDcIhGi2FevfOvYfaUQm+vHBylTScu9y9JNDbWLMSds1RzWeNHRMnD6D4hPlFAsAxIpQknuYUXeVO8Ue5n6p1vK04TGbTfA9LbQD3ueEyg9bdwpz3+9iLunE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHzYN68c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHzYN68c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F31C4CED3;
	Thu, 19 Sep 2024 09:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726739605;
	bh=4CmeJowxKLZLKcR4giaMSaP0GKjiObmkswPpirFduK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHzYN68cWGKZJRNia8nfhzyVquDDghI0vL39OBjW9SIcjv9e9dgfEhQnwwW/pnVfy
	 BY6K8EMuWRf+oWnsYhgeBp9xb3FcmHA73U0pMMW+7CU+YDYJmRpJygpaBLaqEQSBH0
	 sHATlJ5gDww/Pld78BuK8HQg1W/UOaa675i8GXr5VgVufj0tmjhkDyJSO0c7Q2ZHNX
	 E1x5hfrU4xs+DwTmwg+E5P8fJWQdsciWmnMW3iSztBxbHuQ1hZ3X/RnxyqvyDOvX/t
	 J5I/Qcz5FI0shekv5Bn4bXVsqY+A8XYnxZM7XHkvVe0QOkNqh+WtYC8bTfOXb4kgks
	 qlsbqAZWPHbHA==
Date: Thu, 19 Sep 2024 11:53:20 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [GIT PULL] Performance events changes for v6.12
Message-ID: <Zuv0kA-um9ZT-Tjd@gmail.com>
References: <ZurLc9qEjBH9MkvK@gmail.com>
 <20240919082624.05ca5fd6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919082624.05ca5fd6@canb.auug.org.au>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Wed, 18 Sep 2024 14:45:39 +0200 Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Please pull the latest perf/core Git tree from:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-09-18
> > 
> >    # HEAD: 5e645f31139183ac9a282238da18ca6bbc1c6f4a Merge branch 'perf/urgent' into perf/core, to pick up fixes
> 
> >       perf: Generic hotplug support for a PMU with a scope
> 
> This commit introduces a (reported) build warning in some configurations:
> 
> https://lore.kernel.org/all/20240911153854.240bbc1f@canb.auug.org.au
> 
> That turns into a build failure for some configurations :-(

Thanks: I've queued up the fix for this ARM warning in perf/urgent and will 
get it to Linus later today.

	Ingo
