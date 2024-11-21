Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DBD1D47A3;
	Thu, 21 Nov 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201140; cv=none; b=mGt60PBixg+zwMjZe5Sexp/rqZ85/C8oMDs68KLy+KEglRk78v0bHv1047iyHVkXwNQfwT8UE1+MoKMMa+ND3uNH8fGLC3OljyVljLoQe/jN+oWVAcskVR1MqBI7DqAdJaVA7K8sdSSP20i266kIHmhAQTZndn2A26QMVPM8+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201140; c=relaxed/simple;
	bh=IMRV+yVO+Sf3c1V5tZa1floKCs3jCS1HMm2ZVQE8KBE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9d4inPaT8+mXCE+MtXuhjdOOiYSpR07kLDgpGc82+nrPon73u2bhndQwQPU6pWoWjk7sEzSzRRvcnZC5AZhDx4ctHbGXMfl+LlCQwbNFlRGRsytZ0m3pxBTPegzodGcmqgRRl4dptMyblq9w47SdPNi15xMSUj1uMNeWjDFGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvLr75Mdtz6J6pZ;
	Thu, 21 Nov 2024 22:55:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C9B8140133;
	Thu, 21 Nov 2024 22:58:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 15:58:53 +0100
Date: Thu, 21 Nov 2024 14:58:52 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <tongtiangen@huawei.com>, Yicong Yang
	<yangyicong@huawei.com>, Niyas Sait <niyas.sait@huawei.com>,
	<ajayjoshi@micron.com>, Vandana Salve <vsalve@micron.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Huang Ying <ying.huang@intel.com>
Subject: Re: [RFC PATCH 0/4] CXL Hotness Monitoring Unit perf driver
Message-ID: <20241121145852.00000460@huawei.com>
In-Reply-To: <Zz9Cq4CPStYGZyt7@PC2K9PVX.TheFacebook.com>
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
	<Zz9Cq4CPStYGZyt7@PC2K9PVX.TheFacebook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 21 Nov 2024 09:24:43 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Thu, Nov 21, 2024 at 10:18:41AM +0000, Jonathan Cameron wrote:
> > The CXL specification release 3.2 is now available under a click through at
> > https://computeexpresslink.org/cxl-specification/ and it brings new
> > shiny toys.
> > 
> > RFC reason
> > - Whilst trace capture with a particular configuration is potentially useful
> >   the intent is that CXL HMU units will be used to drive various forms of
> >   hotpage migration for memory tiering setups. This driver doesn't do this
> >   (yet), but rather provides data capture etc for experimentation and
> >   for working out how to mostly put the allocations in the right place to
> >   start with by tuning applications.
> > 
> > CXL r3.2 introduces a CXL Hotness Monitoring Unit definition. The intent
> > of this is to provide a way to establish which units of memory (typically
> > pages or larger) in CXL attached memory are hot. The implementation details
> > and algorithm are all implementation defined. The specification simply
> > describes the 'interface' which takes the form of ring buffer of hotness
> > records in a PCI BAR and defined capability, configuration and status
> > registers.
> > 
> > The hardware may have constraints on what it can track, granularity etc
> > and on how accurately it tracks (e.g. counter exhaustion, inaccurate
> > trackers). Some of these constraints are discoverable from the hardware
> > registers, others such as loss of accuracy have no universally accepted
> > measures as they are typically access pattern dependent. Sadly it is
> > very unlikely any hardware will implement a truly precise tracker given
> > the large resource requirements for tracking at a useful granularity.
> > 
> > There are two fundamental operation modes:
> > 
> > * Epoch based. Counters are checked after a period of time (Epoch) and
> >   if over a threshold added to the hotlist.
> > * Always on. Counters run until a threshold is reached, after that the
> >   hot unit is added to the hotlist and the counter released.
> > 
> > Counting can be filtered on:
> > 
> > * Region of CXL DPA space (256MiB per bit in a bitmap).
> > * Type of access - Trusted and non trusted or non trusted only, R/W/RW
> > 
> > Sampling can be modified by:
> > 
> > * Downsampling including potentially randomized downsampling.
> > 
> > The driver presented here is intended to be useful in its own right but
> > also to act as the first step of a possible path towards hotness monitoring
> > based hot page migration. Those steps might look like.
> > 
> > 1. Gather data - drivers provide telemetry like solutions to get that
> >    data. May be enhanced, for example in this driver by providing the
> >    HPA address rather than DPA Unit Address. Userspace can access enough
> >    information to do this so maybe not.
> > 2. Userspace algorithm development, possibly combined with userspace
> >    triggered migration by PA. Working out how to use different levels
> >    of constrained hardware resources will be challenging.  
> 
> FWIW this is what i was thinking about for this extension:
> 
> https://lore.kernel.org/all/20240319172609.332900-1-gregory.price@memverge.com/

Yup. I had that in mind. Forgot to actually add a link.

> 
> At least for testing CHMU stuff. So if anyone is poking at testing such
> things, they can feel free to use that for prototyping. However, I think
> there is general discomfort around userspace handling HPA/DPA.
> 
> So it might look more like
> 
> echo nr_pages > /sys/.../tiering/nodeN/promote_pages
> 
> rather than handling the raw data from the CHMU to make decisions.

Agreed, but I think we are far away from a point where we can implement that.

Just working out how to tune the hardware to grab useful data is going
to take a while to figure out, let alone doing anything much with it.

Without care you won't get a meaningful signal for what is actually
hot out of the box. Lots of reasons why including:
a) Exhaustion of tracking resources, due to looking at too large a window
   or for too long.  Will probably need some form of auto updating of
   what is being scanning (coarse to fine might work though I'm doubtful,
   scanning across small regions maybe).
b) Threshold too high, no detections.
c) Threshold too low, everything hot.
d) Wrong timescales. Hot is not a well defined thing.
e) Hardware that won't do tracking at fine enough granularity.

> 
> 
> > 3. Move those algorithms in kernel. Will require generalization across
> >    different hotpage trackers etc.
> >   
> 
> In a longer discussion with Dan, we considered something a little more
> abstract - like a system that monitors bandwidth and memory access stalls
> and decide to promote X pages from Y device.  This carries a pretty tall
> generalization cost, but it's pretty exciting to say the least.

Agreed that ultimately we'll end up somewhere like that.
These units are just a small part of what is needed in total.

> 
> Definitely worth a discussion for later.
> 
> >
> > So far this driver just gives access to the raw data. I will probably kick
> > of a longer discussion on how to do adaptive sampling needed to actually
> > use these units for tiering etc, sometime soon (if no one one else beats
> > me too it).  There is a follow up topic of how to virtualize this stuff
> > for memory stranding cases (VM gets a fixed mixture of fast and slow
> > memory and should do it's own tiering).
> >  
> 
> Without having looked at the patches yet, I would presume this interface
> is at least gated to admin/root? (raw data is physical address info)

That's certainly the intent. It's not going upstream in this form so
I haven't actually checked yet :)  Uses similar infrastructure to ARM
SPE which can also give physical address info + a lot more than that.

Jonathan



> 
> ~Gregory
> 

