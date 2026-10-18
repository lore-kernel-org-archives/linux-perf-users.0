Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527B3BE630
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341792; cv=none; b=VRj2oI7l6UBIP+YY+UomM3jFjV1VqriXUi12zMGDoR4lIq9njHwpUtnD2sJu8YRYfQShFUbrJQGprPOFlYq7IEKP0nKbu3mszhbt8BIbIlyzbw0b3b81RJr1CGCvPSc46gcH+fk7AgbhYx3XKFwvkevyyIxVpqOZtD6WjqvCw7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341792; c=relaxed/simple;
	bh=aZmofIa0hVD68F+k6H7m6jxg0HKU48GvkTThLlg2eHQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UAJsh5VuWTSHb6Fpp43K/o0rUbrLDGNSDZ/+L6nN97uYt+hoUwZg5wCpNa5nNCHjGFzHf3mrChHJir6m03rjodJLNvBUD+2Zg/EwojX8Ybq8vwR+LgECp9nat7H1qRJpNeCr38OZAsSbGNvDDFQXI/OxuaG7Fd7Al0SBlT+dTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuyw14Vy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuyw14Vy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF221F000C4;
	Sun, 18 Oct 2026 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341790;
	bh=+RyiMPpGwCLPqtcUTA3YwPQpSR+Ut6pMrdljOrTCRmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cuyw14VyKHk2TaVwkMt1Ae2SYdFl1o+0UyUbP/d3tHocZkg+onIMGE5m88n4Xq4Q6
	 TqHpq3ENuw8bgkylmj5i9LHmGYSBD9Uy81ZkdLRhN6OPv+seQ5X2a4FCKj3ux+MRim
	 gLf6kEiWpmzYaFvDFPSTRhMjC5I+mjvtl/2NdcdeLzB0B4lEnxNrn+QrXGFcEo6Lpe
	 /wEj4X8dQVD1kglAipFzIohWUsGw/Iteq9oKkd3jnuJOHGm8Y5lmFZCFwZ867hHyME
	 32yLQIF2RAsS5VBs5Ndq5YWGlzZMGyJ5k/A0LSsia/+pQTED219VBJikLH7nWel+T3
	 gKe+pr2Te0QTQ==
Message-ID: <sashiko-outbox-176288@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/5] perf test: Make sure maps to have a machine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018163741.850434-2-namhyung@kernel.org>
References: <20261018163741.850434-1-namhyung@kernel.org>
 <20261018163741.850434-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 16:43:10 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> It's be easier if we could guarantee that maps always have a machine.
> IIUC this is true for all real use cases, but only the test code has
> an exception.  Let's get rid of it and make sure they have machines.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018163741.8504=
34-1-namhyung@kernel.org?part=3D2

