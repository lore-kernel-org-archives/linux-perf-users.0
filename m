Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A936B90D
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587052; cv=none; b=IZydBGP8v3HwDj8PdNDHn0qtKUUvtF8DII0ld5Jjm1zZ2P9bmGw2+pyQj565VVdSsRMzDtaYWdfbuh+lx7W4KvMq/qY4C9nZazBLRkFB4+SxTGuMKRbU6ow2WcTnqkEWv4qh7yt9Q8fL90u3D+C2vGZZb2grho49wj+Ne+Ha5LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587052; c=relaxed/simple;
	bh=WLDiteWIqF3m1z44XJzECGsDTBGJPPLigkS/d7vyfyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaPivrzrqPSpfK59uuz6EmkFzF2xAJJpLc58GKySjOzMl+w+cfRL2/BR5D2CpEuEYlGrXlZGwEPLIMmwGzghRNVpCrr8ZWtXFeedBSOVlHPvCPj08lkktD06o8I/oZsGALPA2GhDDh3g9lM24o0yAnnqExupQ+NHQ5Wk0THj/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXbid/uy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXbid/uy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787587049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lt6JfU9N3TKmHx8nvPAdDqg71QI5DDY6kggznOpUqRc=;
	b=fXbid/uyd4y1jUk49ftnHcSSJkuvKfuF755ZbuHTOZFvzGc06bTxfcnBc6wKCaQS4c487R
	pPf2dkXuFEwVKPSY8rkVqJZeFANgYZrCPxn/at+dLy43kA5xDsF24BOjOPyCtCGzVwPH0b
	YQRPFlGsAXPQ4YzwvqV+O1HFaeixg6Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-Wb4jBxTKMfqBc15vuBl-vA-1; Mon,
 24 Aug 2026 11:57:25 -0400
X-MC-Unique: Wb4jBxTKMfqBc15vuBl-vA-1
X-Mimecast-MFC-AGG-ID: Wb4jBxTKMfqBc15vuBl-vA_1787587042
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E2D71977535;
	Mon, 24 Aug 2026 15:57:22 +0000 (UTC)
Received: from fedora (unknown [10.44.32.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3D9CB18005B4;
	Mon, 24 Aug 2026 15:57:18 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 24 Aug 2026 17:57:22 +0200 (CEST)
Date: Mon, 24 Aug 2026 17:57:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Keke Ming <ming.jvle@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
Message-ID: <aoxp3Rcbp3fUuqS8@redhat.com>
References: <20260822054620.452262-1-ming.jvle@gmail.com>
 <aosT4H14zcowzU_7@redhat.com>
 <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com>
 <aotM6tRUHI9Bo7gW@redhat.com>
 <CABbwK50istUW_xnFsjCA+MMgFCuBbY-Zs3QmJU=Fg7heqKdF6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABbwK50istUW_xnFsjCA+MMgFCuBbY-Zs3QmJU=Fg7heqKdF6A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/24, Keke Ming wrote:
>
> On 08/24, Oleg Nesterov wrote:
>
> > Hmm. It is not that I think "it is not enough", I think this is pointless
> > whatever we do.
>
> Well, I didn't mean to insist on the cleanup, I also think it may
> be redundant. If the child is bound to exit, manually calling
> uprobe_free_utask(t) in dup_utask() is pointless, as the normal
> exit path will handle it.

Yes, but the same is true if the child is not bound to exit... IOW,
I still can't understand your motivation for this patch...

> > But this is only the first step to cleanup
> > this logic. I'll try to write another email tomorrow.
>
> Of course, I'm all ears.

You have already mentioned "Option B" below ;) that is what I meant.

> Here is my current understanding. One thing I am not sure about
> is the signal semantics. If the copied uprobe state is incomplete,
> the child should not return to user mode with that state.

Perhaps... But consider

	func_which_can_be_ret_probed(void)
	{
		if (!fork) {
			printf("CHILD\n");
			exit(0);
		}
	}

> Option A:
...
> ...
> kill_child:
>   // I was thinking about SIGKILL here because it cannot be ignored
>   // Of course, you can correct me
>   send_sig(SIGKILL, t, 1);

force_exit_sig(SIGILL) can't be ignored too. But I am fine either way.

So yes, perhaps this makes sense. Although IMO this all is not that
important; GFP_KERNEL shouldn't fail "in practice" and at least
uprobe_copy_process() warns in this case...

> Option B:
>
> > Note that uprobe_copy_process() warns but returns "void", too late
> > to abort copy_process().
>
> Looking at copy_process(), uprobe_copy_process() is currently called
> after the "No more failure paths" point and after the child has already
> been made visible through the task list and pid links.
>
> Would the longer term fix be to move the uprobe state copy earlier,
> before the "No more failure paths" point, and then add the needed
> bad_fork cleanup for  p->utask?

Agreed, pronably better than Option A. But in therory dup_xol_work()
can still fail after fork().

Oleg.

