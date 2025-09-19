Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742325CC5E;
	Fri, 19 Sep 2025 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308831; cv=none; b=RMMOP3BGu90wbOYLNY++nQrCr0YCnwrAZsIY03Ff5M5mUJZlLpWzkA0pLRj82wohSYc9zxYPmEW/K7OioN1UFa08Drjs6E1FzuluLvfrrC1u1azn9ef1oJwChMSyICRa+YaR3T6yp/uzUnQIUjBTBev84ZQoYDfIHgWb4KRPCek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308831; c=relaxed/simple;
	bh=2EWSU5zaOh1m7kgeYGxcKNHLBxvAF5AG40zT/LkNSL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKncTr4FEMx4CAZWNp+JLi3rkE7oxzgW3a/R/2rKrg/zkrtzK0VlzAUosC4NK0qMZl848Wxxxxcqy16qRh1gqsWJVR0nAcmw2yIeAcspkp/VnOepwQUAj1ieTCtYIzs7v2d60NKFEXdANrtPzTD18yv3tq+ePx5TdR6VLs+B1TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJcrt6+g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJcrt6+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A319C4CEF0;
	Fri, 19 Sep 2025 19:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758308831;
	bh=2EWSU5zaOh1m7kgeYGxcKNHLBxvAF5AG40zT/LkNSL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJcrt6+gCMig6aP2MmfT/JwKHY4uCfsHxqib4IaUpGHz4naW73cUM247Qcw+vjCAb
	 O9R//gfUWc0yZny/XUtddUAiaLWoFVxf1ZxyakKaADPiUMMkfa86iobprUE9hMMXuu
	 jSDRW0e9pzqqo0t4kkVlZqvoOM55Wi4bRqXO4RctFZAqAt2fstd8UmkkU34obVqAlQ
	 6cBb8BhYQ9C0g9zYk9+v1m7v+7ewtfF/jUJqlcr/Oqb+Rj4jApVwPEgUlugZGvArKh
	 oH2ioahvtgrBhitEfUaO1FjIA8qgNH6jUJ1zEtEtxr0hI3p7vJhk9yzcj6uMoEDHJq
	 ipZiYyZ8lLHng==
Date: Fri, 19 Sep 2025 16:07:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Michael Petlan <mpetlan@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	James Clark <james.clark@linaro.org>,
	Tomas Glozar <tglozar@redhat.com>, Yuzhuo Jing <yuzhuo@google.com>,
	Quentin Monnet <qmo@kernel.org>, Leo Yan <leo.yan@arm.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] tools build: Make libperl opt-in rather than opt-out,
 deprecate
Message-ID: <aM2p2up90BM0zwEz@x1>
References: <20250908181918.3533480-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908181918.3533480-1-irogers@google.com>

On Mon, Sep 08, 2025 at 11:19:18AM -0700, Ian Rogers wrote:
> If libperl is installed then the perf tool build will build against
> it. There appears to be limited interest in the scripting support for
> perl so let's make it opt-in and deprecate it.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Applied, after the slight change below, to keep the tip for fedora/rhel
systems.

Thanks,

- Arnaldo

diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 5457762f7dd59425..7fd054760e47847b 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -49,7 +49,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
 	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
-	FEATURE_STATUS_TIP("libperl", HAVE_LIBPERL_SUPPORT, "Deprecated, use LIBPERL=1 and install libperl-dev to build with it"),
+	FEATURE_STATUS_TIP("libperl", HAVE_LIBPERL_SUPPORT, "Deprecated, use LIBPERL=1 and install perl-ExtUtils-Embed/libperl-dev to build with it"),
 	FEATURE_STATUS("libpfm4", HAVE_LIBPFM),
 	FEATURE_STATUS("libpython", HAVE_LIBPYTHON_SUPPORT),
 	FEATURE_STATUS("libslang", HAVE_SLANG_SUPPORT),
