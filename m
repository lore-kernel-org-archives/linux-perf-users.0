Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC06D3A9612;
	Wed,  1 Apr 2026 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080372; cv=none; b=YCWkiWTwfvsgjq2E/YG4F8U35XFd1r6beVuQ8EImZQGemoNKEEfT2vEc7GYI6/cxs+/KefjYaTrTHJTmtTsq4CKS+BWdWIU3DjSv+fbIOlY2+NCgUhvE47wTACJNaPxxmqrb4hoiBNiaHtBSiAaWeiVLXZlXIhzQU4+Z5kIDIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080372; c=relaxed/simple;
	bh=kaFsHKKIwxh1xgPpEnc6Kq2lfCfyFKi/GC1cNI0xfus=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D3hPmQrz22Vur90AvcijFZs5c8A6Bwy6ghg8A3a3uFe7vjZgE9S2AKp5aOTJcT4kNeqDoaN86bvthDMGnLRSIwmVzJ+G4zj0Cc6p6AFgQ4tp5SybVE3C2dq7aLi7vYvZkNFaLl8rgTLjDU9ZDobpwnouN223JX1kKufyXs7BRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXDUk1/n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXDUk1/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AA8C4CEF7;
	Wed,  1 Apr 2026 21:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775080372;
	bh=kaFsHKKIwxh1xgPpEnc6Kq2lfCfyFKi/GC1cNI0xfus=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=hXDUk1/noskMipd3C09K7yzfRZWqlWD5wiYSfpCYB0DHQ4zgTnIp+W4p8za4WRix+
	 10yyQAOar6qAsSugBxj4DLViVUei5wUnl0ElK1MaKs79Y5CdzqOHUZYD8ZhzEKoFtY
	 g9yFwT33K9qeNuRtPWx5oXzfpsU5mlGIqtWGJ+Su9aPfiTYFw1VoRj3DNb8fjNr+Jm
	 Gl3POFEzX6KHsf+NGX4OasAQspsRnlxvM/6H7S4rVF6W+XX9B3f2YfIUZmik9nwmKH
	 vGI+0gKb7OcQpNRsOW/DtHX0YAn26RA2T8AOCqSzAiApq4ivUWn750LkqUayzhJfMx
	 Oky7f9Q25Tx9A==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20260306191908.2065682-1-irogers@google.com>
References: <20260306191908.2065682-1-irogers@google.com>
Subject: Re: [PATCH v1] perf build: Add -funsigned-char to default CFLAGS
Message-Id: <177508037242.42628.1009450386737394381.b4-ty@kernel.org>
Date: Wed, 01 Apr 2026 14:52:52 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 06 Mar 2026 11:19:08 -0800, Ian Rogers wrote:
> Commit 3bc753c06dd0 ("kbuild: treat char as always unsigned") made
> chars unsigned by default in the Linux kernel. To avoid similar kinds
> of bugs and warnings, make unsigned chars the default for the perf tool.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


