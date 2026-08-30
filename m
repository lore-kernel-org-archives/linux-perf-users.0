Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20543F104C;
	Sun, 30 Aug 2026 05:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788068125; cv=none; b=JlZyRqpCwYNxg01j01PyvACJB8HuEuQPuw0nPUuT8kQEexg29rjsy/aElCcY7jk7hoRuqgXVqKi6hoICAlJ8skoCH7XgJ6jSqyAMG2FxlU5IKpR2TLmZujHHaKdGUfPx1gVrqEYkT2ZRFvHHJCQBehATayljn9sf7NzwUvENRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788068125; c=relaxed/simple;
	bh=u5OoWiBiyp8XxgqeNSzC12P2Z/c+MBHL2wUQUZWubAU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Zwhw7+W018PR1DF94OgWQEk8fBEGrfvnsP7ILRTdLTZ9Tv3wjCgoUJkBXtcVsU9HiCZwclxFYkZOhgNqPxGHAHBlvaSNC/K4eUi2zHS/7wzJo+u54f6XcAyrbXOE/9A5HAQKDWmR0T3md3O8CraNFGVJOhAk+lsOo5giW5nwRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZB2YYfa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZB2YYfa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4354B1F000E9;
	Sun, 30 Aug 2026 05:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788068124;
	bh=mK56DxcoBkHFc3H2ezI1X6JgqML3AZmY7yhEbIcRO58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AZB2YYfatTjPoQyN0ac+X4SWEZTY8XM5Dvqty+6+Vgj9zf7a+ruvqCqBfH149UP29
	 l8iCg/iN7pva6rXaxAQfvkyJuqUb/hde6DC0oY/X5o8mYzzOBil7QUvh/DgzFOsnMk
	 H7nsqZVGQODwuG8l2HiWPU6kstBfiiZrP44LaidKVfOOsy8TpSYyEWWV8KTe2l54RD
	 KB8rBVtDa8uDyleQVIIFfBKMmRe/v/Gy6nQnMpfTpCc6JRit6ru1XSeI73JaXoOw0N
	 oi55oN8E/dM8yPSlCQe/Fh6k9VLDz06X6rEyjXBY2P+8PoE2aIzmzQ6Vun9d4N3/oc
	 rIKyovBYn6xBQ==
Date: Sun, 30 Aug 2026 14:35:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v13 05/12] tracing/wprobe: Add wprobe (watchpoint probe)
 trace event support
Message-Id: <20260830143521.f1b696cb7066d6a5d84c540b@kernel.org>
In-Reply-To: <20260822094914.09C281F000E9@smtp.kernel.org>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
	<178739064718.1520941.13864925402314213363.stgit@devnote2>
	<20260822094914.09C281F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 09:49:13 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The trace_wprobe_show function uses %pS to format the symbol address, breaking dynamic event restoration because kstrtoint() in parse_address_spec cannot parse the appended symbol size.

Oops, it is my fault. Let me fix it.

> - [Medium] Address validation in parse_address_spec incorrectly exempts address 0 from the kernel space TASK_SIZE check, allowing user-space tracing at address 0.

Ah, address 0 will hit in the userspace. OK, that should be fixed.

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
