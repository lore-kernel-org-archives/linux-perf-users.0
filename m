Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D73286891;
	Thu, 19 Feb 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527646; cv=none; b=pXQIJGAEMB2B6rZ1qUe7tiHuUk7tCYqlbHVQGpzOewwaEkb6X5B1quBrFQOE25E4ppoEgdZJdKAqpOC7VAkJyyyACX92aqZM8LTEVksab0nouw87DwOK0ialxnNIWKubB511MGcm9zgKV9kCP/jvX8k+tneuOzYid0T7rkMAjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527646; c=relaxed/simple;
	bh=tOUxmlvh0y6gA4TYQBTOESNKuI4IZahsJkpk8/Z0TlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH/53DxgBxv8AsJYIU2BnvijeXXNdthGba6Qzxz+CTqJab58bA6vl2rQcL5qCq1Edlp8F9ktJY285uunyIU9tmPtV85CG2vB0WBPOIh3/o2kPLCgjhk29bN0C/tf8c5apmtbhPhAWqEYW2iBFKWXmgBTB2svDHcSQNsxAIRuEpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbOUMrY6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbOUMrY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ABBC4CEF7;
	Thu, 19 Feb 2026 19:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771527646;
	bh=tOUxmlvh0y6gA4TYQBTOESNKuI4IZahsJkpk8/Z0TlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cbOUMrY6us6gWUUluAZ/11UbZKNDqXrOJq0lWr8uISUPgtYlQYlFTM5FHQ1jYfHrH
	 jfOy8MTDy6QbYsWkUJGmepb7PywXtY+qXaNDVDhBUrK+qgLhpBHu4iL/yZbPFxLchz
	 ccelROPRcw1bQirXjx7tyMDu1H/tZCtTo6fY6bENAT7seStPbDVtYYKjUfndJOnlWD
	 4GtuOUFdZk9vAWsDWmUZKTsj+lmTOt/CNUVqeNUxG5jkj1btZ3ktOse/NczXhf+bJ4
	 6T7Ubag2YMMwHcekLNPM0gnDHdvjNvZ3dbtLHRfyi0y4LIUa5AO4Llol2FA4W1v8Qp
	 RxGZMoTmJJGyg==
Date: Thu, 19 Feb 2026 11:00:41 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf bench: Fix initialization of union
Message-ID: <aZdd2clm2RQGLnT4@google.com>
References: <20260219004417.188434-1-namhyung@kernel.org>
 <a91a44a4-a918-4edd-9fe2-2274d5213dcf@linaro.org>
 <ea82e2ab-ddb5-419b-aa70-49b28f18383a@linaro.org>
 <20260219150256.GC136967@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219150256.GC136967@e132581.arm.com>

Hello,

On Thu, Feb 19, 2026 at 03:02:56PM +0000, Leo Yan wrote:
> On Thu, Feb 19, 2026 at 10:38:57AM +0000, James Clark wrote:
> > 
> > 
> > On 19/02/2026 10:36 am, James Clark wrote:
> > > 
> > > 
> > > On 19/02/2026 12:44 am, Namhyung Kim wrote:
> > > > Recent compilers don't initialize all members (or the largest member) in
> > > > an union.  Instead it seems to set the first member only.  So some perf
> > > > bench output shows invalid numbers like below on my system with GCC 15.
> > > 
> > > I couldn't find V1 of this so I wasn't sure if it was discussed already,
> > > but wasn't the plan to fix this with a compiler option:
> > > 
> > > https://lore.kernel.org/linux-perf-users/20250319110454.3230687-1-leo.yan@arm.com/
> > > 
> > > and
> > > 
> > > https://lore.kernel.org/linux-perf-users/20250320105235.3498106-1-leo.yan@arm.com/
> > 
> > Oh I see V1 was only the second patch, that's why I couldn't find it.
> 
> Thanks for bringing up this, James.  The latest patch would be:
> 
> https://lore.kernel.org/lkml/20250402173056.829400-1-leo.yan@arm.com/
> 
> This patch intends to apply the option across tools, but no response
> from the maintainers.  Seems to me, it may be good enought to apply the
> option to perf first.

Thanks for the reminder, yeah it looks better.

Thanks,
Namhyung

