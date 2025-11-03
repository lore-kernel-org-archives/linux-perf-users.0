Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D2E31DDB9;
	Mon,  3 Nov 2025 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192422; cv=none; b=TmrrapRJOmqwDRdVaG6bWjeAD+mGbrafk+Ac9nNCd7TM5aL2i5iMEHAyUZv1ZePg2JbcZNkTBKhj1bbaccPubkScn25/Mt6iewLxJ6S0dquyLoCcTbDi7T9ZQDyKal+fTfvE93WD7GowCumjeJgTBvHuYLqKsdWIx4yn2piXbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192422; c=relaxed/simple;
	bh=+GLSnQPf4Wubvuv8h9ufvHvX1RLnyGg/LNSXT7/xiVU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eImxS7o6WLSLo9DwPT1EXrrGwBrBXc4z8YhmxbPSial9IoWmHj3BTxiiKTCDy7+aBhj0EWBRlhdi56bNaBIVS3lnqkmdmrMIOIbEdXYfZYfxJCIlQpCoscguL/Q6leJkWuP2XPkzRZKel7XWy40cyg+ptBttlnyUdwqXzRBM7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6bqFsla; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6bqFsla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B289C113D0;
	Mon,  3 Nov 2025 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192422;
	bh=+GLSnQPf4Wubvuv8h9ufvHvX1RLnyGg/LNSXT7/xiVU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=F6bqFslaKu7C2em1zw4Mg2Ad1ZEMLVZZSjlyPBzaOEMeV3oUWorTTSeBO5/X+DGC+
	 UzXtt5RHc3FFQaELUkV93tB/PE1b92HwzIKCsLMJ2cuSAK0zy4bNHE/h9draqL8DjX
	 a+gQZO9ZRHmTvBP3mclWlG8Im+HJmXCnaypkRFgkaXt1d09vBsjKKlGKxbS3F9xJn/
	 Y4CC8T6mQPeDD4hdtvB0zYxVkYGHq4/9xnIPiT2kC7ZABRKCZrSc7NAJwwTuDHaWje
	 npKnc1EMlDEAFX3HAaTmRx72WvZT1aNsBSMCp6tQQeQ2iGOsC2PWiZw2KsocdXdido
	 A1zIoHeCqvW1w==
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20251031194216.1518072-1-irogers@google.com>
References: <20251031194216.1518072-1-irogers@google.com>
Subject: Re: [PATCH v4] perf s390-sample-raw: Cache counter names
Message-Id: <176219242132.1981113.14223031712122079931.b4-ty@kernel.org>
Date: Mon, 03 Nov 2025 09:53:41 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 31 Oct 2025 12:42:16 -0700, Ian Rogers wrote:
> Searching all event names is slower now that legacy names are
> included. Add a cache to avoid long iterative searches. Note, the
> cache isn't cleaned up and is as such a memory leak, however, globally
> reachable leaks like this aren't treated as leaks by leak sanitizer.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


