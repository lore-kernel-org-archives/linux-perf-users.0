Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A940191F85;
	Tue,  3 Sep 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389056; cv=none; b=NgeXthKfIprbwFRNE328mSvhmGhmaZCTPkAsJT9uLoJsEdR10sth7/y1iQ80+8x07O8jycrnbtvB5fmhPshNJlRQiaPlp8j+gu2F5ZOLJEPbUYpajvCPrRg+D7G6fRBwNyADaMMeEN26i9ry88l/YtDjySJ498v97GJomz4wy4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389056; c=relaxed/simple;
	bh=7d6cfc2xZAU6TqVoY4UT3QV2pPdhIlhRcAok+Ugyyh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VL2coKvaTPnmFLtWJr6gsOzbuU51k4AnOqfRAnwHEds63zh8n4/B12GTXHyB4Ta8xFCbOo8b5efbeg4yKhAangMLrXxnQ3Q6tGMBtkBod+wdi0PG+7CiCc063gFESkxDEDV9EwzS2ixbkp+XvNQY0dAaUnK7s3V58E4NQXznC9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWzujukp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWzujukp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01844C4CEC4;
	Tue,  3 Sep 2024 18:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725389055;
	bh=7d6cfc2xZAU6TqVoY4UT3QV2pPdhIlhRcAok+Ugyyh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWzujukpk9YIM2UG/1X2Dfy+W++9qpSSputDo/a2o0KltulVfMjQMLxeCibs4gTyR
	 G2JRL+pz+bin2DgJJbnaXfRVs5L/sefXigr8jqiCT2dt55gHCaI+fIl5YaaDEL4cub
	 sluTcgmPOI7PUgTRyo2RZi6607tP30gitQdWQLux2pEq8a0lmRjEly0mq4zC3eZE2P
	 0YjtkMfzDNr1r81hs5Qrkkg7LsVQEMoAWPalKf8+om+N8VT2XSN+dDZxkWamPSUlfe
	 MXLcqH2JTgJhOxbJH7M2bphPZX8gfniSvl0HCJV/s68lVR0frKZxe8unmJ0Hv8dtpw
	 VFgdXIR6gwhVg==
Date: Tue, 3 Sep 2024 15:44:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Yang Jihong <yangjihong@bytedance.com>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf sched timehist: Skip print non-idle task
 samples when only show idle events
Message-ID: <ZtdY-6NuoG8JzBNo@x1>
References: <20240812132606.3126490-1-yangjihong@bytedance.com>
 <ZrpcioDOG42dPAll@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrpcioDOG42dPAll@google.com>

On Mon, Aug 12, 2024 at 12:03:38PM -0700, Namhyung Kim wrote:
> On Mon, Aug 12, 2024 at 09:26:05PM +0800, Yang Jihong wrote:
> > Fixes: 07235f84ece6 ("perf sched timehist: Add -I/--idle-hist option")
> > Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied both for perf-tools-next.

- Arnaldo
