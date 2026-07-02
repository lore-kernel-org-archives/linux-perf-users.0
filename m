Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8525B30DD2F;
	Thu,  2 Jul 2026 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959814; cv=none; b=dNpgWAYMFm1DQ+kmSMnu4HTkUfhmqjMSK2NOM4ppyACeYUT/CWfJWpLVraw1r6NkzQt3OkAoK+lg5qq9tLf5emKmIvA1G7mnHIpx1ENS3h3RVpLdHjAx1l+g9Ap6Q6ZxRCOigS5vGluOqyYqMkLTvRHS3rXBKiZytJk+eQE/BbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959814; c=relaxed/simple;
	bh=S6lFr1ncGH7pd1HRrKVDAKq+X429xEVtJJ7VS8y8+2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+Mcx/02u8G/d/sMPBOtZnI/+JVr5lDqov/y6tEYYo6YXQi8Lmi0BMCAAMSA4Q2PMNn6FV+xfB8ofAA6v/zz4T8Xi31cPIGBe/uRp/suDFxl7vlYM2XjBE9BYoCO5WSPoFmnZ1EABWQ0MeGMpOAp4bMXZxwR253EVrm3VedTgSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=H1nAGM0l; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="H1nAGM0l"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4E22C40E016E;
	Thu,  2 Jul 2026 02:36:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3pq55z7zS62Y; Thu,  2 Jul 2026 02:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782959801; bh=9Eo3m2gBojQEgeS3YSAkOcuM+sTzJu4uhJOH8vh5P4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1nAGM0lCMp+QtJqXvfKA99vBWj4y8izUMiBoTntTuwjS6T7iqnR1qsJrtJ8sY3MF
	 9Lct9DWXh06/MFgGeOgU6xj7rNXDwuE7s6iKL52a9eXw77icjBI1rwtf4JuETeNIKy
	 1OOQV1vYczyW3PQMFnTX5z/U5Hu8wx4MjAse/KTnGaRRmajuJm/ixQCMSBtYExOC/o
	 gtL6rxdADqp/0ketUkx1oZjRKEOhnQiAHLt0WX9kP+jh8DJfIp0Zb6YsvlQ/0zmmJM
	 MRyppcmxvNzF24dVw6FO6B8B53FUD5ibULt4jMftznL00S5VqxRmuq8IsJFXosUB4m
	 mw4OAWdQuIzGjHIXYziQUGwJKOnS57Z7LvqmEgxYEdLQLxXHDyY8PAsvGII4x85Wxq
	 GeJpCWH9SfEBAMZI8MPKlk5ig46O15Zrcy/Qm55png0qNj1/hqvmUlyuryEMG5rkyl
	 Vnra5aCj/+Sy86EXYm0fT/Kj/QGQoiYyfG0071Gq33VlDlwb85RJ8/lgp7BP0mrSfv
	 3CSD5VydrgduOscrsMcoLtJWrX19CcXbsjoWBL8888d3BKvOezHDm9O9UW1UjDVlXW
	 Dp9QFWXwqhJQ5YHS92laHi5O1BgDT9ROlX4g/iit3Pg5qF9gUQz9B50mikTAwbCxvC
	 ZZuU8KItha32zRlTAZUlM6lI=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 894A740E0140;
	Thu,  2 Jul 2026 02:36:28 +0000 (UTC)
Date: Wed, 1 Jul 2026 19:36:25 -0700
From: Borislav Petkov <bp@alien8.de>
To: Qi Liu <liuqi@hygon.cn>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	x86@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, lijing@hygon.cn,
	Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v2 0/3] perf/x86/amd/uncore: Add common helpers and Hygon
 support
Message-ID: <20260702023625.GIakXOqdXpW3GVkk8E@fat_crate.local>
References: <20260701093417.1312443-1-liuqi@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701093417.1312443-1-liuqi@hygon.cn>

+ AMD people who work on this code.

On Wed, Jul 01, 2026 at 09:34:14AM +0000, Qi Liu wrote:
> This series adds initial Hygon uncore PMU support.
> 
> Hygon uncore PMUs use a programming model close to the AMD uncore PMU,
> so this series factors out a small set of common helpers for perf event
> handling, counter assignment and per-CPU context management.
> 
> The Hygon-specific support is kept in the Hygon driver. This series
> supports the Hygon DF and DF IOD PMUs. No Hygon-specific logic is
> added to the AMD driver.
> 
> Changes since RFC:
>   - Address sashiko bot review.
> Changes since v1:
>   - Rename the helper namespace to amd_uncore_common_* to avoid
>     an generic uncore_common_* prefix, and to keep it distinct
>     from the existing amd_uncore_* names.
> 
> 
> Qi Liu (3):
>   perf/x86/amd/uncore: Add common PMU helper functions
>   perf/x86/amd/uncore: Convert AMD driver to common PMU helpers
>   perf/x86/amd/uncore: Add Hygon uncore PMU support
> 
>  arch/x86/events/Kconfig                 |  17 +
>  arch/x86/events/amd/Makefile            |   4 +
>  arch/x86/events/amd/amd_uncore_common.c | 403 +++++++++++++++++
>  arch/x86/events/amd/amd_uncore_common.h | 114 +++++
>  arch/x86/events/amd/hygon_uncore.c      | 556 +++++++++++++++++++++++
>  arch/x86/events/amd/uncore.c            | 578 +++---------------------
>  arch/x86/include/asm/msr-index.h        |   2 +
>  arch/x86/include/asm/perf_event.h       |  20 +
>  include/linux/cpuhotplug.h              |   3 +
>  9 files changed, 1192 insertions(+), 505 deletions(-)
>  create mode 100644 arch/x86/events/amd/amd_uncore_common.c
>  create mode 100644 arch/x86/events/amd/amd_uncore_common.h
>  create mode 100644 arch/x86/events/amd/hygon_uncore.c

I'm sure Ravi and Sandipan will give you more indepth comments but the general
direction with reusing AMD code on Hygon is to copy it first for your purposes
and, later, when it turns out the helpers do remain identical, then to merge
them.

Vs defining common helpers now and stifling your and AMD development by trying
to shoehorn common helpers with an architecture which is here and there a bit
different.

Also, I'm not sure about all those export symbols gunk - why would common
events helpers need exports to modules but meh, Peter will give his thoughts
here.

Also, Sashiko has comments:

https://lore.kernel.org/r/20260701094808.5C8BC1F000E9@smtp.kernel.org

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
