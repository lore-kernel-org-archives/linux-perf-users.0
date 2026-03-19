Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907C73EE1E5;
	Thu, 19 Mar 2026 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941078; cv=none; b=ZLjb8pgD99cH3euVyTaGSwkpXRGkfrtcZQBetUR1hYSs+HaiNGUmI8Z0DsonLAQ983DwIa0P8YcFvL8pwpjUXQfVWQDAl8/OHJsNIOorED4PQA1lwoMHYqJy/k6Yx9/VouP8spEJrBIQMykgb0XASsH92Ag47IHBmhQs7KyjZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941078; c=relaxed/simple;
	bh=kBRINqrLYdRaj2OTEdauVdZSYU6PWMTWOVjA1hl4gb8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P+gtE6eqGpuq3XCx5oEmLHyPROJQXcG5savlL22t8CF2hURHOHmunF2qvpppKF35ehVHHfOsGM6FBQBEGDSBHJkjRhzUDRFQtm1sts24rI5NW4l8kgPyRW+YFISKgnc7Zj/5GNfx3mhSl0tZ2tHYJ73sw3+gg+L+5JWR3jbgMa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5r8knBa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5r8knBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056A6C2BCAF;
	Thu, 19 Mar 2026 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941078;
	bh=kBRINqrLYdRaj2OTEdauVdZSYU6PWMTWOVjA1hl4gb8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R5r8knBa5uix+BUJZ32fXdz4UxrwXjG1/IOoy+lDg1ROBRqtLSvPC5ACZyKJ66ny0
	 G/2rA3+d+BId4Em+A5hIh54RuH9SJfLwBzsqSFDRoa6hDzJTgleTmdXrxh0FYq3mqj
	 bqwd6nJ7qR6G2ZKtHs3pO47snz/Fm8dHEwd5UZcaZLJNU9b/flBfw+7vpvhuJbN1NB
	 Kmfg7lMJPyEP28OSbR26yckvQUJvLqZke38CjCOOyVt48ivSf52/J4M/EG6IHa/cbM
	 8+aYK5BUVDFvwkTd9DXextHTEbOdvEQMAsbzluZzvd2CgZsduZrVl5+JjFPl5IU1oJ
	 MB8YO1qcxjMxw==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 irogers@google.com, pjw@kernel.org, alex@ghiti.fr, guoren@kernel.org, 
 cp0613@linux.alibaba.com
Cc: linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260317034847.4136-1-cp0613@linux.alibaba.com>
References: <20260317034847.4136-1-cp0613@linux.alibaba.com>
Subject: Re: [PATCH] perf symbol: Add RISCV case in get_plt_sizes
Message-Id: <177394107796.14914.5183103180695281404.b4-ty@b4>
Date: Thu, 19 Mar 2026 10:24:37 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-02735

On Tue, 17 Mar 2026 11:48:47 +0800, cp0613@linux.alibaba.com wrote:

> According to RISC-V psABI specification, the PLT (Program Linkage Table)
> has the following layout:
> - The first PLT entry occupies two 16-byte entries (32 bytes total)
> - Subsequent PLT entries take up 16 bytes each
> 
> This aligns with the binutils-gdb implementation which defines the same
> PLT sizes for RISC-V architecture.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

