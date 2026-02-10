Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A455221F15;
	Tue, 10 Feb 2026 01:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770686797; cv=none; b=cESiJZTqvqjOOaMhNU7rXQksV6etJiSjzGgh5YrpgRWb0NMIFVQedr3KjYbvORH4/ieNBa+m5gkLZtv3E2G5vHpDjVuOlkTSRSHrkGE/uoZvzeIyhhgy7tup1tAk6Y3LPmjCIRGhzlWgsNxcZKkvpO8W9tkqBSAtcP8lquPAECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770686797; c=relaxed/simple;
	bh=/JL/NBJ3mmRn8+KkYwBL+HgZXwf7DY85OyQZwefolqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCQe1wTHaIj55ytiIDwCH4pSA0tearSIr0fbQybesdgBM1cfuCiBbEr/opSGfghuQM3kUhxeRHjFIEtrAp4l5/RWr9SF5g4Jgh9dm+WKWViWLjgcv2X4vbl5XAhIMf/U554uR2f5465+hHxgMZPVTLlWmyzgaajKPjASn3zkmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/23l/2V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/23l/2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748D0C116C6;
	Tue, 10 Feb 2026 01:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770686796;
	bh=/JL/NBJ3mmRn8+KkYwBL+HgZXwf7DY85OyQZwefolqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/23l/2VkTzTKj1a1VUE2iUQFLWGIhYtxuddqKo8pTmWblqQIpAy+zZHVRl/ZDthM
	 h9CN7bbNygfHyIfoG2B4AKA51gb1Fc4TYi+QfJBYx1XYpxH0/DM9WTfOgWYCSn8Hwi
	 o1QNG9UzrTkBMW7g3EiXD1HF3BQO9e8HrajICxWfS+nlQP/3arZ9n4CvD7uq0gM1rE
	 MEYMYM53yVkMxrIVSQVad6vxU7MrJEFbjLhipsFGHo05xDXGfGatuLgDN/kxbhf81t
	 RTGwnN2LbpJguD53NEDgY9x+B0ItPhNNuqAOxBVBl7hCdjq2PlxuzOdmnb+xazSv4k
	 CqwIWQQ7pEzgA==
Date: Mon, 9 Feb 2026 17:26:35 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Rust data-type profiling working in perf was: Re: [RFC PATCH v2
 0/4] Test annotate with data type profiling
Message-ID: <aYqJSyTgG0oCUClS@google.com>
References: <20260208122227.3524-1-9erthalion6@gmail.com>
 <aYigHLZtXooznMB7@x1>
 <aYig1O0-5yxy91la@x1>
 <6i5osof4lst2rjnta232tvntpbufrpzihp6jicsysob36pj6ss@6acco3e7r4ym>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6i5osof4lst2rjnta232tvntpbufrpzihp6jicsysob36pj6ss@6acco3e7r4ym>

On Mon, Feb 09, 2026 at 09:45:32AM +0100, Dmitry Dolgov wrote:
> > On Sun, Feb 08, 2026 at 11:42:28AM -0300, Arnaldo Carvalho de Melo wrote:
> >
> > Also please consider adding examples of output of such new features, so
> > that people can quickly see it in action, data-type profiling for Rust
> > seems interesting, right? :-)
> 
> Agree :) What would be the right place to put such examples, somewhere
> in the documentation?

Yep, please add it to the documentation.

Thanks,
Namhyung

