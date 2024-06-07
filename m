Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD251C33
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Jun 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782669; cv=none; b=rxtvRRd6GRBAEKr0hr0CWunuZ5RIUWTP/Jrh/fyFQiGEzSS+sv5KQBczEVnxKdpEqbD8e5m8XDvV+RHWqFOTFB/YjQvEKY6KGueJrx5pAzgHHfcn5mxhDXJkLrtZRNrTTT1HPWKxj3iw/gt9yO3+wsNlKoZGVWqiheLZQwgBmpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782669; c=relaxed/simple;
	bh=5XBYu17a+yTtyu3AHLXTF/2/2Ed2op3+w3NYCkHzLAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMITbYfLUIHgcJ2lhbhT1UCLiALN9fH3u3cBFZXLnquBa0cGHh7swzc+Gh7or3OnhQk3SrOVbVvFBXgY8bykqQC/3EHESGp8oC3nuPvEso4hK7DLEUZ2QcgKHWSv5ZgbK3DP6ZcTWqakiqvAsU4xr29ms+mwxs4eKMLnoh8ECdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpQZfsMn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpQZfsMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CB5C2BBFC;
	Fri,  7 Jun 2024 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717782669;
	bh=5XBYu17a+yTtyu3AHLXTF/2/2Ed2op3+w3NYCkHzLAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YpQZfsMn7L6ow3UzmLnBsbXiJ7lea6LQrCNpkdRfqBPyxgOKlnsyN9qilS5UwLQCs
	 NKkvx7vBTpKdCLLTBxnDtJ78asMk3t3K4D9XE/VFAGg1zslD0YULg00E1GFT9/1D33
	 4lqVRGfqje4ujIEBQPGpGQsPFovVkhHqvV7u2Hxiji3oZZPYdRmD765jmlxkdSIsT1
	 RUwVS+8Pe2/g/Oo0MP9bIT5zIhwM/Bj6k4p+hY7qI3plBxcECEQmXviYfglYEIq5sI
	 2E0D0avOW/etu9tPe4IXphDkB96zQ/LvQDteBfJipmy0ZVHpOeyDEDFmDL35d23Uqn
	 w7cQRLvmP6eKQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: linux-perf-users@vger.kernel.org,
	kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: Re: [PATCH] perf script: netdev-times: add location parameter to consume_skb
Date: Fri,  7 Jun 2024 10:51:06 -0700
Message-ID: <171778264864.3080066.131401019380184237.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240605144442.1985270-1-l.stach@pengutronix.de>
References: <20240605144442.1985270-1-l.stach@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 05 Jun 2024 16:44:42 +0200, Lucas Stach wrote:

> dd1b527831a3 ("net: add location to trace_consume_skb()") added a new
> parameter to the consume_skb tracepoint. Adapt the script to match.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
