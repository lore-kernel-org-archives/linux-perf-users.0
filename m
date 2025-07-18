Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7BE29993E;
	Fri, 18 Jul 2025 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839285; cv=none; b=i7xIoE+VbWR4fDiqSerFvQcdRiuKIpcK9yKBfQvG6kf9jJLtPESIbn6TH/cwW/OBlhskqbsvsgnr07vXun3xiAcEnkjvVKQjXgUhtTwcGZ2h/U3tdNwZOAeNzefaL9dgjGUy2bpkG8SjbCIbnhUs6KExkegKuZZDNuS1yz5c7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839285; c=relaxed/simple;
	bh=EGtRkZ5U82Aqv6qxflDEOWj/WYCMX9s2gIGAP/sSaY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amanwOjJFK5xXA9hMYo4DfJi2gaRMPxPQxrUOwtjjJZUpEa7evMuEhcsMSYVzMi0EVr4oqXicxeVl9Vrb135vfH4AwQEWkMRw6JObyOeBzEudvDHIKaX2LKGlgcX2W7HKIknFGadpiqez0v+Jv9wO7+xc2caWKQfLk0WjDFLZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=uFmmKuoJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eldWWJRZ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="uFmmKuoJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eldWWJRZ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B495D7A0179;
	Fri, 18 Jul 2025 07:48:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 18 Jul 2025 07:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752839280;
	 x=1752925680; bh=TixgCXnBJyIqXhUnfdaZUNI3oOckDeciyEbiH83Iars=; b=
	uFmmKuoJEFwkN9w9M9/KALI1tOWTBpMQ8X/YdhGWRYGR3HGR4zqJ+4mY/tIKA3lz
	K6JrpnqzBdvKVIYidiMRdUqDHN6T6KPghwGKXx20z2yelscyUKa20DEnpt7n/tH9
	CGw+h8+hAuNvaa342DoVxb60Mw84wSMXUx8G4AxQAKdW7BNw98/lea+dtbBl1XLC
	+bgQ65qPFimTkJJr4hDAcPpzfmSVbkAyqdyR4QG+tBBdl8CxYjPVHBsjIn23mcoz
	TYn2mWwmgFNBFGCgD2aVhNWvzR9BfEiF03NasySj1XNe19qIo3wn2X93PVucLVuu
	ZmNx/fIqaZW+6myHuXm+9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752839280; x=
	1752925680; bh=TixgCXnBJyIqXhUnfdaZUNI3oOckDeciyEbiH83Iars=; b=e
	ldWWJRZXpycMZO4g1g39yKpaQe4dgQXLaQGyT6tqokPvwoW3rpoMmsF5Vd9sFJGq
	vP4f0WtEHgl9uxtlZJWxTTWenQibeTqZKhw4sN/O5xRUBK8YjFWnNMrMNlH3FHGF
	ZLp771oROhYm2T3DvXqoHsadk3ZbOdlT2Um2SWGY2E8lhXBEtJOFatDH5BHk7pgS
	2SMHVGrhC0BFn4f/oMc7oV73ls3T2KyQIK1M3LhWzWRIYgq9RaGT1PgiZU4UJGHk
	7ZneWgbUWSrqTA1MXertkoE0F7fwi8feaD36omUaoPzu0ZP+a6OCteeznWVfUfZe
	6AvHpS3c1+g7gs+gqkNzA==
X-ME-Sender: <xms:bzR6aPzxyY2UNeMJMGctEQygJEaZpk_wTgmHDOg7BUhXYKQQvV7R4A>
    <xme:bzR6aNm4Hf6eVe8bC4D5bOvJJB-2S8LojTuKSnCc-ajRQOtiRWkQNe69_FGvrWu6C
    OO_4M2ZFoC1oA>
X-ME-Received: <xmr:bzR6aPUfU246mSVlmguOvaxZqnuOHTeT_Kt6V6a426DYR7lt3yCMFqG_kcNvuRnIxYIO8GzzaJm2AXb0XUX1sgsBMDF5MF_7H8TRdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpefgkeffieefieevkeelteejvdetvddtledugfdvhfetjeejie
    duledtfefffedvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepfeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsrhgrkhgvrhdrnhhoohgsrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthho
    pegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrmhhhhihunhhgsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtgho
    mhdprhgtphhtthhopegrlhgvgigrnhguvghrrdhshhhishhhkhhinheslhhinhhugidrih
    hnthgvlhdrtghomhdprhgtphhtthhopehjohhlshgrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehirhhoghgvrhhssehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:bzR6aG1a8_Jm7Z8PUhNrDsZL5pCj7eKkHIb7QyugE8solOeclK9auw>
    <xmx:bzR6aHkDuDVEqwmM5eITZ9M2qrK9K7o4Z9WmsX4bRINhozKz6G-JqA>
    <xmx:bzR6aFFp9e_sb1F9vkWseJ2Pirf7iiUH8t5hzcGtkQchrbGUNF1KIg>
    <xmx:bzR6aMlJDfoAuTxePBe-o703q2Q8C3aTQBK0FGDCTzEumq-pTX_31A>
    <xmx:cDR6aDCkJWPN7o5mNZCTZ-VzGM-vKzYy8K1Fs4TBu73yW5ciCzf9ghRb>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 07:47:59 -0400 (EDT)
Date: Fri, 18 Jul 2025 13:47:56 +0200
From: Greg KH <greg@kroah.com>
To: Rujra Bhatt <braker.noob.kernel@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, vgupta@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] arc:kernel:perf_event.c : replaced sprintf with
 sysfs_emit()
Message-ID: <2025071801-driveway-curly-698c@gregkh>
References: <aGjUpI1yNjEhSiAq@brak3rDesk>
 <CAG+54DZQC+-6E-P3D4BUtVujNegL1qKpcB5SGh28+rX5hrHFiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG+54DZQC+-6E-P3D4BUtVujNegL1qKpcB5SGh28+rX5hrHFiw@mail.gmail.com>

On Fri, Jul 18, 2025 at 03:57:20PM +0530, Rujra Bhatt wrote:
> Hi,
> 
> On Sat, Jul 5, 2025 at 1:00 PM Rujra Bhatt <braker.noob.kernel@gmail.com> wrote:
> >
> > Replaced sprintf() with sysfs_emit() in sysfs*_show() function in
> > perf_event.c file to follow the kernel's guidelines from
> > documentation/filesystems/sysfs.rst
> > This will improve consistency, safety, and makes it easier to maintain
> > and update in future.
> >
> > Signed-off-by: Rujra Bhatt <braker.noob.kernel@gmail.com>
> > ---
> >  arch/arc/kernel/perf_event.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
> > index ed6d4f0cd621..424ec072c441 100644
> > --- a/arch/arc/kernel/perf_event.c
> > +++ b/arch/arc/kernel/perf_event.c
> > @@ -648,7 +648,7 @@ static ssize_t arc_pmu_events_sysfs_show(struct device *dev,
> >         struct perf_pmu_events_attr *pmu_attr;
> >
> >         pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> > -       return sprintf(page, "event=0x%04llx\n", pmu_attr->id);
> > +       return sysfs_emit(page, "event=0x%04llx\n", pmu_attr->id);
> >  }
> >
> >  /*
> > --
> > 2.43.0
> >
> 
> Gentle reminder for the replacement of sprintf() with the sysfs_emit(), kindly
> review it.

Why is this required?  There is no bug in the current code, so no need
to change it at all.  Please just use sysfs_emit() for new sysfs files,
no need to churn the tree and change all existing entries, otherwise we
would have done this a long time ago when we introduced these functions.

thanks,

greg k-h
