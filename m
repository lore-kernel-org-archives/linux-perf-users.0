Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117C2877DE
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557643; cv=none; b=rW2e1yqzhYA0vhqBb+n1i78e6oAvY7EoIpK66wpjY5wM7j27lj3UMMY9PFmSFdH7Hha48RQyAWEfwwJ8/QDQ1T927+UeYQ+U7689AjoPOLFH0t2gRyyvPfYbUrTbx8ov0FYfyqN7sML+K1qEbkUdsY+835+qUUVFNzCREdt2NF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557643; c=relaxed/simple;
	bh=+f+3prHGUyo+xtQpFZ7phqzk9UABRgOTL5KOHZ7H4iU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EuBw+TbPKrOVxlJMbPlUA7ym0Sj9kcg7TwKkHy0hqxnP4BsU1l7fjN0KrpPsEKa53Sc0nBw6gUrOJlm4m1OcUhAiS1pCGfpnN2+Imbs8T9ChViaX6Ftzr8AR25T78loKUW4+qCM4TpRkCjQT+etiDW4g8GfWFN9H4QP+8AEoQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWJhPxe9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWJhPxe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2301F000FF;
	Mon, 28 Sep 2026 01:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790557641;
	bh=30jEGYzxQgJIu3BXMwn3j2cyAOVY96LcBcVMSTiXzRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oWJhPxe9sgxhxGboxU0NDtlBO7GdbEjE7APnmS0pbDBuiHaaV6pVBop203uCCPg1W
	 A4+ezCSYkbvqksB6o5RQhaWfcRQgdf2PCEox8gK0BGlM5AKpjq0xWiv+yRuNNM/ek3
	 VERHaJHS0ckQudVFkuYTuNI0GZBKgM4PzN/1Dwfe/BTac7GTm3KnZX8sHrbBuwuh5S
	 krHaSOqSPVAdn10gt+DUDlVz1e20sWMviKLynQk0Ffslrsnuk30QUcUc7JF8FWm4Vt
	 3gQOpbn0XIPy254v5xmofNXA5A2mFjHeyx8eiAu/vWaaad1sZJnRD4bX1Rj7fQaUU3
	 juwZheL6IYNPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] perf test demangle: Fail when demangling fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Pluta" <michalpl2003@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928010227.1903673-2-michalpl2003@gmail.com>
References: <20260928010227.1903673-1-michalpl2003@gmail.com>
 <20260928010227.1903673-2-michalpl2003@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:07:21 +0000
Message-Id: <20260928010721.8C2301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The Rust and Java demangle tests only log a NULL result from
> dso__demangle_sym() and carry on, so a symbol that fails to demangle
> doesn't fail the test.  Set TEST_FAIL.
>=20
> Assisted-by: LLM
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928010227.1903=
673-1-michalpl2003@gmail.com?part=3D1

