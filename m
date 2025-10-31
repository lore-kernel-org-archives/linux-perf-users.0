Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3998332572E
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761943264; cv=none; b=r3Qgs31VVwKkwJ7G8Wwng0SZ2O+HeSJq2qWmTvxVgfYAsq5b88hw3lzfFJ1no/g9hFatUiOktQqCdAv46LX7jrXkSao1M6yx0evaO8aLnL0guYXtNzFiB+yTPVIEKlhzBIJjF9l089dLIOzJg/rdXM6A4iKfAMfGSSXlXnh624U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761943264; c=relaxed/simple;
	bh=FDNWyiM/DIysWaOo8f40ZMH7N7WDtxvAbClOdvclENM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLqEUypAJHMvC927NxYy2S75mHWZbRJSFtVdJBkFCN51Qfh0Z1C0oax+qKQlT6DEujgN3T73bGbJ5HMeFeImfB1rBLwbrie08byiN1Dr/kkW6/kfygrPRaz8hUGZO8+56K/LR4p4euzsgB7ZQhwjzm9oK2M9+/82/m0YpHit2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c/uE4UFb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bi2dcEsi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c/uE4UFb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bi2dcEsi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c/uE4UFb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bi2dcEsi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c/uE4UFb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bi2dcEsi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 403A12223B;
	Fri, 31 Oct 2025 20:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761943260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CKf/MdkO2ded+5cvWBbVeTV2ckd5n7B5uRUTyZkQKYI=;
	b=c/uE4UFbZcKBlpztNgLPB7kETeYQcWOMp3k+jX5PWjDIZVU1gRtBTF7zfBLmpG+t7jXIlA
	yAqVZKSFQSzVej4SBpSb0ggzaOUkUOTvkNtqm9Iav54ftCtEM91oLqWCCRqnYSj+Xw2Qsv
	CJKPmO5ToARkH3arQe6aQsES0S/t+XQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761943260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CKf/MdkO2ded+5cvWBbVeTV2ckd5n7B5uRUTyZkQKYI=;
	b=Bi2dcEsi8QrJ038QBwsWEd1/ZIdo5lw+HSapLza6fslry9rL1/DC+td+5ZI/baRP3UP/91
	MtVH6hJKELScQNDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761943260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CKf/MdkO2ded+5cvWBbVeTV2ckd5n7B5uRUTyZkQKYI=;
	b=c/uE4UFbZcKBlpztNgLPB7kETeYQcWOMp3k+jX5PWjDIZVU1gRtBTF7zfBLmpG+t7jXIlA
	yAqVZKSFQSzVej4SBpSb0ggzaOUkUOTvkNtqm9Iav54ftCtEM91oLqWCCRqnYSj+Xw2Qsv
	CJKPmO5ToARkH3arQe6aQsES0S/t+XQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761943260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CKf/MdkO2ded+5cvWBbVeTV2ckd5n7B5uRUTyZkQKYI=;
	b=Bi2dcEsi8QrJ038QBwsWEd1/ZIdo5lw+HSapLza6fslry9rL1/DC+td+5ZI/baRP3UP/91
	MtVH6hJKELScQNDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50AD813393;
	Fri, 31 Oct 2025 20:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /3koCNseBWmkcgAAD6G6ig
	(envelope-from <tonyj@suse.de>); Fri, 31 Oct 2025 20:40:59 +0000
Date: Fri, 31 Oct 2025 13:40:55 -0700
From: Tony Jones <tonyj@suse.de>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com
Subject: Re: addr2line performance
Message-ID: <aQUe14AOt3Yc5Xv0@suse.de>
References: <aPkivW2WoySU1Zkc@suse.de>
 <aQUQhHEmsk9Mm6Qx@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQUQhHEmsk9Mm6Qx@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Fri, Oct 31, 2025 at 12:39:48PM -0700, Namhyung Kim wrote:

> I think we can just use libdw.  I tried it in the past but never
> finished. :(

This would be interesting.  

I asked our toolchain folks if they were aware of libraries 
(other than libllvm and libbfd) that could replace the addr2line+pipe 
(and were license compatible) but I've not heard back from them yet.

I'm happy to look into implementing this if you lack the time. LMK.

Tony

-- 
Tony Jones
SUSE Kernel Performance Team
