Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24F377AAA
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991212; cv=none; b=kec6N8NY4JA7ailE7teBAVzOs/vW+jjuQ1la2EzyyADo2wUdfI784IrRUHQjVr59d4IV9nk8pK1r7K0yl17o8YCZCKwS3YUalK/e/Fg1+Vc0F1fqHF8tQxg9m8frvqLrfH7RDWPDeEhzY1wSfpDw7EJjnpTIan97AhtEGfgcVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991212; c=relaxed/simple;
	bh=L/ip9Fu7Ctn77hGZv2BVrCx8TueYMMI5P5VzkgAHB7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bbmUx4dTaC9KFv+PSjmOr+hLkedrlD35rnHT/s5v8U1BhJ0E1i+7Gnr4mFvmdSWBFzlKoHGjSPOm/VeacydUHvnD4G0mU7Rh7itRDenkCnaAToaMHMAf/FQ8f+gsWwk4nO2uuxzrx38SeJs6tr4wIAZfk2AdFlcOenfX+sWwyHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wth5ZUgu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wth5ZUgu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9951F000FF;
	Sat,  3 Oct 2026 01:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991210;
	bh=L/ip9Fu7Ctn77hGZv2BVrCx8TueYMMI5P5VzkgAHB7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wth5ZUgutNbYRCqC4MINLQpEsHdnVUsTynfTXXpiPJSfP0NRWRrmwPXxgQb+BSMH/
	 jL8UNICi9ubLisk3ga1AOAbmbrv1pXNnrW4w/4Mbr1NcE9Mqkp5tRtJ6IY4CV5YuXf
	 fJatDFCpo8SSn+cqSF5ZSpBE9L3OLIKfdBuOySFbrJHyqDDykKSoiaJiK7VYjBVmc+
	 W6hrjxkcIm0ODZnfRMuCAibEnc0fuUFnh3tjL/LJHm1ycecNoO0f+1q/ijr82Aipny
	 VEBQaP6TYowU15MV1EByx5/B0DGeh2YpECaS2s6oGbClJJLI6ws9mm0DXSRMuNo67n
	 Z3LqF82ptlyew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/13] perf test: Add a test for the treport script
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002182624.3259797-10-irogers@google.com>
References: <20261002182624.3259797-1-irogers@google.com>
 <20261002182624.3259797-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:30 +0000
Message-Id: <20261003013330.9A9951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alice Rogers <alice.mei.rogers@gmail.com>
>=20
> Test launching treport through perf script, the error for a file that
> isn't a perf.data file, drive the textual app headless checking the
> profile matches one built without the UI and exercising the key
> bindings, and that quitting while loading stops the background load.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002182624.3259=
797-1-irogers@google.com?part=3D9

