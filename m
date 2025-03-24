Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653BC2641C0
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834078; cv=none; b=DQuwKKwfqJNNfa3u7iRIdiAt6SRnI5AXuUz/Pp7mK44bFYIzCWQLhiQIy1jntTFjETGVE1bapL2h5sUk8I4CNL0xRSw3wqYQuAQGe1PNPXWpxtOAvO5QncKckukIIksmjpWBIkDk8LCHuTK5JLZArG8f1tqtoD2mw5e7NQKc94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834078; c=relaxed/simple;
	bh=JFWxah0yn9IuLTdnRpfNkLfC6UF7xa6SumacmP2pPUs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rt7xWgfHu72K5Vnn3XbHVXBNuFR4jwhBocwsDPwYEXKYBpLoGCwGr7Q53F8bm1GtIXAm1exROxcfi6SbJfV88tsyO57BQ3JCgtLrTlk1HYG4zvXcbWoZUc4HViZZPLQzWpsM6tFtYp7qCNPfOW6dEfhr9wqR4tx6kzTnB0IZQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e77Jb53O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e77Jb53O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986D4C4CEE9;
	Mon, 24 Mar 2025 16:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742834077;
	bh=JFWxah0yn9IuLTdnRpfNkLfC6UF7xa6SumacmP2pPUs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e77Jb53ON9OcMUZ6ghvNMRYbGsKcNW6OlJxiZVp8l1kPDux/ThRnF97o+a237kxJK
	 I5+5fi9B4ljXeYDBv9mx1dVjSMmxxEMh6DWPa734LPEOzacFNXxS+D/ewTg8n1ju53
	 VEz/gztxCia/YcWNdmHjgNeMo7hkMP9v3VR4Ie+pPKF+T9ekcTLiWTg5mNBBy4Fyob
	 XAn+xIwv5CdyGt9Yd2WOW/H1TQbz/2gMch8NC76qDeVJX+7SYk2fx2DirtPR+EiYbk
	 YSp4LDc9PtgqxNLKn3dg4rxLC1G0YvqvHiylSsMyhOrWl5uqwpwL4GuRbVYBflmEax
	 XjzM/g6ZbttPQ==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 irogers@google.com, Likhitha Korrapati <likhitha@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 maddy@linux.ibm.com, atrajeev@linux.ibm.com
In-Reply-To: <20250321100726.699956-1-likhitha@linux.ibm.com>
References: <20250321100726.699956-1-likhitha@linux.ibm.com>
Subject: Re: [PATCH] tools/perf/arch/powerpc/util: Fix is_compat_mode build
 break in ppc64
Message-Id: <174283407758.1817265.13747137437378271196.b4-ty@kernel.org>
Date: Mon, 24 Mar 2025 09:34:37 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 21 Mar 2025 15:37:26 +0530, Likhitha Korrapati wrote:
> Commit 54f9aa1092457 ("tools/perf/powerpc/util: Add support to
> handle compatible mode PVR for perf json events") introduced
> to select proper JSON events in case of compat mode using
> auxiliary vector. But this caused a compilation error in ppc64
> Big Endian.
> 
> arch/powerpc/util/header.c: In function 'is_compat_mode':
> arch/powerpc/util/header.c:20:21: error: cast to pointer from
> integer of different size [-Werror=int-to-pointer-cast]
>    20 |         if (!strcmp((char *)platform, (char *)base_platform))
>       |                     ^
> arch/powerpc/util/header.c:20:39: error: cast to pointer from
> integer of different size [-Werror=int-to-pointer-cast]
>    20 |         if (!strcmp((char *)platform, (char *)base_platform))
>       |
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


