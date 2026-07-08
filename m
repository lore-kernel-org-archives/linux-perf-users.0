Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA658420876
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491699; cv=none; b=IAl/uoH94X7r/fkprdIW6UPuaAeVp1LAjtZ1oMLz61/kj1oP2dOW3YCBj4ttMK6wXlqFr5/9okGd20DYWBROHj18xtQ9NVX/Mi2ugIG0h1eNA38Flca2adaIGuEr26hZkFhEoWRj0Vpud7W3l+UjDE7MQ9Zwm56icPQQ9eU8pCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491699; c=relaxed/simple;
	bh=6+SqlFVjvTqXaj+J5fndg/SAfXVQm0tyFoAdh0EAazw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRH3LqnFadydDiPPKrj7zynbPGjI4rvE+nUqcHdMoHSm/1maDOUq624waoJqk0YyJTt4xqsK24tIh+bIYBHsSht2K4gmP0QAyM7znjlSh2yRRbpI29CDfaxsF8mZBXwSWjWOCv2oZOmoIDL96K+wfrUnLmXE1X3svU/u66cVMXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPCZXiIV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPCZXiIV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7871F000E9;
	Wed,  8 Jul 2026 06:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783491698;
	bh=oJ/cJ3COZlIuVedjRUSSgt9XaIa7i7ArTUDrC6rt0aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DPCZXiIVRMEawPoCfhPeWMRc7W3Hp1bSyzeCy+j9VIr+WCiIgyH0K4kXL0ImMLTPV
	 2ngDOWTqUhV+MMjpeNBaS669fLEJJtDBaS4m8yIxRtP9HmHY12EpZd7Ch5b+rlxDpl
	 87W0KLJaqJJCd7ANfy1DfBCIquGQzKgUhCusAX/TKF61mpZmuK1NfbC4/SwyTM5/Or
	 4TgPWUNhL1njBWXUYBEWp4ulbIYSf4ZHs1mec+CuDwF0KwYhKMQM8qafIPTYfXkbMS
	 nqUQEUA37ZxpTYCnrQrDTg5j+/v624br2Jsb8txSUtI2Ufk+9oACz+u/oeCR1Wv709
	 zFHFWs32PFMZw==
Date: Tue, 7 Jul 2026 23:21:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ivan Lazaric <ivan.lazaric1@gmail.com>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com
Subject: Re: [PATCH] perf stat: reject --field-separator and --json-output
 combination
Message-ID: <ak3scJT4MfbAg0G4@google.com>
References: <20260705005840.1252666-1-ivan.lazaric1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260705005840.1252666-1-ivan.lazaric1@gmail.com>

Hello,

On Sun, Jul 05, 2026 at 02:58:40AM +0200, Ivan Lazaric wrote:
> Specifying --field-separator option is stating you want CSV output.
> Passing both --field-separator and --json-output is then stating
> you want output to be in CSV and JSON format at same time.
> 
> Currently this combination is not rejected, and the outcome
> is a malformed combination of CSV and JSON output.
> This is because of inconsistencies in various printing functions,
> some of them have if-else chains that start with
> "Should I print JSON?", and some start with "Should I print CSV?".
> 
> Example of current output:
> $ tools/perf/perf stat -x , -j -e cpu-migrations true
> {"counter-value" : "0.000000", "unit" : "", "event" : "cpu-migrations", "event-runtime" : 474817, "pcnt-running" : 100.00,,
> 
> Instead reject the option combination,
> with a helpful error message and non-zero exit code.
> 
> Example of new output:
> $ tools/perf/perf stat -x , -j true
> cannot use both --field-separator and --json-output
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -x, --field-separator <separator>
>                           print counts with custom separator
>     -j, --json-output     print counts in JSON format
> 
> Signed-off-by: Ivan Lazaric <ivan.lazaric1@gmail.com>

Thanks for the patch, but it doesn't apply cleanly.  Can you please
rebase it on to the latest perf-tools-next branch?

Thanks,
Namhyung
