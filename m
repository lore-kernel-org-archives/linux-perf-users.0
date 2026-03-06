Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9336C0D3;
	Fri,  6 Mar 2026 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813389; cv=none; b=RedfXj2AQtjSc7RM6g3iYbNGi8K39FoRt5io+N3psO4CmjqbbQPBO6H90ciNS9a6dh5guEbIK6Zo+Jr46/V/snO+O4+fZi4ek4PX2W4FYkUSOpAfa3PSMEnXx7+Va2AtjedgiprsGzgJRQpP83+yuwQ7ogV2ac+YHOCpCXgCFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813389; c=relaxed/simple;
	bh=ijXGaJWUViaOUpLIMrNPVgZXACg9PxvjH/F31I84tS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVWMlVhYZY9w6vBzZ4lLnnsxYBRlrEM+m6WmkcWWkbgBmo3GAxglJAQoswfDMsfKsB5Yk1synYFZU4n+lHjElWf2BdWrNxdV5Un64lJ3/zZ6oMGWn/karaMy6h0bFtcV+vyWGtyV7ohi5bNZ5CArjAvn3mIv34DwGYexK+lEp3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jAU4goC/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jAU4goC/"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7A4E040E0163;
	Fri,  6 Mar 2026 16:09:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6pEGM0WzYpuj; Fri,  6 Mar 2026 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772813381; bh=BjqVHXIzuvmwNTbYb+QBG/sSOUQnnPucpuvQkYYsYgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jAU4goC/tLvu96O63tImRQ1LCOPUQ7gut1SEsSt+oHf/xK64iibrhkq+c5k+qhexg
	 gS15ftHyfJvJ+Awe7q6KYGgbwOpOCHtylGdCqsG/Glqz1QqPZZm8TvHX4aYSqyW4KE
	 4SwWMa4ciL8vOvh+ew1oF+CiO0JE3B27exOxFa6aEU0agF35wenxkVrDP5XYgS9hRt
	 mI8nOEw+GEFdasI63i5NT5iEj0NGy69Dn0zjTKwM4HHCXnGsIUkfWq2wYEkrJw3RJa
	 c8ponEyfk3KXE2shqvXIsaYZPk2hkS6xhvTebsWWZifZn6K80+YeSMyKuL0IB9iSRT
	 lJKI/B0Or2YV+7SMSj/BKMkl9wg1cQVOXk4H57A5etYu/YgzuLFu7Hh6oaPBlN8bfy
	 HOHt2JCuGy+NXe7guuWAGJvWiqGcd1h5sSff6CDdvN9TzM6qOW5CdVdHYKxef8rOmN
	 HPj8WJU5vpfBYBxWCMIIc26rv1MXf43l9mo7kuskfuuJEocl/huC1+9lDnCFv4hdo9
	 cttBdtUSlFDDO5tE/hT+0cDhA8cgDPcAfkAxArgtj7PxucD53hxF2H1rZWeBPSYYON
	 9H5/6t55KMEeCjyVDndYOM5WFaGPRLVCNE4gG93YfnduuWIU9DgSzgcVFBDg5hC6sC
	 Cgkv1S0SP4yMd5lxmLRlgbAI=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4630440E00DE;
	Fri,  6 Mar 2026 16:09:22 +0000 (UTC)
Date: Fri, 6 Mar 2026 17:09:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add references to tip tree handbook
Message-ID: <20260306160916.GHaar8LPlIl_ygYs6v@fat_crate.local>
References: <20260305212215.3188399-1-dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305212215.3188399-1-dave.hansen@linux.intel.com>

On Thu, Mar 05, 2026 at 01:22:15PM -0800, Dave Hansen wrote:
> The tip tree handbook is a pretty handy reference for keeping the
> various tip maintainers happy. But there are no references to it
> in the MAINTAINERS file.
> 
> Add a references to the handbook for a number of subsystems. I've
> added these for all of the obvious subsystems that list T:.../tip.git
> and are likely to follow the tip rules.
> 
> This will be useful both for humans digging in the MAINTAINERS file
> and our new AI bot overlords.
> 
> I'm cc'ing all the M:'s and L:'s listed for the subsystems but leaving
> off the R:'s because the cc list is already out of control. I'll
> commit this to *some* tip branch if there's general consensus that
> this is a good idea.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: x86@kernel.org
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
