Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591020;
	b=py9oadVM/vvUoQfcdg9ud9GP76Srk7K3mP1RXabzzMYwj536/jRm+6qqQ7AO3QK/shPg
	 OhilFL2xsUnURoFwx040/BbSLcunoSzQS9Z3sidFiekgKuowfvQ3y/7h+cZ7FhhjHwvm4
	 045DLI0v8rL21WqaUKLFPw0sF/05KjgVJypGdkuIOCrh0u2BpEfdLGYo5vO7lhbVpUs/Q
	 yKEmWFrsDkvOoYdIGmi0HQnOEY5V7IbRMorjQNNB1aVVazhQnRG5f3EyXYtafdH7Sv+ms
	 ibsI7O5FaeN0eZpUbK2XABQqMPdOq/+Yf2f2inLDNduLLENSIoixHcDOqYlh+bA2Oow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591020;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yJTEur3QS1DWWr3IhYlZFnfwGzONf+vSHNbviB7kho8=;
	b=rZCAUPXQTo37JDWGsFfFl1gRjtv3PQktVev6doQt/cnFSyKXA7QFpcPHS7bloTs+g+Xh
	 hIrvaIB4B5d/XPv8dflgkpApO+u9wCEgomOAyk4JYMDCYz3kAixaI8OOihI+WN+6Aa7/e
	 bh/2LZ0/TfQquSPWcrzPgN4Br76LGYV5us3wRklGfIYqHfvVw5sn4qi3PerXDWDV4N//g
	 qj/49VHwuGCA+Ji5O8M97Cz7of2tkgRO6FCNTNhilH8njEleTtdLGZsJGEYXBxR3Viuiq
	 7v7IJsCYnKbEQ8apoHlHRI6JgCvRzmBxy0Q7t49Dhosi7VATaWUxZPTSzyDI/v59Xgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGnrjBTS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5EC6070F30
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGnrjBTS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923341F000C6;
	Fri, 13 Nov 2026 17:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591019;
	bh=yJTEur3QS1DWWr3IhYlZFnfwGzONf+vSHNbviB7kho8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DGnrjBTSGPtssShSlxJOWzLYbLSzQcj0IEEQCrcOKYbmGEGUV6fYkRHCj0/swEKkT
	 SwooiQorJpI/1zTQm0Hthuq8wqDq724yP6J01Wtwxe7t+jJG/0Kgdvz0mc8mgP0+BQ
	 cEzoYwUIUzWAt73Nejob1nqnF8Rj/rnOwzM3d5T1EZtbWH9NtKwrGrp2UjqxjmloLa
	 RpRpmtSCzgHfb0hbUpszaKye0DX4Lh8usqhZVlZpEqE+MWS8bE3aL6GkiwGDtVFclI
	 k0PfXr0cVIZkWWZnnlagUWgihJY9+4m5I1xDTkUvBXJp2OZ8+nFNEqDDyI8yyBkTnf
	 WPpDqcdkVMbfw==
Message-ID: <sashiko-outbox-213311@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/23] perf threads: Avoid table->lock self-deadlock
 in threads__for_each_thread()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-3-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:30:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> threads__for_each_thread() holds down_read(&table->lock) while invoking
> its callback fn(). Callbacks such as perf_session__e_machine_cb() call
> thread__e_machine_endian(), which calls machine__findnew_thread(machine,
> pid, pid) when pid !=3D tid. Both threads__find() (via
> threads_table_entry__set_last_match()) and threads__findnew() acquire
> down_write(&table->lock) on pid's shard, triggering a read-to-write
> self-deadlock whenever pid and tid hash to the same shard.
>=20
> Snapshot each shard's threads with thread__get() references (using a
> stack buffer with a heap fallback for large shards) and release
> table->lock before invoking fn(), matching maps__load_maps().
>=20
> Fixes: d436f90a64f3 ("perf machine: Move machine's threads into its own a=
bstraction")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D2

