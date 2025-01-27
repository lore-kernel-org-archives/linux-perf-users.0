Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BEA18FDDA;
	Mon, 27 Jan 2025 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738002908; cv=none; b=NbUMA0J5VZvm4AhHZe8MI/1XJ/cBa4uduMA/jDo6d8JylTKA5ox4vyUCwJ7wOfQ9g1KeMx6V9O7vb+F4giN7ehNH+2KMYNBXQhRHVSrgM9J6LEWGWpYhVXT8TPbRC1WBIuGeqCV/NHmoCW2jp6CDBvZHHngoyONxqI3xjwpeklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738002908; c=relaxed/simple;
	bh=dERTfVk9xbmRISZO2txnelT4RFFG9bNlKVozSZahXk8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uumBe2JNMSj2O7mIWQ83G2slkT4wat6UWCV2ZxeYHscTIum5oj5iPjeYqyz+wUV/71U12JZ02QFADBj5ioQ1G3Y/ZAYIblcux3nxvOSO18vIdl/+vd4k6u+98XNhisb8W+HjV4DRYX2uDlxjaVD/uIl2xrcaWecfBigFUieGUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qivj5U5M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qivj5U5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F808C4CEE0;
	Mon, 27 Jan 2025 18:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738002908;
	bh=dERTfVk9xbmRISZO2txnelT4RFFG9bNlKVozSZahXk8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Qivj5U5MNVlTMYwFLLfOT4FDpqjuyeHy1Wu2gEC9RMj3HN+BnN7aSFZpyZgMifzbw
	 Iv3YUC6R3KcX3bhSXEHw3Kz593MIUzLJ2zC8q0jJyWebFxpE/ciA19ZDtoJTOULpjp
	 WK3Nl9/XvzN6XWFCJV1jX01BcUqPOBlgl75eHkVZtyIjElTDHLb6Be+TTOV656zm+5
	 nV7ZiBWlHEhFdPl3oSHm0ZG2mqutalDQp3PKlVafhhJ+XXD9XA3moAlaw5YN0XBYWe
	 PSzvi0kvuEVD1Wy115wI1A+saqSGjFEEO1VjbL1GN9QOKBZWiHcJJZ3Zlkrp0RCUXi
	 GDD40br2dFEzg==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
 Akio Kakuno <fj3333bs@aa.jp.fujitsu.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250122163504.2061472-1-james.clark@linaro.org>
References: <20250122163504.2061472-1-james.clark@linaro.org>
Subject: Re: [PATCH v2 0/2] perf vendor events arm64: Add N3 events/metrics
Message-Id: <173800290747.34478.7772336329501115835.b4-ty@kernel.org>
Date: Mon, 27 Jan 2025 10:35:07 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 22 Jan 2025 16:35:01 +0000, James Clark wrote:

> Changes since V1:
>   * The generator script wasn't adding new common events properly and
>     also wasn't generating groups for N3 and V3. I've fixed up the
>     script and regenerated.
> 
> James Clark (2):
>   perf vendor events arm64: Add N3 events/metrics
>   perf vendor events arm64: Add V3 events/metrics
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

