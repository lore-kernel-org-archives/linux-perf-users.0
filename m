Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F712CDBE;
	Fri,  6 Jun 2025 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749230964; cv=none; b=X4aPaGBwgmfpYhjp8OyUXN+wW5imUS00cD9T4L277AkOKG6S5MXITt7yM/pVapDjaAE5Tn1hx6RJQPXFWcMNcrMD+p/Cc8fAzpWr1rcVaWZS2Alvn4L4CPgsT6j8bY25DyZ0L0jpn0mMWtkJoXfJEdDoovVMP266+n2+ujCa3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749230964; c=relaxed/simple;
	bh=V/cpUhfftxSgEKkgVpLpoJFamzINkyavrZoLmAupKCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7Z7/VfMfI1Kqct+6VGA6lSZvrU7tz+0SIkODZKhK8oTsWvxOBhA/lPG5JbLsEgrGlUt2X3ZgA4rlDIPyO4hi6iqcQ3HEE5VoC7s2OrOTYuFnkt6ZE4Tr3iNa24yMjLEOqnLGgBuQzOkMSuwfvx+LbeWOr+Jh4+RMylnelbL6nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRACbj0m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRACbj0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113D1C4CEEB;
	Fri,  6 Jun 2025 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749230963;
	bh=V/cpUhfftxSgEKkgVpLpoJFamzINkyavrZoLmAupKCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iRACbj0mcsWq901qlWS7gff7keJTsDjJPrBIZr0CWwXS6qbA9JWVHH8zzoj8xX2EA
	 hlTgBT8ZwfSWE7krInaNE78H8+Pj/aFa3Gklx1xpyjxge2z5EU6nU1cmiuuog5qMwl
	 yHRvn2rJJCkGudAvNKjwwEYnG14jSRK2RxmWbWkVCQsnmmRjennzdwboV9325S98P0
	 gsjobZqdZ+IdeyiRt01+MDDxbimV+VMuzcgVYthS/uWwyGpGJtsxqDXMsOli6QSjjW
	 /3kIOIJlwGWNRdnIOZwdIxVFzXpvEBlfkW1Spnd3rIOasNkLfwCGGQbfWFQDeQ9Jlq
	 cWt0/6wgGvh/A==
Date: Fri, 6 Jun 2025 10:29:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH RESEND] perf stat: Fix JSON output formatting in
 iostat_prefix()
Message-ID: <aEMlcf02v1kpNVEa@google.com>
References: <20250605180012.16788-1-suchitkarunakaran@gmail.com>
 <aEJnQIviayEi-Jsv@google.com>
 <CAO9wTFhyQnE2hgvtQuYxfCTjd7iRHJN5O+v3wka7smDkrUX1GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO9wTFhyQnE2hgvtQuYxfCTjd7iRHJN5O+v3wka7smDkrUX1GA@mail.gmail.com>

On Fri, Jun 06, 2025 at 10:04:17AM +0530, Suchit K wrote:
> On Fri, 6 Jun 2025 at 09:27, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Thu, Jun 05, 2025 at 11:30:11PM +0530, Suchit Karunakaran wrote:
> > > The iostat_prefix() function previously included a TODO noting that its output
> > > format was incorrect in JSON mode. This patch corrects that by conditionally
> > > formatting the prefix string based on the output mode specified in
> > > perf_stat_config.
> >
> > I've tested this.  It doesn't work well.
> >
> > Before:
> >   # ./perf iostat -j -I 1000 true
> >   #          time    port              0.000517525 0000:00 "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
> >        0.000517525 0000:80
> >        0.000517525 0000:17 , "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
> >        0.000517525 0000:85
> >        0.000517525 0000:3a , "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
> >        0.000517525 0000:ae
> >        0.000517525 0000:5d , "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
> >        0.000517525 0000:d7
> >
> >
> > After:
> >   # ./perf iostat -j -I 1000 true
> >   #          time    port         "interval" : 0.000463559, "device" : "0000:00""Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
> >   "interval" : 0.000463559, "device" : "0000:80"
> >   "interval" : 0.000463559, "device" : "0000:17", "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
> >   "interval" : 0.000463559, "device" : "0000:85"
> >   "interval" : 0.000463559, "device" : "0000:3a", "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
> >   "interval" : 0.000463559, "device" : "0000:ae"
> >   "interval" : 0.000463559, "device" : "0000:5d", "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
> >   "interval" : 0.000463559, "device" : "0000:d7"
> 
> Hi Namhyung,
> Thanks for testing it. Could you please tell what could be improved?

I think it should show a valid JSON.  Something like this?

  # ./perf iostat -j -I 1000 true
  {"interval" : 0.000463559, "device" : "0000:00", "Inbound Read(MB)" : "0", ...}
  {"interval" : 0.000463559, "device" : "0000:80", "Inbound Read(MB)" : "0", ...}
  {"interval" : 0.000463559, "device" : "0000:17", "Inbound Read(MB)" : "0", ...}
  {"interval" : 0.000463559, "device" : "0000:85", "Inbound Read(MB)" : "0", ...}
  ...

Thanks,
Namhyung

