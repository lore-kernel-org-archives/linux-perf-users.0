Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4081FF7DA
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459636; cv=none; b=TpYOxUhtUq9+iR/Ddj2ILDONw/CMxBi/P75xd/eL58F7pIhoBy8sN0jqSBROS2lqRYfu8AMr6Vd0c6Mk28ku8YlOpO9sKm3lKOTia0a5a9zag8mvYvZZT8b7CMuCJTsjW/T0mPXfGY/s6Y8L1zeFqFCU5mnD+FbqVBjMFU5wN2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459636; c=relaxed/simple;
	bh=391HNqFehXOw1V8bsEr7UXnf15uPmbqwhL3qo8KIc0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I65+k6isrIwHBIfNV8EMu1FjamfPg6DLGaiX4JjWEgGpRcTj3ksmh6NjvhZHUxW53sKBrGoGsl4tW1SRu3uMHDGMtNtrxZ3JBBE9OC2++y1OtVZc6UJnUgjdSi3J02lKeBdIIRVRRy1MAENXpxslabOB5tUaWq31+T1PNOWST5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/JDXLeq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/JDXLeq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5139C4CEE2;
	Thu,  9 Jan 2025 21:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736459635;
	bh=391HNqFehXOw1V8bsEr7UXnf15uPmbqwhL3qo8KIc0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/JDXLeq/1LxouR07u9ngiGL9w28e+J8uyy2WCvJC9Pm1C3mcncjJ5cSCPtaVUlYD
	 7nY25vSxZLQ9ybNz2XLJ4SrAde5tysTM7AoPkS0tEV2iH9rs/2krfc5BFLYSxX1aJA
	 pbqQZTB3HkMGqmJcs0plntqGNa2qSn8QviSGQ1jWZ+thQsCNcxI3ts0DZu4wj835dH
	 7kAEWsgpKISW4BQ1v74mkUgsDE6kj9tXifvIT1YbXauNubk7bAOmIyCbe2FI0Q6MQd
	 uHwK1o5QCENTiNs+5eBq+190oEZVyt1UqxOMOYZ8a4vkaMV5+JZTQ2hdGOGySMf/lB
	 u0vssZ/YjI0uw==
Date: Thu, 9 Jan 2025 18:53:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michel Lind <michel@michel-slm.name>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/1 perf-tools] perf MANIFEST: add license files
Message-ID: <Z4BFcA0L3IfsmtbZ@x1>
References: <Z0Zcx0WRqtlUYpgw@hyperscale.parallels>
 <2fe55e73d3ef64ec3bfc683446e3f1f8b9e8c9e8.camel@michel-slm.name>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe55e73d3ef64ec3bfc683446e3f1f8b9e8c9e8.camel@michel-slm.name>

On Thu, Jan 09, 2025 at 12:55:16PM -0600, Michel Lind wrote:
> Happy holidays all!
> 
> On Tue, 2024-11-26 at 17:41 -0600, Michel Lind wrote:
> > The standalone tarballs should include the license files - both the
> > COPYING declaration as well as the text of GPLv2.
> > 
> Just making sure this does not fall through the crack - does this look
> good to merge, or are there any issue with it?

Applied, thanks for the reminder!

- Arnaldo
