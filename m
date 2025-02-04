Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797722163AE
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689968; cv=none; b=uugVvqmQd8gqRsURFpfHtQz4uxVbeGRjMX02PCJ6VDxnR75bs4ymiF/fajvsVoVwz0xjskk7fVey7zXm7elpX6w/oRSxzHS/FKizMKW5mY0mHpYYc6jkALx+3XmGsmacmN5REnZeUCzkmxLiJP0+pl5PLy9Ilc2bLTKSPnL4LzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689968; c=relaxed/simple;
	bh=0YzfeZdjLY9NVB3hSD+K0c0P5Etexu/0jXDH/iRQvJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IvqDcbKhUJmbJEumS2ybmzjridfXEZHU0pHtGG1Ekx7VQyLfxlyrRJBk9S1tXemxmeutO1jSEhmRTuKaGKatMv0t6gTb9IHk4lBvh7W1Arj1DnqDh0xWoRI7FVFVWcEKqkwN2OUkO6ws2La1ah2+JHJxKrRMfYfydy4ijaHCghY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIEpWhsP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIEpWhsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43267C4AF09;
	Tue,  4 Feb 2025 17:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738689967;
	bh=0YzfeZdjLY9NVB3hSD+K0c0P5Etexu/0jXDH/iRQvJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PIEpWhsPq/eR+z5UJhI/TWhzlHvtv226u92jC55JAIeS7hh4GZo284AvKG4fSOPsi
	 a1G1FOrS49CGcHfruZNVingRUkuPTV0Nw1W0/TQvzQOKOW2i9K46V15ddM+pK8OLnY
	 gAyQ3Q2+7ZXqUsTwlHrmbvvP6rZrextc9g/Tl8GWFLrKC58ZM/0+66JEuZauTtnKJt
	 /vxpv1KsYTxs384zT8KLxKvPl7kMxUGXDrckDY/rJ0r34vOyqdTNoWSx5rjocGEdCh
	 nhSzhpszuovMvxS73B7SdXqUmMIIdMUWZfNkOFyvyhA/84nL+jY6x4ayK16A7XOi0n
	 Xz7n59NvBbZZg==
From: Namhyung Kim <namhyung@kernel.org>
To: mpetlan@redhat.com, acme@kernel.org, irogers@google.com, 
 linux-perf-users@vger.kernel.org, Anubhav Shelat <ashelat@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 dapeng1.mi@linux.intel.com, james.clark@linaro.org, ldoskova@redhat.com, 
 kcarcia@redhat.com
In-Reply-To: <20250131145704.3164542-2-ashelat@redhat.com>
References: <20250131145704.3164542-2-ashelat@redhat.com>
Subject: Re: [PATCH v2] perf script flamegraph: force flamegraph-report
 script to run in live mode
Message-Id: <173868996721.666026.14385333375077778002.b4-ty@kernel.org>
Date: Tue, 04 Feb 2025 09:26:07 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 31 Jan 2025 09:57:05 -0500, Anubhav Shelat wrote:
> Currently, running "perf script flamegraph -a -F 99 sleep 1" should
> produce flamegraph.html containing the flamegraph. Howevever, it gives a
> segmentation fault.
> 
> This is caused because the flamegraph.py script is
> supposed to take as input the output of "perf record", which should be
> in stdin. This would require passing "-i -" to flamegraph.py. However,
> the "flamegraph-report" script causes "perf script" command to take the
> "-i -" option instead of flamegraph.py, which causes no problem for
> "perf script", but causes a seg fault since flamegraph.py has no input
> file. To fix this I added the "-i -" option directly to the
> flamegraph-report script to ensure flamegraph.py gets input from stdin.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


