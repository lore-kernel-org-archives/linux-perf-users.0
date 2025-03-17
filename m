Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CBA1C8637;
	Mon, 17 Mar 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230003; cv=none; b=H4hwQHRkR+GPuYv3LG4VwueQqEi3KqGqWO7XQbpAFvy0bMQAnyZdex6+O/OtEW3wqE8dNMvHarMB4TxBrcy6GNrzMOt6yLdBpo8ttPel9mlZa0uEEESmL3xpDu18VLM0oHHYZ0ptl7V4YikP9i+gMfabtuG6xbO3hnC3n72FKxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230003; c=relaxed/simple;
	bh=+gpgx1f/Gxc036wNUlCVYAX4Xs//acADzBzuOoLrCmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrDWI1JAV+ViKKW+MYnxulhxaSuRP7OXL+veLTcK3Ed0LROq848D0Q4cokj0zYvrx9+LD1LQx/hn/6YX+fslc4p3g8kLtelWzyH1zkdAKHa4iwX6hpttfc3N8+3xzGCxH91lO0C4POvapBmTwOZ2jCkbR63lo7uLAS3jIGAZr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSyJzNu1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSyJzNu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9D1C4CEE3;
	Mon, 17 Mar 2025 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742230002;
	bh=+gpgx1f/Gxc036wNUlCVYAX4Xs//acADzBzuOoLrCmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSyJzNu1XI24vzUJST7LRc1wPpIUK8XSunvC5pBTzK2p5A0BCsBPOlhHmLIugLhc1
	 hYUD6cYUW4tCNSVi0feAcVrxk3oPVFcvf435Zmn0WabvlwIQKNdQzpULX1re49daXH
	 CIYEP8106uxqZHyfkuGEh19aH+6wBph+fomwnc7eR+Dz5Hek0pqkCAua1CjrZ6j9Bu
	 ezxDtFDcVWzhrk3SPzqFE/Fjy/XWo19PzHMHoYnNtDCMw/JhrBWHOV2Tw3Ldmohkw/
	 xMb57F7AEUzAZAsDfqa5oMRslK4Kt3EnBaUOx+LMtbgDOhqxrllkRQwAARN76f2KJk
	 n0t3MYcYMjhRw==
Date: Mon, 17 Mar 2025 09:46:40 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com,
	james.clark@linaro.org, christophe.leroy@csgroup.eu,
	ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf record: Add 8-byte aligned event type
 PERF_RECORD_COMPRESSED2
Message-ID: <Z9hR8M-SQ5TD2qMX@google.com>
References: <20250303183646.327510-1-ctshao@google.com>
 <Z9TXabugl374M3bA@google.com>
 <Z9hFJtEKfsGGUDMg@x1>
 <Z9hLKsZOfouM3K7H@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9hLKsZOfouM3K7H@x1>

On Mon, Mar 17, 2025 at 01:17:46PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Mar 17, 2025 at 12:52:09PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Mar 14, 2025 at 06:27:05PM -0700, Namhyung Kim wrote:
> > > On Mon, Mar 03, 2025 at 10:32:40AM -0800, Chun-Tse Shao wrote:
> > > > The original PERF_RECORD_COMPRESS is not 8-byte aligned, which can cause
> > > > asan runtime error:
> 
> > > >   # Build with asan
> > > >   $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=undefined"
> > > >   # Test success with many asan runtime errors:
> > > >   $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -vv
> > > >    83: Zstd perf.data compression/decompression:
> > > >   ...
> > > >   util/session.c:1959:13: runtime error: member access within misaligned address 0x7f69e3f99653 for type 'union perf_event', which requires 13 byte alignment
> > > >   0x7f69e3f99653: note: pointer points here
> > > >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 00 00 00  00 00 00 ff 07 00 00
> > > >                 ^
> > > >   util/session.c:2163:22: runtime error: member access within misaligned address 0x7f69e3f99653 for type 'union perf_event', which requires 8 byte alignment
> > > >   0x7f69e3f99653: note: pointer points here
> > > >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 00 00 00  00 00 00 ff 07 00 00
> > > >                 ^
> > > >   ...
> 
> > > > Since there is no way to align compressed data in zstd compression, this
> > > > patch add a new event type `PERF_RECORD_COMPRESSED2`, which adds a field
> > > > `data_size` to specify the actual compressed data size. The
> > > > `header.size` contains the total record size, including the padding at
> > > > the end to make it 8-byte aligned.
> 
> > > > Tested with `Zstd perf.data compression/decompression`
> 
> > > Looks good to me.
>  
> > > Arnaldo, are you ok with adding a new record type for this?
>  
> > Checking the discussion and the patch.
> 
> My first impression yesterday when I saw this on the smartphone was: how
> will an old perf binary handle the new PERF_RECORD_COMPRESSED2? Will it
> ignore it while emitting a warning, since it can be skipped and then
> what we will get a partial view?
> 
> Having some session output showing how an older perf binary handles
> PERF_RECORD_COMPRESS2 would be informative.

I think it'll show the below warning:

  <offset> [<size>]: failed to process type: 83

Thanks,
Namhyung

