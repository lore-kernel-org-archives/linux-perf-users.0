Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2776819F424
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Feb 2025 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780696; cv=none; b=CLhvswwxTu6MRMpM9rnkJ0kYk1BQE3jc/kLqSOkcO0HgvcuHobul9TC9OMrlY1BrwRVR/OyXrDZXQtdxKF5vY5nth75409adUrui06PwItg0sg8YL/vbxqx4lbIl+heHlMcQ3/+K1dp4/bX8EqiCVcHgYm96N2l7Kddy59/5fGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780696; c=relaxed/simple;
	bh=RUc43yBbpnO4JZzVyNeqGPwPoHy70gqSiiPq0LEJVgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSLY5ald/9rod6a4KwxNPwmr5p3VA8K0ja37ez4tQxVKwCxTQkJUDyzVkM1UcdSKWlQxSShFAEHh1mIi1510ChpaPTko5cvvy9fVPdsYdSH3Rsmpd82/qSlsZ+f/MAcw68EaooCdNCIRlT6OLXv02fzeNlear/nE4dEYI19WPBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93F661007;
	Mon, 17 Feb 2025 00:25:13 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFCA33F5A1;
	Mon, 17 Feb 2025 00:24:53 -0800 (PST)
Date: Mon, 17 Feb 2025 08:24:51 +0000
From: Leo Yan <leo.yan@arm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com, acme@kernel.org,
	namhyung@kernel.org, will@kernel.org, james.clark@linaro.org,
	mike.leach@linaro.org, leo.yan@linux.dev
Subject: Re: [PATCH] MAINTAINERS: Remove John Garry from arm64 perf tools
Message-ID: <20250217082451.GB8144@e132581.arm.com>
References: <20250214114646.1444305-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214114646.1444305-1-john.g.garry@oracle.com>

Hi John,

On Fri, Feb 14, 2025 at 11:46:46AM +0000, John Garry wrote:
> 
> Unfortunately I don't have time to help review these days, but
> hopefully will have in future.

Thank you for your contribution for Arm perf development.  And you
are always welcome to come back.

> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25c86f47353d..9e1e906014c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18539,7 +18539,6 @@ F:      tools/lib/perf/
>  F:     tools/perf/
> 
>  PERFORMANCE EVENTS TOOLING ARM64
> -R:     John Garry <john.g.garry@oracle.com>
>  R:     Will Deacon <will@kernel.org>
>  R:     James Clark <james.clark@linaro.org>
>  R:     Mike Leach <mike.leach@linaro.org>
> --
> 2.31.1
> 
> 
