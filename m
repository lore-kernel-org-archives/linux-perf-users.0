Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0605191F91;
	Sat, 16 Nov 2024 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731787874; cv=none; b=UoW2mZGkpLsV0t+gb75Yb4I8dXBPo00d6itcckNxvEDAMRxoV3T1pNgKMwC41aM831i4EeBd1UhDPf8vFMazO+HLyL9nIXA4vds2pClfLuCZXuIwjJZrCfuB5NN9BH+7kL2gold4Pcx2AFTenyeFMYxVdPMe3dwNu1stBIhCMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731787874; c=relaxed/simple;
	bh=EeWzMrWdfD/HxxinqMu5HNzCaz3avaGlrsyOzZ0EeUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAm2Y3kVnZgoDpT7ypfnjLQQpquAw7M1SnjwXSjxLmooOXiFrSto7DexvVsu54wFEBTZxno5rzOn/eAICJqv7NTb68Aq6Lzt4+q8nLsDkiJdYCpG1mjDUVinstb4LFXYY4NcdPPNo+ARR274Pb5zAGNRYodYqXgOdQM7yxzP69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=WCcBLXUI; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="WCcBLXUI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=TizVYUSUbAB7nwIteA1ejCNMb9z7MQUcwEoVieNbuEY=; b=WCcBLXUInIt9QudM
	H+j7dd2kokoDTm3am/ARR4s6bb9yGVR2HekYXjXiWtvd02/GukMvS0lQ1BiyvZxY4SC9czIqTHG6s
	nublnIj7oBDc2tZXsLC9gfG4SGqzz7omYC//j6U+tgzILcISeCCFmlZaE4hCfIubkC6B06qQ4/Gnk
	fjtweYciJfiktdqERgGDxyICJTidx5dhhLi687Ia0sPok15LA49n39ayIRxqZniPkjxW+O62+f5V6
	5BP3bU9BQMUWVBLpFXXPBMMcBU48PLdt+w+J7Q1FHiEN2uq4+cpuy6OfGPVYtXYS6uHbrotN9tzvL
	uwHSw+d7asPsYrFV3A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tCP8I-000Jjn-0j;
	Sat, 16 Nov 2024 20:11:02 +0000
Date: Sat, 16 Nov 2024 20:11:02 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, namhyung@kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf util: Remove kernel version deadcode
Message-ID: <Zzj8ViF6Q3NZu0-e@gallifrey>
References: <20241116155850.113129-1-linux@treblig.org>
 <CAP-5=fXqig=qHAa26d5-8pHPCtS0ZyCNs4FJGr4c4BSjFe+-eg@mail.gmail.com>
 <ZzjxxCnicVIwAF5N@x1>
 <Zzj3y2BN_GcnRKbK@gallifrey>
 <Zzj79IHk9ylwvfiJ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Zzj79IHk9ylwvfiJ@x1>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:10:47 up 192 days,  7:24,  1 user,  load average: 0.12, 0.05,
 0.02
User-Agent: Mutt/2.2.12 (2023-09-09)

* Arnaldo Carvalho de Melo (acme@kernel.org) wrote:
> On Sat, Nov 16, 2024 at 07:51:39PM +0000, Dr. David Alan Gilbert wrote:
> > * Arnaldo Carvalho de Melo (acme@kernel.org) wrote:
> > > Thanks, applied to perf-tools-next,
>  
> > Thanks!
> > Have you got:
> >   [PATCH] perf: Remove unused del_perf_probe_events
> >   https://lore.kernel.org/all/20241022002940.302946-1-linux@treblig.org/
>  
> > from a few weeks back in there?   I don't think I've had an email
> > response to that one.
> 
> Done now and pushed out, thanks for cleaning up the perf tools codebase!

Thanks!

Dave

> - Arnaldo
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
