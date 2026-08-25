Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE3A429024
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660829; cv=none; b=NcxPPIBDVgMcMKlCcgowiJUrd457GJWTq9G0c+yTqEjG+S3gjeyLD6fD9Kk1YhU4mBruS7Jy3hvyBCnjKo+Z7sYcFRzsPmdp4vG4ZojJI1m7FEPYX1gI8gocvg3FtwFGxEkfzsnj9mQ9L75QdP+KrSv/Xj6wO3j+DBNpEaTMb+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660829; c=relaxed/simple;
	bh=9GYDlWtS1yrMi2DmvdcfxbgnSq1hjRXS2RbpilOuJjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj0l/1GTv0+mZTJ42yVdztCApMcMzbZI7slhXUsok5X66zj5mB0w7iW0Qk8jhDGIPE0bFBEkTmDU7J5g/179DP5DwJruagWviONqFqk4Kk+ncJyivZBLsOAEiStqBV1GsuAL4GtSO/OSIU0KyAAcbRX8uxWtYQEbHPFql/5HpCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dc5f2rXX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dc5f2rXX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787660826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GYDlWtS1yrMi2DmvdcfxbgnSq1hjRXS2RbpilOuJjM=;
	b=Dc5f2rXXdZn4iFfK8LnYJn2Kr/3y5Wdfw7pWMQ4u9ktbhUOcQFsVb/W2SwsMaaK0H8dNXf
	UqtjaWLc+5rvg/XyBnDWQl/MKSj+7XTIw0pr6F2a2qnBL1RQ6sidwyMQb7d5FZZqi8Sc8v
	kql66gH7COzke6zw2zIHsBK3OA3+1j0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-WP18YMzGPu2gNGn_XYpIHQ-1; Tue,
 25 Aug 2026 08:27:00 -0400
X-MC-Unique: WP18YMzGPu2gNGn_XYpIHQ-1
X-Mimecast-MFC-AGG-ID: WP18YMzGPu2gNGn_XYpIHQ_1787660819
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0729C191FCD3;
	Tue, 25 Aug 2026 12:26:59 +0000 (UTC)
Received: from fedora (unknown [10.44.32.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 673DE1800641;
	Tue, 25 Aug 2026 12:26:55 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Aug 2026 14:26:58 +0200 (CEST)
Date: Tue, 25 Aug 2026 14:26:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Keke Ming <ming.jvle@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
Message-ID: <ao2KDQuBMNtONu0K@redhat.com>
References: <20260822054620.452262-1-ming.jvle@gmail.com>
 <aosT4H14zcowzU_7@redhat.com>
 <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com>
 <aotM6tRUHI9Bo7gW@redhat.com>
 <CABbwK50istUW_xnFsjCA+MMgFCuBbY-Zs3QmJU=Fg7heqKdF6A@mail.gmail.com>
 <aoxp3Rcbp3fUuqS8@redhat.com>
 <CAEf4BzbUQWAB0JuEdXu32v4S_zMuv4de+kYv0mcY4tDPu8CA2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbUQWAB0JuEdXu32v4S_zMuv4de+kYv0mcY4tDPu8CA2Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/24, Andrii Nakryiko wrote:
>
> On Mon, Aug 24, 2026 at 8:57 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > force_exit_sig(SIGILL) can't be ignored too. But I am fine either way.
>
> Current SIGILL sending is already pretty bad behavior that bites us
> periodically, instead of doubling down on killing the user space
> process because something about installing uprobe goes wrong, let's
> think about a bit less destructive way to do this. Mark uprobe for a
> particular process as defunct or "detaching it", or something along
> those lines. But not just kill innocent processes.

Well. Yes, SIGILL sending acts as BUG_ON(), this is not nice and
probably we can improve the current code. And, just in case, as for
uprobe_copy_process() in particular I agree that Option B (make fork()
fail) is better.

But what, say, uprobe_handle_trampoline() can do if ->return_instances
is NULL? Either we have a kernel bug, or the probed task does something
wrong. In both cases it is better to kill the task with pr_warn() and
generate the core dump.

Oleg.

