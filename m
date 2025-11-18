Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242EC23BCED;
	Tue, 18 Nov 2025 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763429739; cv=none; b=JxWxtVXIYDEGKxiKtvLfC7by342d2UkCG8dOGwH/pqOVjGHSwrv1vmIAGFVAapczfsKotryPgBYSnQ4KaIDam8lLC6dPK4twh389myTnRekn6De+e0zPp5BDyn2f/XM6l6OUauHVC5RkFHG6ZcZXyF4NFgnVNvIOCXVBykbfv1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763429739; c=relaxed/simple;
	bh=1A3ueFJQdKAL4IrQZDG0qekVv1j8MkNba+taOgIOFJw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MBvjVu3d8P9VvfuBS7xoIk84N/Z1a8Acz2MQVZN/zwfJluPUg7KrvMRoz+OY1mQjYzWq2uVPGmEzAWEfKSICgNaqPaX/L3lhViTfkgfuxqDwnKU2miOO3v8YPzg3ttEeAvJyAiiAHSd8erEg+/OPRKJKRyjjeIWhTybfOiuEzUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZn8Ir2i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZn8Ir2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C10AC2BCB1;
	Tue, 18 Nov 2025 01:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763429738;
	bh=1A3ueFJQdKAL4IrQZDG0qekVv1j8MkNba+taOgIOFJw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FZn8Ir2i6TjFXjh+oxmRYRZqmy6Lx4NcK+CyW1lYm3j/+UAteu1nJXJW464om6QT+
	 2o/+e6+FItZPm2UWa596rJPcssqQWJsKEKf9rh/pgEBAffEqNe9hAxfpL0Fejpnvic
	 rKVt03DP/lCluxy5mwI80SswUjeYNcHVcWDxlS9NZ3kOTWgOKJv/5gpfJ+PYimhVKv
	 /rbZZ7jZCdt3smt7FReyk4VbTGtL7kVyFWK0EWHDJWgOspjFs6p4EQ/YFw64H2/chk
	 XR5czoaIc0D4YdJZAQago+7m7a9JgxG//d2Mv3P78JKgt/6/KgyOQUx8bCNzjKmmSh
	 QrldhIuiQzgVQ==
From: Namhyung Kim <namhyung@kernel.org>
To: john.g.garry@oracle.com, liujing <liujing@cmss.chinamobile.com>
Cc: will@kernel.org, james.clark@linaro.org, mike.leach@linaro.org, 
 leo.yan@linux.dev, suzuki.poulose@arm.com, peterz@infradead.org, 
 mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250922095057.3136-1-liujing@cmss.chinamobile.com>
References: <20250922095057.3136-1-liujing@cmss.chinamobile.com>
Subject: Re: [PATCH] perf sample: Fix the wrong format specifier
Message-Id: <176342973594.1348495.12670854655035999916.b4-ty@kernel.org>
Date: Mon, 17 Nov 2025 17:35:35 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 22 Sep 2025 17:50:57 +0800, liujing wrote:
> In the file tools/perf/util/cs-etm.c, queue_nr is of type unsigned
> int and should be printed with %u.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


