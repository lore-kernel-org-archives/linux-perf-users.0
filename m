Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5933D504;
	Wed, 24 Dec 2025 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766605104; cv=none; b=rg+7s79k/nWElglShCWve7VtP5uEsLm28UJz3/ekv0lHsPDY4uVPLk8puxtFMNXDA5tUvNCZQ+y3tMb3VVNZ3WKkbz70RMZI6MERI+7/8hqy6D5oAELETUE/2NLjqbw44zB1oegQ9Xxp1Abi5tz/CCjcTGSOWNbRiuBZVqnEodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766605104; c=relaxed/simple;
	bh=Xrm/6WEVvOiue4lKlDCI1R59OZx7C59wEORK7oDNnuE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EO54HHMp3XzcuEaVJxqV/2kMgRgQcKzGfghqy6FXhwyHKOVel8R0xQ3kIGiYxRzAfGXjoop4bpQtovfjWZIamB0YSANn8/06kDI1qpiAwp4gfoCHrSHdrydRIOSx7NnAZnx58XqwnNYD5v/uJX/BlH8I1g8jywrgS6xPpZk7i5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNvFgZ8O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNvFgZ8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D20C4CEF7;
	Wed, 24 Dec 2025 19:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766605103;
	bh=Xrm/6WEVvOiue4lKlDCI1R59OZx7C59wEORK7oDNnuE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=mNvFgZ8OiTC4q3Nam6IvnWZ7jMjRCZsQVeE47t6qE46xECLYCoJ3VRsvZSBaNokrz
	 1RlAHh46r5gkW9T7Ph5kWVUtFGZ61nu0pDOKRdMyLib9Ehzw8v2nmxgXKohlwFCSdX
	 BRwQ3B2ks7dUyEAjc4rthRrYIJvby0VY3z4IDV+wyIe8BF3nuh5YTZk36GBsVeyCc1
	 ABryva0uDGMsyyAYb6yWsFW1YSuUTZzfqURmPbrgHKCQuvn0dzDQZQRsLKQXLMRgFd
	 OSVhix3OjF7DiD/JeEig6Y5Apxm9Z5xSW0RSdBunVvXN7S0OZ443suvDSO4IlWWAb2
	 hirepoSJcL6HQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20251204225522.648456-1-irogers@google.com>
References: <20251204225522.648456-1-irogers@google.com>
Subject: Re: [PATCH v2 1/2] perf tests kvm: Avoid leaving perf.data.guest
 file around
Message-Id: <176660510357.764852.14792840727445410195.b4-ty@kernel.org>
Date: Wed, 24 Dec 2025 11:38:23 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 04 Dec 2025 14:55:21 -0800, Ian Rogers wrote:
> Ensure the perf.data output when checking permissions is written to
> /dev/null so that it isn't left in the directory the test is run.
> 
> 
Applied to perf-tools, thanks!

Best regards,
Namhyung


