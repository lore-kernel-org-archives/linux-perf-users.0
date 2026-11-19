Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096599;
	b=qCn9a2XyD70hjlWNPmr9rzxapBwjPzz1T7HrqmWsEDLuzyclYn7meD4Pp3MElz+G/hAW
	 GEndK2Wh7OfAFwRm62SEqdOAzPo2Ktczlh9BzYQ1J1D6rDfz/euNHSPfcG1FS9f8/Lt0X
	 rHLwNNziFKEckoBn7a3NGx4We7uf8X16CfryENdi/fzfK83KcO0bqGVgKFtqxJ/zXMrX7
	 D4lYzcyZNGoK0jRJwyDKiqSmWHjStnBBflpdDRTuGlx6urztx+XxDjIDG78/tFs731jXC
	 czz+TYjPCt3n1Snwd4112CCfG0UC712n3ogujGrAUBe9yYEBv3VsSI0+biltG/emk7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096599;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=p01AMJEsgxMawydqGiX5oGqRwQagNaltsLGSLmx0qnk=;
	b=sVnpi8e/zicooyA45cliYgjQesrBmnf0szp2V0GkmirZM+JzkF2RlzwJcNLr7Vqt/gKG
	 z9GMBRNvTws2mKDyFUMRryEEOpyXFy3kMyrWxAEs3gTyfPbCI4hqI0TsH5+bymngs3Q6H
	 VrkuMsaoGj4TDFDFQghz1G1g+2BVV92WA4OSE97h+8nxUn7D2+2h/6Kwn9NYK2iXqMbiE
	 whymyOqs6044Qi1GdpWPbh/o0wOOOGTcBJhDSjHf6K/FeXwfWf6Y+Ns++i+6otz4CfKA3
	 smamPtWetIUJOJUygQ9mxAwoCtlSqq9lt1KRsyGGuHe4A106nV1pXxVHPHVfh1pNYiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=yFKw5dWF;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953D606A326;
	Thu, 19 Nov 2026 13:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1953D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=yFKw5dWF
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 2969080AFB;
	Thu, 19 Nov 2026 13:56:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 3403B6000C;
	Thu, 19 Nov 2026 13:56:34 +0000 (UTC)
Date: Thu, 19 Nov 2026 08:56:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: JunYoung Lee <ljyoung04@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Require kallsyms permission for the .function
 filter modifier
Message-ID: <20261119085632.60cc7df3@gandalf.local.home>
In-Reply-To: <20261119025941.87102-1-ljyoung04@gmail.com>
References: <20261119025941.87102-1-ljyoung04@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 3403B6000C
X-Stat-Signature: q8fd4qnyrd5cyffidt1e5i3tdi88s7sp
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19aueHXQZARrHKFPI9VLfHoXusHGVYx6vM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=p01AMJEsgxMawydqGiX5oGqRwQagNaltsLGSLmx0qnk=; b=yFKw5dWFtRBxr2DVkodExwzF5jV7yxErNYj3s3Qa7JFTRK5lb3tAudPX8jYFe4KFsnqcJZnxtASF68nTk+ghX/FD03RBNMq19cPjxQEykbRvvN+WozjOfwCZ2cRJwdMT0HzA4UGm74pE0ptmbT3lTuGQCCXZ+Jp7cPr6pBBdMd8=
X-HE-Tag: 1795096594-802728
X-HE-Meta: U2FsdGVkX1/hWsnU9WHyInkMYlA2PoE5GYkMwY1JVwjEn7zdVsPZg2s0UYoK4WXkimiyonPIKWqB2k+7qrt2/VS5bl5z9tvr7lio64w7BRQgbZQjQiWp/j5XRf5CoRl8o1QZnZsGnYK9ctitJXIdqIzEbtkGxc9geK3iO5/gowWWuj37sesVgB277U0+x49L9g1vJb6f1s6vbpb5HHuU4Vtjp/MDYwFEsuCttredkBqNZgZrUQTN2NiRe/n4jheVK+jCK5GQf3l48qZCFDTFHKhMnuULL0lA/O4nB2EQDcfeHRWSnPKwvllP2KkTG0qWouG564nMQAO+ZSS7rXKaRdthMOZzHvvx

On Thu, 19 Nov 2026 11:59:41 +0900
JunYoung Lee <ljyoung04@gmail.com> wrote:

> Hi Steven, Masami,
> 
> An unprivileged user can locate the kernel image (KASLR bypass) with
> PERF_EVENT_IOC_SET_FILTER at the default perf_event_paranoid=2.
> parse_pred() accepts "<field>.function == <addr>" only if the address
> resolves in kallsyms, and the perf path has no permission check, so the
> ioctl result tells whether an address is kernel text. The details and
> the fix are in the patch below.
> 
> Affected (reproduced as uid 65534, KASLR on), since e6745a4da964 (v6.3):
> - mainline 4405c18c95d2 (v7.4-rc3-230)
> - stable 6.12.118
> 
> Example on mainline: a counting event on ftrace:print (field "ip") and
> 561 probes return image_start=0xffffffffa1000000 and
> image_end=0xffffffffaae30000. These equal _stext and _end in
> /proc/kallsyms as read by root; the same user sees zeros there. No
> tracefs and no capabilities are needed. Not affected:
> perf_event_paranoid > 2, or perf_event_open blocked.
> 
> A C reproducer is available privately on request.
> 
> Testing of the patch on mainline with KASAN: for an unprivileged user
> every .function form now fails with -EINVAL, and ordinary filters still
> work. Root keeps .function via perf and tracefs (it is refused under
> kptr_restrict=2, like kallsyms values). ftrace selftests test.d/filter
> pass 4/4. checkpatch --strict and W=1 are clean. A 6.12.y backport is
> available.
> 
> A separate issue seen while testing: as root, a .function filter on the
> perf function event (ftrace:function) crashes the kernel with a NULL
> dereference in ftrace_function_set_filter_pred(), because pred->regex
> is not set on the .function path. It needs CAP_PERFMON. I can send
> details if useful.
> 

The code in kernel/trace are all privileged commands. If perf is the one
allowing unprivileged users access to these commands then the checks need
to be done in the perf code. It's not up to the trace code to handle perf
permissions.

This fix should not touch any code in kernel/trace/*

So NAK on this approach.

-- Steve

