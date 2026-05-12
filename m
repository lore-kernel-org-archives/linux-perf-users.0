Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C49838888E
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602684; cv=none; b=jYn95pZoXdO1GFWMfpj8icVq17WIF/vAA46fwsrR6Bv2LXvlf7rYCJMLXHzxnTI5ecCmxAW124zbxWMcwWRl1TNrBDqyodhhJIqvlpwTas+7coLPDTytgMP86Rt+cK/N4Lh6cRIRYgraqhnP94Bj/J6DFqETj+N13t64biYT4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602684; c=relaxed/simple;
	bh=m7z9Z4sYN0opQKuI3E1x7eWvBvgZZGHly/GpE05aOE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7cPzRPUPsiRocFT9LM+d1He8oQW6bauVz318EoePedDOZwYXlIiX9SuvgMjLd5dYcWu0vRDsgDTKK6EvfrGq9lEk+jKD82WcFN15A8XIADYx9ICINJ551jB2SHfeGym0IIoYf0xAZVoUb/ipJGJQmcgado9X2xuT487aqs2+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFV94re+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFV94re+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778602682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nxcKNVqiUEb6JNi/jIVIymwa8BQUKmPeEdVzIc63rZk=;
	b=VFV94re+qSaqAXX1S/IJHbwUriTXz2cWl4p6KbW3JpacejG9WbyO2yx03Ni9N7WExGbL3/
	ZvS9y/7ej3xdjnk0Os2XWdGGrodmjE/G6c7Dr2Hndbgmi1Ur5aXPl1TB/9CODXbezk6Qz7
	9C2HF9Y7JczipNf7fLC3cpkVhDXoaVg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-ftWU47PpMumNXoDqS6MSmA-1; Tue,
 12 May 2026 12:17:56 -0400
X-MC-Unique: ftWU47PpMumNXoDqS6MSmA-1
X-Mimecast-MFC-AGG-ID: ftWU47PpMumNXoDqS6MSmA_1778602674
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 645FF18005B8;
	Tue, 12 May 2026 16:17:53 +0000 (UTC)
Received: from fedora (unknown [10.44.48.223])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D932E1955D84;
	Tue, 12 May 2026 16:17:47 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 12 May 2026 18:17:52 +0200 (CEST)
Date: Tue, 12 May 2026 18:17:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:UPROBES" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] uprobes: Use flexible array for xol_area bitmap
Message-ID: <agNSqoie5l0jdgNx@redhat.com>
References: <20260511225648.27886-1-rosenp@gmail.com>
 <agMPMAnsCH2ZRhf5@redhat.com>
 <20260512234857.44e2b0fafa4961900fdb7246@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512234857.44e2b0fafa4961900fdb7246@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 05/12, Masami Hiramatsu wrote:
>
> On Tue, 12 May 2026 13:29:52 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > >
> > > -	area = kzalloc_obj(*area);
> > > +	area = kzalloc_flex(*area, bitmap, BITS_TO_LONGS(UINSNS_PER_PAGE));
> >
> > The downside is that kmalloc will use kmem_cache with ->object_size = PAGE_SIZE * 2,
> > almost half of the allocated memory won't be used...
>
> Hmm, is the bitmap so big?
>
> #define UINSNS_PER_PAGE			(PAGE_SIZE/UPROBE_XOL_SLOT_BYTES)
>
> And even on arm64,
>
> #define UPROBE_XOL_SLOT_BYTES	AARCH64_INSN_SIZE
>
> So if PAGE_SIZE is 4k, UINSNS_PER_PAGE is 1k, its BITS_TO_LONGS will
> be 1024/64 = 16. So 128 bytes. So the object is allocated from
> object_size = 256 ?

Indeed you are right.

Sorry for the noise and thanks for correcting me! I can't even explain how can
I came to conclusion that object_size can be greater than PAGE_SIZE with this
change ;)

So I think the patch from Rosen is fine.

Thanks,

Oleg.

