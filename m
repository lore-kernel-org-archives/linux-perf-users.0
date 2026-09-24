Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486044B4894;
	Thu, 24 Sep 2026 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271772; cv=none; b=QfMiwHIqwr6iT5uMe9Yi3OlknCJXqVDS+f5lP6sP2GlY7XyYxsu2eh/act7An+dZeMbQqrgFgX+ryGgzEvc4kbgrMgnu0MySf1MHjh1G7VrCjSN4trCfdECCSnmLEq0rjohJx43rwROSGhYONIQnI0Dv2kOGpWdnU8lIWnxKtD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271772; c=relaxed/simple;
	bh=vcJtfxpVsSBGnXSKyblhxsUK5ZZS2KwzT8XmWhThEZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4CbFIul8DP0A0gvzzB9YAVWLqVDupUYE3JSkeLhPBuNAObSPGLG1//V2733Q++eUqif52FRTxoD1Y9kYNVBa1JBi8JZqLA+zUACLf4MUxZddaFnx+Fp9fz2a0gYKvy6Wh4UIRYhGuEDEpF4YifYEmlrGhKVoB8FeaoU0MbMBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf+zN5Ru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf+zN5Ru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FEA1F000FF;
	Thu, 24 Sep 2026 17:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271770;
	bh=IERi4gcSzZ5mhy2o5C8Pq4RKsSIgaWdUICIYtzdLXkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lf+zN5Ruc9WiwU1wgCsaPEN6tGmC4zijuHQS0p0QaO2Ur4q/vNT/whgM6yO8oUHI+
	 B8UzChcKfcmZoH7zD/7Tfl8Y+leQCeODdG9+RrGfzlH4aWagnTlVBRpRua4Ljl39ka
	 JnbOpk0qL0e/tvGZM+P7W21lo8TH6/06X8Fxq5LoEElTsCVJY+uVA+KlWwLM6fI8BZ
	 B9z33voCZVcuLWfS+2IscYHcKJn5k9XVS56vC/MoagSVYt9tNNAS2fRH6/5XjpopT7
	 JBW1GxY70MaPmOFkS2SzXfy6D5xRKNw9B4hM5KAs4W1IPw2CIEg0rsOPPpl+ih5bcm
	 sySTHj0OegZ5Q==
Date: Thu, 24 Sep 2026 19:42:48 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf buildid-list: Fix empty output for AUX data
Message-ID: <arVhGILpes7fRK0b@x2>
References: <20260922-james-perf-aux-archive-v1-1-0ede8ed764ff@linaro.org>
 <CAP-5=fWUZrANh69W=aADmSwhg-8ogFBheL+chOHAWbRuhijEew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWUZrANh69W=aADmSwhg-8ogFBheL+chOHAWbRuhijEew@mail.gmail.com>

On Tue, Sep 22, 2026 at 10:21:25PM -0700, Ian Rogers wrote:
> On Tue, Sep 22, 2026 at 7:47 AM James Clark <james.clark@linaro.org> wrote:
> >
> > perf record enables buildid_all for AUX trace because buildid-list does
> > not decode AUX data to identify hit DSOs. Historically those build IDs
> > were available in HEADER_BUILD_ID, and buildid-list disabled hit
> > filtering when HEADER_AUXTRACE was present.
> >
> > Build IDs are now carried by MMAP2 records by default and the build-ID
> > header is omitted. perf_session__list_build_ids() forces with_hits when
> > the header is absent so that it processes the event stream. That also
> > filters the result to DSOs referenced by ordinary samples. AUX data has
> > no such samples unless the trace is decoded, so every DSO is dropped and
> > perf archive reports that no build IDs were found.
> >
> > Process the event stream whenever the build-ID header is absent,
> > allowing MMAP2 build IDs to be read, but do not enable hit filtering for
> > AUX data, this ensures that all build-IDs are included for AUX data.
> >
> > Fixes: 6bd89ae7d147 ("perf record: Make sure to update build-ID cache")
> > Assisted-by: Codex:GPT-5.6-Sol
> > Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
