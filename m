Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7AF1DA316;
	Wed,  3 Jul 2024 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720035380; cv=none; b=tYIvFJUlX8RboN1JX1kcADdR+CpZWO/2Q2PZRGErT5TrXYFbt/93ttkocbv5KRqk6IYI+7aEf6opJdxn9dXoYi6ZreRuCXu3BlKeva2QS4NmW+W/zNvk+tGvbPMRa+1uYaXXzYLd1rIan02gJjPJC4gcwFmHVyB1xLhpmdl71a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720035380; c=relaxed/simple;
	bh=wvJnBj/S0cpi1UBzVKpHlZ82ps8JxftzfYszzQdgOHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGbYUNDvg0ygVRBfiHQZlFQ9xC61FgUU69/aCntwBnQ02HKxQfm1drN1Zf3+les84vtfO480y7I789IDLmiyJfYXmHL1pQrDYVC3Cr1FOIfYl0lp7JdpZOUQO1SDqRZpLJT6HdY/CaTAfL2DPlbWbJ1E1f0qh64Q0hHEKSFDo+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE28C2BD10;
	Wed,  3 Jul 2024 19:36:18 +0000 (UTC)
Date: Wed, 3 Jul 2024 15:36:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Guilherme Amadio <amadio@gentoo.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Ian Rogers <irogers@google.com>, Thorsten Leemhuis
 <linux@leemhuis.info>, Leo Yan <leo.yan@arm.com>,
 linux-perf-users@vger.kernel.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] tools: Make pkg-config dependency checks usable
 by other tools
Message-ID: <20240703153617.650fcc1c@rorschach.local.home>
In-Reply-To: <ZoSP_vFMVl83pxES@google.com>
References: <20240628202608.3273329-1-amadio@gentoo.org>
	<20240628203432.3273625-1-amadio@gentoo.org>
	<20240628203432.3273625-3-amadio@gentoo.org>
	<ZoSP_vFMVl83pxES@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 16:40:46 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> +CC Steve and linux-trace-kernel list.

There doesn't seem to be a cover page, and it doesn't apply on
v6.10-rc6 nor on tip.

-- Steve
