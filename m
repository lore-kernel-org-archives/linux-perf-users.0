Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E995B2EAD15
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179669; cv=none; b=EliOdqCwsTWtEbl7af1CqyF/PrPaWbHOKyhWm0nL1smsNvUha4JPT2n+jxXJRAbIt22N3weDbkboJ2vSQQE/GlCmbFappLr0HzFL4jpNcrw3r9zMpJjFDFPo9g9DR1Pf5oxtld57dYTZEUJ0r1cdQ0VMN6O1O/kb7qz08/hSjQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179669; c=relaxed/simple;
	bh=H3J9EZr3tvvevdBAgqVrRb4AziVG1y905B7abbKP/HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooV+jJO/L0t0DqUIwkTYffBy3DGutHnnzKAilic5QYK/sPNTfgIu80PhYBthiMLeSBGL8NMw1tLXUrrt2r1i62JiyrmhvLRQrsd2R2l41pnC3vK3h8ryPIoleND4zZ6451WhrbSMobKVk72xpZT3eE13cpTywrj8a2VvznwbfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+3qCKwA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+3qCKwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A20AC2BCAF;
	Fri,  3 Apr 2026 01:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179668;
	bh=H3J9EZr3tvvevdBAgqVrRb4AziVG1y905B7abbKP/HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+3qCKwA0hQ54jmAI7omw55knguLR6cX010JRKDRMcNtrlGQ3CT3uJXcXf7qh3n9w
	 6QXdS6RqEH91dJYN3vrmMylJ+RK8308zzRoIZxv7durYNzXPLLOZMya6QGXqC9Soff
	 1QrsJn1MXWNN6vCVkGujarq1nWm66AClyPIo+zoZY16ncGWtVjf9nUtaII4AQW2Yfa
	 FXzucd1itI57Xg1vCA/hsnqVhcFQFCFnJw+ev8FvbjOjaW+drY/KQ+FGwW+wWPUUjA
	 FMej6obO34XfbJ0somonTlM/mmBOPUEpdJ7kQ3SUeI+XRzSjYwQECY2lSL98zo6aid
	 xRz/qt0JQcKcw==
Date: Thu, 2 Apr 2026 18:27:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>, Venkat <venkat88@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>, acme@kernel.org,
	jolsa@kernel.org, adrian.hunter@intel.com, vmolnaro@redhat.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
	Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: Re: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
Message-ID: <ac8Xkty-lqrIbFsP@google.com>
References: <20260315105751.86835-1-atrajeev@linux.ibm.com>
 <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com>
 <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
 <ac2uvTXI1iknXwyV@google.com>
 <CAP-5=fX6993MzAEgB7JeVEU5GcVk3PxhkEjMX3G4EZgxPBaBqg@mail.gmail.com>
 <A33EEA7D-DB03-4FA9-A0A8-D10115FEF423@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A33EEA7D-DB03-4FA9-A0A8-D10115FEF423@linux.ibm.com>

On Thu, Apr 02, 2026 at 09:15:54PM +0530, Athira Rajeev wrote:
> If the addition of “-a” can cause regression ( like intel one if its not suppose to be run system wide ), 
> how about adding a case like this:
> - Look for "enable system wide with '-a’ “ in the error logs
> 	- If logs matches this message and if user is root, attempt with -a next.
>        - With “-a”, If the logs has "Operation not supported” , test can continue to next event.

Sounds good, you can check perf_event_paranoid as well as root.  Then
you don't need to check the result of "-a" for -EOPNOTSUP.

Thanks,
Namhyung

