Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489547CC6F
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574827; cv=none; b=eWORI5jaTLOAo7SE/2dZsLIqxIaTIBBmCukXX5duxLy32sEGqhjKWZMEEKwuLW8bWaIhL/VPZLxiFoVO4kTTTMe0d4OcgLv6VlusRSqzXqUv0zTuAf7OUDHRkS+z9FaczRNVwHLwzV5d6QVgAoSY0pfG/UxCZDZTgnIkpb0OVFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574827; c=relaxed/simple;
	bh=sgEmDrRG7CWGy0GhWu6kQhiMkkhNkXPK8olzYJNcb34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwDehB+JUFXn4LL7cmuJ1RfiOtbKrfkmSWkXPuifHMXtbqvMrRr5RvY4eRSh+ihiGqi+bcyG3ByfVfLR7LaFNt4TAMenxoJxw1f2/cIq7mmJ5hMgOSJDvDQTUoow698S4wzUbiRllExEJAtO4TDqDm45+AaOD6GsoveUWzKHThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDERL2pf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDERL2pf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777574825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sgEmDrRG7CWGy0GhWu6kQhiMkkhNkXPK8olzYJNcb34=;
	b=DDERL2pfKz5+CW3yVG3cjj87BD8tHz9/mYO/jNJZnjMgO5G4vKfX+MZpXnH2XpHnA9Db1K
	Z5YqRZzQEDPILd9lbRhw2AVwdjQ/cuvRi8KEBqE6HXAiffpD0vLFUaeNRk5Z2OFSM65Zkb
	VoFSoYLu8ZMlPmJI+JCmjattsr5yxgw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-yQvVCO7mO_iiuCeNpI7Y5Q-1; Thu,
 30 Apr 2026 14:47:00 -0400
X-MC-Unique: yQvVCO7mO_iiuCeNpI7Y5Q-1
X-Mimecast-MFC-AGG-ID: yQvVCO7mO_iiuCeNpI7Y5Q_1777574815
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8785B195608F;
	Thu, 30 Apr 2026 18:46:54 +0000 (UTC)
Received: from fedora (unknown [10.44.48.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 564FC19560A6;
	Thu, 30 Apr 2026 18:46:45 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 30 Apr 2026 20:46:53 +0200 (CEST)
Date: Thu, 30 Apr 2026 20:46:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Daniel Walker (danielwa)" <danielwa@cisco.com>,
	"Darko Tominac -X (dtominac - GLOBALLOGIC INC at Cisco)" <dtominac@cisco.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/madvise: preserve uprobe breakpoints across
 MADV_DONTNEED
Message-ID: <afOjk9igx9nlc9cg@redhat.com>
References: <20260429131522.4049054-1-dtominac@cisco.com>
 <889e4186-9f75-45d3-bd9a-1c90b218a635@kernel.org>
 <afIiqR5CqYRId0N0@redhat.com>
 <afJz3l6435DHLorn@goliath>
 <afMeAs6upm8kLCYb@redhat.com>
 <2d815203-a81e-40b4-92ba-31832c84c20b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d815203-a81e-40b4-92ba-31832c84c20b@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

David, et al, I am sorry for the unnecessary spam but I can't resist...

On 04/30, David Hildenbrand (Arm) wrote:
>
> On 4/30/26 11:16, Oleg Nesterov wrote:
> >
> > But may be MADV_DONTNEED should not set zap_details.even_cows == true
> > by default ?
>
> It should. If you do mmap(MAP_PRIVATE, fd), and modify some pages, MADV_DONTNEED
> must zap these pages.

[... snip the correct explanation ...]

Ah. Sorry for the confusion, I should not have said "by default". Of course
you are right, and I understand this. At least I hope ;)

Let me try to explain what I tried to say. First of all, I still agree with
your "It shouldn't do that on a MAP_PRIVATE file-backed VMA". I also agree
with Jann who suggests to make the manpage more clear about uprobes/bps.

But, lets suppose that this "problem" is raised again, and we come to conclusion
that it should be fixed/mitigated. ("we" actually meaning you and other mm experts ;)

_In that case_. Instead of this patch (which, rightly or not, I personally dislike
in any case), can't MADV_DONTNEED paths check MMF_HAS_UPROBES or vma_has_uprobes()
to decide whether .even_cows should be true?

At least when madvise_behavior.mm != current->mm ?

Oleg.

