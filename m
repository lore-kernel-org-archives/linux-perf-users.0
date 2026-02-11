Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456112DCBE3;
	Wed, 11 Feb 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770812615; cv=none; b=LHY32dU49D3Lk/QioRpxuHw0VaY1YGqZ4g4wYOjwAjB568nT4G5zP2SSyIAsDvIu7rIlFD5ByeO3QItFFoq8rZSAwd16dCG3IqiHoJX28jJ3zYhPZhsBoBe6x/u5PIR6dmQtshQiUdZiB7NYt3g8XFOF5RPuzfoLNkReyutAuQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770812615; c=relaxed/simple;
	bh=aRbHbMXxA1HHvDev2TLdmsWBgi1ORs4/jyZv+ydD5Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwHVOUHPKNL24HrspPSrIILbZlX+PLcCawqeNonhVE3BIJSZ6CZGI9GwNVytEgPW2ERrp95uVQMHYooPUkZ2paBevWXFwu9d5we0iwE9RATeuCd8r2cY1MnlXK4DK3Um4Zj5bOhTFxInndgtI4T3ui1Pyr/HJ1urAknsYCTFBLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSFtTabi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSFtTabi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A3EC19421;
	Wed, 11 Feb 2026 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770812614;
	bh=aRbHbMXxA1HHvDev2TLdmsWBgi1ORs4/jyZv+ydD5Ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSFtTabiNgnTqkM+1gV0QXifduGzJ4yFxLFBiqX55zjUeMYAKYN3XNud/fxXdwRIi
	 OVXTBHP1h0bomrCnVK+WX4uBmPnVuGK/RVTnxlFGi8HZ2I8wl624W75IyE+qvDBWOZ
	 pswsSgz3PG5HWJKPMxEON2QM0A4bFlXehhU4Cit1RWFvikjXjcCQAyTBQ/ZVYbCHCJ
	 THQREmd7/6cjxH8u03FiUg27jCn6V9fed7r3Rhnc6YQ/4c4sLCtBUm+8pq+BiQdYLx
	 eHBKIHkI47P5UlmImEa1Ne1WLOoZRFcTUC3NR0gao4m2WMm8iPe4XhUHRP7uuZnc+Y
	 iMOHvThg/yxPA==
Date: Wed, 11 Feb 2026 09:23:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] tools build: Fix feature test for rust compiler
Message-ID: <aYx0w8AnkK2-c11z@x1>
References: <20260211095807.132855-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211095807.132855-1-9erthalion6@gmail.com>

On Wed, Feb 11, 2026 at 10:58:01AM +0100, Dmitrii Dolgov wrote:
> Currently a dummy rust code is compiled to detect if the rust feature
> could be enabled. It turns out that in this case rust emits a dependency
> file without any external references:
> 
>     /perf/feature/test-rust.d: test-rust.rs
> 
>     /perf/feature/test-rust.bin: test-rust.rs
> 
>     test-rust.rs:
> 
> This can lead to a situation, when rustc was removed after a successful build,
> but the build process still thinks it's there and the feature is enabled on
> subsequent runs.
> 
> Instead simply check the compiler presence to detect the feature, as
> suggested by Arnaldo Carvalho de Melo. This way no actual test-rust.bin
> will be created, meaning the feature check will not be cached and always
> performed. That's exactly what we want, and the overhead of doing this
> every time is minimal.
> 
> Tested with multiple rounds of install/remove of the rust package.

Yeah, seems to work, applied.

- Arnaldo
