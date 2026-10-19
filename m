Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5CE4F5DE7
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416648; cv=none; b=Scb06D+daH/49zqQJX/CZB3y/MhNrIH5gh0l9MVh6EFOUe+Qv0mtMV6cIr+GK1Id8wggccR35Puu5l6w82bA8cKIe0T3k9HC6GySRy3VrydYXDTTPxcoJvG/UR/C5lSEMLYHGvkCAO+eIEZQU5LXg7ujdBC3RioZgnjcNdidYNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416648; c=relaxed/simple;
	bh=BWASPwQKR2kBTnra5Qg6Tk1CKSldjiRrhCemeqzV77M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uQO1y8QjXth4ctPmxUI3V41BcWfJew1N03l9OIcIyIFkcMsYqGQdeEr70Fzl5k1+rOs3QLeJsjvTTOOlZVpqgyIQG1/IJwzF3CZBtWxsOrByz9IfX6QeliUhZVCtKRCQ+ubFw137jKDU9y1jlwhV2xqkSUhaSJqS85gqaLGnrOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDr9oK17; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDr9oK17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614DA1F000C5;
	Mon, 19 Oct 2026 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416647;
	bh=BWASPwQKR2kBTnra5Qg6Tk1CKSldjiRrhCemeqzV77M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CDr9oK17rfFMCgUj3usTtdsYbkckO46gGbYdSkc6NVUekj7GhN8DSY/ajIb2MRMAV
	 mjqRs5EGg3TgDzdymetmNxsTKQTR6OT8WUGMuslIgerVco0FvV9g8/R8X4YVbn5Vmb
	 g+O9p1PubXHUtBwfTlFzgOVKq6Q3xX1dpYnYEqjdljWGVT5hSqwfvrtULGoAG5xhY+
	 5BIdRfBdJBXKcmzQCjzHADzPBFSTz1QlnNI9dqtai83Ze8Kf2XzckyAw8Zg7mxxn/u
	 I0mEUDrfbLflTOfgtMKUKyjzMosU4sCtL7f4+7C+Leju1PaPkFFOHEg2JN8L2DS8Vn
	 0HV3zoUvRTLuA==
Message-ID: <sashiko-outbox-177158@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 15/49] perf/amd/ibs: Move
 CPUHP_AP_PERF_X86_AMD_IBS_STARTING post stop_machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019130856.49711-16-frederic@kernel.org>
References: <20261019130856.49711-1-frederic@kernel.org>
 <20261019130856.49711-16-frederic@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 13:30:46 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Between CPUHP_TEARDOWN_CPU and CPUHP_AP_OFFLINE, stop_machine executes
> all the teardown callbacks while stopping all CPUs in the system. This
> doesn't mix-up well with running RT or isolated tasks.
>=20
> In order to transition smoothly from global stop_machine to finer
> grained synchronization between teardown callbacks and the other CPUs,
> a new stop machine post function has been introduced to be executed
> after the main one with IRQs still disabled while other CPUs can exit
> stop_machine().
>=20
> Here the callback only restores the IBS interrupt to the normal priority
> on the local APIC and running it concurrently against other CPUs
> shouldn't expose any kind of race.
>=20
> Move this teardown callback to post stop_machine() accordingly.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019130856.4971=
1-1-frederic@kernel.org?part=3D15

