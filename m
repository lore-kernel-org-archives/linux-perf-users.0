Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2F52BEC2A
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765557271; cv=none; b=H3wJZ5vtsDeK4knd/2DLDNuZlLJGb7E+jwSMEPASwRf4ko1fmwW/U8Dmq03YFbfi9bzTKxU43t9tWFv4Ck6Xa2J8fxSnEtFCDwbdvEtjzxTSsx9vgTGWU8nUinR8ufSY8GSyo72JbzN1IxduLvfJkUV4r8Vs3Qki5O5QWHIqXaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765557271; c=relaxed/simple;
	bh=OUBOnoaHiu/T/oRgg+Y8ItCC7eokyEOcJLNBvTcAvaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNqIxHVaDDJ1xxcdpxtTHoIuTon7RAnSjCIxxn971NDnO2zU/xn5TJqknu9Zyk1pzjHkHs9cXxeQrfMgofr9a9leZjF6VHGkL1AUYqYW0jWq7v3NvwBZCas9j/NdJha8I79vbUeh4+CesfsTglmPR6jpZmNEGRNCZUcnXEBqALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AE8F2yDb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZR4eCTsJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AE8F2yDb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZR4eCTsJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AE8F2yDb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZR4eCTsJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AE8F2yDb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZR4eCTsJ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4279233934;
	Fri, 12 Dec 2025 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765557268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vvp0iIWQbzPmX9pOnK1JUI7dXdP2deXbYgt0HlgwpzQ=;
	b=AE8F2yDb5Z+345kXmrQ+hzNpwXOozV0iYCaUQd/BO5upPHjzmPVTrxr1ETxHDGzGAG8Tnd
	STEr6bUr0UYpjMK+SUmmxfJZFlu0LflxHoxycYjPgU0+0DNyUs5PWtwObQcYUyCD1RxHXC
	1hoXsPaYPB+RdWAtpqnpsXUFhR8yIOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765557268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vvp0iIWQbzPmX9pOnK1JUI7dXdP2deXbYgt0HlgwpzQ=;
	b=ZR4eCTsJvdM3g/I0/SybNC0fpmw8uCCyrz8ZcRWEMSK4oPJFtyt+Eqvz1Jy7q2cSUdK9hR
	JLyjIpsaBbtGQKDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765557268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vvp0iIWQbzPmX9pOnK1JUI7dXdP2deXbYgt0HlgwpzQ=;
	b=AE8F2yDb5Z+345kXmrQ+hzNpwXOozV0iYCaUQd/BO5upPHjzmPVTrxr1ETxHDGzGAG8Tnd
	STEr6bUr0UYpjMK+SUmmxfJZFlu0LflxHoxycYjPgU0+0DNyUs5PWtwObQcYUyCD1RxHXC
	1hoXsPaYPB+RdWAtpqnpsXUFhR8yIOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765557268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vvp0iIWQbzPmX9pOnK1JUI7dXdP2deXbYgt0HlgwpzQ=;
	b=ZR4eCTsJvdM3g/I0/SybNC0fpmw8uCCyrz8ZcRWEMSK4oPJFtyt+Eqvz1Jy7q2cSUdK9hR
	JLyjIpsaBbtGQKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8437E3EA63;
	Fri, 12 Dec 2025 16:34:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5OueFRFEPGnNOAAAD6G6ig
	(envelope-from <tonyj@suse.de>); Fri, 12 Dec 2025 16:34:25 +0000
Date: Fri, 12 Dec 2025 08:34:18 -0800
From: Tony Jones <tonyj@suse.de>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
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
Message-ID: <aTxECtpK3wdxd9uI@suse.de>
References: <20251122093934.94971-1-irogers@google.com>
 <aSdGq2K6TRMyG009@google.com>
 <CAP-5=fULHMCw=b0PuN07r=aAjoamb+MNSNrHM3nyHPYM2DGkow@mail.gmail.com>
 <f85dacc5-5d81-4ee7-acf3-8aa053c42dab@linaro.org>
 <aTtVO7Iykc8oTl8c@suse.de>
 <CAP-5=fUbZ1pjvcbF0do8BrC0NAzkOJeQUAozQhXKpGuosrW3ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUbZ1pjvcbF0do8BrC0NAzkOJeQUAozQhXKpGuosrW3ew@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,infradead.org,redhat.com,linux.intel.com,intel.com,gmail.com,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Thu, Dec 11, 2025 at 09:20:35PM -0800, Ian Rogers wrote:
>    Thanks Tony, those are great performance numbers! I'm wondering now:
>     - do we want to land addr2line with libdw given the wrong file/line#
>    problems or wait for a fix?
>     - do we want to make the addr2line configurable like with objdump [1] to
>    mitigate the problem above?

I think we should spend a bit more time understanding the former before
doing the later.  If only to provide some documentation on why there 
is a deviance to explain the configurability.

Tony

-- 
Tony Jones
SUSE Kernel Performance Team
