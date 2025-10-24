Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A73221DB6
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271818; cv=none; b=ovp40VrKPMMh/BiEtYymAvdHE5EbFJsqeV59MI3cQlmgOU9PJEnG5B3m3luvsEtoaJMkgkrcXW04f8KCzQCbCZUKphyZmwAlcKkiIXvGh4Y/Ojw04+Pqz7qPhu4wjN0KlApd26ns7TwnF7CVaiA2iXzPRqok4AAfDr/ZqLzFUts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271818; c=relaxed/simple;
	bh=PQeC3BNC4qgb2T6cpYj+muD6fS+0qX37xv8G6La01l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ/a/zgWOOjT0vuNBut0OgfQAqHGoMCoxuuLi7UY2kpBWpIToinUQX4LbqqLfmpf3QEoe3Ea3uioODMIOcgcHKb8u797WbUOGzJGe8qf+gWpBGVbgbkv7nLPAyyhlTgqvdTAsirTH5124au/1CSUoFJ4Oo5zV0pKgIZNRaDxFtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tscZ4krR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tscZ4krR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFB5C4CEE7;
	Fri, 24 Oct 2025 02:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761271818;
	bh=PQeC3BNC4qgb2T6cpYj+muD6fS+0qX37xv8G6La01l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tscZ4krRrdwUnmJA+R9oqb4a7zgnIh5eaLadWeEZWkfUyzDR5Hkl3645Y/QBmIiAf
	 K1sftGS58DQs/NzW50qw6N4b3vojVDG7B/GsD4SfvXKeaNucV7v8Ku1AFQdTzQUWuO
	 Mn/58i01pmBRzKVIRuScvzfmID+q7v/Zd4xclGFedoFb0fxXGlTrLBda+M0yDWbWF+
	 dzxxD9JtRcVok5TlvSddCnmaEpRJ4nzkiTPiSNkVqYf01C/TIhh9/eybLtyAJ4lS1P
	 c9sz4jZyQuQ19zf+Y4BjesstpwDx2diBtKX6ds4rdy76ofpzmabe4VNMuZ5tPP+6xu
	 eV7kOifGoTjcg==
Date: Thu, 23 Oct 2025 19:10:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tony Jones <tonyj@suse.de>
Cc: Michal Suchanek <msuchanek@suse.de>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf hwmon_pmu: Fix uninitialized variable warning
Message-ID: <aPrgCDJ_HqSzq9V1@google.com>
References: <20251022103839.19550-1-msuchanek@suse.de>
 <aPqjMzxyYeKCp91K@google.com>
 <aPqoGTyM9nKSQYQ9@suse.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPqoGTyM9nKSQYQ9@suse.de>

On Thu, Oct 23, 2025 at 03:11:37PM -0700, Tony Jones wrote:
> On Thu, Oct 23, 2025 at 02:50:43PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > On Wed, Oct 22, 2025 at 12:38:35PM +0200, Michal Suchanek wrote:
> > > The line_len is only set on success. Check the return value instead.
> > 
> > Can you please share the actual warning messages from the compiler?
> > 
> > Thanks,
> > Namhyung
> 
> [snipped CC]
> 
> I believe it was the following (gcc13):
> 
> [   38s] util/hwmon_pmu.c: In function ‘perf_pmus__read_hwmon_pmus’:
> [   38s] util/hwmon_pmu.c:742:20: warning: ‘line_len’ may be used uninitialized [-Wmaybe-uninitialized]
> [   38s]   742 |                 if (line_len > 0 && line[line_len - 1] == '\n')
> [   38s]       |                    ^
> [   38s] util/hwmon_pmu.c:719:24: note: ‘line_len’ was declared here
> [   38s]   719 |                 size_t line_len;
> [   38s]  

Great, I'll add this to the commit log.

Thanks,
Namhyung

