Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0B2AE7E;
	Wed, 30 Jul 2025 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899243; cv=none; b=GG8nwKKreEAIZ5cNK8fY+3NnT4gm1JgBpasjRUEVfbgfGZcPCnMY2XxihmEcqOb19n/WpZd6uwhtpvbMuKGg0tSNWbNMW8uMouGz+Qyzuwqcnt2uxTKZlKm4Kf/USCLcKCpwhRdZBD3vzTmsCBl8yTEbhlhd1Cw1f1A4n6u8gVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899243; c=relaxed/simple;
	bh=Vq8PPeNCXUI/fWm/2cwO0dyobdGpAvdWfjsOkRbhjRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujJDa7irZNVJ8f1jhM3Xcolh0cqtyRuo5DNQrNg+sj9FrQWLPuoQ5HvpuqTBdsG1qccVwCHu5Eh4TGn5Z3gjI1F/swH7+G0Rr2gCwWi4/o85Pxq2GA2p5hCn4t6ulBLHoXOBMjxe1PLM+tEYcTEei83T/FGpHEtjaPhM7pLN2ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdiWs3Dj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdiWs3Dj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9CCC4CEE3;
	Wed, 30 Jul 2025 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753899242;
	bh=Vq8PPeNCXUI/fWm/2cwO0dyobdGpAvdWfjsOkRbhjRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdiWs3DjAuGYlmnTYjuMwsIy7OmvqE+CPYmlNWrqL0UxNW8TkiClKjzBBvdpoHlzK
	 ovXDea+ZcTAK2gprbNQEoVl465xzpYeH7UrUnlcFFs+J8WEp5I6Kaw/YkwZLYNZM5w
	 MUsgLz/RzwADdRsHUC0cnE+b5dT2t4L6BsNjYk1bl4U8kKhj7Q9rgJxzKqzdqcojlX
	 iboI1KTvYPKULhb6/jfIiJnHgcbkkvWEdeOz43oTcI5i8EaCw0QgApPQDQC4U95zo4
	 9SWv9r3FD9mcp80R6Pm4lFP9rJmWZ6ErIG2rb52SzDybZrNDJEYi9nBnrVT2iycnEO
	 Zunx49Yg3ckyg==
Date: Wed, 30 Jul 2025 11:14:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	James Clark <james.clark@linaro.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf topdown: Use attribute to see an event is a
 topdown metic or slots
Message-ID: <aIpg6OsDZNeG1mRX@google.com>
References: <20250718132750.1546457-1-irogers@google.com>
 <aIA09RLkeKjeUCnB@google.com>
 <4354cb25-3999-489a-9154-c6ce45f2be23@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4354cb25-3999-489a-9154-c6ce45f2be23@linux.intel.com>

Hello,

On Tue, Jul 29, 2025 at 11:21:32AM +0800, Mi, Dapeng wrote:
> 
> On 7/23/2025 9:03 AM, Namhyung Kim wrote:
> > On Fri, Jul 18, 2025 at 06:27:49AM -0700, Ian Rogers wrote:
> >> The string comparisons were overly broad and could fire for the
> >> incorrect PMU and events. Switch to using the config in the attribute
> >> then add a perf test to confirm the attribute config values match
> >> those of parsed events of that name and don't match others. This
> >> exposed matches for slots events that shouldn't have matched as the
> >> slots fixed counter event, such as topdown.slots_p.
> >>
> >> Fixes: fbc798316bef ("perf x86/topdown: Refine helper arch_is_topdown_metrics()")
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> > Dapeng, are you ok with this (or Ian's TMA fix v3 below)?
> >
> > https://lore.kernel.org/r/20250719030517.1990983-1-irogers@google.com
> 
> Sorry for late response (Just back from vacation). The patches look good to
> me. I tested these patches on Sapphire Rapids and Panther Lake, no issue is
> found. Thanks. 

Thanks for testing this!
Namhyung

