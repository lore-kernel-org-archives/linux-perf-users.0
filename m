Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB37320A0A
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764150381; cv=none; b=np+oLRDFqqEcj/dtZ6oQdpJgDz5TOrXl2Guma6PoYNsA+tBfwS4ug2Bbo4sKdaZFLxrm8KEcKn+mbds+xOm798OcraYRJUTtJEV5rj2DA6qpIoE5z6HCR0c+S1GWSLmA6kU5I2MtqRAxxJYe4AKCAX3hVPs6JXWpPGC8NxloPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764150381; c=relaxed/simple;
	bh=TKJ4evTTrTCn7lglh02/NYxcg2/26sorkWVSBcB5aSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Of7QGDkOo4ykdkuZhvZrhtCEKxBmKwOg79OUQjWuar+uXf7++bonBPlCcISJl+vWgkJLi+e2LxeEfjGNXR9ssVCDpc1ff6FmQAnxlcGGHRgB2hj4TdvhRuRzv0muQj3u3OCjzkHs3egK4l8grSWHuvBvcvw8LXDvYXcPmEHDYYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YwpnJgsZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n5YuunwS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YwpnJgsZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n5YuunwS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YwpnJgsZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n5YuunwS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YwpnJgsZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n5YuunwS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EA505BDE8;
	Wed, 26 Nov 2025 09:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764150378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71oeEgOrLPKpQvX3jEg/a7qJc2VeX37MUB5MPj4Q5IE=;
	b=YwpnJgsZldJUTmngUPc2nOKl4IE/U8Lh4Dd/iFEuI8fIm6Oums0d37XzCi/FWVns2nLWmf
	NBZgO/HnhWmoVWBlcjwcC9CGPB9QD+3OYd9x7fxClJSTLCszGIIIxR7Ng5J82SGUd8euV+
	pClwwa+kdyeifiYucMvedd3TCMGsulM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764150378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71oeEgOrLPKpQvX3jEg/a7qJc2VeX37MUB5MPj4Q5IE=;
	b=n5YuunwSXDFAtrxKN+T/4TpTLKzhWv5rD6r/90m5bm2sQSvhPQY80LOKQw0dNXLQGvxD78
	UvH/7NTnjihSgKBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764150378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71oeEgOrLPKpQvX3jEg/a7qJc2VeX37MUB5MPj4Q5IE=;
	b=YwpnJgsZldJUTmngUPc2nOKl4IE/U8Lh4Dd/iFEuI8fIm6Oums0d37XzCi/FWVns2nLWmf
	NBZgO/HnhWmoVWBlcjwcC9CGPB9QD+3OYd9x7fxClJSTLCszGIIIxR7Ng5J82SGUd8euV+
	pClwwa+kdyeifiYucMvedd3TCMGsulM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764150378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71oeEgOrLPKpQvX3jEg/a7qJc2VeX37MUB5MPj4Q5IE=;
	b=n5YuunwSXDFAtrxKN+T/4TpTLKzhWv5rD6r/90m5bm2sQSvhPQY80LOKQw0dNXLQGvxD78
	UvH/7NTnjihSgKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53E353EA65;
	Wed, 26 Nov 2025 09:46:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vjkXFGrMJmmwJQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 26 Nov 2025 09:46:18 +0000
Message-ID: <4cb9f727-734b-43fa-92d2-80559df76c84@suse.cz>
Date: Wed, 26 Nov 2025 10:46:38 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] WARNING in __alloc_frozen_pages_noprof
To: Xianying Wang <wangxianying546@gmail.com>, akpm@linux-foundation.org
Cc: surenb@google.com, mhocko@suse.com, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org
References: <CAOU40uAHO9-59HB2VmCBfC5OiNg3BZBd-32jphtRd-nkvhD6Dg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <CAOU40uAHO9-59HB2VmCBfC5OiNg3BZBd-32jphtRd-nkvhD6Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

+CC perf people as AFAIU the problem originates there. Should the limit
be lowered, or the allocations e.g. switched to kvmalloc, to avoid
requesting impossibly high order allocations?

        /*
         * There are several places where we assume that the order value is sane
         * so bail out early if the request is out of bound.
         */
        if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
                return NULL;



On 11/19/25 10:07 AM, Xianying Wang wrote:
> Hi,
> 
> I hit the following warning in the page allocator when opening a perf
> event with callchain sampling after increasing
> kernel.perf_event_max_stack.This warning can be triggered by first
> writing a large value into kernel.perf_event_max_stack and then
> opening a perf event with callchain sampling enabled.
> 
> The reproducer does two things:
> 
> 1) It writes a large (but still accepted) value to the sysctl:
> 
> echo 0x40132 > /proc/sys/kernel/perf_event_max_stack
> 
> (0x40132 = 262450 in decimal. This is below the current upper bound
> 
> enforced by perf_event_max_stack_handler(), which uses 640 * 1024
> 
> as extra2.)
> 
> 2) It calls perf_event_open() with callchain sampling:
> 
> struct perf_event_attr attr = {
> 
> .type = PERF_TYPE_HARDWARE,
> 
> .size = sizeof(attr),
> 
> .config = PERF_COUNT_HW_CPU_CYCLES,
> 
> .sample_type = PERF_SAMPLE_CALLCHAIN,
> 
> .sample_period = 1,
> 
> .disabled = 1,
> 
> };
> 
> fd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, 0);
> 
> The same warning is reproducible on both v6.17.0 and v6.18-rc2
> (6.18.0-rc2-00120 g6fab32bb6508), only the line numbers in
> __alloc_frozen_pages_noprof() differ slightly.
> 
> The suspected cause is that alloc_callchain_buffers() uses
> sysctl_perf_event_max_stack directly when computing the size of the
> per-CPU callchain buffers. For large but valid values of
> kernel.perf_event_max_stack, perf_callchain_entry__sizeof() grows to
> several megabytes, and alloc_callchain_buffers() ends up doing a very
> large contiguous kmalloc_node() per CPU. This high-order allocation
> then triggers the warning in __alloc_frozen_pages_noprof() in the page
> allocator.
> 
> This can be reproduced on:
> 
> HEAD commit:
> 
> e5f0a698b34ed76002dc5cff3804a61c80233a7a
> 
> 6fab32bb6508abbb8b7b1c5498e44f0c32320ed5
> 
> report: https://pastebin.com/raw/bCq3d4KR
> 
> console output : https://pastebin.com/raw/5hfk57Vd
> 
> kernel config : https://pastebin.com/raw/1grwrT16
> 
> C reproducer :https://pastebin.com/raw/GADWbwKN
> 
> Let me know if you need more details or testing.
> 
> Best regards,
> 
> Xianying

