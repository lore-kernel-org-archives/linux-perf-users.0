Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC063A89CC;
	Tue, 20 Jan 2026 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768940931; cv=none; b=uThf4Yej6FWyZg+GEDKRkxNK3txxs94N+yLZhfvOH4RI3/cIzlWG4pKr6b7PynVkyTrbvTDVXnEdJs3ssD0onu3VkL0AqizWR4gMetIxODnI1a4OcX2mjA0G0EZHbxirA5LzRo790+IDiu+/JONZSdg7ng3oTyAnO9h2JGA4H/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768940931; c=relaxed/simple;
	bh=S+EooQ7GlTBK8gMrVfBuRTV8I4TyAXJP9I1rGzVjhyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnwrR0g27zCb4TxkjKDUVRTc8+enbqSGVJR1Wi/wwlEfNPvxHNlez7Q15Y6bMGo4FeDwTrXH1u+Dhrczu/Qlq7RPkf3X/b6OQs6cKh/hVqjQ23Udw73oOUmfqVBJk/4Poznb7/+K6OpCqWZnzRdGf4NoZXEbF3+SJX89FDUr2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkoZ8BNa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkoZ8BNa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DA8C16AAE;
	Tue, 20 Jan 2026 20:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768940931;
	bh=S+EooQ7GlTBK8gMrVfBuRTV8I4TyAXJP9I1rGzVjhyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LkoZ8BNavPjES4DcMY2X5Ho0xzFQn9KF3OrN+3QR2cCsExjC/HbVcA8hGNOwj9PVj
	 MyG8IFSzXOvH0CS2VXwTYN798mJQbxgRtD0Z7Xl2CFDyZjhMehMMSTx7RwrkBBWKmI
	 URjyTNsJUKrzcjU9O7kBXC3mqynVayzQ2PWg7tR34Pt1hvE7DhPkb2bjssPoFKHtwv
	 8fZtuH6bBx/79AbHxibIk0uQnK1Z/DwfdU4Hxv0264QFuRbXgC4Qg3KFOT8xrNM88a
	 rQwtf/uZqy1AQ3wNt4qM6RHIx2NYJIaO+qBR8IZdQztbk06M+d4JrUCbrnZF38Oxe1
	 qVvGPgCPm5t6g==
Date: Tue, 20 Jan 2026 17:28:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Haiyue Wang <haiyuewa@163.com>, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf tools: Add the legacy-cache.json to .gitignore
Message-ID: <aW_lf4P_bRXcv5mQ@x1>
References: <20251208021524.10101-1-haiyuewa@163.com>
 <f08a244f-864f-4e68-b448-c17ec9ff89b2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08a244f-864f-4e68-b448-c17ec9ff89b2@linaro.org>

On Tue, Dec 09, 2025 at 12:55:45PM +0000, James Clark wrote:
> 
> 
> On 08/12/2025 2:15 am, Haiyue Wang wrote:
> > The commit 0012e0fa221b ("perf jevents: Add legacy-hardware and legacy-cache json")
> > will auto-generate: "pmu-events/arch/common/common/legacy-cache.json".
> > 
> > Signed-off-by: Haiyue Wang <haiyuewa@163.com>
> > ---
> >   tools/perf/.gitignore | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> > index b64302a76144..5c59f954f52a 100644
> > --- a/tools/perf/.gitignore
> > +++ b/tools/perf/.gitignore
> > @@ -36,6 +36,7 @@ config.mak.autogen
> >   util/intel-pt-decoder/inat-tables.c
> >   arch/*/include/generated/
> >   trace/beauty/generated/
> > +pmu-events/arch/common/common/legacy-cache.json
> >   pmu-events/pmu-events.c
> >   pmu-events/jevents
> >   pmu-events/metric_test.log
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next,

- Arnaldo
