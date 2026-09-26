Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C862A2E762C
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403974; cv=none; b=uXleNFbpgbCpqJJfCfSycTqpvmS+Xu4V1HgiVD8X5AIO+yroGZZYu9CBVbsaRC1Gy77/hedHNgVDxKsJ+qFmBSuYfAdNId5vekloGDIK2xrlA84tjkXJ+QXTvuW8njDGYTy64gQ/ymq4zLDgEKIvE53oDsy/nFc9jtYP0hwU1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403974; c=relaxed/simple;
	bh=27k5ACdR0xxTQxEzU/9ia0N8dsQBC+bHvsyoi/+gxYY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TR1X3EU/ukMSx6vQz+uhkxa8n/tuEnDBpNXVavm/eP90cJDR04h1uY7ziJ5b0BNd72wwG40MyzGhkHxBoQyWvQNNG9aNyp4lZDj50F9d6uqxh3R3Yj9KBwmscQpDKF96ohf8BwYv8yxFGJuDc5+AFhIq29hWMTJYaWLD+KuBDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7l3zSEf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7l3zSEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7011C1F00893;
	Sat, 26 Sep 2026 06:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790403973;
	bh=FgxYbAVmQ/Gn5ea7znq4+P03wopTtD+cBccNg4TAwNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j7l3zSEfFPUbjAD1IbMj1cYEHGQ7vvsP0KchnZUFmTi4kh9bI/ms9QRDVtzrHdxOb
	 GT1M3LDVoXApMujGK+FIs27klMZiEgSMymThxhGlFY5X6C+TDrC1q1WEesGp0PRUD7
	 C9ybt4jfLDM8wCiHNGiF9zEjdLhs30cG5PrXHAmGZm16YkTgDPT3PpfpF21KtGpJz1
	 6UdnDyoVjCWwOZOna9DjgCFjMb5aRr41cr9qalEl15d623cU+Pd1CNyCYRu6Kn8ljC
	 l7T6itZcXbumceNFREVhq1C6AumzONdjT8ELKEX7prxONwdGOcRJxZ+9wlvvX630HA
	 8uNmv3kGcChoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/49] perf python: Clean up pylint warnings in
 tracepoint.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-6-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:26:13 +0000
Message-Id: <20260926062613.7011C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up pylint warnings in tracepoint.py so that it passes pylint
> without warning suppression comments:
> - Catch ImportError instead of bare 'except:' (W0702: bare-except) when
>   importing setproctitle.
> - Remove unnecessary trailing semicolon (W0301: unnecessary-semicolon)
>   after evlist.enable().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D5

