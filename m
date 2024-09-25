Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88062E56A;
	Wed, 25 Sep 2024 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727304024; cv=none; b=e1mzgSM01SKuaJfX7wCUaAKvnd6/0B9wHBXvt3+4uFMyuewkgW1FTFlET7GKxr7m5GpwR4NwGScLLOsM9KUBlR8Fxy9Fc4ZuLcXCS6SQWnV6X766CKIgmJNwxsuJCkR6Q2vyvuq7aW3TNP5asu8A7eblEOJAZtwYIVKvJ7aOMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727304024; c=relaxed/simple;
	bh=89H0dHRotcITW8gkywOlmms22eTl7HHXleDUdRH2eds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flREwiBETpSzCCO2WhibUeiEIzMXrT8klsS8y0KUkin9K+m0uv2xg8RVkiqODaYR1HgHHVrGc8NfnUbO6maFiha5llvcxckcI9juVjnxSQQ7kYFwQRnvf9BSdaZniBwYcWhfSEQYOJq0iyp8yg7cyOsqPBXqsZw2/wjO7vabWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwYWefqc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwYWefqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EFBC4CEC3;
	Wed, 25 Sep 2024 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727304024;
	bh=89H0dHRotcITW8gkywOlmms22eTl7HHXleDUdRH2eds=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kwYWefqc9bfwjRemBp1GEJVJi+fwuUGtTa/MXeU07pw892U066JGor92/yoZhqDME
	 d8/xiDQ0VtnM/mWGpLJ0rwGdFJAIoAKALfRfbtpKtV0uKQQHSXOgkT/OGT4FFF0S2/
	 ThDUzzid4zzcGZl/GQZ6zCgTt7yGEVZsGzTO0hTxpD3Q5pFkFC1R1R2wVbSVxDuWcm
	 JR5XUxzpyV4Bk3KDETe+LpAbHgIEht04jwtQpiUOdueGdjX6G0qo7VWE4TWAteoBlf
	 rNC6xCIk8dhHMe17j0TozrWMYVIEHnpk7Ed06yVdquhwXhzrNhbAP/Hl6llR9+ZzLq
	 rH27MgmiQGoEQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2] perf test: Be more tolerant of metricgroup failures
Date: Wed, 25 Sep 2024 15:40:19 -0700
Message-ID: <172730392631.3246951.9952274941815216570.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240502223115.2357499-1-irogers@google.com>
References: <20240502223115.2357499-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 02 May 2024 15:31:15 -0700, Ian Rogers wrote:

> Previously "set -e" meant any non-zero exit code from perf stat would
> cause a test failure. As a non-zero exit happens when there aren't
> sufficient permissions, check for this case and make the exit code
> 2/skip for it.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
