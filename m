Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7BA2EEE7A;
	Thu,  4 Jun 2026 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609539; cv=none; b=EcjYrbjpBSJjmD+ONlmntGqVAxPWTY9BToAcCrzYHbTgRnbTYBzfZijVBFPgr7r26ZzOHe28+x4AaJQFF8FhK3nGO/K0qX4oqZe/9Z9U46dDCbSmKTv9P3BYP0rH4ZqLj0TTGgZ0XrHuD7mc3PptFEyJLpHX/w+MT5KVwzI1JoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609539; c=relaxed/simple;
	bh=eGlTq58OPuaKU98Sw1Dy4HI/GbZ3deybTOS4jSYPFNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjrMBVXsetSEYIgrfx8oBHItujValcLAHI+qdf0dPcE3dYw6N6bfN7eE/ZUwyxUW3vtHz0LZhfXsXwDOr7SgIYo2vxs/k3yAdorMkldPym2npZooVxJ9Wdy9OsymQ6MSSip00bxlJJ0oCFsDEA1HVgXAhGhmKjwNUdCkfBKV1gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxYilrHq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxYilrHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533F41F00893;
	Thu,  4 Jun 2026 21:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780609538;
	bh=D198WoNPL0fOturA9ZR1xYcBW/1qBSSMoaqkKcghODw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JxYilrHqnnWLoTwvovOz9tEAUf+NEKoMqo59T1zN9PwN+HTUJEGASY02GttELRIdq
	 k9Xhnh24HKnx4dOtdw08maj0vX4yUU73KPuVeBvkJwBRCiavK9YYins+7UH8twERxH
	 1qJa0VbC6xORR/ZvnS8yjHTkTvoT/vL04MaIwmepmkCDhz7ZHosOuutbBWxemNle1g
	 AP+XSILl+Hs6piDnpcg5x6XpZ88HtihDtfGhDXjWhbMFbXBY8PT5cuiic3OyTGFFw5
	 A/da7oyAk+C/FHyrq7z5E0VdVS6dGxZwS3Zm2RstrIcbAhUXFzP94iWEXtwQ8sev/M
	 jTNnikNXEgYiw==
Date: Thu, 4 Jun 2026 14:45:37 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] perf timechart: Remove unnecessary copy of backtrace
Message-ID: <aiHyAeODQHSxccCy@google.com>
References: <20260604190812.2168118-5-namhyung@kernel.org>
 <20260604191818.352171F00893@smtp.kernel.org>
 <aiHcxl4rHnvkcUkK@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aiHcxl4rHnvkcUkK@x1>

On Thu, Jun 04, 2026 at 05:15:02PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 04, 2026 at 07:18:17PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] Removing `free(backtrace)` causes severe memory leaks when the backtrace string is not consumed by the sample tracking logic.
> > --
> 
> From a quick look the suggestions seems legit, will wait for v2 then.

Yep, will send out soon.

Thanks,
Namhyung

