Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EFC28F949;
	Wed, 25 Mar 2026 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774452770; cv=none; b=irCBh42kr14oDxYaZ/GH66qbuAGmh/KBiw7l074llZD2OnvALYnej2eI9UHsVHW6GnHrXDm/bKbCns3zBpOuzhGHc7h7C2WyfyIy1bbkP4jG6Ev2+1VLe3XlGHt3H+DGvTEokpQ3++WpM+lB7OXFwvcIuYwqajktulzVZMSIjnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774452770; c=relaxed/simple;
	bh=lKvyEM68xFevYhuzAf0jU+8fwUQON+hy53TSSIdLLtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsoV5FDIiWx4giMRS1EemBMVme04HEGFQU/IxPfAy0y+8bssvMykrM0a6BE7dsQk86qGxeXNZBZNylTSdsQK2N/Fyp3woolBxkfh2HlJP9zbxT3VcgYJh6mSHZI2a64WJ4KjrDomPBLdr+H0pWIcNZ0dZrCGxR7O3V9ZIOt4Q74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RjL6y9FP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RjL6y9FP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cvBNTH6UO4NrJA7ZeXzlrXmhyqeU6c9RcfZsXgC+OFY=; b=RjL6y9FP8+YGBj367jAK6Kk4vX
	L+enG2fNiW5cdI0vP2jEhMMJSMZolIheB01vVIxC5vo3DOCG1mK3bnW2U3Nb4c4vlfjhfVte26mG5
	uchXyVb/8dVOwxNZucMRbfHTEwCws5KF2GLNKW3sjRemN7SR7N0gPTkTqJSbGiDXuvFyFzb4rVlYh
	BsTRIb1ka/XWvVQJT5QTcyAkOd07wOmVY4LdYhe8UDj5WT9Ktm5vpOhEdXUKExU3un+2wWjpyGRMd
	Jr7YTSGpq5Zu8S/pWacuWjl4xGnAxThvW/+mXNji3V8lKDfnIpdm9yVD8Okv5qPKPfOB8Fhrr7usr
	MPx1g4Bg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5QDo-00000006UyY-42Lj;
	Wed, 25 Mar 2026 15:32:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 67F7A3004F8; Wed, 25 Mar 2026 16:32:40 +0100 (CET)
Date: Wed, 25 Mar 2026 16:32:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: yuhaocheng035@gmail.com
Cc: irogers@google.com, wangqing7171@gmail.com, acme@kernel.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
	syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] perf/core: Fix refcount bug and potential UAF in
 perf_mmap
Message-ID: <20260325153240.GK3739106@noisy.programming.kicks-ass.net>
References: <CAAoXzSrdEjHtLYqHJDT8bm_gDAY=C1VdeU=0NbjJ0hhpOo5V9w@mail.gmail.com>
 <20260325102053.1401-1-yuhaocheng035@gmail.com>
 <20260325151735.GI3738010@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325151735.GI3738010@noisy.programming.kicks-ass.net>

On Wed, Mar 25, 2026 at 04:17:35PM +0100, Peter Zijlstra wrote:
> 
> Argh,. why is this hidden in this old thread :/
> 
> On Wed, Mar 25, 2026 at 06:20:53PM +0800, yuhaocheng035@gmail.com wrote:
> 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 2c35acc2722b..a3228c587de1 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6730,9 +6730,10 @@ static void perf_pmu_output_stop(struct perf_event *event);
> >   * the buffer here, where we still have a VM context. This means we need
> >   * to detach all events redirecting to us.
> >   */
> > -static void perf_mmap_close(struct vm_area_struct *vma)
> > +static void __perf_mmap_close(struct vm_area_struct *vma, struct perf_event *event,
> > +			      bool holds_event_mmap_lock)
> >  {
> > -	struct perf_event *event = vma->vm_file->private_data;
> > +	struct perf_event *iter_event;
> >  	mapped_f unmapped = get_mapped(event, event_unmapped);
> >  	struct perf_buffer *rb = ring_buffer_get(event);
> >  	struct user_struct *mmap_user = rb->mmap_user;
> > @@ -6772,11 +6773,14 @@ static void perf_mmap_close(struct vm_area_struct *vma)
> >  	if (refcount_dec_and_test(&rb->mmap_count))
> >  		detach_rest = true;
> >  
> > -	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> > +	if ((!holds_event_mmap_lock &&
> > +	     !refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex)) ||
> > +	    (holds_event_mmap_lock && !refcount_dec_and_test(&event->mmap_count)))
> >  		goto out_put;
> 
> *groan*, this is horrible.
> 
> Let me have a poke to see if there isn't a saner variant around.

Also, I just realized this patch doesn't even apply, it is against a
tree without 77de62ad3de3 ("perf/core: Fix refcount bug and potential
UAF in perf_mmap").

