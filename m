Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107C7284B58
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767911856; cv=none; b=ewllJtNnMwpU2eTziryB5sMndbqNc7J/ZFF4U+T5jgQd5mJkkYeoJfDSC80jIumH6wh/RAjIUvlsR/sQxEIPjEzutHRpwOy9kF79q/4M8UtiM84FgS3u2kFpjSzclektXh1lEEdTbQc05tjL+moyyc9DjLv3eIaqBLzoC8eXShk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767911856; c=relaxed/simple;
	bh=ezrR5tTZ4SQ/2obvD0LU3f0y3h4eCAU21kEmdOcjvJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifkm7WMd5+lsHYIvOPSXk+zVpvi2q1ORLB57M+q7AM6xcmDq4ZV8k98ICuyCY4/0s6T+Ga34YsLhKaXnfHBBXAGN7i9Pr7nwtMluSPdnb4XcqyGPuw2OSbtibfHjUdNkKEw0KOSvUH0FgEuDAQ/stg9vpcff2R0yUGBjazaJcHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ff+CfPOd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m12XfyH5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ff+CfPOd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m12XfyH5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ff+CfPOd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m12XfyH5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ff+CfPOd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m12XfyH5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 296CC5C66B;
	Thu,  8 Jan 2026 22:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767911853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KphhVK5ByXh70IvkaTPteYZOXkAaUES4Hwv1H1n0vaE=;
	b=ff+CfPOdVVzMFZ7LlTAqTWq34s2Hw9ZpcrZKWcLql5jLeXM4YFJpYUB5/vd6aqdFTcbrBM
	bREpn9t2zosC4Mb/sqiOMXWD+EY7gfeCMvGxlwD/HlkoKW1y6wAQYH6ZHE/33C7WraZY9w
	eEZ5DxKqKWkVoWF2fhBMe6+R/YDY27M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767911853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KphhVK5ByXh70IvkaTPteYZOXkAaUES4Hwv1H1n0vaE=;
	b=m12XfyH5ZS7iJvP7/QtiDtGaNrFSEY/nLTinZxs0C5noCv7Q9iTE86LPvxNGmBJpswEw62
	cWunShiQQYRM+WCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ff+CfPOd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=m12XfyH5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767911853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KphhVK5ByXh70IvkaTPteYZOXkAaUES4Hwv1H1n0vaE=;
	b=ff+CfPOdVVzMFZ7LlTAqTWq34s2Hw9ZpcrZKWcLql5jLeXM4YFJpYUB5/vd6aqdFTcbrBM
	bREpn9t2zosC4Mb/sqiOMXWD+EY7gfeCMvGxlwD/HlkoKW1y6wAQYH6ZHE/33C7WraZY9w
	eEZ5DxKqKWkVoWF2fhBMe6+R/YDY27M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767911853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KphhVK5ByXh70IvkaTPteYZOXkAaUES4Hwv1H1n0vaE=;
	b=m12XfyH5ZS7iJvP7/QtiDtGaNrFSEY/nLTinZxs0C5noCv7Q9iTE86LPvxNGmBJpswEw62
	cWunShiQQYRM+WCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AC853EA63;
	Thu,  8 Jan 2026 22:37:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZT91D6wxYGnLHgAAD6G6ig
	(envelope-from <tonyj@suse.de>); Thu, 08 Jan 2026 22:37:32 +0000
Date: Thu, 8 Jan 2026 14:37:24 -0800
From: Tony Jones <tonyj@suse.de>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf addr2line: Add a libdw implementation
Message-ID: <aWAxpIBX4mddAdBm@suse.de>
References: <20251122093934.94971-1-irogers@google.com>
 <aSdGq2K6TRMyG009@google.com>
 <CAP-5=fULHMCw=b0PuN07r=aAjoamb+MNSNrHM3nyHPYM2DGkow@mail.gmail.com>
 <f85dacc5-5d81-4ee7-acf3-8aa053c42dab@linaro.org>
 <aTtVO7Iykc8oTl8c@suse.de>
 <CAP-5=fUbZ1pjvcbF0do8BrC0NAzkOJeQUAozQhXKpGuosrW3ew@mail.gmail.com>
 <aTxECtpK3wdxd9uI@suse.de>
 <CAP-5=fUd95Hw8opxtCA+5aO5-6V6_Y0FMPOCCSmfwsDP6YnzeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUd95Hw8opxtCA+5aO5-6V6_Y0FMPOCCSmfwsDP6YnzeQ@mail.gmail.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 296CC5C66B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Thu, Jan 01, 2026 at 12:17:08PM -0800, Ian Rogers wrote:
> On Fri, Dec 12, 2025 at 8:34 AM Tony Jones <tonyj@suse.de> wrote:
> >
> > On Thu, Dec 11, 2025 at 09:20:35PM -0800, Ian Rogers wrote:
> > >    Thanks Tony, those are great performance numbers! I'm wondering now:
> > >     - do we want to land addr2line with libdw given the wrong file/line#
> > >    problems or wait for a fix?
> > >     - do we want to make the addr2line configurable like with objdump [1] to
> > >    mitigate the problem above?
> >
> > I think we should spend a bit more time understanding the former before
> > doing the later.  If only to provide some documentation on why there
> > is a deviance to explain the configurability.
> 
> Thanks Tony, did you get a chance to look at this?

Not yet, maybe next week.  It didn't feel like a time critical issue
and I had other more pressing things to look at.

-- 
Tony Jones
SUSE Kernel Performance Team
