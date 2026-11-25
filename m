Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611759;
	b=4Wq/T6+s1B04fCTlFJCKsDvHm/jQmeeix560NpmAV6xz52DIbuNu8MKYiBQKOTOix2PX
	 sceZmch96xKgb7uQ0v1ftcbRN+n367fM9TjVAKxe7e9UTDucwWc1207pxlPZf/hgXF/Cx
	 g2JQGjxbQEUTs9JIgnJ4quakriGitk99xWzfbIjFz3DUQ0sy/HKJKCCKEQC/K7ST68Kni
	 lUaGnHKL78hpoXG0qk3PBaaPrbBxVQPNB3+gG06WpRhVcR9bKtBCg3tQEDqPXTdpL17KC
	 iib64xf/xFzYWiK3uB20nnWVwd17R5pw2syMwaKMJRF+SFpiVv2FPvMnE/qrFgQUekw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611759;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=iH1h6kWeUH9RRj2wi5ecaoW5gXv/BiW7zN7nR1fxcqM=;
	b=SEYQbaKzwBEEYXP//yXlXUD1FDms9iapwaRMrmza8+/puSr+aW85Jm3db+Sr+AIm2Bla
	 4W8+OI57pkIDDMs+kgGTXk4tfS0fsiY+75BM43XOzeyUWTVOIbSJggxAPPsWFOWoscZqi
	 9NRIYg1C24aI+H/kowwGDb3+2gtqrhgqsLy87e16qdxmjCagwmJzH589HOPTTku1nVZ/W
	 j2BGimUbXzvtdXzdCpZe9U1tcDsubwRPiVO1hir/FC5yiNsQr4WCNxb1o8cuejMX5ZFw/
	 tWDl2VC7GsDAFWktSx3aqcLwoIUyZnZa4n/QGJjHb29WQ9POX4KXVZnTgvcRSxtJz3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=OiM6FUYl;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74F2606A32D;
	Wed, 25 Nov 2026 13:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E74F2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=OiM6FUYl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iH1h6kWeUH9RRj2wi5ecaoW5gXv/BiW7zN7nR1fxcqM=; b=OiM6FUYl0UZ7TtReqL890BKiTx
	ZB5Cu75j1x7CGQ2YAvfK2+g7t9999u0zuxXE9OtOEUo/PyjFZleRot/AQR90N96unLlsGqOAdLGwo
	DV3GyZnPuBkJzQVxd5mfUydqBzQqveJV1dIgJ2Mej5J7yOpy3bXR00oPJ5760rcuEzm9s+YQENfEm
	PbET2wdeYSTB6svenKs8Fu5kGzB41Yf2IVqRzHT2qEMpwesV4TQu9nGNNIsEXncP+MK4C+feWtEtd
	lrUXAO/tEaKvo9j5vH3vD+gQaE71FWukS35u66UI+S9VPHGxjsnA7Lalrb9oTrmn/+o+q3Pyt4VLQ
	UeRLjckQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWCdu-0000000EGuV-00ko;
	Wed, 25 Nov 2026 13:02:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 83F82300446; Wed, 25 Nov 2026 14:02:33 +0100 (CET)
Date: Wed, 25 Nov 2026 14:02:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] perf/core: Add PERF_EVENT_STATE_ON to fix
 filtered event enabled time
Message-ID: <20261125130233.GO2669272@noisy.programming.kicks-ass.net>
References: <80d983c5713537f5743b69e9b35ced1177e4732e.1795589380.git.irogers@google.com>
 <20261125123712.GP1813469@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125123712.GP1813469@noisy.programming.kicks-ass.net>

On Wed, Nov 25, 2026 at 01:37:12PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 24, 2026 at 10:52:28PM -0800, Ian Rogers wrote:
> > @@ -4134,6 +4154,21 @@ struct merge_sched_data {
> >  	enum event_type_t event_type;
> >  };
> >  
> > +static void group_set_inactive(struct perf_event *group_event)
> > +{
> > +	struct perf_event *sibling;
> > +
> > +	perf_event_set_state(group_event, PERF_EVENT_STATE_INACTIVE);
> > +
> > +	for_each_sibling_event(sibling, group_event) {
> > +		if (sibling->state == PERF_EVENT_STATE_ON)
> > +			perf_event_set_state(sibling, PERF_EVENT_STATE_INACTIVE);
> > +	}
> > +
> > +	list_add_tail(&group_event->active_list,
> > +		      &group_event->pmu_ctx->flexible_inactive);
> > +}

This whole thing looks dodgy as well. This feels like
__perf_effective_state() needs an update or something.
