Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A47A3B42FF
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334396; cv=none; b=A2rnG1fXJ9bcZM0MrFhUpZGQiXLS9+VDiXH5cH3Zk97+htbkHtXBj8qS4/kwCBLuQOVr3p3yai9oz8IZrG5ejl5fRSSyoOr0hZXhMYqtqomJ1JR+dY75zPfFun5WOOPIecLqiBImKqxoBcnE4Z8nCvvnSEoo4y2TqusLEaPMxo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334396; c=relaxed/simple;
	bh=mmHuEFwKy8hIf8loZ8pNHRfJ4gO4I7H9s2m+Fwj408Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az5sv8pAhK6GaJwlOJ8y+GT9gWXlKvUbSwarr7o3eil9y4dQoWAaGPKvod4fF4nPAJlJAGGBCq03hb4M1YDLtYQZlakldXaZfgXZPZL7OkB3HQpMQC1KD3YxgfCq4ZkwgovqzlTjtepHESxYvf0h8AU7A0ZouWqFsReCtoPsEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI8rqfNW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI8rqfNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA2A1F000FF;
	Fri, 25 Sep 2026 11:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790334395;
	bh=BZE/mS5MeOWWJ2yYBa2PFomFqRAzGZRvKwDM0lCOOMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MI8rqfNWn1i6QidqsV7dd0Af9heRII7ZwB4jqhopcqp1+VKyw5IEqcSTwxKzuZA8Z
	 rVINLN1E6KAkj9SGJKs6QPvf4U1p/Ch3eB0RHDCu6GejpRunWf12IAtvk7VyrQYMW+
	 6vsG66Qz1zvt/4s7IXRWKFUuSqQ86tNuHZaFEhAsHxQfZuFYCGETf10Dmjr5JfC+jg
	 AOVjX5LjcuOq7MeqCUPht+6LcBlm4cHw9B5/h+zq15O0Wd/MgWytj0TbHkeayJAAMh
	 7V8gr9jZVkzS4bAbDesjLU8QjF3+JRVzL/bjBdz5sZJr2PIs5VG3XuLB4+zyzZtHAa
	 wSsza2Jlj0C7w==
Date: Fri, 25 Sep 2026 13:06:31 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf: remove unused empty help-unknown-cmd.h header
Message-ID: <arZVt6gDYTJkaTBH@x2>
References: <20260918032356.466938-1-enelsonmoore@gmail.com>
 <CAP-5=fWS6TOnfq2WmJ_HOhkySF8XRQf92Zo2XhZSFJVv8XFSWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWS6TOnfq2WmJ_HOhkySF8XRQf92Zo2XhZSFJVv8XFSWw@mail.gmail.com>

On Thu, Sep 17, 2026 at 10:12:44PM -0700, Ian Rogers wrote:
> On Thu, Sep 17, 2026 at 8:24 PM Ethan Nelson-Moore
> <enelsonmoore@gmail.com> wrote:
> >
> > tools/perf/util/help-unknown-cmd.h has been empty and unused ever since
> > it was added to the kernel in commit 5feaac248a46 ("perf tools: Move
> > help_unknown_cmd() to its own file"). Remove it.
> >
> > Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> 
> This seems like an accident, the declaration has been in
> tools/perf/builtin.h ever since the commit above. Perhaps the header
> file is a more natural location, but an empty header file is clearly
> useless.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
