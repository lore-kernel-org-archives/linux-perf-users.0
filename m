Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD862EBB93
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184265; cv=none; b=g2naIAvATllFE9W6zUUuMV1+XMymi6oYTGxS3G1papNCBtt01S3ii8DnBtE5po5mflLdcAgLJFTbdrzOMj3bHT6ez9CF3lC/Se3+s6CwVQ2eITdbea3PF3C8L5jl7Aal61agbWRtY/sPYTVgb03X714TQWS63/CVX9eYCJYgg4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184265; c=relaxed/simple;
	bh=8p/LefYsf5LgKM56T3JnfTxTjsJKg8jOC1zOeBv1a9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnIklQifmZ2ddJKVUzM7hroOwk80KLjl98qvEimuU2Jsy4h0EKCCBkfoh4HL49bmgVd59GbjSJpgpR+m/A7vF+Bc5JHrbRkJ3neepk/gc6la02aJ8C4a5fRXysmRijIuKzkHTPUCSS2amRK3veMeNdgmb4Yvreuoz2n1LFhCzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gazYrxKi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gazYrxKi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8p/LefYsf5LgKM56T3JnfTxTjsJKg8jOC1zOeBv1a9A=; b=gazYrxKis2r8QYPDEe2SsvBgfB
	TT1QuBFzqvkbaEvWewf0wcrbMrsz4ESPwpnqaioo13FPeMWobWDhFmvtXddV8Lo/iM20JKKDwJFdO
	APAD90h/EnfFw/4zFFR3j4yQMW8wMOH8wzsTiMH0HCcH1rSThK7NC0m7jV+bz+X8oW608rcbOvXlz
	inbp4kbSjNGa45MEojs++vPndwvGrqdwPuF9nw6gDTKxazJLhFoq4PzqsisnpXaH27xyXSFBGOBGW
	4VC+j2brOMs5eevtY7x1TkBRWpQlPOAulfuTSA96IUWxxS2BJyddpundbUrLcKF8rHNj7kYN4/qop
	0SyjXYbg==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRasN-0000000HU66-2usO;
	Tue, 17 Jun 2025 18:17:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F0A630BDAD; Tue, 17 Jun 2025 20:17:38 +0200 (CEST)
Date: Tue, 17 Jun 2025 20:17:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: perf_event: avoiding gpf on rdpmc for top-down-events on hybrid
Message-ID: <20250617181738.GD1613376@noisy.programming.kicks-ass.net>
References: <b0b0ae91-785e-64f6-348a-ca6edd448b74@maine.edu>
 <CAP-5=fVivxz-TPVap6-+6U=ueU9W9fdZSH3w5F7e-h=uN--8kA@mail.gmail.com>
 <CAP-5=fVa14Y+0a=nrxo85uEOHfiEJRbQXt6fOV7E3dQJDf4fdQ@mail.gmail.com>
 <2c759cfb-41b2-6f50-e893-1545a965d106@maine.edu>
 <CAP-5=fXHgzhp6=xrVi1GK6gO_dtVAAStK__eKKoaAvvge4oNow@mail.gmail.com>
 <CAP-5=fWYfMe8y-xcZkkEnppA11+H0r33Xnn0Mn2d4_y3dortmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWYfMe8y-xcZkkEnppA11+H0r33Xnn0Mn2d4_y3dortmQ@mail.gmail.com>

On Tue, Jun 17, 2025 at 09:37:39AM -0700, Ian Rogers wrote:

> To answer my own question, the sequence number will vary after the
> counter is read and so the read loop will be retried with a different
> index value loaded on the next loop. Perhaps this is the right fix for
> hybrid, if you have a hybrid system a per-thread event with
> cap_user_rdpmc and the thread is rescheduled (say p-core to e-core),
> then the sequence number needs changing in the user page mmap. This
> will trigger a second loop where when the index is loaded it will be 0
> for disabled.

It does; migrating the counter will change the sequence number. But this
is not sufficient, because meanwhile you will have executed the RDPMC --
which comes before double-checking the sequence number.

Issuing the RDPMC on a wrong index will cause fail.

RSEQ is more strict, it will abort and redirect the instruction stream
on preemption/migration and ensure the RDPMC instruction will not be
issued.
