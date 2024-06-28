Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB187157A4D;
	Fri, 28 Jun 2024 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593690; cv=none; b=YIak66+PA2M9JJcj9y5JKpbo2Owg92C/T+CGsW8jusIGH2TfNVlnwFopckPkzz/N52fkVNNpo6Mc7szkEGUhOehn3eOZQ0HkOKDrje2U4+SbKS5UUe8ld3jabizgkstqmxagsQELZGs/Ht2398thsox/8H6BfYv8GbIaAg5Z2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593690; c=relaxed/simple;
	bh=HCIo5V6kVy+GGx2BNWeeWnzUF6OHCNxZE9uxSZ8xo/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNWBRd/VMLu2z0cPwmXkdb+jxH0Nc7a6ek1rd7fG7BdpFxRcK7eziNi/PmvaJiKByMoH/5C9/BIht9scOMhhR9SpAO38Tirq555Bf6xdQUiXWuF5rFNJ3UOL53+hz9ZkYRJ/2FBRWrC1cbPnishtC+EO8JIFXWBCVwlpeRJpBpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rtkub+Fe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rtkub+Fe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F673C116B1;
	Fri, 28 Jun 2024 16:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719593690;
	bh=HCIo5V6kVy+GGx2BNWeeWnzUF6OHCNxZE9uxSZ8xo/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rtkub+FeeK0yymTDyB0vKyPwO4qgf8YaD/dOd7HpNFNU30V7s+NFbcf72nuuVS74M
	 cJTU+fJMV7jBxM+sqT5zGuOjZdBVzwoVPGy3YLiB56Zi/J5Rq/cJki3PzZ+0T6A5KN
	 RdKqa5GX1KBOrsE4tvW49chthHixQKLvC3pduFrjPo0vmsL+455D/p5AoeC1H3cVad
	 gw8togfe8ercqj47Szn5nfWspm0ziXaXTSlAYaoL3tyhBTd+g3wMJJ0uAZ+BcxP03B
	 fY/enkfh9q3OBnQTEv9fwI/jWX5+DcgnihQO6bynKlTBGG6bhTPrGftJTOPlMI12p9
	 wV0v2IWlW14jg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf report: Display pregress bar on redirected pipe data
Date: Fri, 28 Jun 2024 09:54:46 -0700
Message-ID: <171959367016.545005.11373537265295905345.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240627181916.1202110-1-namhyung@kernel.org>
References: <20240627181916.1202110-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 27 Jun 2024 11:19:16 -0700, Namhyung Kim wrote:

> It's possible to save pipe output of perf record into a file.
> 
>   $ perf record -o- ... > pipe.data
> 
> And you can use the data same as the normal perf data.
> 
>   $ perf report -i pipe.data
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
