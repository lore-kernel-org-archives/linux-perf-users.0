Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8745C345722;
	Sat,  4 Jul 2026 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783181463; cv=none; b=QTH3yWUhcJZd4nKB72MrWVbF2nz0pnoNfLEihZ4GN8Ay8N3I59QajfOKt3WybO0doqptxInWfPyKXtSR71upgD3yBe6vGMfnxiZ9d9q+KEbCHW1HHP3gZ9bIsVb7cqsPrOY8lF8WDKo2tnq7jO3nfGu0Jl+MbHxVFW0sGA8RWV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783181463; c=relaxed/simple;
	bh=8T7MQdJMKNs6n6/fyXQhasLB73I/OIFVgUIWdvlsOSg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JWUZRhV7+3CuQLqpE9839RQTmWKD8r6hzVzxvEsojZswXwopepnFKRbwMEzr/TNiAOAapSmTO7RJ4roRHqRIncQ0I2RqdV5p/h35VM8FyvAoKo7WKEu/qDt7NsWOawPoPZBBMZiMhmQ5V9qSgxviZcTFmT6w8cpQBR3J0cEfPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKC1k1x8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKC1k1x8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3093F1F00A3A;
	Sat,  4 Jul 2026 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783181462;
	bh=B0CwLxfiqHsqVg8byxNSiwIA+WVcsN08HJ64y/nVgl4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gKC1k1x8W8YOSaJabutgw83AcMT6XJPpCi6XAkWruxgpvvof6N6HwYCNsYSJeROAw
	 GT3EKP+fDUaDJaH1DVqJM6a4LfQoDe+s2lgEiqrjuEbm/VaGEORoWHMtkedEg/0lQi
	 Btxqm7LcipoicfO8ncJhQL4JF508l/e+RpPX57JdI1brvtSOUiIokRW0HWJeAQnlFb
	 iwKaVcEF/J47jJ7znQRLJV2ildxUiyDcP1QTNJ3Br7qJsIqdscmO2W5lBii2sJGalD
	 NsybIkarnQ7HUeCd3xk7kv1ODQ7jVMBJg7Kr4DrGHws7l3ol3RD8Wff7jVshej2anE
	 fyCWjDz335/Ww==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <20260701194153.401218-1-namhyung@kernel.org>
References: <20260701194153.401218-1-namhyung@kernel.org>
Subject: Re: [PATCH v3 0/6] perf kvm: A small update in the default arch
 event
Message-Id: <178318146216.1194818.559653917515294334.b4-ty@kernel.org>
Date: Sat, 04 Jul 2026 09:11:02 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 01 Jul 2026 12:41:47 -0700, Namhyung Kim wrote:
> Ian said there's an issue in the perf kvm record command line option parsing.
> This is my attempt to address the issue, simplify the code and fix memory leaks.
> 
> v3 changes)
>  * remove unnecessary error check  (Sashiko)
>  * update test code after rebase
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


