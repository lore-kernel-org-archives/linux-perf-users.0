Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF1D31AF2D
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789758868; cv=none; b=F3iqsYGPCdPDkk41Fw6tJZbcitY32jYAa7op/WrAJpeHBb/WAy/rvDoYqTEq50hATGUq8b+ZGsXd+6D+iZd/Q/dUKHVmSG21IsjuN3ubj/ZH6OZTprWO3O2ZwOpJZJDBYDs3qV/n9rL1FiU31UlfjxShadn7BAfAhgpynG4WyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789758868; c=relaxed/simple;
	bh=scUpTDvpZRJ4xnWKdkUXINgkH0E+/7R4ZXDHySXU7Go=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gLh01vIXd0+5/5PWOQu0h/wRwvi9xJ88xcV7bduK7NrC/9zsZ+bxTu8pZRCtjJcnQe6emuBIa/ys7ghL1/2khdH2LWW/2SYd7qc6WhuWECbcnHU8Z0Dy8sFFmbBY1yFMx6JZ4k04qtRDqQDCrpJRbCBYJgnw74Ec8D7/RbfGctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ0jLq4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ0jLq4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87B71F000FF;
	Fri, 18 Sep 2026 19:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789758862;
	bh=Pf2DXyJZyImNVJgdbxgF78pt9hJnpzMXyphtw5EihTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XJ0jLq4gXHa9cYc+wISdoyoPmWk8npJ3y4hMhpBI8XqxXtqJoNRoQ1rsXU5KakASJ
	 dRz3DiCgvrHnFrEeAYcxThFX62AwYhuAsw0OlGpR3Y6leUsultaCxcpROJM61nQ5PB
	 gGFz9XBfyZBXM9cNs8t+UXDWYuLFdLnO2GE0aCkmeLMqXzYU58RO7ZqPRR3qoVrQ5I
	 wpWrvYaGliqwSNtjXYK8gJBjmN4WyW5B/pbHMMF3nzHn3yb9HJcTIPSso31i0Er7RX
	 qb2JeXShdDgkF85pxmf3rJlhmo09aKXb/fPO0ZBWLU/mO9x/sxwcljrX6k1qCg0yIn
	 CMaQeP4iEDCNQ==
From: sashiko-bot@kernel.org
Subject: Re: Please backport subset of 2f5d370dec3f ("perf test: Change all
 remaining #!/bin/sh to #!/bin/bash") for stat_bpf_counters.sh script to
 v6.12.y and older
Reply-To: sashiko-reviews@lists.linux.dev
To: "Salvatore Bonaccorso" <carnil@debian.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <aq2MQLKmyrxkFd0Y@eldamar.lan>
References: <aq2MQLKmyrxkFd0Y@eldamar.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 19:14:21 +0000
Message-Id: <20260918191421.C87B71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Hi
>=20
> Recently for v5.15.221, v6.1.188, v6.6.157, v6.12.110, v6.18.52 and
> v7.2.6, the commit b02027776ac5 ("perf tests: Fix flakiness in BPF
> counters test on hybrid systems") was backported, but it introduced
> bash specific syntax.  For versions after 2f5d370dec3f ("perf test:
> Change all remaining #!/bin/sh to #!/bin/bash") aka before v6.17-rc1
> this is not a problem.
>=20
> The proposed patch is a stable series backports specific one, as one
> cannot simply backport 2f5d370dec3f ("perf test: Change all remaining
> #!/bin/sh to #!/bin/bash") without picking as well some other context
> related changes to make it possible. So I was proposing to only change
> shebang to #!/bin/bash in stable series were it is a problem, as in
> the stat_bpf_counters.sh script.
> [ ... ]
>=20
> No upstream commit exists for this change as for versions post 6.17-rc1
> the scripts were converted to #!/bin/bash already.
>=20
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/aq2MQLKmyrxkFd0Y@el=
damar.lan?part=3D1

