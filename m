Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB34935A383
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131262; cv=none; b=IrNdDqtVZXkTfhIMBaCw4k1hjngXVIBlR3M4ymDbj1occWTT5W2R52SJeUMID+CHHI+n6oDvMAHBrexQpVA8Y1AqMCf0vP9kGN60KoyI4cQCwyQ+JEY+Mt8y6gb3NDLPO9Ek4y6T5h3SH29HCVvBKOMAQGTPdrQLW1oW9qni5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131262; c=relaxed/simple;
	bh=1Vkzlkf8iyjAcWMHzA8YdXmTGe/S+Y2ah5UMLvIjvEs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TuR5OQCzTgVpnciljawwvknxW/FdwLGmkqjF09+A7tua1mH5niw1+xv7hqlJVcC2tloFEwIZyRFhtywZb52dyZpSl6S2eQHhfGs4aGnBBikTTjxn17K4Ft6sb9X0hkcv4G6UIX89qDxY8P5CEqIYogqjuB2g0yUJgqRqspMkAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LroLluYp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LroLluYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFE9C19423;
	Thu, 26 Feb 2026 18:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772131262;
	bh=1Vkzlkf8iyjAcWMHzA8YdXmTGe/S+Y2ah5UMLvIjvEs=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=LroLluYp8bsnmt5iPt3W7T549znoUA1eUXwvAeFJ0JK/YKM6ASBD7Dp139G6bYY1Z
	 0jc6OFwiydgmf3F7fvUQJJlbPH24GuIP7XGReON2pPaoZcmxwgrDj0ShhRyzlAyQll
	 ePypdAR0XpaHGTJIxSA3UAuY+bCqFYTAa7C9eXBtaaPKYiCidTJcGLnqaSHwR3CqET
	 R2Xmr/gYj/TBSW2meybJqaxMV2KShEyO/CWcppGZPwp7xCLg9MrHxQoCuuRk5OfG/L
	 Yu2HWJDnQJB8q9N1OXX2N0zmUHGeKeLWetZx0sQW5kf5PM/OUxy4vMC1KB/IjtAr6e
	 oy57iS5Oc7k9A==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, Andi Kleen <andi@firstfloor.org>
In-Reply-To: <20260218014056.3454977-1-andi@firstfloor.org>
References: <20260218014056.3454977-1-andi@firstfloor.org>
Subject: Re: [PATCH] perf, script: Fix brcntr output with --xed
Message-Id: <177213126259.3706963.10933531077902636278.b4-ty@kernel.org>
Date: Thu, 26 Feb 2026 10:41:02 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 17 Feb 2026 17:40:56 -0800, Andi Kleen wrote:
> brcntr in perf script brstack insn currently outputs
> 
> $ perf record -j any,counter ...
> $ perf script -F +brcntr,+brstackinsn
> ...
>             BC1s 3450809 5665912.127194:     100127
> cpu_core/cycles/:      7f0475d6cc89 handle_intel.constprop.0+0x2b
> (/usr/lib64/ld-linux-
> x86-64.so.2)
>         intel_check_word.constprop.0+224:
>         00007f0475d6ca7e        insn: 00 4b db                  br_cntr: # PRED 21 cycles [21]
> ...
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


