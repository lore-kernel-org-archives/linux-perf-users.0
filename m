Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22E2857EA
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069514; cv=none; b=tcZlVi8dYYZxmiPE0x65ka8sOMYGss8H/yjL5ySjCxNDs1LU6OdcQwq61JrUV2PCAqorn4MPG8XDrR9P59Z6FCvEJ7nUNXWv2WpPRMt7h2Eovn8VOQrCNvErPZQVoPBIMibBXvDXotEBx0BPBuzI7oGg7CslpBdT/XCH4iZ+Z5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069514; c=relaxed/simple;
	bh=nwtnWb2r+mU629TqlvAo27+SX+PargmWUT0OYbhqwrw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nfMyvkplhLIsThMThQK+Di4h8F2C4l0RTHAj70X75as1R2f4bwXZmw/WvsHg+zjxbC5V7UphrgsFOTMhk3VJYrSXKuieWR8177xIui7+SHot6ui4hY63boKO1dgg0Wa0gxRBUXqMbI+RfTgHT0e5m46USFxaz2fKROJq5IPsbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVNMKXid; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVNMKXid"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036531F000C4;
	Thu, 15 Oct 2026 13:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792069513;
	bh=nwtnWb2r+mU629TqlvAo27+SX+PargmWUT0OYbhqwrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jVNMKXid9EycvPL8Z+REQDigDnOsipPtNWvoZMlCZKoeQ10UC/m2hIHcwDyAwrEGR
	 v2MNZ8eCix5RkI8mq0/q5XDa8KIo22lTps7QHrc8g8odpEpPictKtOYwuwCVmHmOs5
	 xGg81wOfloStXwjfUBPPjrQ+s5vPFnXHeKWFII6B3BU0aE0ZdWqzACuVMIFa06FPoH
	 8SasvLVIbJJpgzS7Oe2wlqZn6PPzUnp4sTbQVcDM9cwWN74oFUZpilleEyg7BJUz/9
	 VSMuZpx8abrctid9nwvVRLhFprrZkx2iT6Af6LrfcXosV1NBPXZKNI4hy7lBAF6NQ5
	 D/V1FJ3tIX/rA==
Message-ID: <sashiko-outbox-172895@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Update cgroup time when rotating multiplexed
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoine Huret" <antoine.huret@bull.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015-perf-cgroup-rotation-time-v1-1-93e177dfee5d@bull.com>
References: <20261015-perf-cgroup-rotation-time-v1-1-93e177dfee5d@bull.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 13:05:12 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Antoine Huret <antoine.huret@bull.com>
>=20
> Since commit bd2756811766 ("perf: Rewrite core context handling"),
> perf_rotate_context() only updates the context time before scheduling
> out the flexible events. It no longer updates the cgroup time, which
> ctx_sched_out() used to do.
>=20
> Cgroup events take their times from the per-cpu cgroup clock, so
> between two cgroup switches the rotations see a frozen clock. The
> events rotated out lose the running time they accumulated, and the next
> update, usually a read, credits the whole interval to the events that
> happen to be on the PMU at that moment.
>=20
> As a result, the time_running of multiplexed cgroup events is wrong,
> and so are their scaled counts, as long as no other cgroup runs on the
> CPU, e.g. a busy job alone on its CPUs. Counting cycles over one second
> of a busy loop in a cgroup gives from half to several times the max
> frequency of the CPU.
>=20
> Update the cgroup time before rotating the CPU context, as was done
> before the rewrite.
>=20
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Closes: https://lore.kernel.org/r/PR3PR07MB69223331EED5BEBE150375B7849C2@=
PR3PR07MB6922.eurprd07.prod.outlook.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Antoine Huret <antoine.huret@bull.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-perf-cgrou=
p-rotation-time-v1-1-93e177dfee5d@bull.com?part=3D1

