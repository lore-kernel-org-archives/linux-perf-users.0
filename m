Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1503839AA
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620915; cv=none; b=UBwqJB2k36CGcRCcA07kwCrtpPOX2+C3JcO6W/fenU0l518y4Vqlvx3EDF3x6eU9dfYFwiosU0lkVQlTi4t99jYljvtqM9zQ74W6T91GTTFnP5K5nu1/Y9uOan2vTvlMXGCKxqVUTqjNlYVAwII+BQwkCDuivuSfmX0X+AHHVBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620915; c=relaxed/simple;
	bh=bWDeXG59qSL26vfe6kwRiMcGtBnWvhGFtVq1ROFQJI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O2/Ynt5EksK4gWPBvbsAt5137E3Q43m0x1GGYlRnrpomsDYwogQwzGb4UFdJWSYGA3fwuMd6CP8tIlruz5hI1J+ytfHF6btmrX981A+cAB97J078MHf6RiJvv89LEJoySryApqgF34HVRymYhhxpLQXY4gcDpdJKAx3MU2pedhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItMUj0w7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItMUj0w7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1971F000FF;
	Mon, 28 Sep 2026 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620913;
	bh=bWDeXG59qSL26vfe6kwRiMcGtBnWvhGFtVq1ROFQJI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ItMUj0w78lOqjLDPO+DhUAYtNGvrCnK4MDjK5N69/KlV4rxAAq/4NkhEvlqHbzcQX
	 YKfk72Olcxxl27QjEbxvzWKIBP3Hp30eL+zf003maJQwvU6aczEiEjsnoBYVcffriF
	 KI/HQE/hl1YwU8DqZ17gP48ROsR/aMjbzuRglrCEFUx9TQsamlojYYgDzufyo2HPrz
	 SKkFmtXFD5m0J29aV1LmObFfL9C16saNtEZutT9WI/C9wDZUDhCLvUBpyYktyxr5V9
	 FbYWp9qGV9oFh946TMepubKerVnYbh9YnpPdZTFMx7Lxj8Qro9BrhgG5HACQrSmxkO
	 z+awI+ciqrlzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 22/26] perf test record+probe_libc_inet_pton: Scope
 event to PID and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-23-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:41:53 +0000
Message-Id: <20260928184153.CB1971F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Scope the uprobe name to the pid, retry adding and deleting it as
> concurrent uprobe_events writes can fail with EBUSY, and delete it from
> an exit trap. Create the temporary files with mktemp rather than reserving
> names with mktemp -u. Remove the exclusive tag.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D22

