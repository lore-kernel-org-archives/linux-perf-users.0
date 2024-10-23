Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B111CCB21;
	Wed, 23 Oct 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729707590; cv=none; b=jNT0sSiIU2306HtHKMqMRnFMnelw7AmJWtIQnfWoPPvdiwj7BUivTMXrUcWorhq5h/nlTzgQUQsh/elz/WExWr2RSReLRYIn7WhSMoLDgSV+PQYWfNpcdB/Z1KFJQnzF8ml6RfwkMIGM9oNFp1AJWi4i7hs2QegOff+CBMdJPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729707590; c=relaxed/simple;
	bh=1P29n3KYpH6IJHLnBuonNMN3vn1rEN/zcyufPCnh8yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpL8N/sFwmY04D+YaaG0pAb1Czc6YKfMrD7xuFQ4jQijfy1zQ77rQr50k+mJE1icZLm7Ti6/s6FdtiWDQLL6zgIas6G7a5MLkB3JOTWKLLpeRCGSnNKbY55ibGLCQJFX3nu1HyLXk9S+ZFc4EZDtnvNp3pINa8/ETfuZQknegL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f/DnQTfC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f/DnQTfC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3RvvBC6Z9BN9H81Wpl2DzpTszPz0S3vLepyiAHjS1W4=; b=f/DnQTfCV2h6QohiXrCQnqKji/
	NEzTNttzpIUERxbvSpkFko+J6zhETZo/8IORKVfNB8WH9dGKrhpJBvGwpUyWpVuUAS8u6IoaLDFVE
	yt872EeXC3aqjZ3ds/cGwlCdDn8OhMABBkZ9LG9sJ1SKKk1RgQQOllQqll26J6XjzJ5CfqtH24Hrw
	oS7g235JJpOIm7VIzDZAn4rH7GL44tXGo1ZdGbZJiABsQshYOH4eHI9gR+admM/ifAotCfMJsm7wk
	CX0wRidz+270KJ28B62VNCfQnFqmC2RVvsFTU/nkpUK4nbtue9ruLlohttdkMgIdTu1uCt6mZuc5m
	W8mCTMkQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3fxQ-00000008WSf-1nJY;
	Wed, 23 Oct 2024 18:19:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8CA2B30073F; Wed, 23 Oct 2024 20:19:43 +0200 (CEST)
Date: Wed, 23 Oct 2024 20:19:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, linux-kernel@vger.kernel.org,
	irogers@google.com, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/7] perf: Generic hotplug support for a PMU with a scope
Message-ID: <20241023181943.GC9767@noisy.programming.kicks-ass.net>
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <20240802151643.1691631-2-kan.liang@linux.intel.com>
 <f856d105-5463-4b8b-8715-0e6871165616@kernel.org>
 <eb552133-829d-4935-87e9-101e052fd40c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb552133-829d-4935-87e9-101e052fd40c@linux.intel.com>

On Wed, Oct 23, 2024 at 01:46:43PM -0400, Liang, Kan wrote:
> Yes, it's good enough. A patch has been proposed, but haven't been
> merged yet.
> 
> https://lore.kernel.org/lkml/20240913162340.2142976-1-kan.liang@linux.intel.com/

Got it now.
