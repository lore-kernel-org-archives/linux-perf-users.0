Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB430C14A
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188729; cv=none; b=CM31rlTNJaIA6Jpz6agzKQ0yLlFbznUDWoJhHGFTEO4F5rN3d9sgP5p8xxaBvVCjr2trX6ptY5/oA6xFGUOpU2FvLicd4RZANJeiytJ6xygXp+0EFaJGuuAbJXR+SAJ1te+USIB+/6Uvc0MdYhUJm4LKf1o+Ed/bt56gbfPv1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188729; c=relaxed/simple;
	bh=YQcRUjuIRQVwGKEm1vs8rd1+Ob6PmgoeVaunf4DtSvc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=evngq7IDonJWffoCw/oaDsrxT2mMdHbfIVZDwCam9x98rQDfjQ5Eb2M5i0/zqZN5yCh3bR4YCld2xi1trofUyl0F+6JbS/rLjyQWM4yU3KPhi6TeXdPhqx89WYjQnKMnQS5UdUWpxAFejDHBYlgyFa/drTnDelvu8EZGQ1hkp20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyrFQbRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyrFQbRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541751F000FF;
	Wed, 23 Sep 2026 18:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188727;
	bh=GtnKQtOXmPe/IID76g/Ed1sWU5IjWCzZSRG7NxAY42Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UyrFQbRqEJkAhsXEPP46cRFe95vY1YqkPbpyviNkukn3iTthY8shX+FcVEDvlFYmw
	 BAATV1Ud7MoxPi50rZNg9H25ln8GwmC8hcKl6FeIkMRVRDmPFNhxm+gfF3BvKc/FJ9
	 uddkbvV6RVYjpZ/ls2A8dCVpYWLnBsKceABmwozQJD56bkIRi1Z6KB4O9wSQrkmoL1
	 OznHJuKqh7HU0q4XONuBnZKFUZ2hon6JU3QOv/gi5D/GaVP07gNrn0S4JWdx+mpvGh
	 GFm8M4L6X4WVttkIkUNTVN4NtDSutZeDwVKc5QKwnPbCbN6O/Si6G+HrTpFUx8qABo
	 Z7qEgqL4jWIgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 31/49] perf python: Port task-analyzer to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-32-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-32-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:38:46 +0000
Message-Id: <20260923183847.541751F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port task-analyzer.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/ refactored into a class-based architecture.
>=20
> Improvements compared to the legacy script:
> - Support both offline perf.data file analysis (using perf.session) and
>   live trace capture (using evlist.read_on_cpu), accessing
>   sched:sched_switch tracepoint fields directly from sample objects.
> - Automatically disable ANSI terminal color escape sequences when --csv
>   or --csv-summary is enabled so CSV column headers ('Comm,',
>   'Time Out-Out,', etc.) are never polluted by color codes when running
>   interactively on a TTY (e.g. as root).
> - Sanitize non-printable characters and leading CSV formula characters
>   (=3D, +, -, @) in task comm strings.
> - Emit a one-time warning to stderr if sched:sched_switch samples are
>   missing tracepoint fields (such as when recorded without libtraceevent
>   support).
>=20
> Update test_task_analyzer.sh to invoke the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D31

