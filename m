Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B28B2066CC
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Feb 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740228147; cv=none; b=TWT+s3+5aHBZ6b9/tm4y+P8AVGoDMbKzc41IHHc4zUG+7o997HboSy7w36w6H3UIrVUCuEIR9ZPGYGzHCCtf/gn7lMOudeX1bL3aXgHq6wBw/TkmVmX6lPH894Fbn8817dILaCFQlvC9qg8bCpBPDjDeGJZMjMmL9gwgQ1Yly0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740228147; c=relaxed/simple;
	bh=dlNurf6J/kF6jwdjyszmwDsz+iXM2ZJ+Sue3Mwroilc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7Wk5xCpoi+38TGgW/IZ6do+IsYof55RlHIVNq8JI/cc4iNge2AYhkQ9mZys3N1smc0ZWOkpxVmCQ+snjoDq9xsSsqXLK+T7tc8OQ0oZVtHnh7x+3mI/eDmnlh7XS8IwNp+am56UndMXB/JCqSE0GL7uTQX540k9c3bNmLplMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+pH9DQO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+pH9DQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EDBC4CED1;
	Sat, 22 Feb 2025 12:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740228147;
	bh=dlNurf6J/kF6jwdjyszmwDsz+iXM2ZJ+Sue3Mwroilc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+pH9DQOXkxhQeEh+Ai6/XFiHNKLwNubwX/mHikU5yCIGNXSGur8XtPtfCNjtiAW2
	 4nONXV+Pl9vj1oH0lwUA6GXI8ExTLfVT5HCgsPiLAippGOGVy90snc0krkRT+dnyEo
	 qJgWlMooAOkhfdLz3P17m3Hh+JXHtlifflerO9psToO835MyZz8YECVTHj4PKjv2Yh
	 wIvhe3VZjRynplNpJi0Iz+yNuNGLM+NdkwRN/UVD52ytYjcOoJABClElec37WOh76m
	 1mWYMHp6zP0465OyWU0C1p2SjWezCbbVYfl9c5lJKCoB0ekSvA5CDJcPb1+mkRW+vI
	 Grb+lQYZoipCw==
Date: Sat, 22 Feb 2025 13:42:18 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: intel-xe@lists.freedesktop.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v14 1/7] perf/core: Add PMU_EVENT_ATTR_ID_STRING
Message-ID: <Z7nGKlY509BxgyUn@gmail.com>
References: <20250122062341.1100173-1-lucas.demarchi@intel.com>
 <20250122062341.1100173-2-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122062341.1100173-2-lucas.demarchi@intel.com>


* Lucas De Marchi <lucas.demarchi@intel.com> wrote:

> struct perf_pmu_events_attr has both id and event_str however zeroes
> the id and only set event_str. Add another macro that allows to set both
> so drivers can make use of them. The id is useful for determining the
> visibility of the attributes without resorting to creating separate
> groups passed via update_attr, while the event_str is still useful for
> attributes like *.unit or *.scale.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  include/linux/perf_event.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
