Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35FE399D08
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228435; cv=none; b=XazyDA3KkZuCf8jTiDsMf5rUBLNqbEHmcJhnalS/GLlmaUq7t4FrkopfGSeW9VaFGfp1omT94wTCM/rgC4WFiGruYJZUmXv6465iBS4f8RqEY6sANrIzp2G8EMrIDpv2i/irEjRHXkwrRt7A0rnL9FvKHnbLnPtaNNDupl8S9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228435; c=relaxed/simple;
	bh=KHNObmwDuJrnT6yEZqm4Fq/A7alXM6NP8Ou/TM/Imnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nYkuE2Pvnbp315w0yJgCBxJjTD5pdw+4aoejr2xQvU1u4wY+rIUGFve0iLeuxYoQenJeabmRzJsObHg6JVYA3cYzqqkeebZGLJCvx397QdBbr4m4v5UP+RKtRN52gCiGlchdCC5gjkjOrDM4ZDZePDC6JvFbTKVIdNpAYde/wt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jree/1jR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jree/1jR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5D41F000FF;
	Thu, 24 Sep 2026 05:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228434;
	bh=nGDpuPcul20QwC2PW8AAuqVfTdY9e05LukLurz3BMFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jree/1jRtn81u3zRJd6lM+M7FEXn21j25+w9HpsdsCC+D0gOtTJ6l2XNe4ca0hUM/
	 y1w6cfAhFxTq1E29igUEcFb/IEwUhJi7OZ+6UwOSbGOsvK8jqqQKeNw13zbe8px7xC
	 vcZdF+YyUm/hNqKgxPjbQ0ziAlmjxzJYzsKA7alUiqMUk0CFHWrFW7t6Jc7h5a0y5O
	 iHs4/N/DWqXiWo63K7inyzlvOvG740e7r3dG2xx/3siSQuKOVrUmMLOteK/HRpwc2L
	 CpDXND/SBdmcjXJ+79j4/97P5k9+onoJx4v8xavuQ8DKRddcIW81z0Dm6gSlwuYkGs
	 GOzyup6Rtx4Jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/21] perf vendor events intel: Update alderlaken
 events from 1.40 to 1.41
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-3-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:40:33 +0000
Message-Id: <20260924054034.5D5D41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/5d7b37d5671a49c72abf735dc81d147=
c7776119c
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D2

