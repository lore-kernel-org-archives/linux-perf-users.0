Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08981EB9E1;
	Fri, 27 Jun 2025 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751050387; cv=none; b=FraN7xRGEhrOgDe0BCG6ZmMuoAq4QB9P4PNWS2O9zuKqAjANax3OBckv9lKwXhdiv5gXWaTUTbGCVq4LxhzJ6utKwmpIGP/bqMkYwE679NUWYBYTAjHm0Z90v3Uh9BheGgo+BRub/lZigWZXeukwISSNazBw8jhlNgHKHr3FfP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751050387; c=relaxed/simple;
	bh=ea1V7zv9OOKPcZXcC8m2UzAbXOdgBp9lR7cH1LLkPFs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EUSKFoaqczhmnI5A280vY4NmyFNQ01m2JHx7WaSuGNUDwEQ4FL3Nj1UmCMEdGJwJxKmeVLHqD2Hy/kXyeb7Et1ZSuVh/mJR9AQruxqBeR/PeR14LoC6LQgqzHNOZxcB2kPC+br177zgflg24n2I4FOIEsVtBIVJ5GIQjC5J7hLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITbwRkot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITbwRkot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC94BC4CEF1;
	Fri, 27 Jun 2025 18:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751050387;
	bh=ea1V7zv9OOKPcZXcC8m2UzAbXOdgBp9lR7cH1LLkPFs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ITbwRkot7Ib5BdmllyjI5jRjIum+Zs5ZcRh6phH1xaMM43R//6soTrsGhapv/piQ3
	 UMcpvSXsjaZXepd3cEUKC7X258Tfhvye4cXZxR19a0Q0s7G3jSXQlvU+AgC9lWwtVw
	 +Dhf3Se7wtjWqeVVR9DvFMbec3kMzrqE2Mq4K33KNWqWL33Z/RleJBICIKRYo63UCU
	 v+tZpk0vCslpu7TAlAGn1jNlRU1KWTXDQSXzFvokHRpnTxwYUNV1w/33obUNOOPjYM
	 fBYLm+M2yW1dkGIW49RYu/opiBdmF99QDr4RendKJiypd6efyuqpPSrFT7H43E/t+m
	 8sSdUsnfuC8Vw==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yuzhuo@google.com>
In-Reply-To: <20250625202311.23244-1-ebiggers@kernel.org>
References: <20250625202311.23244-1-ebiggers@kernel.org>
Subject: Re: [PATCH v3 0/4] perf: Remove libcrypto dependency
Message-Id: <175105038680.2492671.15332871169080946858.b4-ty@kernel.org>
Date: Fri, 27 Jun 2025 11:53:06 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 25 Jun 2025 13:23:07 -0700, Eric Biggers wrote:
> This is a reworked version of
> https://lore.kernel.org/all/20250521225307.743726-1-yuzhuo@google.com/.
> I've changed it to add a new minimal SHA-1 implementation, instead of
> trying to pull in the kernel's SHA-1 implementation which is not really
> designed to be extracted into userspace programs.  I also added a test.
> 
> Changed in v3:
>    - Rebased onto perf-tools-next
>    - Removed unnecessary parentheses in array indices in sha1.c
>    - Updated my email address.  I've started consistently using my
>      kernel.org email address.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


