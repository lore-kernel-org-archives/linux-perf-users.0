Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF333334695;
	Fri,  7 Nov 2025 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537945; cv=none; b=HrFBHMICI9tE2fOaZ3CbNcZ0aYkZwfdSK+QQZzMqQ+jG3Jjr8sLerTBzoI1n0FxQu0RQQUv4Tl/VUmRuVzXA0rgNQ1ZPVacL5z3tVIdDmiFwx+TZCIcCJH3Apj2Ez0goZaSzIhNntReenpu88IF+x5i0a0GRYbAlN05CEGvrg0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537945; c=relaxed/simple;
	bh=zy5i/LESJTmO7E4M3EEK0RfeVUq2RmmTlTfJl4/xLKQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bKT3+hSB27Y2OC6G+y0NImlq+eYgTGxM89fhpkLc6CE0jxXou9ztW/WRqW/GfzevxQOujt9TVa+C7jMRFxs28qldGrQ37RcrcWMHCc62xBt3xMDFaQTZkV1EIS/fUlBkEI9AWLSE16JYKA+yXXo8F12XGGuQF97jEiHSgI3Ig8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdsPmsDv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdsPmsDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFBEC4CEF5;
	Fri,  7 Nov 2025 17:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762537944;
	bh=zy5i/LESJTmO7E4M3EEK0RfeVUq2RmmTlTfJl4/xLKQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FdsPmsDv9n4OANN/1oK2Jt5rp3ssazPUt3HDCFZdbH95lZ79qv9nvL47t8ReG6CkK
	 w34pnudC0YmJy8pn6fjKkLSaGJryyGkfSd51Ib/3xNWZSPocT9jPfJ7fxhIxCdW4lA
	 MyFc+dhdl9J6BBeYAjWlVtMNpEyCROVRBRP+vM09rhA8iL8eFWW6uMYUsWiIEFu0oz
	 VgRps1jcQf+VA8Nps22e00uaJIaOMSqKtV6nWSE5SghnwiYDnRDa2y7Fe/+K2QtLLd
	 DfFVZITSGiUDd+Q1HRFDXtTkIplbo2nwbSlANnrJogmO6WkWUbkDv95nNCNCbrjiqN
	 5JAAZfI6KDl3A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20251106190023.1772629-1-namhyung@kernel.org>
References: <20251106190023.1772629-1-namhyung@kernel.org>
Subject: Re: [PATCH v2] perf record: Make sure to update build-ID cache
Message-Id: <176253794340.371147.16125840852097744838.b4-ty@kernel.org>
Date: Fri, 07 Nov 2025 09:52:23 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 06 Nov 2025 11:00:23 -0800, Namhyung Kim wrote:
> Recent change on enabling --buildid-mmap by default brought an issue
> with build-id handling.  With build-ID in MMAP2 records, we don't need
> to save the build-ID table in the header of a perf data file.
> 
> But the actual file contents still need to be cached in the debug
> directory for annotation etc.  Split the build-ID header processing and
> caching and make sure perf record to save hit DSOs in the build-ID cache
> by moving perf_session__cache_build_ids() to the end of the record__
> finish_output().
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


