Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180C5C2C8;
	Fri, 12 Jul 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802725; cv=none; b=Lt5A5J71PWl/1sHzeT1EkZyRHN+iKMQd07fawOd5w0wpZs5lG/QZkraE+UjXpJ/Ma7ZHdZuh/umW/ohgmDM34vXgqjHk1Xu4Aanuu5LdHazXogLFrtnfzMmQURKxk3v6aR723c3vXgdHM0oVscUrFhsu/RTIdc1bfJGaUV8bcjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802725; c=relaxed/simple;
	bh=fz1FkdOHxXkL0jA9cpZro/NUbB3UZWCruXEUFtwB72U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PI335MHhLQSMipr5zQl9thkbvrMlbl4J/4hrJdmq05Q4BLlcsBfo1jDHS06dyIf9xyadn+ZrJA6/N2Dce7LG70hfdSeSiZJifE/WPWXDkzP6zi6OqkEvVfUyK2WYhbfQ/DluyxIrCwjUC1Qo/+0PuFEkkd4lFKG9OdavvHRUwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2NtIycx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2NtIycx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2434BC32782;
	Fri, 12 Jul 2024 16:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720802724;
	bh=fz1FkdOHxXkL0jA9cpZro/NUbB3UZWCruXEUFtwB72U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T2NtIycx7YnG4LtxEwNouZg/UJ6Ec44PZ3iSjlW36b6oLDSqhOHo9UZF7gQqLV1fc
	 DYQIGsY2SAPhLYs5NPrMNnG9BTqquuhDvModypusA1iME8QdatG302WYvjHOZb4m8M
	 SmjSpseZGlLqrqxb9cx95wKI8qy/gTbiDStqz9w9W38joRf9yxJj6WGWo7XkgbK4i/
	 hn4GKXh8LjhFwGLQkJGrGeD3YVB6YUy5oAgpCzr79GkXqn4takjEXFXpliSQ6Nd7f3
	 hC6ZlPvcoU1TngKtTheuebTcf512N+IAB28kM8Sd2JsehFf6bqv1YyKzMBIchtis0O
	 6fVz2d4yQyBgw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	acme@redhat.com,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/3] Introduce --task-name and --fuzzy-name options in perf sched map
Date: Fri, 12 Jul 2024 09:45:20 -0700
Message-ID: <172080268548.2773429.10546736534878393260.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <20240707182716.22054-1-vineethr@linux.ibm.com>
References: <20240707182716.22054-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 07 Jul 2024 23:57:13 +0530, Madadi Vineeth Reddy wrote:

> This patch-set aims to reduce the amount of output printed on the terminal
> when using perf sched map, allowing users to focus only on the tasks of
> interest.
> 
> This helps in visualizing how a benchmark or a task is spread over
> the available CPUs while also knowing which CPUs are idle(.) and which
> are not(-). This will be more useful as number of CPUs increase.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
