Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5399A28030E;
	Mon, 20 Oct 2025 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958345; cv=none; b=G5LHE6UcRtZRiw/YPJLClnfs5aWl5PWwVaDr+ouvt6ToGt8NN5H9AmRTjuIGT08Wv72N0sR449m8CbRyTZEPXqAuyN3Xovu1nuIdRIgCRNfATATkR8L2oJeTIKdfwpHPAKhbtWOYZX15aifBDZbjjUr3QqqvGg16LyRWVCdm+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958345; c=relaxed/simple;
	bh=p8FbxxyqDaWha6IAODck454Cur0UZ5U6vyp4DvJ3Ji0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCWccoWeEiGA6iGMTB2gGJf7bw1+kUkYtV9fsU5B8tpMtsSpOIUgdkjK4iNHyZqh2/ww9ltQgpuCyDFbndIJI8AUL/B1+Kl6NBJ7N6vdvfvvnIUw8d+U5iac6d+61juEdVcKVpAFm7jfoVbYLGvt5H8bJtMbV1gPPAh9/cue1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC4641063;
	Mon, 20 Oct 2025 04:05:34 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58EA93F66E;
	Mon, 20 Oct 2025 04:05:42 -0700 (PDT)
Date: Mon, 20 Oct 2025 12:05:40 +0100
From: Leo Yan <leo.yan@arm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf build: Add Debian/Ubuntu python-is-python3
Message-ID: <20251020110540.GF281971@e132581.arm.com>
References: <cover.1760617634.git.geert+renesas@glider.be>
 <e1c0c2acbab60630cf8538ac5446f91970dad92d.1760617634.git.geert+renesas@glider.be>
 <20251017122904.GC281971@e132581.arm.com>
 <CAMuHMdUUH2AN7tE3C7cPWeNJDW6jL9vQOktaRDW2HChDwvroSg@mail.gmail.com>
 <aPRR1APPW8vro4HB@google.com>
 <20251020093136.GD281971@e132581.arm.com>
 <CAMuHMdXEBX2CK8iE-Mc0dPR5gV5dBM6QU9LsEWnWgO-d=o6xVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXEBX2CK8iE-Mc0dPR5gV5dBM6QU9LsEWnWgO-d=o6xVg@mail.gmail.com>

Hi Geert,

On Mon, Oct 20, 2025 at 12:15:22PM +0200, Geert Uytterhoeven wrote:

[...]

> > Can we explicitly suggest that developers install python3-devel or
> > python3-dev instead?  Two reasons:
> >
> > - python-dev-is-python3 is specific to Ubuntu/Debian; some distros do
> >   not provide this package and even advocate against using unversioned
> >   "/usr/bin/python" shebangs [1].
> >
> > - As Namhyung mentioned, perf has removed Python 2 support (at least
> >   this is claimed), it is straightforward to install only the Python3
> >   packages.
> 
> Suggesting python3-dev sounds good to me.

It is good to mention both python3-devel / python3-dev (one is for Fedora
and another is for Debian/Ubuntu).  Sorry for confusion.

> None of the two checks:
> 
>     ifndef PYTHON
>       $(call disable-python,No python interpreter was found: disables
> Python support - please install python-devel/python-dev)
> 
>     ifndef PYTHON
>       $(error ERROR: No python interpreter found for jevents
> generation. Install python or build with NO_JEVENTS=1.)
> 
> seem to be about the python interpreter anyway, but about the python
> development environment.

Either is fine for me.

Thanks,
Leo

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
