Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B50156F44;
	Wed, 18 Dec 2024 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510252; cv=none; b=VQX80bVSWBCbigbYaB8lPkf73y5STguMjsI1PSFXC5bKWRI2uP+XWmg7MdF/VnbXExH2QCXfvkhXS5Hf/jdTG2zrdjj22SVgrQFS7XC8z5gcEsoRyjKO6J0lgsEbeKEhezBbWb4ZDBJulsjOhYinvEETe4OcydjV5TLTLSfiHaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510252; c=relaxed/simple;
	bh=n4Tq50B7Z4mceZQjyf5fXQEMQIwFGiuPS2eSBwEQU8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJtuxve/+YxJe4FK8jxaKq6VApq6YbFrA/jK0UochLgNuryKAuH+UA5umjJM1X8fs6J/1CZAV0dpHpxXNdogv1tZs5UoXAQZkxzFzxdqMX9RkRc0EUB6Yuk2rcPWT5kRTAVivb3K36T8zk8fjvLTr2z+CyTz7yp92yaPQQYhz90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hoS1cq//; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hoS1cq//"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XZhYKQOPiTAb87U75sBGEx96S7WwXcuuY4plVWjiyLg=; b=hoS1cq//do5sDr/yMFEJOW9L3X
	zNiVjPjsARSDA8nyXBwd5Iy6l8XWKNEoZgy147q4gTz414QFq8eOV9vRudTzrAsvDkfzH/Tytxvc3
	bsUQB6Y+R7y4jwaZJxvMKgv1RuRI/P1ZL0CpDtepCKVEdCaQi8gWYL2YYRDF82TMFBYkQGJERPViA
	lQ4J3dKr3lM5nSpSQ5RkNcdFulo+uG4cJR5VRuc/rcQQBENE5Eq1cV0VIwQusSnaji+L/Bt47YkOZ
	Y0/Ao+NYo7LdKAICbjza+4DKmdCNE4JhaCv0p1ImpwBp/GnVqEH30jXzIxoY4QN3Egc0vwRV3Jb5U
	HpqUg0kg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNpLh-00000005ClW-2vaT;
	Wed, 18 Dec 2024 08:24:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E45CD30031E; Wed, 18 Dec 2024 09:24:04 +0100 (CET)
Date: Wed, 18 Dec 2024 09:24:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com
Subject: Re: [PATCH V5 4/4] perf/x86/intel: Support PEBS counters snapshotting
Message-ID: <20241218082404.GI11133@noisy.programming.kicks-ass.net>
References: <20241216204505.748363-1-kan.liang@linux.intel.com>
 <20241216204505.748363-4-kan.liang@linux.intel.com>
 <20241217133707.GB2354@noisy.programming.kicks-ass.net>
 <96cb859f-8265-4f5a-99bb-44cfdcd25b9e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96cb859f-8265-4f5a-99bb-44cfdcd25b9e@linux.intel.com>

On Tue, Dec 17, 2024 at 12:45:56PM -0500, Liang, Kan wrote:
> 
> 
> On 2024-12-17 8:37 a.m., Peter Zijlstra wrote:
> > On Mon, Dec 16, 2024 at 12:45:05PM -0800, kan.liang@linux.intel.com wrote:
> > 
> >> @@ -2049,6 +2102,40 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
> >>  		}
> >>  	}
> >>  
> >> +	if (format_group & (PEBS_DATACFG_CNTR | PEBS_DATACFG_METRICS)) {
> >> +		struct pebs_cntr_header *cntr = next_record;
> >> +		int bit;
> >> +
> >> +		next_record += sizeof(struct pebs_cntr_header);
> >> +
> >> +		for_each_set_bit(bit, (unsigned long *)&cntr->cntr, INTEL_PMC_MAX_GENERIC) {
> >> +			x86_perf_event_update(cpuc->events[bit], (u64 *)next_record);
> >> +			next_record += sizeof(u64);
> >> +		}
> > 
> > I still don't much like any of this -- the next_record value might be in
> > the past relative to what is already in the event.
> >
> 
> I forgot to handle the read case. With the below patch, the next_record
> value should not contain a previous value, unless there is a HW bug.
> Because no matter it's read/pmi/context switch, perf always stop the
> PMU, drains the buffer, and the value is always from the PEBS record.

Consider this 3 counter case:

 A is our regular counter
 B is a PEBS event which reads A
 C is a PEBS event

For convencience, let A count the lines in our example (anything
incrementing at a faster rate will get the same result after all).

Then, afaict, the following can happen:

  B-assist			A=1
  C				A=2
  B-assist			A=3
  A-overflow-PMI		A=4
  C-assist-PMI (DS buffer)	A=5

So the A-PMI will update A->count to 4.
Then the C-PMI will process the DS buffer, which will:

  - adjust A->count to 1
  - adjust A->count to 3

Leaving us, in the end, with A going backwards.

How is that not a problem?

IIRC I've raised this point before, and your Changelog does not mention
anything about this issue at all :-(
