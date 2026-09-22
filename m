Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0911A3166;
	Tue, 22 Sep 2026 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038693; cv=none; b=OJt7meYX1ECcfv4oDLuiy+QHQqZZJptDzom49mD4qWc6Md+AJ1NhLe4JA0WXKlf+BzpyzBrpEP9vIqYd0vrQpi0A56cQBxjKw2skifsHfWdhLJ+x8MxgjFS8vWTUt2TEey0AolxTxpEytQrGT9vJiit7D+qYoNpg8gPn8KJH4AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038693; c=relaxed/simple;
	bh=Zdl5HCvWrVIZs7k06QEa9jK0/9hhOJZugYVa2ccIjOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaF1fhWOeUrN+J0YhiyUxXg3lICNvZX/8hiD9EY3miPQB9/eM7ZzQ8kz/uQ/Hf0sQWR/l6VK4YoUchVRHcDrbLmX2jr1A2pxj3OkE8Hi/rXvrj8ryU4GOdHB0lbWmYVeIl7Y1B+zi+r/Wz4R9XX2+oS1mEmuCYlX8suLDSjwUQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1T2+e9V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1T2+e9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EC01F000FF;
	Tue, 22 Sep 2026 00:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038691;
	bh=YbXtzLSgr9892+N+EUKioiAWB7IAkzRDYOqEEJNihS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I1T2+e9VTiANv3awlsNIe+oKfbxOxJGFDIcuPqqq/iNpqFs+XEzadRQPeULc9P2oZ
	 G3Sc4uHx2aqnyYTvFnF8NyrWJk70ybF2rSt19LMSkcp1JmhAk7JrT33NG1+4FcbNuT
	 OC0BiKDTBYeg5M4Q5fjkFxpLhtkiBBgUXNMIfcFGA8zTNHCAHBaMYb3p6/51uJDLsD
	 Kem2llr+ECVz3uBp+3d0UbPHl2Ab3GoycHcGZubxIwG7IUrSqBrgl+QGAheG/lmmHs
	 i/DIqywfaDiqFn9EZqtrjPRHWwp9F2eytvEp/wEfnkcffhd7R64vhNyq42etkPbzUp
	 VkhHPaS7H+g2A==
Date: Tue, 22 Sep 2026 01:58:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 robin.murphy@arm.com, icheng@nvidia.com, sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v4 02/11] perf/cxl: Clear stale event fields
 before reprogramming a counter
Message-ID: <20260922015806.6e0a1f4c@jic23-hlaptop>
In-Reply-To: <20260805155911.1304807-3-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
	<20260805155911.1304807-3-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 08:59:02 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> cxl_pmu_event_start() ORs the event group id, event mask, edge and invert
> selections into a configurable counter's config register without clearing
> them first, and cxl_pmu_event_stop() leaves them set. Reuse the counter for
> another event and the new selection lands on top of the old one, so the
> counter counts the wrong events with stale edge and invert behaviour.
> 
> Use FIELD_MODIFY() so each field is replaced rather than accumulated.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
