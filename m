Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2945E3C8716;
	Fri, 13 Mar 2026 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773421086; cv=none; b=ibDDt6uoiwJZ0WcNONiMCqBzANgEBvmCdUrtsZNNWBflQULnwQvpC/hc9PC2okxMGgQqWDX0cK0423XUCzUhWrQhUIHQ401a1PEndXrBKZHzkxK+t2UsoBv+NHksonf+iKImLUz8hZmXLb4peRlb0tzHf1MhB4F084VtDvjcmII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773421086; c=relaxed/simple;
	bh=AJDazMIR1rb+7E2yQe7UZWUVUyc3Iv9DEzDUBJULao0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQqd6yuup+Fp/ZLbAJPzIsMPHAWffu9unhdPZxnMsZAE/zhl1kOT/VpifW1fo9EcjknoG8sOPevgTVIvOStZ6RXja53ZMaNwW4YUrnO8qBci9v6Y9GD7JJF/GKFGMyiLiQHPIkd7Qz8OjfzaI1r2uRdhx6XoIbeKljX201btSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=j03eiT8H; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="j03eiT8H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hORKVIgTxx2i96/nN8XIOFlT2ndO+E7zMrwD+UdB/rk=; b=j03eiT8HneW23wfguX7kgL4aZt
	Ylg09sePqsNr1olyrW7OgDuaPj7yV+xuUO0EbJRTSUNc7HH+4rrQQVWRb1v5ZVnOOB0g2KBfEaChQ
	bKKbfqRCmrqU7GP2RsHUKDlCOIUjd+J88RkTt9cMjyMGfbZ1qHYMWSXwsJyRhFT60/57udgxEb41a
	njB7GQncZoKDgDPE4p21YYBCQN4Uq1gh5ISzIyi9WfMFJ4ZONoHICaYzwHkZPjV5luAtbPg2Eyf18
	fGZplKOR+GLfSsTjuUbH70vli1p/jAtjUy8iK10cHyHio8EJbPldBE6QLdXa85X2PRP7ABdODpxqr
	hLsqpvxw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w15pL-005Sws-Uk; Fri, 13 Mar 2026 16:57:32 +0000
Date: Fri, 13 Mar 2026 09:57:24 -0700
From: Breno Leitao <leitao@debian.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] perf/x86: Move event pointer setup earlier in
 x86_pmu_enable()
Message-ID: <abRB4rUT0CIbm65f@gmail.com>
References: <20260310-perf-v2-1-4a3156fce43c@debian.org>
 <a0a1d8ab-85cd-411c-b8e2-9e7e2f7136fd@linux.intel.com>
 <CAP-5=fWAzaKNO0wmAA89ovJLFgxCWQ3khnyWFotnaSAGiugv+A@mail.gmail.com>
 <20260311173509.GR606826@noisy.programming.kicks-ass.net>
 <20260311204035.GX606826@noisy.programming.kicks-ass.net>
 <9e0e04e9-7421-4dfb-a017-c31741a8d500@linux.intel.com>
 <abQPM7zKWBaNJufd@gmail.com>
 <20260313153515.GC2872@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313153515.GC2872@noisy.programming.kicks-ass.net>
X-Debian-User: leitao

On Fri, Mar 13, 2026 at 04:35:15PM +0100, Peter Zijlstra wrote:

> > Thank you for the patch and the discussion. To confirm my understanding:
> > this patch should be applied on top of my v2 series to fully resolve the
> > issue, correct?
> > 
> > If so, would you prefer that I include both patches together in a single
> > series, or are you fine with them as-is?
> 
> Yeah, I've got then in queue/perf/urgent and once the robot is done
> chewing on them, I'll push them out into tip.

Thanks Peter!
