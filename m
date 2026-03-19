Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511F35A38F
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941077; cv=none; b=J4b9UARHUhJAj7e7B423fvuazDPt7utPpgLe8VYopUJyR9l6URC0R1axv2V+WiKNRyIRrbmB2OFrk01fR2OiVIyh2Ri4R2QTTJQG1Ig0hLtqZVnx0zublUPjf10iMe2vwIA8Y8ybCh4u5Lt+fQyEvIg0ZyHkOhRkMM9mLagvXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941077; c=relaxed/simple;
	bh=cMFYt2kg+g3J6nZTkg3mAy78UVtAy4nRAp8S1qIIGMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WX2xXd2czehx8NCH7ls7zMa3mIAewIoG+DXLAdeVxlAd1cohiHSO9XUJClo5bG5escGyYx9rc0oZC3gzuj9NbLiwVXntUalt39di8bXpT5SVDe5xWg4iIhVYgodxvNKqRBVStb0reSDsfVishmDrKjbEU+B6/efm8h9etJs0/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phzYwc5u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phzYwc5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4673C2BCAF;
	Thu, 19 Mar 2026 17:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941077;
	bh=cMFYt2kg+g3J6nZTkg3mAy78UVtAy4nRAp8S1qIIGMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=phzYwc5uRxk/fbp8DmBB5Ppzp9j5+g6S6qgZYogMKUDW1UE3Py31CmAWPzTobz0v5
	 DCDiiqhJCEvuKKZDwquvVcoHgf/jBeVkwxbXgFwkPtRcEJS235wDjQUtFaTGwrhO76
	 61vBS+dr44HOD7cbj+twrkPwmOUCKF46dzHnLRx/Sj6zElAxYfnqSlG5G4YXJDlVTn
	 Ri8c4P5hwJN5DJh+tGll5ZGD/FLovQ98KkKcyyq7poi8wT8xNmPEuKqEjQB5K1Xznd
	 DBfm6ZHEm7tTyR4YMrohe8EdgLAhnov1WrOfVjnEQCz8eywZ8WXkZtZiU8VqxhBJmE
	 xMnw4SEcMgadg==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, Chen Ni <nichen@iscas.ac.cn>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org
In-Reply-To: <20260318040422.398996-1-nichen@iscas.ac.cn>
References: <20260318040422.398996-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] perf symbol: Remove duplicate include of debug.h
Message-Id: <177394107668.14914.3571352055492448282.b4-ty@b4>
Date: Thu, 19 Mar 2026 10:24:36 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-02735

On Wed, 18 Mar 2026 12:04:22 +0800, Chen Ni wrote:

> Remove duplicate inclusion of debug.h in symbol.c to clean up redundant
> code.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

