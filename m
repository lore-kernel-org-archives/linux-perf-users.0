Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2751A156
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663621; cv=none; b=edDIlIzAm7ywBBjipH6sTsUm7iPzUd/OxxtvEJtg3LcUurObQ7MhPZ4H+REiAjLWcFL43vwvaZB17dYxBfescAItnBoziQF9ZjPaIpTk9DQISooksFPf2whMcPtxcqFZ5+WsUhNwjWOLRlCQoqWZkZiNS3E1coUCwH6u9sjzvYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663621; c=relaxed/simple;
	bh=o93CLH2Nh0j499EvYkLN+aYC6UUMdOgRMxyWcmHEaAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U/JddCgwbhQ1deryxU0cZPOdM2qS0SLbZgVzlEiSMuMGECCkY2gNm0jUVUPO2Ixfuyv7Sbj61PkWBbKMe2Q8QRPgg2fQKjX7UfXJFi/u51mrAUfSi6kDmVjnwzz8/Jl4cSY9KeVYkjeMjihZ068tjRmtqrNoHcE04zePQ8yLdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9b85ZtU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9b85ZtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853D01F000FF;
	Thu, 17 Sep 2026 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663619;
	bh=o93CLH2Nh0j499EvYkLN+aYC6UUMdOgRMxyWcmHEaAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V9b85ZtUZ3RmrXTppJQ5ja1o3P7daVW4J5wdYGXPqMi+BGmEpKC2PAeYcM+g698Hd
	 YwMlVw7CjKRWg9wjODBR9Lu5lyeHnNRmh+foPGqcEUsCtVAltAVw0Aw9VeZaPyH8HZ
	 9esmGrPA2xHlhPwVjaOJqI+l4dJS6uQYy+BpiwyveL84+aF5C8CCujeogn9agUSaDR
	 iVwVLRLZfaAhigJdVe/4Kp1y7NZ3Hfr1frBiZqFSUr3etaU8BvdKMQtaWWggPFPVZz
	 MTLUGUkFQkX4Cxw9VBn6ztcVWJEPQkcRJxSXIwx0MK1jaB/rUgAmFRLuUX3QHbpXuM
	 3R7n6Mwka3IbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/14] perf trace: Include the headers declaring
 pid_t and strcmp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <73ad72faa38e0287b3ead119e28ac15e0caac34c.1789662556.git.irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <73ad72faa38e0287b3ead119e28ac15e0caac34c.1789662556.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:46:59 +0000
Message-Id: <20260917164659.853D01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace_augment.h uses pid_t in the augmented_syscalls__set_filter_pids()
> prototype and in the !HAVE_BPF_SKEL stub, and bpf_trace_augment.c calls
> strcmp() in augmented_syscalls__find_by_title(), but neither pulls in
> the header that declares what it uses. Both happen to build today only
> because something else in the include chain drags <sys/types.h> and
> <string.h> in first, which is not guaranteed and does not hold on libcs
> such as musl that keep the POSIX namespaces strictly separated.
>=20
> Include <sys/types.h> and <string.h> explicitly.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789662556.gi=
t.irogers@google.com?part=3D1

