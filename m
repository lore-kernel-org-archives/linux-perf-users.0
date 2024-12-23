Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E96F1C460A;
	Mon, 23 Dec 2024 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734971849; cv=none; b=mG4E/PlNMe+nJlafcseXFNAvTfx59y1UflbdSIQPx3LR17h+cgk6pTPpbEJt3eKEu+C+Z1D/tx9FpMMZEXSQDXpUt3JvKaM49PIFg081Q3zXA7Dp6g6z4beRmrNgZiMinxJHkmln9fOdmed4MRCORVxgmW6ho0IuD2DunPdwoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734971849; c=relaxed/simple;
	bh=CywUTySS9a9ZbkX0bNfHyhGIkiM4ZT63tQQMZXsVjXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTYAJ75FxdzpRgCKFJlrtXKZYQ+mwrm1JnZt5eeI/9vgVjnSK8BpzrrqOzXfU4LlpL0jK+lQXAVGDj8ihbgfBVy8zbqZsB8c2eF9x4AqwEn1FKjb93RfguE6PoaNBWTJ52hKsi3EvJsNvquSJwOEAiuvhpTUZRLh3ePIl22vJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1khou9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1khou9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C256C4CED3;
	Mon, 23 Dec 2024 16:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734971847;
	bh=CywUTySS9a9ZbkX0bNfHyhGIkiM4ZT63tQQMZXsVjXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1khou9gXP+GXbYgCO8UeKVoTq8xdN3QHCeMr40aig0Ay35XeGRF7hGG8ilYjrYZc
	 UZIF9qDyKGZkeFirQgbWAfYRqJItuJANYwLLD1YkSw5qRijJX228WppLOc0xwt+CXh
	 3z0w+0KO3nzm78kWeclgp2l5AnFfOYpwfUA+sW8THJYpOY9M70F+PasF4MxTprhD+p
	 IxoIXCyFBiP7FjE/wWryWOcAuhnH99icfVzvXp2B1GHVXCFfKqUoCg1RJmrNnL9fFL
	 bpFL30q1ASQ7PX1FQLw+xdfhpuhy8EQgUtsGPPSZM1z1Ow3WMzBas68I1ZqDCWbmTe
	 CIRTslMgt7Efg==
Date: Mon, 23 Dec 2024 13:37:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux@treblig.org
Cc: Carsten Haitzler <carsten.haitzler@arm.com>, irogers@google.com,
	peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Remove unused is_executable_file
Message-ID: <Z2mRxByYb-GIi0UU@x1>
References: <20241222215831.283248-1-linux@treblig.org>
 <Z2mQjAIwBcx4_Pm0@x1>
 <Z2mQ4RdSE_EfbGyO@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2mQ4RdSE_EfbGyO@x1>

On Mon, Dec 23, 2024 at 01:33:41PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Dec 23, 2024 at 01:32:15PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Sun, Dec 22, 2024 at 09:58:31PM +0000, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>

> > > is_executable_file()  has been unused since 2022's
> > > commit 7391db645938 ("perf test: Refactor shell tests allowing subdirs")

> > > Remove it.

> > Did you patch this on:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next

> > ?

> > That function is still there, so I'll fixup your patch, keep your
> > credits and test it all.
> 
> FYI, it fails on the .h file:

I also added Carsten to the CC list, since he is the author of the
mentioned commit where that function stopped being used.

- Arnaldo
