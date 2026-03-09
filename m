Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A04CB5B
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083234; cv=none; b=gBoa6E5l1mwS+M08CU30QehdwahkHgJgWqTy6sDZ4cT/m0Ke73ADc3SQKhtaBw6I/2WeejeKk7YUnKTHyssNKKk78Q7CIbNqiIAmGKvZDdMppokjfK5peeyZhSgjWeukXUMk+uq7dQNHXIgmSYr4wOXfz/X1QaofkEKsWadlSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083234; c=relaxed/simple;
	bh=0ejJUd1f4TIHwtauLrETBQzTivnfMobD69XRnEvpIy0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ounfa9n5XGaeyjYcBCv7smyGvStENoeiE2X7vKN/TMH7cenR2GryF582lkp+ftsrJpYwky3ZQb0xpzwSflYqF21dmZSXRcetbIPahPrRPbNIg0BcHcwUlqe+l8JX8rD1NDLy8KgbU1a2d1/naJeGCeP1I0xSauMoVpgkuVjBYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LuOs6fHV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuOs6fHV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773083232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MPxQ0JQAanVlOPbp6mzcMRey1wUUE0QiIS3/mMFkEEo=;
	b=LuOs6fHVzPjzuO56e3qTrD7dBggxtCzhqT8PxL7Bf5aHHUOvKYx7GtJQC/uMwUmLxYHheL
	yXcjWrNe3PBOorbH3V0uuY8EXlGY4KyWCklxhim8LJYbUP6VmBWy/DpXCs4LGnYakdbiUS
	KG13f162V3xtoh9AAZPEu1BxvoZ/IeY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-CVuflAmWMCS8Byb2UqhzHg-1; Mon,
 09 Mar 2026 15:07:08 -0400
X-MC-Unique: CVuflAmWMCS8Byb2UqhzHg-1
X-Mimecast-MFC-AGG-ID: CVuflAmWMCS8Byb2UqhzHg_1773083226
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C8F01800561;
	Mon,  9 Mar 2026 19:07:06 +0000 (UTC)
Received: from Carbon (unknown [10.44.22.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50B0618001FE;
	Mon,  9 Mar 2026 19:07:00 +0000 (UTC)
Date: Mon, 9 Mar 2026 20:06:56 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
    Dapeng Mi <dapeng1.mi@linux.intel.com>, 
    James Clark <james.clark@linaro.org>, 
    Sadasivan Shaiju <sadasivan.shaiju2@amd.com>, x86@kernel.org, 
    linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Manali Shukla <manali.shukla@amd.com>, 
    Santosh Shukla <santosh.shukla@amd.com>, 
    Ananth Narayan <ananth.narayan@amd.com>, 
    Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v2 4/5] perf/amd/ibs: Avoid calling perf_allow_kernel()
 from the IBS NMI handler
In-Reply-To: <9145b8b7-fb83-49c4-aa17-acdba069359a@amd.com>
Message-ID: <21f41878-254f-191e-eaa9-26a9faf68d45@redhat.com>
References: <20260216042216.1440-1-ravi.bangoria@amd.com> <20260216042216.1440-5-ravi.bangoria@amd.com> <81204aa7-9d81-8d53-b82b-6c4ad8c89c2@redhat.com> <9145b8b7-fb83-49c4-aa17-acdba069359a@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, 9 Mar 2026, Ravi Bangoria wrote:
> Hi Michael,
> 
> > By evaluating the privileges at the event-init moment and using cached
> > value later, couldn't it lead to the cached value being obsolete at
> > some point? E.g. a setuid program later dropping the privileges but
> > still being able to read physical addresses?
> 
> Yes, but wouldn't the same concern apply to all other call sites of
> perf_allow_kernel() ?

Well, I don't say this case is worse than the others, just raising a
more generic question whether this design is fairly acceptable or would
deserve e.g. privilege adjusting at the time when they are dropped or
something... Nothing more, just a note... :)

Michael
> 
> Thanks,
> Ravi
> 
> 

