Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8B390618
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078290; cv=none; b=fdggSj+XN8cR3GELWwrCaW/h3eZUW8LALPsYD1myfVCjhyNa6uEMa/9qJNuY4jO8XbRZZnS9xUcsPNmPIFKYqUWris8POq/QD3ujXxgjfTqUNC8HfD483jh9eiZf0O9fLOBtDKHxfZGcLO6Q1CEowRnZLBTAEZ1VLq2U638guGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078290; c=relaxed/simple;
	bh=AB2MO8B8CmJ5huHnibA/u++gZiDQ+4VxpgrHDmqG8Wo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SlQKZDSjOez1duFbhC/x8TYmhYaGDJmUR7En+iqB7zlxinoXUUBaqbp28OPV7swSn7JkLRQt87VKcO9MVwPBm/W6LWIrSZr7z5bdTyHUAEzkXavhYrsGFZ4lI3UIC4J3VilFuoMUwlaJRJsBzmd9XxamN9zpSntUYmTjUrrXzQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5I5D4lt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5I5D4lt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F551F000C5;
	Thu, 15 Oct 2026 15:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792078277;
	bh=AB2MO8B8CmJ5huHnibA/u++gZiDQ+4VxpgrHDmqG8Wo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g5I5D4lt9Wq5sO+J2AHMJumMqfC5eojkv8LdKahW9MUhJmpfPJSR/KLVdyzIfjVLX
	 oPvRchnFKVEMcUmyOVGBdVe9SjgNLLF3Y4nwopS3JQ4unaUrlLVzOQv2x3ZVXoFUqG
	 7z7mx2tW4caG+KoMaAsRErkTSt9VVUKBy2pHG5HC6UqaWM44clg5c0VfKoztXQDQjN
	 Qy4++/MO4httei4jLzMWqAZC/C1WoMgszUYRsh0qEKYPtkQjYwj7kBRJ5MF86OJ4ki
	 TQiG2FK2wyGUn8It5UO/omlRGgPZ+IXBQ8798jDJSwdVo3O6cUR1LjohDyclGzgALG
	 LJuDKVw3zZgSA==
Message-ID: <sashiko-outbox-173075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf/core: Don't send SIGTRAP after exec removed the
 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danish Khateeb" <danishkhateeb03@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015152013.106040-1-danishkhateeb03@gmail.com>
References: <20261015152013.106040-1-danishkhateeb03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:31:16 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> A sigtrap event must also set remove_on_exec, so that its SIGTRAP never
> reaches a program after exec. But the signal is sent from task work,
> which only runs on the way back to user space. If the event overflows
> shortly before execve(), the task work can still be pending when the
> task enters execve(), and then runs when execve() returns. By then
> perf_event_exec() has removed the event and the new program has default
> signal handlers, so the SIGTRAP kills it.
>=20
> The exec_stress test in the remove_on_exec selftest catches this and
> fails about half the time in a VM. A process that opens a sigtrap event
> on itself and then calls execve() is killed by SIGTRAP in 15% to 50% of
> runs, both on an AMD machine running v7.2 and in a VM, with or without
> close-on-exec on the event fd.
>=20
> Commit ffb684f2aa14 ("perf: Fix race between perf_event_exit_task() and
> [ ... ]
>=20
> Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015152013.1060=
40-1-danishkhateeb03@gmail.com?part=3D1

