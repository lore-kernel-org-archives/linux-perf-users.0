Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E69E2E3700
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753508162; cv=none; b=nvLuSSN/C+grnCyBct5krDG2PKJxbxebMDDhNhVxaVP0IJs8YIQhlGTonNVmX/0TvegJPeMjzXM8x2sWDkY3m26lLNNZiDaxSEF8cKTxzK+Yl2XN38bGWdhCyIB/nPb+67JKGufaP5LbyOp8gxCFGHYUFMw4iCa1VTJ0xda/2p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753508162; c=relaxed/simple;
	bh=KpuHAGLwdBMZ0ATmyZUxTQrLKtkOSLIsA5zSg6harAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8B5ScnD5wB0fkQdtHYBoiEc9tzwVMJfzGRzPORwO8YUoMfZrfboX1bfCy2RU/a/Z7EunH9g9KYiFtkhwXJ8WyRcyoOZFyRyb1HHylKCcGfb2NTCQdDlju4cEBlAY//Z9BoCNUTFFbfeNuUIYnos3tp1/F6XSryxZn2aCBr4Yok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+r9j1bG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+r9j1bG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB395C4CEED;
	Sat, 26 Jul 2025 05:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753508162;
	bh=KpuHAGLwdBMZ0ATmyZUxTQrLKtkOSLIsA5zSg6harAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+r9j1bG7NM6uth8wweOVHBcXa8FYuOWP6K1x2TmJICkmaFBvxAmu86aob0T56BUU
	 LL6vNO+OWX3JmcSGlAh0NFrlcCbbEVw5JTl+YeDMLknECZn/RpfuMZuLkGJQAksCVu
	 DsjD1ApQNM6lSrPgC7ZAp97ataGFkc5YaM8QpITYrk3IfIAn/QdB8saSH/acEIrFRo
	 J5Gxhi7KCWIHG0C8INkxNwTrLhRAGxg7EGfRaNl27WI6obHtuKWUV4htfJGciL4pMm
	 de+ViHqEZ8Jf5XmB1Vl2i1KB14KbIZAgTNaez5Pup7vL9hC3puL00Nepafytz7Va/v
	 b5bjjbpjJ7JPQ==
Date: Fri, 25 Jul 2025 22:35:59 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jan Polensky <japo@linux.ibm.com>
Cc: adrian.hunter@intel.com, irogers@google.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] perf test: Increase load in lock contention
 test on low-activity systems
Message-ID: <aIRpP_LpVAWXv7o7@google.com>
References: <20250709203809.3211178-1-japo@linux.ibm.com>
 <aHgCmxEZ_bcNeki-@google.com>
 <aIOvdQ003hRqFEH1@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIOvdQ003hRqFEH1@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>

On Fri, Jul 25, 2025 at 06:23:17PM +0200, Jan Polensky wrote:
> Hello Namhyung,
> On Wed, Jul 16, 2025 at 12:50:51PM -0700, Namhyung Kim wrote:
> > Hello,
> > On Wed, Jul 09, 2025 at 10:38:09PM +0200, Jan Polensky wrote:
> > > On low-activity systems, the 'kernel lock contention analysis test'
> > > often fails due to insufficient system load. To address this, the test
> > > now increases load by using multiple groups and threads in 'perf bench
> > > sched messaging', scaled to the number of available CPUs.
> > >
> > > Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> > > ---
> [skip]
> >
> > More importantly, there are several instances of this workload.
> > Probably we want to change all of them by introducing a shell variable.
> You're right — introducing a shell variable makes sense, especially since
> there are 13 identical calls. However, I’m slightly concerned that this
> might reduce readability. We might also consider an alternative solution
> to avoid this.

We already have similar code in other places like record.sh.

Thanks,
Namhyung


> > But I'm a bit afraid how much overhead it'd bring up.
> Indeed, using the --group parameter on large systems can lead to issues.
> For example:
> 
>     [root@localhost perf]# ./perf stat -- perf bench sched messaging --group $(nproc) --thread
>     # Running 'sched/messaging' benchmark:
>     perf: socketpair(): Too many open files
> 
> To avoid this, I suggest following the approach proposed by Thomas
> Richter (tmricht@linux.ibm.com), using the -p (pipe) mode instead:
> 
>     perf bench sched messaging -p
> 
> The pipe-based solution generates sufficient load and lock contention for
> the test, while avoiding the use of sockets and their associated file
> descriptor limits.
> 
> I’ll incorporate these changes and send the next version shortly.
> 
> Thanks again for your feedback – it's much appreciated.
> 
> Best regards,
> Jan
