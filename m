Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F928AAEB
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939590; cv=none; b=WAmgeAHERImkNp5vAOCtspmGOusbkGMAVYdMjVKaWMpYOjI6ajiFmieR4cDOYNJkEM3qT0x7SimCGeXziUYgZh8D6sPtJI0AYwJVZzrSxwGF9AWBpJIDWOBtss9v8EooOB7tqIgukP/eY330GEA7Q/YpqTcfZhZhf7NCft7/FvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939590; c=relaxed/simple;
	bh=iHsVkPE+Z9ggmLNq959L/8TAa97VKNkN4qQUPJE0aE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7alwxzj+Z2A0sYlZme6xWCSuVsrCLpHXfbIh/M3llsmki/TgLlGwMkqqthp2hQNjy2Y5crjgqyZW7Bhonu4PKGMENWAj87JN8NA9Yts5qPtGSIEHMNYZg8b0zV2HqWKsAzEpfPhFb+wyGJXQd4ENdevYdWM3YsfHRo8A6EnpZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pt0AOnvs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pt0AOnvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9B1C4CEE7;
	Fri, 31 Oct 2025 19:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761939589;
	bh=iHsVkPE+Z9ggmLNq959L/8TAa97VKNkN4qQUPJE0aE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pt0AOnvsvTofTICodu6nZsc95Z79/Ra/BSQyMwByChIv+zYuuwE4wJZ9rwOyyPUgv
	 aEqpqjUtnomJbLOZkQDHUorO5y3ddlJuVojCuH565cHSq1ACskkuJVYnOIBgYS0npb
	 OVbh3u+/cO9v/Wy8+DCb1UHVINavRtKKWpUdydzVCdjsOGgwm5UZueVQzozFNnuyCr
	 1+/A7hrfH/5h85jv2lsssJvHGntTAg3RtGOBi3rKOqaltMmomaYVBzXZjwtlA3oSeM
	 4sl61CDUsD3nA5fGr1Y7HSQP2ajPDIfQc2wJSGHwstPTqjw50B7z4GV+IMI72vvaaf
	 7LvkpZCeq80ww==
Date: Fri, 31 Oct 2025 12:39:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tony Jones <tonyj@suse.de>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com
Subject: Re: addr2line performance
Message-ID: <aQUQhHEmsk9Mm6Qx@google.com>
References: <aPkivW2WoySU1Zkc@suse.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPkivW2WoySU1Zkc@suse.de>

Hello,

On Wed, Oct 22, 2025 at 11:30:21AM -0700, Tony Jones wrote:
> Hi.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=218996#c1 mentions
> "there are proposals to move this logic to being from a library again. 
> I think the addr2line processing attempted is valiant but ultimately 
> using a library will be best" (this was when LLVM addr2line support 
> was already present),
> 
> Obviously the test patch mentioned in the above bug doesn't address 
> the underlying performance issue, only better classifying a timeout 
> error.
> 
> We have a customer bug complaining about the performance of addr2line.
> I'm seeing cases where it's taking over 20 seconds wall clock to 
> resolve certain addresses which obviously causes the io_timer to trip 
> but the performance of the success path isn't great either.
> 
> Obviously BFD isn't an option and (for various reasons) we can't use 
> LLVM for this specific distro so I'm looking at the performance
> of addr2line.
> 
> Can someone point me to the prior "using a library" discussion 
> referenced in the above bug or whatever the current thinking is.  I 
> couldn't find anything searching the archive.

I think we can just use libdw.  I tried it in the past but never
finished. :(

Thanks,
Namhyung

