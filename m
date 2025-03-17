Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F8D188907;
	Mon, 17 Mar 2025 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228269; cv=none; b=ppmD6I+6IJF2EEGIrTC0zLsb7onL+hnft5MbCx0cT6+q75elmLYbfkJgb3SFZ3smCDNYylG6Htkiuev5pkUsyZ4ed3JzgvL2bdA5uG6Ya3l18DELjy76x9ItMZBgA7Ou/iy/5X9ptB6mtlYLDuzafdnTz/tnsb4sSa3DvvT4kWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228269; c=relaxed/simple;
	bh=G42GrbRlFLadgeAorXitKrnMtX3TCyZknmA2IK3Bfk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTYMC5D2riKawAkKLIWEF+pbOYLdXsaQlFDCkAsS3OjbzOQnuFzfxMoxF5UbB2zscWTb3NwZs8jGEtKdFJK+YAUJoR/2Th+9JYcZ5OOCHW3DvnBs9WSz7TruekYuRdwUCUaa0bO2Xvv2gT99Sd/crwH9kBJrDchl0kn0TBvi1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4XUfczs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4XUfczs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9201C4CEE3;
	Mon, 17 Mar 2025 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742228269;
	bh=G42GrbRlFLadgeAorXitKrnMtX3TCyZknmA2IK3Bfk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4XUfczseN+rrOTPQuSZejroQ55t7/R8yhHyg2TG2Tupr5raFLs5Wzetyo88H+cyn
	 Dq3z3oW7xQB7+OZoqOyuPhfwt6PZ9OC4OT77sk9KsRuhlnGVgWScxSaxsbtSYzf4F+
	 VXUlCcMu7o5qRPXsqX8PFkhi4gdX0gKPDkkDM+wohSpn3zAxpbaBmQ9b3gvoBEjAwh
	 EEovcEMfbONYlKjgZy1hlYLEXmAJlbB+thdvhVnpctjxxgLvMzIR1FO10XSUR8ccLE
	 ZWwpYFC8jLivmP8F6WyPft+wBbqhOEE+gIB39MhcTbjzS3THdb25FrAiTKCAnWBA/5
	 TaQa5kdB86ieg==
Date: Mon, 17 Mar 2025 13:17:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com,
	james.clark@linaro.org, christophe.leroy@csgroup.eu,
	ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf record: Add 8-byte aligned event type
 PERF_RECORD_COMPRESSED2
Message-ID: <Z9hLKsZOfouM3K7H@x1>
References: <20250303183646.327510-1-ctshao@google.com>
 <Z9TXabugl374M3bA@google.com>
 <Z9hFJtEKfsGGUDMg@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9hFJtEKfsGGUDMg@x1>

On Mon, Mar 17, 2025 at 12:52:09PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 14, 2025 at 06:27:05PM -0700, Namhyung Kim wrote:
> > On Mon, Mar 03, 2025 at 10:32:40AM -0800, Chun-Tse Shao wrote:
> > > The original PERF_RECORD_COMPRESS is not 8-byte aligned, which can cause
> > > asan runtime error:

> > >   # Build with asan
> > >   $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=undefined"
> > >   # Test success with many asan runtime errors:
> > >   $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -vv
> > >    83: Zstd perf.data compression/decompression:
> > >   ...
> > >   util/session.c:1959:13: runtime error: member access within misaligned address 0x7f69e3f99653 for type 'union perf_event', which requires 13 byte alignment
> > >   0x7f69e3f99653: note: pointer points here
> > >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 00 00 00  00 00 00 ff 07 00 00
> > >                 ^
> > >   util/session.c:2163:22: runtime error: member access within misaligned address 0x7f69e3f99653 for type 'union perf_event', which requires 8 byte alignment
> > >   0x7f69e3f99653: note: pointer points here
> > >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 00 00 00  00 00 00 ff 07 00 00
> > >                 ^
> > >   ...

> > > Since there is no way to align compressed data in zstd compression, this
> > > patch add a new event type `PERF_RECORD_COMPRESSED2`, which adds a field
> > > `data_size` to specify the actual compressed data size. The
> > > `header.size` contains the total record size, including the padding at
> > > the end to make it 8-byte aligned.

> > > Tested with `Zstd perf.data compression/decompression`

> > Looks good to me.
 
> > Arnaldo, are you ok with adding a new record type for this?
 
> Checking the discussion and the patch.

My first impression yesterday when I saw this on the smartphone was: how
will an old perf binary handle the new PERF_RECORD_COMPRESSED2? Will it
ignore it while emitting a warning, since it can be skipped and then
what we will get a partial view?

Having some session output showing how an older perf binary handles
PERF_RECORD_COMPRESS2 would be informative.

I'll try to reproduce/test this all...

- Arnaldo
