Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD822E888C;
	Wed,  1 Oct 2025 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328100; cv=none; b=W43t2wZ8t39BaHYncqg1D6xJcqYDrDBOLp5Sq1z8qMgIITygXzWRirdDhzNe3+PBhaJ17lAAYkOIbXVuy4qV9hwAA5yZD3DXCJU+HRYTBMzuM52AJDAOuS6C8hwBGILxb4IUppmFb83wcOscdffskjfgUyHkgO79NW19T0WJgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328100; c=relaxed/simple;
	bh=nQic+VLci5XqxwF9N2qBEMgmpbs4SRbRbJmzysZjCjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYBTwTvT4mHYcRQF/Rcm6AJ+znHxXke9VHpeUZE/GA3HPiehDlmNgswFAhdtsHLcoqXf5mAIKa/hSSQylaSoG4GP1zMjtw77yTrW6nvY4igLjslp9pz9OBrNse4a+JuIsMNmJQrYupb6c36UEz0qLMCLiF5q1enQ3jAQDyUXgsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dodkX1ad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dodkX1ad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5ECC4CEF1;
	Wed,  1 Oct 2025 14:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759328100;
	bh=nQic+VLci5XqxwF9N2qBEMgmpbs4SRbRbJmzysZjCjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dodkX1adpvOAzilMHv7Jyp1+GtxiLIUqLV2Lvrb9jr2SI6W7AEEb6Yve+lQUGkWDo
	 EEGjeO9efkiDUbm8GtyYpydM1GRlaHqkuPe17xI61b6xL9jsxejH7PdmAsdnjWX9Nw
	 CaTMkD/0ud/bIsOcD+WLcFAr6C9r/1lbWjan3tRMYwXtfJ87wA17XubagoxqC8hmaD
	 ZApmxNV5Q1A0TMrsSxX5e7TFaeblcDBpGNP7BG6BpzGY9QB5IfTz+Ao4lWx2jame5m
	 IpiT+eyz5qU/qY+hK5OXKeegjF0gvDlrO0HYmfck9X1GDapBwOUo9O08murCtWtWab
	 oBfzTGzzORpsg==
Date: Wed, 1 Oct 2025 11:14:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Suchit Karunakaran <suchitkarunakaran@gmail.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] perf/annotate: Use architecture-agnostic register limit
Message-ID: <aN03YZ-GkfTyOD8Z@x1>
References: <20250923174236.12372-1-suchitkarunakaran@gmail.com>
 <CAP-5=fXVFBewYhSmjVCGTbzEN82apECRLRnSeit8rqydCBJ1bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXVFBewYhSmjVCGTbzEN82apECRLRnSeit8rqydCBJ1bg@mail.gmail.com>

On Tue, Sep 23, 2025 at 12:11:27PM -0700, Ian Rogers wrote:
> On Tue, Sep 23, 2025 at 10:43 AM Suchit Karunakaran
> <suchitkarunakaran@gmail.com> wrote:
> >
> > Remove the arch-specific guard around TYPE_STATE_MAX_REGS and define it
> > as 32 for all architectures. The architecture that perf is built on may
> > not match the architecture that produced the perf.data file, so relying
> > on __powerpc__ or similar is fragile. Using 32 as a fixed upper bound is
> > safe since it is greater than the previous maximum of 16.
> > Add a comment to clarify that TYPE_STATE_MAX_REGS is an arch-independent
> > maximum rather than a build-time choice.
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
