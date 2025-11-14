Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0472DC78E;
	Fri, 14 Nov 2025 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145333; cv=none; b=lpTNfpJp9xpCi16mjgocsWNK5nF8OXlPP6hwxiL8Jzr8L5QZxp3N8S/AtrFq414NZKryv4bIZKVvOsbFBsTz5DhnpaTgYO4908XDaCNiDG4SgY/DlPJaB257yg4mCnIBsOm0NUfYzHc5WMuhh8t+G3vnxVM56hCsmKa51bqqhLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145333; c=relaxed/simple;
	bh=36cRTe/WyJjA55hFKVVbZLuMuZF05sRrDdliLnUDIt8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RcBgtNcxlJ9xG5gfd0VNzVnsz2VCsvEewZU15MU5PQJtkeGYS+edGx2/X1x5ISFsA/00xD9jcePvbfOS03d26yO9QWyo+saJi7UhpeGQy8HRKdD3Er4i3tq3wS4M6Y+Tg86A0r1RYYshRLZ0s35LoGTswudpT8OF1PxrCyPrhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8w5opep; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8w5opep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE91C19424;
	Fri, 14 Nov 2025 18:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763145332;
	bh=36cRTe/WyJjA55hFKVVbZLuMuZF05sRrDdliLnUDIt8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=J8w5opepR9kD4rUGmbFxPLjybjdcMvPRW+FIjYD7Do8SeZHAaJgc8Ev8Mj4mq0tM7
	 H30dYEgRHnxHj1WoBQx8/i7sEv0PyXqXktubY/L1fMi10gMUrW5g2VezSR5TnTeKZT
	 FRL4tR3QFRGM2j2DL//BuCelZa/IjYS1/aPmlGQbb2v1zjN+yySLaz9TaCq0PxxC5r
	 GGpG2pD6E6TP4+dZRUzvK6sDvrVikkJ8ekFQ/P0fE1X70gW8MvRKdRycBz23+48FtG
	 n/9//+nhwE9tIFHuecrVXlC/2Nwc9uJInBb7nGk3hBl1ql6mmWhrC/hNY3D3MgB1g9
	 8Qo5QDxeybYsA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Thomas Richter <tmricht@linux.ibm.com>, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20251112162439.1553368-1-irogers@google.com>
References: <20251112162439.1553368-1-irogers@google.com>
Subject: Re: [PATCH v1] perf vendor metrics s390: Avoid
 has_event(INSTRUCTIONS)
Message-Id: <176314533161.3522480.2883210310657766484.b4-ty@kernel.org>
Date: Fri, 14 Nov 2025 10:35:31 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 12 Nov 2025 08:24:39 -0800, Ian Rogers wrote:
> The instructions event is now provided in json meaning the has_event
> test always succeeds. Switch to using non-legacy event names in the
> affected metrics.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


