Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F92548564
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923132; cv=none; b=MbKTXPFqyaDirjLTtYNNHT5qtTXXW5xsHxFqPNeyCfNmaTk65WqzyLz0jI9teqP+kAVjN/CkpFZPwlBm0743YyU5EuVOTzflGDAw6p3h94f+1LiyoVLYMk2bfOWN6cLl28hju3ldNTIjfVc4YgSm1UnvrK8D0zFxSXhDtlRjp4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923132; c=relaxed/simple;
	bh=5myiY10p730O4a8/zujkQpnLs2hWj33hDAKqi7pBikI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LLUSCphIWa/kaz5rktL6un7pzPpI0mT77CC6Ufu7dBpBfTjQGGEfwpTi8Y+k4D8LMW3I8/itjKCvm0L9uRTn5+bni6gYwFYqHB2C+Ct6d40cJ4tKWz6yxbVANpkYipOHK0EntJKqBAigaVf0c8i7R+UbJKz2kif6JIVmReJ84H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8wmV2z8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8wmV2z8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0081F00898;
	Tue, 13 Oct 2026 20:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791923131;
	bh=78dBArypcVQmXniTelmIMm5oAos6aMNRFf2QjPKdJPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D8wmV2z8eH7XpRNTu8XyVdNZd2AKsGsbM2dRX+EXD0k51iOwE0YiaMNwQ0F1NNMM8
	 6v9qTn/uSqnDcaMhxXfoeaclg87eQvMSpbRxcRxaGE3fJme65Av8ggoc+R1Fji5566
	 3ooNBEsxg/c0f5noKBXJ9aNkcjvsDirvDzHgZipDKsWQ9ppdtvuNcFTm3w1fDBG6DE
	 bzSf7xQiQFbXj/Q9uA3jTSU2c+dWCak5KJgz7oe4OOqjzzCVu4NCTFA8HOl01gsKeb
	 25YvW65RtoGdPyhnUhem+4jkbZr/G02zEoO+qpy0tXnkNZTEneRcmpyvZ5Wmv7Pg9W
	 fdQD5Xha7RwCw==
Message-ID: <sashiko-outbox-170458@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/19] perf test attr: Ignore the core PMU type perf
 puts in 'config'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-8-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:25:30 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: KeyError crash in Event.equal() on missing event terms
--

commit 2d6e742f00c1817f447e64e8fed117f4dbcf95c2
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test attr: Ignore the core PMU type perf puts in 'config'

Since commit 55bcf6ef314a in v5.13, and arm_pmu opted in with commit
5c816728651a in v6.6, the kernel can be told which core PMU a legacy type
event is meant for, with its type in the top 32 bits of 'config'. This patch
takes those bits out when comparing the 'config' of legacy type events so
expectations written for the single core PMU case continue matching on
heterogeneous machines.

> diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/=
lib/attr.py
> index f254d03c1b253..70ff73585cb3f 100644
> --- a/tools/perf/tests/shell/lib/attr.py
> +++ b/tools/perf/tests/shell/lib/attr.py

[ ... ]

> @@ -130,12 +156,33 @@ class Event(dict):
>          self.add(base)
>          self.add(data)
> =20

[ ... ]

>      def equal(self, other):
>          for t in Event.terms:
>              log.debug("      [%s] %s %s", t, self[t], other[t])
>              if t not in self or t not in other:

[Severity: Medium]
In Event.equal(), log.debug() accesses self[t] and other[t] before the
boundary check executes:

    log.debug("      [%s] %s %s", t, self[t], other[t])
    if t not in self or t not in other:

Because the Event class inherits from the standard Python dict and does not
provide default values for missing keys, will accessing a non-existent key
here immediately raise an unhandled KeyError instead of gracefully returning
False?

>                  return False
> -            if not data_equal(self[t], other[t]):
> +            exp =3D self.hide_core_pmu_type(t, self[t], other)
> +            got =3D self.hide_core_pmu_type(t, other[t], other)
> +            if not data_equal(exp, got):
>                  return False
>          return True
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D7
