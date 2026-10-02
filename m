Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF83D76;
	Fri,  2 Oct 2026 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957942; cv=none; b=Tn1GhjCTC8RRGXFb/6WP7pH+KecXzbg2QII5IkfhhC6StqcTFRieRBrwryJ6mlFPdxO5HdYBXp0zrhxlaAkt5LWR9wHvj60ly0lIZEGNUJFXMlnT+6UuSZm27EwtYONQTaVobnCvCfc3FTFFxEEgk8VqUKEg/txQSzXp5SMWfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957942; c=relaxed/simple;
	bh=B48fwaa56pY4U+My0GqpvR9gOogOUEm2JeWSv86s0YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmOhKp01dR5enYubV2e4ERzzcsr0gKD2bW9kOcKtUxJIzGclxP82kIncUFnGxV6Z/y5f2niT0MrklL0Bd8MWspHx1BRuw0NKgwNtDk2f5eYiAB5hE6p805jqm3f6cB1kElUW1Csau7bhmGsfjYxdjTfx2aRfRBWEsLB/DukOrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSacBtJO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSacBtJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6141F000FF;
	Fri,  2 Oct 2026 16:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790957940;
	bh=eWmjm7vEKisLYbLXL6w0pR7Ro/v6UckZORlsLJ3XLUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cSacBtJO4kq0zNSOtsryekHLMV6tj7igTBIjf8XbrtphydCvD0SpPvQ9qi8Bsp95X
	 VYHWi9DQfKKRHlk//+wWPcuwBJC8FqkSnBTlurHiKnk6lf9yAGXNGKUPCBBzSH48FW
	 Ve5GkkPqkDBeKpvVz6Z6ggXFztrVGlIm8QHdsSSbHfL42+CRoj5gzgjcejfV+VQliW
	 zEoMsCYjwvi779FxQLcRUcvJ+weCAnEPuY+syc4lppS4WdzSIx5FoiEy/O3vmUGuQr
	 nI2ZUs0kvrJt36wF9tDsmSVl7H08QlDwbVUc1jkORyY7xez1YX+XMC/6l8MXQaM1c+
	 mwHqH0lB4gxYA==
Date: Fri, 2 Oct 2026 18:18:57 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf python: Track linked libraries as extension
 dependencies
Message-ID: <ar_ZcRqAZxwQpr4O@x2>
References: <20261001-james-perf-stale-python-build-v1-1-dd3b14644606@linaro.org>
 <CAP-5=fVsTGp+_gsk-yCiK58A7O3LuK0okOuHwuVr+xgiSHVGLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVsTGp+_gsk-yCiK58A7O3LuK0okOuHwuVr+xgiSHVGLQ@mail.gmail.com>

On Thu, Oct 01, 2026 at 09:25:02AM -0700, Ian Rogers wrote:
> On Thu, Oct 1, 2026 at 8:48 AM James Clark <james.clark@linaro.org> wrote:
> >
> > Since the Python extension switched to linking perf libraries, setup.py
> > only lists util/python.c as a source. The libraries are supplied through
> > LDFLAGS, which setuptools does not consider when deciding whether the
> > extension needs to be rebuilt.
> >
> > When a library changes, make invokes setup.py, but setuptools can skip
> > the build and the recipe copies the stale cached extension back into
> > python/. This leaves perf and its Python module running different
> > versions of the same code.
> >
> > Pass the linked library paths to setup.py and declare them as Extension
> > dependencies so that library changes trigger a rebuild. Include
> > EXTRA_PERFLIBS in the shared library list so that both make and
> > setuptools track those inputs as well, preserving the existing linker
> > order.
> >
> > Fixes: 9dabf4003423 ("perf python: Switch module to linking libraries from building source")
> > Assisted-by: Codex:GPT-6-Astra
> > Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

git am complained, applied manually:

⬢ [acme@tb-x2-perf perf-tools-next]$ patch -p1 < ./20261001_james_clark_perf_python_track_linked_libraries_as_extension_dependencies.mbx
patching file tools/perf/Makefile.perf
Hunk #1 succeeded at 538 (offset 12 lines).
Hunk #2 succeeded at 571 with fuzz 1 (offset 12 lines).
patching file tools/perf/util/setup.py
⬢ [acme@tb-x2-perf perf-tools-next]$

- Arnaldo
