Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351682FFFA5
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930096; cv=none; b=fdvJ6UFLKclxCUL44KDyFjkKFKyFuqIcRxVkxctsgTtSbsNK/0LKwBQPcT6OKLSUo6+0I0/sXPi0YPmFLo5o3E+wCxwEDVN6XiCphjNh3pK+gK8FnY4uE8RR9y7CzQvSwjolR8o8aUk1xnPKOCfU+7aC4rVwM1WF79QX3jM0JSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930096; c=relaxed/simple;
	bh=JH7txACGqpu70QrcZpv7eK5Fjn8nvkBMvawjfClTs2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m58qUYuSyiHDIck7l3RWqa26D8oejRU+bwocb1fNYAVbvuQtOui27ezv23R+P1tmTmBS96Ww3A6an+H5/TNhCxwALm+Wdc/uajlOCEuc/VcjFASQDpL1n/IKvv/2ToJ8eg+ehMvVps9Z7bSNnvXw+j/rUXhjNKbfoZfOihTJdAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mwe7op7I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=51KCtvsy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mwe7op7I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=51KCtvsy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mwe7op7I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="51KCtvsy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mwe7op7I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="51KCtvsy"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A5D42246A;
	Fri, 31 Oct 2025 17:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761930092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlF5qBf4juZSf4H9c9EQslASU5Ma+rHdW8yMnK4XpM8=;
	b=mwe7op7IGWBd2T1yWkm9oFJ8gaPQgMPXXdpjrt1xjC8yVxCvWnK3PS61Xog73EZaXu184c
	iE+yz6Sje034eiGaENL1ULEcHtnE90mECVwISIoT5+dpBYsE6N/U//XBEWO5HE8FIGa+PM
	fWwW7Up4uwImk2se7lW9VidJYROr5rM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761930092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlF5qBf4juZSf4H9c9EQslASU5Ma+rHdW8yMnK4XpM8=;
	b=51KCtvsyD/VdKcctilOcFtSx25D1O7YVJCsbx9V6MtRBWYM/kA6AdhasBJyCnTwAIsCanK
	DSSXiqQUxPUrs9CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761930092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlF5qBf4juZSf4H9c9EQslASU5Ma+rHdW8yMnK4XpM8=;
	b=mwe7op7IGWBd2T1yWkm9oFJ8gaPQgMPXXdpjrt1xjC8yVxCvWnK3PS61Xog73EZaXu184c
	iE+yz6Sje034eiGaENL1ULEcHtnE90mECVwISIoT5+dpBYsE6N/U//XBEWO5HE8FIGa+PM
	fWwW7Up4uwImk2se7lW9VidJYROr5rM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761930092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlF5qBf4juZSf4H9c9EQslASU5Ma+rHdW8yMnK4XpM8=;
	b=51KCtvsyD/VdKcctilOcFtSx25D1O7YVJCsbx9V6MtRBWYM/kA6AdhasBJyCnTwAIsCanK
	DSSXiqQUxPUrs9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EC5213393;
	Fri, 31 Oct 2025 17:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dgonFGvrBGlDIgAAD6G6ig
	(envelope-from <tonyj@suse.de>); Fri, 31 Oct 2025 17:01:31 +0000
Date: Fri, 31 Oct 2025 10:01:27 -0700
From: Tony Jones <tonyj@suse.de>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: addr2line performance
Message-ID: <aQTrZ54mkx14r_cQ@suse.de>
References: <aPkivW2WoySU1Zkc@suse.de>
 <CAP-5=fU4y2y+pOT590GZG-A+zO5YdAAzUyPgUX5RTji0nh6Z+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU4y2y+pOT590GZG-A+zO5YdAAzUyPgUX5RTji0nh6Z+g@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Wed, Oct 29, 2025 at 08:51:12AM -0700, Ian Rogers wrote:
> 
> I'm not sure there is an explicit discussion rather than discussion on
> individual patch sets. 

Thanks for the reply.  I thought the original comment in that BZ
was talking about plans to remove the current forking of an "addr2line"
process and communicating via pipe with some library implementation.
Of course what that library would be if not BFD/LLVM was my question.
Clearly this was a misread on my part.

I'd seen the patches related to dlopen'ing llvm, backporting this is 
a possibility since we don't want a rpm requires.

Cheers!

Tony

-- 
Tony Jones
SUSE Kernel Performance Team
