Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4963ACEF7;
	Wed, 15 Jul 2026 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140812; cv=none; b=Uj+/ZElwEGeMJGKI+HTUFBvR3rmzte9Q2qTSIiuM9kluhA+o0mK90UGr4A8u/qoEBFpC1NkkRMiOCLD2nZ1n1Ne/Z4ahzO8J+gqn71wbWPxdPhsxxRLy8vu+LEb6W+r2d9NfnvMJtnOvtm6ruGyJHTojJ7ALY2U3y6Z8uzdUq0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140812; c=relaxed/simple;
	bh=6j17ijxh3oHmzisGaAaq5moifAl58IUJ+UmklCPxRek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V1HiZ1uFyJxgYqk1Qd90c+Ng3T1oiVY/oaTKj8omMY+mU7RL3rwA1NBKfXLLEo4sotDisouaaYZZBz5wzyEy7k8GRNxSUWzYwtKyb1fUuT5UQOttQyKll0DDWXQ9JBs1CyRfQB7KXepY22x6H/ToBpG31Fx7GWSZQvEoba7L+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiwdZIag; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiwdZIag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489A31F00ACA;
	Wed, 15 Jul 2026 18:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784140799;
	bh=W4sp8KP7g56HAcSW1HISMzSmhrW4fHkXhoUfhpEs49U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KiwdZIag9AHStN533ljsqLchM3BZKLHBvNBuWNJ8ijaoj6tSF6GbNf2BD80NCkYKD
	 AhTweNyil06CZHnuQbqXcw/Lz9zwQdhsCRAgian9THtHajUaiPgw+YQNsYjokHY2bF
	 W75aRUBrHOCU8rJ3QpcmSYvlaffvLqvoJAYMUkmYtmvwRrU9c7aYPB8wDZ1GHSNkaG
	 pZPp5QKD3UUhpzi7uNzXEC0YAYmj1X9Okr6DvUDpjtDbIptJZS6EH9H8xz1itmpcmR
	 1xAiawwSziQ2BOvFssUevKnHox4PcBa3wXJZfDWaxhZn6YvafUzyckJtcUBz6xUkAT
	 P0OeAwuN8PUjQ==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Chun-Tse Shao <ctshao@google.com>
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
 mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
 irogers@google.com, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, perry.taylor@intel.com
In-Reply-To: <20260713181757.481164-1-ctshao@google.com>
References: <20260713181757.481164-1-ctshao@google.com>
Subject: Re: [PATCH v1 0/12] perf vendor events intel: update
Message-Id: <178414079926.2318976.11582097083954520870.b4-ty@kernel.org>
Date: Wed, 15 Jul 2026 11:39:59 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 13 Jul 2026 11:17:45 -0700, Chun-Tse Shao wrote:
> Sync the Linux kernel perf PMU events with the latest upstream Intel
> perfmon repository.
> 
> This patchset includes event and metric updates for Alder Lake, Alder
> Lake N, Arrow Lake, Clearwater Forest, Emerald Rapids (including IIO
> bandwidth metrics), Grand Ridge, Granite Rapids, Lunar Lake, Meteor
> Lake, Panther Lake, and Sierra Forest, as well as adding initial event
> support for Nova Lake v1.00.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


