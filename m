Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC83191F8E;
	Wed,  3 Jul 2024 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043576; cv=none; b=TPnkCSXUaGez/OACoZ+dikQdyGU8KA9Kytni/k7lc0V3l1OHLvHESF5WbzV5w5naKpGvYDCCDwE6HSn1kPQYd8intteOBBHy48N31fZbIbyjmNRtmshXqFhDrv3Eq1KYDBrhbLCTl0O28VK3ybG7m3/m8zAoVHUcITLmEakoz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043576; c=relaxed/simple;
	bh=AcYxp1ZH049ohowuR6EtpszX6O6OFlqS+kmQUZPgFSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMZ5b0V5M5OGCb7J13oD09YmLj8xv3kvMIgMojmtIJh4wWBX+SwJ8zVy8MIz6intnr9tl7VFd1Y+35zOTBDgaX23YLemV7Mx/BLoNEKYGgb7SHFvHKSb5a1WGyc+t3yFgTLKbTvwFII3mdwJX//QazjR0BhaRdCVY/SVGSDu1qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib1TlHrK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib1TlHrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AF7C4AF07;
	Wed,  3 Jul 2024 21:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720043576;
	bh=AcYxp1ZH049ohowuR6EtpszX6O6OFlqS+kmQUZPgFSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ib1TlHrKlq1LnWzlBtSEOnad/63Zu5K0JQt4uK8ec/4Pl4ESRxBDDS2gEjAYd+tnc
	 G0l8dI6wsc9UWIhe0imKA8XT2j/rOGJhptGf7HjATR+ByP7twZThr3kcb5nWOpRYIT
	 wv4XeKc5uKO3avqGclMkQT3w1LD1CUVL499zkJ98R6G1VStASXxCmpoV4xznMEKfk/
	 aHTof1n/sNXeI5UOokx760cWrF7V1TeNnvx9wZn3Rw1M3ODQ3barziskZY2n8uGJcJ
	 D9GLLa69Bcz615VKTa0/aY6HLUqhtBszRaz54D3rECKffPiOJATK1rcRQnvPtzK1ze
	 nAeoxfn74wOAQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/2] perf intel-pt: Some small fixes
Date: Wed,  3 Jul 2024 14:52:52 -0700
Message-ID: <172004355383.3801562.4132153508514771871.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240625104532.11990-1-adrian.hunter@intel.com>
References: <20240625104532.11990-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 25 Jun 2024 13:45:30 +0300, Adrian Hunter wrote:

> Here are a couple of small Intel PT fixes.
> 
> 
> Adrian Hunter (2):
>       perf intel-pt: Fix aux_watermark calculation for 64-bit size
>       perf intel-pt: Fix exclude_guest setting
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
