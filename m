Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC921CDA0D;
	Tue,  1 Oct 2024 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816529; cv=none; b=BROOaEe0WQzQSFl8cl9XLXPqjgVsstoq7IME2ZaMZlLv8m+4d0CUOyivPaa1qqiLlOfjsXg6oO0pVV5xAHgdm9S8CDaUJHwdZXgg5unc/ZcXRsvIO3RYzZWXzD6BlH458QYX1mClOfMMz+Ph96wJ0G44PLl38i6j0vxkX8dNgt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816529; c=relaxed/simple;
	bh=x0yHY+NMGqlMlbSOie7GEb+sPTXUdOYK1JMIW7elCOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrymzGnkaiLhqUdNP9+e6p1Aj22PPRIsvjzaUfPPjjw87JxmK+4Uv4lAEUNtRbyAsaTI9FQHAr1SfinCr2GosH/j83Zq+80TLs4BPHG0w2zT3dBlF+GgXX6TCiBKU0bDvOJx8x1bcSKp4QlVppA+hSHBDKqxR+IQp1cW8bhAUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK/9/aVB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK/9/aVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C998C4CEC6;
	Tue,  1 Oct 2024 21:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727816529;
	bh=x0yHY+NMGqlMlbSOie7GEb+sPTXUdOYK1JMIW7elCOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WK/9/aVBmZqVoP3Ks5VG22B9JlKieEeIgpPJ59DjAYnxeSwEGS6h5vbfJcN78AWXN
	 mbP3nXBybiwvPWtmWcnY6CtTOBUCpSopKHYtH3tYbFffx0tWOjlZ6u82pNjp5p3bsM
	 giMKaZbIT1wWIH9p4Zl380zLyDzGDC9+Aqb5bMbNCnJZ4Y1/GoQrthCG+jKATdBZKR
	 yXvj0T79uNJh9bKFDZTCiO6sWcd4Nx8HkIpvwcGEvSS8Fz8rTLRieRg82fvntmC2Iv
	 t2Ss0BZPO3AXrJn9Co6P0+uS4jQHla/Cv43L85NsmRMwkqQpSgXKEUj/WxWrTxQ/vO
	 3+T/PPAHVss5g==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
Date: Tue,  1 Oct 2024 14:02:04 -0700
Message-ID: <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 13 Sep 2024 08:47:06 +0000, Dapeng Mi wrote:

> Changes:
> v5 -> v6:
>   * no function change.
>   * rebase patchset to latest code of perf-tool-next tree.
>   * Add Kan's reviewed-by tag.
> 
> History:
>   v4: https://lore.kernel.org/all/20240816122938.32228-1-dapeng1.mi@linux.intel.com/
>   v3: https://lore.kernel.org/all/20240712170339.185824-1-dapeng1.mi@linux.intel.com/
>   v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.mi@linux.intel.com/
>   v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.mi@linux.intel.com/
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
