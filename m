Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5CA1A2642;
	Fri, 17 Jan 2025 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136490; cv=none; b=rxGoUWbPicQc7hN8zcOHrErbz1h5/clNncBMC7mRy7zCZn6NZeeSxePDuFdCk+iL9rxWDe7fwBfpgmHj13hFcuoi7vC8Y0faH4C55bWPCZCpodv5ySJqBc2VuRHGOxdA6+lFot93Zd3bCEA3BTgF7M1Gye0iL1/DDHCfO01pMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136490; c=relaxed/simple;
	bh=7WYRISorZOP+4OmxqYz7vZKvJhnn+PvoEdS+CRQwlyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t6eH80e/BrhRJ99IJIA7CS1NNrMRIiJCG5zo/V0BHwef8/pCYubyAU2cb8uFHn8l7o5NjQ3dnLz0BQjtzWfQKjzvO/1skeNEc32eM+xGdPHFiqMQZDrhJNlJynVT6hAg4f7Xzy4UmVoI8G7o+v9mn/pm9bDPcnXPfVvX+NeafpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcHBMpqo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcHBMpqo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9E6C4CEE3;
	Fri, 17 Jan 2025 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737136490;
	bh=7WYRISorZOP+4OmxqYz7vZKvJhnn+PvoEdS+CRQwlyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hcHBMpqorWYoncAdc6KL0v05h6CnmAK8uYO+hMnhOFkzzHg4H1RKxZ6ly9RoOkWv8
	 Y4SiHgeS0TXH6WF/kXV6tMj2oUpnp14PvsskI/4BLT8VY9maOD70sc1chubFv2GXEg
	 VKplshqMjlp8m5taEfjKS08ucWyv3ImCKAoG8V5D7pqUM5s5XT5ydMTvlVHKLQkHR/
	 2vQ9+kbT/MzPnGRc/iaM8gxtiodLEdgl6/a23oVT8HKhrllK6KkxIgJMxjkADPxjGW
	 B/+Zlp/v0Vh3uqvVzdzRFfznmD8xH9HliRIwsrYvYCsMzgZiO/+92SxvFCRo3kyU+l
	 5Raef6x1xZHpg==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com, Dmitry Vyukov <dvyukov@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1736927981.git.dvyukov@google.com>
References: <cover.1736927981.git.dvyukov@google.com>
Subject: Re: [PATCH v3 0/2] perf hist: Fix bogus profiles when filters are
 enabled
Message-Id: <173713648992.2190713.7753622718922603463.b4-ty@kernel.org>
Date: Fri, 17 Jan 2025 09:54:49 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 15 Jan 2025 09:00:40 +0100, Dmitry Vyukov wrote:

> Dmitry Vyukov (2):
>   perf hist: Deduplicate cmp/sort/collapse code
>   perf hist: Fix bogus profiles when filters are enabled
> 
>  tools/perf/util/hist.c | 114 +++++++++++++++++++----------------------
>  tools/perf/util/hist.h |  14 +++--
>  2 files changed, 59 insertions(+), 69 deletions(-)
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

