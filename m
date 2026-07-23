Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735A33B1025;
	Thu, 23 Jul 2026 05:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785313; cv=none; b=sLVgWdTQj2SzI7ePC7TAvL3iEEZyEobauo3UeVpJ6ItCQFfAfx+19a/NlNtFG2eTVYvdlAbh2TdAmxlLF18/JRrAv5rju7sW6MDsxF4gfULc8+WIjiW8uNVKpD5aWuz2X5+GII7Q9giI/7Gv1luf8kUDRyo6iKcn4c2GPwxPRVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785313; c=relaxed/simple;
	bh=OoyeuW4o0JgY7GRWOoC1IyvVme/e0Ko/55215aLkzEE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OZvvIPhCBwqMCEddLHcyCem3nOq++SgBrpIrWykfq5TkSDCEvkS0qfbDzbHapgxtwWB1azmuL2QMXUy8JgNKQlKDzkwl27jwElP7iDh+50+BldP7F8FV+8/GQuqRxD0yvoTAMZwovHX9z+90Ha9soLBMyTigvx2RkRlyLIQEAjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1/humrl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1/humrl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49801F000E9;
	Thu, 23 Jul 2026 05:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784785312;
	bh=vcO4pej2JHp18g+G9FsNUIDyesuagcI3gviAw5stuYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=E1/humrlY9x635lx9BmHtWQwP7KWSZ85MUIjpT3O7Of+2bjCRSm1MiMXow+JuswRj
	 fc+yeuDWVFuATUyXIUqbsMa6RwpN+HvmsixVFQRjlQTVDPs2EoHc4A0y/F1hddsFXx
	 Xmm+IztlycpZEWeDmNBHmfjL7DyRqkpas0oCcxL3O0IGSBx+ZxXJJut17C6J6DpvpK
	 OTTFwraupdS6kQ5Dc0hQ9v3DgKiXlNLNSMMtpNREpOTgs+dh6BwPKggBWPP4xWHVBp
	 gFbtmh8fMwar9i11uAbZPdsaJIQLRHdBPGVtPZZBwLG7a18XchKnMOGc4hz9Y+ZGJ2
	 B451yYA2VOUZA==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
 james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com, 
 chjohnst@mail.com, sean@ashe.io, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260719013800.404370-1-atomlin@atomlin.com>
References: <20260719013800.404370-1-atomlin@atomlin.com>
Subject: Re: [PATCH v3] perf stat: Add --hide-zero-events option to
 suppress zero-count events
Message-Id: <178478531163.51855.3309729588360804449.b4-ty@kernel.org>
Date: Wed, 22 Jul 2026 22:41:51 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 18 Jul 2026 21:38:00 -0400, Aaron Tomlin wrote:
> When monitoring a large number of events (e.g., with wildcards such as
> --event 'syscalls:sys_enter_*'), many matched events will return a count
> of zero. This clutters the output, making it difficult to spot the
> active events.
> 
> Add a new option --hide-zero-events to suppress printing events that
> have a count of zero.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


