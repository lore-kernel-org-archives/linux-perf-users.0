Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE257B3F7
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Feb 2024 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410984; cv=none; b=nq+tf+V6PyGnKB1lcFXCL3I4sEL1RLRgzXg5ir96aK5Xl9gtWbrswfExxVJrqJLIVLGneKIcYXe/s0l6l3L1mXoZAEmaxujWHhJmH0vGbFTULqWGY1ZVEk0O9ZDbDK8d7v0+qzW7quCuIw8OyUNBpN2m3oau9nqNZyWgEdk3WSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410984; c=relaxed/simple;
	bh=yvPbLu6iaxbF+Zl9aU5lxEwQiXlaIO7kvIsLJhKBweI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Rm9wJkpr9K/5gS5OJofRSKCNHGq2BZo+NPZDbaophdAt1YtKeesISTtd935IoLcacksB5YyQHNqG7/b56IL8fHNp/lNz/bkEWVAy965jMTzcPKWJZn39r7RKtBfAMDaKJt7vmJxaT7Zeq7mYHYH98t9SdTF3ujQZ0Zdcq0peYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZZo37P1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZZo37P1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707410981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQH/4KocqEh8aLQFBMs2v88RVeCnGaoZKpekJ/EFKuI=;
	b=VZZo37P17aJH3+aytEuXhqVAEGXXKHyE26oyN5mJ5KO9pp4tLeGKfDyq1NEQ8+jP5QRHYe
	+kJYkh4FP7vHhN7rfYjcX5iSiCMVxWk58ITlqyZVC265kltdZlTxlE7PiAOOZpmXWJxv+Q
	LTYEmmSiR6NA1lqAUTCsGCNXeQavzhw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-M4fuM21EP0yB606-zTD7gQ-1; Thu,
 08 Feb 2024 11:49:38 -0500
X-MC-Unique: M4fuM21EP0yB606-zTD7gQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C69DF1C0F478;
	Thu,  8 Feb 2024 16:49:37 +0000 (UTC)
Received: from Diego (unknown [10.39.208.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 930F140C9444;
	Thu,  8 Feb 2024 16:49:35 +0000 (UTC)
Date: Thu, 8 Feb 2024 17:49:32 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To: Namhyung Kim <namhyung@kernel.org>
cc: linux-perf-users@vger.kernel.org, vmolnaro@redhat.com, acme@redhat.com, 
    acme@kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH 1/7] perf testsuite: Add common regex patters
In-Reply-To: <CAM9d7chjET+Zy7EYcRNW=9XaC+DKcqqU+EatiGJouRCjjHscKA@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.2402081741080.11354@Diego>
References: <20240131113951.17077-1-mpetlan@redhat.com> <CAM9d7chjET+Zy7EYcRNW=9XaC+DKcqqU+EatiGJouRCjjHscKA@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463784192-246822525-1707410977=:11354"
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463784192-246822525-1707410977=:11354
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 1 Feb 2024, Namhyung Kim wrote:
> On Wed, Jan 31, 2024 at 3:42 AM Michael Petlan <mpetlan@redhat.com> wrote:
> >
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> >
> > Unify perf regexes for checking testing output into a single file
> > to reduce duplicates and prevent errors when editing.
> >
> > This will be used in upcomming patches in shell tests.
> >
> > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> > ---
> >  tools/perf/tests/shell/common/patterns.sh | 256 ++++++++++++++++++++++
> >  1 file changed, 256 insertions(+)
> >  create mode 100644 tools/perf/tests/shell/common/patterns.sh
> >
> > diff --git a/tools/perf/tests/shell/common/patterns.sh b/tools/perf/tests/shell/common/patterns.sh
> > new file mode 100644
> > index 000000000000..919a07b8b454
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/common/patterns.sh
> 
> We have tests/shell/lib directory, maybe better to put this there.
> But maybe we can move it later once we apply the series.

Yes, in case the testsuite gets accepted, I plan to work further
on the integration with the current shell test set, in order to
unify the configuration, output, logging, etc. So, I'd prefer to
merge the directories later.
> 
> > @@ -0,0 +1,256 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
[...]

> > +export RE_ADDRESS_NOT_NULL="0x[0-9A-Fa-f]*[1-9A-Fa-f]+[0-9A-Fa-f]*"
> > +# Memory address (not NULL)
> > +# Examples:
> > +#    0xffffffff9abe8ae8
> > +#!   0x0
> > +#!   0x0000000000000000
> > +
> > +export RE_PROCESS_PID="\w+\/\d+"
> 
> I'm afraid the process name can have spaces like
> "my proc A/9876".
> 
> Thanks,
> Namhyung
> 
Good catch! Theoretically yes. It is not used yet (perf-trace tests use
this regexp; we aim to post the rest of the testsuite later). However,
looking at the perf-trace testcase, it runs also `perf trace -a`, so
if there are any processes with non-standard name, they would appear
there. But that's not only space, but also other characters, like '+',
etc. We will try to fix this to match any valid process name. Thanks.

Michael
> > +# A process with PID
> > +# Example:
> > +#    sleep/4102
> > +
> 
> 
---1463784192-246822525-1707410977=:11354--

