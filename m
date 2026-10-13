Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9214554DAF5;
	Tue, 13 Oct 2026 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923524; cv=none; b=eU9iFV3c+PMTEMNY9tnbcqAphkDflgE0p8OGwi3phBiCR9VoRS4TdqAumElK9XaPtAv/jrK6kuEtZZyhcaMTwN821vona1hkBwAe2wPVL15siwEMHdtYuucPvJQ9KNNFguS9uFyoHClPaYiCob8ZixhBV7+zY9e6OfBmV+FWuTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923524; c=relaxed/simple;
	bh=zB1bYAP7BlE3kghgTbTWzukoIkZ0zPngPL3n5uFA4l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgZ0dd9Gy+PEzmV07B1IbkhDgMexQ/adIg4e8r1h/tIK0ycZ0Jg+bJJxGqCidDvzECD1em1VXEgWe1ws3H5KgeUUx9vP749ejIwdsCANoz03rAfppRzRoqDk0OhKq5FHC0589d6BBU0GvQlIlNcWBKr2h7jd9CmtT8BPPMZQI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=OzOTAYrO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="OzOTAYrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1791923517; bh=zB1bYAP7BlE3kghgTbTWzukoIkZ0zPngPL3n5uFA4l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzOTAYrOsNXdT7HaUIlD1URf/tUABcu0MwYaT22Ws/35IVkul3E+7ETsojrEaUzXx
	 qsoVSwiMbfkYJ+3NLvhFmXaWQmDn9XFle2xnhBLO56tRpQSd4V7e1vC7M0sv9dfnZP
	 0Rvg4JRNePLtXuIl9Kx6sUKwI7Ber97YFUXUJ9Tg=
Date: Tue, 13 Oct 2026 22:31:57 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	linux-kbuild@vger.kernel.org, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] kbuild: factor the userspace ABI flags out into
 KBUILD_USERABI
Message-ID: <e92f7acf-a8fa-4138-9703-8feb3cd55499@t-8ch.de>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011233647.2454648-2-sashal@kernel.org>

On 2026-10-11 19:36:40-0400, Sasha Levin wrote:
> KBUILD_USERCFLAGS and KBUILD_USERLDFLAGS pick up the flags that select
> the target ABI for userspace programs: --target= under clang, -m32/-m64,
> or CONFIG_ARCH_USERFLAGS. Collect those in KBUILD_USERABI and export it,
> so programs built outside of kbuild's userprogs can be compiled for the
> same ABI without also inheriting kbuild's warning and language flags.
> 
> No functional change: KBUILD_USERCFLAGS and KBUILD_USERLDFLAGS keep the
> same value.
> 
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  Makefile | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

(...)
