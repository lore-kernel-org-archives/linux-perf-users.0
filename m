Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520BC23D2;
	Fri, 18 Oct 2024 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264809; cv=none; b=BiQdmHb7UlZQHB5JGbpUxCwheAp0Yy7ppQsB0FhwS17zqTw74q3Bq/6C7AQ0hI+O3ggk/KMlB1odjXSD7qZ0ZxZQ8DAd3Qtocrt7726CUdVxJcIkqpPpkXOHElIn+ykvPcfZFZDGHJfdx+O4adI8Eko2gv+twYF+BIDjID0Xp7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264809; c=relaxed/simple;
	bh=dYgNxH1KAZzJc6ZxlPcZAP/+GEwZCh9Os7i+9GyR4d4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sVcb7UdRg8Jq19iMnZ7rb7zb3PRWT1Dmo8iSTkBhqkNurw8qxuFqemIj2BdzanOdJop+m3ySt029nyJQ6VDIMfRsvkaSAXm+18jaPJawWj7oFXWuO8cwrkuz94JekpD1b2B7zq+bjLSzLE1tvZpC3wJ8zvYtV+0Csvzzp0sT+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPEIufVF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPEIufVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905CDC4CEC3;
	Fri, 18 Oct 2024 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729264808;
	bh=dYgNxH1KAZzJc6ZxlPcZAP/+GEwZCh9Os7i+9GyR4d4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rPEIufVFvVle4/hC2CotZ+UlZBgPEYWocFgsbfUR8kAoE5OvZ7o7IDFQj23hLpBmR
	 jHfUUfSOqhhSlOvRMNCl6yf/yXEOebgbLyhubypDljvYJd7Yj0Vo0UgZUMHa2Xub4c
	 8KL3dnkKcBSq1JYM/R+dfoWGIMp1MoKAm0wPQjSYWIvtikr1OJJvWXWagXDethSbI1
	 jzF3e6p6ABhjkQZQNN++aEhDwixxl9VATp+0Icx45+DCL5NWRFGvkRp2lXE+Ylryc6
	 0gTehoePjWHfYi7sw8Fbu53zQYVGJkcp2NadIBa8AG35Emcem3TOvVUystVxkjltcy
	 IODv7J7Lvg/CQ==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 irogers@google.com, hbathini@linux.ibm.com, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com, 
 kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
In-Reply-To: <20241010145107.51211-1-atrajeev@linux.vnet.ibm.com>
References: <20241010145107.51211-1-atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/2] tools/perf/pmu-events/powerpc: Add support for
 compat events in json
Message-Id: <172926480855.1381973.17233939395641584642.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 08:20:08 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 10 Oct 2024 20:21:06 +0530, Athira Rajeev wrote:

> perf list picks the events supported for specific platform
> from pmu-events/arch/powerpc/<platform>. Example power10 events
> are in pmu-events/arch/powerpc/power10, power9 events are part
> of pmu-events/arch/powerpc/power9. The decision of which
> platform to pick is determined based on PVR value in powerpc.
> The PVR value is matched from pmu-events/arch/powerpc/mapfile.csv
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

