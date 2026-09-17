Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9D3769E4
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627831; cv=none; b=KaTB5Iv9m43vO6x+9QbF5TTrAZy8R0My7FepoVTBPAr61wqra7ll056kfXdvoLx1U0QbV6kolcrwxNU03lu2qv4+Os3gcXZ9k2vaMv9PYkpsnSkWk8KJV17wCmNNXNfy3um7bUGzEDop41RMi2+VUPT89UlZ1otbrsCCOx4zJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627831; c=relaxed/simple;
	bh=Nyg0gTh5/RFSUr7wI1RyKkY+SPBeAyl+gbd43BtfDds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tPZD8f/LnWeSarqZdVA7F7IVb1d4YkMmUSwXou4YKGNYA7t250yKC5Vd1HAMK/j+IC9tMGcXnRE2a5W+YjuKjj1TCBlDRcyrQljuFjcFeAnBqbA9vBxl21ck2WLUtSmZgN0y260d0GcWloMXOsaFZ+3DdrNrY/K4Mp9V96TkrSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv2Vdy6X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv2Vdy6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7991F000FF;
	Thu, 17 Sep 2026 06:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789627830;
	bh=R1EwhvsNVJajkS0hzSNeZnYsXjG2YhdpoVoZ6yI0lj0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jv2Vdy6XOauk6UjWhk1UMxOwbvt9YR8+hSJKh2Mk0L2wOtuLFnv23zo2D3ZiJqNfe
	 iVKZVMjYrzvVESXX9BA6BZGULFXq1SRRvCpiHmfYUFAXF8KCewDt2dSqXgbMEY7HE8
	 eP8ZsCjSkX3aDHWoHujSUNOcfAe5Xxx0gLdfWKi9KGcOt346zPwxMUQ5iza3Bt2uep
	 4hMzfDFu18gcFi3K4RnwPKju4VsvcbbDTcaF1WeTnNuDQS1RrpOZPchc/7TVlSjZIV
	 E2tbZDm20kKIU9YqqYkFNsNiwzMxPUSjkxJt3Vq/OmJyzAl8Qi2qF4byiExBmGSwNY
	 vZ2ydLFb45QDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/13] perf trace: Handle fork and exit directly in
 BPF filter maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <301baf74713ea1b7ea6bce83d83edd8820b6f1d6.1789626978.git.irogers@google.com>
References: <cover.1789626977.git.irogers@google.com>
 <301baf74713ea1b7ea6bce83d83edd8820b6f1d6.1789626978.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:50:29 +0000
Message-Id: <20260917065029.CD7991F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Updating target or filtered PIDs in userspace upon processing
> PERF_RECORD_FORK and PERF_RECORD_EXIT events introduces latency between
> event occurrence and userspace BPF map updates. If a newly forked child
> executes system calls before userspace processes PERF_RECORD_FORK, those
> syscalls may be dropped by BPF PID filtering. Conversely, if userspace
> evicts PIDs asynchronously on PERF_RECORD_EXIT, the kernel may recycle a
> PID before userspace processes the exit event, causing the late eviction
> to silently drop a newly created task that received the recycled PID.
>=20
> Address this by attaching BTF-typed raw tracepoint BPF programs directly
> to the scheduler task lifetime tracepoints:
>=20
> 1. Attach SEC("tp_btf/sched_process_fork") (sched_process_fork), which
>    runs in copy_process() in the parent's context before
>    wake_up_new_task() wakes the child. Using tp_btf rather than
> [ ... ]
> all, as evlist__prepare_workload() leaves the child blocked on a pipe
> until evlist__start_workload(), well after the attach.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789626977.gi=
t.irogers@google.com?part=3D5

