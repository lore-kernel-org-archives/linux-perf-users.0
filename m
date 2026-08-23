Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29982379EFF
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514104; cv=none; b=OrG18aCcs56Gu2vcC0wu4T8F6mMtXwElVwo8cFslu4yOQOEHiKnPuyjZyjKpbHL1YL9I6Ig7sDTQe6NRZVzfig9OYu/I7yJpeSGNSIX+Uzmo07fkfF0h6Pc46EI1myPOsYQQ2Je334unqN9Gqa7liQ/z+qHcmRhXrkqY/5GEOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514104; c=relaxed/simple;
	bh=sz0V2ZRk4ZCw1/+YsI06kjy62c2A7WZUFmknYSZ1RoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8tQEmq9Ei0lnqahx/iruDvwq68WUGBOUl9I+hQCabzgKqyA/EkHj/StxJvC1n1c7bJMlP3BO4QglUHEaqOLKz44BMOWVe6fy+/GDZzL8tNHit8UP8zXOHKtn5N5eibbg2DNZEaIOCqX6yf1YNo7xfoQ2FLDbrAbWQvecYFbOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VAHqiTb/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAHqiTb/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787514099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6jP9FYcrTlMrM2Opp8ZZKtUNy4FHbJ1LealZ0XwT6nI=;
	b=VAHqiTb/uhQrOOVBCncl1Ti0UEdYpbdJgGmWzyDgz3+zK3SNWCZ53hgaBttiYydz1Ns1wK
	ni9fHhYsRCYfFjvDLm/5pZ8L+T4bJMaALLTScdGhujrMvjJwIkQ4p2HwA4Px3gbom/BN5v
	BN0y8Y4cAO5EmoltSStUsG4Lg1ndfh8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-Y7EVpKeFMtayFHZ8eHTXTA-1; Sun,
 23 Aug 2026 15:41:37 -0400
X-MC-Unique: Y7EVpKeFMtayFHZ8eHTXTA-1
X-Mimecast-MFC-AGG-ID: Y7EVpKeFMtayFHZ8eHTXTA_1787514096
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72A771954122;
	Sun, 23 Aug 2026 19:41:35 +0000 (UTC)
Received: from fedora (unknown [10.44.32.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 870F41800348;
	Sun, 23 Aug 2026 19:41:31 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 23 Aug 2026 21:41:35 +0200 (CEST)
Date: Sun, 23 Aug 2026 21:41:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Keke Ming <ming.jvle@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
Message-ID: <aotM6tRUHI9Bo7gW@redhat.com>
References: <20260822054620.452262-1-ming.jvle@gmail.com>
 <aosT4H14zcowzU_7@redhat.com>
 <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/24, Keke Ming wrote:
>
> > Note that uprobe_copy_process() warns but returns "void", too late
> > to abort copy_process().
>
> You are right that freeing the partial utask is not enough.

Hmm. It is not that I think "it is not enough", I think this is pointless
whatever we do. Please see below.

But you know what? I am afraid I am totally confused again, this happens
more and more often. So please correct me.

> Would it make sense to keep the cleanup

But again, why do you think it makes any sense to keep the cleanup
you propose?

> and additionally send
> SIGKILL to the new child when the  uprobe state copy fails?

Or SIGILL like the rest of uprobes.c does...

Yes, this is what I meant. But this is only the first step to cleanup
this logic. I'll try to write another email tomorrow.

Lets suppose we change uprobe_copy_process() to kill the child. Then
why do we need to call uprobe_free_utask() in dup_utask() or do anything
else in copy_process() paths?

The child won't return to userspace, it will exit and call uprobe_free_utask()
itself.

> Also, should the existing "dup xol area" failure path be handled
> the same way?

Yes sure. But perhaps needs another discussion.

Oleg.

