Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E56E3314A4
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290359; cv=none; b=AemodaRtXaaKAPQVPyzExQGMgilfgFpKH1Ut+MM7DlXECMCCcNbK6uhJ8p3wp+3fr3u4GgDh2bkT6BVfFP+q/wHv3l5H8YFZwXuMXxP7usBDbHF34vDFBfdNZEykSi3GAWz4vk8+pIukZKS70rakKzwgeUa5WFFMruMf9mgowpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290359; c=relaxed/simple;
	bh=mXQWpS7rANoNXxPIUW9X3i+Z/k00bZkKmCZ885Xn7hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAna1JD7nWGpFPb74dezkmuJZoYv8U7AvDoiEMoeTV32dDcqi30duJPUJoultV0Qf6byFPiC0qR4ohd7Q8q1WgzOYNfWMWETvoY6xJH+rtSS3TCT4DuIFlT6ryKHu3E0vPTkZLEKjcytZfkQRDw4Xxmfy7mCQSLSRAi26tD/kWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fZ4MfAL5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0DXXXcUT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fZ4MfAL5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0DXXXcUT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fZ4MfAL5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0DXXXcUT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fZ4MfAL5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0DXXXcUT"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF5643E7AD;
	Thu,  5 Feb 2026 11:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770290357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEgO4EFr4TOjOZFGozCqrWjARXJ47Q3XARcO22ZXarY=;
	b=fZ4MfAL5Tyb0jHnux2e0EyRdqQDL9v6aHU+Uq8dKYmZaBVAQZ2S32UE+7zZByHH16ZQCDO
	Mp8YKvTal5AAYWvrNQEWL69RXovs1VrCv1X7E9NeU7M9/nfgMgzfImXz3qRBBzIuyhQotL
	kjXHNHhFiXaQ80sTcwECZNTxXstePGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770290357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEgO4EFr4TOjOZFGozCqrWjARXJ47Q3XARcO22ZXarY=;
	b=0DXXXcUTfVuXXrmg1WxQ1pxgKfOl8vEQ3LLbvpm2eQg1LuQ3Rrmqt9qPAt4NQIaSZ1Ip3O
	BeayKV3evYcwN0Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770290357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEgO4EFr4TOjOZFGozCqrWjARXJ47Q3XARcO22ZXarY=;
	b=fZ4MfAL5Tyb0jHnux2e0EyRdqQDL9v6aHU+Uq8dKYmZaBVAQZ2S32UE+7zZByHH16ZQCDO
	Mp8YKvTal5AAYWvrNQEWL69RXovs1VrCv1X7E9NeU7M9/nfgMgzfImXz3qRBBzIuyhQotL
	kjXHNHhFiXaQ80sTcwECZNTxXstePGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770290357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEgO4EFr4TOjOZFGozCqrWjARXJ47Q3XARcO22ZXarY=;
	b=0DXXXcUTfVuXXrmg1WxQ1pxgKfOl8vEQ3LLbvpm2eQg1LuQ3Rrmqt9qPAt4NQIaSZ1Ip3O
	BeayKV3evYcwN0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A4783EA63;
	Thu,  5 Feb 2026 11:19:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TA+5A7V8hGkybgAAD6G6ig
	(envelope-from <clopez@suse.de>); Thu, 05 Feb 2026 11:19:17 +0000
Message-ID: <04f2e194-5148-47b6-97ff-835f9561bd36@suse.de>
Date: Thu, 5 Feb 2026 12:19:12 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uprobes: replace deprecated kmap_atomic() with
 kmap_local_page()
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, "open list:UPROBES" <linux-kernel@vger.kernel.org>
References: <20260205105725.298340-1-clopez@suse.de>
 <20260205111208.GK232055@noisy.programming.kicks-ass.net>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <20260205111208.GK232055@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
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

Hi,

On 2/5/26 12:12 PM, Peter Zijlstra wrote:
> On Thu, Feb 05, 2026 at 11:57:25AM +0100, Carlos López wrote:
>> kmap_atomic() has been deprecated for a few years, and kmap_local_page()
>> should be used instead, so replace it. Since the uprobes code relied on
>> kmap_atomic() disabling page faults to access user pages, add the
>> required calls to keep the existing behavior.
> 
> Are those pagefault_disable()s really needed here, or is this just
> cargo-culting?

The subsystem experts can correct me, but it seems to me this code is
primarily accessing user memory, e.g. is_trap_at_addr() ->
get_user_pages() -> uprobe_copy_from_page().
