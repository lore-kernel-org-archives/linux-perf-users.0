Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C893EC6A4;
	Wed, 15 Jul 2026 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139716; cv=none; b=Xb5gVqp9I/kG2/S+RmgzVK05xPtaIkQ/q263sJlu1c6/RyaEPfw/WkTpbx9jKg0ougIDKILSaL3xXGjtWDd/cm1TayPIGDp44ygEceVhl5XcFGlvrlA31Rykf2pEgCyW29gTa3v+40SxU1GcVZWvqG8zgJT8LJlBt/nkv2rESxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139716; c=relaxed/simple;
	bh=jvyqiEGDlDPAY39VjzAaLBkUb5V1W4nAReWxGSXGIGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qheF1/lvOd2DGm7kHEx9/3zK0tQXqv+VeE0tbbX/q1Iy7IkgNphd+tboO+qFR6ohljjPxbTMu+21JNftBzhbZZBrP49n/T7qTy8NOBNc2T9mmvzTPtPOJRs1hijIYR52xtBnha7e4U3y8SRVVwwH6jH7LVTciwMKq7fqLP0rtLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6VnUXlb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6VnUXlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2BB1F000E9;
	Wed, 15 Jul 2026 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784139707;
	bh=q7FyobgUfnhunJ5F9IhBarq6sejEcHzB3Iga4iGTXx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h6VnUXlbAjI0XFCn8Lerj6YF79lE9Z02OThY3lrzUQXDWY30YzQYpSyqaY5SIJXoO
	 r6xyqqvVVVauAGXy/61Gi2Sw/n/A3Zyh1PYDidG8cWoMTycwSXxpw95s1jjW/d9AWl
	 /5DfWm12I0mrmhunNkRM6gdJrgHnPsU9dr4fwctvsekjTndHiIrJ97zNeaqubxuFOA
	 PNGpsBsDfsH12QQ3HkRi3H/QelgV+x67ADLOUOQaREHiCa9g28LTwiOyNqx84jWFzo
	 SgDP7IfUGWgbnw7zJ7nHUhm6VF3Fw+/QaR3QkZPDyXAtdD/+E4NVbHOleyroieetsv
	 t8omshhansuHw==
Date: Wed, 15 Jul 2026 11:21:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de,
	mani@kernel.org, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, irogers@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/12] perf vendor events intel: update
Message-ID: <alfPuIxX95FTv5Jt@google.com>
References: <20260714204044.1952031-1-ctshao@google.com>
 <CAJpZYjUa4HpbUvPhcjG3-ezKkig8bd1mbdQmb7xo_c9S_uyvfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJpZYjUa4HpbUvPhcjG3-ezKkig8bd1mbdQmb7xo_c9S_uyvfg@mail.gmail.com>

Hi CT,

On Wed, Jul 15, 2026 at 10:35:35AM -0700, Chun-Tse Shao wrote:
> (Please disregard my previous message due to a formatting error, I
> apologize for the spam)
> 
> Following feedback from Ian
> (https://lore.kernel.org/all/CAP-5=fVc6tw3hfnvB7n_UZ3B5JF7vBpm7cnE8516t5HVUWwFNQ@mail.gmail.com/),
> we have decided to address this by fixing get_cpuid_str rather than
> modifying mapfile.csv. I will send a separate patch for that.
> 
> Please disregard this v2 series and use the v1 series instead:
> https://lore.kernel.org/all/20260713181757.481164-1-ctshao@google.com/

Thanks for the clarification, I will apply v1 then.

Namhyung

