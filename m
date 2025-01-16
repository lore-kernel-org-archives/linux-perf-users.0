Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF114901B;
	Thu, 16 Jan 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064116; cv=none; b=O1OfQspyXEsnXnJoTLEvOSyvfUDfZLq6LiGwVQdmhQ2S/49kMjYAcz2J1jGJQAYgNOcHD/YyU10qb1njaYIzUcQrrcb/UirwP8cfoHxcLUaF3Kgce7p1/njckSx3iQiNmQPqRJILIRJyDcgHjvwdGo26+J9CiC0c60kel9N67L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064116; c=relaxed/simple;
	bh=6uDVeXmwWQa6+BNUeOIe0+JVY/iRLewv8xswwsSTk/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbBYMyAowPQFJwtdW3fMsyFlPMT6rVsEqXYvG0O4daSuGrFWHZ2tazJ+NV07PKo9wyMdZ3gg36u2DoaBdn+zD3qSeyPqaAczhuRi5DJFTdCDB3xl6FBxN1gi/cDksP8Bdrb5dWjJIXlOTynYdnDf+edALdbXd/VDRev3c2NkrPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E49C4CED6;
	Thu, 16 Jan 2025 21:48:34 +0000 (UTC)
Date: Thu, 16 Jan 2025 16:48:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michael Petlan
 <mpetlan@redhat.com>, Veronika  Molnarova <vmolnaro@redhat.com>, Suren
 Baghdasaryan <surenb@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/2] tracing: gfp: Fix regression of printing GFP
 flags in user space tracing tooling
Message-ID: <20250116164840.5f278bbc@gandalf.local.home>
In-Reply-To: <20250116214123.917928229@goodmis.org>
References: <20250116214123.917928229@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 16:41:23 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> This fixes a regression that was brought up last year[1], but due
> to missing a response it was forgotten about.

Note, these were only tested by building and booting the kernel to see if
the gfp_flags have been fixed. I did not run this through my normal tests.

I can run them, and if I get an Ack from the memory maintainers I could
push them through my tree.

I would also like to have those that reported the issue confirm this fixes
the problem for them and they give me a "Tested-by".

-- Steve
