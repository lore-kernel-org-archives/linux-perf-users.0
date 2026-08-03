Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA5431E51;
	Mon,  3 Aug 2026 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783793; cv=none; b=kvkrEFgAhs/DpcTLt+d1lx9YGp2LdqzO2gE19qIoIrF84V0MeeWC1TqWkjhvodVjT+YoBCHHjuKxgIrdxHbaOSmGnNcGVn8uad+64Waffr7yTaZiXN2maF6qOIMTv2LmrkJ48oJ8A2/OdzibSjcCyFoWKUYDo7eNMxlIeM2JS8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783793; c=relaxed/simple;
	bh=9ovv44+Mnmj2cD26Xq0W0L5rS2QaG7sUiUlUfdpxPEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkfdySjdm+V84BhiRNDKgqSND4tHYmcTU8s6mc3K1t4QEjGX3kV4wOd8gKYtJxOBaOAn8E1Q5rgHEF0aYwIVCXfVY1nmBXwIkZrxfVaZfP8jAI6Cby4ex0AZJUj9AfRqbZlc9Pz6Em8X/D7q2o7jxoAy3TvuQi89o6lrx4acUrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCzfnaOl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCzfnaOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97C71F000E9;
	Mon,  3 Aug 2026 19:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785783791;
	bh=OSlT+1QU066vGRZd2mcg5MvdWcriyX0BMDjBe/4IvXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bCzfnaOlZ298MrAXsZaiLaHqrW0W08KvnKhMxW7GVod4IQ8bgQoetR4CcBcQh+7Zf
	 9rVFtoN0WqoSCy1b79K+8AGXzEY+egjX7l+Q2y1O3h7BMmGqura0JA6NvtPL70FGoF
	 NtOAMj2j6HI9DEK+8rabvNxQI89WoviBBCww0Qg67vyGVHzab25kR+zE7KWXdT8mRQ
	 PdqxghtVKdagPo9wFXpQlKn8tKxt4JXQAoFETRdyFLDkA7A/aKEyyikWfXJj8z818C
	 6p7i5jXrlYf+sRGheejeQRtQE9MBPX+7E2YKtq8kLU+ZF4uGwTiQTx5dwnAbjyRXtQ
	 1h2lMM6YpLYlw==
Date: Mon, 3 Aug 2026 16:02:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES 0/5 v1] perf tools auxtrace hardening series
Message-ID: <anDl49CuYEtbemLq@x1>
References: <20260727161705.64807-1-acme@kernel.org>
 <am0vWwqDMib_NF6q@google.com>
 <dd4a6a5b-5abf-45e5-bb88-59d6e911123f@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4a6a5b-5abf-45e5-bb88-59d6e911123f@intel.com>

On Mon, Aug 03, 2026 at 09:46:38PM +0300, Adrian Hunter wrote:
> On 01/08/2026 02:27, Namhyung Kim wrote:
> > On Mon, Jul 27, 2026 at 01:17:00PM -0300, Arnaldo Carvalho de Melo wrote:

> >> Arnaldo Carvalho de Melo (5):
> >>   perf thread-stack: Fix heap buffer overflow on branch stack wrap copy
> >>   perf auxtrace: Fix queue grow overflow and old array leak
> >>   perf intel-pt: Fix off-by-one in auxtrace_info minimum size check
> >>   perf intel-bts: Fix off-by-one in auxtrace_info minimum size check
> >>   perf arm-spe: Reject zero nr_cpu in metadata to prevent division by zero

> > Can you please review this series?
 
> Certainly!
 
> Other than the Fixes tag in "[PATCH 5/5] perf arm-spe: Reject zero
> nr_cpu in metadata to prevent division by zero", for the series:
 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks Adrian!

- Arnaldo
