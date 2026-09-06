Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA145450F2;
	Sun,  6 Sep 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709345; cv=none; b=J+6b99b1JKG5Z1ScCjigMjxrkSPE5khIE6OZb7PbKewVGbzm0vA7BEaRE5FVkqIV2b/USBYO3IotmHx77zrZjl/ks7kfRy1+puf5Hq7rxLE2V4HeWxp6lBvDX2a0+rjJXFmBO5GWdskngRcSR20Nfc8nEK0aTaL5FnruF4ZMjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709345; c=relaxed/simple;
	bh=11nwYOqjS7WVavYxrg7Ld+NiROnkUQGKhy7RW/7i2FA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=q7t5eMp69KK49Vm6GHYtMWR1+O+2q29Dsp1dTu5WN9IuvssAXDh9YMHGQ0FTeyFW3iUZszNPc/5mMagfKX+rJPkG/fWHLQCNKaNps/bmwKFhFIqs5Fjc9Yekoa9XIabbu2MPagYufPlsXzEWrLjnzs3eaRIjEn4xiRtUt4yHbVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgnZSgWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgnZSgWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED031F00A3A;
	Sun,  6 Sep 2026 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788709344;
	bh=HqFbEB3BcoZW6oNfC9aLw0EaGak7+Jw0+tBf/ANKn+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TgnZSgWq7V0snDWIfbeYFOHyLLmBVH8ywgWAymCaAJREDIZvTU7kOy1yhRXRMmxOv
	 r/dsuEz/ONQzteOn7VgAVAF3d74N6fhrmgc7iUSaXmUTB0y05fcXh2cyr7z4cgtDRo
	 qARSZuggRt3/Lo5/grVFFXyIak4hMjyVfNigvTZmOUHlSvfxQoIYKm2K2if16fnv9H
	 hGlnVgqbuUVXg9JttijE06k+ze2YV5PKZw1pkO1Sc5jceXZ0zgArHtt/zx3dobqXxL
	 00X6Y8yjH0a0dgrJdg+4DfZPa6h4S/bxx9SdvXdfFWP1Ma3te+J9ELOAbMJsPsZETf
	 0j50sWEoCEIoA==
Date: Mon, 7 Sep 2026 00:42:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v14 05/14] x86/hw_breakpoints: Add
 arch_modify_local_hw_breakpoint_addr() API
Message-Id: <20260907004221.6977b7132e65a04002c21d8c@kernel.org>
In-Reply-To: <20260830143849.070271F000E9@smtp.kernel.org>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
	<178810006604.64882.2095793023976981357.stgit@devnote2>
	<20260830143849.070271F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2026 14:38:48 +0000
sashiko-bot@kernel.org wrote:

> > +int arch_modify_local_hw_breakpoint_addr(struct perf_event *bp,
> > +					 unsigned long addr)
> > +{
> 
> [ ... ]
> 
> > +	do {
> > +		seq = this_cpu_inc_return(cpu_dr7_seq);
> > +		this_cpu_write(cpu_debugreg[i], addr);
> > +		barrier();
> > +		set_debugreg(addr, i);
> 
> [Severity: High]
> Does this code risk violating the x86 hardware architecture specification?
> 
> Looking at arch_modify_local_hw_breakpoint_addr() in
> arch/x86/kernel/hw_breakpoint.c, set_debugreg() directly updates the debug
> address register (DR0-DR3) while its corresponding enable bit in DR7 might
> still be set.
> 
> According to hardware specs, modifying a debug address register without first
> disabling the breakpoint in DR7 can lead to spurious debug exceptions or
> unpredictable processor behavior if an NMI occurs or if execution boundaries
> trigger a match on the transient state.
> 
> Should the DR7 enable bit be cleared before updating the debug register?

For the wprobe, the handler will check the spurious exception, but it is
better to make it safer.

I will update arch_modify_local_hw_breakpoint_addr() to temporarily clear the
slot's enable bit in DR7 before writing the new address, and re-enable it
afterward within the cpu_dr7_seq loop.

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
