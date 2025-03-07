Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B418DB32;
	Fri,  7 Mar 2025 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370998; cv=none; b=WEsj0lHZwUwln15F01DDj4rz9TRcPyobmkXMJ/XXDvMcfmjJSdlGldszfHSlrtZgVS0DgY+9r3wv+XJZ5sBTNi/9t51vnQ7llh6E6EF7kGHZeyCP7+jy/ND7J+xt7heyEBiGYF2FDDsOPCBlQuJvboWH377aqebcZflHiYXOAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370998; c=relaxed/simple;
	bh=yIGYZx1ZawUngkZDVnTe+TS6p4jPyDNyFfsqtIuamsM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U1+2emHnnqjYAVEXiVbBNCFgw/k8rLP+TlNJR8quUMTzQZdcowE+PyvsAPlipl0tnQHjUq4DWdZwXsNxTV9Px7sqT5ZZE/gTMbOVPGWXgcv/+WoSy64PldubOu3A0Wp+bUf9ZUxlBEHQPFRUvM/MRzG3zliy2bdqU5Ti4mFTMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Glz3toXy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Glz3toXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4BBC4CED1;
	Fri,  7 Mar 2025 18:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741370998;
	bh=yIGYZx1ZawUngkZDVnTe+TS6p4jPyDNyFfsqtIuamsM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Glz3toXyxMUJ8tc0IYag0/Wnuzdt6yE/H2K/IkVDmvfVDoygIKUPGqA+nlq2EMb5q
	 mJL4gfCmRQoF5weKBIfT74BQAwrNSA+5B3h2WnHjJXigcIX1XaHR7FDxfguebZVozK
	 cVLUiDZdF8oW8ymH/Zwgvo7KuDARuJxknldHpFPekr7mWYSH6cAC/4nKoG0JoLpmNp
	 /9GNpsjSUKSm+fEST7DitmlPnIGo1tUyDIGPtExMhY2Ydmc3sxWZmg0PW30kcpdgQt
	 tckuJdl9/ZIR6NLf0MgxH3vsUl0ddwINhfq0r1jsLaZENTQoq3utTgUWsr+b0Ky1CG
	 uUGBCRPJ5KJzw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250305191931.604764-1-irogers@google.com>
References: <20250305191931.604764-1-irogers@google.com>
Subject: Re: [PATCH v1] perf test: Fix leak in "Synthesize attr update"
 test
Message-Id: <174137099760.213280.16871864951265396512.b4-ty@kernel.org>
Date: Fri, 07 Mar 2025 10:09:57 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 05 Mar 2025 11:19:31 -0800, Ian Rogers wrote:
> The own_cpus map variable may be non-NULL and hold a reference, in
> particular on hybrid machines. Do a put before overwriting the
> variable to avoid a memory leak.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


