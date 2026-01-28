Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7A33E35C;
	Wed, 28 Jan 2026 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591445; cv=none; b=i8WXUBqEoDqNbE7MNBw3t6YdZhAPsB9PoZeQZLz1oGHmcLeqJAV1SdmF15QaQ0IYXR9oFkBv6srRdTKT1diSFiBPxyIg30ximbp+VWxWu7OLgOQLPdibU2SM7p4dkpfjM8wmnBTWWz5tl9E1FG1NSEXCUjMxmr8VBTXxDvPsV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591445; c=relaxed/simple;
	bh=3g4Ns0zq66zZ0eyPk8o6AsaAZ98JylMVWxRW2Njb0+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaNS94OEsv3YjxzJTvqdHxCbonW/0bkUpkYnfwpPLSbjX6TeI37KztLiRqtFob/2fLYRzMY27i8N8vXZMZvA3CREhHFFMle5hcYb2dXVtAYaaPcs01UB5IF4P+YwYRQ1vNKN9F83NWfuo32eNhx99wLHVg2Gox//TyE+Cb9OumY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jkqr9VZq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jkqr9VZq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BN1OpClR9nd49gx7hLH2TJc2jF9HNpfhLbHP6r8m1yM=; b=Jkqr9VZqJATO10VaGZUcJFsBjt
	bclGlUNFd5m2u9J1CgAdnBRIq+E0oban+MjAGu5vemad5CJ8dYe6ktFqRm9/Jtbj8ofLtSd8E2Ki/
	koY0CzYqckHwBSNTK5eSqm/My99ICzo+2fRM7fFiovaeaypshNl5PykOfugmeUVkwSPnX1N8mdGBs
	3ZTf0cbLTSS2qkSSXnBcF3uM1GPBec9MaKBp1CwQte1DzyR2K5/lZfNGqBnA7+s05RXW0WdkkL72W
	+3eOAGj1d4LFwBeH8wT/mzv1dLZsTGl35YQIfSEqwzb2EtZam1nKYAlQr3gXy7O0kCzNdEaTKFgJk
	LMFippqw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl1ZJ-00000008Cts-2dj1;
	Wed, 28 Jan 2026 09:10:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 152C6300754; Wed, 28 Jan 2026 10:10:33 +0100 (CET)
Date: Wed, 28 Jan 2026 10:10:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tao Chen <chen.dylane@linux.dev>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
Message-ID: <20260128091033.GG3372621@noisy.programming.kicks-ass.net>
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-3-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126074331.815684-3-chen.dylane@linux.dev>

On Mon, Jan 26, 2026 at 03:43:30PM +0800, Tao Chen wrote:
> From BPF stack map, we want to ensure that the callchain buffer
> will not be overwritten by other preemptive tasks and we also aim
> to reduce the preempt disable interval, Based on the suggestions from Peter
> and Andrrii, export new API __get_perf_callchain and the usage scenarios
> are as follows from BPF side:
> 
> preempt_disable()
> entry = get_callchain_entry()
> preempt_enable()
> __get_perf_callchain(entry)
> put_callchain_entry(entry)

That makes no sense, this means any other task on that CPU is getting
screwed over.

Why are you worried about the preempt_disable() here? If this were an
interrupt context we'd still do that unwind -- but then with IRQs
disabled.
