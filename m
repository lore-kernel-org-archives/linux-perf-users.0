Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E2A25B0B1;
	Fri, 22 May 2026 23:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779493966; cv=none; b=tadsE+mpoiEqwUXknvilt34pHkamRuF5FisN0TKEqhFR01UPLm2HdHD2qsQ7Om2T9c/2hh/7vLE/jbJ/OZDt87VZ4nBCmIUmeKxrpnDM4L+JjKcYzU0vwIUss+BuJkEEmI9KxBEwOEM3LVVIeYFQje+t73+ZPaCwuEgfqiF26oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779493966; c=relaxed/simple;
	bh=XYz5JA+U04L0FDSPqO9/Q3hGUZAwBhj0IvXAp+T3L+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ip1wsZc+XxqbmAoHbcNDosfS8UIFyBOVlLElwpS8WJiZR7uYhQF+N/GiL385IoVKfo0E1uyQ4l3qIRXKq7GS6CaxrT3VuCFomXcs88MB5ELZkGhVjQHUODh4RhJhnElUhptXbsTdqrZ3WkYlooeUJ3uMyOlq+dtHp+Xqk204YJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClIaBfUV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClIaBfUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C101F000E9;
	Fri, 22 May 2026 23:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779493964;
	bh=ih5PFDFDw0NH7ur4/FGVW9tv0p92F0T7l68ZdBIVr/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ClIaBfUVPpibtE5bV9Rq3BIURdSzCbIa+wBJaZOT37otiiqCoRYREbj04YCDEzp96
	 uxcsi2z6l7YyAZi2zkeXw0i63NhHS8HJ2FUmSzc/JT85VW8zz7S3k087YJXSL+3p5u
	 LiQpMKwmug/zDW2xoiFlGLkyHttAvL3v68pVa0W8kaPY2i/0MWtdhul+i1ZwlfjYBf
	 MTR3eVLhZHULVVO8zNS4wO6NkzC1ROrguy2GLZPMNbOoTilABeuUquCt1i9ARZTbTc
	 wHo0SfTdskLtqpLAzM0tKE0nOmRYQjVg1NXuGgCoFMmzPCr4kbQNYhegDF+IEeJDAo
	 57fWiNKKxL0dw==
Date: Fri, 22 May 2026 20:52:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] perf: Fix kwork memory sanitization and libunwind
 test builds
Message-ID: <ahDsSXAYd3eHwp8_@x1>
References: <20260521072429.1283423-1-irogers@google.com>
 <CAP-5=fV+H3fNnOSYzPoJkdC79DpVOzk2RzLcctYOLjcz81EdBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV+H3fNnOSYzPoJkdC79DpVOzk2RzLcctYOLjcz81EdBA@mail.gmail.com>

On Fri, May 22, 2026 at 02:33:05PM -0700, Ian Rogers wrote:
> On Thu, May 21, 2026 at 12:24 AM Ian Rogers <irogers@google.com> wrote:
> >
> > The combination of the libunwind refactoring and build system changes
> > exposed a build-test regression for the libunwind build using a cached
> > feature dump. Re-send kwork fixes [1] moving a definition to kwork.h
> > to avoid breaking no libbpf builds.
> >
> > 1. Build Fix for libunwind:
> >    "make feature-dump" runs without LIBUNWIND=1, skipping the setup of
> >    libunwind LDFLAGS. When Makefile.feature is included to generate the
> >    cached FEATURE-DUMP, the local test-libunwind.bin compiles without
> >    arch-specific link flags (-lunwind-x86_64) and fails, caching a false
> >    negative ("feature-libunwind=0"). Later builds (such as make_libunwind_O
> >    reusing the dump) compile the unwinder based on CONFIG_LIBUNWIND (remote)
> >    but disable HAVE_LIBUNWIND_SUPPORT (local), breaking compilation due to
> >    missing maps__e_machine declarations in maps.h. Fixed by unconditionally
> >    setting up libunwind feature build flags in Makefile.config.
> >
> > 2. kwork ASAN Double-Free & Leaks:
> >    - Solves double-free in the record command argument array due to
> >      parse_options mutation, by preserving original pointers in a calloc'ed
> >      to_free buffer.
> >    - Ensures kwork_usage string is freed on all exit paths.
> >
> > 3. kwork Unified Memory Lifecycle:
> >    - Establishes a unified memory ownership model for kwork_work by
> >      ensuring work names are dynamically duplicated via strdup() and
> >      consistently freed using work_exit() and a central perf_kwork__exit()
> >      teardown path.
> 
> It would be nice to land these fixes. Thomas reported the kwork crashes in:
> https://lore.kernel.org/linux-perf-users/314df838-4c38-4f03-9515-ae1dabd09a54@linux.ibm.com/

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
