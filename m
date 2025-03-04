Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569861F63E1;
	Tue,  4 Mar 2025 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113814; cv=none; b=MDoCNKGkynwzjjMkHi3rU/AUVCshG22nKcbCB461LPYYVJjPxZGYg6B//9BuiyjV/ivxdsXmNmkOTg8xc6tOAnQPo1CXabBXAloNS/UTBryXj4//y4MEb3SgUWfB4ogHy6HfJUOybUzBhcPwqpt+Fy2yzlrFxgru0mtYXx9AiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113814; c=relaxed/simple;
	bh=MaCdA5ZR6l7zULNgrfHmO/03rDMi0kLhXHTr9N98E+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEyhTYInlLnTFenctD4VHcn4XD/u0X/nVs/KwmbYmYY4o3dyH0DoplKtW83jk4TgS37m9t54edZ9/qQxHGsLW8jy6gqsB1o1Wavl5abY/kChAYtH7fZ0+ybkPjj3jlOAn0CKTDAA7wNlSShPEPrutsF3eEfButeVEuWmLAL2AGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqcGzJYU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqcGzJYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E66CC4CEE5;
	Tue,  4 Mar 2025 18:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741113813;
	bh=MaCdA5ZR6l7zULNgrfHmO/03rDMi0kLhXHTr9N98E+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqcGzJYUnUMbMA8p6Xw5DhbbdRmftfzfiR8HsuWPyAXJuhhlK+TWF2FcfQQ+0RS7a
	 LtbXJZWdAVtwFiNexFEBJlaF0uhp2yXqrCIHWviOIOF4W6dJ89ZN8GlQarfJw5yf/4
	 sgt98rxb8LPG8D6VWFi1ee6Gm2eIJFNIbDPR5GL+ytMrZlGUGXgjMYKQOJPE2PEFKT
	 eDTJg/iTyevfJo2ShASIYpqmOeB0Yotlzd3Vf4Xn4hmBGuAx5fs4tKnYYjqM8sFleT
	 Y+OCIyYa4OEA0C+650mULD98TNs/Z2Joq6PGsBkLEMx92FxWGxjBmsCL0Rfv36gKOo
	 s+KrmRXmasc7Q==
Date: Tue, 4 Mar 2025 10:43:31 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Graham Woodward <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/12] perf script: Refactor branch flags for Arm SPE
Message-ID: <Z8dJ00nIeVqMMncD@google.com>
References: <20250217195908.176207-1-leo.yan@arm.com>
 <20250303093853.GG2157064@e132581.arm.com>
 <Z8YYY2Q_ZPIaZ74g@google.com>
 <20250304113350.GK2157064@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304113350.GK2157064@e132581.arm.com>

On Tue, Mar 04, 2025 at 11:33:50AM +0000, Leo Yan wrote:
> On Mon, Mar 03, 2025 at 01:00:19PM -0800, Namhyung Kim wrote:
> > On Mon, Mar 03, 2025 at 09:38:53AM +0000, Leo Yan wrote:
> > > Hi Arnaldo, Namhyung,
> > > 
> > > On Mon, Feb 17, 2025 at 07:58:56PM +0000, Leo Yan wrote:
> > > > This patch series refactors branch flags for support Arm SPE.  The patch
> > > > set is divided into two parts, the first part is for refactoring common
> > > > code and the second part is for enabling Arm SPE.
> > > 
> > > James has given review tags (including the new added patch 06).  Could
> > > you kindly pick up this series?
> > > 
> > > Sorry for pushing a bit, as we have dependency on it.
> > 
> > No problem, I'll add it to the tmp branch and run some tests.
> 
> Thanks a lot, Namhyung!
> 
> I saw you have picked patch series v3 in the tmp.perf-tools-next branch.
> On the other hand, to follow up on Adrian's comment, I have sent out
> v4 to remove an unnecessary change in patch 01, and the rest of the
> patches are exactly the same as v3.
> 
> Please consider picking the latest change (either the whole v4 series or
> just the updated patch 01 would be fine).

Sure, I'll add v4 to the tmp branch soon.

Thanks,
Namhyung

