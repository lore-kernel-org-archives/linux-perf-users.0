Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511AB33DEEB;
	Wed,  3 Dec 2025 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784714; cv=none; b=qvGQabKOWP5+3zC2CcbGG0Lnbw+MY3FBJL9v4/+OEfcWLjwI+MtMmNqcyS+boJe/0YJFbxYoiUTvsM5EL00fS0SNWgLPXgHlFHAPLhBTAAixqCVTs3R22csC+NO+5Kzq+zbu6jo6NJlu9Qxq3k/Futezo15VAv8rQjE6IV2aX94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784714; c=relaxed/simple;
	bh=odvDvU39uz7B8A+oDWeMr+EYRQoJwE5bEI9RfPVlWrU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KSFQxAAIW49rB8rRyyvymeIWol2PgCAmXfhsF7152d7RmL4xd4qjkNaf+jgK14trtoFwulUrjIlJkl8SqK+YIjwPf2DWju/WDyzy/fQ9Hw8+Y7Bd4T+PMZN84igRbF4aAF9O4+obVaF9BTe3sAB2W3nimyQq2DmXRrOhZORSQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLZNanAM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLZNanAM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB96CC116C6;
	Wed,  3 Dec 2025 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764784713;
	bh=odvDvU39uz7B8A+oDWeMr+EYRQoJwE5bEI9RfPVlWrU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=pLZNanAMMRGyS+z0bVEpEmPCUBr0iMDgosUvSZJNzNWKOi4yeqswAs4tH0v5bQTW/
	 fHKBCn0ZgBDgUuWYAY7p7UJDTVajExnxmtjgi9+M4pRlkStzI0qkJNoEO0gi/DDrhf
	 GFocxqHn5ZIkxQ8oj4uJHP8Kp8O47ixNzsUAr1/3ARjUWRZNViLy7tTuYRV8Bp7zAS
	 HufqIwtZSnZ55iP7OrcK9qox5hsZqF3Awm3SFaUpDgkucf4QTxLOkQS6rcPMT6wHsH
	 B2FgnESrz4NZFyznTg+VAQnEDsU6ScUVVUgkK5k5P1+VdFewqjQSI6fUxEpJmo8XAM
	 Lk2BLwAKJgSkQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20251201231136.293248-1-irogers@google.com>
References: <20251201231136.293248-1-irogers@google.com>
Subject: Re: [PATCH v1] perf test: Fix hybrid testing of event fallback
 test
Message-Id: <176478471279.3636162.12282429232615352755.b4-ty@kernel.org>
Date: Wed, 03 Dec 2025 09:58:32 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 01 Dec 2025 15:11:36 -0800, Ian Rogers wrote:
> The mem-loads-aux event exists on hybrid systems but the "cpu" PMU
> does not. This causes an event parsing error which erroneously makes
> the test look like it is failing. Avoid naming the PMU to avoid
> this. Rather than cleaning up perf.data in the directory the test is
> run, explicitly send the 'perf record' output to /dev/null and avoid
> any cleanup scripts.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


