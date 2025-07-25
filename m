Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5453111BF;
	Fri, 25 Jul 2025 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469329; cv=none; b=ANF94DRf4PMV+PTC0leGYu1zXLa1Q+28CXfROQa3T0ryQg32s7vnNmT6S+OtyeGfoGAlyrog/hXRQjbi8kRqQ9FQBgiwf5Yto6FGMw5GgcAoNtOXuQ1Q1pXsehLCpjOaGFk29AKi1xGh+Mtxwk5SPpAcySv6SdQI7TUIWLwSulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469329; c=relaxed/simple;
	bh=drqm5uHAen5vZFA1LtmWBRGe+mw6H1jWWcG8bL4HGfU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EyEjCtHzR5AP4sbI/pSzPX8GETAZZK5ZWgEKRG5VaitFA0A05wwWKWq1jguR7iHt8WWi4IbhuR/Uv4Oy29pJMb3xHWmM9Uem+G1ywYQt4Fz4VAuvrlcDCqEcLrnSJ12v1BkKw8c+IeJXDe+Wyc1HdN6iatijFbXSthibuIEN/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9jOfcRa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9jOfcRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0042FC4CEE7;
	Fri, 25 Jul 2025 18:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753469329;
	bh=drqm5uHAen5vZFA1LtmWBRGe+mw6H1jWWcG8bL4HGfU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g9jOfcRaE5ibtAULjfDSey4ov9kZd57a0b4VoETy+k0pmEwZYW6LwLhwb/uJee9hJ
	 +SyiLzGtzl0nYs9bfF64mWsvsjsnrEJaAhTZjSvQa5Q8d/QvcUrMMpXH0QLBgbh25p
	 cUeRaMq5elba0c8k3gdbcwCczrPOkuysVV1xKwCatiVBIy7hvTF+b4+FXdn5HXiwPG
	 PJYkv6963Z3KUcECsUjLy1Z6xX1/z1cCSaskLHOj7PAZrDA5kCQKTGIGzQA6GSO9OF
	 kBQfAv91tuBC1f4p8R5y0OjgCcnKbRg3fx2cUvPyDT8fviN/Kj/ZLeg8B6H6MMViJp
	 NGvSVVlwvqRLQ==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Li <yang.lee@linux.alibaba.com>
Cc: Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20250723070418.2195172-1-yang.lee@linux.alibaba.com>
References: <20250723070418.2195172-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] perf stat: Remove duplicated include in stat-shadow.c
Message-Id: <175346932894.1444596.10188055413657433597.b4-ty@kernel.org>
Date: Fri, 25 Jul 2025 11:48:48 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 23 Jul 2025 15:04:18 +0800, Yang Li wrote:
> The header files rblist.h is included twice in stat-shadow.c,
> so one inclusion of each can be removed.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


