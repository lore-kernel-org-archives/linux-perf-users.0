Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED11427A
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779754540; cv=none; b=ESZLvHSpZf6AFZSBfXmBRrocx6etiEpmeFy4jocJEX6n7sZ0e4k7RyhyKPigklsODyZnrYlQWjn+2hU3Xm9qKOIAuLmwh+tdsKNZvf1lCnwhSVDottKEfV+mt1o3UQms6vAo2gsZQWwz3rVIhP9UP1dvugixk2TWqiVMrEuhQUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779754540; c=relaxed/simple;
	bh=IMvZi/gEARnyw7nFqH4E5dDCNY+GHVim4lKJWSY28TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPOJ1sM/sdlz8UQqU6ZpRQWhc3PS4BxKVE8NWwIcFYiFavRu2bW1RzPX4vNFlllhRTY6fwqoeJ9lQdnwlC/I01H6l8dycfkxHrvVq+K6IxrpocMe/F1rMY5B7A4sXfd5LpghcL1hyqFTMFLBKvbHlND1wCyu7E1TcL3lNIJZ6kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESHkQfvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESHkQfvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250861F000E9;
	Tue, 26 May 2026 00:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779754538;
	bh=sNxhh0sGTo/v6pHCTPp30lxMgH+kpUZu+u2UGduBT6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ESHkQfvDzksEKNns+nSb+8IO+A6ENvmYkdEIfrs3YLM5LYMtyLR1EPxJDSPOYQnpG
	 QzL/i61B+9LLUAdK9Q+qrcf1HG1zJ5hpMf/aU7PM07lg65Skc7Q3ECZZ0ernCrs8T8
	 q/8znVjZtNAL20OvVTZjSlRDRTxaQiD+n6Y3oEQ1/GdO4tFVJN1WbuDNdyrTZcgIus
	 JPP30TsxCUhojYxx0knwUDWu2M0Y+e5sZiD3Txk/yIMBoViWpMh4yLPGm49YXEDGfS
	 i2DfuWcsBq9pBph9Asli/Slqoym8C4kWyUFpqqlz+j2R45XlxJcffOJipRxbyBirED
	 6aLEUEhbANAxw==
Date: Mon, 25 May 2026 21:15:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: Summary of perf-tools-next changes and patches sent to
 linux-perf-users
Message-ID: <ahTmJyLLZYOPpnKa@x1>
References: <CAP-5=fX=vEmTaz6mWgExmrgyYMJmSyOD+1sMCzf7JTk1SkA-zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fX=vEmTaz6mWgExmrgyYMJmSyOD+1sMCzf7JTk1SkA-zQ@mail.gmail.com>

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

I'm doing this locally as well, helps.

- Arnaldo
