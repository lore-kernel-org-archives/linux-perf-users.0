Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514D1D7E5C
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Sep 2024 19:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391978; cv=none; b=b/Suoh0DB9IoatU5nd5V/HUI5cp9sUwLtIktjYKySYhc6bytSxSQpSENLhSuDBMbzwU7UOOwzodpwdYXZfBI9Vfuy1rySDSjhKYz+d8qFB06U5qYEvQ4LtixFhqbBM0yid+ZeYx42PEbhxJE8tC3d007gw7x4vb6bTm+vMTHcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391978; c=relaxed/simple;
	bh=cVPmlfM4WE9cufRVeCzhP/FJ4zUgDSM/0iSqHCu51f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOF4ngS6hMwrYyAag0cLjVdkzpROuwGpyyKZ9MFEntJ5lpCNbYBu1Ll3bMVfmqNRce+hHdyNjTaLOsWQv4xOywLghgAOCHSd4KDj5ho1FAk7ngRslwIFVyWiyMuoyVsU1kqm7NOSs+GuDblFy7aeu+NsU0Ojk3/A7xRavBN7/ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2aUPTrn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2aUPTrn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725391975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+Z2PRoTofDqf4fCyTx1VB6rz5LVbnMudjBmBICJ+Vg=;
	b=K2aUPTrnFmCwddk5pY36YEdJs1nFYw1Jx5J2S8yl3E9U1h3OyB1SsPPrBX+jP/eGJaDeLi
	o9ooSeTwQxoGFbeJY8Ji6IX+q/Sk2/NtIOipAcebpsvc+KBGo+oRfEFMEVgpcWwz7mo8WK
	3Y3jzs7X5Tk+Pnza1TB5JMvliyrAWN8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-P4NmjCkqMKyRe10En3_pcA-1; Tue,
 03 Sep 2024 15:32:52 -0400
X-MC-Unique: P4NmjCkqMKyRe10En3_pcA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E93F195E939;
	Tue,  3 Sep 2024 19:32:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.38])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6E8681955F1B;
	Tue,  3 Sep 2024 19:32:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  3 Sep 2024 21:32:39 +0200 (CEST)
Date: Tue, 3 Sep 2024 21:32:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sven Schnelle <svens@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
Message-ID: <20240903193232.GK17936@redhat.com>
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com>
 <20240903090843.GA17936@redhat.com>
 <CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/03, Linus Torvalds wrote:
>
> On Tue, 3 Sept 2024 at 02:09, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > but with or without this fix __create_xol_area() also needs
> >
> >         area->xol_mapping.mremap = NULL;
>
> I think the whole thing needs to be zeroed out.

Agreed,

> Either use kzalloc(),

This is what Sven did in

	[PATCH] uprobes: use kzalloc to allocate xol area
	https://lore.kernel.org/all/20240903102313.3402529-1-svens@linux.ibm.com/

Oleg.

