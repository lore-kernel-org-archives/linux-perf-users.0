Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE82EB872
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Oct 2025 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157836; cv=none; b=uvnsAW91R1ywiWbDS51ly4/RdL4ob1SzYNE1Mc49D1/fhlnB1QfdCdjQwq0csRuxdhME+y/cpXKKq6xsAhtofMJiijaIdH+akagrs+duLRr3P8844EpA/jESmZn5V7C4pb3U1tERjMIGdAObFcLzuAl20B0Uwyo1W9HzElRp31E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157836; c=relaxed/simple;
	bh=oiyOgEKeckHtHN0udO0QGer8XOB4gN+VvxHJpz7R+L0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=szQVAYOvPn8pv0zKrS1LNUOazPke8NzhQvHfBQ51XA6+TgdDKA3uU5pm+xpGEe4BGAKpUhFe7ZKPygEBh6SILQA6UJITr9sdpF4UJwEcPxX+wLy3ocxbrRN4pB28jNV/ZJf9MwLtZKfuAjUabjw2uq9gGsEXKQWkxMgn+cFAoho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=agTqkdR7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OULDU72U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XZWrjNVD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hGBiGoMY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="agTqkdR7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OULDU72U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XZWrjNVD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hGBiGoMY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D18471F397;
	Wed, 22 Oct 2025 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761157829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=X/Oxrs3kNjzM880iX2m4VVuIi0An5H9S6bUHF5nSwVc=;
	b=agTqkdR7R05K5eiU/RlmulYlEVEqGSkypL4natNKGK0TnmpCpKoz2U/nfOoOjstv5YDkPf
	+gajt6Uj4iavyjHgS2Pu19jy9K195e8UKJ/b/IUKyWSNVcPNj4Lj5dLgK24h1qeZLim/vm
	iJ62rBr3fXKX5H7hcHFUEyztYi2pTg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761157829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=X/Oxrs3kNjzM880iX2m4VVuIi0An5H9S6bUHF5nSwVc=;
	b=OULDU72UxFZr+kqe0XDesfczgVBklE70um1GlGOEzOUxNnKkHlFbQbR+2laW+czzAevkaG
	f0s4+fKyxMWCmqAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XZWrjNVD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hGBiGoMY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761157824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=X/Oxrs3kNjzM880iX2m4VVuIi0An5H9S6bUHF5nSwVc=;
	b=XZWrjNVDi50XixCYEWK5dbpKCppBLVPiS76qkUVwm57+q8SlOCpkbRtw7aJ0iKA4ukb6aZ
	5h0QVMsGpF36cuBE/WBI/eCcTtAt1upthOfahHQdw+NgBJLKMIada81tKvil1jtfCwnall
	was3PpgO8K7LsYi4leah7cpnr2MImEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761157824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=X/Oxrs3kNjzM880iX2m4VVuIi0An5H9S6bUHF5nSwVc=;
	b=hGBiGoMYTTnAMeqYCBDb11XymSgMDUXAzzlZXUchilE+dsGgHEjV7zSD2Pn0UccCeuwkcq
	8qtuHyXOqGhKYnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1ABDA1339F;
	Wed, 22 Oct 2025 18:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rq5bN78i+WhnCQAAD6G6ig
	(envelope-from <tonyj@suse.de>); Wed, 22 Oct 2025 18:30:23 +0000
Date: Wed, 22 Oct 2025 11:30:21 -0700
From: Tony Jones <tonyj@suse.de>
To: linux-perf-users@vger.kernel.org
Cc: irogers@google.com
Subject: addr2line performance
Message-ID: <aPkivW2WoySU1Zkc@suse.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D18471F397
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

Hi.

https://bugzilla.kernel.org/show_bug.cgi?id=218996#c1 mentions
"there are proposals to move this logic to being from a library again. 
I think the addr2line processing attempted is valiant but ultimately 
using a library will be best" (this was when LLVM addr2line support 
was already present),

Obviously the test patch mentioned in the above bug doesn't address 
the underlying performance issue, only better classifying a timeout 
error.

We have a customer bug complaining about the performance of addr2line.
I'm seeing cases where it's taking over 20 seconds wall clock to 
resolve certain addresses which obviously causes the io_timer to trip 
but the performance of the success path isn't great either.

Obviously BFD isn't an option and (for various reasons) we can't use 
LLVM for this specific distro so I'm looking at the performance
of addr2line.

Can someone point me to the prior "using a library" discussion 
referenced in the above bug or whatever the current thinking is.  I 
couldn't find anything searching the archive.

Thanks in advance!

Tony

-- 
Tony Jones
SUSE Kernel Performance Team
