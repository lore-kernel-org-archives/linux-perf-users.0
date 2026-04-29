Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD92FE58C
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498347; cv=none; b=iUzTLoQ+6vMEzCF8LZObmzaSnLd0KqeJQlkdHrcVg9sIYn1RjGo+kF3QY5G6JrYAv+Lm8Dd2Sw0vqPe6M1QqtxnSstJ8n6HIHVw27nZlGXuMsfzlXHyk7qLRAIP1Qwr1mmonD9Rlo52u2qPfS1kX2bbsJ/VkEIYs8kbKCIBcCHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498347; c=relaxed/simple;
	bh=jLusxmMsG4qd61k3KrzEpU3XONmrh0EJLgh0HGZWkjU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GKp7ad1YUzHHNOYfJBmZi4+mxudSBaZ61bt4HFkEE30LzT3NtVFBaPstHqoC1AsVaCsfUkP9KTf4Iv4EkEScp3M8F1U33vJY/y65UKjUROana52gK1jd3/15pdbakodUqLBRic2x8accbarPUhEe+ibgky2vIOzYT8GuPOoKnw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6qG9RLH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6qG9RLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881D8C19425;
	Wed, 29 Apr 2026 21:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777498346;
	bh=jLusxmMsG4qd61k3KrzEpU3XONmrh0EJLgh0HGZWkjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=N6qG9RLHnaESGU2lKnW7it9/rKaz8B5tfkTWvfrFIaXSwfLOo93g9ypw9MEY/8/KV
	 2KyhtTZHu7vZDuU92wA2W3VRZe5JmrtoytEaiFjbM8DBNUUZw/UvMRpQT7ybghqkmx
	 QUB17UEyddFfQgxrtv/L7fSrP8Mp4D2MzKd7LFgEn5CAolimpqdaP0rQNjKgaiqyG3
	 x/M7VLuS2OJKUf1F2UaElXbfhTDlBiFxcXoriO1Gj7ILT/dCoylIrXTJeIOHsC6qXe
	 kSHi9z7M5QGQ+cMxu65L/pUjmtdsdjyDLWlqqIvCz2oMFUQpxJwkiposELO/PNtP72
	 Q7UDpJZyJ6Mlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH][next] perf/x86: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Reply-To: sashiko@lists.linux.dev
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <afJcDg1I5ZU5ZkXf@kspp>
References: <afJcDg1I5ZU5ZkXf@kspp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 21:32:25 +0000
Message-Id: <20260429213226.881D8C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typo in the commit message: 'inmediately' instead of 'immediately'.
--

commit 0317549343d8f9b27dab5b6a63ada8e7200c73f0
Author: Gustavo A. R. Silva <gustavoars@kernel.org>

perf/x86: Avoid multiple -Wflex-array-member-not-at-end warnings

This commit fixes multiple -Wflex-array-member-not-at-end warnings by using
the TRAILING_OVERLAP() helper. It overlays the trailing members onto the
flexible array member while preserving the original memory layout. A static
assertion ensures alignment is not inadvertently changed.

> Lastly, the static_assert() ensures the alignment between the FAM
> and struct perf_branch_entry lbr_entries[MAX_LBR_ENTRIES]; is not
> inadvertently changed, and it's intentionally placed inmediately
> after the related structure (that is, no blank line in between).

This isn't a bug, but there is a typo (inmediately) in the commit message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/afJcDg1I5ZU5ZkXf@ks=
pp?part=3D1
