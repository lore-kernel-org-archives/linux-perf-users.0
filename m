Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9FA26463B;
	Mon, 24 Mar 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834078; cv=none; b=aGfCosWNSWHxqstySQuPhwXJo+1KnmJhuUUZD8wCzyw1K5oPHa/FXFHn2baOWW1JICAJ0tgY2E3uTB0Ag4MLeZjMk17hVr36mksJmaGJ5W4+iVkAfSIyCpksvzeFOo71L+iheZrmgK0z0tqXXqgEsF3f0tM8nZiPp58oVCbEBfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834078; c=relaxed/simple;
	bh=1zWB+UF3RuP6LS1CWoOcETI6jyJl6jMBirhZ/8pe6yM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AQnsmklQWrgz82PF0St9wZX333zDVm7FVn8t9VmccNfFC6kg7e+UwwpGoqC/74civSl2+Bp8TR7DyJPapYSj13d5C51ZNFR+p7LVdSCWif33o57fVxmXYKHSByHIdwXg8nGuB86LFw3Xf8KHj8y/0TEgajKwnhF3d/vcLYmoKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2i3Hlox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2i3Hlox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A69C4CEED;
	Mon, 24 Mar 2025 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742834078;
	bh=1zWB+UF3RuP6LS1CWoOcETI6jyJl6jMBirhZ/8pe6yM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h2i3HloxywUdOTOVU6jmPqP6WIzDFmIEY4u06ftTclBB01JiNHA+vsdYrkaDopHFI
	 WkSqUB4UyENaVPDsROEmwRRVR3gbl/sbLaLFeV9vYxJGPpiaomtE1YoVqZeGg+DY5m
	 lzK8WSZsMDH7LRa4DaTn3gCc4gYtqkOLMmp5oPYkXLlpVYqlMIZCjohsqRVMB3Aceq
	 RxduVge1UnNd7vb9SYTeu2wiVjwYt0jQU8W5p0ouGiC2QLOLRulSk7TteoHVy+0fmj
	 lt9rxX79dJhjn1JOLwIMu0cGvZrzIPjhPCNqa4aGAIeS/Svd6MACl/SAN7s/4CABc+
	 lrLv3GfOY9f9Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Dirk Gouders <dirk@gouders.net>
Cc: Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20250323140316.19027-2-dirk@gouders.net>
References: <20250323140316.19027-2-dirk@gouders.net>
Subject: Re: [PATCH] perf bench sched pipe: fix enforced blocking reads in
 worker_thread
Message-Id: <174283407799.1817265.5810920957697722806.b4-ty@kernel.org>
Date: Mon, 24 Mar 2025 09:34:37 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 23 Mar 2025 15:01:01 +0100, Dirk Gouders wrote:
> The function worker_thread() is programmed in a way that roughly
> doubles the number of expectable context switches, because it enforces
> blocking reads:
> 
>  Performance counter stats for 'perf bench sched pipe':
> 
>          2,000,004      context-switches
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


