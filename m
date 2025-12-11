Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D43B8D45
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Dec 2025 23:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765496134; cv=none; b=XCvWSHTui97eWXzZJjpB4Xz3YetDnHh4ttC8Gg1WRx4+Z93xnOXPwjFEe6gomp8IEKn2gK8MK+8jVAGkzmNNQGkhIfNtf23W0hRkhQqDKPXVmUsCeTz5ytqxjFH88a+PlloT7JWFLGM1iGP44RkFNUOKR7qbfXUwFnXP2gNHeWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765496134; c=relaxed/simple;
	bh=rhk0wmqIl3Ez6zAmquakRwT+9CgEeT24rBcNKBK/oJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LduLAQW0IKWBmq9ujuvAtU/ucuP4ELxvjEa26cRTEpQrm/omhDyDB9Q1ZG7k/MiL4WEcNrvWL++4BRITHEVK7vExeUwBYkGev5V8RQNFZNV2Gr4/Uu1WZrNXyEhzwCXt7Wj3xW7LuKzTKK+0hn8oxQ+vQ4fnsltRerlo4rpjG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OzcggnDX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FO0SuX7C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OzcggnDX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FO0SuX7C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OzcggnDX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FO0SuX7C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OzcggnDX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FO0SuX7C"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE96F5BCE0;
	Thu, 11 Dec 2025 23:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765496130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IPcy33/DuUzyPTg2Je9aEmCXF4TRhB6WwhLLNSHoHPU=;
	b=OzcggnDXWRlpNT3WWS5ZfLfEYNJRHwKSjSSjYuNEY293JKuURhRXrddt8TxL34DWLW6DyG
	36V5+rvJALRJufERunyCsR4HNBgQOeAibfd/0Py+YC4Vqu1k7zFJ1HYmh0VCv23R72DYlB
	zIiea7zsmcoQ4uI0bfG5q3/pDhUta2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765496130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IPcy33/DuUzyPTg2Je9aEmCXF4TRhB6WwhLLNSHoHPU=;
	b=FO0SuX7CsElxsTLbEZyRNr+KeI6xr6jWXPl+81j9fXu6qF6QOji65CcNKS4PDHHLVbUH4l
	j//++PPWyLNCbsAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765496130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IPcy33/DuUzyPTg2Je9aEmCXF4TRhB6WwhLLNSHoHPU=;
	b=OzcggnDXWRlpNT3WWS5ZfLfEYNJRHwKSjSSjYuNEY293JKuURhRXrddt8TxL34DWLW6DyG
	36V5+rvJALRJufERunyCsR4HNBgQOeAibfd/0Py+YC4Vqu1k7zFJ1HYmh0VCv23R72DYlB
	zIiea7zsmcoQ4uI0bfG5q3/pDhUta2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765496130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IPcy33/DuUzyPTg2Je9aEmCXF4TRhB6WwhLLNSHoHPU=;
	b=FO0SuX7CsElxsTLbEZyRNr+KeI6xr6jWXPl+81j9fXu6qF6QOji65CcNKS4PDHHLVbUH4l
	j//++PPWyLNCbsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F28DA3EA63;
	Thu, 11 Dec 2025 23:35:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lWUSMD9VO2mQJwAAD6G6ig
	(envelope-from <tonyj@suse.de>); Thu, 11 Dec 2025 23:35:27 +0000
Date: Thu, 11 Dec 2025 15:35:23 -0800
From: Tony Jones <tonyj@suse.de>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf addr2line: Add a libdw implementation
Message-ID: <aTtVO7Iykc8oTl8c@suse.de>
References: <20251122093934.94971-1-irogers@google.com>
 <aSdGq2K6TRMyG009@google.com>
 <CAP-5=fULHMCw=b0PuN07r=aAjoamb+MNSNrHM3nyHPYM2DGkow@mail.gmail.com>
 <f85dacc5-5d81-4ee7-acf3-8aa053c42dab@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f85dacc5-5d81-4ee7-acf3-8aa053c42dab@linaro.org>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,infradead.org,redhat.com,linux.intel.com,intel.com,gmail.com,oracle.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]

On Thu, Nov 27, 2025 at 12:16:29PM +0000, James Clark wrote:

> If the llvm addr2line implementation is also supposed to be slow, it just
> means we're trading speed with accuracy with this change. Hard to say what
> the default should be in that case.

I originally inquired about this (and was going to code up a patch
using libdw but Ian beat me to it) as we had a customer bug 
complaining about the performance of the binutils (/usr/bin/addr2line) 
forking solution and llvm isn't presently an option for us.

Using the forked addr2line the customer data set takes real: 54m15.023s 
user: 40m57.719s sys: 11m22.461s for perf script -F ip,srcline (with 
numerous time-out errors). 

Versus real: 6m6.598s user: 5m32.603s sys: 0m1.768s with this
proposed libdw patch.

I'm also unfortunately seeing similar wrong file/line# issues. This
said I think given that libdw is being used anyways and how poor the 
/usr/bin/addr2line performance is that it's worth digging deeper into 
what the issues are with libdw.

I'll try to look at it some more next week.

Thanks for the patch Ian!

Tony

---------
Tony Jones
SUSE Kernel Performance Team
