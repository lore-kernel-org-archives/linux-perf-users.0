Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0E49BD96;
	Fri, 25 Sep 2026 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341993; cv=none; b=IjyBTOD/tHJ+kA+3SjRYkwBIhKB6tX7GB2wZ7NpnOBm5p2FpuOiBkhygyC+RrrVL2gP1AJ0kHiCqWrJJ3d9RPdJx3sG3pt9Yq5EmAuDP1ZLXpgKngYcwGYzRjQk/wVb4LdDgd3qP59rVa6RYqqwzFN7oS+6i/f9dnPG0YIFhNmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341993; c=relaxed/simple;
	bh=V1dQRoMhO9xO6x00STIoGR+4LjhtdOE7CWxtjPaxYfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+y98VH7tlSfEISxaon1FLbC9iieShqcWxNUQrH9m6fRr7+6aEGDohwVK/yBwXhcmciiC7U+43s5NoKk/ZwDo1Asw1eEk/SzrRIK8Y+JhwXJ6Lwv30opGQp7/prHYjC9MNb+a6SQZS5O4itbTKouGuOF6A9jC1XVwZ/dYXKWQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrQ4JTYS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrQ4JTYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B7D1F00893;
	Fri, 25 Sep 2026 13:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341986;
	bh=tdWUX2hM5T3JVmLjlMc1Ccb5YiNrhwJMCS1hCelEhI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GrQ4JTYSIg72ssOfZSLJF30qWw63w5BWtOUGWVtJ3tQLNgHdiHFx76a4YOrfQnrDF
	 p2FiZRfoqbStYbdwhpC1ldWQTviJaGChB4hRlxBiFdMpFGtvFKqZXmec/qGV1gDEeK
	 e8eUHDyFpUlcC3CN85HSth+wdgwv8cMsz/mikRZN4NIgo7oo6HPXMtkz1PznwyxBEd
	 TFD3ecKTChYfdZXtBLt7Dd7B5AAAhiR4zHnaa/UxB6GTx3nBSZacIzbMWFU1OVaVQC
	 yV+UKFIft8VCeiiWln/XS0wA7wlYINiUJpoOLeERVdjUzWBbnhctgTl7CZ1vhXp85/
	 PENc5z1XxOBeg==
Date: Fri, 25 Sep 2026 15:13:03 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: nanshuaibo <nanshuaibo811@163.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH] perf sched: Make output_name variable static
Message-ID: <arZzX4h6995j1yHz@x2>
References: <20260903112835.1694260-1-nanshuaibo811@163.com>
 <CAP-5=fVBi=VSnGQ_uNAb5+Y=mVi5mBz+Zazgw-kS173hR5vDrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVBi=VSnGQ_uNAb5+Y=mVi5mBz+Zazgw-kS173hR5vDrQ@mail.gmail.com>

On Tue, Sep 15, 2026 at 12:43:59PM -0700, Ian Rogers wrote:
> On Thu, Sep 3, 2026 at 4:28 AM nanshuaibo <nanshuaibo811@163.com> wrote:
> >
> > The output_name variable is only used within builtin-sched.c for the
> > stats subcommand, so declare it static. This fixes a sparse warning:
> >
> >   builtin-sched.c:4140:12: warning: symbol 'output_name' was not
> >   declared. Should it be static?
> >
> > Signed-off-by: nanshuaibo <nanshuaibo811@163.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
