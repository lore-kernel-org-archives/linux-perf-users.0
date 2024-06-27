Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6791113A276
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512463; cv=none; b=EZ/pjNXze934+D6zrhAhvj8Xe5vOQrKQVk6Hs8li3QxkIIInCGbAfXS1C1UJwTC61/LExx1LoZK6b8lbEI+lc90ki34pmSqIgwR4EGuzs2/A/zdOmorL+H9hYaoGROAikGkaqNeb2JnAiLPsnuj4StWlvNTk6XLRPJgKgVABzo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512463; c=relaxed/simple;
	bh=ml2uPtC2kty28CyMUl5Uk2b6HcQX8FWxNGRsamXc8Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttf7vcHsBoqm2GcV6PGJl7pC1oiJRQaNQ9yVRS5OjhclrB5MBXOlzhRgS13lv/BZ1GANovzO0d+a2TVXeg8K0BGlbDTh1EiovLMbo8I7rqwAWZXeefP3bo3ihYWBK7zZUaHq/eEMd/hjleAWkGvf9foJE8M3yPfEyAPrX+bze/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AigXc+6g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AigXc+6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F4DC2BBFC;
	Thu, 27 Jun 2024 18:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719512463;
	bh=ml2uPtC2kty28CyMUl5Uk2b6HcQX8FWxNGRsamXc8Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AigXc+6gY6bH7w69cLlRVFDYI9la+LHy/cm0AvSGnbp8DemLiAsSSrnY6zfvPp2ny
	 4HSFw2DtzdukjUL2BgaOgh3fdd2mUzLXuLx06rHwi/1hd4iYMoYOg5QQ6BqpvoCtTR
	 MI3ZWc6O2A137E9xgC+By4bpnCd8y0KH1qOuUhiLTA4/dUjzI4X2bLWpwYlDATDHL8
	 XgGPpLGZzwO84dkhVwLoRQQ6LXLkZAu1Yfiip9eN2jA5ZkUrDLpqHYG/YjhqgHhrAc
	 cHZEitzHPvNnMOoW/Ow4c3JBlI7qh4V8DP+ELKggopqXZn5V92BBaMzvSURuz68TB6
	 0ltgIhmPv7TBg==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	vmolnaro@redhat.com
Cc: mpetlan@redhat.com
Subject: Re: [PATCH v2] perf test stat_bpf_counter.sh: Stabilize the test results
Date: Thu, 27 Jun 2024 11:21:01 -0700
Message-ID: <171951244238.6240.4224681167685980527.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240625092001.10909-1-vmolnaro@redhat.com>
References: <20240625092001.10909-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 25 Jun 2024 11:20:01 +0200, vmolnaro@redhat.com wrote:

> The test has been failing for some time when two separate runs of
> perf benchmarks are recorded for cycles events and their counts are
> compared, while once the recording was done with option --bpf-counters
> and once without it. It is expected that the count of the samples
> should be within a certain range, firstly the difference was set to be
> within 10%, which was then later raised to 20%. However, the test case
> keeps failing on certain architectures as recording the provided
> benchmark can produce completely different counts based on the
> current load of the system.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
