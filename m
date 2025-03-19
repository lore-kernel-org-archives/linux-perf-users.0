Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D61CAA89;
	Wed, 19 Mar 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415210; cv=none; b=otZtJpmOuq0uq8lXxRuyPErI0IDcMP6qBXrG1zZ1S1uYXzJFKJGX5aJ47aUTI7JKZcWiwQzN+VEGJF4ZWcVN4e9xQhfF1/1EFdCrhAGB+KyOI6HiA4wSTbvm3K4vR7973ptI2wA0x/yzLg5Hb6bot9I/4A+1m0von0Rcp0P9LSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415210; c=relaxed/simple;
	bh=lOzyWTaFdm5D3cOcIb0lxqFPvrXuA8d/dvQka1kG81k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uAILrKyh7gJM5yXl2BKg0lQdY2tdIDWzII00rVfnm5woY6AVIU5/hZd1IwjVgGr9JXVgn/6ZUbZp95dli02G+CFKCWP9imNzCMmz/KeyNWxgwndMWZv46swCvjacrMOsaYpJN/xMq7t+xuj3ApM841GecULuCXceDNBJWtELMlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvrRNkLV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvrRNkLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21487C4CEE4;
	Wed, 19 Mar 2025 20:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742415210;
	bh=lOzyWTaFdm5D3cOcIb0lxqFPvrXuA8d/dvQka1kG81k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PvrRNkLVPrV8HXySBA2gPZzGQvVfRLatWx8VKEau8dTL9eb1aLxYJREhid/7yU/5W
	 EbSLlWwKdQxoozkSWsuAIebrS8tDQECeFHWEdHolZ5q5/gctfmzkD3mQa3kPsoKRnV
	 sK6IuLXI5Bhk09b5/fhYIK4IFCwT59vQNSKV0I01ZItBk3LP742qD5s3VUwuU3f3rJ
	 pvp8ga6cE/3Vo1M59WsHWdJa1BezNl5ViX3BWjYWnkKEZQNCrqC57Aa4x8+PRJJBDw
	 kGkBln6TdTCdfTzFDtH5QRlygIcnTSf8MTCromsNADIf0YwFWc3DLNdcRHT6V2z1Z7
	 6BryyDdJGRpFg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>
In-Reply-To: <20250312203141.285263-1-acme@kernel.org>
References: <20250312203141.285263-1-acme@kernel.org>
Subject: Re: [PATCH v2 0/6] perf python binding fixes
Message-Id: <174241521005.3133484.10830372265000276672.b4-ty@kernel.org>
Date: Wed, 19 Mar 2025 13:13:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 12 Mar 2025 17:31:35 -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi Namhyung,
> 
>         So this simplifies it greatly, it almost ends up as a one-liner,
> but there is an improvement as well to mark the event as consumed to
> then parse its sample, because the copy of the whole event was done all
> along.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


