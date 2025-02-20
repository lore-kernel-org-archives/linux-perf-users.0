Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B061F463D
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Feb 2025 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053506; cv=none; b=XiQ4jR3yU/pdV9qXrcTc2n3grys2iLcIJrgvNApN10ZriiFX59XueGQGY7/T64KfISIN1qBUT7p4F4V7roHoYg6GnZM3IMEVdmJlusz9B2TcjiwBxZlIrPy4inrimIHY33I7XMEJY6/mdGdcG2YmBuGGVOMM8ew0/lk9ZyRs0Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053506; c=relaxed/simple;
	bh=x8rxWQrvJ+M4LCHRipLM5Opmo7p0J0gyDNK7Shle7Og=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oFmk/dRa+spP7Y/V2qfnTECmjuQSrTp0LrHVgWDe4K/Nl//d8rdNXw09tGhXrBafSYtHotCAdoVDbgrgZ3wvcM51Q1+68JKR5EHoNCiOpurOz3CgCkhMjk0xoFknCLdw+hkNp11jViy6GUUakgtIMNajx9pvyVEcs6qWZSUmSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLGQaPcF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLGQaPcF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740053504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RhrXFXQ5svBVQxo6ziu59a9sD3xm5P7Es03Gb2LJN0Y=;
	b=HLGQaPcFpV9qJS2lecJSmWvCqWdc6u9QYCUuHSGhlyDYsc+LWx5BgyAWcCTvswOXym06Ix
	AX/yv4bH7Sz2nSlEOrQ1ZbpijX80drnNgfNT9g23+LG4XO7J8Lp9gsO9UWgqCMtfkHRnTA
	WFdIYwFVs+Q18TE6nsNLHL3mH9QKVzk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-MfjS2_HEPXqmcX64T2dq1A-1; Thu,
 20 Feb 2025 07:11:42 -0500
X-MC-Unique: MfjS2_HEPXqmcX64T2dq1A-1
X-Mimecast-MFC-AGG-ID: MfjS2_HEPXqmcX64T2dq1A_1740053501
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 344411800570;
	Thu, 20 Feb 2025 12:11:41 +0000 (UTC)
Received: from Carbon (unknown [10.44.22.3])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 504591956094;
	Thu, 20 Feb 2025 12:11:36 +0000 (UTC)
Date: Thu, 20 Feb 2025 13:11:32 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
cc: linux-perf-users@vger.kernel.org, irogers@google.com, 
    weilin.wang@intel.com, caleb.biggers@intel.com, namhyung@kernel.org, 
    acme@kernel.org, darcari@redhat.com
Subject: Re: Broken intel uncore events on SPR
In-Reply-To: <c481b5a2-6d1d-4c27-a32a-df131712a1a0@linux.intel.com>
Message-ID: <5116e2a-57b8-475e-7a37-2f68ae1c15d7@redhat.com>
References: <a2372e44-19fc-7eb4-c24b-1a568c742546@redhat.com> <c481b5a2-6d1d-4c27-a32a-df131712a1a0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, 14 Feb 2025, Liang, Kan wrote:
> On 2025-02-14 7:39 a.m., Michael Petlan wrote:
> > Hello all,
> > 
> > our testing shows that some uncore events are broken on Intel Sapphire
> > Rapids (family 6, model 143). I have tested v6.14-rc2 and the results
> > are the same as with v6.12.
> > 
> > The full list of events that don't work is at the end of this mail.
> > 
> > The reason is that their umasks are too big in the JSON definitions, e.g.:
> > 
> >   {
> >     "BriefDescription": "PCIe Completion Buffer Inserts of completions with data: Part 0",
> >     "Counter": "0,1,2,3",
> >     "EventCode": "0xc2",
> >     "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
> >     "Experimental": "1",
> >     "FCMask": "0x07",
> >     "PerPkg": "1",
> >     "PortMask": "0x0001",
> >     "PublicDescription": "PCIe Completion Buffer Inserts of completions with data : Part 0 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or x4 card is plugged in to slot 0",
> >     "UMask": "0x7001004",
> >     "Unit": "IIO"
> >   },
> > 
> 
> The issue should have been fixed with the latest update.
> https://lore.kernel.org/lkml/20250211213031.114209-20-irogers@google.com/
> 
> It should be available in the perf-tools-next branch.
> 
>     {
>         "BriefDescription": "PCIe Completion Buffer Inserts of
> completions with data: Part 0",
>         "Counter": "0,1,2,3",
>         "EventCode": "0xc2",
>         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
>         "Experimental": "1",
>         "FCMask": "0x07",
>         "PerPkg": "1",
>         "PortMask": "0x0001",
>         "PublicDescription": "PCIe Completion Buffer Inserts of
> completions with data : Part 0 : x16 card plugged in to Lane 0/1/2/3, Or
> x8 card plugged in to Lane 0/1, Or x4 card is plugged in to slot 0",
>         "UMask": "0x4",
>         "Unit": "IIO"
>     },
> 
> Thanks,
> Kan

Oh, thanks Kan!
I have tested it and it fixes all the broken events. Great!

Michael

