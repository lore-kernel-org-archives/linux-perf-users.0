Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B833A70E;
	Tue, 18 Aug 2026 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787088205; cv=none; b=PNpBgSG1QTkUjAzx8Y7ybaeiXkYiFX1/m9aQZHj+iQ0yAOyv7EDJofF3zDRzz96xZfbwYKnDtR9XR/s2NCOtSSYE7Ujfh2hRgX+hp6xr7tafhmpWSYex8yEhYfvkcJEsctTQ2RM8g2owaWIn+Bgwz5ysCeWzH2EjMq8dL+ran4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787088205; c=relaxed/simple;
	bh=w3iZyoMUyzY/d1rktT8WuyAMsMY0ynD45FsOqHfO7kw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZBK8N6Xz0esuAQyOUN9NriXKeeeW6RzZVXmifx2r08ef+ZfOLfyhuFPMHBoOzwtBskoSZI+9egd5tZNeBbEwFkVzg8+eZI/utZFVExU6RdNhPpIGOGN9QpXWs0Iv6Y+tNOkY1Vg7221iFOGwe1+vXnJWs4vMgkIk14/VZXy4tlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1oQPcRK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1oQPcRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943191F00A3D;
	Tue, 18 Aug 2026 21:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787088203;
	bh=DlK0/M/5LbU1lPSxuxYeEd4K2IxnPXpvav2pGLkJjVI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=e1oQPcRKd4R3DopVb3bmCkRYrDUH8h0GAsipYqj5pvehHCTKzt8NDy3HtCBf+cI6y
	 LV96AfT3YkcgeRTF+7VNNpTA/26zVwHX/ZG8bzfQYgX+0eOLHI96zHUSc8V/ACGmMC
	 qpxkJAsLSQXATYK1trAH1IdoSStFZq01VsDwjHvKg5dGAZ5zmLBKdrSdEgJAsi2eoG
	 xYqbXNJ4c+n/3Wz/ZL241VNtlk+DRDVLIRONDkr7wiyZlXkv7N9KbBYbilhFcSZmPK
	 kv4FhQ7WvXbePntt5dRQ8OwGfTKSKm7uPJ7Iae52YJ4aTZuCrOgo3B6VloQs/TCCn5
	 tNScvuFWSqO0Q==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 mingo@redhat.com, peterz@infradead.org, tshah@linux.ibm.com
In-Reply-To: <20260806041414.20327-1-irogers@google.com>
References: <20260806021038.2291417-1-irogers@google.com>
 <20260806041414.20327-1-irogers@google.com>
Subject: Re: [PATCH v2] perf evlist: Warn when 'sleep' workload is used
 without system-wide (-a) option
Message-Id: <178708820355.2068376.15426283047599013628.b4-ty@kernel.org>
Date: Tue, 18 Aug 2026 14:23:23 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 05 Aug 2026 21:14:14 -0700, Ian Rogers wrote:
> A common mistake when trying to record system-wide profiles for a given
> duration is running commands like 'perf record sleep 1' or 'perf stat
> sleep 1' without passing '-a' / '--all-cpus'. When '-a' is omitted, perf
> defaults to per-process monitoring of the sleep process itself, which
> does not collect system-wide activity and records very few events.
> 
> Add a warning in evlist__prepare_workload() when the workload executable
> is 'sleep' and system-wide mode is not enabled.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


