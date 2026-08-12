Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F41335081;
	Wed, 12 Aug 2026 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555134; cv=none; b=VfGwIWVeUZvOPyJG2KJX//osrmuC4O0LvuzhT9y2HdXe+eD1LZaokAeY9Vbiir6VWe5r5xQsUdmJf4gLeoW36eTIPvnF11wj9iYooI3iE8Tp5BUvwrFVALTLgOyOgVkuQk+qEb9OaUqRFDb/AkIN1DenMzwJJR1XlmWh8ysNt6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555134; c=relaxed/simple;
	bh=hPIuoqkoBuzMlQluA9LtRKITfG4I3FKifuZTAzF66wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiofjL0N9/VaO308A2ESoGkPFkS++uCN8bAesETQz8MZTZo2rc/82bOtwghKir636dBR8m5gaq5NPCbnPBRZbVr2/ru6NKBVElD1wstXfmaLEZQzUxH3MFLlngUxSVRb4ob01k5IdGYpAbLdtkgUBc0HLhn/5Ff0eLMqVXukl5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeRn5VJT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeRn5VJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EE11F000E9;
	Wed, 12 Aug 2026 17:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555133;
	bh=3AWdc6S6CCFpx1yMWzJWK0dTgnoALDccJCcxtDdpwf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YeRn5VJTxHjUDymmgN1wfrniIkwifM77G6mK+OvHyfocaZ9hjk1znrtDkNB2G1hx1
	 icdmYZ9j2LURhigIAV89V5Zdn7cxqDxy2CM4WPf5Lvodihv0oR5vKx2hFC25hlYGQu
	 xINY7+9VfScSAncfAY+UoFCs7klpV3wkdQVDSQHhA7Q51YEP5zAaAEO9bcIyjaXivP
	 EJg1Y1GZvi7LFX3UjStGgLN2+U1tmbVdsZ3vM1ULZ+y5b17LfwfNaDZtVejtRCJyu9
	 WCtKHEGu0CqK/fJLGh8Pj1Pu4V6Vz9AFv0YbrpXV/jROyk4zzgc2ECFWZ89pnVOcCS
	 IVPtHZYu6dzuA==
Date: Wed, 12 Aug 2026 14:18:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>
Subject: Re: [PATCHES v3 0/5] perf DSO hardening series
Message-ID: <anyq-lNV-J6q5t1a@x1>
References: <20260811175140.7235-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811175140.7235-1-acme@kernel.org>

On Tue, Aug 11, 2026 at 02:51:29PM -0300, Arnaldo Carvalho de Melo wrote:
> 	Please consider merging,
> 
> Five hardening fixes for the perf DSO data handling code path, all found
> by the sashiko-bot AI reviewer:

This is sashiko clean now, if there are no further human reviews can we
have this merged?

https://sashiko.dev/#/patchset/20260811175140.7235-1-acme%40kernel.org

Best regards,

- Arnaldo
