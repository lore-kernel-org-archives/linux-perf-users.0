Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85A1D86F1
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Nov 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201369; cv=none; b=Y61nEuU4ylXyAfFgPuIoysAZlmA253bO4NRhArp+hOPGBrqEwzqsRRSNabZoiP4KOJeWDEBgurHHe6/ku6yEcgJekgrfgUQWD4TVuzRmL1MEB+PEMFb6qRNIqeXq2654UpUj72KGjnXJg8R1RARTWk3h8HnqfrFpRaie4ih9DV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201369; c=relaxed/simple;
	bh=db0BRnQapNQ5060EwGN2j3jaQC3RDALyn4g51+mBm48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlQEzqqYYgnPfilz57Kx/xuccW765iX/LFtIOeJkLD1S4eEqBbBm6ndqO9AfxtPtdhF4A6ZCHTJOfh5ysnGkL7xANIcu8Fw1f1xcm5e5eE0sFd8tjbKGANk87dL1Ggre7CdwLNqSyObZ05t8h+uVmCBh8AnZsQNECKqtFlGqBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB89C4CECC;
	Thu, 21 Nov 2024 15:02:48 +0000 (UTC)
Date: Thu, 21 Nov 2024 10:03:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: vmolnaro@redhat.com, linux-perf-users@vger.kernel.org
Subject: Re: perf kmem --page stat and gpf_flags translation
Message-ID: <20241121100326.645bd0d7@gandalf.local.home>
In-Reply-To: <87be5f7c-1a0-dad-daa0-54e342efaea7@redhat.com>
References: <87be5f7c-1a0-dad-daa0-54e342efaea7@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 14:54:25 +0100 (CET)
Michael Petlan <mpetlan@redhat.com> wrote:

> Hello Steve and others,
> 
> We have found out that perf kmem --page stat sometimes fails like the
> following:
> 
> # perf kmem --page stat
> 0x2aa28 [0x8]: failed to process type: 68 [Operation not permitted]
> error during process events: -1
> 
> This seem to happen on s390x KVM machines.
> 
> When we tried to investigate for the reasons, it seems that the problem
> is caused by incorrect/unexpected translation of gpf_flags for event
> kmem:mm_page_alloc.
> 
> # perf script
> perf   96553 [003] 100299.663963: kmem:mm_page_alloc: page=0x1a8f9 pfn=0x1a8f9 order=0 migratetype=0 gfp_flags=0x500cc2
> perf   96553 [003] 100299.663995: kmem:mm_page_alloc: page=0x1bc3f pfn=0x1bc3f order=0 migratetype=0 gfp_flags=0x40cc0
> perf   96553 [003] 100299.664001: kmem:mm_page_alloc: page=0x1a9d9 pfn=0x1a9d9 order=0 migratetype=0 gfp_flags=0x40cc0
> perf   96553 [003] 100299.664011: kmem:mm_page_alloc: page=0x1788b pfn=0x1788b order=0 migratetype=0 gfp_flags=0x40cc0
> perf   96553 [003] 100299.664023: kmem:mm_page_alloc: page=0x17993 pfn=0x17993 order=0 migratetype=0 gfp_flags=0xcc0
> 

Does the same thing happen with trace-cmd record?

 # trace-cmd record -e mm_page_alloc
[ run tests, hit Ctrl^C ]

 # trace-cmd report

?

If so, could you send the trace.dat file to me.

Thanks,

-- Steve
