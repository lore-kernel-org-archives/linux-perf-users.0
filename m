Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94D1AF0B4;
	Mon, 23 Dec 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734971839; cv=none; b=PPLUZq4w6mcO9A6wff16q+SbpD+jmIMQh+2xinjbCCe1W33sVk8DzQYt3SABT7qsYyPtzqvYDal50baib/6bN5UhJmGcU1agRpfyG7PtM+0e2uzsM9yGI9Z/gf5rkb1ei0tgg6Rq0taIabqlyHXdYuTjKi7v+8GG8jg+UpCXupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734971839; c=relaxed/simple;
	bh=rIaNRedYjqT4O1vrhnqnSY3wVgfMnQsQVACnCqrwQ7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhuqiHig9xEWr5gHZwR1LXIhR8CEyTesLIQNuWu8SwpSMX2LWpgV5XNwNz/sHslqNF1FbAUYLZUwqRMYc6fk1Ta7dYBKLflatS+nzGt77OkpeftGMM1pcbZ6zDht3pbdJeJa18b7gddqqrrb88+UGdAkK7rWEzYQ0pwGDVTudwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=eA2MC7f8; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="eA2MC7f8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=gGbeKsemM6vqc8uPAsUbgJTExrupjropy+SU9oG3OUQ=; b=eA2MC7f8mbXfv9Eu
	11wY4D/seSBaH0LNVcR5fppFBt/kAMfvph3smiiZjM/o6F/N/yR1vv0hoU5lf94jm5WM9IpFY9+MY
	oS2ZSDYpHEkVwkj5l92cYSTdZc+cFtPJawxfwS0SzhqX86aygFyz3aC5RV6En8dYRw3AjwATnFaus
	3Et0Wrax+H8zCkOEmMTeW2kHwtpMFrZoQ1v+ifHXe/Bzf99aAQ8u4fqc3yu/2lULPxyHJ7NahxkQi
	L9O0GbtVAoO0TLGJ7RpSMiwf7bYkY+P4/FTc68QI1v36jEf1Dbf3/9veEs0qpfOEv/ui7jOJ9XEcq
	SeeYeuywhJUMsTklsg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tPlQQ-006tiR-0l;
	Mon, 23 Dec 2024 16:36:58 +0000
Date: Mon, 23 Dec 2024 16:36:58 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: irogers@google.com, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Remove unused is_executable_file
Message-ID: <Z2mRqjIQJUhxJ8wa@gallifrey>
References: <20241222215831.283248-1-linux@treblig.org>
 <Z2mQjAIwBcx4_Pm0@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2mQjAIwBcx4_Pm0@x1>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:35:02 up 229 days,  3:49,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Arnaldo Carvalho de Melo (acme@kernel.org) wrote:
> On Sun, Dec 22, 2024 at 09:58:31PM +0000, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > is_executable_file()  has been unused since 2022's
> > commit 7391db645938 ("perf test: Refactor shell tests allowing subdirs")
> > 
> > Remove it.
> 
> Did you patch this on:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
> 
> ?

Apologies, this is on 6.13-rc4 (ish - it might have been slightly further back when
I sent it).

> 
> That function is still there, so I'll fixup your patch, keep your
> credits and test it all.

Thanks!

Dave

> Thanks,
> 
> - Arnaldo
> 
> ⬢ [acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 20241222215831.283248-1-linux@treblig.org
> Grabbing thread from lore.kernel.org/all/20241222215831.283248-1-linux@treblig.org/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 1 messages in the thread
> Looking for additional code-review trailers on lore.kernel.org
> Checking attestation on all messages, may take a moment...
> ---
>   ✓ [PATCH] perf tools: Remove unused is_executable_file
>     + Link: https://lore.kernel.org/r/20241222215831.283248-1-linux@treblig.org
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ---
>   ✓ Signed: DKIM/treblig.org
> ---
> Total patches: 1
> ---
>  Link: https://lore.kernel.org/r/20241222215831.283248-1-linux@treblig.org
>  Base: not specified
>        git am ./20241222_linux_perf_tools_remove_unused_is_executable_file.mbx
> ⬢ [acme@toolbox perf-tools-next]$        git am ./20241222_linux_perf_tools_remove_unused_is_executable_file.mbx
> Applying: perf tools: Remove unused is_executable_file
> error: patch failed: tools/perf/util/path.h:12
> error: tools/perf/util/path.h: patch does not apply
> Patch failed at 0001 perf tools: Remove unused is_executable_file
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config advice.mergeConflict false"
> ⬢ [acme@toolbox perf-tools-next]$
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
