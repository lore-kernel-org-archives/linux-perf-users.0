Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C455B23C393;
	Wed, 19 Feb 2025 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003257; cv=none; b=dC4+YEuLJYWTS1L0RJCmU+S9Lrh28HqfjLodHPtiCY8UD6iRzRU7hIZ9isK71Lv/GDkD1pl4r76du8uGZAzmkn1hbSC2pYEFiWg9mVTc3m2TKzCDQv1dq0W/P4VrJ8tV+jI/kb+j3oQOMgT6nWErpEqVYmF1HP4CybnZCUJG5p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003257; c=relaxed/simple;
	bh=JeI53DFR5fb2vBXnNFPnu54DZg9eT1lCDTFnsz+MBHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVvQJ4lWfBvwLEfMcuvne0GQSslMyB4jR+Gn7XVl9TQB1Bbvf+fwBPzoYTbnegb/gQEM70dFzjuyICosALVqhAi8gGUZKMTd2yXqpWL8ApiAAwNHilyzvX5dxUviH7VCjgC7BDZlOfk2m7zBxevy3BwVXMe7ge3OlycXV55keIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/NkNv2Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/NkNv2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB904C4CEDD;
	Wed, 19 Feb 2025 22:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740003257;
	bh=JeI53DFR5fb2vBXnNFPnu54DZg9eT1lCDTFnsz+MBHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/NkNv2ZiE9wOssvzbftAr9Mo3HI54WGDnq8Tc3phCcW97Eyd/2ND/5sXx1y4LJGM
	 XYPtGBvuZHy1aSPsLTk+VWRTzS2esPeY0SbMaEaKqBKCHhoTJpvgcHYN0NcwtDrBBK
	 2l/Kmc2yK17HVemDzwuJ85MGZ+zaRUwMzqdNrIyVHroEhxbM9f0UPgXA4uSC04eAG2
	 Wao+/Sug3kHW6Qd1Q5rlDxlz4NT6jbZhqc7Y25voWVQPzZC5ML/d9+hPYC2gv2JMuq
	 LLvCi3liY6Hi3+Qjc7snHKsogsnBGQOCxBXMhM+E5VuvtSpDGpf+KdfNaCSFgQqXCG
	 ZCgmgy2Sq0XQg==
Date: Wed, 19 Feb 2025 14:14:15 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/1] tools: perf: support .gnu_debugdata for symbols
Message-ID: <Z7ZXt_Qttdrw6rAQ@google.com>
References: <20250213190542.3249050-1-stephen.s.brennan@oracle.com>
 <20250213190542.3249050-2-stephen.s.brennan@oracle.com>
 <871pw0gw8d.fsf@linux.intel.com>
 <Z7ZKAYutejOOoBbQ@google.com>
 <87zfihbnsq.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfihbnsq.fsf@oracle.com>

On Wed, Feb 19, 2025 at 01:57:25PM -0800, Stephen Brennan wrote:
> Namhyung Kim <namhyung@kernel.org> writes:
> > Hello,
> >
> > On Fri, Feb 14, 2025 at 11:30:26AM -0800, Andi Kleen wrote:
> >> Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> >> >  	DSO_BINARY_TYPE__GUEST_KMODULE_COMP,
> >> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> >> > index 66fd1249660a3..e578b7d406a69 100644
> >> > --- a/tools/perf/util/symbol-elf.c
> >> > +++ b/tools/perf/util/symbol-elf.c
> >> > @@ -6,6 +6,7 @@
> >> >  #include <string.h>
> >> >  #include <unistd.h>
> >> >  #include <inttypes.h>
> >> > +#include <lzma.h>
> >> 
> >> This needs some ifdefs in case lzma.h is not available?
> >
> > Right, should be guarded by HAVE_LZMA_SUPPORT.
> 
> Thank you both. Do you happen to have a preference on whether to do this
> inline with the HAVE_LZMA_SUPPORT guards, or whether to use a helper
> like lzma_decompress_to_file() with a temporary file (presumably one
> which is already unlinked...)?
> 
> I suppose the more I ask the question, the more it feels obvious that an
> unlinked temporary file would require less new code. Both because I
> could use the existing helper, and also because there would be no need
> to free() the data which we decompressed into memory. So unless you have
> strong opinions I guess I'll switch it over :)

Should be ok to use the existing helper but I guess you still need to
call close() once it's done with the data.  Also I think it's better
to add dummy functions in the compress.h when LZMA is not supported so
that the symbol code can be unaware of the configurations.

Thanks,
Namhyung

