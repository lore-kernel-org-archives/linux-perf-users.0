Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E9212FB8;
	Tue, 18 Mar 2025 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320939; cv=none; b=Nfb9dNQSyjRABViZXSS8dwokm0ArHw2YxxxnF4YV7msD3Jfybh4rU3nZRwyhh0H7BVjgd6dyT71oCgL57cnKDBsW1qVOcPkWSBCI7FVOz5MpNIFdIzCiU12WMSSkfWt9HooYyzsRcHwUh08+PTVMOWaQrJZxcFUnTVre1MguDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320939; c=relaxed/simple;
	bh=vE5+qH3TXp7vqXVeezqWNJ9F8OpjH3jzJMAo/m0FVkg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rgDZs6FzZQXrc5p7VAI0C+vtRispCr6umDrdAKDEwMaSoTNOQXUtdhHpLcVccaNQFY9M2sxQmhawJAYxqI9nVws6WYfW6m+l4QPUxWeMAi94jv+AsF1jPQWDkor/8r1/vNrC/qlybqBPNnn9sxqIiQV65EL2/z8Wp/uY6mTu7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxBaxjJ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxBaxjJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD61C4CEEE;
	Tue, 18 Mar 2025 18:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742320937;
	bh=vE5+qH3TXp7vqXVeezqWNJ9F8OpjH3jzJMAo/m0FVkg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=DxBaxjJ9ruFnbcGcbqjvz2vUG7fp1da51MoxwaLhhrY6wliuBXMm42NMd0KX2mXb4
	 A7PkqkTycKfRAk3v4C9fIjbLNDrsuU2SIOCfoQ7jwqbE66z+4sA1QoAHL3OE9A2us8
	 iAHizeXdmuPxh7G3eZAsBgTGKGdXKlT02fWAqsHrJ5U7FuW147rCrz7brpTOVMKdwO
	 kb/udSbbHEtdtoSFButFgkj91vJXR77A73308rX5e5O7bT902tiQfrJW7jRjAjP/h5
	 aQsvvxe0aT3YNT5Mspkk5Ld954z1Uh16tTIIn+46QsOs1O/KJ1hkVc/TD5e0nnGChc
	 kNm8W/QzBUm9g==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250312001841.1515779-1-irogers@google.com>
References: <20250312001841.1515779-1-irogers@google.com>
Subject: Re: [PATCH v1] perf tests diff: Fixes to variable expansion and
 stdout
Message-Id: <174232093760.2542685.11014481276305317263.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 11:02:17 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 11 Mar 2025 17:18:41 -0700, Ian Rogers wrote:
> When make_data fails its error message needs to go to stderr rather
> than stdout and the stdout value is captured in a variable.  Quote the
> $err value so that it is always a valid input for test.  This error is
> commonly encountered if no sample data is gathered by the test.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


