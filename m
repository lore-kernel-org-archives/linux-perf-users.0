Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A212DD93;
	Fri, 10 May 2024 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350554; cv=none; b=Y942Gzi++vAixKo9V3VWmRN17QBKVds152WqfaOMdBjs9vhslJPClBzPskRH9Dmccp3BPJ1ek6l9nWBO1+XqakGZh3eDoA55wcFvIb5VGYUSDBb2USm/4eBhaOC4piHYVI2TsEUNSPvnW2VrNovh01qV2NmeY0g36HRB14tM7YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350554; c=relaxed/simple;
	bh=Bc4hqX/m0AxXcyrSLTvBIXURaXcSvRXC3i+DpTHFxp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6Kk7NMj6qiiJi6aClW14+0lUVJaWTZAnD5TNJ+WtRwOSjwfqSDq9nd5wsnex6b9lC4f3Y0ZShCi8aAO6bHdWNDMYlGzfMNafX7QTzXWqgVjJaVdxK9vIfi2Qd/exQXdxL8chhyCn22yPIPS4kMblT+3d89lNLIWbx0HDBfi8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XivSKhIK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XivSKhIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74941C113CC;
	Fri, 10 May 2024 14:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715350554;
	bh=Bc4hqX/m0AxXcyrSLTvBIXURaXcSvRXC3i+DpTHFxp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XivSKhIKugkr7R5Zh91B9wvodhthFrMK9ea4i4A5Uga5fez7nr3SGEBMOk+vOPtI4
	 sjPkpOAuwLvLixvpGTF1ZgmPkGHO0v5RqZghZK6OdSmiKIuBa8joxze81j3JvosjMf
	 yJtj8sTvCbnZHzOSQeLRqc87a1HGu6JrDaetC9dvWc33c23aln9lhd32XP+/pBJSj4
	 j7TQOE97KS09A5YcahpFahx/a+36NBMcgJ2zsJDEySV+fNvWOeGn+hwCrOmoSzMjFq
	 5FfTaKU+cYWT1UPzVcT8mZqrtJpnsw1cvYKAX51eljq6PvgRTZs3UC2z/SOqMcyMj8
	 +Pye0FFFwvfBg==
Date: Fri, 10 May 2024 11:15:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf lock: Avoid memory leaks from strdup
Message-ID: <Zj4sFuAKPiNfSN-b@x1>
References: <20240509053123.1918093-1-irogers@google.com>
 <CAM9d7cgvRO0niWKi8dVnaYU1Y0C2hWCYxdA+Yb1vObDdgK85Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgvRO0niWKi8dVnaYU1Y0C2hWCYxdA+Yb1vObDdgK85Kg@mail.gmail.com>

On Thu, May 09, 2024 at 11:24:10AM -0700, Namhyung Kim wrote:
> On Wed, May 8, 2024 at 10:31 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Leak sanitizer complains about the strdup-ed arguments not being freed
> > and given cmd_record doesn't modify the given strings, remove the
> > strdups.
> >
> > Original discussion in this patch:
> > https://lore.kernel.org/lkml/20240430184156.1824083-1-irogers@google.com/
> >
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
