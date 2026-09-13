Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410F26FD9B;
	Sun, 13 Sep 2026 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335941; cv=none; b=sbhRXjxkXCfSK/22LiuqBr4gtcJAXLOTtj7NJb2KSxLsomaMOX+XMIkVjhhy/j/7rxCkubVK6CjjRBuEjtZ8mU+qbpMb5RZJskgMV3am/auI7Z6AEvKk/fA/74lfPxHQt26hNE2THN9PVzbhRdZZPGeh0eIhmMkHVo/FhwWYAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335941; c=relaxed/simple;
	bh=kozrj0ZnEsmTVum2FV1VdqXGVuxjfN0MqSTS14MQb3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACiMFMV3uyM4OGCThJdwPGpimyX44NeT680syr+5yuMpexTl6B4lqdH+OG0mgRkBqUrgOPL9dsikavVPUU2O42eO90AX9D2KsojMmrpoZW14J8Tst5qJMKoZR0S2eS4dI7zyFB0H1zk6IVisRditUp3OTfiuierOfzpbAUq16hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fosl6tpG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fosl6tpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6821F000FF;
	Sun, 13 Sep 2026 21:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789335940;
	bh=kozrj0ZnEsmTVum2FV1VdqXGVuxjfN0MqSTS14MQb3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fosl6tpGQ1QE8AWfBWO9Qgs0yfpzhSSORLzssGHAocSFBF3kt+VV4vcHTvMsfdwjn
	 pTrQo/3uxXgAdHslAej6wTO/1ZVh1Yx1tN8R5Xuld20hn2ueEZzdq0CWJbcT/4ghhP
	 8Fw07bjt9FBBo0m1ibM2+2Pp5d4escM0txj0M1j/PSxeRcc0JI1039VfACqP4pKUP5
	 EdE2x4rVCZIN24tZAvi336XkqloOs3itiWDZpEyu5cOO8aC104NeFOsgjlDaaVhI3f
	 8dtoDMfQQvGQiiEIO8DYqWPj5TaH36/1TIGce7liydZkZpe/IBjEmzKOrCbYrTLzGH
	 EF/mhuUh+WtxA==
Date: Sun, 13 Sep 2026 18:45:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Qerogram <qerogram@naver.com>
Cc: namhyung@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, irogers@google.com
Subject: Re: [PATCH perf-tools-next] perf list: Avoid repeated strlen when
 escaping JSON strings
Message-ID: <aqcZgKhnWFAaVf5i@x2>
References: <20260910123839.72285-1-qerogram@naver.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910123839.72285-1-qerogram@naver.com>

On Thu, Sep 10, 2026 at 09:38:39PM +0900, Qerogram wrote:
> The %S conversion in fix_escape_fprintf() calls strlen(s) in the loop
> condition while escaping each character. GCC 14.2.0 retains this call
> inside the loop in a normal DEBUG=0 (-O3) perf build, repeatedly scanning
> the whole string.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
