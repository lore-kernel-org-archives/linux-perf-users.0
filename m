Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A244C33E6;
	Wed, 30 Sep 2026 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793453; cv=none; b=LUxZJ8PpSV57cb+X7UQ9/eWk3GJ1v7DePKKtCoyFbASMb+HA/UtOFt6XZCgqA5ZCDxyHplx9PCVyiziGZhdsWZkFKRfcmNXimr/Wdcy7Ols3B26kY92py95jYsfHZrH+41gM0UWHIveTLzZITCWJR/AJwZrlK808+PllZ49Y08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793453; c=relaxed/simple;
	bh=81LSair9EPRAiBn/IkSUZMEuAIdtIt5K4tXTvBe09i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeiMIHmg0ZS7/waEgkOKbyJgKBenrP1llks80v5G0WAJTZ+BGITRWxr6DLnFaJvXetiC13qGL8d944Dt2dtMnl2qQRRU7J14NO3LmLfsgxAL3S/jv20TH/gpPnzz1LbdlLpvhVeTUX8HABMc57tT9dUqxUDRMZj27VvvTVXo/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITA9sbQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITA9sbQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B851F000FF;
	Wed, 30 Sep 2026 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790793452;
	bh=ng/g14mps5jdMDV/NHuBoWekicBT/8el9ZOYheRl8qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ITA9sbQIcZr+dynzwIE5TTanisiKUjcWqmB/pQUFq7w9hEzJQdpWOjUGwlWuVPzXB
	 Dgb7uMfP1te1riOvx+GwTJtZri32E97yXI4kZTdVaUGwMxrJgyM3HDKQyC08KIHlVx
	 7V6AggInQ0116AafzQe+TUhHf+3UphlEUMV3PKSi2d96QxiiF8jzQesM7Wfro2zC1m
	 GQUM7CZ1oi+SKIyKn6doMmltTn9zwys09ZBW26iY/8vPmrDxcT7ggZphm2H4Y+aM7t
	 nciT5xC15T0pPYwEB8VHd6jlUCyMahCmD3sPOHsoV7Q4V3AgmOXsK0WPaYph2sxIDy
	 qG11EwQLm94Ig==
Date: Wed, 30 Sep 2026 20:37:29 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/26] perf trace: Bound the fixed size augmented
 argument beautifiers
Message-ID: <ar1W6c5E5kJEFbWA@x2>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-6-irogers@google.com>
 <r4uzrbjmhlwogshwlzz2346fbgehlpgise6rqhzeibgelqedkg@ezlubngls5pw>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r4uzrbjmhlwogshwlzz2346fbgehlpgise6rqhzeibgelqedkg@ezlubngls5pw>

On Wed, Sep 30, 2026 at 02:22:34PM -0400, Aaron Tomlin wrote:
> On Mon, Sep 28, 2026 at 11:25:44AM -0700, Ian Rogers wrote:
> > The timespec, sockaddr and perf_event_attr beautifiers read a fixed size
> > type from the payload without checking its size. The sockaddr payload is
> > addrlen bytes and the perf_event_attr payload is attr.size bytes, both
> > chosen by the tracee.
 
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
> Tested-by: Aaron Tomlin <atomlin@atomlin.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
