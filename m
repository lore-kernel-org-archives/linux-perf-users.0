Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335E28751B;
	Mon,  9 Mar 2026 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075698; cv=none; b=VS329dAiRsKw0ovsVBigE3/9D5aWZ2d69fl6Fp/275UPhk/7ef6IKCDU/EYMldQb4RyZ/Bc5/EUxsMyI3euPxRt67K3WbH2vMMevviPLJTxPyq6B/14fwA8/FUfESrHBBrdQOwaqhfbNe+XBiBzl5g2QR/Omb3ixYBklS4fUqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075698; c=relaxed/simple;
	bh=CccXPIcZHJO5QOOqrPifhK8Sh9bibBOfSpkAytLYqqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hb5uuhDxo5GBHe758lV6zEWFQq8VmVyr8/sf0LcvIyVM70VYxfmqaLU516t3b6ygFzGn8HAghmKEtps/IjmWohA/XSKpNk20B3JimD/DbYWeBTDEit9tO2c681jEMPTQ2fuVZRj0hlWCwStkrVIB+hjKjqqPN8nN43qKogdE6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=secJ7dcG; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="secJ7dcG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CccXPIcZHJO5QOOqrPifhK8Sh9bibBOfSpkAytLYqqM=; b=secJ7dcGch7WJBxEFnZ4EUQhJ6
	a+RYvc4zv5+DkWWCTz/ILf8QhCDuz4HySyxf4VYWe6EdHVk8vlus1wbXtXOwLe+EZLJ/Sp/szIzOs
	6twbqhm6I7oy/0mMWjafO3A4qff194nYq7hK5LSmmaVvaujaUdycGqK7hCTgk6QklwIoLc4MmCR30
	hG/tZmsS6KMcnGPN+AyzxZfysbx8wcA+o7gbM8gE3czVlFHJhWcWrkHkWHUGt/k5unUDKNEg+nxmK
	6hDJfdTyLJSlZ27SdksWKrlolYoUVX642e1Hx2OTLlquru2KTJ1FcePPYhUNM4DT+m/+nHHM3pOj3
	HSSt0kVw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vzdya-002Mk6-Ea; Mon, 09 Mar 2026 17:01:04 +0000
Date: Mon, 9 Mar 2026 10:00:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH] perf/x86: Restore event pointer setup in x86_pmu_start()
Message-ID: <aa77xXNKBRk5gnyp@gmail.com>
References: <20260309-perf-v1-1-601ffb531893@debian.org>
 <20260309163847.GE2277644@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309163847.GE2277644@noisy.programming.kicks-ass.net>
X-Debian-User: leitao

On Mon, Mar 09, 2026 at 05:38:47PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 09, 2026 at 07:40:56AM -0700, Breno Leitao wrote:

> So why not just move this then? Having less sites that set that value is
> more better, no?
>
Sure, let me update.

Thanks for the review,
--breno
