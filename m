Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56EC356773
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Aug 2026 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787744963; cv=none; b=E9lR2TzBtVfw71Z7YvDVNiP/QCLWDqN5JH0k5PnXMh2ssqsbypX/5K+7r98h19KHW+xFxqIg8g7DKYQJvcINVhOEPM4VHXorXCGcJwiPn8juWGUKtWr+Z2f+sXfI6UrN5uVYxzFvC64CJvbQ0EKXeGA48uRGwhFW6ALsNgHKYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787744963; c=relaxed/simple;
	bh=uonRQN4Qcu+xYpyvDmFEPiFQRec78FsMxPf6dIYkQy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbtASjq/wwDTieWOhX9tH7e62Hd6NS0aftARs7PPvWXffBRpEJLfI8DsnxTAAtIHk3hWAYJhyhACE6MyGVnZ1IZSdSb86Lsahvp+QgmkGzxMKxcTfW/5tfzUy+jBAAwptJmVZ0RMjDP7t9KaBQQqqpS16OjCXlpqNiDTj1hjE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IzewdEbt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IzewdEbt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787744960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uonRQN4Qcu+xYpyvDmFEPiFQRec78FsMxPf6dIYkQy4=;
	b=IzewdEbtJfN/6CRqoHaVC4KBgVS7a3He8yrl+lqg5sn5UzZd/ryN2QVIQEsusKM/ncvHht
	wCmXl9YY2X3/TU1opDuzF7KJABiW2uuXcV1LxKSooyX0hqvA0OjBMeeeXI5roXCNERM8ej
	mFGZ23B7P5JodD+7bB4971WzsPEVaZA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-vU9OaW84M92ZmoUDsCvIiw-1; Wed,
 26 Aug 2026 07:49:10 -0400
X-MC-Unique: vU9OaW84M92ZmoUDsCvIiw-1
X-Mimecast-MFC-AGG-ID: vU9OaW84M92ZmoUDsCvIiw_1787744949
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F27F0195423B;
	Wed, 26 Aug 2026 11:49:08 +0000 (UTC)
Received: from fedora (unknown [10.44.48.90])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BA4B219560AB;
	Wed, 26 Aug 2026 11:49:04 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Aug 2026 13:49:08 +0200 (CEST)
Date: Wed, 26 Aug 2026 13:49:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Keke Ming <ming.jvle@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>
Subject: Re: SIGILL and uretprobes, WAS: [PATCH] uprobes: Free utask on
 dup_return_instance() failure
Message-ID: <ao7Sr0zqFoiKgaRM@redhat.com>
References: <20260822054620.452262-1-ming.jvle@gmail.com>
 <aosT4H14zcowzU_7@redhat.com>
 <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com>
 <aotM6tRUHI9Bo7gW@redhat.com>
 <CABbwK50istUW_xnFsjCA+MMgFCuBbY-Zs3QmJU=Fg7heqKdF6A@mail.gmail.com>
 <aoxp3Rcbp3fUuqS8@redhat.com>
 <CAEf4BzbUQWAB0JuEdXu32v4S_zMuv4de+kYv0mcY4tDPu8CA2Q@mail.gmail.com>
 <ao2KDQuBMNtONu0K@redhat.com>
 <CAEf4Bza0Hy_a4BpFBrsP2F5wvEDOyL6n2jK5FK8r-QyRFwvBPw@mail.gmail.com>
 <CAEf4BzZGQ50=B4S2NBZnqWN29YBgthMX8LsYGLq5rOsdGzpS3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZGQ50=B4S2NBZnqWN29YBgthMX8LsYGLq5rOsdGzpS3w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/25, Andrii Nakryiko wrote:
>
> On Tue, Aug 25, 2026 at 9:38 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Aug 25, 2026 at 5:27 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > On 08/24, Andrii Nakryiko wrote:
> > > >
> > > > On Mon, Aug 24, 2026 at 8:57 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > >
> > > > > force_exit_sig(SIGILL) can't be ignored too. But I am fine either way.
> > > >
> > > > Current SIGILL sending is already pretty bad behavior that bites us
> > > > periodically, instead of doubling down on killing the user space
> > > > process because something about installing uprobe goes wrong, let's
> > > > think about a bit less destructive way to do this. Mark uprobe for a
> > > > particular process as defunct or "detaching it", or something along
> > > > those lines. But not just kill innocent processes.
> > >
> > > Well. Yes, SIGILL sending acts as BUG_ON(), this is not nice and
> >
> > The problem is that this is actually not a bug but a very real and
> > expected behavior with user-space using fibers or coroutines. Any
> > suggestions how we can make this less violent, as it's actually quite
> > dangerous and kills production applications when someone (unknowingly)
> > tries to uretprobe trace them...
> >
>
> IIUC, this SIGILL and coroutines/fibers issue is due to
> uprobe_handle_trampoline not finding utrask->return_instances, because
> a bit earlier we threw out pending uretprobes due to
> arch_uretprobe_is_alive() returned false due to that `regs->sp <=
> ret->stack` check (for x86-64).

Well, unless I am totally confused this is another thing...

Yes, arch_uretprobe_is_alive() sucks, it assumes the single stack.

And I do not know how to fix this problem... uprobe_handle_trampoline()
must fix regs->ip correctly somehow, otherwise it is pointless to contunue.

Note also that the current instruction_pointer_set(ri->orig_ret_vaddr)
can be wrong if the probed task switches its stack.

And we have the same problems with sigaltstack().

ATM, I don't see any solution, and I don't really understand what do
you propose...

Oleg.

