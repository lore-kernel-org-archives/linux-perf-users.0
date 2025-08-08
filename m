Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DD22E370A;
	Fri,  8 Aug 2025 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754691051; cv=none; b=E1vIp2R7cQNH0spfqWG29AJjnJj3erYnt6yorMNMuEK6NBaCJzQYgxXtlCNLeyuxyup7X3PuyyvsNg5oRvSdWLpYbZk8hQpFloZMUBkaGXMcMl37CGefXIajlyZSYvgFOJ0KCuNbhxyWnSFr9JpGsKMugrzvsPxXra6yO43ojGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754691051; c=relaxed/simple;
	bh=b6Szy6iFdiBEMmksstIHJtJaQqOImx+an/ADCiwmFJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgvVF2ypHadomw+YH4pI8oJrqMoMcmQKKrTrLS/MK8PFjF/yZhWtejXId3qmlpXVLp5XHDsuSnFvDXFBNgE2RMnJY23WDU4MlifwpgxnDf6pE6H+bSo5UQxqfLvloGXYwp3qbyHQfr0u4dyNzxG/Y/93FBDFrC9Wo/SZQFLMuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaoapQ2p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaoapQ2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142F3C4CEED;
	Fri,  8 Aug 2025 22:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754691050;
	bh=b6Szy6iFdiBEMmksstIHJtJaQqOImx+an/ADCiwmFJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UaoapQ2p809nC9ok17nuQy2BOY0/X0HEddZSxM2d75q+yPaeLOCpoH626+Zr5uk9V
	 gV7kRQTlBtr45x7LIjoUqRSjs6JRC4Tm3uV6cV/5YUb3KcYI/6l5Xdzo804vHQh6wz
	 OR7yf3IdXr85mOWPgKCZAHQyO+478I3DsIpNzrMz8qqsjnI82nVsEaubFRK520Faed
	 TA12pWE7H05bzWwgZ6EHOXKS2AS6QaQBopdAeOfDpAZJ8DXE1RVza65vb3ojZ8xxab
	 n/Xy9oD7UGpv5Dbdgn1vXzFH8EEzPb5dgIErvJ4/DRbm62peyyHGDBi8Pf908Mu+Zh
	 kk0tABUmYU0iA==
Date: Fri, 8 Aug 2025 15:10:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 4/5] perf tools kvm: Use "cycles" to sample guest for
 "kvm record" on Intel
Message-ID: <aJZ16DZXNI1pvt5-@google.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
 <20250805004633.135904-5-dapeng1.mi@linux.intel.com>
 <aJPuhpFK_ZjLk-ct@google.com>
 <154b59ee-0858-4caf-9972-3679db0a0c49@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <154b59ee-0858-4caf-9972-3679db0a0c49@linux.intel.com>

On Thu, Aug 07, 2025 at 11:08:11AM +0800, Mi, Dapeng wrote:
> 
> On 8/7/2025 8:08 AM, Namhyung Kim wrote:
> > On Tue, Aug 05, 2025 at 08:46:32AM +0800, Dapeng Mi wrote:
> >> After KVM supports PEBS for guest on Intel platforms
> >> (https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/),
> >> host loses the capability to sample guest with PEBS since all PEBS related
> >> MSRs are switched to guest value after vm-entry, like IA32_DS_AREA MSR is
> >> switched to guest GVA at vm-entry. This would lead to "perf kvm record"
> >> fails to sample guest on Intel platforms since "cycles:P" event is used to
> >> sample guest by default as below case shows.
> > Do you mean we cannot use "cycles:PG" for perf kvm record?
> 
> Yes. Here is the output on Intel Sapphire rapids.
> 
> sudo ./perf record -e cycles:PG -a
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.801 MB perf.data ]
> 
> No guest records are captured with PEBS, and guest PEBS records can be
> sampled only without PEBS.
> 
> sudo ./perf record -e cycles:G -a
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.798 MB perf.data (60 samples) ]
> 
> 
> >
> >> sudo perf kvm record -a
> >> ^C[ perf record: Woken up 1 times to write data ]
> >> [ perf record: Captured and wrote 0.787 MB perf.data.guest ]
> >>
> >> So to ensure guest record can be sampled successfully, use "cycles"
> >> instead of "cycles:P" to sample guest record by default on Intel
> >> platforms. With this patch, the guest record can be sampled
> >> successfully.
> >>
> >> sudo perf kvm record -a
> >> ^C[ perf record: Woken up 1 times to write data ]
> >> [ perf record: Captured and wrote 0.783 MB perf.data.guest (23 samples) ]
> > What if user already gave some events in the command line?  I think you
> > need to check if "-e" or "--event" (and "--pfm-events" too) is in the
> > argv[] before adding these.
> 
> kvm_add_default_arch_event() would detect if user already sets events explicitly. If so, it won't add "cycles" event any more. Thanks.

Oh, ok.  I can see you called parse_options to check the option.
You'd better to check "--pfm-events" as well.

Thanks,
Namhyung

