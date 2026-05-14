Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C38264619
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778738308; cv=none; b=cmSocFnAhFxXTzORYaKPjDFP2YlxgRxzKyTWHKxBBFHLQKvvdSWEB6ZQfVDyu1XHW7w1hoNq8lSvrVXQdKwT5A8BlHhTB691N01rWWoEnmJvO0ZaLgba1yYcI7OLFMyqcqHyzDj1aG+QjK8ifLirjlD2DNPc7orY8Ntt5A7Fw9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778738308; c=relaxed/simple;
	bh=E2mp2ooawHWSeje8s6fi7PMoWNEy+KCCOmwZ3FV3Z/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EB/r/Y1xT14ZCKb0b0qCvhkk7M39qv4MeKoW8KcAww+vR3t80uw2HWywh+7ViOrYKDXBqPLvtKLY4gAAid90BT/p0rpti4Cu+CQVu8fOpaMqOvCj6b5qFyYcIqoCUCA16KgVMVTPfJN+dPJx6w9kmmXym5RwBq1WAg3X5tKhxxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i6HFG86H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OB0HZCAy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i6HFG86H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OB0HZCAy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i6HFG86H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OB0HZCAy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i6HFG86H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OB0HZCAy"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C99A5CB3C;
	Thu, 14 May 2026 05:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778738305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOgWhDRcNjDz19mj/rWWcL4Q1L5v6fdJ+Xa8kqqczdo=;
	b=i6HFG86Ho/jLEDkLruEGfg49LHBt/v3tY7G4R/HaVgxHR6EIPvlz/awbadbbpptERtNl6w
	SWTK0Xs7fxEqB+J6shqMYArmM5VpJ/kmaRc0rKUiX2ZYZ/3MgqDUd/DgsoKn71M7F2Vn4M
	8V2Ty09Ga3b9ALOVNwJ5RDGjB8VRxd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778738305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOgWhDRcNjDz19mj/rWWcL4Q1L5v6fdJ+Xa8kqqczdo=;
	b=OB0HZCAys4Gycg9vUT+ugtZ9b1GVIIbBg8K2FOXC6sBb/tKvv1iXNTIj33ETVQdp14y+5e
	KD19SrvIi+/lwLAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i6HFG86H;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OB0HZCAy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778738305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOgWhDRcNjDz19mj/rWWcL4Q1L5v6fdJ+Xa8kqqczdo=;
	b=i6HFG86Ho/jLEDkLruEGfg49LHBt/v3tY7G4R/HaVgxHR6EIPvlz/awbadbbpptERtNl6w
	SWTK0Xs7fxEqB+J6shqMYArmM5VpJ/kmaRc0rKUiX2ZYZ/3MgqDUd/DgsoKn71M7F2Vn4M
	8V2Ty09Ga3b9ALOVNwJ5RDGjB8VRxd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778738305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOgWhDRcNjDz19mj/rWWcL4Q1L5v6fdJ+Xa8kqqczdo=;
	b=OB0HZCAys4Gycg9vUT+ugtZ9b1GVIIbBg8K2FOXC6sBb/tKvv1iXNTIj33ETVQdp14y+5e
	KD19SrvIi+/lwLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D61BE593A9;
	Thu, 14 May 2026 05:58:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L/gEInZkBWqRGAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 14 May 2026 05:58:14 +0000
Date: Thu, 14 May 2026 15:58:04 +1000
From: David Disseldorp <ddiss@suse.de>
To: Jia He <justin.he@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, Rae Moar
 <raemoar63@gmail.com>, Alexander Potapenko <glider@google.com>, Marco Elver
 <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Petr
 Mladek <pmladek@suse.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 1/7] init/initramfs_test: wait_for_initramfs() before
 running
Message-ID: <20260514155804.1fd13627.ddiss@suse.de>
In-Reply-To: <20260514050455.2954509-2-justin.he@arm.com>
References: <20260514050455.2954509-1-justin.he@arm.com>
	<20260514050455.2954509-2-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,kvack.org,arndb.de,linuxfoundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,linux.dev,davidgow.net,gmail.com,linux-foundation.org,suse.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLbwzjzhmci8e35wtwpcw4zc8n)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Queue-Id: 5C99A5CB3C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Thu, 14 May 2026 05:04:49 +0000, Jia He wrote:
...
> Add a suite .init that calls wait_for_initramfs() so the async unpack
> is quiescent before the first case runs.
> 
> To: Alexander Viro <viro@zeniv.linux.org.uk>
> To: Christian Brauner <brauner@kernel.org>
> To: Jan Kara <jack@suse.cz>
> To: David Disseldorp <ddiss@suse.de>
> Cc: linux-fsdevel@vger.kernel.org
> 
> Fixes: 83c0b27266ec ("initramfs_test: kunit tests for initramfs unpacking")
> Signed-off-by: Jia He <justin.he@arm.com>

Good catch, thanks.
Reviewed-by: David Disseldorp <ddiss@suse.de>
