Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEDE34751D;
	Wed, 29 Apr 2026 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447525; cv=none; b=CD5Dwi6CvNaovKXNzx8h996iFbt+ukWYPfbwbY337miMmc3YPurthju1baAjsszSd9G6/ZyUju43ox/kFsNCSnBUU+Ww3/OCiaWq5NvhNtOfjxaokwUcG/JQyFWPmIROms6fIFQvMRLsrqflJkV4g5MMFuOod+E24DZmNpNKXU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447525; c=relaxed/simple;
	bh=PLWmMocxHZ2qX2NovMeOADpWdzS7exOlBa2w6iPJ4U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq43EAhVrdR5nouZEX7GaWO5gVjv2dvU7XHWjQBZw1NCoOlpsLVhves8xm2J+Li9F3dQRkaCept+urRyETyQzO6TJqt87B6kvVcVXP5aC5HOIzjzkn0vSR3XXG9Ados6t7kbhBrUTYm413YVId1cZ/xJ3R/+2t6B7WhqShDNdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj6xxFuj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj6xxFuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608C8C19425;
	Wed, 29 Apr 2026 07:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777447524;
	bh=PLWmMocxHZ2qX2NovMeOADpWdzS7exOlBa2w6iPJ4U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rj6xxFujttZuPJkCeRLixk3SSSLQUo5vnoYYYbI8P6HxWYpP8zACy9jiMcnYzYUpj
	 tvOSWPuV2EF6LubdoUBc07gYMX8i0cIHdoX6hAoViTNMn/cXY2Jz1NSrCbSPqEk09Y
	 4SjX8CxaHUIFx3ycsykqICR7PlAUvl64KOuKq+nJxw6WJ9jhUVwbc4arplYSt6cKxC
	 DvIgh8dd2KIC8vESQgoUd2IQ7fpNrXn/WVjFJuXSdjGM/I+ScmFMSmXzf3o/T8k4rg
	 JbafMxVPwmLfKDdE4XVuZHwBybGeJY/MRCHj2bmEdvfFVdSWniObp9RgjtRg4KDRxX
	 YGppVYhsjUoDg==
Date: Wed, 29 Apr 2026 00:25:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v8 09/58] perf evlist: Add reference count
Message-ID: <afGyYi01XSNIS-A2@z2>
References: <20260425224951.174663-1-irogers@google.com>
 <20260428071903.1886173-1-irogers@google.com>
 <20260428071903.1886173-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428071903.1886173-10-irogers@google.com>

On Tue, Apr 28, 2026 at 12:18:14AM -0700, Ian Rogers wrote:
> This a no-op for most of the perf tool. The reference count is set to
> 1 at allocation, the put will see the 1, decrement it and perform the
> delete. The purpose for adding the reference count is for the python
> code. Prior to this change the python code would clone evlists, but
> this has issues if events are opened, etc. This change adds a
> reference count for the evlists and a later change will add it to
> evsels. The combination is needed for the python code to operate
> correctly (not hit asserts in the evsel clone), but the changes are
> broken apart for the sake of smaller patches.

Can we keep the existing evlist__delete() code?  IIUC most parts of the
code don't need to worry about python.  Then do we really need to
convert them all?  Maybe we can convert only the relevant codes.

Also I think it's better to split evlist__put() conversion and python
code changes.

Thanks,
Namhyung

> 
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Added evlist__put to pyrf_evlist__init in case init is called more
>     than once.
> 
>     I double-checked trace__replay() and confirmed that trace->evlist
>     is not assigned to session->evlist in that function.
>     trace__replay creates a new session and uses its own evlist for
>     processing file events, leaving trace->evlist pointing to the
>     empty list created at startup. Therefore, the
>     evlist__put(trace->evlist) call in trace__exit() is safe and
>     correct to avoid leaking that empty list.
> 
> v7:
> - Added pyrf_evlist__new to zero-initialize pevlist->evlist to fix
>   crash on re-initialization.
