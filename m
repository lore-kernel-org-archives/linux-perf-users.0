Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4146438029;
	Sat,  1 Aug 2026 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583730; cv=none; b=k1sCJtcK07dFC5kcep760YI9Ev5JYi+wnYwEsmaakiXLo29GJsi/6H7ZypOne8RsrmNwsfkqhmVT+E+v4oLrCl0gKI+kxUCPbhI7hJ504ucf/9MB5HO74bD8okWbiN7NsXcFfoJry3VHuNdhDPHiRryciFQgHL+aVoVyOAcJ/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583730; c=relaxed/simple;
	bh=JpTO3eqMIPrhICzmbLqz2MpX1J3/iEmleEvrJZJGUL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ks6jvXPhWBl3ZsdF3HbD8gVKf/yYvwsRT90kVu5N6bw2CxY+UdwPvmFXlK7k2L604ZUlqhDzYz+guTnUJTHvGvYhn4FyIxAyCwdPYPlB4sUrTK2hH7DVzcCjaJsJW2ZFSqiS9VGEnP9/n3YXLoXS4z/ttrAxJTokMu8jM9XhVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeLVnyd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeLVnyd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D331F00ACA;
	Sat,  1 Aug 2026 11:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785583729;
	bh=hJFRZYvUMbiVIUOjSQH500WaF8jMfo/BVWXDkXdQIaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OeLVnyd6zGgLFlnhUiVUgc1C9g7ew9Y8Gn9so0Dzjq7p8dz/R/WEK7EDgRmqlgSPW
	 7+fMl19S1i3WzGWYMvP68Mb6bQqgj4a/W9K3XjvabG8uStuGOR/dFhgHFPC/1wgF/G
	 pMAWeYOEOYVSCcFgOODx22ciVjQ2XK94oF4XTnkmqHKyEx51CQedmxEE8TCJh5nKaL
	 rHsJHfk0taP1pXAClIZlsQ0O0e8fiEvwKQ79g5HuLvsResNEN6KJMPDPQLbc9NhFHk
	 CcfoQND/759OElU7zCrv3eKOgOCsfiGPZVgnj5iyXeVm5Xhhq0DTY0GaiaADShbARy
	 LsebwpdGeCm8Q==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leo Yan <leo.yan@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] perf: arm_spe: Make wakeup range check overflow safe
Date: Sat,  1 Aug 2026 12:28:30 +0100
Message-ID: <178550621893.239311.16566989493274037656.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702170521.4103426-1-leo.yan@arm.com>
References: <20260702170521.4103426-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 02 Jul 2026 18:05:21 +0100, Leo Yan wrote:
> The current code checks whether the wakeup point is in the current
> writable range by comparing it with handle->head + handle->size.
> 
> The perf AUX head is a monotonically increasing index, so that addition
> can overflow when head is close to ULONG_MAX. In that case, a wakeup
> point which is still inside the free space range can be missed.
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/1] perf: arm_spe: Make wakeup range check overflow safe
      https://git.kernel.org/arm64/c/fcc5eaea2d23

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
