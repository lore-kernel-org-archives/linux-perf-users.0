Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2536215F
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182368; cv=none; b=sAaTchXWF6EAQAC3sSwZN0vrhZZ95x/2+4/4amUlDKBzqgqZPv0oYa7UJ1DHW6TN0j/qKOs7zYXyhhyYid7xxK2QlH9TQYF0NiGzcN9fE3OBO8AbGTviI3R5f1oLdKOZCUjWULNMvFAVUF4evEeQPfFGgyiEcm2+2BHwXUdUxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182368; c=relaxed/simple;
	bh=3z0I5fRdx+GESBSkdSTTp5QRKGsaJv8gT9tGpQjgwtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R68YNe33p8wk6YiF0gpaaqODRWWmOUcQO3sZPp/bB35DVxbK2lUuzubRuCNYYAaD5kw+5slfVSgG/Ubyq/WV8U8hl3hIoomCrN6g9FtwIlR5Qspm0yYF3j5eyoz1j1MzHT5g4H/KE0dNgtwarFj3z/OvnDnBlcIGEYOapmnAYWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKIolhkC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKIolhkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A35C1F00893;
	Mon,  5 Oct 2026 06:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182366;
	bh=3z0I5fRdx+GESBSkdSTTp5QRKGsaJv8gT9tGpQjgwtM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DKIolhkCBHcZy4DNXgbBqN0VeMrkxpG1F1/DdLKn+RBBrnz3UN755YgL1lUOmfvqa
	 1EECLUumLZfhLSBjPwe4l6bD6vFq/ELRra4qLZBbqHd5GvwXtvBQOmemrr5tZ7hefB
	 CKT5SZ8QL1HwEcCyf6nB3yYEaRMmsgcCNixAetAkCuQ/c/W2w93JU90oQlupE/OfuU
	 FzMRZ90S3e2TkmDw2hhQrNVMiDOX4NkNoQFKh5BE9GlZbF/Eyzt1s/m8RzwWdxJnW8
	 1zl3QyNyc67YEqBKZUAXYI2D8ohD91lJo7Pqg/NzW1UXxUAjNYovx6JYMMy45Vin2M
	 grlMIBCuJWBmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/7] perf tools: Remove redundant dso data init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005063411.114244-2-namhyung@kernel.org>
References: <20261005063411.114244-1-namhyung@kernel.org>
 <20261005063411.114244-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 06:39:25 +0000
Message-Id: <20261005063926.2A35C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The fd and status are initialized later with cache.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005063411.1142=
44-1-namhyung@kernel.org?part=3D1

