Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B08479864
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708626; cv=none; b=gvEHr+RTXZbIm5vVYaYZunOseSyDqpz1o1VmLruubrLfBWreztEu5++sv+LpX4+Z0v8evuVhsN2KzGAiK0lyN80XbJlQ/5bwhOJnFSOzvPvLjc9kIjOII09BspmVRf5BUngnNMs5cagoDrRWJsaXK1YaG4nsyYyRO1u+VPWCeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708626; c=relaxed/simple;
	bh=SHmhNMKUuicGf3YhvGpd015j4lDdUvf/rzEqRK6Npk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMon5bwxn5ku+19l4gLu/IVRRn1KnRMmIBeugvyruF+ZwncZB804/3r+g9tpUE8fW29vNS54pDTJ2smQofM52XneYieGBeFqLBuS6UOVTAHE3pOFbHkkHZjq2KzR5DAU4T3XJ15kkb8cRyfs7Sap5qTE8UrryF/DWhhqFbfaejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPWRaPFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPWRaPFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0E51F000E9;
	Wed, 22 Jul 2026 08:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784708622;
	bh=2HQRXDYmfcMi0mg0rXCEwcS43+FjhTVzFh1WHpcJ8v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MPWRaPFxhRjkVElc+W5o308lLNxP5Ys6kO5p9kB1VEmTysf8gS8Hn3bT+nQbcEo8A
	 sFQTMu6ojHLBdafrhZWH97OxKFJF0+LRFcYDiUqEYh0fudPyZ7dOCR881nxuiuT/cx
	 5xasg0pgOh/ikVXebVWbsnqTflE0u7HjA6fm8eRreBKcLKKU+qF/2JScNkBkKZblig
	 6oOZDhmEruw6RJXeHbQH+/iCBJyw8UDPbxfir0N9jGvazRR+Bs5QEmtNvKqkdOAQW9
	 IBipSd+u8ZWiAByNHZlwOCCNa+LyaxHkUoV0zgMZfFaQDV5AyZbBEaBgp/5ucX7qo/
	 OhXqNkqEZwbpw==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	zeev@amazon.com,
	blakgeof@amazon.com,
	avivb@amazon.com,
	ilkka@os.amperecomputing.com
Subject: Re: [PATCH v6 0/2] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
Date: Wed, 22 Jul 2026 09:23:23 +0100
Message-ID: <178466981527.100304.690835278646398901.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782824005.git.robin.murphy@arm.com>
References: <cover.1782824005.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 14:01:16 +0100, Robin Murphy wrote:
> v5: lore.kernel.org/r/20260603150025.30980-1-avivb@amazon.com
> 
> Hi all,
> 
> I'm reposting Aviv's series partly for visibility, since the previous
> versions were buried in a thread, but also to respin patch #1 - Aviv had
> fixed up the bugs in my initial draft, but I also get reports against the
> original commit on my branch, so I ended up taking a second look, and
> deciding the improvement was worthwhile.
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/2] perf/arm-cmn: Move DTM index data out of hw_perf_event
      https://git.kernel.org/arm64/c/56603c28d916
[2/2] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
      https://git.kernel.org/arm64/c/9d0b1714e1af

If you get a chance, please can you take a look at Sashiko's comment on
the second patch? It said something similar on Aviv's v5:

  https://sashiko.dev/#/patchset/cover.1782824005.git.robin.murphy@arm.com

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
