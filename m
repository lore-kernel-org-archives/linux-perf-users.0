Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07FE3A4505;
	Mon, 12 Oct 2026 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797873; cv=none; b=kRsog6yYJUpJ4WxhRFo/VawEo03afe0VZi2U95k5s5Z4IGpT8u04dxlsivAj/tEy7pflPGXh7zurHELDZLGwWqi7g6L7+WSC5iJTACgrtDHvGZyF1Ar66+ZrZ6HMu6NkoCPgudCWQH3tFX3KADhwuwRsgmNafDlF/WuyGNGbTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797873; c=relaxed/simple;
	bh=3KO2zrZQqRdD9YjsPoal8BLBSYxWEmDj4/ZBDvXs8xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixhxczqg65tSBAL5sFmKMCeWQ1HOkheBFWrMe5LWnUvg6gw5gjEFJNC+y8MwS+qfyvgvDNIc/f4DaHRJsJVKfnqN5ZjYe3GqrNa9pP8sKKA/s3PRonelmKaV4gN73JEVsJq0vjuCd1oTN4NHOAn8MmIG9aA4Sq15TsqqKG06e7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X1JtDlog; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P2uzdqiL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X1JtDlog";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P2uzdqiL"
Date: Mon, 12 Oct 2026 11:37:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791797870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4uJOodi+FZ4tJ1FsHukg1PiHCMKFXTy7eV6EJag2V4=;
	b=X1JtDlogZkmamoZfmYvV8E9ukSU4SOFcioN2yIXeYYB24WJ6Yxn9tCxxAetu8UHBVLsw0e
	gCuV276owqiyTLpF1GD+qOuB7fAgJlQszwFMkLNm1EFkPOx7ykphn1Ci13ilo8um0XYdWF
	3sz8wmvYWptPKfSVTSVJ+4Fiet4BUDGiOnNF7puNE2qnLM5cv/Fl6cVFbsEZgUN5WMx8fz
	if7vDJ6c8s7vaWB2Tk/auVWU0C+tdNB5NP5EQJg7V69oKFofNJn+DhdemeXIXw/BRZa2pC
	0A5DG4oIlR661HXk4D+0y82T44vdayUfY7pRMhXtnAldLUF5zqP0hhdJAQ/7BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791797870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4uJOodi+FZ4tJ1FsHukg1PiHCMKFXTy7eV6EJag2V4=;
	b=P2uzdqiLqfTDgK5G0ovUosQxYIMFr7B0OsSKeZgORmENnC+i+EwPk0edwJ9QAnTiBo4lyR
	95x+NUQJUqPVRRDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] ARM, ARM64, LONGARCH, XTENSA: Delay HW BP
 notification to task_work()
Message-ID: <20261012093749.aPWUGJ1a@linutronix.de>
References: <20261012090431.TF3iVDsk@linutronix.de>
 <sashiko-outbox-167891@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-167891@kernel.org>

On 2026-10-12 09:18:30 [+0000], sashiko-bot@kernel.org wrote:
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -215,6 +215,10 @@ struct hw_perf_event {
> >  
> >  	/* Last sync'ed generation of filters */
> >  	unsigned long			addr_filters_gen;
> > +#ifdef ARCH_NEED_PERF_HW_NOTIFY
> > +	struct callback_head		arch_hw_notif;
> > +	int				arch_hw_notif_busy;
> > +#endif
> 
> [Severity: Critical]
> Does this cause an ABI mismatch and One Definition Rule violation across
> the kernel?

So you learned a new thing.

> The ARCH_NEED_PERF_HW_NOTIFY macro is defined in architecture-specific
> headers like arch/arm64/include/asm/hw_breakpoint.h, but it is used here
> in the generic include/linux/perf_event.h header.
> 
> Because linux/perf_event.h does not universally include asm/hw_breakpoint.h,
> translation units that include linux/perf_event.h without previously
> including the architecture hardware breakpoint header will evaluate
> struct hw_perf_event without these fields. Since struct hw_perf_event
> is embedded in struct perf_event, this alters the size and member offsets
> of struct perf_event across different subsystems.
> 
> Can this lead to memory corruption when perf_event objects are passed
> between translation units with mismatched struct definitions? Should these
> conditional fields be driven by a globally visible Kconfig symbol instead?

This header file includes the mentioned header files defining
ARCH_NEED_PERF_HW_NOTIFY. The condition upon which the header file is
included does not change while the kernel is built. This could be moved
to Kconfig but I don't see the need for this.

Sebastian
