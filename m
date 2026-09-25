Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5E349CF36;
	Fri, 25 Sep 2026 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341517; cv=none; b=hybNzcPO71t9EGqa3epZOUnkkwfnaSugKfDA0qc1NEM9VedYgvKimu1GVHB4V9B0D4aKIoNuupa1oAwq2yvblD5E+vgjyrWZdsV9edSllPeQ4YlbPtrDpheFLVDkXGFxfLKd9hOgVOwAy0sGCar1DJ7QUZFi23JQsTcEvHYiqMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341517; c=relaxed/simple;
	bh=h+7jCsmx1mECXixYfE+2oe8fc8wZzXoe5MxL0D8ywVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk4j4ulADZ+61Xyem6FKL3AYsg/wn+nsUsYWI1K6lOOmxyUIEIWQgsGbQMtNdPj+STFBOs/gbv18Y449Atby5n/ijFRpXPYh4arLjd+QVc5F0XDKYqUd6OgaBDVrH9PAt9+1XLvzmCXG481z+vkFHnu+eKVro85X/s2EcBaFBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acXz5EZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acXz5EZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD16D1F000FF;
	Fri, 25 Sep 2026 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341516;
	bh=iRWDA7tN/Bxga1x0OC2hENb8kXP5XAj0Fo3YD+9p+Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=acXz5EZTDwb36o4wjiCL9R7+XzWGNQfTYEcnt7wvDGzsIWBWx7P1wOuSTzUA7TeJv
	 +FkRNRlugCeYybqRgOYMJ3CbiVnhiXKZ+wGJCPAqk9Pk9/A+IY362k+3fFOLoQ58Hb
	 teCIzZgsw0OeP7GXNkNnJ1zvyqIL8OAhrWWTVKRsm7Kp5p0Se5XDWhKR7cl4lkFqgt
	 Y2f7At31+IT951ox/+UF6KWC+Bdi2A0aZDTuog2UaLhMKOTWcD1E3qzC8nFLuhVUn2
	 cqgeqqX/gDQQHuNxm1HYmwQm0xvklv7wXls4uL0QFFA2lro2o0t2njktJl1cijxfPo
	 7OYovGac92qfA==
Date: Fri, 25 Sep 2026 15:05:13 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v1] tools include: Add missing stdarg.h include
Message-ID: <arZxiWdPsMBz3ZKG@x2>
References: <20260917040454.32916-1-irogers@google.com>
 <aq4u1lMOBF61XJFu@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq4u1lMOBF61XJFu@z2>

On Fri, Sep 18, 2026 at 11:42:30PM -0700, Namhyung Kim wrote:
> On Wed, Sep 16, 2026 at 09:04:54PM -0700, Ian Rogers wrote:
> > Header file makes use of varargs but doesn't directly include stdarg.h.
> > 
> > Reported-by: sashiko-bot@kernel.org
> > Closes: https://lore.kernel.org/linux-perf-users/20260916062233.192271F000FF@smtp.kernel.org/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
