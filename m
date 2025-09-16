Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6F275111
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008554; cv=none; b=cpD+SUyDlhQudEFaVnSE36kjJ0ElHKxXKCbc3nkhBbclrrtNm6kUOdnuCGkdiuJdeIk9tkekDzo2prR8CTw89eTfmn59qdbJ390+0brmJ8ngbZ2/BTdbfyH5Q3zt4GMMrkGpRDHx6sn67ivFN8okgZhdrDox912umDXQP6/NDG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008554; c=relaxed/simple;
	bh=NRUBIK6yL6+CmJm7whVUiCeOzNvGvSmxUXnZC9gySgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I37K6rKfngthOICM/Qa6w1d8t+4CqTA13gX4XzEm6Tqvzp16ZdD5YILDWC2RpVP4054XDBXj0Wo4qxAwe5qhIevpuUp26oRbLW64fCXVGLx7jcf1ayT9FjDoceOUUcg3FGRpCSVY7fJKRCD4p8p9K5V+gSkMrRyvvxvusZtUqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EqS9SBlE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EqS9SBlE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8sHRCjw7e9Pd75QxDAA6YpRMq4pTFEZknMvfD29JhSE=; b=EqS9SBlE80vGVB+xlDQMNuvMLV
	0fMuIOJTRGJ4WoNMyn+3AdSEjCOd6me78zIoQA0iOD0NvscxJd49pnTIZTEgt42ARaI6WDZ3y8S7z
	SBLHlAqRFtvoVNqyvFZXEFDVerPjCag7B2ITXdrREd9P6v9s83MVxSkEqu1y+FQd5SQIty5D/fxxG
	Vmdy54AML2uELeHK6us0F9F0RfxqMGyjcdBEr+8LXUH1+FW+GF6V5E+oSU4yO2InaB/q4N4DHs3ey
	aFNdNZ1IXIHr26GvZIx4rxnXVMquxgGsW1gh72uwDjaVuE1uK5NhndXG8Lys25qDbwn82Vam+yXb7
	CPHa5dhA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyQKQ-0000000HFZu-3FGb;
	Tue, 16 Sep 2025 07:42:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 522A8300134; Tue, 16 Sep 2025 09:42:17 +0200 (CEST)
Date: Tue, 16 Sep 2025 09:42:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
	akpm@linux-foundation.org, catalin.marinas@arm.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, kees@kernel.org, masahiroy@kernel.org,
	aliceryhl@google.com, ojeda@kernel.org,
	thomas.weissschuh@linutronix.de, xur@google.com,
	ruanjinjie@huawei.com, gshan@redhat.com, maz@kernel.org,
	suzuki.poulose@arm.com, zhanjie9@hisilicon.com,
	yangyicong@hisilicon.com, gautam@linux.ibm.com, arnd@arndb.de,
	zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com,
	coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com,
	luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org,
	wangjinchao600@gmail.com, yury.norov@gmail.com,
	thorsten.blum@linux.dev, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] watchdog: remove HARDLOCKUP_DETECTOR_PERF
Message-ID: <20250916074217.GF3245006@noisy.programming.kicks-ass.net>
References: <20250915035355.10846-1-cuiyunhui@bytedance.com>
 <aMfpwYPX6_i6ROOY@willie-the-truck>
 <20250915103506.GA3245006@noisy.programming.kicks-ass.net>
 <CAD=FV=Vr67+uRK2bYu34MDXRJN4w_VH_EO7OW4eVLJ3wqUUBog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Vr67+uRK2bYu34MDXRJN4w_VH_EO7OW4eVLJ3wqUUBog@mail.gmail.com>

On Mon, Sep 15, 2025 at 08:42:00AM -0700, Doug Anderson wrote:
> On Mon, Sep 15, 2025 at 3:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Sep 15, 2025 at 11:26:09AM +0100, Will Deacon wrote:
> >
> > >   | If all CPUs are hard locked up at the same time the buddy system
> > >   | can't detect it.
> > >
> > > Ok, so why is that limitation acceptable? It looks to me like you're
> > > removing useful functionality.
> >
> > Yeah, this. I've run into this case waaay too many times to think it
> > reasonable to remove the perf/NMI based lockup detector.
> 
> I am a bit curious how this comes to be in cases where you've seen it.
> What causes all CPUs to be stuck looping all with interrupts disabled
> (but still able to execute NMIs)? Certainly one can come up with a
> synthetic way to make that happen, but I would imagine it to be
> exceedingly rare in real life. Maybe all CPUs are deadlocked waiting
> on spinlocks or something? There shouldn't be a lot of other reasons
> that all CPUs should be stuck indefinitely with interrupts disabled...

The simplest one I often run into is rq->lock getting stuck and then all
the other CPUs piling up on that in various ways.

Getting stop_machine() stuck is also a fun one.

I mean, it really isn't that hard. If, as a full time kernel dev, you
don't get into this situation at least a few time a year, you're just
not doing your job right ;-)

> If that's what's happening, (just spitballing) I wonder if hooking
> into the slowpath of spinlocks to look for lockups would help? Maybe
> every 10000 failures to acquire the spinlock we check for a lockup?
> Obviously you could still come up with synthetic ways to make a
> non-caught watchdog, but hopefully in those types of cases we can at
> least reset the device with a hardware watchdog?

Now, why would I want to make the spinlock code worse if I have a
perfectly functional NMI watchdog?

> Overall the issue is that it's really awkward to have both types of
> lockup detectors, especially since you've got to pick at compile time.

Well, then go fix that. Surely this isn't rocket science.

> The perf lockup detector has a pile of things that make it pretty
> awkward and it seems like people have been toward the buddy detector
> because of this...

There's nothing awkward about the perf one, except that it takes one
counter, and some people are just greedy and want all of them. At the
same time, there are people posting patches that use the PMU for
page-promotion like things, so these same greedy people are going to
hate on that too.
