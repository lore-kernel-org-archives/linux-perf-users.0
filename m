Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6832D839C;
	Fri,  4 Jul 2025 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651739; cv=none; b=qZvp83bHC8SBkqgoOK8A9NAqqA/AEi0woJkaFpLvNHAsp+rxutVdGwEqIlfRvgHxwpw5FJz1JElU3EYQ+bgwk4dLQMz7w4x+Y68cZxlNVVpJ7Stu+XPaVG+PKZzFyvmStVf36WvSGHWvVsXspeNU77Sn589NGPRhNIsSWbaV+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651739; c=relaxed/simple;
	bh=UKLnwGOdPpHLJ7sTxY1lA+Ws2ImagWBSPW4hqzfhnAQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gbWrzwmgD8TMUSs1SPKlq+lJYNusxPMsqXkVibTsEg2X/9BTn0H+XOMU9xcGswORV74LQ4ArTYO06Jpgn1KwQudvSzFpjthxiaVf7Lr1chgz/RWsP/e+kCdgbL4VabbQ9Z5NGdu1El05Pu7sK5wOhZwl3FqINtWMt5kQVKs0GD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQDc8gEp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQDc8gEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FADFC4CEE3;
	Fri,  4 Jul 2025 17:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751651738;
	bh=UKLnwGOdPpHLJ7sTxY1lA+Ws2ImagWBSPW4hqzfhnAQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=eQDc8gEpUQLzn+1OPT6E9KwduK6yqKfkPKplP70xgW3KtRUJ1oCRHN2244lUqedLC
	 b7gTuWIDBZpb4r8QcCBTCroKZFHrA0LoPQ/ttsyYHzJqNtbI3MtACPcMUtVl/qc5EJ
	 buRbUxFMERB8a6wKQihtx6yXlSDosiaR3Y60J77DZNLbHduLGK30Eq4lFfsUKmTRxd
	 Cfia2/lsxzOxFgfEXmZC9IgquEFfcRz1Js1/ZLXqG6wTj62WJTgDtJtABGfNF/awSb
	 ImD0qRu5teRx4hOuoDP+h0v9jm4OUFaRAa8CUu7Houe8zlrRdKyRUkwzjY00obsgOi
	 iqifHNQsTzMdg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250703042000.2740640-1-irogers@google.com>
References: <20250703042000.2740640-1-irogers@google.com>
Subject: Re: [PATCH v1] perf header: Fix pipe mode header dumping
Message-Id: <175165173800.3149172.11734116965485342264.b4-ty@kernel.org>
Date: Fri, 04 Jul 2025 10:55:38 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 02 Jul 2025 21:20:00 -0700, Ian Rogers wrote:
> The pipe mode header dumping was accidentally removed when tracing of
> header feature events in pipe mode was added.
> 
> Minor spelling tweak to header test failure message.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


