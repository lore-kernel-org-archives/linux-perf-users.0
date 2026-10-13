Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3744A0EF6
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916533; cv=none; b=gGKXjgctfvLLZVRZOhFwdBl3L0OxvWxI95raJVdjxFEobL7KRlsFTHvFiVPqbUvypwAOwMeaVJmV4SsH3vSFmyqFSPL2lR26UuZyjLVA6JFKEMBg56HPyr00HqUohhK7lEPkctsQL+MC45RC1yDZM1WYw+ThsLAHggp/xuhYb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916533; c=relaxed/simple;
	bh=tdCe5zdmmGgUVGkvOcAxsfPs6246DbMzXlms/wHK0I8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aHLPkc1yGODw8hvQzrqv/JR0B6ihCpxT6UymG0ZCTIIefqE1c0SUTXAYk/k6VdiSOdmg1TEo4jm/X7zROlgQmWHma7LPgczcmthrr5Ja8nxmSPMoLYGy8fy8JyGLWw0LAbp8Uvo+Z55jm3ZF5lP0IGqDWEkJ8aozPrCJ+EagjGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJt5qVxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJt5qVxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C57A1F000FF;
	Tue, 13 Oct 2026 18:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791916531;
	bh=tdCe5zdmmGgUVGkvOcAxsfPs6246DbMzXlms/wHK0I8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eJt5qVxW5JS3JmTMJHMYcbET1rWJiQv6AYDJbq8vwH+5dlzl+wrP1zU6K4oDLHE/+
	 YY9SWcTcG1GgKBWNEHlc8b5/LrS8397PqipOHvVwDPM/NK1CbGgV1ro+g82TrT2WR1
	 GuFeJXz/AqxYPiCqit74miNqVNJHA6KPTUhauEV/jGC4Tn9u2sN5P48VKXMqs6z3zi
	 kePFwp9FjAM/joo1ioSSm5s/9lLhK54oyHoLpitH53ohPAOP9rb/DJgOq3hfKBNQVG
	 f78Wid501Z9t3yoR5XNIo322qqQyIPPV/A6Pe2bUZaYg1WU/o18kMC8O9x6bRHTTkU
	 yZIHGll+KK/uQ==
Message-ID: <sashiko-outbox-170339@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/10] perf thread: Expand context analysis
 annotations to threads and namespaces_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013182458.1234616-9-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013182458.1234616-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 18:35:31 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Annotate shard and last_match in struct threads_table_entry with
> __guarded_by(&lock) and add __must_hold_shared()/__must_hold() to the
> last_match helpers in util/threads.c.
>=20
> In util/thread.h and util/thread.c, add __returns_ctx_lock() to
> thread__namespaces_lock() and thread__comm_lock(), annotate
> namespaces_list and comm_list with __guarded_by(), and add
> __must_hold_shared()/__must_hold() to the namespaces_list helpers.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013182458.1234=
616-1-irogers@google.com?part=3D8

