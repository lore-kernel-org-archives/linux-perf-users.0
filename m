Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E482E8B67;
	Fri, 29 May 2026 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066541; cv=none; b=l+Plpojbz9y49sOtzF/11TZH2K4vI4+cpJfllS1ubJsay1W1PWDIsTIa31TCY9sfGl5NqkXoSam92oWE6BroqNWZTCu6cygiSV/gsOteECyEZeNzj1cMdIoxJdk4mWKekNiy3UcYUGe3YUg1bLjAjq6cWH2IAQSxaMcFDY6WWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066541; c=relaxed/simple;
	bh=G2DouJqxYp9YC9xT0MMU3BE6lnc24O/S4DxnlZEAEhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPkT+Gc1emqYOUwh1ZSgQbW/zxIU/dyJBeLoHq1bjmzPykE4TIrB2xc+gmzocmzIMYhDuiuY4oAC67KqfVoEerkpteS7khkPpqFhYE58UzkKHActsKjtWM9GUgLlFKJAh3TGBy7cQ7xGmDyvYaVapje4yq5DEEU5FeWTwWWvjrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGxJdkb2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGxJdkb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44D21F00893;
	Fri, 29 May 2026 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780066540;
	bh=SsYvQIujDmIdgNUBpvfrksPzotUo5Kccj0oELYXwLDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cGxJdkb2Drs7MTaoLBbxzvqLt+NrmVwKoPTpM9pm3Hs88YUWBjbQ5EzLtNWWiV82v
	 rNHGYm69FM8TxyeVoEHMjljrsXtg9KMnCuNWlxTm+snUsRkYr2m8q6DlgAoxGbeLEy
	 P47xfp0nIPI8Vzme0mpl2lCf97Gnzlk2ry1PUQT3nmVFBa13u6a8ebgQO62b2I182C
	 x3r4vjIn0jer7d6UxmaFysE8WyIjJQQpgWatoy0kDj9OYtPXjDC8tzhpuy5E7EcTHP
	 rUXLKstTvJly11pQwX/JkXY4dy/PIhHyKmEiQ32I8p1qPweNHEW+Mm2tLC+2UImSJR
	 IgHobrX5oHn5A==
Date: Fri, 29 May 2026 11:55:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Amir Ayupov <aaupov@meta.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf cs-etm: Queue context packets for frontend
Message-ID: <ahmo6AF3oGOvdzT8@x1>
References: <20260526-james-cs-context-tracking-fix-v1-0-ebd602e18287@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-james-cs-context-tracking-fix-v1-0-ebd602e18287@linaro.org>

On Tue, May 26, 2026 at 12:14:35PM +0100, James Clark wrote:
> Fix thread tracking when decoding Coresight trace and add a new test for
> it.
> 
> Unfortunately the test has to be added as a separate binary like the
> other existing Coresight workloads which needs a bit of makefile
> boilerplate. Ideally it would be a builtin Perf test workload, but Perf
> has a lot of dependencies and generates a lot of trace when starting up
> which makes tracing tests very slow because all that has to be decoded.
> 
> Hopefully I can find a generic way to enable Perf events at the
> beginning of the workload and then I can migrate everything from
> tools/perf/tests/shell/coresight to Perf test workloads, but that will
> have to be done as a separate change.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

James, there are some review comments from Sashiko, some looks
legitimate, wdyt?

- Arnaldo
