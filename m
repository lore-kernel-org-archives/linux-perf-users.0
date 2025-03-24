Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8EE2620CD;
	Mon, 24 Mar 2025 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834078; cv=none; b=O7b30MBta42nBfgDV89n1RQrt1IdVdVN8Z7LF9pupcn90XvXvVuKB1XmTj8uiBol5WM8+YtNptD8a0+2XS5ZFhyvCZd/j6o95UTG2K/Mv2dSR23Qgjfwfm5yvAWhJ8PH7T90bN8/NGJxzQlK5AG3HdehqcWiR6MM0b/HjO+Ik3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834078; c=relaxed/simple;
	bh=gPQPmq0dFdYF4LB/dq2S6P9tXXT1ja/KkEg7A1kPt/A=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A/IpSYX6BpAHfLEmzp5BVpIl751rDI7e5i8H2VLdfLYhpoeAjG64MK3AadgxYlkObQdrcC6N7BdYWVzBV6+a2+rAY7ayOuFmTvsbaruaM9eJksnKSiLJYmFGEguRJr/uRkb5jZ8VeCn+IfdtXJmH13Jey+REEP5seESmhZ5cjJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONPJZEpU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONPJZEpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1350BC4CEDD;
	Mon, 24 Mar 2025 16:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742834077;
	bh=gPQPmq0dFdYF4LB/dq2S6P9tXXT1ja/KkEg7A1kPt/A=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ONPJZEpUK3pXwZ5PsCfrys7k3yTEAKrQzhTCcx3FNgId8VQ1hYsYQ3c8H5niZYGyU
	 DOnWHJiH7OHagGlAjqHfE0w7c3qC+0XhxeIrU4zJaAHKvmgFzy30qzG3Ihs0D7sieK
	 CJDB9USuOAzXyG19shDKaYnuEfvAKVkOogUEnxweNtiw7St712N9r4KKfmPPV70N+6
	 Pu77LZSZt3fdOyQJoV2AX305Llk5fyKrgwSE6FxWkxMhkfOwe+aspDDzAKXo96tba2
	 iI/cz1FNeU+1XPxRyXZmV4muJdq/W9MOsPzxHsXyHhRdKUJLBUjGW4tBphe6MxB2Jz
	 OBjajM0cXMD9g==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
In-Reply-To: <20250321082038.27901-2-holger@applied-asynchrony.com>
References: <20250321082038.27901-2-holger@applied-asynchrony.com>
Subject: Re: [PATCH v2] perf build: filter all combinations of -flto for
 libperl
Message-Id: <174283407703.1817265.14283726401128648885.b4-ty@kernel.org>
Date: Mon, 24 Mar 2025 09:34:37 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 21 Mar 2025 09:20:39 +0100, Holger Hoffstätte wrote:
> When enabling the libperl feature the build uses perl's build flags
> (ccopts) but filters out various flags, e.g. for LTO.
> While this is conceptually correct, it is insufficient in practice,
> since only "-flto=auto" is filtered out. When perl itself is built with
> "-flto" this can cause parts of perf being built with LTO and others
> without, giving exciting build errors like e.g.:
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


