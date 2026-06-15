Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8873859EC;
	Mon, 15 Jun 2026 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553314; cv=none; b=AUvpJsV52pl5e+HODFOmlPN15JXINdPCEITfscqFb2Zhb2ISga9W+NSoQIaM0xNtN9u3N7CDjoLpG6kNAEJVJ7F91iqqHNcwgRECpZY1LivvJFYmoy5HbHmLxVuoyxnilJAwVFYRbmXZceEhaUH3QFrgGzxyuxdmt20PvlRT+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553314; c=relaxed/simple;
	bh=k49/gCUICYtqxrL/ig32jQXTtX342RforaCclRAq93s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjECizCdamFcE/tMNPvbCVOOjybaYjRzuJfc1ssR9omw5tEU1YF0W85Ae7QE1k0iC07OLgApnAmP9hdfmIz2BPEdbW4ou3fQGg2gRV6JSByXfGENUvhHrKw3VIVQyGNEWrai/0KmuQEcNrxCh+Ba447GSMP21TreqQx2jhzPaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l59aZvBB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l59aZvBB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B3D1F000E9;
	Mon, 15 Jun 2026 19:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553313;
	bh=cX+aZXmIzVmggZMfVn9nBPrnGDAG/98qVUikFkFDMIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l59aZvBB/jKFqZo4Y2IRZO0hjKZvCFCTcoNrLKB6GskghMKy0ws/yTI3Va4fbcjja
	 zyfPzt3+HHBalYyVblG0KesRlHWqKsooQlcXnI78OdcdyA7OeJj6vfNI5/bjUmJsmN
	 c0vZ9KYZsDoETYeG1/ixHVlg8iQnWfEwSuhzF1RNXmiWl83BFB4NS0i1L0romP3mIr
	 uzREgec11qS+x1JWFaK35Ue7enIERkpr8ymSHCfJPt/ivqFWJ/UnP+2P9n9/MoAMeb
	 EcnuzhnHuMry+CttGiTxXYtYtRG7fXOjzE8zlvlavLN9X9LiebV7YSgqkFE63NNOtS
	 1r/CAwMS6QMFQ==
Date: Mon, 15 Jun 2026 16:55:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH] perf: Document recent additions to the perf.data file
 header
Message-ID: <ajBYnQMctGqDVFTN@x1>
References: <20260612192847.1221091-1-thomas.falcon@intel.com>
 <CAP-5=fXicnkOSeRCgZu2OXNvOJYVM9qOQdrUStOomnoT2powkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXicnkOSeRCgZu2OXNvOJYVM9qOQdrUStOomnoT2powkA@mail.gmail.com>

On Mon, Jun 15, 2026 at 12:21:10PM -0700, Ian Rogers wrote:
> On Fri, Jun 12, 2026 at 12:28 PM Thomas Falcon <thomas.falcon@intel.com> wrote:
> >
> > Add documentation for recently added HEADER_E_MACHINE and
> > HEADER_CLN_SIZE data to the perf.data file. Also fix a typo
> > at the end of the header section.
> >
> > Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> > ---
> >  .../perf/Documentation/perf.data-file-format.txt | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> > index 0e4d0ecc9e12..b90cba9168f8 100644
> > --- a/tools/perf/Documentation/perf.data-file-format.txt
> > +++ b/tools/perf/Documentation/perf.data-file-format.txt
> > @@ -464,7 +464,21 @@ struct cpu_domain_info {
> >         struct domain_info domains[];
> >  };
> >
> > -       other bits are reserved and should ignored for now
> > +       HEADER_E_MACHINE = 33,
> > +
> > +ELF machine and flags data. e_machine is expanded from 16 to 32 bits
> > +for alignment. Format:
> > +
> > +       u32 e_machine;
> > +       u32 e_flags;
> 
> Thanks Thomas! I found that endianness was missing from the
> e_machine/e_flags for capstone disassembly support. Part of me thinks
> the unused 16-bits of the e_machine could carry information like this.
> That said, we also have endianness information via the perf.data magic
> value. Anyway:
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
