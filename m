Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D118EB0
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779754973; cv=none; b=YYNgfB7RHWup4ZVURp1WpvAICxHMVQJwRTRThB+xvz3DIvs5MUNJudRXXOdwmNifdaxp9vxLc/QaIEJkyow3128mDr2ci2bq9oRhMxGwNUZ6rB0ovqemNhVgs7eO6K3+PHJH2yr1F0/uk9VeSq/DHikedfvTH47mBCjtUtxven0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779754973; c=relaxed/simple;
	bh=+GDVZ+o1TQvxX4P6DZzb2h99SCG6BsX6/edxGhbk6wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRwDuoSfUuaswl5ep3ROS9liNZ1nXTzYnJgzwVdzIP0bqCNv4eVDPlABaN4RharJuHj910xjC67Y3uAOc9ylD597bz34yL+25/DpLN+/zTDGLtIrLG0d3vYp4a7QN18jmz7s8RXvmu+PfffrZuIY3kjEWLYTh7Y7oVwsy57LHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwdlYbTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwdlYbTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F6A1F000E9;
	Tue, 26 May 2026 00:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779754972;
	bh=BPsM8zt2us7PUMzN0u/5tDOMOApTNPSw3bGFr/XhMZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LwdlYbTqCINt86KbjLSVYN+1WK+BNKQTSjzW26QPBal84K07zfLZauGNIcYJHI9wc
	 WPEVSpMiPH13Jf/bKI5qNCfsPG96hEVc5p1QSgwI9GCMWiTvAW7hTaBTp29+gPkVth
	 DoZzKYDHtaANHCevsfurhLvo89YGJQTtNSfRmcW6FyTrVBJlal9gZNrcbrTbaj0FWO
	 2AX3yRmJa0hAvNntLKli9Hk1gGWHEZX2RxPX31DjbsfHYNizqFVh05WOcAz2TK010y
	 6vauh04Fp2ymmn8YVL+3ipZVG1mDmtYLA+5nQt9+Ywu5iNQtPH7EJPlrOn12FgLfQT
	 8yEsgdNqyG94Q==
Date: Mon, 25 May 2026 19:22:49 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: Summary of perf-tools-next changes and patches sent to
 linux-perf-users
Message-ID: <ahTn2SnHbe4QHdEo@google.com>
References: <CAP-5=fX=vEmTaz6mWgExmrgyYMJmSyOD+1sMCzf7JTk1SkA-zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP-5=fX=vEmTaz6mWgExmrgyYMJmSyOD+1sMCzf7JTk1SkA-zQ@mail.gmail.com>

Hi Ian,

On Mon, May 25, 2026 at 04:35:51PM -0700, Ian Rogers wrote:
> Hi,
> 
> I've been working on a script [1] to summarize what's been sent to the
> linux-perf-users mailing list (using nntp) and compare it to what's
> merged into the perf-tools-next branch (using git). The idea is to
> make it slightly easier to track down patches that might have been
> missed. The script shows what has been merged and what's pending, what
> Sashiko thinks, and whose turn it is to work on the patch (author,
> reviewer or maintainer) using some naive tag analysis. The output is
> quite large, so rather than adding it below, I will send the last 4
> weeks in separate e-mail replies to this message.

Great!  It'd be very helpful for me.  I have two requests.

1. can you make it not to wrap the long lines?  I guess it may be an
   email client setting.

2. can it show only summary of the series, not whole list of patches?

Thanks,
Namhyung

> 
> [1] https://github.com/captain5050/ian_tools/blob/main/missing.py
