Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A71929408
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 00:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246550; cv=none; b=oAaCjvpnRuVjsBSMV2I1GqEka9kOwgoiag/gVxgg0/Jr3gw2Ak9zgaXOYFbd9QvgYLA1lqSg2nOq5ZNw8sBfyUtbUbmkNoPQGY9Tf7x/PGt6/ymQDoIaw++W2qdSN7cmp40fiebpRpPpg+tNDhYjd0jdPz1P18p0WrbmRjZPKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246550; c=relaxed/simple;
	bh=dKfzn9NMhn6EAv6UHq/Cgsx6lIipgiH1d6754fcZxIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s773EKMh4zo5LHEfc7QWG2MIq1SXQsf1pzmBOY7ImsXglHcN0Ac8SmX5f+cs7H/GnGCKpUvs0Ss7P1ASRoMyYzlJVJjN+1C4GhvCWa1vPnm6KAJhlDF9ZqXg6o5iqwlU6dg9nL47TJvIEGxj8W1qIizoa8WhgbfEXpI/2hCSGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLMHTJV4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLMHTJV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA6BC4CEE3;
	Wed, 30 Oct 2024 00:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730246549;
	bh=dKfzn9NMhn6EAv6UHq/Cgsx6lIipgiH1d6754fcZxIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLMHTJV43RnxXVmFAMOxjCKlVxeMATQFuT9j51hfyLfbdijfXtDPGgNdiKsSDyRc7
	 PyPjmM1+EHA144rmOZ2apEIFU0yvgobayAQ5KoGJfXiTRSAlhnxuZ0a/4b+TSL/anQ
	 AY0R/0Un68SRyzaUEvrxj00EVSw4uxCDcRBHbE2Q7JrGSATvDoPY636d2T7AkpFvwR
	 2hytKndKXgIH45YzaG3GKtOCbp5iXjJPBJNsO1SnUN9r23sodixKeir6lfjosSOxSZ
	 UMgE0YXM58fTsC5qeaKnzk5SYcSXciScTEUhpwV9vGVJrPkxgsGEPQxZhfzbUA+hP3
	 hrtbzR9aGpIYQ==
Date: Tue, 29 Oct 2024 17:02:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: laksono <laksono@gmail.com>, Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: Intel SPR: perf-record doesn't support topdown events?
Message-ID: <ZyF3k__jUtRUAcWm@google.com>
References: <CALwKgup1UhiKMHvEni_3gaWoC0BLu8kkT6R=7R=b-LkBx5_3ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALwKgup1UhiKMHvEni_3gaWoC0BLu8kkT6R=7R=b-LkBx5_3ZA@mail.gmail.com>

Hello,

Adding Kan to the circle.

On Tue, Oct 22, 2024 at 11:40:25AM -0500, laksono wrote:
> All,
> 
> I am interested in using Intel TMA support in Linux perf. I can run
> 
> $ perf stat -e '{slots,topdown-be-bound}' ...
> 
> on Intel SPR with no problem, but running with perf record doesn't work:
> 
> $ perf record -e '{slots,topdown-be-bound}' ...
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (topdown-be-bound).
> 
> I suspect MSR_PERF_METRICS cannot be used in the perf_event sampling
> mode. Could someone (probably from Intel) confirm?

I guess you need the leader sampling with 'S' modifier.

  $ perf record -e '{slots,topdown-be-bound}:S' ...

Thanks,
Namhyung


> 
> My Linux kernel: 5.15.0-86-generic #96-Ubuntu (just in case this matters).
> 
> Regards
> 
> Laksono Adhianto
