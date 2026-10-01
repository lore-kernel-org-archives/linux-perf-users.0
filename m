Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4570550AC15;
	Thu,  1 Oct 2026 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870151; cv=none; b=PGgsoWppSwKoaBCVAaEWPiUoJrw1h9EOHwwoUdXJbwsfzlAlzF84Lp2KV94wZkPcIQpxy7Lz6c1iUmfBx7iaIHsZjcz0nEeUPG45r0d/JaJVzYENazGBmB5FVpFheFgJU8nq0kuE+Zh3qA+G+N6TZC5OdBV6TLxmk9o6PbgnPUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870151; c=relaxed/simple;
	bh=9G8fC9vK6q3WS7QyN9/mgOXXOGbJu6zmrLM+PWRXRu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfdRjma1LhrWy20iYe4mc12Ksr7zeZjyaP/AKCqfv+qvvX4Pds64DN8vLWvLHunkATmjaAGitwVcG+BwTeG5LMCFGLSFxfxXhQQjeKMldsqi8RrnWAJ8L4zP7ymjGeqiteUnRFJ5f+V8gAzHWC+IQtFgo0vwjkdPhoUBuq0bM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lA2rqNIw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lA2rqNIw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37D321476;
	Thu,  1 Oct 2026 08:55:37 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 443013F86F;
	Thu,  1 Oct 2026 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790870140; bh=9G8fC9vK6q3WS7QyN9/mgOXXOGbJu6zmrLM+PWRXRu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lA2rqNIwSfXh1CQf8o+gTWbCPDKoMqpEk/DpJm5TIZKLkhBiDE37L1QOyQ1xIRT6O
	 z4kWw/ghQy65lQ/FQamYsEiy/4wl8BhKNy/HeZZ4WM5gG5Pu0Klxf4ByQi7y1GmfBh
	 hWcx9s1bxZYNjX+35pXiAJjWUY0cxoVSVlR3ShqE=
Date: Thu, 1 Oct 2026 16:55:38 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2 3/4] perf test: Suppress optparse deprecation warning
 with older pylint
Message-ID: <20261001155538.GA1208404@e132581.arm.com>
References: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
 <20260930-perf_fix_pylint_errors-v2-3-945cd526576b@arm.com>
 <CAP-5=fVzy-=8ryObpHWiW6WDcvpW7SqRkAWwmNvoSgQmgz-3gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVzy-=8ryObpHWiW6WDcvpW7SqRkAWwmNvoSgQmgz-3gQ@mail.gmail.com>

On Wed, Sep 30, 2026 at 10:39:36AM -0700, Ian Rogers wrote:

[...]

> > -import optparse
> > +# Pylint before 3.3.5 still treats optparse as deprecated.
> > +import optparse  # pylint: disable=deprecated-module
> 
> Thanks Leo! Could we just update to argparse here?

Thanks for suggestion. Please see the new patch:

https://lore.kernel.org/linux-perf-users/20261001-perf_replace_optparse_with_argparse-v1-1-268b604f8e55@arm.com/T/#u
