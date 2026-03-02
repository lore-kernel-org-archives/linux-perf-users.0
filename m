Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CDF421F11
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Mar 2026 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469205; cv=none; b=GQDE2OjYD4hemYUPGVzck8nn1eaX6aelrUyYbsSpa3AFp8a1AiUcenmvqXYECU//XV3ZXFuTjMmX9b+LTqe/8iHDO2Gp9AN/J+xswj+yTAHIzVcnwLWfgirVUPTEAv/LkDuKTzOh0C3EYf+ZHC9NrRj5jusmA8Gme9t0YuL/vlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469205; c=relaxed/simple;
	bh=lSjpmgyCnhu+Pq2SAbgg8Jf8/7/JBFUufvH9c6aVBUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIhY+biFthh3mF6MvczSwMQfsAZ+sKLGv2cBdzXOi4FvtZuqYzQXMjyad7Pm3N/tl9nHT3Ll4QWIdYXrrn4jYiOPSfj7VU8sa6tqCuCY+oojktC8YCiHa/ifYumREosl0DB8lxrRiiHBZxd9qJsH0fVDqYgvujVexBUuzxjNfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/iV5LNL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/iV5LNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772469203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qhyPpNHT+7FAPWparjtNDEXTVS3lZcX8CHma9Mj4ghs=;
	b=V/iV5LNLWN2795zkuvEG7oK32UkSIvcYsy7SEnhjPpyiaI5PjZswzf78k3ztAZvdCNEMCf
	FqGbVu73WIQbYO4HCgoS7bn1mDQJ0if0vc69t9NOSZRaDNWBN5gY1ldBsHSFLDsbuJsVsb
	xNp+zRgwhvQPdaZa4zOoPPXrh7UN8nY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-jeHT-FfnNsmFsuaxdFbFAw-1; Mon,
 02 Mar 2026 11:33:19 -0500
X-MC-Unique: jeHT-FfnNsmFsuaxdFbFAw-1
X-Mimecast-MFC-AGG-ID: jeHT-FfnNsmFsuaxdFbFAw_1772469197
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D41851800352;
	Mon,  2 Mar 2026 16:33:16 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.csb (unknown [10.43.17.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 835DB19560A3;
	Mon,  2 Mar 2026 16:33:10 +0000 (UTC)
Date: Mon, 2 Mar 2026 17:33:07 +0100
From: Jakub Brnak <jbrnak@redhat.com>
To: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	broonie@kernel.org, acme@kernel.org,
	Andrew Kilroy <andrew.kilroy@arm.com>,
	Vince Weaver <vincent.weaver@maine.edu>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kristina.martsenko@arm.com
Subject: Re: [PATCH v2 1/1] perf arm64: Send pointer auth masks to ring buffer
Message-ID: <aaW7s-ISz1QGpmqB@jbrnak-thinkpadx1carbongen9.tpbc.csb>
References: <20221020101921.1219533-1-james.clark@arm.com>
 <20221020101921.1219533-2-james.clark@arm.com>
 <Y1F8DUWaWhlh/phL@hirez.programming.kicks-ass.net>
 <4e50b890-0588-1551-fb7c-6cd8191d1054@arm.com>
 <Y1q914IVy6XgE1xq@hirez.programming.kicks-ass.net>
 <133c2f4b-1ca5-2d0c-f4f4-e01ff5e028c8@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133c2f4b-1ca5-2d0c-f4f4-e01ff5e028c8@arm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Oct 31, 2022 at 01:48:56PM +0000, James Clark wrote:
> 
> 
> On 27/10/2022 18:20, Peter Zijlstra wrote:
> > On Tue, Oct 25, 2022 at 04:28:12PM +0100, James Clark wrote:
> > 
> >>> Why do we want the same mask repeated over and over with each sample;
> >>> should this not be part of the address space (side-band) data?
> >>
> >> You are probably right that it could be done that way. The reason that
> >> we did it this way was to be consistent with ptrace feature [1] where it
> >> is delivered to userspace on a per-process basis. And there is also a
> >> prctl for the enabled key types [2] which can be changed dynamically.
> >> Particularly for the last reason is why it was done per sample.
> >>
> >> Having said that, the enabled keys field is not used by perf, only the
> >> mask is used, so I can drop the per sample data until enabled keys is
> >> needed, which may be never.
> >>
> >> I'm going to assume that perf shouldn't use ptrace because of
> >> permissions and conflicts with debuggers, so I could put the mask
> >> somewhere like PERF_RECORD_FORK instead of per sample.
> > 
> > Yeah, or create an new RECORD type which you can also send around at
> > prctl() time.
> > 
> > The only thing that's needed on top of that is exposing the mask
> > somewhere in /proc for existing tasks; which is what perf also uses to
> > syntesize RECORD_MMAP events on startup etc..
> > 
> 
> Hmm ok, in that case I can just add the /proc interface for now because
> the mask won't change and we can add the new record type at the point
> it's needed in the future.
> 
> Thanks for the feedback.

Hi all,

Does anyone know how this issue was eventually resolved? 
Specifically, is the mask for the pointer authentication bits 
currently exposed and stored somewhere in perf.data so it can be 
used when running perf report?

Thanks,
Jakub

