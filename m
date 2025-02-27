Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0DA59;
	Thu, 27 Feb 2025 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644451; cv=none; b=qkhu4ierUXwtjGvxamg8GdkSx+Kcc5Kh6+NExdNBwfPXJ7moNsOUP8FPPQ481DAC5OGE1HiqsrFgUdCOwB/R3sgkoHXT9dK3lcL50/StB/+aoCDi6yQlHXGdTogrsnkQkp6ipIYmAmYLYFW3BrLaIDjwO5iISBHKp4oX4SevBlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644451; c=relaxed/simple;
	bh=4ffz2MO6+Bn9pTFZqNJARYS9yBa3M1fEfZf1jWfeuZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZTgIT9CF9rTJgWSLn0aOxWkf18hUbuwuR8zr0OyK1yywCcH8UYpSKmpQ2GAzRdxpbOvKYuLALLzd9c3R3xUy2u1jG4uztRDib33TenQAZM502ldCtmjCwY0vvz1M4Hrnn49+ynkS2MvZ0/zF5nibQCDxAPZJaNfm2FObAv8rPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jno52Y+p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jno52Y+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3790C4CEDD;
	Thu, 27 Feb 2025 08:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644451;
	bh=4ffz2MO6+Bn9pTFZqNJARYS9yBa3M1fEfZf1jWfeuZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jno52Y+p0y0rkxxqKEwyjRQtikEA+nCRBI1ijB/0h3csf9VeX2Ga3bz6B6CH8eQcf
	 X6dXc/bA38gFwQ8u5XgycUufL3J2HAFQMrziO3fpnCSRFZbFO0T2ZF+Up0MUweuKpX
	 vxr/YGicslV0+tQ6a46KJp+JQaYeb4kBre+N1fY68mLwlK41NzFeiukSt5cSh1ME1S
	 sE1B/3popzwjPDoOLOLtg4PlcEI++MHSisxtC6OmwazZgW/LkOgblKhfOT2AOBfS+q
	 qS2oTmvlO6Gkue+fGTTlvmmm0r5MwfpdmTgqZSIaMOrSKHJC7jI5oH5Hpkm4bU8l0r
	 aH61UBq4yk1pw==
Date: Thu, 27 Feb 2025 00:20:49 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com, terrelln@fb.com,
	leo.yan@arm.com, dvyukov@google.com, james.clark@linaro.org,
	christophe.leroy@csgroup.eu, ben.gainey@arm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf record: Add 8-byte aligned event type
 PERF_RECORD_COMPRESSED2
Message-ID: <Z8AgYUnNkSA_Q36F@google.com>
References: <20250227053738.788153-1-ctshao@google.com>
 <Z8AAcZXtuD7O3TAV@tassilo>
 <CAP-5=fU4rVkTS07Uq8g9roO4kXq_z2R0CgMX55YFXFWMHzWTGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU4rVkTS07Uq8g9roO4kXq_z2R0CgMX55YFXFWMHzWTGw@mail.gmail.com>

On Wed, Feb 26, 2025 at 10:20:36PM -0800, Ian Rogers wrote:
> On Wed, Feb 26, 2025 at 10:04 PM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > On Wed, Feb 26, 2025 at 09:34:06PM -0800, Chun-Tse Shao wrote:
> > > The original PERF_RECORD_COMPRESS is not 8-byte aligned, which can cause
> > > asan runtime error:
> >
> > It seems pointless. Most architectures have cheap unaligned accesses
> > these days.
> >
> > Just disable that error?
> 
> The perf_event_header in perf_event.h is:
> ```
> struct perf_event_header {
> __u32 type;
> __u16 misc;
> __u16 size;
> };
> ```
> so it is assuming at least 4-byte alignment. 8-byte alignment is
> assumed in many places in tools/lib/perf/include/perf/event.h. We pad
> events to ensure the alignment in about 30 places already:
> ```
> $ grep -r PERF_ALIGN tools/perf|grep u64|wc -l
> 32
> ```

I vaguely remember that it needs 8 bytes alignment to deal with partial
mmap-ed data on 32-bit machines so that it can make sure the header is
not across the mmap boundary.

Thanks,
Namhyung


> Having sanitizers I think is a must, if we allow unaligned events we'd
> need to introduce helper functions or memcpys to workaround the
> unaligned undefined behavior. I think the padding is a less worse
> alternative and one that was already picked.
> 
> Thanks,
> Ian
