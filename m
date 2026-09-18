Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064603D1707
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713527; cv=none; b=PGfp/Uc+R0LadWwCwchkO4kYbzvyYpm5yAEkLqg34Y9fPlxl/FANH23k/C4m7OAc+V5D6i6s1hf3Ir9QbxpNFImAA5oxgtC5qBTkf3WPxGFokVz/Pjsv2MSVcgYP/IvvrB3BIIF1LOCF1Gsr+9Se8PDaa9UzsnHwNJJ9P+RAJdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713527; c=relaxed/simple;
	bh=VRXnNbAEMslQx0rqOw1rOkxKBJxKL3yr/FQf+eXOJUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RxhEknvOUohAdbEU+/uabzX/C7+UnfmlDz6veB5ESF0czGd2wPlTqcydMsQ1WV6Znjv7/wwAqpNJN+DSJ4m2I6A6AZkw/ptqT3FJ1jOxThAImuo3pfQKc2ILyIZQRZP9fEXGlGyYPvdN6vwL7ZpRR8B0Ce06o5A/L/R45jaSYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOmSHs3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOmSHs3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4BD1F000FF;
	Fri, 18 Sep 2026 06:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713525;
	bh=VRXnNbAEMslQx0rqOw1rOkxKBJxKL3yr/FQf+eXOJUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fOmSHs3+qzVOSIuMZcXge7AhBpxZzDALZz5mKLssR9xM6x8ssomchZuQfM3C9qUEj
	 O2Rn2BFAQZyoF7avoHi3wNra5buuKOiSq0AYI9LDZjyiOKk7EQlIgJrwCuPC7j1rRp
	 5KcoyxpGWWOiQVMgQxwpMugyDAjQAMic9mxCp60R1qJWumAw9zFBpAYYWSpjADHOFG
	 WlDBeGQtrYuP9n0Xc463roDPTQnfizxk8aCR0KGu2dVTJt9R5ti45tleG+SWiqH12S
	 ax9SCiXa8qZjqVU0Mk/gIOkHJeBzrdyxf5Gyf+asN9JKs7nZ30J2uQ48YFlhcEIhaD
	 Z7aSq5q2S6MBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/5] perf trace-event: Reuse an already parsed
 tracepoint format
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918063249.2172589-3-irogers@google.com>
References: <20260918063249.2172589-1-irogers@google.com>
 <20260918063249.2172589-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:38:45 +0000
Message-Id: <20260918063845.7A4BD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> tp_format() read and parsed the format file on every call. Each parse
> registers another tep_event with the global tep handle, and
> libtraceevent has no way to free an individual event, only the whole
> handle, so a repeated lookup of the same tracepoint both redoes the
> work of reading and parsing the file and leaves a duplicate behind for
> the rest of the session.
>=20
> Ask the handle for the event first with tep_find_event_by_name() and
> only fall back to reading the format file when it has not been parsed
> yet. The handle holds formats for the running kernel alone, so a name
> that is found is the same format that would have been read.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918063249.2172=
589-1-irogers@google.com?part=3D2

