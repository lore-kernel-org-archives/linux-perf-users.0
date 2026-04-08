Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D927707
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775646899; cv=none; b=CTQVC2AuTOsvEM5oST2D9Tz5vDD+lfexYVpWVe9YUFWbktWyR8ZM5vA9vaCJoMTYpIRU+/3h7wwMfAt8/NpOprstu2DgE9q42vKvB8YG1b7NAbOlwXlL6rwUl+3H5G4BEV+o9eyya+cIOF3xN1RaGYogqkwg9YCyVfLy+4ufDc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775646899; c=relaxed/simple;
	bh=mueYoQ6sG5yyoDbGMzTDm09zIcf0bCrCc611dBsRLac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jaScX/iIVvVogCt7kE33ISrVkOOw5nM9P0FzlscT98X65pwO8hK8Spu5Jm+yx0t5zoPv+GwDTAz5CLZVNUfce/Rn79lRAP7xeC6lSq7rf65Nu8RCMMuQ1F4VTiCRRIQDQe2wjstH7/PcITOTWlJycQFoBTbt6UO3OGvpqhcj3Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVtfr6lu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVtfr6lu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6BDC19421;
	Wed,  8 Apr 2026 11:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775646898;
	bh=mueYoQ6sG5yyoDbGMzTDm09zIcf0bCrCc611dBsRLac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BVtfr6lugylLjT7/fPAOv6J8MsUpw03Xastcxsnz0kyvm84VoiJfG2daxx2GDPVbR
	 wo0tk8/wY/fNv9ASnG/HSo5JUT7X2BmgK3XL40bFHvAEDY4yCC2k3sNYVizQQhvOy8
	 qyx0p6ndUOYk77UncHcs3Zg4NR57mtCT2SvynPBUvp4dX8R4SKkOSOYwnaZYbnDRQJ
	 oEYqeZ6tDntKxQeuY2qncHLod/pYpU0oirj/Hg1Xt8gSkOuCmUY0ht028BS6bps2K+
	 qk5fZZIDL5h2jfjtFrCNR4CTL6+HyKGeWr+EbzSsU3HSwgo6BWzAYmq4/1VzP5BKtq
	 k6RrZPKSVrC6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test: Run test 126 exclusive
Reply-To: sashiko@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408110707.1455185-1-tmricht@linux.ibm.com>
References: <20260408110707.1455185-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 11:14:57 +0000
Message-Id: <20260408111458.9D6BDC19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The commit message demonstrates flawed validation of the fix. By=
 marking the test as `(exclusive)`, its numerical test ID changed because e=
xclusive tests are deferred and sorted differently in `perf test`. In the '=
Output after' section, the author runs `perf test 126 128`, but the output =
shows this executed entirely different tests ('perf trace exit race' and 'm=
map interface tests') rather than the intended 'perf trace BTF general test=
s'. Thus, the provided proof of the fix is invalid.
--

commit c35ec49c9966f472a5d232107254f8f61709b80f
Author: Thomas Richter <tmricht@linux.ibm.com>

perf test: Run test 126 exclusive

This commit marks the 'perf trace BTF general tests' shell script as
exclusive to prevent it from failing when run concurrently with other
trace tests.

> Output after:
>  # for i in $(seq 3); do perf test 126 128; done
>  126: perf trace exit race                           : Ok
>  128: mmap interface tests                           :
>  128.1: Read samples using the mmap interface        : Ok

Does this validation output demonstrate the correct tests being run?

In the first output block of the commit message, test 126 is 'perf trace
BTF general tests' and 128 is 'perf trace record and replay'. In this later
output block, 126 is 'perf trace exit race' and 128 is 'mmap interface test=
s'.

Did adding the exclusive tag shift the numeric test IDs, causing the
validation command to run unrelated tests instead of verifying the fix
for the intended BTF general tests?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408110707.1455=
185-1-tmricht@linux.ibm.com?part=3D1
