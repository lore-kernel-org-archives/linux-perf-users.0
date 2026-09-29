Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF4746EC80
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663834; cv=none; b=oSie1aHDfOXaTkzzJJzHg8g/Vg5lA0bdehzAD4OfPGOlLjcmpUK02svGC6y6EC4Hx0PZxgO88uxdMHxTQaAntXwNWaXiv/d/CyexZuw5eLAQ9d8Ld+oqjvpI1k7NE9V11cS1lSQFYNzIySK+van0LmjbkX5cfyCakB9SkjDc/Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663834; c=relaxed/simple;
	bh=XnxyX5MBPRfi1kIcZnf4uw3ssw7A8umDxIWbe/lappU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EIfXudRisT5oo9cnc2YWDSYoox+Yy+hSxKu9UopFMZ+hbJZgDop77EpGSqz7RKwwnIidxFgCq+Dp1t/r1rY8UkQgAnUp4HLFPzvfj9hvngBkGNjfZLScKSU9Cm9RnrfAqFKng1O/7flIXLjkFx2AN8+qNyfc4birZ3tH2Pyvmto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbUWhYen; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbUWhYen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3501F00893;
	Tue, 29 Sep 2026 06:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663833;
	bh=XnxyX5MBPRfi1kIcZnf4uw3ssw7A8umDxIWbe/lappU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HbUWhYen+ERAaclB9qu2nohSFKinfKDunH4LUP0OWHF8TgHn3IZ/okDUHnqja+3Dv
	 8pdkLjK82U2sNJG7Rdi01WVM4EGeY5WGhimzcaA87Mw8GslQFBIOYS1AcHhmzeokEM
	 hGc2/gPc2jfLonfCqFJbPBxkw8OdaKcLumJ0FdJA01Qt4ma7FVJboRjCwsoXVF+NyP
	 WZdwFS3M/5dONwqo5HlTDAXAptNqumXrdBy7KDn9pz1claycXFcG5r/WgL/5B6883a
	 0WkLA8sh0rUIy0BpJ+7aT2BPgHh4qnD9kjiWHuInmIgLxIapKaYm4jG2BII6hUgeax
	 hyrQ7rwrWQxCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] perf python event_analyzing_sample: Default to
 in-memory SQLite database
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929062937.374137-8-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929062937.374137-1-irogers@google.com>
 <20260929062937.374137-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:37:12 +0000
Message-Id: <20260929063713.3E3501F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When -d/--db is not specified, event_analyzing_sample.py created a
> temporary file in /tmp via tempfile.mkstemp() and deleted it in
> trace_end(). As noted during review, creating the database in a shared
> /tmp directory does not reserve SQLite's auxiliary sidecar filenames
> (-journal or -wal), and a temporary on-disk file is unnecessary when the
> caller did not ask to persist the database.
>=20
> Default to sqlite3.connect(":memory:") when db_path is not provided,
> removing the temporary file creation and cleanup logic, and test both
> the default in-memory mode and explicit -d file mode in
> test_event_analyzing_sample_python.sh.
>=20
> Fixes: eeb70645a809 ("perf python: Port event_analyzing_sample to perf mo=
dule")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929062937.3741=
37-1-irogers@google.com?part=3D7

