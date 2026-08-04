Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB247CA8D;
	Tue,  4 Aug 2026 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863083; cv=none; b=SKowsOhqUh3Bt70mWnROFESNk1bXeEOhj4ivHSvXbbC95/0Ra52IuuBFwyAMd4+0RapYpLunsy6k0zkhCcP01xcEC8bV4LnUNzRXR3+4QHciJw79iWPvmJgpi0RExgT5oLCeRVGt1BjtpYAVCdhTxd8+budiYosDZmybylHcpdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863083; c=relaxed/simple;
	bh=feeUaNWKXZnUbf8sGpU2RPkPKZ0lK6kGW22RW2+80TU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hdYqjpi16chWhZcaHNzziP1EwBFFN+0ui2q/c8e0qAFxT7aPCnoOay+2ZZM/IVBcyyIBwn5v7ga8MWxwMtkkpnVa7OgyPLAOXALi+75TwkRm240l34jsDv5abk9t57hYs1lsNzU7kD1odon8AzHfyJZpV0buZfvtF67/UMN9AsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpskBn7B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpskBn7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D5C1F00ADB;
	Tue,  4 Aug 2026 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785863069;
	bh=lCU2QXnEQAlVnkyZh67mmXHUie/042VSOWCThRIDYTM=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=bpskBn7BRPoiPhHpg6RrykDMrZiRoq6LtepsjhMQK4YYrZm0l7gnorRtZpzmyQunL
	 zhVbviG9AYXUziP2OsZOUOmOxXS5URYxRysiNU7U6o3+ZGMkXq26mJe7mwLR3QXa96
	 42He7PrVOhpHOufoIS2jRMIwOC1I9N58fzB54YMlrKTh9eYSMLKrwm9hyopmgQ9DN8
	 MazKvgQTEh0XiyBFU7453p/NZ6mq84JTubKtSTRqHRboUBT5hUzlrieK6L8LEiu6gw
	 bpnOBkhKW7wDq/TZAKZLJ4f7yNtwPTjS38E4yvu+QCim8z7rhr6O+IPR20sOy0UjdJ
	 Jwu++RapVAs5A==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiazi Li <jiazi.li@transsion.com>, Pu Hu <hupu@transsion.com>
In-Reply-To: <20260802132536.4635-1-hupu@transsion.com>
References: <20260802132536.4635-1-hupu@transsion.com>
Subject: Re: [RFC] perf pmu-events: Fix typo in idle-cycles-frontend
 description
Message-Id: <178586306871.3573204.13116776445552587033.b4-ty@kernel.org>
Date: Tue, 04 Aug 2026 10:04:28 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 02 Aug 2026 13:25:42 +0000, Pu Hu wrote:
> The brief description of the idle-cycles-frontend legacy hardware event
> refers to its alias as "stalled-cycles-fronted", but there is no such
> event. The correct event name is "stalled-cycles-frontend".
> 
> This typo is visible in the output of "perf list", for example:
> 
>   idle-cycles-frontend
>        [Stalled cycles during issue [This event is an alias of
>         stalled-cycles-fronted]. Unit: armv8_pmuv3]
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


