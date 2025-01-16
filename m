Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A1B81727;
	Thu, 16 Jan 2025 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058348; cv=none; b=IZzrrp7T54i/kOrB1QX7u78nbqCmdh7CGRyJrSFhIo8FCixL9lepAW4K/fj2aTaBoQHuxI7AEqpnUNP/GdjcZeVDsslrMjGpgbNTGwKVJkPrhq3SJExyJVYN/2nubb77Quo4oKLIbyavIKwXdHjDgGgMwanFEpkWn4G/YFN6YF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058348; c=relaxed/simple;
	bh=hDV5TMm0QqYt7tln1MTJDElQj2k0ZtjBytq6skR4l8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCuo1GiXBsGr5u+cTOQI+zej2YzXeoY6JZjh+TcWatSW2kB3j7ivGYDSFHkNOS8dn+i22JBi9LehGLaFge1HbvmZLoaG+7R6f77NPBMeltIKczwOH/H8o/Udza4xjhCGkw4Jo8rq7yNSnDhd+ILEJ1IKZWAPSZ08dgK44BzilsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53A8C4CED6;
	Thu, 16 Jan 2025 20:12:26 +0000 (UTC)
Date: Thu, 16 Jan 2025 15:12:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Michael Petlan <mpetlan@redhat.com>, Veronika
 Molnarova <vmolnaro@redhat.com>, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] tracing: gfp: Fix the GFP enum values shown for user
 space tracing tools
Message-ID: <20250116151232.4cc70a51@gandalf.local.home>
In-Reply-To: <CAHk-=wjHUvCTurVZosKsJhPmBJBYXeN=pNCE2nnV9EWp9P5JmQ@mail.gmail.com>
References: <20250116132359.1f20cdec@gandalf.local.home>
	<CAHk-=wiFEeyY5HE3NMvDYd254yHynzaQyzwYhv5gzRj7KU+gjA@mail.gmail.com>
	<20250116141800.31d519eb@gandalf.local.home>
	<CAHk-=wg_2zXOKH2kDAnAyvC6MDWWgyuMRqQDNTGzKJBhfVzHVQ@mail.gmail.com>
	<20250116143018.0b156e42@gandalf.local.home>
	<CAHk-=wjHUvCTurVZosKsJhPmBJBYXeN=pNCE2nnV9EWp9P5JmQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 11:30:52 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 16 Jan 2025 at 11:30, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Would it at least be OK to add a comment there to update the tracing code
> > if a new GFP flag is added?  
> 
> Sure.

Heh, there's already a comment, and I can make the changes there:


/*
 * In case of changes, please don't forget to update
 * include/trace/events/mmflags.h and tools/perf/builtin-kmem.c
 */

enum {
	___GFP_DMA_BIT,
	___GFP_HIGHMEM_BIT,
[..]

-- Steve
