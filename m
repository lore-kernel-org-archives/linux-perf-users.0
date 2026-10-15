Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B3151C065;
	Thu, 15 Oct 2026 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070514; cv=none; b=b88xlaNFRPC7gxk/bNDRZvXBdUzmw6OtNghfVVDl1raLqlcbq3FZO+phMsSf4wc4bhd/no9w1KlzO3Dm9Uorp2gvzoRORvuDmty35p2P94PPPec57gCCGsy7OLyepDcYghAzHuw3jDHDfKDQRjQBeoH5x+lJNqRUdPzd5nDm0nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070514; c=relaxed/simple;
	bh=dALrA1GsxC8vVl/exTNWFqaXq/yilSUKsozs8vOLg3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJcKTiAOsY1VBtRL/We5xRpB9zBvJkikKwScMhKGWDdiuNhNjHwR33BkfsRiMLgayNsoj35Ol1KXy/Y7/ZJKzBXxGyPG1CGeMQX/kPM1w0SHKU4IIGhxmj5w+6c+C2H5WT13uIq2IqMbZ6D66PIRqeCRMCt5DsGNO58u4Asn7XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FVJFClR4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FVJFClR4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7R2sAHVr7w2P/QFifakXkPy66wmmGya42yXgvY9Uwls=; b=FVJFClR4MU50janZbmfmYTG/5E
	sUSrjE/yasd+pkUMEqZWr3W9/EH6TJ/vBjTI7P2UW2NpAfYdoWoYrKzcjPktCbl6GT4GFXmjvNjCN
	77naiTCGwBBsFu5qhKReUBcm4g1Ht50WzS63pzON1jRDGBqOxChJjfYmHSiV60j0k/k684s3cQCNQ
	szzdL3x1Owvf2I0TPYftZ/eGbVVC8FNlIs4sHI8rFbHZkXRp/DF3sCGrxlB0/wegZJgnhB9E7BfCn
	pjDDpvGVnTlaBWSICdurtDttiVcGLerQLXdDJuX1YeEATVJkih3r0aRW4QTRDmyg1D+YJ2S/6TOPE
	K/2VJhoA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHLOr-00000000PSr-2AaB;
	Thu, 15 Oct 2026 13:21:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F2ABB3003DE; Thu, 15 Oct 2026 15:21:35 +0200 (CEST)
Date: Thu, 15 Oct 2026 15:21:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Antoine HURET <antoine.huret@bull.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] perf: Rewrite core context handling breaks
 multiplexed cgroup events
Message-ID: <20261015132135.GK4121339@noisy.programming.kicks-ass.net>
References: <PR3PR07MB69223331EED5BEBE150375B7849C2@PR3PR07MB6922.eurprd07.prod.outlook.com>
 <20261015111316.GJ4121339@noisy.programming.kicks-ass.net>
 <PR3PR07MB692235BC98DAB96E30E4AB8D849C2@PR3PR07MB6922.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR3PR07MB692235BC98DAB96E30E4AB8D849C2@PR3PR07MB6922.eurprd07.prod.outlook.com>

On Thu, Oct 15, 2026 at 12:30:55PM +0000, Antoine HURET wrote:
> On Thu, Oct 15, 2026 at 11:13 UTC, Peter Zijlstra wrote:
> > /me mutters something about having to go install and learn docker and
> > what's wrong with simple shells scripts that poke about in /cgroup
> > filesystems :-)
> 
> Fair enough, sorry about that! Next time I'll do plain cgroupfs,
> promised :-)

FWIW, it might be useful to extend perf-test with a bunch of cgroup
tests - this one included. AFAICT we have nothing there atm.

