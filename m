Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5A3603EE;
	Mon,  9 Mar 2026 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084080; cv=none; b=pn53tOJYpIhvZ6aU6TnT3V+PLSNkmHLreB0dF2ADc9IOBtsan5twwPHbxVqMOv8vtka0oZ0g+SSgtJSlia+7MAep6vg7nPiAlMR1LJ+/Ja7zfnl9+ukF5eSOSS7lrdmByyoG6JQw2RbZEJZDEC7xZMz2RbLsuOAknf5THLVldxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084080; c=relaxed/simple;
	bh=XB8VGM9EpIdaZXFqcufAUheVpSzAzz6UQjQ+t4Q3fP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LelQiUUp5Ky4Qp4lFKc8UsmOXQ0Ydz/4j3oWt+XT9HUSoxHto6cpGtBWvbclAQys5qaOe1BGaxloIfk4bS82HeKhtbHyqGL0ofF4vzPOEbY1qJx02dAzU7Avt5Ful4eoJKDSHWYGWk22XjQ14BbxiJ/i1L6YOmoFyZZERkOy/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0XQPSNy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0XQPSNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD45C2BC87;
	Mon,  9 Mar 2026 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773084080;
	bh=XB8VGM9EpIdaZXFqcufAUheVpSzAzz6UQjQ+t4Q3fP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0XQPSNysypcSkZq+5dBoUMrv4aYG47ZCNe/10nKo51lYBTfo0rXuajmeEQGuqq6Q
	 BxfAOfqPVPP/b/MA1aKv7bBLgkTlK+G2sHxWsvxaiC7Drc74gbf+siD56O9/wDq7XO
	 bPaKe4xTaVUagycTuKKO09gkV28vBiG1JRwSmuBHpMLM6SjRP3xvVz/wOYWncHcIZN
	 L6heWhsm4cTcPotYB9qV4YSOiz7UFKge+gwbhvD56X5muCCRLarNFV+w1sR6kH9KP9
	 MDfegZsYGCkUZXMjZtlyUn+h8ABXIDkCRg9ifKSjxU0D+amCcHFwEb7aQUP4D9BelD
	 M1q1/EwZT8dNw==
Date: Mon, 9 Mar 2026 16:21:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: Syncing include/linux/coresight-pmu.h with its copy in tools/perf
Message-ID: <aa8drHIm6P3-xbUY@x1>
References: <aanm4oUxeJ4U34FO@x1>
 <557db631-aef8-43b1-9f45-fae75910ccb4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <557db631-aef8-43b1-9f45-fae75910ccb4@linaro.org>

On Fri, Mar 06, 2026 at 11:27:44AM +0000, James Clark wrote:
> On 05/03/2026 8:26 pm, Arnaldo Carvalho de Melo wrote:
> > 	Right now we have this perf build warning:

> >    diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h

> > But when I try to update it it explodes, can someone in the ARM front
> > take a look at it?

> Sent "[PATCH 0/2] perf cs-etm: Finish removal of ETM_OPT_*" to fix that and
> update the header.

Thanks, I'm applying it test building so that I can send the first
fixes/header sync pull req to Linus after soaking a bit in linux-next.

- Arnaldo
