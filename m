Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD668405C
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Oct 2025 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761257514; cv=none; b=Uay6Og/5Xb05RcotpdtqpzfKHW75oxGSOuzItGI4amPqn2pY5qrl/aIuY8buxaCwhSni0nRm+ladW5d4OAoBKWYEmafSy+Uxv1j4F92qErl+ziX8hRDoSTQB/x3vO8glmUh13QMDqUI7eskT86qPzxJiVN/54pEKjWMr4byx6/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761257514; c=relaxed/simple;
	bh=B+UUUp6uNHLrzyagMuHBGzkaTB2vsSCjuib0ZOuQjVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrOlSJMxz5zenCN4oIhqCV8mgpAalaWoKAXwwBXcCt6NuhCZYbuyKOECYgieXOen84+J2UYhY07WlU1hNZUZBi6ZG+shX+Dio52z+tNOLu9UB1z1bjly5SrQVzU1sghpQBUAngFcMo5hf3hVe7kerlNnsgJ7U6AwNfNeSIWq/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kyFMZ/Ju; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=56f2uXX5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=euZg90e8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/f+2orCV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kyFMZ/Ju";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="56f2uXX5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="euZg90e8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/f+2orCV"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D9091F397;
	Thu, 23 Oct 2025 22:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761257506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQ8YJL6c4otX3rpW5Q4ZskCTfDtlTHaM9dPQ9OJN+YY=;
	b=kyFMZ/Juw4TULUzkLvPddYAlTRTefS/LXQUDo1YilZAY8kMn5yxAv8ZziEqXdQ2lmBOV8G
	hZMIZQ4aFmkZzVtNUewUwA87Fv7/Vu3WaW4jKnR5kR4cSKXVKHwLBfWld8ScfzAjxa6csy
	vq8ZIBHpa9YZmVmdikOGO5pgzrtJ2aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761257506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQ8YJL6c4otX3rpW5Q4ZskCTfDtlTHaM9dPQ9OJN+YY=;
	b=56f2uXX5aL1uqNT48a4EEdvdGLcKcQeiBLogcxE3KqFrX7EeZP3bjPOfKk8kHglZLaLMMA
	ePNU5DOa/nfpiKCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=euZg90e8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/f+2orCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761257502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQ8YJL6c4otX3rpW5Q4ZskCTfDtlTHaM9dPQ9OJN+YY=;
	b=euZg90e8yDnMZG/JOsAJw2yOoL4qdlb+j+vvaVkAXJYbWMZesAcmEVAxJWDzR2sBgxEGqI
	WhG/ydOe2VL20yRIXknrR4638Pq1A7/FvVZkXgbyYNGQeVvEe22JIk1rG1YbBufZnpomgb
	Bj2pm9eaDxb6pioH2i+287Boc+vxVZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761257502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQ8YJL6c4otX3rpW5Q4ZskCTfDtlTHaM9dPQ9OJN+YY=;
	b=/f+2orCV6Yn8+jtEf25EKXY03nGbUw6kEkhBwEMQUmST8YueHiQow8fLmeOqAqRb06Zbd3
	PqmCvm80enwaY4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C619139D2;
	Thu, 23 Oct 2025 22:11:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NdylDx2o+mhfFgAAD6G6ig
	(envelope-from <tonyj@suse.de>); Thu, 23 Oct 2025 22:11:41 +0000
Date: Thu, 23 Oct 2025 15:11:37 -0700
From: Tony Jones <tonyj@suse.de>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Michal Suchanek <msuchanek@suse.de>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf hwmon_pmu: Fix uninitialized variable warning
Message-ID: <aPqoGTyM9nKSQYQ9@suse.de>
References: <20251022103839.19550-1-msuchanek@suse.de>
 <aPqjMzxyYeKCp91K@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPqjMzxyYeKCp91K@google.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5D9091F397
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On Thu, Oct 23, 2025 at 02:50:43PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Oct 22, 2025 at 12:38:35PM +0200, Michal Suchanek wrote:
> > The line_len is only set on success. Check the return value instead.
> 
> Can you please share the actual warning messages from the compiler?
> 
> Thanks,
> Namhyung

[snipped CC]

I believe it was the following (gcc13):

[   38s] util/hwmon_pmu.c: In function ‘perf_pmus__read_hwmon_pmus’:
[   38s] util/hwmon_pmu.c:742:20: warning: ‘line_len’ may be used uninitialized [-Wmaybe-uninitialized]
[   38s]   742 |                 if (line_len > 0 && line[line_len - 1] == '\n')
[   38s]       |                    ^
[   38s] util/hwmon_pmu.c:719:24: note: ‘line_len’ was declared here
[   38s]   719 |                 size_t line_len;
[   38s]  


Tony
