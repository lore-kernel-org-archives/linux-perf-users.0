Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4E047605F
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932476; cv=none; b=AYtJj7H2eN7hY2b9i5MdVKPpAQqATmCxn9o7yIAwmn9TGrV3VOZULqCl5D6K8bu1GU/2mhrK+wR0+HlfY5qavYw8a4b7cmeSAt2us5wkQShTRzangCngDymf/0RlmSxH0R5E8/c17e76R88qDqP6UJkKTmyzqZ7Ln5+Tu1ySHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932476; c=relaxed/simple;
	bh=MpwnkdnPgc2H9b8xvoE1V8noeOB/vmYRA4N/HaZVIzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h2T0dapPHEzXF8ga3+6bYKm36yo06QZqpqbXKpawlsFSGCGVsGDGyxld4enILtTtBwKe+o3ezBw6Y2OkdAkmw9RQh0NnUR+MZ+TcaGoawXoV87t8qFlUMu4PleKinmdcwG5WG/qkcit75jV31l4vmcetu9sjozrh/4ODsaE6RLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cf/SfNuw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cf/SfNuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734C61F00899;
	Fri,  2 Oct 2026 09:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932475;
	bh=MpwnkdnPgc2H9b8xvoE1V8noeOB/vmYRA4N/HaZVIzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cf/SfNuwJtVXapgxthPaIMFzA3X0Yt7DK1t4Eed5pzEMXqCYWdKifPXnQMcvvhoCX
	 8O0Uug5J8oh8nLaaypl/ssfFyefCVbqebHWpNM91hTRaGLtAHlusWZz1Mag9lr5KNB
	 eS+gZvPAj8h0NcqPw6XFzH5MIdjtn88Lsu1Q0up4w2e/46H9ni6jlmsBzGpzopGwyK
	 RizjpEqIrNXgn7/L45Odx6hgdscDZ/sr9qc9i135hspjDFFYEAQ5a5IJly7n6Zo2uI
	 hUI0+YXzfwNxosjFcco04YhmiBeA9AKVqmgZRinHPceIDdLo0x2mhUvg0l/qiOUkqD
	 ZCqh1UMoNsdMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf trace: Increase TRACE_AUG_MAX_BUF to 128 and
 document beauty_map encoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002065440.2781176-2-irogers@google.com>
References: <ar6nzTSj17IxCy0j@x2>
 <20261002065440.2781176-1-irogers@google.com>
 <20261002065440.2781176-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:35 +0000
Message-Id: <20261002091435.734C61F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> With sockaddr arguments copied as buffers via beauty_map_enter, the
> 32-byte TRACE_AUG_MAX_BUF limit only held 2 bytes of sa_family plus 30
> bytes of AF_LOCAL sun_path, truncating longer socket paths such as
> "/var/run/.heim_org.h5l.kcm-socket".
>=20
> Since struct augmented_arg already reserves PATH_MAX (4096) bytes,
> increase TRACE_AUG_MAX_BUF to 128 (SS_MAXSIZE, the size of struct
> sockaddr_storage), which covers all 110 bytes of struct sockaddr_un
> without changing map sizes. Also document the 1-based negative
> -(arg_idx + 1) encoding used in beauty_array for paired length
> arguments.
>=20
> Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002065440.2781=
176-1-irogers@google.com?part=3D2

