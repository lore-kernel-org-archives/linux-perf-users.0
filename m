Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F30215055;
	Wed, 23 Jul 2025 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291846; cv=none; b=uVSPZNWbxSD9Cf4LpJv8/IsBvfC+kQiOSyYKVR2Wr3BwtON/G93oZJhAieTOxN2MFx/5JsxoSL6LufbNjzkkVHAHZ7lpqZXtZqkaI0+2iDFZfyWk0AEmZqoDDPu6jOnJyAjkv1wA+HxJW1va8Nws0icmeKCkswQE3y444qdlSd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291846; c=relaxed/simple;
	bh=xJN02HVRClKYAJEwqIN9Rq8KdG7EBsD1osTfyz/FyQM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SfQM5B40U0d3ZfwnnIe0bejLxU+8H6ib8oEc1jcW7634dr4a8/dwRl3cFkpR4NECYVUDzHJarsaMNJ8ttksLFWjeVAsLlWZ165R8QytuqNCOeBsftuuJ+IbxS+2j6gxoOTgYPMLgdC7XL2lP+8KXMufLHLwl92JOu0Hh5yp+J0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFl3hOiX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFl3hOiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3C4C4CEF8;
	Wed, 23 Jul 2025 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753291846;
	bh=xJN02HVRClKYAJEwqIN9Rq8KdG7EBsD1osTfyz/FyQM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=BFl3hOiXgoiVcaTyeDvk6wKUxJpvRu1ICwXtmre1WJC2VW1h9CJMt7udk1IMXBalp
	 oXJpyZ/r8DLLWKRQYsMWvoS6aXeq55neXu7svGRKDvTzlwenH6Ur06biI0cg2T32ri
	 MaBCI9cEwd3JuA9wLYQP20uVJzc5KEknry9f6Q0iP4lcgm6DsY42QSWJv7EkbLvvmW
	 vPJjC8JvzX5T62/PHjUzWzLdejUrKq/HHOBUl9VHk0LMYUBU2SqmgxnbcUBetZGnnY
	 SrIP8DIbJ3KSeoDtOeZJP78LkiqpFzx/wkMyJPE4cmzkapReVqxVylusx4LMWc74jc
	 4wcOHTYy5Wqeg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250717150855.1032526-1-irogers@google.com>
References: <20250717150855.1032526-1-irogers@google.com>
Subject: Re: [PATCH v2 1/3] tools subcmd: Tighten the filename size in
 check_if_command_finished
Message-Id: <175329184572.30139.15349467815781298838.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 10:30:45 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 17 Jul 2025 08:08:53 -0700, Ian Rogers wrote:
> FILENAME_MAX is often PATH_MAX (4kb), far more than needed for the
> /proc path. Make the buffer size sufficient for the maximum integer
> plus "/proc/" and "/status" with a '\0' terminator.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


