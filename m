Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD861DFE09
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Nov 2025 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762226174; cv=none; b=RgRutd05o70q5Dc9ami8sp7hYPfGTKfcFX9z2mUgmUNMIzKoL2J43UXGjB9LIO4SaH9+55di0cdrPsNAXKNIB5jqd87E2/DoPr/WzckpPQZUfjh6l3uVJxcgs0ep+cRs36GaD3ucH1yVRcycDQKDhjugRYY1KgDLjQLyJ7bnB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762226174; c=relaxed/simple;
	bh=1KvNWXi9ovhPtuBh9zdbOqhZ1Sj/rdavzAafvDg/nmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqBSR5rXPbShHqPdbG/S/1Ch9zU7Qj/ODnwQKzgVuFzl48Lpkjhq6Q4DxUg86uOQlgaEl5N3vVO6ULMDvTZMBDApAG5JyNVKxbbpN7jH7dHZxiWJGDrCWCVr9sc1oXVGOKo0yx32q2ZcbM0QXrXSYgHJOx03cfWOjbtik3JebVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7J6UitE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7J6UitE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF648C4CEFD;
	Tue,  4 Nov 2025 03:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762226173;
	bh=1KvNWXi9ovhPtuBh9zdbOqhZ1Sj/rdavzAafvDg/nmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7J6UitEPUUcLDvVy2o8kLf9phcTWi8I7SjrwzMsCUdcUagxXDWW4w9b605T2btzo
	 ag4Km80oBqwXph4Qsx8ecLSZWR2qZbdz56efpD4VIHHfWJD2qINK7HZL7cFvvSPhyy
	 OAkZUPaISj2p4h4EHzG8jw99xH70UVpfLugQtDU3/lwOB/p2mPAfvsudZNRYnthntp
	 sY0o7rrzzyX5XXT330hCY4+YkMrhKHNyhK3uYUN0N2V42M+cebzvXWTMTyv/48p7NG
	 ehFjW38Y2wGS7/xGAaX4KNNOmRZQjvS/8rl4RkQXBXUWU5q4qBRlxBr4CHWvpHALwr
	 qW7kEdRABwvfQ==
Date: Mon, 3 Nov 2025 19:16:11 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Tony Jones <tonyj@suse.de>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com
Subject: Re: addr2line performance
Message-ID: <aQlv-w0axiiMrZVD@google.com>
References: <aPkivW2WoySU1Zkc@suse.de>
 <aQUQhHEmsk9Mm6Qx@google.com>
 <aQUe14AOt3Yc5Xv0@suse.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQUe14AOt3Yc5Xv0@suse.de>

Hello,

On Fri, Oct 31, 2025 at 01:40:55PM -0700, Tony Jones wrote:
> On Fri, Oct 31, 2025 at 12:39:48PM -0700, Namhyung Kim wrote:
> 
> > I think we can just use libdw.  I tried it in the past but never
> > finished. :(
> 
> This would be interesting.  
> 
> I asked our toolchain folks if they were aware of libraries 
> (other than libllvm and libbfd) that could replace the addr2line+pipe 
> (and were license compatible) but I've not heard back from them yet.
> 
> I'm happy to look into implementing this if you lack the time. LMK.

Sure, it'd be great if you can work on it.  I think it's basically
dwarf_lineaddr() followed by dwarf_linesrc() and dwarf_lineno() but
you also need to check inlined functions.

And probably you want to cache dbginfo of recent binaries to speed up
addr2line processing for the same DSOs.

Thanks,
Namhyung

