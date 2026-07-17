Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5056F245012;
	Fri, 17 Jul 2026 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305786; cv=none; b=mvHbsISkFigfQeviGEscDbpfzazT2C9xejh6jQ8YUlOb3raZQx/gGolCLq+g5nvwB2fWPz015sqHYZdIM1mJH7Hg6W7nVbOiZ7tVVRb7dyRWwnpEmmEv/BW7mtKuhqjLUCXX93tg/TksfJFxMsHa9ZgU2HVJgTHK6NLfhRwg5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305786; c=relaxed/simple;
	bh=+lHYXOMpYR2CjVPrlOEYR9B2IEXORBCms1hig+6Q1ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dK4zruNbqCDocJwftAu4dd5ghZOdo2LQypoaXhH9DcGMBcv+UzplpBZyFk/qM8/pSZhiNCG9N7vJU9mY/412lZT3rIdH7Ymyzo/bVE4Kvxi4YcYW+pL53uJj4JlodaZKRmebGkyL4GBv4jVYBdRa0KdXrq4DQQQ5JWknqm6TonY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=g3y2dkvY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="g3y2dkvY"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B2E7B40E02B1;
	Fri, 17 Jul 2026 16:29:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1Y60ZtmddiTi; Fri, 17 Jul 2026 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784305763; bh=Nz7TtCuvujd6DyFmLHCmqcD86HKnSIHjpAW+JTeQYUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3y2dkvY6g+abAmwgItNF01PKbGFYkIATv791xbmF8hejFEWf8jNeNJSMOBQUQ8xb
	 D1UFMXpzd4FODiPCzb/bN3LQYNZlCsfk+gcXn0a5yaG9G5SxBc4ryvLVQA5oF0tAdI
	 vQrkveKZvczYYZjez4tb3X+fSDXHa2XyuJFH6peeV1vt1i9UK49vLTk2ZlRfZxO0/v
	 AcFuwQcoAxVwk1s9egwvABIGhIf0HtNPoo9NrVNtRYMGa1PY2sUJoOmijf7uxTp5Go
	 Qmg7VgJKNwDMZgyu1vFmLvdNm7m4+fUW6tbF+4OO0wNyBp109k9wKuXPpQM4Jkga1Y
	 7KIq4w7hV/aSTfXedaAhqK4ZHCY37Bzq3nlqLBkTdvHJtCbDww9vWgb2ADix3B/LlP
	 mzY8ZFl4d2EbeMbo0dsQe4T2seltZcnrrC7uvqYV03lKoigX8zifuEvV5cmIx2OTX4
	 zhIaQV5YAtRuAGtju14hM8lI3iVs6Bfe/YT0KygzBFT+slLnTSGxBL9C2ZXjEE2gbw
	 Id8EAxO2wJEKJnPgY0rROLnp1paMQIfFf5S65qqQTWjlb9aD2jPrTNgMvdTnFj2Kba
	 WP9Criiut2XIajQoQWAvYLvhLI7y7l/CeYsFsifiOC/rRqnMxjkcTKexHL0GCNuE9z
	 wFpnNeAJxxBMuSuaPldO+U9c=
Received: from stx.tnic (unknown [165.204.77.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3247F40E02B0;
	Fri, 17 Jul 2026 16:29:07 +0000 (UTC)
Date: Fri, 17 Jul 2026 09:28:57 -0700
From: Borislav Petkov <bp@alien8.de>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 00/10] tracing: wprobe: x86: Add wprobe for watchpoint
Message-ID: <20260717162857.GAalpYSaZ_emTMUEEW@fat_crate.local>
References: <178429796992.157981.3393977217853767915.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178429796992.157981.3393977217853767915.stgit@devnote2>

Hi,

On Fri, Jul 17, 2026 at 11:19:30PM +0900, Masami Hiramatsu (Google) wrote:
> Here is the 9th version of the series for adding new wprobe (watch probe)

any chance you won't blast out your patchset every day?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
