Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C71BA89C;
	Thu, 27 Feb 2025 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675026; cv=none; b=GLVHDSs6tnRTJlYvjxUz1yHnL5xem0J2hGuis5cSwl+xslbilNrd2sG8Vt9cthwGETNQDaRB4AlZo2SUjREoiwDMRYfKY/29+k01uPdajD/ivxLA5RDv7J2O37JHnziQbLQbKk5HUPAGY5QJI4gzAkyBvoh+I3R6MDUgeRFIBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675026; c=relaxed/simple;
	bh=u6jvAtjQDeHKcAULB4used/R8A/6KwlpQMJHvfjz/AA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rOj2cN63jMlpVroCOqi2ZgXss99+Jeqjd5I0gyb1Eli0NVfa4WvqOYYfQKrpvwIxyDV7ogQhm5XwK94P3G3DQMtQqkecbdEeg0EZzTScu4GpBW4HrcCV8EbskYo4GBWNk7v2fam8eaZZRIcMCsPKLsllj0cE+YpKOn1LVyVj200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3yxhoIm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3yxhoIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B30C4CEDD;
	Thu, 27 Feb 2025 16:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740675025;
	bh=u6jvAtjQDeHKcAULB4used/R8A/6KwlpQMJHvfjz/AA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u3yxhoImQdgK0Nr3pDpfaIJiiNCW/q0Gekek831NrPC3jgTYmw7Gr4BHuBF0YmA06
	 CDBwHGpGQUxS/zw+0Nwbl/BDb4nZhk/Gyh47Fh4k4ymlLmBzEpzExstQqlnpRTmrUH
	 r7RZGar/DhqzwHHqy10Gq1D6t5u0AHPfVfaI1n6EFcLMxXMEVtQjj/VxSrU1r8nLs5
	 jNpe5LsFAVMMCMRfOX9eumtsJZNnoncX0QfsFum95o+uPu4ehq8z0PRZaLfDodisHk
	 4Uu3JckZ8NeDySEoJXh3+R1Scv5iteJu2cS+dgLktAcZGKIObnq3lHq+5LQJWSY+Qh
	 hMvNOXwW2jWqQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Stephane Eranian <eranian@google.com>, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
 Blake Jones <blakejones@google.com>
In-Reply-To: <20250126210242.1181225-1-namhyung@kernel.org>
References: <20250126210242.1181225-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf annotate-data: Handle direct use of stack pointer
 without fbreg
Message-Id: <174067502548.1401960.6718661071804935248.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 08:50:25 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 26 Jan 2025 13:02:42 -0800, Namhyung Kim wrote:
> Sometimes compiler generates code to use the stack pointer register
> without frame pointer.  As we know RSP is the stack register on x86,
> let's treat it as same as fbreg.  But the offset would be opposite
> direction so update the debug message accordingly.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


