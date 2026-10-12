Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59484361DA7
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849223; cv=none; b=YDcx0D/DYHg1NTIbLa2LE6Om+dRCPyS9y3bgqv2q0f5T+llPFbTVWFPlpDQUAEAs6yKP8tPI5BH3Yu2YMnfmE/7BowKh99Uu3aCvrmoc3r2BX3y+OagBUEhlBX607zMpSp1GVg9hppJQNxT2ZxFp0IKUAPum4c2ySGsX3t6vvsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849223; c=relaxed/simple;
	bh=Q9gY1cLqf4DqJ4mRABDmFrgbui4J4LPiJ5V62Anu2W0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RZRKuS0rP309UcWOynthlIgh5EtGD5Xo4vXr0rtiXAaxS8lqKBx254G9o1AcL4f7RRMoUNFaj68D3ZsnXNEuWr5VdHF3zzCjtSnJasWhJiYSNN99cFxo351Y8S+rWSVNKYIJiTNsO+9OB+K3E588Cp0MgFuwgHAfCv+M1fHTKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY0nPFPd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY0nPFPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68951F0089B;
	Mon, 12 Oct 2026 23:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849222;
	bh=Q9gY1cLqf4DqJ4mRABDmFrgbui4J4LPiJ5V62Anu2W0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZY0nPFPd73CjwnmMEpJ8hzZl0uvE8Uc/n2wGiE6ed+P6cwGTCZNaOjN+VmtQb5mFb
	 Y6pWzBkK0rYM+O1Snpcmx7VfEFwmASdAUIbTGKq8p1PSMgv2q7Wbn6Y8WiimKDxP7j
	 IgObC/znHbrhZ54/+OmV+Tl+0m9FO4j/luV3EGyeLS4UE4PIdMiOYOCsJYSOaUY9HW
	 41++lRkIG8zbVkOFdsOIdoPi3vC0NQJFvIz3/axwAwdLmeqWIjtvI4znlZMWgL1kQr
	 QIscdwJEUMjurrcDi5oihVFNhIeCEtTKWPdSUEOa9eespHNnjP5owouidxXo17k+7x
	 3CVul4uk7H9tA==
Message-ID: <sashiko-outbox-168749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/10] perf symbol: Set binary/symtab type for split
 kallsyms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012234654.60666-5-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
 <20261012234654.60666-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:53:41 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When it creates new DSOs for split kallsyms, set the binary and symtab
> type to KALLSYMS properly.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012234654.6066=
6-1-namhyung@kernel.org?part=3D4

