Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2831A83F8;
	Thu, 24 Jul 2025 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753334089; cv=none; b=I1X4AAmlGiaVyNKR4WWJuKavnyQgTeByyKMv5MLODVm+VRXifk2/kd2b5ulJsx81RjtQ2xz8Cut5rPWNAUTpJZg8oQpdG4QLFWCniCquCAdsvC5m8FDMxzM8ozxwYnW/B4YUffqBag4SzlS8wdlb31omxBZMnoLO4zkJj7QjBHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753334089; c=relaxed/simple;
	bh=2r647/puxcXqvJQFSujsdIBelJGtyYAv8zisJ9ymQbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYJRcUOer6UwQ39PgKhCw7N949qQREnPS8b4CyZLrXiSBZ39yJojgt8uyYRaemshnuJ7DAkCi8515WpLpIZEhUjg5D8LP6TvdmAb0Ew1rPefIhx/hahgWbDbo89FEC2k9aQMVdUe1+1NqVK9fuvi9+U0jR3IKOq+HPAA+rlVOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22535C4CEF1;
	Thu, 24 Jul 2025 05:14:44 +0000 (UTC)
Date: Thu, 24 Jul 2025 06:14:42 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] arm64: uaccess: Add additional userspace GCS
 accessors
Message-ID: <aIHBQl9V0rMM1pjY@arm.com>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
 <20250719043740.4548-5-jeremy.linton@arm.com>
 <aICwaQZxK5Spjj8G@arm.com>
 <2a6e1c4b-e8b0-49e2-896c-65c55103b017@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a6e1c4b-e8b0-49e2-896c-65c55103b017@arm.com>

On Wed, Jul 23, 2025 at 12:14:17PM -0500, Jeremy Linton wrote:
> On 7/23/25 4:50 AM, Catalin Marinas wrote:
> > On Fri, Jul 18, 2025 at 11:37:36PM -0500, Jeremy Linton wrote:
> > > +/*
> > > + * Unlike put_user_gcs() above, the use of copy_from_user() may provide
> > > + * an opening for non GCS pages to be used to source data. Therefore this
> > > + * should only be used in contexts where that is acceptable.
> > > + */
> > 
> > Even in user space, the GCS pages can be read with normal loads, so
> > already usable as a data source if one wants to (not that it's of much
> > use). So not sure the comment here is needed.
> 
> Right, but userspace isn't using it in a privileged context to emulate
> operations that have a permission check performed as part of the read when
> performed by the HW.
> 
> This comment was added in V2 following a number of conversations about
> whether this was an actual risk or something that is only a problem if a
> long set of pre-conditions hold true. Conditions which can be summarized as
> "it is too late anyway".
> 
> Hence the comment to remind people that this routine isn't assuring the page
> is correctly marked.

I think the comment on the load function doesn't make much difference
since LDR is permitted on an GCS page anyway. It's the pop function that
we actually emulate without proper GCS instructions that's more
problematic and won't be checked against actual GCS permissions.

> I will reword it a bit if that is ok.

Yes, please do.

Thanks.

-- 
Catalin
