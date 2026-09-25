Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15404D2EDC;
	Fri, 25 Sep 2026 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350791; cv=none; b=Yb6C4rqm2/5KpsRIfPFVsH7uJUjUz0ZnXOgd6BBGcscNXwblh+zi9mCsFVbTc0TcqeZFzA1+3A7s40f5z+ZYOfTFAf/v39LYy3kg9SO5x7SDFhx50ipOyVIeo/70luZyq6voyEbmIJibIxnThsEfZzfHF8PqKP217tBPYVlgFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350791; c=relaxed/simple;
	bh=J5HIB+A7xw9N4g9RnI5JPKl0t6d0a1+ff6Q72XBfYro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJkyz2we+xf5KIXTstQPSTxfEIWGQV7FMRB7tWsriczGlx+v6Nyg3CKCqaqP2bMcR5jK3zleLw846MoPCdnsX0sUAwbBF3TnJtCsR9Y8K11YbRdmTbaKgX+wR8u7FzfAa93jRfN88E+zWlTL5qJR5Ll5cC3dFLP6i3CIrIlVUSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgNR9KSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgNR9KSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45FA1F000FF;
	Fri, 25 Sep 2026 15:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790350789;
	bh=dgUtL3Esmm4f0G21+jYcyLyaM+xDeO7XBgis/c7TfHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GgNR9KSa1BYCVSxFNfheZCkIEVzPcbzlrUieH/tGfqpjnfgDlTSqH1aNdT+/J1+1D
	 r2RRgRfBdlQqZp1hiLrYVkTfrtdJWlbyNYct6Jy/snVvsrN9lL3zr8pLG4wYEmKi+C
	 Ur2XhctKzRYPcEFU+NEc6LcYtueZELTZ787/pRrEheloZgswZ7AqRChqgb1TMUIHsy
	 v6JiXT8HKXLQUsNgkXpclnevdo1FUxkVUPzX4MTdf4JyYFZT0Dzwp3xEQghplpu2ql
	 sA3Y4MvYs6QylPT2S+0544jj8MXYklr3JzBkISSLkZDOJm9R07NPmE/ppTqopNKrTo
	 3dw35BQ8x11+g==
Date: Fri, 25 Sep 2026 17:39:46 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: stat metrics cgroup strip possible slash
 from cgroup name
Message-ID: <araVwgCOx4cwNbLb@x2>
References: <20260917061312.820074-1-irogers@google.com>
 <CAP-5=fW36Momg+N_P4vU08Pd_t+8PGK_-KfEn9HZjLPM4UO8nA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW36Momg+N_P4vU08Pd_t+8PGK_-KfEn9HZjLPM4UO8nA@mail.gmail.com>

On Fri, Sep 25, 2026 at 08:33:08AM -0700, Ian Rogers wrote:
> On Wed, Sep 16, 2026 at 11:13 PM Ian Rogers <irogers@google.com> wrote:
> >
> > The grep to match cgroup name in metric output assumes no leading / on
> > the cgroup name, however, cgroups in /proc/self/cgroup may have a
> > leading /. Strip the / if it exists to avoid failures to match the
> > cgroup name in the perf stat output.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
