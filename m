Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258F27FB1E;
	Fri, 27 Feb 2026 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227970; cv=none; b=EvECyY8HbRTQdjjlYSySmu5pWbPwRDb0H9f7RUE0CvloyJm/tUA3UG25w4DAex7VhWfvZSkUlxWXcyUf7hQC6EvQRpBwypYk8Y3HVTPgkVMTo79l6Eir4W28mAROJ8YUOk9f4molpq7sJ7f+zI4XdlwZCq6MBy35VV6UpMsaq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227970; c=relaxed/simple;
	bh=UnYESNcs+zPIgjgXbHeljjXAZjDUOhZihapy0xiiuxI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mtxxtlxVBTL9HHT3WdWHjsqIFh1y/kGa9DOmD5QCiOqU/k18LH6TczmNPoPWGvEAsnC7jgSCHaPmestbCSnSqeqLQC+vOpi6+9sAT5WWlZyhSo8ocPesB5lqNKCyAXYHrZYfEOFNrdAovXCEa/15P4i22I6YsRGlPfZOJrkaGcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7FRk07o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7FRk07o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5346CC116C6;
	Fri, 27 Feb 2026 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772227969;
	bh=UnYESNcs+zPIgjgXbHeljjXAZjDUOhZihapy0xiiuxI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z7FRk07onq9MfIO/1EMLe1iFn99EMcjIAud9X/1OmynMxFNeH+zPz6oC/nazjDifL
	 TMkFG1MZff9LQGJQdr9QAIAR4BQEEkUxZ7uRnVCHLT3FLfzEQ4YcyJVJIXu5ImcfCk
	 AYe6pWA/2WuLTFS+vYEDiutIeenYo7aBZkoMD+H7FmiN+620cA8v6jqx7AhJTUo3hA
	 lZJuXd+YN7yCBC0NjGGuDzWfaXhuvlJ14m+wRhsqUwh+7jEepRjP1u31OTCOOJFwOm
	 Iysfu8Wgc13HAiwWLMsLiHNzCJ3iR9MXU9BGyO5SQlyUcm9LoWNbqSuloZpoWNzg9V
	 GwteN7H9OYx8g==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
 wangguangju@hygon.cn
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260226122208.162765-1-wangguangju@hygon.cn>
References: <20260226122208.162765-1-wangguangju@hygon.cn>
Subject: Re: [PATCH] perf trace: Fix IS_ERR() vs NULL check bug
Message-Id: <177222796929.277001.11130004024791436706.b4-ty@kernel.org>
Date: Fri, 27 Feb 2026 13:32:49 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 26 Feb 2026 20:22:08 +0800, wangguangju@hygon.cn wrote:
> The alloc_syscall_stats() function always returns an error pointer
> (ERR_PTR) on failure.
> 
> So replace NULL check with IS_ERR() check after calling
> delete_syscall_stats() function.
> 
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


