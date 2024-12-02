Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F921DDC24;
	Mon,  2 Dec 2024 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733171286; cv=none; b=hq9bIKF+QHjJZAjEj/NUd2+0jc5Tc01scji3+GXHdLz7ZVLX14h+yTLOEkfp0NYkbbiYDWzLIIvg+96aPmdSDM6M166iLTt8qiio3ErdxadBBD4HpowI5LQUZRwTe5oZIQk8HONuMYlA9FfVs8086Cs69ZC5G5rizlC3f9La3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733171286; c=relaxed/simple;
	bh=9LeDiFpTDfuWGn8VPz0U/7308bndESjHwusLDaDvzho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkP4mtY74dJjpIaF8JoRVexqVwr2jyjSidHyVKmjt0AvbRywlabEfcCOtDw76O5BHmhIbvxnKc8HgHwUUYQ0xpBFdKZi3Whj/+bOACG4AmiyX5qZR+eGknNaHGFf1Vr8EVUwCcm7P/MH1xXpAJUlT0hDtu8j/i1mVmu7IeHGCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoNuyKaB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoNuyKaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3005EC4CED1;
	Mon,  2 Dec 2024 20:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733171285;
	bh=9LeDiFpTDfuWGn8VPz0U/7308bndESjHwusLDaDvzho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FoNuyKaBeYquTfe8O/wzpRy68DqrKl8kZ3XEAeMLayM0TIzPSQxtntHrSeCcoSKiB
	 gKBlJ2VaZwI0LOWzgI8LWx5J1bk5Q7Z4DyUSV4YtfmrfYRvm9A2NMog18PfKEvEjpb
	 x05+y7bdy9oX3mtv7rR1ZbB31GQThW/plc5XG4eQSrYPsKyQ4YdKzglGyN+ORahhzG
	 M23JNDUQ/5enqKw3R96AjV8UNYNx1DgQlda9iuQeP4WsezANMSp6mLJNciavWwkK5i
	 Vjao9yJ+EpoSkwSTlAcmvm0Crp8fNZ65LoU6QvqDns8fPMXmzwaf+jpE1qk5jV0ASy
	 rfUzXHI8gIk3w==
Date: Mon, 2 Dec 2024 12:28:03 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Guilherme Amadio <amadio@gentoo.org>
Subject: Re: [PATCH v2] perf test record+probe_libc_inet_pton: Make test
 resilient
Message-ID: <Z04YU78EMUWhHtXL@google.com>
References: <20241202111958.553403-1-leo.yan@arm.com>
 <2b3bc88a-e435-4ccc-a543-c8f8566dd306@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b3bc88a-e435-4ccc-a543-c8f8566dd306@linux.ibm.com>

Hello,

On Mon, Dec 02, 2024 at 02:48:01PM +0100, Thomas Richter wrote:
> On 12/2/24 12:19, Leo Yan wrote:
> > The test failed back and forth due to the call chain being heavily
> > impacted by the libc, which varies across different architectures and
> > distros.
> > 
> 
> For s390 using 6.13.0.rc1
> 
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks for the test, but I think the patch excludes s390 to be safe.
And I think we can test s390 in the same way.  If you're willing to do
some more tests, Leo can update the patch to include s390 as well.

Thanks,
Namhyung

> 
> -- 
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> --
> IBM Deutschland Research & Development GmbH
> 
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> 
> Geschäftsführung: David Faller
> 
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
