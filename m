Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A143A9852;
	Fri, 28 Aug 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957440; cv=none; b=mYhmUg6CHjKlmd//MBFz7qNlEGKC4VYnptopvN7TT++cMBKofsQ3LMAXCiaFx1sXcKBmI5rMrTMxT3V2SNmDWig9/AVvKFwn1hAWqAJo332WKUCHByVUPTluwcr2io17N0M8x9VFj7kthBDlmrk8Z7OrlYXTnBwPjKTJG+Whj4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957440; c=relaxed/simple;
	bh=YzYbS/mUgTdW7TpPgxk34yQk8/yCr91EcgGd7JNd8X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCrj6hZzNZbxAzeeXJEHb3NvlMlG7j1DFB4Wf6IaVsqarwJQhzkmPSszoMj/9h6WgKUMLucXeghYeBoOiWXhSNxx01JMPJqW3gdLehBfY97eoTns5McGrMu6+vs2LuG2Ie+nqqHxwxa1Gktc5RyFknrBYKDrXk4+gwZJAh86puk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSIBaFvy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSIBaFvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5221F000E9;
	Fri, 28 Aug 2026 22:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787957437;
	bh=zmVmiMxAWKb570gh6PdWPY+Luuzb6Ouehc/PzemXyQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hSIBaFvy29YKnD5qBFTkHUkI8asPX4zxliFdaldDmWwiiSbaLQMmv/kxUwpx28Xnu
	 Z9A8g+irkWBW07G1l3dy+s6Ge/dMs3RGaMo2Xq64SvJ5OKcufr5EhsgCSi0cdXjc9/
	 KYnLc3seo/YEwTqWIJO07vNtCqgwEUOHav9FLCj+mR5r2C5h1SWv5UH1gV3owboxqq
	 0KkD7WDCdpAB+DcSXvHL9+ZsKXEp0UY6Wlo11Izg+zNzQ6rRfeb4Ar8LnfYU67dPeu
	 BY6IlOg2O/R1y7JkaG/Lwbm1WlCPoUEhvMwrApy0OASh2BZ8E0Omr5RRN0SJADf9Sx
	 9KqPTxhOLFXUQ==
Date: Fri, 28 Aug 2026 19:50:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Chun-Tse Shao <ctshao@google.com>,
	Zide Chen <zide.chen@intel.com>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v7 1/2] perf pmu intel: Generalize SNC cpumask
 adjustment for multiple platforms
Message-ID: <apIQuQAPGaEhKesD@x2>
References: <20260527221934.3830896-1-ctshao@google.com>
 <20260528001117.3BBF11F00A3A@smtp.kernel.org>
 <CAJpZYjUiNdN3a6y+8rs=YP2Mgtj6EQJnkiB9TN_suWd8fGkoEg@mail.gmail.com>
 <CAJpZYjUhw8+ouKTS82G6ih457=pHn18AtvwMCAcaTL9csKmdTg@mail.gmail.com>
 <CAP-5=fVAckZihxg4djQn7iTGbNNT1vFLXt2En8mm8+COSs3GcQ@mail.gmail.com>
 <29d02905-14fd-4c2a-86d0-a605e9d41b10@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29d02905-14fd-4c2a-86d0-a605e9d41b10@linux.intel.com>

On Fri, Aug 28, 2026 at 04:11:38PM +0800, Mi, Dapeng wrote:
> 
> On 8/28/2026 1:28 PM, Ian Rogers wrote:
> > On Tue, Jun 9, 2026 at 11:44 AM Chun-Tse Shao <ctshao@google.com> wrote:
> >> Ping for attention.
> > I suspect Arnaldo and Namhyung are waiting for feedback from Intel on
> > these patches. If someone could check them it would be appreciated.
> 
> I suppose Zide has checked these patches and gave the "reviewed-by" tags. :)

yeah, looking at it now it seems to be pretty well reviewed, I'm about
to start processing patches for the next merge window, will get it
merged soon, thanks for the ping!

- Arnaldo
