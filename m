Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC14372063;
	Fri, 26 Jun 2026 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462085; cv=none; b=Sjpl2NLNeOh4LU36i+dFtkBPM9BTTDqIKvR0qb4pfZhpnOYnzpMnz3anwh/r8+HPswQSyhAQPyxJ5IefiAoEdR41SnoHYsEbrZqwO5Btd4BrpUJ5vsMlrRdVAFWO4gcbG2TmuACGp3dLW4y1zcPNQeFGXj9XbTidNbIRKVRF1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462085; c=relaxed/simple;
	bh=2pEFtKLnyKk0zMGW3D1ZQTpBOgCKO6ECHgUtPekp0f0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TPNy2lfKbhDxXeBSkf6eJtoYUQ6oThmm+TyTwIxqPB7RaBZ2E2bm6l4uSnw4NEsFyTy7cJr5YK5C68JCELvkDVr0hDj7vIqQQXcBtte7xlO+wjHjMKDtdi9vCsnBJg0bEtI/2xpfdKnXctgoQmiwHunlSyQo6Y1qa7TVNr8l4Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfgA+z6F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfgA+z6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F451F00A3E;
	Fri, 26 Jun 2026 08:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462083;
	bh=52SPPVu3YGhhIMY2BRJv/B3qF4NdywMsMSBaNgtMuvM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IfgA+z6F+j0/xx7GKl5Wi6w/gMIMYcBz8EgpLDUdDEUcGE9/nXQLUDuFbd52gbFvq
	 KXQFUMzwe40opw1qgweDt6fAS/peeF6vBxP6TqW91YDs4myGtrray33EjDOfrk/Z1l
	 /SiW497iu6789CSenJ2DfZ6E9GhCSlB9oh91N3eZZzTWwSO2r8nrT6v6qvghLNrw6N
	 Cx4uvqEJ6M9khGqhy25NNOWLYs8HN0+fV3j4XBEn0ozRzioz/0pj5XiVGGUxU2WZVM
	 KS6SFSYTBF1waKs9EdSH2ItbsqHMw+l6D+rXLiEHN+cT9WBXJkE+oHfDaf6WVikRCS
	 DWNZvtWjwbf6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A1A39389E8;
	Fri, 26 Jun 2026 08:21:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] perf riscv: Fix discarded const qualifier in
 _get_field()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246207023.3816447.7046697661981822212.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:10 +0000
References: <20260513180721.1179904-1-guanli.oerv@isrc.iscas.ac.cn>
In-Reply-To: <20260513180721.1179904-1-guanli.oerv@isrc.iscas.ac.cn>
To: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, palmer@dabbelt.com,
 pjw@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Arnaldo Carvalho de Melo <acme@redhat.com>:

On Thu, 14 May 2026 02:07:21 +0800 you wrote:
> The assignment of strrchr() return values to non-const char * variables
> triggers a -Werror=discarded-qualifiers warning when building with GCC 14.
> This happens because in newer glibc versions, strrchr() returns a
> const char * if the input string is const.
> 
> Properly declare 'line2' and 'nl' as const char * to match the glibc
> function signature and ensure type safety. This avoids the need for
> explicit type casting and aligns with the design pattern of not
> modifying read-only memory in the perf tool.
> 
> [...]

Here is the summary with links:
  - [v2] perf riscv: Fix discarded const qualifier in _get_field()
    https://git.kernel.org/riscv/c/7378b6656aa4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


