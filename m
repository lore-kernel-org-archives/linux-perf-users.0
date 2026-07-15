Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D144495516;
	Wed, 15 Jul 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140815; cv=none; b=nwrpJYOqFqbGP9XZK/+tbmVifugqejQQM6qQEhYkvFZWlfbyDxWbFGRhuy/BL47DlKyC/0YQrOJRKdT0hk7VjkKGp+8JSO1mW1VllzkuNRnqY/Om5UfFwrG+HRWWGVp8GySt9P7qGJgf69XQl+ntTftC6QlqGpa/u92qOjLFGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140815; c=relaxed/simple;
	bh=14xCmOofCXTH7oppo8YbHg64PY8+Mm+bOX/EFV5N3Wg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pBL1XBOBISEYg/0FPM9W0ux1Pa9ZOqKIg/+EBBXk3oRW98XBpcX2Qe7KvW4ZnJcUofDJsopaQi4XQPBqAWkSwFzcCqlCzrjEfUfQaOX4nhWcSavvRR8P20kby3mfDh6tePu27Tbt+F4t4v1AUgZT/9fsSRoxnZl3p6TU4fBvkAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIrjOBCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIrjOBCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CBB1F000E9;
	Wed, 15 Jul 2026 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784140797;
	bh=BWDmVsXyq7uAd7AjZkqm1hqTznBwGfenaBrklI43KOg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gIrjOBCct0yygdYadAIpDaJBtcDFrM9hZqzw+Vn73NnIzwN/ULNZICJYD1qtAmy9a
	 GIYvT6kQsBaRk/Qwgg+sg1tcZyIp6dOM4jmTKg5lx8dHgfq5hknJSnloHopa9mPUzD
	 mtfHIBY79BQnKwWRnhMWjcUVW8co7sRebOTH4sIaX6/xATJQRWKqQ/21t/zqitXxfa
	 ze77kC+A8pbFyrAeew0LG9sTDypE3DRZP/CRPoh2A99B/MCf3H+09PzfuCx1N7EXyW
	 1fusCbuZnIF2LwW4NHnlWq9hKsk7WS1XxtCAWUvNdalqydY5DghRZp1e3JnIBQxjFG
	 LDBV0dCECrkVA==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Chen Ni <nichen@iscas.ac.cn>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, james.clark@linaro.org, leo.yan@arm.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260714082810.3660091-1-nichen@iscas.ac.cn>
References: <20260714082810.3660091-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] perf test: Remove duplicate include of util/term.h
Message-Id: <178414079738.2318976.2588157267977347995.b4-ty@kernel.org>
Date: Wed, 15 Jul 2026 11:39:57 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 14 Jul 2026 16:28:10 +0800, Chen Ni wrote:
> Remove duplicate inclusion of util/term.h in builtin-test.c to clean up
> redundant code.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


