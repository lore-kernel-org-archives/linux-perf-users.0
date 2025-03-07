Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E8221565;
	Fri,  7 Mar 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360249; cv=none; b=mbiEnE5cZzAh2Kft+IPoVwYHfDO74zzBSSiuYkn5vDiu/J43AC37/4ofjrygsBNnVJaQ1hIlP5OeMnL3BXp8WITrysYboO3tIFvW2aqEtkr5ntAhTzMZWb4Arip9XJn6sr60NvWse2cXn8b1jwTKNUyKqWuexKjNFMzo4SEU3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360249; c=relaxed/simple;
	bh=SorLb/yESkB+YPPgRtN1w+OBH2IdMbCLeWiut7PXYKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud5+BJyKyidUSpjl7Oj6l0ftNi9xyyINFcLvJ1mObOoWodArDXFQP8CVwqTk4Wub5kpeodA/HtKAN4bZA2aLkaOISDb1lSpDOQOQ78C4/Xy0B76bCw4lL4rvZafVlGWhE/AVCVQzQ0/UwdaTIAQ0pvPFVS/gek6LEcv/ahtdAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1CYXnJT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1CYXnJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88462C4CEE8;
	Fri,  7 Mar 2025 15:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741360248;
	bh=SorLb/yESkB+YPPgRtN1w+OBH2IdMbCLeWiut7PXYKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a1CYXnJTKwSwXIMQ3G2Mwntd3JYUwHmR3ZmMpv50tcbi5eq8HakiK+l6bahRrG9dP
	 lMT9RM7+leU4jjQQsQxedvONkxhjbtnYLDPW0aRPh6FmUzmuvNZOVWulHufm9CvJnF
	 VCq9XmmFtM2DjaSpKNKUOwYUqR+OOcsTtrAtn0AlypFs9z+D2OCV1Mnh7kiwcFrOcV
	 k8t0I8M2exv60z83ufE/B8CneL0gRDWKc4HUDUomLnaptrBTJWpukJufYFe2mBMxvx
	 Or42O7GUV0ZG3fkFLjeFq9IUVV+LC3thvfo0TmGeFRs7ASdVOmL5ZIm/ByEsBrtRNP
	 7xD3POLJgwLmg==
Date: Fri, 7 Mar 2025 12:10:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] perf tools: About encodings of legacy event names
Message-ID: <Z8sMcta0zTWeOso4@x1>
References: <Z7Z5kv75BMML2A1q@google.com>
 <CAP-5=fVbti6efu6uA9a5os6xhnTuJ0egyesZsy0dmkiScwYFqQ@mail.gmail.com>
 <Z7yJ0Vpub6JeQyYo@x1>
 <80432f35-e865-4186-8b92-26b25279e150@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80432f35-e865-4186-8b92-26b25279e150@linaro.org>

On Fri, Mar 07, 2025 at 02:17:22PM +0000, James Clark wrote:
> On 24/02/2025 3:01 pm, Arnaldo Carvalho de Melo wrote:
> > On Wed, Feb 19, 2025 at 10:37:33PM -0800, Ian Rogers wrote:
> > > I knew of this tech debt and separately RISC-V was also interested to
> > > have sysfs/json be the priority so that the legacy to config encoding
> > > could exist more in the perf tool than the PMU driver. I'm a SIG
 
> > I saw them saying that supporting PERF_TYPE_HARDWARE counters was ok as
> > they didn't want to break the perf tooling workflow, no?
 
> Doesn't most of the discussion stem from this particular point? I also
> understood it that way, that risc-v folks agreed it was better to support
> these to make all existing software work, not just Perf.

That is my understanding, and I agree with them and with you.
 
> Maybe one issue was calling them 'legacy' events in the first place, and I'm
> not sure if there is complete consensus that these are legacy.

I don't see them as "legacy".

> Can't they continue be the short easy list of events likely to be common across
> platforms?

That is my understanding of the original intent, yes.

A first approximation, those who want to dig deeper, well, learn more
about the architecture, learn about the extensive support for
vendor/JSON events, sysfs ones, how to properly configure them taking
advantage of the high level of flexibility both perf, the tool and perf
the kernel subsystem allows them to be used, in groups, leader sampling,
multiplexing or not, etc.

But lots of developers seem to be OK with just the default events or
using those aliases for expected events across architectures, sometimes
specifying :ppp as a hint that if there are more precise events in this
architecture, please use them, for instance.

> If there is an issue with some of them being wrong in some places
> we can move forward from that by making sure new platforms do it right,

And adding special case for broken things when we know that some event
named "cycles" shouldn't be used for sampling, for instance.

> rather than changing the logic for everyone to fix that bug.

Right. And again, if something doesn't work for a while in some
architecture, its just a matter of specifying the name of the event in
full form, with the PMU prefix, etc.
 
> For the argument that Google prefers to use the sysfs events because of
> these differences, I don't think there is anything preventing that kind of
> use today?

Indeed.

> Or at least not for the main priority flip proposed, but maybe
> there are some smaller adjacent bugs that can be fixed up separately.

Yes, and work in this area is greatly appreciated.

- Arnaldo
