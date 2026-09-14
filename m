Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53382E7396
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 01:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350394; cv=none; b=qc5y85jkrFMoYwJ+B6vaOmC/PUy8xtQl5u3Wb0Tegv05ixE5QSDs0gyt6nmYfTj99nRRENJYYvRaMr8XNG/OLgQDj5H1R0T7A0sYTh56SBqVxVUv8xwsunfPGb+OY4tYqk8kqk64FY22tW46jvjIoAwkK/d/wcxidOozPCrjT+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350394; c=relaxed/simple;
	bh=pfkbFtHR91rkWI5H3cKMlh/Cd7PyxY00/G1W97GtuxI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bZjzdSJWHuBtici7B0KuYPAqrT7A122DlRKBwOxFqME/EdJVT+paCImJL7d4j3DkEoQfjhzQi+F8g2WGwOO+tCzHl2PPjIgMgN+J1AO3nHBfF1mAQMtFxb0MRabCUkEVYxuGSW1NsN5MpG6oid5KUwRLDo9EhUfmTidkGXnOxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym6nHrMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym6nHrMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8821F000FF;
	Mon, 14 Sep 2026 01:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350392;
	bh=cL/9B7HQgHvgyZNIRWiysuqOqpYs1jN+WJiHZtaTv9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ym6nHrMO4TcHVLsJOExVAFbtxKTf7LPgeW/2w4tXQyYRo/URLVDKlxTLM8jIEQjii
	 xp7tKeHDWbjUKLsQ4GSgdl8ieZY0CVojoxN8EHMjZCV4n8rTGw7ayjC6iiPxhHIHlm
	 QDP1sxb63hTLEwkIX4YGPm4NseJ+h6cxRNCOvKh6Oxa1Cvr8cS2XZxVdxugZ+1rbsV
	 QJTse4kcrLySIU78xITGRNC/HclR1vvjGeBigmjUkGX8aEl7Ps9wErzR8CM5lCAhRb
	 2ZsH9qTSkwjHbCK5P1l4hftwilP7DeSBN01n3pBsX1E+DFOZf7XXylpJffZTi85PDH
	 tDtiODO6qJp+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914013604.7702-6-acme@kernel.org>
References: <20260914013604.7702-1-acme@kernel.org>
 <20260914013604.7702-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:46:31 +0000
Message-Id: <20260914014632.5E8821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Processing a large data type profiling session, e.g. an AMD IBS one, can
> take a long time and, when using the stdio output, 'perf report' gives no
> feedback about which phase it is in nor about how far along it is: the
> TUI has a progress bar for that, but in the stdio case the ui_progress
> updates, that are already there, are dropped on the floor.
>=20
> Add a --progress option that installs a stdio backend for ui_progress,
> ui/stdio/progress.c, printing the phase title, the percentage done and
> the current/total counts to stderr:
>=20
>   Processing events... [ 42.3%] 317M / 746M
>   Merging related events... [ 61.0%] 309026 / 506686
>   Sorting events for output... [ 98.2%] 14132 / 14387
> [ ... ]
>   88: Test that perf report handles truncated perf.data gracefully (no cr=
ash, no segfault =E2=80=94 clean error exit).: Ok
>   =E2=AC=A2 [acme@toolbx perf-tools-next]$
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914013604.7702=
-1-acme@kernel.org?part=3D5

