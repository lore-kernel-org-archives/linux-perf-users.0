Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825453;
	b=i+xcA6xqC6d5BBwghWeMC+Gr0pJjrSC2a21fNsgFMHplyetS6T2XcMpWvyEWsJguCvkC
	 WScSXGRA4mrfPgUAAVELuLfDqJ0TGiK4W9qUkB/zY7wSfqM2LXeV6bA2nA1tFEWDX2Lor
	 NYlARseNwMnsrk/sDtsIZPJFTzXLLMLG2A8DNn4u6UXnP1zzVQMAoOHPpRpjxoQWjc2Xu
	 24J9ZRX2ihaMRPzHlM2uH8CmVcSVTtJdsIZ3lA1WdvEDezGsszzwh9H+Pk1FR05BTScRH
	 JKuLJq7VDeeyi2XUxihleblfCBdcjQbYKAYOCYKSdeGoGb/YoowiEgBx9v3CIxKOAVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825453;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=/ZtzIqGKVBjlBBIyqu9fROMer7QN/0/V51r6Lfy880U=;
	b=LPFqI5U5y7P9vduauiQ+976nW9QM4vujhbMJ7wqoKJEIj7sds8nrrywxJQ+SJqnOf0av
	 36VrLHXyG/NttrKl85ta8Y5eR6oPqqtFvITram1QZ34B8k5b3EOTlXfqU1vegxmD74TFK
	 YaNst2LZfnDKkTyUKCwFDfXzB1lw50gzaIelHibeSSlCU4ME9t2NDA+exf8I78816b9Ag
	 WTeMbASkFw1o4WK23giyHNdd8kq1c2b93C1yoB11tzHToddsxLV/Sv0tXKNl1mqSgbvw8
	 LNA1AyOvLfJtmA4EG3ieiED1atBAkxmYetuYlUgiUJD2SRaoAI2QvgP3kuV/gdvXLew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="aEv3CH/d";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37CD606A31C;
	Mon, 16 Nov 2026 10:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C37CD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aEv3CH/d
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF3131476;
	Mon, 16 Nov 2026 02:37:28 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8920B3F632;
	Mon, 16 Nov 2026 02:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794825451; bh=fHZnIIQvAnQEZYB1ohrXNN6xTkU9UWERfy/JRkWqdUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aEv3CH/dircAIumFk9ZT6vTv8qcWLVhR94/xOQnKX/CpPjJCV0PznJfRdIjZAYN7L
	 +YxzjcZvjTvjXurJzyQsvvit8GW23xjZIXxlxj5mWJpfqA0S46ey9vBdOifk2b4hNL
	 Mwf4F9KJ/H8v0uw2yHTNFd0tiVyPjjlpOGpQuXQA=
Date: Mon, 16 Nov 2026 10:37:29 +0000
From: Leo Yan <leo.yan@arm.com>
To: Johnny Fan <johnny.fan@cixtech.com>
Cc: will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
	jeremy.linton@arm.com, maz@kernel.org, mike.leach@arm.com,
	james.clark@linaro.org, alexander.shishkin@linux.intel.com,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com, jie.fu@cixtech.com,
	bob.zhang@cixtech.com, Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v3 2/2] perf: arm_pmu_acpi: Support heterogeneous ACPI
 systems
Message-ID: <20261116103729.GT9176@e132581.arm.com>
References: <20261102084153.3975282-1-johnny.fan@cixtech.com>
 <20261102084153.3975282-3-johnny.fan@cixtech.com>
 <20261113160041.GS9176@e132581.arm.com>
 <avpxRZFX4Iebu0l3@JohnnyFan>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avpxRZFX4Iebu0l3@JohnnyFan>

On Mon, Nov 16, 2026 at 10:58:13AM +0800, Johnny Fan wrote:
> On Fri, Nov 13, 2026 at 04:00:41PM +0000, Leo Yan wrote:
> 
> [...]
> 
> > Based on above idea, I would fold your patch into my series (but I will
> > drop the first patch for changing TRBE/SPE drivers). I will keep you as
> > the author but please bear me a bit that I may refactor it to fit into
> > the extensions. Hope this is fine for you.
> 
> 
> Hi Leo,
> 
> Thanks for the detailed review, and yes — please go ahead and fold it
> into your series. I'm happy for you to keep me as the author and to
> refactor it as you see fit.

Cool!

> I'll hold off posting a v4 so we don't end up with two versions under
> review. Ping me when there's something you'd like tested on the CIX
> board.

Thanks for offering to test! I'll test on my Orion6 board and send out
the patches this week. You're welcome to test them and any comments.

Even if we're testing on the same SoC, your results would still be
valuable, maybe we're using different firmware versions.

Thanks,
Leo
