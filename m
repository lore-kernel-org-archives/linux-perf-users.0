Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D0503916
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663460; cv=none; b=tdJRHPyC9ojwwpPLRzG5LvMkzqh1TEc7DJzenwumZtMAeZK5QXxzLQcOqZwH9rACGlqR40169hDPVRIftdKgwyRQAWcW7Keo2qGY+fMXIOGd5L05u1KvxksumSY2EdJ67GG4LZmQMNwRmfZ9ueGMaSIodezdZaVM4mepkBly7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663460; c=relaxed/simple;
	bh=6LLCB2rDU88BsagHgrAXh/xPS7XBYqwDSMzWdsvMNWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h2dmY5MWHwUYbe+KdTztkbQMH8GELLqGPMdwB0IRoex55dPSfzYtOUX+YydbHsyjsDOrr2rMQZ6XDRKcXaN+L9JOyNuH0vG4u4owSsV9xw+yMm2Iz1PDEyamNfyfue3vxND3PnNSGyi1EFyc6UjEGHwRXLFRI4+T35XR9mwdvT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThHPoKug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThHPoKug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38E51F00898;
	Thu, 17 Sep 2026 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663459;
	bh=6LLCB2rDU88BsagHgrAXh/xPS7XBYqwDSMzWdsvMNWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ThHPoKugeQKOOFYR3vxpOZTvVeG0gEwMQKbStfDk/msK+j/lHOEliROQSTZ2ygEv0
	 tYHxzcfqzgbc8nVvZrPlXR4wlRs99hbjOG1s17C2stFs+VHR9xsWijodguRbpjvIv/
	 C4Y4uYag9a2WgVTP/n15VdZsAj/A0ZYAXLo7QdDJyDt77lBzVAt8WKCU/JySW+sR5Z
	 KQNJABWYrEX1G/0+Bfu892+W3+5E85XZhSPsOE9paFtWRjtsORmPQkXq/yWmKYjBQi
	 G6DbS3HHmTw+7H7QUCzsQpG8ATiD2KdO491XoP2rK4lyVeJTLqeE/mX7uCSRbPHQrh
	 GjEQ00bsYAX1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/14] perf trace: Start BPF summary before starting
 workload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <ee1ddc3779258c12aa0df06eefdaed2d1f025fc8.1789662556.git.irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <ee1ddc3779258c12aa0df06eefdaed2d1f025fc8.1789662556.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:44:18 +0000
Message-Id: <20260917164418.E38E51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When using --bpf-summary, trace_start_bpf_summary() sets
> skel->bss->enabled =3D 1. In trace__run(), trace_start_bpf_summary() was
> previously invoked after evlist__start_workload().
>=20
> Because evlist__start_workload() immediately unblocks the child process
> by writing to its go_pipe, short-lived workloads (such as `cat /dev/null`)
> can execute and complete their initial system calls before
> trace_start_bpf_summary() is reached by the parent process. Furthermore,
> under high system load, the child process may finish before the BPF
> summary tracking is enabled in the kernel at all, causing syscall
> summary tests to fail. Additionally, if initial_delay was configured,
> the workload was started before sleeping.
>=20
> Move trace_start_bpf_summary() to be invoked before
> evlist__start_workload(), matching evlist__enable(), and ensure it
> respects target.initial_delay.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789662556.gi=
t.irogers@google.com?part=3D2

