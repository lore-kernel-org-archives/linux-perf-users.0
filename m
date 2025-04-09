Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7B25DAE3;
	Wed,  9 Apr 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744196082; cv=none; b=i9O2JAwj1bkdWbjWTNDL89hvwViFcwGZR++BBrZSTU/SvKW8XInlsru3xjZbqs+xbMgK3WMSvRBZQHYFJHnImepjskYRVneXfyXBtsnQqvxjomm9hnj4vdbWbLGBxXETiXRzE3fVt5CpL8sc2t81DjjTq80EtnsyLWlKj5UH39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744196082; c=relaxed/simple;
	bh=afhU1dWHc1n2usOgVXlNTp6Z03tRmuPrfnW4JN6sGnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojl7wIhUvq5u2dseIWUaMstYAe2Wph0+FpiMCcDMPDwmM/jlnG3J5ED12GVHEefZK6RIAHifgOGqvg8HZdZEUv49uPVwI0m1/fulHdah/oTXjaEefoIPz+MoC95pDf0MZ/rmo6eyV+RbYf63QERcjjuUJRfvlzqdZBG+Jil7O3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYUaGBT4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYUaGBT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6D2C4CEE9;
	Wed,  9 Apr 2025 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744196081;
	bh=afhU1dWHc1n2usOgVXlNTp6Z03tRmuPrfnW4JN6sGnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYUaGBT4bXK9TCbssJPfEPUva0lZneoBqwQa0OgLrsIkYaC0XT5A2FDeWRqmvLn4b
	 b4KPKLJByHOuQPm8Dcx/o4vG0huxiFJUHdES81SZmIerrt2LxHP6iaIhFJt/2De7zm
	 F0RravFF/v/qBlZCNhoa991MvZ43K9Q4GghxU/ixUEvtBts6i71ZzH/MwSpY0gn5vb
	 +WK26KNWBuOeaBNV1P67Rdpc0TSpFYMw/MIfQThpwx6WtGsSRR89FwIDZ4XYEbPGlH
	 6JQMUqRisD9NsnnmCQeNuDi0+ClH8/+mvRoJUiJon3Oc5OybOSyOuguOiuFp8RCki6
	 xIYuuEFAfEkmQ==
Date: Wed, 9 Apr 2025 12:54:35 +0200
From: Ingo Molnar <mingo@kernel.org>
To: mark.barnett@arm.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com, ben.gainey@arm.com,
	deepak.surti@arm.com, ak@linux.intel.com, will@kernel.org,
	james.clark@arm.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/5] perf: Allow adding fixed random jitter to the
 sampling period
Message-ID: <Z_ZR65SK9hEm561W@gmail.com>
References: <20250408171530.140858-1-mark.barnett@arm.com>
 <20250408171530.140858-4-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408171530.140858-4-mark.barnett@arm.com>


* mark.barnett@arm.com <mark.barnett@arm.com> wrote:

> @@ -14384,6 +14409,7 @@ static void __init perf_event_init_all_cpus(void)
>  		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
>  		cpuctx->heap_size = ARRAY_SIZE(cpuctx->heap_default);
>  		cpuctx->heap = cpuctx->heap_default;
> +
>  	}
>  }

A stray newline snuck up on you here I think. ;-)

	Ingo
