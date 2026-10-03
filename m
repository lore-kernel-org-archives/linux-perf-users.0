Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471CF30D402
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991213; cv=none; b=WeWHyXYgSqKjU5iu6bTgZMEl+fDm+L4RnAHln+7w+D5bvsJoB+qJDQxGptd5UOKG5NKexJx1drfI+PpYWleVMFDDdyUGQ9+4zYZsc3Zad2wHp9CzcgIGAA15aH4ChJ5gXFb+r1Ot3cs3YQBisxODoNMGA7ECwToCtZO+HfBnTtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991213; c=relaxed/simple;
	bh=Z9M5uIPkYX2uaAOJ8qQciPDvss9FdGnoL2+BK68wBv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U9b7hTdYcc0M4DbM5trSR3ZempdZjo6Dm7emKPF5By3dcGqLMA5ptzKK0uxVZ/sbNPvmTPzQGva0uo/aBwCfqNAg0W13Tu2SWS98kFwaVHkvlM6vd2EWqWWy3UUBkFPNmbGg2e9SA4QppeDmpvJILWMaxNbGtpGhIRXw2gi6IrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0IX7uua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0IX7uua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FAC1F00898;
	Sat,  3 Oct 2026 01:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991212;
	bh=Z9M5uIPkYX2uaAOJ8qQciPDvss9FdGnoL2+BK68wBv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o0IX7uuagEJlRGtG945tCnX/4Tlc5wmnE/1yAV4MTw5JMi0I8fkN3r2dqTeUxNqMy
	 HfADojFosB+3J3fP8HeZpBniAk0kt/l++djMkvyToh/Wi9awcntvEdgFh+GvPFjW+2
	 p40f+LA+t8apRqfIlmLEQxD/LE7asug4qSXAYbW5ICA/MXfcD+f6j7d0Vc6RNIbYET
	 i0VaSM3iNNT8b9wf4Ipm6q1XRMujcqx3CQN/U1y4TUgwUOvEOY2cJva0G/x7wU/1+T
	 4zupSAX05jfoMHdAK80BmD7dDdlDF0hjd7EVMjiU5sBpLeeEfgNlQiiNdwf22Z3ZSb
	 0+wZO5ADK2Npw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/13] perf python: Release the GIL while processing
 session events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002182624.3259797-6-irogers@google.com>
References: <20261002182624.3259797-1-irogers@google.com>
 <20261002182624.3259797-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:31 +0000
Message-Id: <20261003013332.04FAC1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When a python session reads from a pipe, perf_session__new() and
> perf_session__process_events() block waiting for data with the GIL held,
> freezing any other python threads such as a TUI thread. Release the GIL
> around both calls and acquire it with PyGILState_Ensure() in the tool and
> call-return callbacks that invoke python.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002182624.3259=
797-1-irogers@google.com?part=3D5

