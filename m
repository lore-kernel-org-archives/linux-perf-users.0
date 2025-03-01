Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39839801;
	Sat,  1 Mar 2025 00:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787431; cv=none; b=U95U0apY9/a4wSx6e1uVVZk1GpZgx2fAVdrNsJSvZngQJ6rbjursQgkkas7ifEGgA/hptj62kR+ZEMCxekqA4V6n7GtXQgRGBRb43u7bvCOuqVEQ8tiYQyVm975qwL3vEUj04nw19gMzl8v2lA3d+8n5ccQ0lt3+rvi4aNFCU0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787431; c=relaxed/simple;
	bh=XpTXUM3kKqDmOrJLizBkP2m6KOt2oo8fdMht3cxSGWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzqjDl5tsqcsn7hi0f3Jbu6QzhZECB47XN/IUR/QLJA3KJhp4rPPxyzGZC5Sj2StBXhlct9wAdw0mM/SEDvHAsta1z40vGgcobZ/snfvfznPFEAGahzOOGX6SE58qUnOJg+2NFLoUmM79+FGVtKalCK7abtQgJVx2y7OR7kaRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl0/vCff; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl0/vCff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377D2C4CED6;
	Sat,  1 Mar 2025 00:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740787430;
	bh=XpTXUM3kKqDmOrJLizBkP2m6KOt2oo8fdMht3cxSGWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gl0/vCff9mMqhzOlpLMP2HDglzKERqhWDNHa1lzQOHTFJdm9qDj7DSbgeB0i3p3Ah
	 EkXVGH6rbTbiz9E9TJXNtReaGBfVa5MvOOFxEYizUOcrbmYAR7f6afptYOstSmZ4+N
	 iI0OAYShRdyiy3OAZEBwIPxeTS0UOnP02MOw9LgAt+XYvwV0mYe5/r8rXr6jmRGIp4
	 lf0mg4oLEo7J2s3gkchiKOMfkT1NNZ/A171OxqSPD5HuOhfQnPWI8+9hIZi0ItBjyU
	 XsneAKLVuEdjOyvES27FMOZD3JzfIFIbHsGr40sZ4m8HZH4kCMwnWf+YBszatLFcTc
	 VbBQxuCQ2jx2Q==
Date: Fri, 28 Feb 2025 16:03:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/6 v2] Fixups for kernel maps insertion
Message-ID: <Z8JO5Jp2b4OyHImx@google.com>
References: <20250228211734.33781-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250228211734.33781-1-acme@kernel.org>

On Fri, Feb 28, 2025 at 06:17:28PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi Namhyung,
> 
>         Here are the patches from the recent session on fixing the build
> when DEBUG=1 is used, please take a look.

Looks good.  It's more fine-grained than I expected. :)

> 
>         I think that since there are no reported problems and ended up
> being a sizeable series, we better apply it to perf-tools-next,

Sure, will add there.

Thanks,
Namhyung

> 
> Best Regards,
> 
> - Arnaldo
> 
> v2: Use map__set_kmap_maps() as suggested by Ian.
> 
> Arnaldo Carvalho de Melo (3):
>   perf maps: Introduce map__set_kmap_maps() for kernel maps
>   perf maps: Set the kmaps for newly created/added kernel maps
>   perf maps: Add missing map__set_kmap_maps() when replacing a kernel map
> 
> Namhyung Kim (3):
>   perf machine: Fixup kernel maps ends after adding extra maps
>   perf maps: Fixup maps_by_name when modifying maps_by_address
>   perf machine: Fix insertion of PERF_RECORD_KSYMBOL related kernel maps
> 
>  tools/perf/util/machine.c |  6 ++--
>  tools/perf/util/maps.c    | 58 +++++++++++++++++++++++++++++++++------
>  2 files changed, 52 insertions(+), 12 deletions(-)
> 
> -- 
> 2.48.1
> 
