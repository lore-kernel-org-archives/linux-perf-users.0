Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668FD3ACEE6
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290875; cv=none; b=J1AHRtYncjDz8Un2akgixVf6UHMjVGeFfxKOD0qtUIDXGLX3MDzJTA84ndf19LZgfzF5Heuq9kGospbaH7d6aJErgCQFbfqxkxX/cydfyoFP6N7kYae9Uat5f/JIRfYAabtsEhReHuCcWR9bHx14l/rL2A2n/pwp74+7aA+1M38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290875; c=relaxed/simple;
	bh=wuR50FqoQ/q0MqcA9W9lEfEUyrRzZlWmSiYfP1GBinY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPv83TAwIKmL0YKd9ZC5siWZkxcLYxDSzRubZ6N9rH14I97dOa7pxwHImjeL+qDVoS+ESfKEJt50Mt/DHLm3J185NJHCBHUQsyI0b+/mkL5oeqTK1zHhu5EGEu7BM54ioTSGIb9g48mm67x1JU6gHBmfjoYOcvyO8oWviZnkMzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0eaxizGf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XaSyukJ8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0eaxizGf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XaSyukJ8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0eaxizGf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XaSyukJ8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0eaxizGf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XaSyukJ8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9308F5BD8C;
	Thu,  5 Feb 2026 11:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770290873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/awvREpN6Y0JEDqqo7tlfDPB+Wwy1BZNyNka1g0Uis=;
	b=0eaxizGfIqptg5IV3x03ImRLMa+TtUzzoyoNUNdM/LMln4B6k8bZA1dN8zA+AehaNIkIkr
	CP9aA8NJ0kaAzvE6ohQub9OwSy+KUIYRl5kH+h62rhbLArciX/43r1/y0cvRkiIPfd+7w8
	sSNqBr3E3LWIfcYwQmSRP6oAOkhVhgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770290873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/awvREpN6Y0JEDqqo7tlfDPB+Wwy1BZNyNka1g0Uis=;
	b=XaSyukJ8CZP3d5XhudbdGO1qZyNdYuAXMjnRwxr64XnmPYn0c3v4lkHxoLNetKUbzIdKkD
	8bjqsyzB/pS4GbBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0eaxizGf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XaSyukJ8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770290873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/awvREpN6Y0JEDqqo7tlfDPB+Wwy1BZNyNka1g0Uis=;
	b=0eaxizGfIqptg5IV3x03ImRLMa+TtUzzoyoNUNdM/LMln4B6k8bZA1dN8zA+AehaNIkIkr
	CP9aA8NJ0kaAzvE6ohQub9OwSy+KUIYRl5kH+h62rhbLArciX/43r1/y0cvRkiIPfd+7w8
	sSNqBr3E3LWIfcYwQmSRP6oAOkhVhgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770290873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/awvREpN6Y0JEDqqo7tlfDPB+Wwy1BZNyNka1g0Uis=;
	b=XaSyukJ8CZP3d5XhudbdGO1qZyNdYuAXMjnRwxr64XnmPYn0c3v4lkHxoLNetKUbzIdKkD
	8bjqsyzB/pS4GbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C358E3EA64;
	Thu,  5 Feb 2026 11:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C6kCLbh+hGm+dgAAD6G6ig
	(envelope-from <clopez@suse.de>); Thu, 05 Feb 2026 11:27:52 +0000
Message-ID: <c5072ace-f99c-448e-a599-cbdbd6301a42@suse.de>
Date: Thu, 5 Feb 2026 12:27:43 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uprobes: replace deprecated kmap_atomic() with
 kmap_local_page()
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, "open list:UPROBES" <linux-kernel@vger.kernel.org>
References: <20260205105725.298340-1-clopez@suse.de>
 <aYR-OM41gqRbEnKk@redhat.com>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <aYR-OM41gqRbEnKk@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 9308F5BD8C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 2/5/26 12:25 PM, Oleg Nesterov wrote:
> Hi Carlos,
> 
> see
> 
> 	[PATCH 0/5] uprobes: transition from kmap_atomic to kmap_local_page
> 	https://lore.kernel.org/all/20260103084243.195125-1-ming.jvle@gmail.com/
> 
> already in tip/perf/core

Ah, looks like I was looking at the wrong tree, sorry for the noise.
