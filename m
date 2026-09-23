Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0707471CE7;
	Wed, 23 Sep 2026 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153515; cv=none; b=UeDtlubT216cLcboxGuHVay5WRhH+vc+k/IorgYvL9HEPFPJYwKHFS9BZxRY1y3omfE/UpMqZjo/5614yYZtSmxn9e1goZ5fZL7tWSR30Ep5msU51WpkXodjDT58gXRb6XhUHCsSYDSB9imXtGrS+LDaXD/ebO8KR8jL8qOv2G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153515; c=relaxed/simple;
	bh=e8BHkedST5IvMG8ydmkWCUz5sx/Tld0fVuGig1pKfak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQ1OsPZO5q4GBs6xPqAZy8rjcdwLmDNEKdfkHsjlifFV0X3jMS04j19muT8ht484C/Wa3W1D4vbbzhY5Esqxe//nmxXSKp64ZGZEDn64WeDX5rJbClA408yXQJhqiq5xPSOp2e5cZVCO6uQn11o1au/uQHASNe0YCrQefJnJ/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qQ68kLs4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qQ68kLs4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zhc+rBydMoTCVYj/UX3EYHmmMl8lLx0CKlWHb9p0Occ=; b=qQ68kLs4+03ouBN6dYWL0IKdKr
	CE4g2/QKcVLDtevwYbe9FLJGfOeW7VS0wIXCU7bdiowtMHW2Nma9Lr1DpIJuTITY/EzZhjFvEgSzI
	IX9ssJOaHTLxfDSRWyuWL1IRvxH1EwAjM9FXLE4xZRTgX7HwgeYGRZmwURbO6880f6kftSZEZBvJh
	4PDZfjfsLAGZn5qr2pWwmRL/5HF1/v2bTxDEjn/D28F9zk6a4PWTmfm2pgU4mWoT7MtKVRQuAk3Vs
	uzG8sqXn/EVyoTxSh29UIn+8PICGLE0wmNCx3jLBRC5c98WXJhIZGQuf6XLrdCeYouBcHltqofCbF
	z/CrInLg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9IhY-0000000EXz8-0dbJ;
	Wed, 23 Sep 2026 08:51:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2A086300478; Wed, 23 Sep 2026 10:51:39 +0200 (CEST)
Date: Wed, 23 Sep 2026 10:51:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v17 02/13] perf/x86, KVM: Prevent host debug register
 leak into guest OS on NMI
Message-ID: <20260923085139.GV776954@noisy.programming.kicks-ass.net>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005110742.388919.1509641807739909065.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179005110742.388919.1509641807739909065.stgit@devnote2>

On Tue, Sep 22, 2026 at 01:25:07PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> When KVM enters a guest OS, host hardware breakpoints are disabled
> before running the guest. However, an NMI can occur while executing
> in guest mode or during guest transition, where
> arch_install_hw_breakpoint() can be invoked from NMI context.

How? AFAICT perf doesn't do that. arch_install_hw_breakpoint() is called
through pmu::add() which is strictly IPI context.


